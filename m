Return-Path: <netdev+bounces-270663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIZfES2JwWn+TgQAu9opvQ
	(envelope-from <netdev+bounces-270663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:40:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE78F2FB6EB
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9F65A305D4E0
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3589A3D1CCA;
	Mon, 23 Mar 2026 18:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SKFBG4ga"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F873D301E
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 18:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774290530; cv=none; b=UeYmHOy6mNpfSSI8tytNbHoXa9YhOhU3+HYOD/m79jvNYU4WIpDQoTVSLv6Mdne0JN+R44VZGPVXMyP2uz0LzabVkfW43t50IeD+p9rKm/VRsNfbjGpQY4PRq1r4Eoh7/R18rQF5uwh2PZCvlsQWaQUXGmsWaqniqLsZ5ZzJCjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774290530; c=relaxed/simple;
	bh=UTDFJf60h4k8PPwTFhEb7MQg4ytg1AGu01E3sA5SLp8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ys1RzjfQtGG8aLpnupOkHtlNeXMSPg3TFbnjcADpZ6i5jSrhi3OBV83eQavSxmcCK0eg/j7D3/1j9jDkSHotRb1lqOGIZIKb3clOxvXLovd52ogMbDycAvwkEYMVu9wvnmBe+R2zqva/GbRGyMgZdYcsNH4zJsu40dYAZPHOogA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SKFBG4ga; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43b40fb7f95so454497f8f.3
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 11:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774290522; x=1774895322; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPBuryN6n7btOiyeSAgPIZIWAfoaH/+/MuqQMs6eiTw=;
        b=SKFBG4gag2wG+zrG5XOUok4d7BrEcqAqTeloSnwhPKFOK82Le2TyhzFXvQz1q0rU7s
         jidY3YYPxIkVrdVQ2U2J3OE+PAZNoROdYfQpph7dET1h5lE8wlPi7OvM7tV7rA4jzx+v
         jJ0NB7zU+SflIFv+xDm9WyjMD2+IchU66T4AaN1Mcp7Hov8/2T4AnvvABlq5KEG//e4G
         yBMdc6iw+bZC6fbOuoyZ7C2NC+1ETyAYpCzsQUmLo+9WB2TsfqhpxDL5Rn1jPvy4gZzj
         hDFo4GXoLbLWT3ToWQELNxX6fff6syXHad44s6hPO5lTSDw6fMOOnMW8b49VRYHwW7gJ
         4Jgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774290522; x=1774895322;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KPBuryN6n7btOiyeSAgPIZIWAfoaH/+/MuqQMs6eiTw=;
        b=CsllJDQiYq31So9eyNonX3iEKTauxouJlZswNHsoJivpNpdbYlFVnJG4CSXuWeEa0f
         DRalYASPgNBpKxjPYhg21GSDYkpX0vmyTyqy6ZdDTRko9JrXfrgNXLe2At/RG8CFdo0v
         ivnW7P5uFNWED3pso4Kg8AdXTit63i/86JFkaXXGqRH4z9QEFvnhryNNM0LMYNADCOK0
         hWWthhpM9COJLktWibm4tGiH5LrmxC8TaFcZs2u5U/Zn8A+tpqjRLHXRIGwZsdVO4YGj
         HxSMHnPfIfLzmXLFGVcf6MdreU5CJ/b/7dorpmwDM2wVs1UDLAGK4WNDYAsLlOVzT48t
         d2Dg==
X-Gm-Message-State: AOJu0YyXLEv1TOvdqOyZ74Pq8lrZQ9zoDcZzZqC7Htd/zILWtMxiVczH
	zDKqh3OI9gH2eAUUCP+2Upi3Ajxsd+cW7ZWKzMbYOue7Z02r5X+hZG9Y
X-Gm-Gg: ATEYQzwnHkEf7XNoLtnobNV6eza7mae/CLkW3hdzpErh3AF2MJ+qJV2K9Goh2BA3wxh
	pbeHIIGa6s8ZSEADryvx9ybWT9dxyFLZJylPE3Q9hG9mKAMKstqNDNx46t1MiKJY89FUBaM7EW4
	MNCgVKEdlph8+gf2az0O419TObeDN/QDwpIAErMkdMOc9Ia4ME2zabYsV1rzOEuz73+rIB67Zmd
	pjP+FGYr3wKSEkTPZdpev9D5VclEdRttA1gz6Zjnnb/tI1+hkS1LhJdOP9zlflOXbk/cIPqNCh2
	4oZNvSSkPApjpHTUsTjQLJFQx+zE5d5DyiJFiT5v/K4jUdj9x+MxR6WiltBNPMyWI2y7pL2jw6U
	m72AIv1eV1/zxwzu6dreZP+LXhW5UgVNZd8y8Ym+e7vQHYyqXIvgDJ/dauuI/m2t1l9m9Z3RKgE
	EecQAplVP37mQh+/YYPcDUqHp6duMfUnR18m9VexY4Cb2KynkvfWy/VIaHaADEOTgh1vY1m9WL9
	rM=
X-Received: by 2002:a5d:5f53:0:b0:439:be82:1fd9 with SMTP id ffacd0b85a97d-43b6423b821mr19745350f8f.12.1774290522071;
        Mon, 23 Mar 2026 11:28:42 -0700 (PDT)
Received: from turbo.teknoraver.net (net-37-119-137-97.cust.vodafonedsl.it. [37.119.137.97])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b64714decsm28448751f8f.31.2026.03.23.11.28.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 11:28:41 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
X-Google-Original-From: Matteo Croce <teknoraver@meta.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/2] e1000e: add basic XDP support
Date: Mon, 23 Mar 2026 19:28:22 +0100
Message-ID: <20260323182823.5813-2-teknoraver@meta.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323182823.5813-1-teknoraver@meta.com>
References: <20260323182823.5813-1-teknoraver@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-270663-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,iogearbox.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[technoboy85@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xdp.data:url,meta.com:email,meta.com:mid]
X-Rspamd-Queue-Id: AE78F2FB6EB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add XDP support to the e1000e driver covering the actions defined by
NETDEV_XDP_ACT_BASIC: XDP_DROP, XDP_PASS, XDP_TX and XDP_ABORTED.

