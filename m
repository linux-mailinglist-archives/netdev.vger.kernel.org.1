Return-Path: <netdev+bounces-170476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77063A48D63
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 01:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 586023B9019
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 00:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 453FA188596;
	Fri, 28 Feb 2025 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmu45u7c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31A128371;
	Fri, 28 Feb 2025 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740702542; cv=none; b=uMb5UEdC87hndoeetg4nN8WM7xFwuWTzWh0VjZDTe60BbrebYi5cQQTRYDMyt8c3YBoHpiISTt0cJimU2Hujk7e25siOfo4LE9h9Qn8ZfbxkMfeJPZ/IwyMEWyk8IFpKOCDi6oGnBPH8TZcVSJdzeL5XZ4NKVbjOhl1XPSp/qLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740702542; c=relaxed/simple;
	bh=QZydrWXqU7auI68WECVKXnJcZI1JK2lrYp8Z5llYz+Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G8uNnwHtLTO4pXPe+5vRqSSJLGrAPAbsa1ZEenhPaCDACKIG0LAqRutzvSsczFFYI1F+1I+nhY9XQ7/QoWRdu6CbR6kUXb0vBdgt/5Q3RX2zy+7y9GxrUZdhd9a/jNtrGx3EXUX2QEMOaRXp3ZsdCOhoqXVS3C3Wlp4WN9pHNck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmu45u7c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 876BBC4CEF4;
	Fri, 28 Feb 2025 00:29:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740702542;
	bh=QZydrWXqU7auI68WECVKXnJcZI1JK2lrYp8Z5llYz+Q=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=cmu45u7c788vcm2mn4tPDQ6SUE4UGiZEnj+kbFT5iSLu5c27QBTr7Ctw4GfBfVGkN
	 69lsoUEirns8MU0MngTg6MmXyqrf+eyq0z4Z9HspAFZHhlWwU4DLUu0Y9C1duWv7t8
	 EpK+CrbckY+OK5lGFqRZMJk8CPViEhujGnnRQZToxjy9ZcPpHxg5TPHxV6Ebh4njW0
	 dR7amHOs/BCyOTJEWrWgR5I3IgpYYnYo34ZwQOFYScjiZO+F60Z3sNC+bTQVpLg3Vx
	 gcxoXrlhmRtXVQqosza4I7wA2RPsLU58sbXcBbg0paEdtzFBqENqL5kTRuI/vxF6o7
	 xC819NpdvTugA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793E2C19F32;
	Fri, 28 Feb 2025 00:29:02 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Thu, 27 Feb 2025 19:30:51 -0500
Subject: [PATCH 8/8] enic : get max rq & wq entries supported by hw, 16K
 queues
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250227-enic_cleanup_and_ext_cq-v1-8-c314f95812bb@cisco.com>
References: <20250227-enic_cleanup_and_ext_cq-v1-0-c314f95812bb@cisco.com>
In-Reply-To: <20250227-enic_cleanup_and_ext_cq-v1-0-c314f95812bb@cisco.com>
To: Christian Benvenuti <benve@cisco.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Satish Kharat <satishkh@cisco.com>, Nelson Escobar <neescoba@cisco.com>, 
 John Daley <johndale@cisco.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1740702696; l=8090;
 i=satishkh@cisco.com; s=20250226; h=from:subject:message-id;
 bh=vOtOGLgIwHioJuNVEdz1PRgNdWKUp87V1dxR5wuRaVM=;
 b=I04rCjeE0JD9Y/0rPE3IceHP9RXGQ8kzkZ/XXn/7WUAYR8NrVYOPmNFYOMWtDcHPocUN423cY
 yTv/Sz1gb1UBwLrOeMcAB6dHh/RgZF96Zb1BwaZjBTZyKa4Zmez2Kvs
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=lkxzORFYn5ejiy0kzcsfkpGoXZDcnHMc4n3YK7jJnJo=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/20250226 with
 auth_id=351
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com

From: Satish Kharat <satishkh@cisco.com>

Enables reading the max rq and wq entries supported from the hw.
Enables 16k rq and wq entries on hw that supports.

