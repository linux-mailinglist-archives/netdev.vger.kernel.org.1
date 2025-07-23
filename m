Return-Path: <netdev+bounces-209377-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB635B0F68B
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 17:08:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF2C6AE0823
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 15:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E00D2F5080;
	Wed, 23 Jul 2025 15:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hjO7K+0F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF4B2FE382
	for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 15:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753282874; cv=none; b=rOmXmSDNvDYhZtLpWyfJ2cDd8bKQntMmSsGdpWiMUBfGC120tcaP8DU12YlFBsBPqWd4thCAvuCpuXVWHlMNgZN9S0OH0s52DdyTlK3maXJE+FWKa77VeDbepOJ9z/lQwimyp/hYMGq8/Z0v4pJn0Vw7NbXj3IuZkIk49QC5Foc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753282874; c=relaxed/simple;
	bh=QqFvZUwbcRYd8mz7u21LljiuDMSWeZml0b5VRGuYrI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qCSP93wWH2dYEaYba0w/3gExK3j4JGAKQ5nx/FL9w9uzKIjMNiagaXUHw5AYD+SfdkFsPrq9KwrvLrKNnqZOlsuA//y1mKjgomjiM1lOxky8nQI1wgpuoHc5RYjg+KbdWpoyDP3NHYC7Ni0J6Cb0Oc7tb2alI85TFtxBiMDd1VU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hjO7K+0F; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3a4fb9c2436so3853532f8f.1
        for <netdev@vger.kernel.org>; Wed, 23 Jul 2025 08:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753282812; x=1753887612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hy1JyWJYUy9j0qqkvGtRREeaj3uku2t8fVuZQ/WdKl8=;
        b=hjO7K+0Fg65aKvYq9WnDsIpPAC6rVWjUVIabY/eIoVxnbi1yJEJNFJYU96D9ASsnRZ
         YQytZcayXmf7WS1QYqqH59WCNyY9MApIeeBTsBiBMFoP6NzWSU5TpWYGTb1ueQ6cYLni
         ZkIFPY9GGYZjQjDnFontyzifx5ZRHRE1J0NGeF+YtDWWYvnjXsZG/pqbuRvsvLNr9qDG
         koJJ9IlwYPUmawuqKwrUavWDXCxgs2j09UAn7MWlT6CNzAfDqfMooKnJWyoZABqHoJ2i
         wg+N7kOaLrgX1+fqfJ1mp+SXK9PWw+YOuxwBintEXaUyFzDdxv2UPX2ACR8P5ElN0hUZ
         Yuug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753282812; x=1753887612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hy1JyWJYUy9j0qqkvGtRREeaj3uku2t8fVuZQ/WdKl8=;
        b=tly6qGiVgPKSjp0kc6Pp36NZei64jRiE+qkx1a+cFMSpV7GRPIWBaVsmdB6DXYYQuO
         iDj0QSfrljEvlj+18WLtNVizrzQOJNLlZKksAfQFSN8S9MIfsPweZgsbEux2GiIuYbna
         fyRmAIRkjMm6NEEihorltl7m3iLqSJPqgpCcMMDuBFmoVvvAWZIrOjKrJJj3ZM6Xj4tX
         PcSJ0fs/2y5oHQdHKdOvYYInDiAYEz1HBlJkXYxRQxOuvg53N490zLfhPMGkJPcpRsyQ
         p6ZMQ+SbFbi2dwZbmpwbZOyIVyd8ZBXIoDBzscIA9fDl2kxQsOWxVHf54b54EfXKF8k+
         ASJw==
X-Gm-Message-State: AOJu0YxABvqFIh96XfzdbqgZK1PgnzaDHLZbU9s5p8WwtytP4zxmP96X
	172mmKi72cVSZjISq29bB3pJoo6PE/8ymzQJI9dZOu0PC6tMfUBmWjTItbJE3Cfw
