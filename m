Return-Path: <netdev+bounces-121412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0022795D001
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 16:34:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA5231F216D7
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 14:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E352190470;
	Fri, 23 Aug 2024 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="CqyVUf9L"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7575118E059
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724422981; cv=none; b=rE8slobvlTynDLYe7UJisjb3y7AIk4Fh2UETx/hPbloHJ4m264Y+GlLuaeEXwv0HAjTBkAu9l6L6xKaA+uMP96X4KjPdWquajc37C8XPMwKOILhandWZPagFMrxPAsFsAAE2oG/e0nRzwBtmlBq2upqIDDAbNQHdFh/FFUXtXsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724422981; c=relaxed/simple;
	bh=mu9HpSRAyP9VwL3llBjJ+tZZikH+8LWpw/HQiUrlc7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MNInFmzx1l5EObV4bTyhfSw5PFBslLsF0VexDGnRW7+sNHlCVkpyerl4QlVdV8s5aHsiA0NiqQria16xbcIZltvojWkUL21bOYeGEsprYlGyBpHLghuXUONy4g1KmlMaMvBP3sueKDCKOoB2asxrjjIzouq5cT3aDeBz3/QLeWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=CqyVUf9L; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:447:9bdd:64cd:a718])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id 0EE057D889;
	Fri, 23 Aug 2024 15:22:58 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1724422978; bh=mu9HpSRAyP9VwL3llBjJ+tZZikH+8LWpw/HQiUrlc7k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09xiyou.wangco
	 ng@gmail.com|Subject:=20[PATCH=20net-next=20v2]=20l2tp:=20avoid=20
	 using=20drain_workqueue=20in=20l2tp_pre_exit_net|Date:=20Fri,=2023
	 =20Aug=202024=2015:22:57=20+0100|Message-Id:=20<20240823142257.692
	 667-1-jchapman@katalix.com>|MIME-Version:=201.0;
	b=CqyVUf9Lxwa+iasPI5jnETkZILMtMOIZBBL/xwEgcAbhpEqkmphDOMzaEwbWPrvVB
	 ciLVhwQuQtLbO34bodiN25vC9iW7UT4xa5wZdo7ZRtwrYQXwjA46IHhxWXYRwEL+g8
	 8IleUeN0qSTzJNoFZoefFAqJWAUjSx/yfJx2HoGH/6HXxX+tjtbniGdppHkO6D7V8k
	 NbEidt/qeYrBuP1AT4voNXoH1OYOPwubiGzB2HrgixcR0F4+2inI9ouWNxwnr6S42E
	 ZrUQ9DyVgwKh7Db4e/XFVoRDbHISyMhdn7hKMZ/GR0p1KnuWFRrInUxN57vZLJzMXr
	 WcR/4bAwIMSCA==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	xiyou.wangcong@gmail.com
Subject: [PATCH net-next v2] l2tp: avoid using drain_workqueue in l2tp_pre_exit_net
Date: Fri, 23 Aug 2024 15:22:57 +0100
Message-Id: <20240823142257.692667-1-jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent commit fc7ec7f554d7 ("l2tp: delete sessions using work queue")
incorrectly uses drain_workqueue. The use of drain_workqueue in
l2tp_pre_exit_net is flawed because the workqueue is shared by all
nets and it is therefore possible for new work items to be queued
for other nets while drain_workqueue runs.

Instead of using drain_workqueue, use __flush_workqueue twice. The
first one will run all tunnel delete work items and any work already
queued. When tunnel delete work items are run, they may queue
new session delete work items, which the second __flush_workqueue will
run.

In l2tp_exit_net, warn if any of the net's idr lists are not empty.

Fixes: fc7ec7f554d7 ("l2tp: delete sessions using work queue")
Signed-off-by: James Chapman <jchapman@katalix.com>
---
 v2:
   - remove unneeded per-net net_closing flag (paolo)
   - remove loop waiting for idr lists to be empty (paolo)
   - add correct fixes tag (paolo)
   - in l2tp_exit_net warn if idr lists not empty
 v1: https://lore.kernel.org/netdev/20240819145208.3209296-1-jchapman@katalix.com/
---
 net/l2tp/l2tp_core.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index af87c781d6a6..e5e492284997 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1856,14 +1856,14 @@ static __net_exit void l2tp_pre_exit_net(struct net *net)
 	rcu_read_unlock_bh();
 
 	if (l2tp_wq) {
-		/* ensure that all TUNNEL_DELETE work items are run before
-		 * draining the work queue since TUNNEL_DELETE requests may
-		 * queue SESSION_DELETE work items for each session in the
-		 * tunnel. drain_workqueue may otherwise warn if SESSION_DELETE
-		 * requests are queued while the work queue is being drained.
+		/* Run all TUNNEL_DELETE work items just queued. */
+		__flush_workqueue(l2tp_wq);
+
+		/* Each TUNNEL_DELETE work item will queue a SESSION_DELETE
+		 * work item for each session in the tunnel. Flush the
+		 * workqueue again to process these.
 		 */
 		__flush_workqueue(l2tp_wq);
-		drain_workqueue(l2tp_wq);
 	}
 }
 
@@ -1871,8 +1871,11 @@ static __net_exit void l2tp_exit_net(struct net *net)
 {
 	struct l2tp_net *pn = l2tp_pernet(net);
 
+	WARN_ON_ONCE(!idr_is_empty(&pn->l2tp_v2_session_idr));
 	idr_destroy(&pn->l2tp_v2_session_idr);
+	WARN_ON_ONCE(!idr_is_empty(&pn->l2tp_v3_session_idr));
 	idr_destroy(&pn->l2tp_v3_session_idr);
+	WARN_ON_ONCE(!idr_is_empty(&pn->l2tp_tunnel_idr));
 	idr_destroy(&pn->l2tp_tunnel_idr);
 }
 
-- 
2.34.1