Co-developed-by: Nelson Escobar <neescoba@cisco.com>
Signed-off-by: Nelson Escobar <neescoba@cisco.com>
Co-developed-by: John Daley <johndale@cisco.com>
Signed-off-by: John Daley <johndale@cisco.com>
Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 drivers/net/ethernet/cisco/enic/enic_ethtool.c | 12 +++++------
 drivers/net/ethernet/cisco/enic/enic_res.c     | 29 ++++++++++++++++----------
 drivers/net/ethernet/cisco/enic/enic_res.h     | 11 ++++++----
 drivers/net/ethernet/cisco/enic/enic_wq.c      |  2 +-
 drivers/net/ethernet/cisco/enic/vnic_enet.h    |  5 +++++
 drivers/net/ethernet/cisco/enic/vnic_rq.h      |  2 +-
 drivers/net/ethernet/cisco/enic/vnic_wq.h      |  2 +-
 7 files changed, 39 insertions(+), 24 deletions(-)

diff --git a/drivers/net/ethernet/cisco/enic/enic_ethtool.c b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
index 18b929fc2879912ad09025996a4f1b9fdb353961..529160926a9633f5e2d60e6842c2fcf07492854b 100644
--- a/drivers/net/ethernet/cisco/enic/enic_ethtool.c
+++ b/drivers/net/ethernet/cisco/enic/enic_ethtool.c
@@ -222,9 +222,9 @@ static void enic_get_ringparam(struct net_device *netdev,
 	struct enic *enic = netdev_priv(netdev);
 	struct vnic_enet_config *c = &enic->config;
 
-	ring->rx_max_pending = ENIC_MAX_RQ_DESCS;
+	ring->rx_max_pending = c->max_rq_ring;
 	ring->rx_pending = c->rq_desc_count;
-	ring->tx_max_pending = ENIC_MAX_WQ_DESCS;
+	ring->tx_max_pending = c->max_wq_ring;
 	ring->tx_pending = c->wq_desc_count;
 }
 
@@ -252,18 +252,18 @@ static int enic_set_ringparam(struct net_device *netdev,
 	}
 	rx_pending = c->rq_desc_count;
 	tx_pending = c->wq_desc_count;
-	if (ring->rx_pending > ENIC_MAX_RQ_DESCS ||
+	if (ring->rx_pending > c->max_rq_ring ||
 	    ring->rx_pending < ENIC_MIN_RQ_DESCS) {
 		netdev_info(netdev, "rx pending (%u) not in range [%u,%u]",
 			    ring->rx_pending, ENIC_MIN_RQ_DESCS,
-			    ENIC_MAX_RQ_DESCS);
+	      c->max_rq_ring);
 		return -EINVAL;
 	}
-	if (ring->tx_pending > ENIC_MAX_WQ_DESCS ||
+	if (ring->tx_pending > c->max_wq_ring ||
 	    ring->tx_pending < ENIC_MIN_WQ_DESCS) {
 		netdev_info(netdev, "tx pending (%u) not in range [%u,%u]",
 			    ring->tx_pending, ENIC_MIN_WQ_DESCS,
-			    ENIC_MAX_WQ_DESCS);
+			c->max_wq_ring);
 		return -EINVAL;
 	}
 	if (running)
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.c b/drivers/net/ethernet/cisco/enic/enic_res.c
index a7179cc4b5296cfbce137c54a9e17e6b358a19ae..bbd3143ed73e77d25a1e4921e073c929e92d8230 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.c
+++ b/drivers/net/ethernet/cisco/enic/enic_res.c
@@ -59,31 +59,38 @@ int enic_get_vnic_config(struct enic *enic)
 	GET_CONFIG(intr_timer_usec);
 	GET_CONFIG(loop_tag);
 	GET_CONFIG(num_arfs);
