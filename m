Return-Path: <netdev+bounces-123635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBF82965F17
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 12:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B7CC1C2095D
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 10:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA32319048D;
	Fri, 30 Aug 2024 10:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="HLIfaSYg"
X-Original-To: netdev@vger.kernel.org
Received: from forward201b.mail.yandex.net (forward201b.mail.yandex.net [178.154.239.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16461917ED
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 10:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013495; cv=none; b=Xe7JiIT3JXfQZ1xh1V0N3mcxf1NTuvB6DF14RiaZiRvSF8t6q/HlH+lZFzO2VWLGyMAp54EjkbeACV8GHhIjLhZ/dbqFoopp+4g32uXdaKH1GwG0FGr/v+Bo0+1uz6NV0fgarZ//7c2ABPBIXD3jlpluvjsdp6miNo0yUHqmVjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013495; c=relaxed/simple;
	bh=+xHzZMDOR4LYwUcapInJ/eXLmC5K9aWgG+R711OrsdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zk2lEVy5Nk37VPE51K98c8Ob+yFGUPglOF6Lilu4FX1tBHgdNmokzbBng5UQ00Xs1wxOpZw77tysRFqXBn050HJf5fsPhedJAJUTaEPNLzYamOzOO0Y43K0nj2fwWphQ4ORxmjmUND3+sRubD/38dlohu+OGPAEwXbrhMNWhtpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=HLIfaSYg; arc=none smtp.client-ip=178.154.239.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward100b.mail.yandex.net (forward100b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d100])
	by forward201b.mail.yandex.net (Yandex) with ESMTPS id 99D9E66B9F
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 13:19:04 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:3483:0:640:1715:0])
	by forward100b.mail.yandex.net (Yandex) with ESMTPS id 987DA60913;
	Fri, 30 Aug 2024 13:18:56 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rIUvxkaXxCg0-26COoRqU;
	Fri, 30 Aug 2024 13:18:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1725013135; bh=0jVxKTo/nH0Goe+iMfT5j7DSkaNu++AcmAAcqJqrssQ=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=HLIfaSYgFM43zY6l935a+SBKemdEqztwyh18weqk80Tid78To1a+YKGdR9WpT88uE
	 9p5y0cdTW5td98lrD5J2EiQvKH33GtGn0Y1uCWEj0iXLxJGX4B/CZ4lt7Q72LNHFeU
	 I5hwgS8fQKcx17hfhucI124a4OAIrJE46dLYAuRk=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH v3 2/3] net: sched: consistently use rcu_replace_pointer() in taprio_change()
Date: Fri, 30 Aug 2024 13:16:32 +0300
Message-ID: <20240830101754.1574848-3-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240830101754.1574848-1-dmantipov@yandex.ru>
References: <20240830101754.1574848-1-dmantipov@yandex.ru>
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
v3: unchanged since v2
v2: added to the series
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
2.46.0


