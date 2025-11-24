Return-Path: <netdev+bounces-241223-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6B5C81957
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 17:33:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 888A8348A62
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 16:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E81C922A4FC;
	Mon, 24 Nov 2025 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Czpvq9d2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22CA29E113
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 16:31:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764001867; cv=none; b=tlwijdZh+xyCkWq7I3YBYYz3Ia9pN7bVFLcjrwP58O+5gkuWBY8XDpl/JbjmRGrJZIr5v5bTf7SQYBp9UmOdL66mBQ14sUDOS2R5mndSuX825tKcHK5P1TzZF/p1P9hvYE2GAWYfZyGMrIrfxl7ZGGdJfGrm/ugaW+OaFgm8gzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764001867; c=relaxed/simple;
	bh=/X7nkYbqQETfcnKui/Xrt6kQwPhWRz0DHcgCrTXwFiI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Glj8jdkYo5Y5uDcp3SwQ2WUbRV7PDMdhx9sDBsistU+/EKL8WWXHiB26MWb8HuDxZ2YUkfGC5FtNEmiFoZMv7TKCqHwTtarqr8oDmP76geBx/X1pEm9Ckz2ZQM46WC+++eYKWsbERblGgq6s3HFMjWIA06leahWQtxziTRHhD9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Czpvq9d2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB414C4CEF1;
	Mon, 24 Nov 2025 16:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764001867;
	bh=/X7nkYbqQETfcnKui/Xrt6kQwPhWRz0DHcgCrTXwFiI=;
	h=From:To:Cc:Subject:Date:From;
	b=Czpvq9d25qeiqCzrohAhTHJcaxwdCgrI5FPctVEsezhCKJbW4QnCZWakMDWc05BO1
	 dWqaKrXYnssqiH12cj105YTVv15J4WWYjEGhEiZulZuy4W9eycmNQ3XXptG+jbkDGQ
	 2RyZd4yzWwdcjtsV+t51Ow3YCc2MKN2ZvtkZsFfzBEM7y3YINiufbP5nBGJwm8vCS/
	 YvtDC/BmP5wTfACho241q7IL1z+NuwHoPu7xJo9Q6snRFIdL09ddu92TzVEzJ1Hzpy
	 7YIYK2w2e1DV99q9Ns3VOxlPdXkCYGJ4aB7B/35hehuMf1YdJHpA0wh50sFY7QKeXA
	 azB7zQcsfPCdA==
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
Subject: [PATCH net] net: vxlan: prevent NULL deref in vxlan_xmit_one
Date: Mon, 24 Nov 2025 17:30:59 +0100
Message-ID: <20251124163103.23131-1-atenart@kernel.org>
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
 drivers/net/vxlan/vxlan_core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index a5c55e7e4d79..137ebdf354a4 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
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


