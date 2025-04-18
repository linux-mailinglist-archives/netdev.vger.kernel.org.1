Return-Path: <netdev+bounces-184245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA66A93FC3
	for <lists+netdev@lfdr.de>; Sat, 19 Apr 2025 00:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D68E173D4B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4F32550C2;
	Fri, 18 Apr 2025 22:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kdEG33ff"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B0E253F31
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 22:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745014387; cv=none; b=kbuVOeLvRZeq9tAqA1Y4ijk/w+RyudpAkUb5VY3ul31srGjGBguUVZ/ivB6LZSsO1IA4hlnukqzfO7Mbgvh1T1KWUwtI0VwO4M3HDzP5kxkUMYSotFq4dl59XXo8FAQlFw3ZfS6URkPvarVXtqGIpgq74YYObNFCwVGHYQRxl4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745014387; c=relaxed/simple;
	bh=HbTA6+SIWtsx6p8fLoWBzXpmBqT7XUqskQU9DuFh/FE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cHKgrPv6/GbVMni4zB4zSsiNEzklt/mXmd3p6vnTUC/P9Xwj3z7m1E+UuoPp2Tbu18vOor71WlyszKVD06DdQuVqIlRxPgPmWO1AjK+ZMNcPS9ZVDfGxNmPaoG85GU3Rn5fP7KyNqdO3pCQFsjhXgzAw7MwpxAevzr8r64GI91g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kdEG33ff; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af98c8021b5so2212394a12.2
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 15:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745014385; x=1745619185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=0EmA7Upz+qHOtDwczVN9FS7m8URUS9IO0+ID1IaGMNU=;
        b=kdEG33ff3qAaumC965pp+Lt8yohfxsFWjDErOuX6Z1mGNjvDIWzgqlsIUckqVTJu+v
         /4W5NMjweWkAzSkRzLO7AbVLu+vvaUcL/TjvXU0udPT6uBpfvB0WFUeSmgpX482dfVXv
         CYUW3HJwnAygsBZ4eXgLo0/3jQP5E3ZShFjQSM78VCCGZmDusrzyFpTBEYMxA+d39k9q
         yU8v9u9MTFAxjo3hCtxhPLSzS4+I4mZwXuRvU/OWDg3HnNEgZ4fu1k9blgcSE3YwXKwW
         gpILSeFYySKJ7GUJcGXAPpPkvUbd0yVGV1IMvqtVA1WtqyDlLUcnuM8sXR1GUZa8l7zv
         vs+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745014385; x=1745619185;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0EmA7Upz+qHOtDwczVN9FS7m8URUS9IO0+ID1IaGMNU=;
        b=ctIrESQWHioAcIeVSpmUogXF0HNzg+WFkdo9glFCqzsWZDC7FHxfvjE5NRXod1qkiH
         HnCeXr3Q2oAkwkbYx+ZTVZen8McVpCWKt4cwCGNFl0bp4eYz/GjmVOTK4Cxd8HtRYMeI
         0Aw0GKT+ryESRzCKvLlCjQLvi5wfCa/cj3r1PzNdEaUW6UCv6360i4/1t1SCl3D9BlqH
         RU/1RDmjCy+7rQYNlCq0fBIwmXmEBPplUQacAm7Sgf8IrmEww3VG6jkXV87J4zkEoGen
         zj0L0QAYQUjQxA36GxQiJusx2FPA3+xhujzRySw0Kr8amzAv0JNbYuIN6gC8wZTwsK1D
         SNKg==
X-Gm-Message-State: AOJu0YzwDqFWJ7kEYCBTXz34E1csn0Et15e5+e6qHTEl8Ae9b1xhF8iI
	nVv4YCAQg1iJApXnDsSW6gyZ58H4HoNOiSpQGvADPsoHUEqy2zkU0EdPIc8kEIVOWJy71JVL5Uz
	/kBzhIsBTQi8NLXIcVZq2ovYT9dAg13oqLcd3Gnqb/4R7PW8KxXicERgKmSoR3GQUuamG/Q2WOD
	+Zf6sb8rNRTuK9OTB3btOI49jChpKqEyythf4F7tDmESMGrcw0oi+H9tXEYj4=
