Return-Path: <netdev+bounces-124565-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4297C969FE4
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 16:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3ED0B23F24
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 14:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E6C84D0E;
	Tue,  3 Sep 2024 14:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="QOCKgKll"
X-Original-To: netdev@vger.kernel.org
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8B657CB4
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 14:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725372495; cv=none; b=YEgwQyoS+KJ1SsLgBwsf+Bq+CkFPB+GhOhxkNwV+fcTd6x4o5BLTcSqQs5stLlqmofZko8bFpgm8VkDaxzmgQIeToeKcnDUuPLcvr0GyDS2oI9lGoRVHp+AOnw3Io9ZAIuBu2ppT1c8SXMNAcbb1SrIaB+a6wGxSCUjMh2EEy+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725372495; c=relaxed/simple;
	bh=sfdEppQNSN1c2rO3jyB5PIwQKyNLGuP6QHTw7wgfiE8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UFojSxynFDo8byo4wgUzBOS+fP50j1VJTCkyDEPrB1sA1itSmk1I+Efylu1exQWnQcSwQBnpdmMnUtnVbkx50yvaQZgwuXZRXCI68M/zqIxq48VZBR7+cKjb0IAGjJdDu4bfS6x+hqwDPLiBhYd9ljvh3gnhSYQXNb6M4RlDdc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=QOCKgKll; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d102])
	by forward200b.mail.yandex.net (Yandex) with ESMTPS id E5FD069361
	for <netdev@vger.kernel.org>; Tue,  3 Sep 2024 17:08:04 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net [IPv6:2a02:6b8:c08:de2c:0:640:e39b:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 30B266099E;
	Tue,  3 Sep 2024 17:07:57 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id s7cJDQ0oD0U0-EO2OQbfD;
	Tue, 03 Sep 2024 17:07:56 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1725372476; bh=Y+k/yNn5odf6VBOhy56nGfHS/YiBPMwQZRP4UHiMdxM=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=QOCKgKlllv9EeDd13+J5LN/xfvxBaluqLGLLhl5HR6WPTWKrCyEc41hbfUlpK6+g5
	 JPICKEkwAx7TnQ1NQay217BdTixP4TxoImZK9OjfO9tGj9mYGTa9V9UJyEtMBwdPnG
	 hJNxlq+91sNFVEf0CAsJImurGyMo6hJwE5Hh4jU8=
Authentication-Results: mail-nwsmtp-smtp-production-main-31.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH net v4 2/3] net: sched: consistently use rcu_replace_pointer() in taprio_change()
Date: Tue,  3 Sep 2024 17:07:07 +0300
Message-ID: <20240903140708.3122263-2-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240903140708.3122263-1-dmantipov@yandex.ru>
References: <20240903140708.3122263-1-dmantipov@yandex.ru>
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
v4: adjust subject to target net tree
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


