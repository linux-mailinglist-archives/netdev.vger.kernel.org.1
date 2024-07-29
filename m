Return-Path: <netdev+bounces-113711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D7193F9AA
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 17:39:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F7B8B21177
	for <lists+netdev@lfdr.de>; Mon, 29 Jul 2024 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A0AE16B38D;
	Mon, 29 Jul 2024 15:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="ngha7114"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44A415D5B8
	for <netdev@vger.kernel.org>; Mon, 29 Jul 2024 15:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722267501; cv=none; b=fWNOmAIk0w5br17k1puCvb9smF5z1qKZTUI6eCnYrUtn2ge9bEFYetNm7AbACjUXG1KaMKUdnmVNYlOQ7kiKRRlpfia5PTBRMO6wulbOgjdvN8adpL0Tx3+yQl287GfH9DlMz85JRX6OLc37afWtPNC6vxZSsqFLxBuTIfwAC3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722267501; c=relaxed/simple;
	bh=kaQKpcmpxVYLHS4c4dyDW2zYNcGS3qVbvPfXad1XE6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQ1RTM10uJ776WpChQAlUkoldNOQt3e+UapqlBKI2T9B7lSANT7ah4lqEduqGrlxLbriN2u35ccRLQ5xzL9Mzo3KqLVjwotqCgpm9taknMVSf2SdIFtCkf9QWnxu61yyVbhEll2ieSkTkZaAFiIG8lz3sJPWxiq3qTtwLP84niw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=ngha7114; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:6c24:bf58:f1fe:91c1])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id D55BC7DCFF;
	Mon, 29 Jul 2024 16:38:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1722267496; bh=kaQKpcmpxVYLHS4c4dyDW2zYNcGS3qVbvPfXad1XE6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[PATCH=20n
	 et-next=2015/15]=20l2tp:=20use=20pre_exit=20pernet=20hook=20to=20a
	 void=20rcu_barrier|Date:=20Mon,=2029=20Jul=202024=2016:38:14=20+01
	 00|Message-Id:=20<4cde928ca968c3ec17a5ba314f9544f8475e06b6.1722265
	 212.git.jchapman@katalix.com>|In-Reply-To:=20<cover.1722265212.git
	 .jchapman@katalix.com>|References:=20<cover.1722265212.git.jchapma
	 n@katalix.com>|MIME-Version:=201.0;
	b=ngha7114VpSuYoduJt6IBbUZFtfhl3huYlBwP3ss2dOfLWse2I+rNFH6fBeC+pKHE
	 v9vJnE37CQ26KxScbcDfv3LSPbw2mNXOR6nIWwaMk+Ldo15WXmeCgBd4dCiAt0uGha
	 EL5XT84lYBjVnoqNba53K7n5Tfi2jkWqXd0+Kp0WLh6r9rlITWVLHUbz1k8b15xRuY
	 BhoU0vozmy56OtYH3KAoNuoPm7pe76mFPB5uNL3G9sZquw1Ib/uxuUqurHg43HkHQO
	 m9u03jL+m6Ff7JCDscj4EONJIcKql8tLPrRutXxD3JpheU1nsMkYAZlJ7HQGGVfcQa
	 GtTSIbZhinTug==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [PATCH net-next 15/15] l2tp: use pre_exit pernet hook to avoid rcu_barrier
Date: Mon, 29 Jul 2024 16:38:14 +0100
Message-Id: <4cde928ca968c3ec17a5ba314f9544f8475e06b6.1722265212.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722265212.git.jchapman@katalix.com>
References: <cover.1722265212.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move the work of closing all tunnels from the pernet exit hook to
pre_exit since the core does rcu synchronisation between these steps
and we can therefore remove rcu_barrier from l2tp code.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index fd03c17dd20c..5d2068b6c778 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -1756,7 +1756,7 @@ static __net_init int l2tp_init_net(struct net *net)
 	return 0;
 }
 
-static __net_exit void l2tp_exit_net(struct net *net)
+static __net_exit void l2tp_pre_exit_net(struct net *net)
 {
 	struct l2tp_net *pn = l2tp_pernet(net);
 	struct l2tp_tunnel *tunnel = NULL;
@@ -1771,7 +1771,11 @@ static __net_exit void l2tp_exit_net(struct net *net)
 
 	if (l2tp_wq)
 		drain_workqueue(l2tp_wq);
-	rcu_barrier();
+}
+
+static __net_exit void l2tp_exit_net(struct net *net)
+{
+	struct l2tp_net *pn = l2tp_pernet(net);
 
 	idr_destroy(&pn->l2tp_v2_session_idr);
 	idr_destroy(&pn->l2tp_v3_session_idr);
@@ -1781,6 +1785,7 @@ static __net_exit void l2tp_exit_net(struct net *net)
 static struct pernet_operations l2tp_net_ops = {
 	.init = l2tp_init_net,
 	.exit = l2tp_exit_net,
+	.pre_exit = l2tp_pre_exit_net,
 	.id   = &l2tp_net_id,
 	.size = sizeof(struct l2tp_net),
 };
-- 
2.34.1


