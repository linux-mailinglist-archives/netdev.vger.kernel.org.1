Return-Path: <netdev+bounces-112605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA95293A208
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 15:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85C9A282E8B
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 13:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097F5155326;
	Tue, 23 Jul 2024 13:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="TtYnZiAF"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76AEC154445
	for <netdev@vger.kernel.org>; Tue, 23 Jul 2024 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742716; cv=none; b=q4gtrNEgv0sZSlXJ1k6sXm8qZdavE3ISxPMiYa9sonMPTdJymJhR8j58Q1pUkWxoLvuQ9fY6HwtIwHmPOGJs6iIJeunGxYGmqZRCWf6S0XQgElIfrhwtjzNrVfoHjL8GKrLr7CQWuqXtZ2sjtyqz+XN3PB8fiNG7XBCAnhVj0O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742716; c=relaxed/simple;
	bh=ISsSxzGzLpmvNc3x4vGptCmW4jbr7HyVvZC9ERNLGW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hAZ1Vz6iWeE2XN9vosbq0TUsaRkLN8fBE0idWadWiXM/n1nVIHYXztQ9743KsteKaphMmTdV2pPQNg0BX/hG/GARve1OyJ6jFT06tkv+IO8K96SPi/EwkH0Kto7wYNTaT2w9dj/Kh0LsjUT/UJnk0M/i4Dg2vaop3+CyLXxmbgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=TtYnZiAF; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:47:b279:6330:ae0d])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id EE55E7DCF6;
	Tue, 23 Jul 2024 14:51:46 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1721742707; bh=ISsSxzGzLpmvNc3x4vGptCmW4jbr7HyVvZC9ERNLGW8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com|Subject:=20[RFC=20PAT
	 CH=2015/15]=20l2tp:=20use=20pre_exit=20pernet=20hook=20to=20avoid=
	 20rcu_barrier|Date:=20Tue,=2023=20Jul=202024=2014:51:43=20+0100|Me
	 ssage-Id:=20<ce5ffdd299cefef8895fd33ea5153300ce6b46d2.1721733730.g
	 it.jchapman@katalix.com>|In-Reply-To:=20<cover.1721733730.git.jcha
	 pman@katalix.com>|References:=20<cover.1721733730.git.jchapman@kat
	 alix.com>|MIME-Version:=201.0;
	b=TtYnZiAFssUXjL2tPLudaK5C9eCvGSZJ5KtmSWgUcSWfocnUIbRbjYj2cCXx230VR
	 3LE9ONoQcnqLC4z6S1qfhBzfHpARtQd0lYFq+wRfRy3//npHCHY0X8PksS4pK5P8Ya
	 y+eNRQMSRk4W6spq2leca3EeGFIs4qmjYvFpRPpAeghD0ZdScbvFoeW6VCYh4U7Xyn
	 swWp1q+lF0Iszcwf+0vharpr7dBhb2y5+2MfkLLWWGBa2lqI+RH06raPsu8Z6388qU
	 0Ma4YdiUe3QAr0CrSzA8sfZFL23clliQGv00l+KML6luDCViOZBbXUfd6gxLJFUXoX
	 68lIFje7X1lTQ==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com
Subject: [RFC PATCH 15/15] l2tp: use pre_exit pernet hook to avoid rcu_barrier
Date: Tue, 23 Jul 2024 14:51:43 +0100
Message-Id: <ce5ffdd299cefef8895fd33ea5153300ce6b46d2.1721733730.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1721733730.git.jchapman@katalix.com>
References: <cover.1721733730.git.jchapman@katalix.com>
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


