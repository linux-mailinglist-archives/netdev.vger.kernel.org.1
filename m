Return-Path: <netdev+bounces-123636-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AD3965F19
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 12:28:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 187B91F27FB3
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69D417B507;
	Fri, 30 Aug 2024 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="F5EKDrHV"
X-Original-To: netdev@vger.kernel.org
Received: from forward200b.mail.yandex.net (forward200b.mail.yandex.net [178.154.239.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44150178378
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 10:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725013579; cv=none; b=pOAjNWvTRb0Vtv4Ub0jpusvfP+Xa5A6xoHM8QO0nITb1tA926j2M4THvcYpBH0Bhj1qBt/y4SNWNOhYr0qP3JDmBk26qhn0ljDbb98vv6TVmjyDrvBgKAFMEd0RLhP80DXNNEznGFkeu2MrFExwTlZ+OkDdVXPYRX92ZCrKFxgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725013579; c=relaxed/simple;
	bh=JH+GTCRr5uv+Asl6ctb4ZcKsxnADYA0LQJKdi4pnG1E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kFCdJb2N4h4Mr9n4XA7jVDSH05DqqkgziBcB+JexypBkLa1iKNxbbnIHheZqtdKOufBH7B396OGWvBrc6XTYPA7b3jq2Xzjdh2UI17N7dK4l6nA0YJX/xei4Du5o/dd/EUYlO4XpLVfY/7nmVX03vNApLkqLKeplqNEz/Hzs1Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=F5EKDrHV; arc=none smtp.client-ip=178.154.239.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [IPv6:2a02:6b8:c02:900:1:45:d181:d103])
	by forward200b.mail.yandex.net (Yandex) with ESMTPS id 988E7699BC
	for <netdev@vger.kernel.org>; Fri, 30 Aug 2024 13:19:03 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net [IPv6:2a02:6b8:c14:3483:0:640:1715:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id AED4B60A78;
	Fri, 30 Aug 2024 13:18:55 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id rIUvxkaXxCg0-SUoRLIPq;
	Fri, 30 Aug 2024 13:18:55 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1725013135; bh=eQj3qC+V4h8BUyBHW0LgaAYoCYj+Yskw5FEh1kPrauE=;
	h=Message-ID:Date:In-Reply-To:Cc:Subject:References:To:From;
	b=F5EKDrHVBkkTvuiMn01m3fTje0aUbqvKaSnqcAjqp+En/mm7PTzrSrlkeaVK63wUh
	 ydRXc/c1cY13tPSCB1D4zLAywWdVciV48cpeNEfGZrZqN7SwPvx54iJyZ2tGZPws5b
	 pZw+jW3i9Ki5DL33jvTqEVE4/1DMhoPD3/DXjDOI=
Authentication-Results: mail-nwsmtp-smtp-production-canary-88.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Subject: [PATCH v3 1/3] net: sched: fix use-after-free in taprio_change()
Date: Fri, 30 Aug 2024 13:16:31 +0300
Message-ID: <20240830101754.1574848-2-dmantipov@yandex.ru>
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

In 'taprio_change()', 'admin' pointer may become dangling due to sched
switch / removal caused by 'advance_sched()', and critical section
protected by 'q->current_entry_lock' is too small to prevent from such
a scenario (which causes use-after-free detected by KASAN). Fix this
by prefer 'rcu_replace_pointer()' over 'rcu_assign_pointer()' to update
'admin' immediately before an attempt to schedule freeing.

Fixes: a3d43c0d56f1 ("taprio: Add support adding an admin schedule")
Reported-by: syzbot+b65e0af58423fc8a73aa@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b65e0af58423fc8a73aa
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v3: unchanged since v2
v2: unchanged since v1
---
 net/sched/sch_taprio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index cc2df9f8c14a..59fad74d5ff9 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -1963,7 +1963,8 @@ static int taprio_change(struct Qdisc *sch, struct nlattr *opt,
 
 		taprio_start_sched(sch, start, new_admin);
 
-		rcu_assign_pointer(q->admin_sched, new_admin);
+		admin = rcu_replace_pointer(q->admin_sched, new_admin,
+					    lockdep_rtnl_is_held());
 		if (admin)
 			call_rcu(&admin->rcu, taprio_free_sched_cb);
 
-- 
2.46.0