X-Google-Smtp-Source: AGHT+IHeFwo6XZSRpHYdFnZUzLtRwDr2aNE4i+vS4FNv6MPSU+02tuDYkNMd44kkWhE2mPSdgmGVyfYVsz1iFPhVSA==
X-Received: from pjbkk11.prod.google.com ([2002:a17:90b:4a0b:b0:308:87dc:aa52])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:903:2383:b0:21f:1549:a55a with SMTP id d9443c01a7336-22c5357a0femr67001545ad.1.1745014385253;
 Fri, 18 Apr 2025 15:13:05 -0700 (PDT)
Date: Fri, 18 Apr 2025 22:12:53 +0000
In-Reply-To: <20250418221254.112433-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250418221254.112433-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.805.g082f7c87e0-goog
Message-ID: <20250418221254.112433-6-hramamurthy@google.com>
Subject: [PATCH net-next 5/6] gve: Add support for SIOC[GS]HWTSTAMP IOCTLs
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: John Fraker <jfraker@google.com>

Add support for the SIOCSHWTSTAMP and SIOCGHWTSTAMP IOCTL methods using
gve_get_ts_config and gve_set_ts_config. Included with this support is
the small change necessary to read the rx timestamp out of the rx
descriptor, now that timestamps start being enabled. The gve clock is
only used for hardware timestamps, so started when timestamps are
requested and stopped when not needed.

This version only supports RX hardware timestamping with the rx filter
HWTSTAMP_FILTER_ALL. If the user attempts to configure a more
restrictive filter, the filter will be set to HWTSTAMP_FILTER_ALL in the
returned structure.

Co-developed-by: Ziwei Xiao <ziweixiao@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: John Fraker <jfraker@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 drivers/net/ethernet/google/gve/gve.h         |  2 +
 .../net/ethernet/google/gve/gve_desc_dqo.h    |  3 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 47 +++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  5 +-
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 5a141a8735d6..adf5117f5087 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -11,6 +11,7 @@
 #include <linux/dmapool.h>
 #include <linux/ethtool_netlink.h>
 #include <linux/netdevice.h>
+#include <linux/net_tstamp.h>
 #include <linux/pci.h>
 #include <linux/u64_stats_sync.h>
 #include <net/page_pool/helpers.h>
@@ -876,6 +877,7 @@ struct gve_priv {
 	struct workqueue_struct *gve_ts_wq;
 	bool nic_timestamp_supported;
 	struct delayed_work nic_ts_sync_task;
+	struct kernel_hwtstamp_config ts_config;
 	struct gve_nic_ts_report *nic_ts_report;
 	dma_addr_t nic_ts_report_bus;
 	u64 last_sync_nic_counter; /* Clock counter from last NIC TS report */
diff --git a/drivers/net/ethernet/google/gve/gve_desc_dqo.h b/drivers/net/ethernet/google/gve/gve_desc_dqo.h
index f79cd0591110..d17da841b5a0 100644
--- a/drivers/net/ethernet/google/gve/gve_desc_dqo.h
+++ b/drivers/net/ethernet/google/gve/gve_desc_dqo.h
@@ -247,7 +247,8 @@ struct gve_rx_compl_desc_dqo {
 	};
 	__le32 hash;
 	__le32 reserved6;
-	__le64 reserved7;
+	__le32 reserved7;
+	__le32 ts; /* timestamp in nanosecs */
 } __packed;
 
 static_assert(sizeof(struct gve_rx_compl_desc_dqo) == 32);
diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 8aaac9101377..36d91eb004c3 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -721,6 +721,7 @@ static void gve_teardown_device_resources(struct gve_priv *priv)
 	gve_free_counter_array(priv);
 	gve_free_notify_blocks(priv);
 	gve_free_stats_report(priv);
+	gve_teardown_clock(priv);
 	gve_clear_device_resources_ok(priv);
 }
 