X-Gm-Gg: ASbGncuk7gTmkgU0ziCY2vpuOpCg/lSdNy/Uq4yKJoyTbfA6iSlTytCbXby0htpvAQO
	Z8tgWta/SSQKeyJ4Qf/eLDz08qWESSlIlRPaN5quVG904o5Oc2DtHTe95kBAcmqyTU3N5v8LViy
	Q9CsNxITnYfs4ie7syELuQQT34pucLOWE5sqMfOemyFntjU8fdGZ1WZj4w1PlLtjN9xcTc9iMV/
	8hfmAUGS3LwPBFDAfPWMcmAs8XdX4VhI/Hk+64zpVKdlBOQVtBWMB2JVvlKH+HpQ/ucRK5Ngyly
	oToKJzXHm/SgwooJljW2ZzV0PTErXEOBa1ccWthmuGj9JqCrzvssKBExKDAbM+YuJbvCI+X9e/V
	TKirmR5tipClXYCF8+Jk=
X-Google-Smtp-Source: AGHT+IFwcJ2kj8jNqsI886kCthWRg/MIYcdYBlasLe2yBrk0NkzV522U5c+6Kw563g9feGg3qRvKCA==
X-Received: by 2002:a05:6000:288e:b0:391:3aaf:1d5f with SMTP id ffacd0b85a97d-3b768f2e267mr2366067f8f.52.1753282811853;
        Wed, 23 Jul 2025 08:00:11 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:6::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b61ca25443sm16703739f8f.9.2025.07.23.08.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jul 2025 08:00:11 -0700 (PDT)
From: Mohsin Bashir <mohsin.bashr@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	alexanderduyck@fb.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mohsin.bashr@gmail.com,
	horms@kernel.org,
	vadim.fedorenko@linux.dev,
	jdamato@fastly.com,
	sdf@fomichev.me,
	aleksander.lobakin@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com
Subject: [PATCH net-next 5/9] eth: fbnic: Add XDP pass, drop, abort support
Date: Wed, 23 Jul 2025 07:59:22 -0700
Message-ID: <20250723145926.4120434-6-mohsin.bashr@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
References: <20250723145926.4120434-1-mohsin.bashr@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add basic support for attaching an XDP program to the device and support
for PASS/DROP/ABORT actions.
In fbnic, buffers are always mapped as DMA_BIDIRECTIONAL.

Testing:

Hook a simple XDP program that passes all the packets destined for a
specific port

iperf3 -c 192.168.1.10 -P 5 -p 12345
Connecting to host 192.168.1.10, port 12345
[  5] local 192.168.1.9 port 46702 connected to 192.168.1.10 port 12345
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
- - - - - - - - - - - - - - - - - - - - - - - - -
[SUM]   1.00-2.00   sec  3.86 GBytes  33.2 Gbits/sec    0

XDP_DROP:
Hook an XDP program that drops packets destined for a specific port

 iperf3 -c 192.168.1.10 -P 5 -p 12345
^C- - - - - - - - - - - - - - - - - - - - - - - - -
[ ID] Interval           Transfer     Bitrate         Retr
[SUM]   0.00-0.00   sec  0.00 Bytes  0.00 bits/sec    0       sender
[SUM]   0.00-0.00   sec  0.00 Bytes  0.00 bits/sec            receiver
iperf3: interrupt - the client has terminated

XDP with HDS:

- Validate XDP attachment failure when HDS is low
   ~] ethtool -G eth0 hds-thresh 512
   ~] sudo ip link set eth0 xdpdrv obj xdp_pass_12345.o sec xdp
   ~] Error: fbnic: MTU too high, or HDS threshold is too low for single
      buffer XDP.

- Validate successful XDP attachment when HDS threshold is appropriate
  ~] ethtool -G eth0 hds-thresh 1536
  ~] sudo ip link set eth0 xdpdrv obj xdp_pass_12345.o sec xdp

- Validate when the XDP program is attached, changing HDS thresh to a
  lower value fails
  ~] ethtool -G eth0 hds-thresh 512
  ~] netlink error: fbnic: Use higher HDS threshold or multi-buf capable
     program

- Validate HDS thresh does not matter when xdp frags support is
  available
  ~] ethtool -G eth0 hds-thresh 512
  ~] sudo ip link set eth0 xdpdrv obj xdp_pass_mb_12345.o sec xdp.frags

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
---
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   | 11 +++
 .../net/ethernet/meta/fbnic/fbnic_netdev.c    | 35 +++++++
 .../net/ethernet/meta/fbnic/fbnic_netdev.h    |  5 +
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.c  | 95 +++++++++++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_txrx.h  |  1 +
 5 files changed, 140 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