+	GET_CONFIG(max_rq_ring);
+	GET_CONFIG(max_wq_ring);
+	GET_CONFIG(max_cq_ring);
+
+	if (!c->max_wq_ring)
+		c->max_wq_ring = ENIC_MAX_WQ_DESCS_DEFAULT;
+	if (!c->max_rq_ring)
+		c->max_rq_ring = ENIC_MAX_RQ_DESCS_DEFAULT;
+	if (!c->max_cq_ring)
+		c->max_cq_ring = ENIC_MAX_CQ_DESCS_DEFAULT;
 
 	c->wq_desc_count =
-		min_t(u32, ENIC_MAX_WQ_DESCS,
-		max_t(u32, ENIC_MIN_WQ_DESCS,
-		c->wq_desc_count));
+		min_t(u32, c->max_wq_ring,
+		      max_t(u32, ENIC_MIN_WQ_DESCS, c->wq_desc_count));
 	c->wq_desc_count &= 0xffffffe0; /* must be aligned to groups of 32 */
 
 	c->rq_desc_count =
-		min_t(u32, ENIC_MAX_RQ_DESCS,
-		max_t(u32, ENIC_MIN_RQ_DESCS,
-		c->rq_desc_count));
+		min_t(u32, c->max_rq_ring,
+		      max_t(u32, ENIC_MIN_RQ_DESCS, c->rq_desc_count));
 	c->rq_desc_count &= 0xffffffe0; /* must be aligned to groups of 32 */
 
 	if (c->mtu == 0)
 		c->mtu = 1500;
