Return-Path: <netdev+bounces-119761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F3DB956DE0
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 16:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9468B1C20C86
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 14:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17E4173332;
	Mon, 19 Aug 2024 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="e+OLnTae"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF8B16C6A9
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724079131; cv=none; b=e1jFxbeuL0XKEdrq+q2vwovX9o2pgoH/z7Jq4NPfTdnfIkH6s843awsHexkNo+dS0JcfudqEbAhe4pC9clx3QqtTOtun9BlwkqP72bWe3I5FkJ7I/X8BB1RV8o4B7OK2lONRnfHdIfr9ikzaNKlF7BC4oau8i19BxQ0te28z6/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724079131; c=relaxed/simple;
	bh=LvNoGVPb3NO+7kbkxpx8N2e6UzrAqg3E/5n3RmGJsiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X4WJm6UVd88109WY7j1ogbRyBu7NdnMZSy15Wm80LYKiDM7pJGUbU1Hfwg6bzigZhUN1IwIELHF6xwzYyQvxdN+ejLNe2aEVtObi9oU/AnV1Xz8Tpm5TP268yKjN1VQ1rLcCMxJYC1+vJqa0l76dSySnX14j74/PcUL1dpG+ttk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=e+OLnTae; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:42ef:82e5:ff01:56ce])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id D46667D9B6;
	Mon, 19 Aug 2024 15:52:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1724079129; bh=LvNoGVPb3NO+7kbkxpx8N2e6UzrAqg3E/5n3RmGJsiY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09xiyou.wangco
	 ng@gmail.com|Subject:=20[PATCH=20net-next]=20l2tp:=20avoid=20using
	 =20drain_workqueue=20in=20l2tp_pre_exit_net|Date:=20Mon,=2019=20Au
	 g=202024=2015:52:08=20+0100|Message-Id:=20<20240819145208.3209296-
	 1-jchapman@katalix.com>|MIME-Version:=201.0;
	b=e+OLnTaef6u2jcd/WzF7XRlX4d2CEiOT9nBUFIVgvomZplnaaFylmuff8u2cPeTwC
	 r21oNawMWEyTczCST9psIm1Hcl6M8oeXGgy0dD6BTKoHmxRnMbx3muBggrpxWyYubB
	 8EXGRQF3MqNzPwQWxZ2UiESI0pWVvYDZYtwF0XuTXohGGuRAWkFhbEcCwhXSKcdYm1
	 VBUfTSNG5P16Yluak4Eu07hr08NoH0WXBfQFB7hCvUH1QjZ1/DUAokiEZ8JYPSa6Ft
	 TmZg3TUwesE0BpTabOZtRA7f0YCmD0Xb1OO3xHEiU+cLCjGwrMqf8lGdUoGf8Q7g/U
	 hWRC2+z5ptn7A==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	xiyou.wangcong@gmail.com
