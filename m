Return-Path: <netdev+bounces-73839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C25FA85EC94
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 00:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32FAC1F22FC4
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 23:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5941B81752;
	Wed, 21 Feb 2024 23:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tq/aAW3U"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8921E520
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 23:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708557135; cv=none; b=HCUIReZk+k+SX7+04L6y4O3kZxrTx6H7ERyjax8SGvLzneDmFIQJiuBVTToJ04SdLJah9EySPsbKPeVf2kERpukD38aJs2HopjcvqsXWYXJdnQViJvVkfIQ2vLVQ8y262zZWWVDSSIn30aWMwtERh0anBCNg3WbdgQ49PvWHjcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708557135; c=relaxed/simple;
	bh=6m4bwN+S2zI58BgI16wRaaTZzktmvtgYYmiPNXQ77lA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oI4s2hLTlZt3rcySPwW/5Hqgal2CROQ6D74HX2iMLJ0DY/42jkQzcfx6lpP0U/KV9pfu8y6aQHfStm18m+0gTpL3ch/hCi8K+rfU5Naxbg67W6LRMyN7ASDsgExB9pfrA2u8/0GnjIGiq/NjbkgIyhFJYs92YSmZUvWLFb2DdgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tq/aAW3U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55067C433C7;
	Wed, 21 Feb 2024 23:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708557134;
	bh=6m4bwN+S2zI58BgI16wRaaTZzktmvtgYYmiPNXQ77lA=;
	h=From:To:Cc:Subject:Date:From;
	b=Tq/aAW3UKYAeAxvOGXeJCSJbkeGY99NQIWyN4EktdhGBN3BGb4+VuLIDy3TSNk4BP
	 awYtGHheHVI+SrWoDlxcYyKr/6vdXW535Fwsz3jcRL8zxvlLkIqC9SnrD3BO+3ujFU
	 Yvo1YJwdJxbDCLj8yn8T1HLEN9LCtCwElI4KCRFTK7hURofydgB87QvP4LtonuheXZ
	 hjrprKIg2f31gp65C4lYN01DZ/j7nDsiA3QfGiEcjn/qdAkg43u+9fh4KLpsBQoaFv
	 uBIBJ6eFfGu+5YFl9XIcRf8AcxzngqaRrplIjX4yQaE7DfcrQt2yXvNzsROF/IDfF7
	 Po9Z1TY/2YJ7Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	lorenzo@kernel.org,
	toke@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	syzbot+039399a9b96297ddedca@syzkaller.appspotmail.com
Subject: [PATCH net 1/2] net: veth: clear GRO when clearing XDP even when down
Date: Wed, 21 Feb 2024 15:12:10 -0800
Message-ID: <20240221231211.3478896-1-kuba@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

veth sets NETIF_F_GRO automatically when XDP is enabled,
because both features use the same NAPI machinery.

The logic to clear NETIF_F_GRO sits in veth_disable_xdp() which
is called both on ndo_stop and when XDP is turned off.
To avoid the flag from being cleared when the device is brought
down, the clearing is skipped when IFF_UP is not set.
Bringing the device down should indeed not modify its features.

Unfortunately, this means that clearing is also skipped when
XDP is disabled _while_ the device is down. And there's nothing
on the open path to bring the device features back into sync.
IOW if user enables XDP, disables it and then brings the device
up we'll end up with a stray GRO flag set but no NAPI instances.

We don't depend on the GRO flag on the datapath, so the datapath
won't crash. We will crash (or hang), however, next time features
are sync'ed (either by user via ethtool or peer changing its config).
The GRO flag will go away, and veth will try to disable the NAPIs.
But the open path never created them since XDP was off, the GRO flag
was a stray. If NAPI was initialized before we'll hang in napi_disable().
If it never was we'll crash trying to stop uninitialized hrtimer.

Move the GRO flag updates to the XDP enable / disable paths,
instead of mixing them with the ndo_open / ndo_close paths.

Fixes: d3256efd8e8b ("veth: allow enabling NAPI even without XDP")
Reported-by: Thomas Gleixner <tglx@linutronix.de>
Reported-by: syzbot+039399a9b96297ddedca@syzkaller.appspotmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/veth.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 578e36ea1589..a786be805709 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1208,14 +1208,6 @@ static int veth_enable_xdp(struct net_device *dev)
 				veth_disable_xdp_range(dev, 0, dev->real_num_rx_queues, true);
 				return err;
 			}
-
-			if (!veth_gro_requested(dev)) {
-				/* user-space did not require GRO, but adding XDP
-				 * is supposed to get GRO working
-				 */
-				dev->features |= NETIF_F_GRO;
-				netdev_features_change(dev);
-			}
 		}
 	}
 
@@ -1235,18 +1227,9 @@ static void veth_disable_xdp(struct net_device *dev)
 	for (i = 0; i < dev->real_num_rx_queues; i++)
 		rcu_assign_pointer(priv->rq[i].xdp_prog, NULL);
 
-	if (!netif_running(dev) || !veth_gro_requested(dev)) {
+	if (!netif_running(dev) || !veth_gro_requested(dev))
 		veth_napi_del(dev);
 
-		/* if user-space did not require GRO, since adding XDP
-		 * enabled it, clear it now
-		 */
-		if (!veth_gro_requested(dev) && netif_running(dev)) {
-			dev->features &= ~NETIF_F_GRO;
-			netdev_features_change(dev);
-		}
-	}
-
 	veth_disable_xdp_range(dev, 0, dev->real_num_rx_queues, false);
 }
 
@@ -1654,6 +1637,14 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 		}
 
 		if (!old_prog) {
+			if (!veth_gro_requested(dev)) {
+				/* user-space did not require GRO, but adding
+				 * XDP is supposed to get GRO working
+				 */
+				dev->features |= NETIF_F_GRO;
+				netdev_features_change(dev);
+			}
+
 			peer->hw_features &= ~NETIF_F_GSO_SOFTWARE;
 			peer->max_mtu = max_mtu;
 		}
@@ -1669,6 +1660,14 @@ static int veth_xdp_set(struct net_device *dev, struct bpf_prog *prog,
 			if (dev->flags & IFF_UP)
 				veth_disable_xdp(dev);
 
+			/* if user-space did not require GRO, since adding XDP
+			 * enabled it, clear it now
+			 */
+			if (!veth_gro_requested(dev)) {
+				dev->features &= ~NETIF_F_GRO;
+				netdev_features_change(dev);
+			}
+
 			if (peer) {
 				peer->hw_features |= NETIF_F_GSO_SOFTWARE;
 				peer->max_mtu = ETH_MAX_MTU;
-- 
2.43.0