index 84a0db9f1be0..d7b9eb267ead 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_ethtool.c
@@ -329,6 +329,17 @@ fbnic_set_ringparam(struct net_device *netdev, struct ethtool_ringparam *ring,
 		return -EINVAL;
 	}
 
+	/* If an XDP program is attached, we should check for potential frame
+	 * splitting. If the new HDS threshold can cause splitting, we should
+	 * only allow if the attached XDP program can handle frags.
+	 */
+	if (fbnic_check_split_frames(fbn->xdp_prog, netdev->mtu,
+				     kernel_ring->hds_thresh)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "Use higher HDS threshold or multi-buf capable program");
+		return -EINVAL;
+	}
+
 	if (!netif_running(netdev)) {
 		fbnic_set_rings(fbn, ring, kernel_ring);
 		return 0;
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
index d039e1c7a0d5..0621b89cbf3d 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.c
@@ -504,6 +504,40 @@ static void fbnic_get_stats64(struct net_device *dev,
 	}
 }
 
+bool fbnic_check_split_frames(struct bpf_prog *prog, unsigned int mtu,
+			      u32 hds_thresh)
+{
+	if (!prog)
+		return false;
+
+	if (prog->aux->xdp_has_frags)
+		return false;
+
+	return mtu + ETH_HLEN > hds_thresh;
+}
+
+static int fbnic_bpf(struct net_device *netdev, struct netdev_bpf *bpf)
+{
+	struct bpf_prog *prog = bpf->prog, *prev_prog;
+	struct fbnic_net *fbn = netdev_priv(netdev);
+
+	if (bpf->command != XDP_SETUP_PROG)
+		return -EINVAL;
+
+	if (fbnic_check_split_frames(prog, netdev->mtu,
+				     fbn->hds_thresh)) {
+		NL_SET_ERR_MSG_MOD(bpf->extack,
+				   "MTU too high, or HDS threshold is too low for single buffer XDP");
+		return -EOPNOTSUPP;
+	}
+
+	prev_prog = xchg(&fbn->xdp_prog, prog);
+	if (prev_prog)
+		bpf_prog_put(prev_prog);
+
+	return 0;
+}
+
 static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_open		= fbnic_open,
 	.ndo_stop		= fbnic_stop,
