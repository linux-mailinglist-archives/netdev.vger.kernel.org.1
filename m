Return-Path: <netdev+bounces-116423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9606E94A5DB
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 12:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3E071C20A55
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 10:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC841DD3B5;
	Wed,  7 Aug 2024 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="ZeF6R5L2"
X-Original-To: netdev@vger.kernel.org
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD5D1D174E
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 10:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723027246; cv=none; b=I7ljzDvrA0O82nm2rZLzxvI8+PsuiZzj/KIDizqIPNvPU4TRu2WLPVgcDglhGcX4oSjLHvNUQ19R/r4J4PewplE2i60RqiVG6NaC6XyjlHZCAR0I0btlXkuhEdDBt3j7FJcnubqO90wQxMv0rJJT//653UXaa0+HXsy9XcPbGL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723027246; c=relaxed/simple;
	bh=sNzghOZRnhUdLIEW9FS2CAIFsCt66cKO/7HKQd+Cl2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5p5vfwQTdjnNc86iW4HMp/5Q1/fmj35vzK+2A3XbWIHwALq7YmxWNQlSkDhXPJ8gdFt1GCvDdN1b0Bzox2N/MA3JfA0rxoKY8+MULEFRrH9LyrEOvpSH/SKILDQ+JvNU9DJ2Cx5bRwNDpXOilDyv2CzN/Hm96K4RCh07PHjNlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=ZeF6R5L2; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net [IPv6:2a02:6b8:c0f:26bf:0:640:efa0:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 72F3846D63;
	Wed,  7 Aug 2024 13:40:34 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id WeaXEH6Sl4Y0-VvbIajb6;
	Wed, 07 Aug 2024 13:40:34 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1723027234; bh=gHc6pJSmw7497IEttLpPGX8BTDtpMO2MTOytUBeRWFk=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=ZeF6R5L2Z2fALRwOqwhle1suX6+l6cvGv8ylx0T4eWy0RkvK9hFrkQGVg6h+Fdtca
	 F1UcJxMWtHB7RAzqUfiMpzVgmums0NCSkly4GalwdeVupyiUlg1r+RFPIJ0fjKICfp
	 ts/XObv3XQnQCUIy9HNF0RetVznAJWgbOlABxXHM=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH 2/3] net: sched: consistently use rcu_replace_pointer() in taprio_change()
Date: Wed,  7 Aug 2024 13:39:42 +0300
Message-ID: <20240807103943.1633950-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240807103943.1633950-1-dmantipov@yandex.ru>
References: <20240807103943.1633950-1-dmantipov@yandex.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Vinicius (and carefully looking through the whole thing
once again), txtime branch of 'taprio_change()' is not going to race
against 'advance_sched()'. But using 'rcu_replace_pointer()' in the
former may be a good idea as well.

Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/sched/sch_taprio.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 59fad74d5ff9..9f4e004cdb8b 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1952,7 +1952,9 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 			goto unlock;
 		}
 
-		rcu_assign_pointer(q->admin_sched, new_admin);
+		/* Not going to race against advance_sched(), but still */
+		admin = rcu_replace_pointer(q->admin_sched, new_admin,
+					    lockdep_rtnl_is_held());
 		if (admin)
 			call_rcu(&admin->rcu, taprio_free_sched_cb);
 	} else {
-- 
2.45.2