-	c->mtu = min_t(u16, ENIC_MAX_MTU,
-		max_t(u16, ENIC_MIN_MTU,
-		c->mtu));
+	c->mtu = min_t(u16, ENIC_MAX_MTU, max_t(u16, ENIC_MIN_MTU, c->mtu));
 
 	c->intr_timer_usec = min_t(u32, c->intr_timer_usec,
 		vnic_dev_get_intr_coal_timer_max(enic->vdev));
 
 	dev_info(enic_get_dev(enic),
-		"vNIC MAC addr %pM wq/rq %d/%d mtu %d\n",
-		enic->mac_addr, c->wq_desc_count, c->rq_desc_count, c->mtu);
+		 "vNIC MAC addr %pM wq/rq %d/%d max wq/rq/cq %d/%d/%d mtu %d\n",
+		 enic->mac_addr, c->wq_desc_count, c->rq_desc_count,
+		 c->max_wq_ring, c->max_rq_ring, c->max_cq_ring, c->mtu);
 
 	dev_info(enic_get_dev(enic), "vNIC csum tx/rx %s/%s "
 		"tso/lro %s/%s rss %s intr mode %s type %s timer %d usec "
diff --git a/drivers/net/ethernet/cisco/enic/enic_res.h b/drivers/net/ethernet/cisco/enic/enic_res.h
index b8ee42d297aaf7db75e711be15280b01389567c9..02dca1ae4a2246811277e5ff3aa6650f09fb0f9a 100644
--- a/drivers/net/ethernet/cisco/enic/enic_res.h
+++ b/drivers/net/ethernet/cisco/enic/enic_res.h
@@ -12,10 +12,13 @@
 #include "vnic_wq.h"
 #include "vnic_rq.h"
 
-#define ENIC_MIN_WQ_DESCS		64
-#define ENIC_MAX_WQ_DESCS		4096
-#define ENIC_MIN_RQ_DESCS		64
-#define ENIC_MAX_RQ_DESCS		4096
+#define ENIC_MIN_WQ_DESCS 64
+#define ENIC_MAX_WQ_DESCS_DEFAULT 4096
+#define ENIC_MAX_WQ_DESCS 16384
+#define ENIC_MIN_RQ_DESCS 64
+#define ENIC_MAX_RQ_DESCS 16384
+#define ENIC_MAX_RQ_DESCS_DEFAULT 4096
+#define ENIC_MAX_CQ_DESCS_DEFAULT (64 * 1024)
 
 #define ENIC_MIN_MTU			ETH_MIN_MTU
 #define ENIC_MAX_MTU			9000
diff --git a/drivers/net/ethernet/cisco/enic/enic_wq.c b/drivers/net/ethernet/cisco/enic/enic_wq.c
index 37e8f6eeae3fabd3391b8fcacc5f3420ad091b17..82d8073e5549094825520e20dbdde3ba97f56b2c 100644
--- a/drivers/net/ethernet/cisco/enic/enic_wq.c
+++ b/drivers/net/ethernet/cisco/enic/enic_wq.c
@@ -92,7 +92,7 @@ unsigned int enic_wq_cq_service(struct enic *enic, unsigned int cq_index, unsign
 	struct cq_desc *cq_desc = (struct cq_desc *)((u8 *)cq->ring.descs +
 		cq->ring.desc_size * cq->to_clean);
 
-	bool ext_wq = cq->ring.size > ENIC_MAX_WQ_DESCS;
+	bool ext_wq = cq->ring.size > ENIC_MAX_WQ_DESCS_DEFAULT;
 
 	enic_wq_cq_desc_dec(cq_desc, ext_wq, &type, &color,
 			    &q_number, &completed_index);
diff --git a/drivers/net/ethernet/cisco/enic/vnic_enet.h b/drivers/net/ethernet/cisco/enic/vnic_enet.h
index 5acc236069dea358c2f330824ad57ad7920889cc..9e8e86262a3fea0ab37f8044c81ba798b5b00c90 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_enet.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_enet.h
@@ -21,6 +21,11 @@ struct vnic_enet_config {
 	u16 loop_tag;
 	u16 vf_rq_count;
 	u16 num_arfs;
+	u8 reserved[66];
+	u32 max_rq_ring;	// MAX RQ ring size
+	u32 max_wq_ring;	// MAX WQ ring size
+	u32 max_cq_ring;	// MAX CQ ring size
+	u32 rdma_rsvd_lkey;	// Reserved (privileged) LKey
 };
 
 #define VENETF_TSO		0x1	/* TSO enabled */
diff --git a/drivers/net/ethernet/cisco/enic/vnic_rq.h b/drivers/net/ethernet/cisco/enic/vnic_rq.h
index 2ee4be2b9a343a7a340c2b4a81fe560ccc2e6715..a1cdd729caece5c3378c3a8025cedf9b2bf758ab 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_rq.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_rq.h
@@ -50,7 +50,7 @@ struct vnic_rq_ctrl {
 	(VNIC_RQ_BUF_BLK_ENTRIES(entries) * sizeof(struct vnic_rq_buf))
 #define VNIC_RQ_BUF_BLKS_NEEDED(entries) \
 	DIV_ROUND_UP(entries, VNIC_RQ_BUF_BLK_ENTRIES(entries))
-#define VNIC_RQ_BUF_BLKS_MAX VNIC_RQ_BUF_BLKS_NEEDED(4096)
+#define VNIC_RQ_BUF_BLKS_MAX VNIC_RQ_BUF_BLKS_NEEDED(16384)
 
 struct vnic_rq_buf {
 	struct vnic_rq_buf *next;
diff --git a/drivers/net/ethernet/cisco/enic/vnic_wq.h b/drivers/net/ethernet/cisco/enic/vnic_wq.h
index 75c52691107447f1ea1deb1d4eeabb0e0313b3eb..3bb4758100ba481c3bd7a873203e8b033d6b99a6 100644
--- a/drivers/net/ethernet/cisco/enic/vnic_wq.h
+++ b/drivers/net/ethernet/cisco/enic/vnic_wq.h
@@ -62,7 +62,7 @@ struct vnic_wq_buf {
 	(VNIC_WQ_BUF_BLK_ENTRIES(entries) * sizeof(struct vnic_wq_buf))
 #define VNIC_WQ_BUF_BLKS_NEEDED(entries) \
 	DIV_ROUND_UP(entries, VNIC_WQ_BUF_BLK_ENTRIES(entries))
-#define VNIC_WQ_BUF_BLKS_MAX VNIC_WQ_BUF_BLKS_NEEDED(4096)
+#define VNIC_WQ_BUF_BLKS_MAX VNIC_WQ_BUF_BLKS_NEEDED(16384)
 
 struct vnic_wq {
 	unsigned int index;

-- 
2.48.1