@@ -513,6 +547,7 @@ static const struct net_device_ops fbnic_netdev_ops = {
 	.ndo_set_mac_address	= fbnic_set_mac,
 	.ndo_set_rx_mode	= fbnic_set_rx_mode,
 	.ndo_get_stats64	= fbnic_get_stats64,
+	.ndo_bpf		= fbnic_bpf,
 	.ndo_hwtstamp_get	= fbnic_hwtstamp_get,
 	.ndo_hwtstamp_set	= fbnic_hwtstamp_set,
 };
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
index 04c5c7ed6c3a..bfa79ea910d8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_netdev.h
@@ -18,6 +18,8 @@
 #define FBNIC_TUN_GSO_FEATURES		NETIF_F_GSO_IPXIP6
 
 struct fbnic_net {
+	struct bpf_prog *xdp_prog;
+
 	struct fbnic_ring *tx[FBNIC_MAX_TXQS];
 	struct fbnic_ring *rx[FBNIC_MAX_RXQS];
 
@@ -104,4 +106,7 @@ int fbnic_phylink_ethtool_ksettings_get(struct net_device *netdev,
 int fbnic_phylink_get_fecparam(struct net_device *netdev,
 			       struct ethtool_fecparam *fecparam);
 int fbnic_phylink_init(struct net_device *netdev);
+
+bool fbnic_check_split_frames(struct bpf_prog *prog,
+			      unsigned int mtu, u32 hds_threshold);
 #endif /* _FBNIC_NETDEV_H_ */
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
index 71af7b9d5bcd..486c14e83ad5 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.c
@@ -2,17 +2,26 @@
 /* Copyright (c) Meta Platforms, Inc. and affiliates. */
 
 #include <linux/bitfield.h>
+#include <linux/bpf.h>
+#include <linux/bpf_trace.h>
 #include <linux/iopoll.h>
 #include <linux/pci.h>
 #include <net/netdev_queues.h>
 #include <net/page_pool/helpers.h>
 #include <net/tcp.h>
+#include <net/xdp.h>
 
 #include "fbnic.h"
 #include "fbnic_csr.h"
 #include "fbnic_netdev.h"
 #include "fbnic_txrx.h"
 
+enum {
+	FBNIC_XDP_PASS = 0,
+	FBNIC_XDP_CONSUME,
+	FBNIC_XDP_LEN_ERR,
+};
+
 enum {
 	FBNIC_XMIT_CB_TS	= 0x01,
 };
@@ -877,7 +886,7 @@ static void fbnic_pkt_prepare(struct fbnic_napi_vector *nv, u64 rcd,
 
 	headroom = hdr_pg_off - hdr_pg_start + FBNIC_RX_PAD;
 	frame_sz = hdr_pg_end - hdr_pg_start;
-	xdp_init_buff(&pkt->buff, frame_sz, NULL);
+	xdp_init_buff(&pkt->buff, frame_sz, &qt->xdp_rxq);
 	hdr_pg_start += (FBNIC_RCD_AL_BUFF_FRAG_MASK & rcd) *
 			FBNIC_BD_FRAG_SIZE;
 
@@ -966,6 +975,38 @@ static struct sk_buff *fbnic_build_skb(struct fbnic_napi_vector *nv,
 	return skb;
 }
 
+static struct sk_buff *fbnic_run_xdp(struct fbnic_napi_vector *nv,
+				     struct fbnic_pkt_buff *pkt)
+{
+	struct fbnic_net *fbn = netdev_priv(nv->napi.dev);
+	struct bpf_prog *xdp_prog;
+	int act;
+
+	xdp_prog = READ_ONCE(fbn->xdp_prog);
+	if (!xdp_prog)
+		goto xdp_pass;
+
+	if (xdp_buff_has_frags(&pkt->buff) && !xdp_prog->aux->xdp_has_frags)
+		return ERR_PTR(-FBNIC_XDP_LEN_ERR);
+
+	act = bpf_prog_run_xdp(xdp_prog, &pkt->buff);
+	switch (act) {
+	case XDP_PASS:
+xdp_pass:
+		return fbnic_build_skb(nv, pkt);
+	default:
+		bpf_warn_invalid_xdp_action(nv->napi.dev, xdp_prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+		trace_xdp_exception(nv->napi.dev, xdp_prog, act);
+		fallthrough;
+	case XDP_DROP:
+		break;
+	}
+
+	return ERR_PTR(-FBNIC_XDP_CONSUME);
+}
+
 static enum pkt_hash_types fbnic_skb_hash_type(u64 rcd)
 {
 	return (FBNIC_RCD_META_L4_TYPE_MASK & rcd) ? PKT_HASH_TYPE_L4 :
@@ -1064,7 +1105,7 @@ static int fbnic_clean_rcq(struct fbnic_napi_vector *nv,
 			if (unlikely(pkt->add_frag_failed))
 				skb = NULL;
 			else if (likely(!fbnic_rcd_metadata_err(rcd)))
-				skb = fbnic_build_skb(nv, pkt);
+				skb = fbnic_run_xdp(nv, pkt);
 
 			/* Populate skb and invalidate XDP */
 			if (!IS_ERR_OR_NULL(skb)) {
@@ -1250,6 +1291,7 @@ static void fbnic_free_napi_vector(struct fbnic_net *fbn,
 	}
 
 	for (j = 0; j < nv->rxt_count; j++, i++) {
+		xdp_rxq_info_unreg(&nv->qt[i].xdp_rxq);
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub0);
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].sub1);
 		fbnic_remove_rx_ring(fbn, &nv->qt[i].cmpl);
@@ -1422,6 +1464,11 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 		fbnic_ring_init(&qt->cmpl, db, rxq_idx, FBNIC_RING_F_STATS);
 		fbn->rx[rxq_idx] = &qt->cmpl;
 
+		err = xdp_rxq_info_reg(&qt->xdp_rxq, fbn->netdev, rxq_idx,
+				       nv->napi.napi_id);
+		if (err)
+			goto free_ring_cur_qt;
+
 		/* Update Rx queue index */
 		rxt_count--;
 		rxq_idx += v_count;
@@ -1432,6 +1479,25 @@ static int fbnic_alloc_napi_vector(struct fbnic_dev *fbd, struct fbnic_net *fbn,
 
 	return 0;
 
+	while (rxt_count < nv->rxt_count) {
+		qt--;
+
+		xdp_rxq_info_unreg(&qt->xdp_rxq);
+free_ring_cur_qt:
+		fbnic_remove_rx_ring(fbn, &qt->sub0);
+		fbnic_remove_rx_ring(fbn, &qt->sub1);
+		fbnic_remove_rx_ring(fbn, &qt->cmpl);
+		rxt_count++;
+	}
+	while (txt_count < nv->txt_count) {
+		qt--;
+
+		fbnic_remove_tx_ring(fbn, &qt->sub0);
+		fbnic_remove_tx_ring(fbn, &qt->cmpl);
+
+		txt_count++;
+	}
+	fbnic_napi_free_irq(fbd, nv);
 pp_destroy:
 	page_pool_destroy(nv->page_pool);
 napi_del:
@@ -1708,8 +1774,10 @@ static void fbnic_free_nv_resources(struct fbnic_net *fbn,
 	for (i = 0; i < nv->txt_count; i++)
 		fbnic_free_qt_resources(fbn, &nv->qt[i]);
 
-	for (j = 0; j < nv->rxt_count; j++, i++)
+	for (j = 0; j < nv->rxt_count; j++, i++) {
 		fbnic_free_qt_resources(fbn, &nv->qt[i]);
+		xdp_rxq_info_unreg_mem_model(&nv->qt[i].xdp_rxq);
+	}
 }
 
 static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
@@ -1721,19 +1789,32 @@ static int fbnic_alloc_nv_resources(struct fbnic_net *fbn,
 	for (i = 0; i < nv->txt_count; i++) {
 		err = fbnic_alloc_tx_qt_resources(fbn, &nv->qt[i]);
 		if (err)
-			goto free_resources;
+			goto free_qt_resources;
 	}
 
 	/* Allocate Rx Resources */
 	for (j = 0; j < nv->rxt_count; j++, i++) {
+		/* Register XDP memory model for completion queue */
+		err = xdp_reg_mem_model(&nv->qt[i].xdp_rxq.mem,
+					MEM_TYPE_PAGE_POOL,
+					nv->page_pool);
+		if (err)
+			goto xdp_unreg_mem_model;
+
 		err = fbnic_alloc_rx_qt_resources(fbn, &nv->qt[i]);
 		if (err)
-			goto free_resources;
+			goto xdp_unreg_cur_model;
 	}
 
 	return 0;
 
-free_resources:
+xdp_unreg_mem_model:
+	while (j-- && i--) {
+		fbnic_free_qt_resources(fbn, &nv->qt[i]);
+xdp_unreg_cur_model:
+		xdp_rxq_info_unreg_mem_model(&nv->qt[i].xdp_rxq);
+	}
+free_qt_resources:
 	while (i--)
 		fbnic_free_qt_resources(fbn, &nv->qt[i]);
 	return err;
@@ -2025,7 +2106,7 @@ void fbnic_flush(struct fbnic_net *fbn)
 			memset(qt->cmpl.desc, 0, qt->cmpl.size);
 
 			fbnic_put_pkt_buff(nv, qt->cmpl.pkt, 0);
-			qt->cmpl.pkt->buff.data_hard_start = NULL;
+			memset(qt->cmpl.pkt, 0, sizeof(struct fbnic_pkt_buff));
 		}
 	}
 }
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
index be34962c465e..0fefd1f00196 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_txrx.h
@@ -129,6 +129,7 @@ struct fbnic_ring {
 
 struct fbnic_q_triad {
 	struct fbnic_ring sub0, sub1, cmpl;
+	struct xdp_rxq_info xdp_rxq;
 };
 
 struct fbnic_napi_vector {
-- 
2.47.1