Infrastructure:
- e1000_xdp_setup() / e1000_xdp() for program attach/detach with
  MTU validation and close/open cycle
- ndo_bpf support in net_device_ops
- xdp_rxq_info registration in setup/free_rx_resources

Receive path:
- e1000_alloc_rx_buffers_xdp() for page-based Rx buffer allocation
  with XDP_PACKET_HEADROOM
- e1000_clean_rx_irq_xdp() as the XDP receive handler
- e1000_run_xdp() to execute the XDP program on received packets
- SKB building via napi_build_skb() for XDP_PASS with metadata,
  checksum offload and RSS hash support

Transmit path:
- e1000_xdp_xmit_ring() to DMA-map and enqueue an XDP frame
- e1000_xdp_xmit_back() to convert an xdp_buff to a frame and send it
- e1000_finalize_xdp() to flush the TX ring after XDP processing
- TX completion via xdp_return_frame() with buffer type tracking

Assisted-by: claude-opus-4-6
Signed-off-by: Matteo Croce <teknoraver@meta.com>
---
 drivers/net/ethernet/intel/Kconfig         |   1 +
 drivers/net/ethernet/intel/e1000e/e1000.h  |  18 +-
 drivers/net/ethernet/intel/e1000e/netdev.c | 533 ++++++++++++++++++++-
 3 files changed, 540 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index 288fa8ce53af..46e37cb68e70 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -63,6 +63,7 @@ config E1000E
 	depends on PCI && (!SPARC32 || BROKEN)
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select CRC32
+	select PAGE_POOL
 	help
 	  This driver supports the PCI-Express Intel(R) PRO/1000 gigabit
 	  ethernet family of adapters. For PCI or PCI-X e1000 adapters,
diff --git a/drivers/net/ethernet/intel/e1000e/e1000.h b/drivers/net/ethernet/intel/e1000e/e1000.h
index 63ebe00376f5..4c1175d4e5cb 100644
--- a/drivers/net/ethernet/intel/e1000e/e1000.h
+++ b/drivers/net/ethernet/intel/e1000e/e1000.h
@@ -19,10 +19,13 @@
 #include <linux/net_tstamp.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/ptp_classify.h>
+#include <linux/bpf.h>
 #include <linux/mii.h>
 #include <linux/mdio.h>
 #include <linux/mutex.h>
 #include <linux/pm_qos.h>
+#include <net/page_pool/helpers.h>
+#include <net/xdp.h>
 #include "hw.h"
 
 struct e1000_info;
@@ -126,12 +129,21 @@ struct e1000_ps_page {
 	u64 dma; /* must be u64 - written to hw */
 };
 