@@ -2041,6 +2042,47 @@ static int gve_set_features(struct net_device *netdev,
 	return err;
 }
 
+static int gve_get_ts_config(struct net_device *dev,
+			     struct kernel_hwtstamp_config *kernel_config)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+
+	*kernel_config = priv->ts_config;
+	return 0;
+}
+
+static int gve_set_ts_config(struct net_device *dev,
+			     struct kernel_hwtstamp_config *kernel_config,
+			     struct netlink_ext_ack *extack)
+{
+	struct gve_priv *priv = netdev_priv(dev);
+	int err;
+
+	if (kernel_config->tx_type != HWTSTAMP_TX_OFF) {
+		dev_err(&priv->pdev->dev, "TX timestamping is not supported\n");
+		return -ERANGE;
+	}
+
+	if (kernel_config->rx_filter != HWTSTAMP_FILTER_NONE) {
+		kernel_config->rx_filter = HWTSTAMP_FILTER_ALL;
+		if (!priv->nic_ts_report) {
+			err = gve_init_clock(priv);
+			if (err) {
+				dev_err(&priv->pdev->dev,
+					"Failed to initialize GVE clock\n");
+				kernel_config->rx_filter = HWTSTAMP_FILTER_NONE;
+				return err;
+			}
+		}
+	} else {
+		gve_teardown_clock(priv);
+	}
+
+	priv->ts_config.rx_filter = kernel_config->rx_filter;
+
+	return 0;
+}
+
 static const struct net_device_ops gve_netdev_ops = {
 	.ndo_start_xmit		=	gve_start_xmit,
 	.ndo_features_check	=	gve_features_check,
@@ -2052,6 +2094,8 @@ static const struct net_device_ops gve_netdev_ops = {
 	.ndo_bpf		=	gve_xdp,
 	.ndo_xdp_xmit		=	gve_xdp_xmit,
 	.ndo_xsk_wakeup		=	gve_xsk_wakeup,
+	.ndo_hwtstamp_get	=	gve_get_ts_config,
+	.ndo_hwtstamp_set	=	gve_set_ts_config,
 };
 
 static void gve_handle_status(struct gve_priv *priv, u32 status)
@@ -2271,6 +2315,9 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
 		priv->rx_coalesce_usecs = GVE_RX_IRQ_RATELIMIT_US_DQO;
 	}
 
+	priv->ts_config.tx_type = HWTSTAMP_TX_OFF;
+	priv->ts_config.rx_filter = HWTSTAMP_FILTER_NONE;
+
 setup_device:
 	gve_set_netdev_xdp_features(priv);
 	err = gve_setup_device_resources(priv);
diff --git a/drivers/net/ethernet/google/gve/gve_rx_dqo.c b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
index 483d188d33ab..bad9e15cb934 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -450,7 +450,7 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
  * Note that this means if the time delta between packet reception and the last
  * clock read is greater than ~2 seconds, this will provide invalid results.
  */
-static void __maybe_unused gve_rx_skb_hwtstamp(struct gve_rx_ring *rx, u32 hwts)
+static void gve_rx_skb_hwtstamp(struct gve_rx_ring *rx, u32 hwts)
 {
 	s64 last_read = rx->gve->last_sync_nic_counter;
 	struct sk_buff *skb = rx->ctx.skb_head;
@@ -790,6 +790,9 @@ static int gve_rx_complete_skb(struct gve_rx_ring *rx, struct napi_struct *napi,
 	if (feat & NETIF_F_RXCSUM)
 		gve_rx_skb_csum(rx->ctx.skb_head, desc, ptype);
 
+	if (rx->gve->ts_config.rx_filter == HWTSTAMP_FILTER_ALL)
+		gve_rx_skb_hwtstamp(rx, le32_to_cpu(desc->ts));
+
 	/* RSC packets must set gso_size otherwise the TCP stack will complain
 	 * that packets are larger than MTU.
 	 */
-- 
2.49.0.805.g082f7c87e0-goog