Subject: [PATCH net-next] l2tp: avoid using drain_workqueue in l2tp_pre_exit_net
Date: Mon, 19 Aug 2024 15:52:08 +0100
Message-Id: <20240819145208.3209296-1-jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Recent commit c1b2e36b8776 ("l2tp: flush workqueue before draining
it") incorrectly uses drain_workqueue. The use of drain_workqueue in
l2tp_pre_exit_net is flawed because the workqueue is shared by all
nets and it is therefore possible for new work items to be queued
while drain_workqueue runs.

Instead of using drain_workqueue, use a loop to delete all tunnels and
__flush_workqueue until all tunnel/session lists of the net are
empty. Add a per-net flag to ensure that no new tunnel can be created
in the net once l2tp_pre_exit_net starts.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c    | 38 +++++++++++++++++++++++++++++---------
 net/l2tp/l2tp_core.h    |  2 +-
 net/l2tp/l2tp_netlink.c |  2 +-
 net/l2tp/l2tp_ppp.c     |  3 ++-
 4 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index af87c781d6a6..246b07342b86 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -107,6 +107,7 @@ static struct workqueue_struct *l2tp_wq;
 /* per-net private data for this module */
 static unsigned int l2tp_net_id;
 struct l2tp_net {
+	bool net_closing;
 	/* Lock for write access to l2tp_tunnel_idr */
 	spinlock_t l2tp_tunnel_idr_lock;
 	struct idr l2tp_tunnel_idr;
@@ -1560,13 +1561,19 @@ static int l2tp_tunnel_sock_create(struct net *net,
 	return err;
 }
 
-int l2tp_tunnel_create(int fd, int version, u32 tunnel_id, u32 peer_tunnel_id,
+int l2tp_tunnel_create(struct net *net, int fd, int version,
+		       u32 tunnel_id, u32 peer_tunnel_id,
 		       struct l2tp_tunnel_cfg *cfg, struct l2tp_tunnel **tunnelp)
 {
+	struct l2tp_net *pn = l2tp_pernet(net);
 	struct l2tp_tunnel *tunnel = NULL;
 	int err;
 	enum l2tp_encap_type encap = L2TP_ENCAPTYPE_UDP;
 
+	/* This pairs with WRITE_ONCE() in l2tp_pre_exit_net(). */
+	if (READ_ONCE(pn->net_closing))
+		return -ENETDOWN;
+
 	if (cfg)
 		encap = cfg->encap;
 
@@ -1832,6 +1839,8 @@ static __net_init int l2tp_init_net(struct net *net)
 {
 	struct l2tp_net *pn = net_generic(net, l2tp_net_id);
 
+	pn->net_closing = false;
+
 	idr_init(&pn->l2tp_tunnel_idr);
 	spin_lock_init(&pn->l2tp_tunnel_idr_lock);
 
@@ -1848,6 +1857,12 @@ static __net_exit void l2tp_pre_exit_net(struct net *net)
 	struct l2tp_tunnel *tunnel = NULL;
 	unsigned long tunnel_id, tmp;
 
+	/* Prevent new tunnel create API requests in the net.
+	 * Pairs with READ_ONCE in l2tp_tunnel_create.
+	 */
+	WRITE_ONCE(pn->net_closing, true);
+
+again:
 	rcu_read_lock_bh();
 	idr_for_each_entry_ul(&pn->l2tp_tunnel_idr, tunnel, tmp, tunnel_id) {
 		if (tunnel)
@@ -1855,16 +1870,21 @@ static __net_exit void l2tp_pre_exit_net(struct net *net)
 	}
 	rcu_read_unlock_bh();
 
-	if (l2tp_wq) {
-		/* ensure that all TUNNEL_DELETE work items are run before
-		 * draining the work queue since TUNNEL_DELETE requests may
-		 * queue SESSION_DELETE work items for each session in the
-		 * tunnel. drain_workqueue may otherwise warn if SESSION_DELETE
-		 * requests are queued while the work queue is being drained.
-		 */
+	if (l2tp_wq)
 		__flush_workqueue(l2tp_wq);
-		drain_workqueue(l2tp_wq);
+
+	/* repeat until all of the net's IDR lists are empty, in case tunnels
+	 * or sessions were being created just before l2tp_pre_exit_net was
+	 * called.
+	 */
+	rcu_read_lock_bh();
+	if (!idr_is_empty(&pn->l2tp_tunnel_idr) ||
+	    !idr_is_empty(&pn->l2tp_v2_session_idr) ||
+	    !idr_is_empty(&pn->l2tp_v3_session_idr)) {
+		rcu_read_unlock_bh();
+		goto again;
 	}
+	rcu_read_unlock_bh();
 }
 
 static __net_exit void l2tp_exit_net(struct net *net)
diff --git a/net/l2tp/l2tp_core.h b/net/l2tp/l2tp_core.h
index ffd8ced3a51f..a765123e213d 100644
--- a/net/l2tp/l2tp_core.h
+++ b/net/l2tp/l2tp_core.h
@@ -232,7 +232,7 @@ struct l2tp_session *l2tp_session_get_by_ifname(const struct net *net,
  * Creation of a new instance is a two-step process: create, then register.
  * Destruction is triggered using the *_delete functions, and completes asynchronously.
  */
-int l2tp_tunnel_create(int fd, int version, u32 tunnel_id,
+int l2tp_tunnel_create(struct net *net, int fd, int version, u32 tunnel_id,
 		       u32 peer_tunnel_id, struct l2tp_tunnel_cfg *cfg,
 		       struct l2tp_tunnel **tunnelp);
 int l2tp_tunnel_register(struct l2tp_tunnel *tunnel, struct net *net,
diff --git a/net/l2tp/l2tp_netlink.c b/net/l2tp/l2tp_netlink.c
index 284f1dec1b56..cd410144b42e 100644
--- a/net/l2tp/l2tp_netlink.c
+++ b/net/l2tp/l2tp_netlink.c
@@ -234,7 +234,7 @@ static int l2tp_nl_cmd_tunnel_create(struct sk_buff *skb, struct genl_info *info
 	switch (cfg.encap) {
 	case L2TP_ENCAPTYPE_UDP:
 	case L2TP_ENCAPTYPE_IP:
-		ret = l2tp_tunnel_create(fd, proto_version, tunnel_id,
+		ret = l2tp_tunnel_create(net, fd, proto_version, tunnel_id,
 					 peer_tunnel_id, &cfg, &tunnel);
 		break;
 	}
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 53baf2dd5d5d..2c083ef2e4ee 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -660,7 +660,8 @@ static struct l2tp_tunnel *pppol2tp_tunnel_get(struct net *net,
 			if (info->fd < 0)
 				return ERR_PTR(-EBADF);
 
-			error = l2tp_tunnel_create(info->fd,
+			error = l2tp_tunnel_create(net,
+						   info->fd,
 						   info->version,
 						   info->tunnel_id,
 						   info->peer_tunnel_id, &tcfg,
-- 
2.34.1