+enum e1000_tx_buf_type {
+	E1000_TX_BUF_SKB = 0,
+	E1000_TX_BUF_XDP,
+};
+
 /* wrappers around a pointer to a socket buffer,
  * so a DMA handle can be stored along with the buffer
  */
 struct e1000_buffer {
 	dma_addr_t dma;
-	struct sk_buff *skb;
+	union {
+		struct sk_buff *skb;
+		struct xdp_frame *xdpf;
+	};
+	enum e1000_tx_buf_type type;
 	union {
 		/* Tx */
 		struct {
@@ -259,6 +271,10 @@ struct e1000_adapter {
 			     gfp_t gfp);
 	struct e1000_ring *rx_ring;
 
+	struct bpf_prog *xdp_prog;
+	struct xdp_rxq_info xdp_rxq;
+	struct page_pool *page_pool;
+
 	u32 rx_int_delay;
 	u32 rx_abs_int_delay;
 
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 9befdacd6730..d77f208f00cc 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -25,6 +25,10 @@
 #include <linux/pm_runtime.h>
 #include <linux/prefetch.h>
 #include <linux/suspend.h>
+#include <linux/bpf.h>
+#include <linux/bpf_trace.h>
+#include <net/page_pool/helpers.h>
+#include <net/xdp.h>
 
 #include "e1000.h"
 #define CREATE_TRACE_POINTS
@@ -33,6 +37,11 @@
 char e1000e_driver_name[] = "e1000e";
 
 #define DEFAULT_MSG_ENABLE (NETIF_MSG_DRV|NETIF_MSG_PROBE|NETIF_MSG_LINK)
+
+#define E1000_XDP_PASS		0
+#define E1000_XDP_CONSUMED	BIT(0)
+#define E1000_XDP_TX		BIT(1)
+
 static int debug = -1;
 module_param(debug, int, 0);
 MODULE_PARM_DESC(debug, "Debug level (0=none,...,16=all)");
@@ -708,6 +717,370 @@ static void e1000_alloc_rx_buffers(struct e1000_ring *rx_ring,
 	rx_ring->next_to_use = i;
 }
 
+static inline void e1000_rx_hash(struct net_device *netdev, __le32 rss,
+				 struct sk_buff *skb)
+{
+	if (netdev->features & NETIF_F_RXHASH)
+		skb_set_hash(skb, le32_to_cpu(rss), PKT_HASH_TYPE_L3);
+}
+
+/**
+ * e1000_xdp_xmit_ring - transmit an XDP frame on the TX ring
+ * @adapter: board private structure
+ * @tx_ring: Tx descriptor ring
+ * @xdpf: XDP frame to transmit
+ *
+ * Returns E1000_XDP_TX on success, E1000_XDP_CONSUMED on failure
+ **/
+static int e1000_xdp_xmit_ring(struct e1000_adapter *adapter,
+			       struct e1000_ring *tx_ring,
+			       struct xdp_frame *xdpf)
+{
+	struct e1000_buffer *buffer_info;
+	struct e1000_tx_desc *tx_desc;
+	dma_addr_t dma;
+	u16 i;
+
+	if (e1000_desc_unused(tx_ring) < 1)
+		return E1000_XDP_CONSUMED;
+
+	i = tx_ring->next_to_use;
+	buffer_info = &tx_ring->buffer_info[i];
+
+	dma = dma_map_single(&adapter->pdev->dev, xdpf->data, xdpf->len,
+			     DMA_TO_DEVICE);
+	if (dma_mapping_error(&adapter->pdev->dev, dma))
+		return E1000_XDP_CONSUMED;
+
+	buffer_info->xdpf = xdpf;
+	buffer_info->type = E1000_TX_BUF_XDP;
+	buffer_info->dma = dma;
+	buffer_info->length = xdpf->len;
+	buffer_info->time_stamp = jiffies;
+	buffer_info->next_to_watch = i;
+	buffer_info->segs = 1;
+	buffer_info->bytecount = xdpf->len;
+	buffer_info->mapped_as_page = 0;
+
+	tx_desc = E1000_TX_DESC(*tx_ring, i);
+	tx_desc->buffer_addr = cpu_to_le64(dma);
+	tx_desc->lower.data = cpu_to_le32(adapter->txd_cmd |
+					   E1000_TXD_CMD_IFCS |
+					   xdpf->len);
+	tx_desc->upper.data = 0;
+
+	i++;
+	if (i == tx_ring->count)
+		i = 0;
+	tx_ring->next_to_use = i;
+
+	return E1000_XDP_TX;
+}
+
+/**
+ * e1000_xdp_xmit_back - transmit an XDP buffer back on the same device
+ * @adapter: board private structure
+ * @xdp: XDP buffer to transmit
+ *
+ * Returns E1000_XDP_TX on success, E1000_XDP_CONSUMED on failure
+ **/
+static int e1000_xdp_xmit_back(struct e1000_adapter *adapter,
+			       struct xdp_buff *xdp)
+{
+	struct xdp_frame *xdpf = xdp_convert_buff_to_frame(xdp);
+
+	if (unlikely(!xdpf))
+		return E1000_XDP_CONSUMED;
+
+	return e1000_xdp_xmit_ring(adapter, adapter->tx_ring, xdpf);
+}
+
+/**
+ * e1000_finalize_xdp - flush XDP operations after NAPI Rx loop
+ * @adapter: board private structure
+ * @xdp_xmit: bitmask of XDP actions taken during Rx processing
+ **/
+static void e1000_finalize_xdp(struct e1000_adapter *adapter,
+			       unsigned int xdp_xmit)
+{
+	struct e1000_ring *tx_ring = adapter->tx_ring;
+
+	if (xdp_xmit & E1000_XDP_TX) {
+		/* Force memory writes to complete before letting h/w
+		 * know there are new descriptors to fetch.
+		 */
+		wmb();
+		if (adapter->flags2 & FLAG2_PCIM2PCI_ARBITER_WA)
+			e1000e_update_tdt_wa(tx_ring,
+					     tx_ring->next_to_use);
+		else
+			writel(tx_ring->next_to_use, tx_ring->tail);
+	}
+}
+
+/**
+ * e1000_run_xdp - run an XDP program on a received packet
+ * @adapter: board private structure
+ * @xdp: XDP buffer containing packet data
+ *
+ * Returns E1000_XDP_PASS, E1000_XDP_TX, or E1000_XDP_CONSUMED
+ **/
+static int e1000_run_xdp(struct e1000_adapter *adapter, struct xdp_buff *xdp)
+{
+	struct bpf_prog *xdp_prog = READ_ONCE(adapter->xdp_prog);
+	struct net_device *netdev = adapter->netdev;
+	int result = E1000_XDP_PASS;
+	u32 act;
+
+	if (!xdp_prog)
+		return E1000_XDP_PASS;
+
+	prefetchw(xdp->data_hard_start);
+
+	act = bpf_prog_run_xdp(xdp_prog, xdp);
+	switch (act) {
+	case XDP_PASS:
+		break;
+	case XDP_TX:
+		result = e1000_xdp_xmit_back(adapter, xdp);
+		if (result == E1000_XDP_CONSUMED)
+			goto out_failure;
+		break;
+	default:
+		bpf_warn_invalid_xdp_action(netdev, xdp_prog, act);
+		fallthrough;
+	case XDP_ABORTED:
+out_failure:
+		trace_xdp_exception(netdev, xdp_prog, act);
+		fallthrough;
+	case XDP_DROP:
+		result = E1000_XDP_CONSUMED;
+		break;
+	}
+
+	return result;
+}
+
+/**
+ * e1000_alloc_rx_buffers_xdp - Replace used receive buffers for XDP
+ * @rx_ring: Rx descriptor ring
+ * @cleaned_count: number to reallocate
+ * @gfp: flags for allocation
+ *
+ * Allocates page-based Rx buffers with XDP_PACKET_HEADROOM headroom.
+ **/
+static void e1000_alloc_rx_buffers_xdp(struct e1000_ring *rx_ring,
+				       int cleaned_count, gfp_t gfp)
+{
+	struct e1000_adapter *adapter = rx_ring->adapter;
+	union e1000_rx_desc_extended *rx_desc;
+	struct e1000_buffer *buffer_info;
+	unsigned int i;
+
+	i = rx_ring->next_to_use;
+	buffer_info = &rx_ring->buffer_info[i];
+
+	while (cleaned_count--) {
+		if (!buffer_info->page) {
+			buffer_info->page = page_pool_alloc_pages(adapter->page_pool,
+								  gfp);
+			if (!buffer_info->page) {
+				adapter->alloc_rx_buff_failed++;
+				break;
+			}
+		}
+
+		if (!buffer_info->dma) {
+			buffer_info->dma = page_pool_get_dma_addr(buffer_info->page) +
+					   XDP_PACKET_HEADROOM;
+		}
+
+		rx_desc = E1000_RX_DESC_EXT(*rx_ring, i);
+		rx_desc->read.buffer_addr = cpu_to_le64(buffer_info->dma);
+
+		if (unlikely(!(i & (E1000_RX_BUFFER_WRITE - 1)))) {
+			/* Force memory writes to complete before letting
+			 * h/w know there are new descriptors to fetch.
+			 */
+			wmb();
+			if (adapter->flags2 & FLAG2_PCIM2PCI_ARBITER_WA)
+				e1000e_update_rdt_wa(rx_ring, i);
+			else
+				writel(i, rx_ring->tail);
+		}
+		i++;
+		if (i == rx_ring->count)
+			i = 0;
+		buffer_info = &rx_ring->buffer_info[i];
+	}
+
+	rx_ring->next_to_use = i;
+}
+
+/**
+ * e1000_clean_rx_irq_xdp - Receive with XDP processing
+ * @rx_ring: Rx descriptor ring
+ * @work_done: output parameter for indicating completed work
+ * @work_to_do: how many packets we can clean
+ *
+ * Page-based receive path that runs an XDP program on each packet.
+ **/
+static bool e1000_clean_rx_irq_xdp(struct e1000_ring *rx_ring, int *work_done,
+				   int work_to_do)
+{
+	struct e1000_adapter *adapter = rx_ring->adapter;
+	struct net_device *netdev = adapter->netdev;
+	struct pci_dev *pdev = adapter->pdev;
+	union e1000_rx_desc_extended *rx_desc, *next_rxd;
+	struct e1000_buffer *buffer_info, *next_buffer;
+	struct xdp_buff xdp;
+	u32 length, staterr;
+	unsigned int i, crc_len;
+	int cleaned_count = 0;
+	bool cleaned = false;
+	unsigned int total_rx_bytes = 0, total_rx_packets = 0;
+	unsigned int xdp_xmit = 0;
+
+	xdp_init_buff(&xdp, PAGE_SIZE, &adapter->xdp_rxq);
+
+	i = rx_ring->next_to_clean;
+	rx_desc = E1000_RX_DESC_EXT(*rx_ring, i);
+	staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
+	buffer_info = &rx_ring->buffer_info[i];
+
+	while (staterr & E1000_RXD_STAT_DD) {
+		struct sk_buff *skb;
+		int xdp_res;
+
+		crc_len = 0;
+		if (*work_done >= work_to_do)
+			break;
+		(*work_done)++;
+		dma_rmb();
+
+		i++;
+		if (i == rx_ring->count)
+			i = 0;
+		next_rxd = E1000_RX_DESC_EXT(*rx_ring, i);
+		prefetch(next_rxd);
+
+		next_buffer = &rx_ring->buffer_info[i];
+
+		cleaned = true;
+		cleaned_count++;
+
+		dma_sync_single_for_cpu(&pdev->dev, buffer_info->dma,
+					adapter->rx_buffer_len,
+				       DMA_FROM_DEVICE);
+		buffer_info->dma = 0;
+
+		length = le16_to_cpu(rx_desc->wb.upper.length);
+
+		/* Multi-descriptor packets not supported with XDP */
+		if (unlikely(!(staterr & E1000_RXD_STAT_EOP)))
+			adapter->flags2 |= FLAG2_IS_DISCARDING;
+
+		if (adapter->flags2 & FLAG2_IS_DISCARDING) {
+			if (staterr & E1000_RXD_STAT_EOP)
+				adapter->flags2 &= ~FLAG2_IS_DISCARDING;
+			page_pool_put_full_page(adapter->page_pool,
+						buffer_info->page, true);
+			buffer_info->page = NULL;
+			goto next_desc;
+		}
+
+		if (unlikely((staterr & E1000_RXDEXT_ERR_FRAME_ERR_MASK) &&
+			     !(netdev->features & NETIF_F_RXALL))) {
+			page_pool_put_full_page(adapter->page_pool,
+						buffer_info->page, true);
+			buffer_info->page = NULL;
+			goto next_desc;
+		}
+
+		/* adjust length to remove Ethernet CRC */
+		if (!(adapter->flags2 & FLAG2_CRC_STRIPPING)) {
+			if (netdev->features & NETIF_F_RXFCS)
+				crc_len = 4;
+			else
+				length -= 4;
+		}
+
+		/* Setup xdp_buff pointing at the page data */
+		xdp_prepare_buff(&xdp, page_address(buffer_info->page),
+				 XDP_PACKET_HEADROOM, length, true);
+		xdp_buff_clear_frags_flag(&xdp);
+
+		xdp_res = e1000_run_xdp(adapter, &xdp);
+
+		if (xdp_res == E1000_XDP_PASS) {
+			total_rx_bytes += length - crc_len;
+			total_rx_packets++;
+
+			skb = napi_build_skb(xdp.data_hard_start, PAGE_SIZE);
+			if (unlikely(!skb)) {
+				page_pool_put_full_page(adapter->page_pool,
+							buffer_info->page,
+							true);
+				buffer_info->page = NULL;
+				goto next_desc;
+			}
+
+			skb_mark_for_recycle(skb);
+			skb_reserve(skb,
+				    xdp.data - xdp.data_hard_start);
+			skb_put(skb, xdp.data_end - xdp.data);
+
+			if (xdp.data_meta != xdp.data)
+				skb_metadata_set(skb, xdp.data - xdp.data_meta);
+
+			e1000_rx_checksum(adapter, staterr, skb);
+			e1000_rx_hash(netdev,
+				      rx_desc->wb.lower.hi_dword.rss, skb);
+			e1000_receive_skb(adapter, netdev, skb, staterr,
+					  rx_desc->wb.upper.vlan);
+
+			/* page consumed by skb */
+			buffer_info->page = NULL;
+		} else if (xdp_res & E1000_XDP_TX) {
+			xdp_xmit |= xdp_res;
+			total_rx_bytes += length - crc_len;
+			total_rx_packets++;
+			/* page consumed by XDP TX */
+			buffer_info->page = NULL;
+		} else {
+			/* XDP_DROP / XDP_ABORTED - recycle page */
+			page_pool_put_full_page(adapter->page_pool,
+						buffer_info->page, true);
+			buffer_info->page = NULL;
+		}
+
+next_desc:
+		rx_desc->wb.upper.status_error &= cpu_to_le32(~0xFF);
+
+		if (cleaned_count >= E1000_RX_BUFFER_WRITE) {
+			adapter->alloc_rx_buf(rx_ring, cleaned_count,
+					      GFP_ATOMIC);
+			cleaned_count = 0;
+		}
+
+		rx_desc = next_rxd;
+		buffer_info = next_buffer;
+		staterr = le32_to_cpu(rx_desc->wb.upper.status_error);
+	}
+	rx_ring->next_to_clean = i;
+
+	if (xdp_xmit)
+		e1000_finalize_xdp(adapter, xdp_xmit);
+
+	cleaned_count = e1000_desc_unused(rx_ring);
+	if (cleaned_count)
+		adapter->alloc_rx_buf(rx_ring, cleaned_count, GFP_ATOMIC);
+
+	adapter->total_rx_bytes += total_rx_bytes;
+	adapter->total_rx_packets += total_rx_packets;
+	return cleaned;
+}
+
 /**
  * e1000_alloc_rx_buffers_ps - Replace used receive buffers; packet split
  * @rx_ring: Rx descriptor ring
@@ -896,13 +1269,6 @@ static void e1000_alloc_jumbo_rx_buffers(struct e1000_ring *rx_ring,
 	}
 }
 
-static inline void e1000_rx_hash(struct net_device *netdev, __le32 rss,
-				 struct sk_buff *skb)
-{
-	if (netdev->features & NETIF_F_RXHASH)
-		skb_set_hash(skb, le32_to_cpu(rss), PKT_HASH_TYPE_L3);
-}
-
 /**
  * e1000_clean_rx_irq - Send received data up the network stack
  * @rx_ring: Rx descriptor ring
@@ -1075,13 +1441,17 @@ static void e1000_put_txbuf(struct e1000_ring *tx_ring,
 					 buffer_info->length, DMA_TO_DEVICE);
 		buffer_info->dma = 0;
 	}
-	if (buffer_info->skb) {
+	if (buffer_info->type == E1000_TX_BUF_XDP) {
+		xdp_return_frame(buffer_info->xdpf);
+		buffer_info->xdpf = NULL;
+	} else if (buffer_info->skb) {
 		if (drop)
 			dev_kfree_skb_any(buffer_info->skb);
 		else
 			dev_consume_skb_any(buffer_info->skb);
 		buffer_info->skb = NULL;
 	}
+	buffer_info->type = E1000_TX_BUF_SKB;
 	buffer_info->time_stamp = 0;
 }
 
@@ -1242,7 +1612,8 @@ static bool e1000_clean_tx_irq(struct e1000_ring *tx_ring)
 			if (cleaned) {
 				total_tx_packets += buffer_info->segs;
 				total_tx_bytes += buffer_info->bytecount;
-				if (buffer_info->skb) {
+				if (buffer_info->type == E1000_TX_BUF_SKB &&
+				    buffer_info->skb) {
 					bytes_compl += buffer_info->skb->len;
 					pkts_compl++;
 				}
@@ -1696,7 +2067,12 @@ static void e1000_clean_rx_ring(struct e1000_ring *rx_ring)
 		}
 
 		if (buffer_info->page) {
-			put_page(buffer_info->page);
+			if (adapter->page_pool)
+				page_pool_put_full_page(adapter->page_pool,
+							buffer_info->page,
+							false);
+			else
+				put_page(buffer_info->page);
 			buffer_info->page = NULL;
 		}
 
@@ -2350,6 +2726,30 @@ int e1000e_setup_tx_resources(struct e1000_ring *tx_ring)
 	return err;
 }
 
+static int e1000_create_page_pool(struct e1000_adapter *adapter)
+{
+	struct page_pool_params pp_params = {
+		.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+		.pool_size = adapter->rx_ring->count,
+		.nid = NUMA_NO_NODE,
+		.dev = &adapter->pdev->dev,
+		.napi = &adapter->napi,
+		.dma_dir = DMA_FROM_DEVICE,
+		.offset = XDP_PACKET_HEADROOM,
+		.max_len = adapter->rx_buffer_len,
+	};
+
+	adapter->page_pool = page_pool_create(&pp_params);
+	if (IS_ERR(adapter->page_pool)) {
+		int err = PTR_ERR(adapter->page_pool);
+
+		adapter->page_pool = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
 /**
  * e1000e_setup_rx_resources - allocate Rx resources (Descriptors)
  * @rx_ring: Rx descriptor ring
@@ -2389,8 +2789,31 @@ int e1000e_setup_rx_resources(struct e1000_ring *rx_ring)
 	rx_ring->next_to_use = 0;
 	rx_ring->rx_skb_top = NULL;
 
+	/* XDP RX-queue info */
+	if (xdp_rxq_info_is_reg(&adapter->xdp_rxq))
+		xdp_rxq_info_unreg(&adapter->xdp_rxq);
+
+	err = e1000_create_page_pool(adapter);
+	if (err)
+		goto err_pages;
+
+	err = xdp_rxq_info_reg(&adapter->xdp_rxq, adapter->netdev, 0,
+			       adapter->napi.napi_id);
+	if (err)
+		goto err_page_pool;
+	err = xdp_rxq_info_reg_mem_model(&adapter->xdp_rxq,
+					 MEM_TYPE_PAGE_POOL,
+					  adapter->page_pool);
+	if (err) {
+		xdp_rxq_info_unreg(&adapter->xdp_rxq);
+		goto err_page_pool;
+	}
+
 	return 0;
 
+err_page_pool:
+	page_pool_destroy(adapter->page_pool);
+	adapter->page_pool = NULL;
 err_pages:
 	for (i = 0; i < rx_ring->count; i++) {
 		buffer_info = &rx_ring->buffer_info[i];
@@ -2463,6 +2886,14 @@ void e1000e_free_rx_resources(struct e1000_ring *rx_ring)
 
 	e1000_clean_rx_ring(rx_ring);
 
+	if (xdp_rxq_info_is_reg(&adapter->xdp_rxq))
+		xdp_rxq_info_unreg(&adapter->xdp_rxq);
+
+	if (adapter->page_pool) {
+		page_pool_destroy(adapter->page_pool);
+		adapter->page_pool = NULL;
+	}
+
 	for (i = 0; i < rx_ring->count; i++)
 		kfree(rx_ring->buffer_info[i].ps_pages);
 
@@ -3185,7 +3616,11 @@ static void e1000_configure_rx(struct e1000_adapter *adapter)
 	u64 rdba;
 	u32 rdlen, rctl, rxcsum, ctrl_ext;
 
-	if (adapter->rx_ps_pages) {
+	if (adapter->xdp_prog) {
+		rdlen = rx_ring->count * sizeof(union e1000_rx_desc_extended);
+		adapter->clean_rx = e1000_clean_rx_irq_xdp;
+		adapter->alloc_rx_buf = e1000_alloc_rx_buffers_xdp;
+	} else if (adapter->rx_ps_pages) {
 		/* this is a 32 byte descriptor */
 		rdlen = rx_ring->count *
 		    sizeof(union e1000_rx_desc_packet_split);
@@ -6049,6 +6484,12 @@ static int e1000_change_mtu(struct net_device *netdev, int new_mtu)
 		return -EINVAL;
 	}
 
+	/* XDP requires standard MTU */
+	if (adapter->xdp_prog && new_mtu > ETH_DATA_LEN) {
+		e_err("Jumbo Frames not supported while XDP program is active.\n");
+		return -EINVAL;
+	}
+
 	/* Jumbo frame workaround on 82579 and newer requires CRC be stripped */
 	if ((adapter->hw.mac.type >= e1000_pch2lan) &&
 	    !(adapter->flags2 & FLAG2_CRC_STRIPPING) &&
@@ -7331,6 +7772,71 @@ static int e1000_set_features(struct net_device *netdev,
 	return 1;
 }
 
+/**
+ * e1000_xdp_setup - add/remove an XDP program
+ * @netdev: network interface device structure
+ * @bpf: XDP program setup structure
+ **/
+static int e1000_xdp_setup(struct net_device *netdev, struct netdev_bpf *bpf)
+{
+	struct e1000_adapter *adapter = netdev_priv(netdev);
+	struct bpf_prog *prog = bpf->prog, *old_prog;
+	bool running = netif_running(netdev);
+	bool need_reset;
+
+	/* XDP is incompatible with jumbo frames */
+	if (prog && netdev->mtu > ETH_DATA_LEN) {
+		NL_SET_ERR_MSG_MOD(bpf->extack,
+				   "XDP is not supported with jumbo frames");
+		return -EINVAL;
+	}
+
+	/* Validate frame fits in a single page with XDP headroom */
+	if (prog && netdev->mtu + VLAN_ETH_HLEN + ETH_FCS_LEN +
+	    XDP_PACKET_HEADROOM > PAGE_SIZE) {
+		NL_SET_ERR_MSG_MOD(bpf->extack,
+				   "Frame size too large for XDP");
+		return -EINVAL;
+	}
+
+	old_prog = xchg(&adapter->xdp_prog, prog);
+	need_reset = (!!prog != !!old_prog);
+
+	/* Transition between XDP and non-XDP requires ring reconfiguration */
+	if (need_reset && running)
+		e1000e_close(netdev);
+
+	if (old_prog)
+		bpf_prog_put(old_prog);
+
+	if (!need_reset)
+		return 0;
+
+	if (running) {
+		int err = e1000e_open(netdev);
+
+		if (err) {
+			/* Remove the XDP program since interface is down */
+			xchg(&adapter->xdp_prog, NULL);
+			if (prog)
+				bpf_prog_put(prog);
+			return err;
+		}
+	}
+
+	return 0;
+}
+
+static int e1000_xdp(struct net_device *netdev, struct netdev_bpf *xdp)
+{
+	switch (xdp->command) {
+	case XDP_SETUP_PROG:
+		return e1000_xdp_setup(netdev, xdp);
+	default:
+		return -EINVAL;
+	}
+}
+
 static const struct net_device_ops e1000e_netdev_ops = {
 	.ndo_open		= e1000e_open,
 	.ndo_stop		= e1000e_close,
@@ -7353,6 +7859,7 @@ static const struct net_device_ops e1000e_netdev_ops = {
 	.ndo_features_check	= passthru_features_check,
 	.ndo_hwtstamp_get	= e1000e_hwtstamp_get,
 	.ndo_hwtstamp_set	= e1000e_hwtstamp_set,
+	.ndo_bpf		= e1000_xdp,
 };
 
 /**
@@ -7563,6 +8070,8 @@ static int e1000_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 	netdev->max_mtu = adapter->max_hw_frame_size -
 			  (VLAN_ETH_HLEN + ETH_FCS_LEN);
 
+	netdev->xdp_features = NETDEV_XDP_ACT_BASIC;
+
 	if (e1000e_enable_mng_pass_thru(&adapter->hw))
 		adapter->flags |= FLAG_MNG_PT_ENABLED;
 
@@ -7776,6 +8285,8 @@ static void e1000_remove(struct pci_dev *pdev)
 	e1000e_release_hw_control(adapter);
 
 	e1000e_reset_interrupt_capability(adapter);
+	if (adapter->xdp_prog)
+		bpf_prog_put(adapter->xdp_prog);
 	kfree(adapter->tx_ring);
 	kfree(adapter->rx_ring);
 
-- 
2.53.0


