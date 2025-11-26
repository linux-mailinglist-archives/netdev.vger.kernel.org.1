Return-Path: <netdev+bounces-241845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A14FAC89487
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 11:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F0396354500
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 10:27:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B342E54CC;
	Wed, 26 Nov 2025 10:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YEnbxhpD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2036131B822
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 10:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152791; cv=none; b=oV56YVsHWqP6Dr2Ky+dRptWKRTYYvn89r6Kl+4j0Dd2pcRVKa+RMkSNAT0WKgzJTe3D3Uw/bK3HlMS/iqQ8d52Fwt5LPJ3mUQO0/2B1PKgUN1BZrheFyShG+Cr79hjBj74ztQgZkNvvEc0uvVX7YdsLjrY7FedyGlsXzo8gT0UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152791; c=relaxed/simple;
	bh=ogXONSA9Fs4JaC6IWq0Wj8CqDg5KXtavSmanR7JQSok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=um+pb7YnhsV3i8zRmdVK7dgIUYW1atLnZ5j9BZmbUpYf/gv9peOK1tGAPFMuVeWWU5lWFu6C+++bnxyVd6mLngzG/4YM8bdMM6KpadKg3Amfqe2L+oleW4foJrOf5gBRpUlo2aNqMOkJFl27BkbPHfZdNaCjcvHSLbLToZgMYZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YEnbxhpD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 263F4C2BC87;
	Wed, 26 Nov 2025 10:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764152790;
	bh=ogXONSA9Fs4JaC6IWq0Wj8CqDg5KXtavSmanR7JQSok=;
	h=From:To:Cc:Subject:Date:From;
	b=YEnbxhpDFpa/1KXLU+I3BOaZz02oZktGP3hhtpGzKHpKwIeGa0nT6BRcbigRf6Zqn
	 94UFQeR5V4gEeFcebwcU4SNQiqQq1YKHhWefuYRJH6qrhfBO/sQnnWqulc9FIMBxvq
	 SVhUHswKAeU+1AOt90XFnFwBJ9/PsGyzIw++kNbLU4moc5CY9Sjr/TdWiTHYJYfX/Y
	 emvRM6HBc5eGZDlWmRqqPu0Hvtj8V2EK7aXFDYysErQoBWpBzIQ83FTvfEQtsnBOKS
	 MoCjeOl51PtlksdUXRZ0zemYkcTRpZXeF0zE9BlgJRn1HFQN1zQx9QvmQWipBwhcDz
	 qC+kbADcgR1KQ==
From: Antoine Tenart <atenart@kernel.org>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch
Cc: Antoine Tenart <atenart@kernel.org>,
	netdev@vger.kernel.org,
	Liang Li <liali@redhat.com>,
	Beniamino Galvani <b.galvani@gmail.com>
Subject: [PATCH net v2] net: vxlan: prevent NULL deref in vxlan_xmit_one
Date: Wed, 26 Nov 2025 11:26:25 +0100
Message-ID: <20251126102627.74223-1-atenart@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Neither sock4 nor sock6 pointers are guaranteed to be non-NULL in
vxlan_xmit_one, e.g. if the iface is brought down. This can lead to the
following NULL dereference:

  BUG: kernel NULL pointer dereference, address: 0000000000000010
  Oops: Oops: 0000 [#1] SMP NOPTI
  RIP: 0010:vxlan_xmit_one+0xbb3/0x1580
  Call Trace:
   vxlan_xmit+0x429/0x610
   dev_hard_start_xmit+0x55/0xa0
   __dev_queue_xmit+0x6d0/0x7f0
   ip_finish_output2+0x24b/0x590
   ip_output+0x63/0x110

Mentioned commits changed the code path in vxlan_xmit_one and as a side
effect the sock4/6 pointer validity checks in vxlan(6)_get_route were
lost. Fix this by adding back checks.

Since both commits being fixed were released in the same version (v6.7)
and are strongly related, bundle the fixes in a single commit.

Reported-by: Liang Li <liali@redhat.com>
Fixes: 6f19b2c136d9 ("vxlan: use generic function for tunnel IPv4 route lookup")
Fixes: 2aceb896ee18 ("vxlan: use generic function for tunnel IPv6 route lookup")
Cc: Beniamino Galvani <b.galvani@gmail.com>
Signed-off-by: Antoine Tenart <atenart@kernel.org>
---

Since v1:
- Fixed uninitialized err variable reported by clang [Jakub]

 drivers/net/vxlan/vxlan_core.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index a5c55e7e4d79..e957aa12a8a4 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -2349,7 +2349,7 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 	int addr_family;
 	__u8 tos, ttl;
 	int ifindex;
-	int err;
+	int err = 0;
 	u32 flags = vxlan->cfg.flags;
 	bool use_cache;
 	bool udp_sum = false;
@@ -2454,12 +2454,18 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 
 	rcu_read_lock();
 	if (addr_family == AF_INET) {
-		struct vxlan_sock *sock4 = rcu_dereference(vxlan->vn4_sock);
+		struct vxlan_sock *sock4;
 		u16 ipcb_flags = 0;
 		struct rtable *rt;
 		__be16 df = 0;
 		__be32 saddr;
 
+		sock4 = rcu_dereference(vxlan->vn4_sock);
+		if (unlikely(!sock4)) {
+			reason = SKB_DROP_REASON_DEV_READY;
+			goto tx_error;
+		}
+
 		if (!ifindex)
 			ifindex = sock4->sock->sk->sk_bound_dev_if;
 
@@ -2534,10 +2540,16 @@ void vxlan_xmit_one(struct sk_buff *skb, struct net_device *dev,
 				    ipcb_flags);
 #if IS_ENABLED(CONFIG_IPV6)
 	} else {
-		struct vxlan_sock *sock6 = rcu_dereference(vxlan->vn6_sock);
+		struct vxlan_sock *sock6;
 		struct in6_addr saddr;
 		u16 ip6cb_flags = 0;
 
+		sock6 = rcu_dereference(vxlan->vn6_sock);
+		if (unlikely(!sock6)) {
+			reason = SKB_DROP_REASON_DEV_READY;
+			goto tx_error;
+		}
+
 		if (!ifindex)
 			ifindex = sock6->sock->sk->sk_bound_dev_if;
 
-- 
2.52.0


