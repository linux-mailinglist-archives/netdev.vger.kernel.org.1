Return-Path: <netdev+bounces-192900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DB4D9AC18C9
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 02:00:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3A2C1C06918
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 00:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39BD2D4B6E;
	Thu, 22 May 2025 23:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sU6U1C0I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A3E24DCEA
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 23:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747958273; cv=none; b=pgs57HmmWJNT7ec9tUUMisQ84VZNhmvIm4ncyodYYjJoYKOls2143PnUJ0Qi4u7wJUtIaNOOx1ucQK9qpag3XFH3LlKVRYxJvnr2iKWFdCjOZhtER5AYTukdchFMgaYv6AlT15r1zvw8FE5stPlExWOShddYpH0X9yEdghgX4Og=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747958273; c=relaxed/simple;
	bh=yBhOfv7eu2/XqSrNXehEo+4lpPVO30A19mzFnjwsSpY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=d/Z23jkYUQW85/Dqxrq4L9oBM4S3FpQUz0IhzbZ+vmRaZwd2XTJOKsUVgBf+3kxnhfXfWNpHsypJlE4GyJMGTFZjiLL2J3wkjy0I8YlXy8kH37Rb+T6w3UiEXuKedUMEamlO6ZZ2tb7Ql6xQ/20vP9+Lz5m6dZYcNIUavb7NViU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sU6U1C0I; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-310e7c24158so418409a91.3
        for <netdev@vger.kernel.org>; Thu, 22 May 2025 16:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1747958271; x=1748563071; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uEHW4PYDNmFipk6wLuYuCvPhqaUjcYJlMloM7o1AYLs=;
        b=sU6U1C0IBPppYtD4pRzZrKWdWlrnOsDxyvxE2nP48TcQN9y5rgcqAgW5p/02p5S9VD
         vCtFerTXRQL5geJ2X5iNf3xjV69SLQwpvk/yWiwRaLiCbY/1nkRe4RxXVeh0MxG9OZ0I
         +Y5JFseh3xHzuHyvSmtrP57EcXIA+6Us/YThgJdACyet5NvmjwRRJL2Bkdse2Bb/8wNf
         rs+OQHlLgEFDGDfr3pi+6LApEi+TyAvhfBYh7pUBBcMhayITiyNStRvGFj9v6yYo+Ozs
         OzYqB+ZBkJe0aU1EVZkhhT2Nowpxhv1WBsMNxm++o9HwDBM5ggBi8IeenCDlkx267WW1
         YKBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747958271; x=1748563071;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uEHW4PYDNmFipk6wLuYuCvPhqaUjcYJlMloM7o1AYLs=;
        b=RcbBIxcw/mGOPPvoWaIEpICwlWZJu/cHPuWoShxqAEeaMe1Z+tOQwhLd15fk6DMaEN
         lmj2KpcvGYiqBZiPkBtpUqZayrJBoHdKdAmf1eJ/025300fyDfBEGeavUkkc7jD5cVdx
         lWl2JbaS0mZHE6laJTmOK8QI5TzEepaew4Nsrhy3vpHa28U/i9b8nGy2u3bjpp7DAFRm
         YIMXmTMTuwCm7e3+GK9wRym10iTA5DlbtBzJCFgdv8r51sJaZQ+eSuHQPCrEiYobL5x+
         aigzys4wbfrgxYdIrXb3RAI9Zcc6cHI57L/jh21Y7KnqP1x0QDQF3RaaaZvDIRJV78k0
         tC+Q==
X-Gm-Message-State: AOJu0YyDKiDnNeYuFt6lZYHB7FxtL5biOmyovUntcsBz3u63fu9zkvg0
	X2JLeghNBdIGVq19w372ZF5K7L8P3Ee9M8m6ujAzLsXGC28dKD1mPky2YeUlq5G86uH+py+gAws
	LxulBnT4m8m6KyohGFMxNLkcqn1j4BQaowovaQwaxnwYYGs93P6aa6VZVdg71eyrKszp9QQ3c07
	p1REjgDffhOOnrEu1+aOj9NW5UpJlXnEH8Iv6P5GC+N5bhRvgL3TZh1By1itBysPc=
X-Google-Smtp-Source: AGHT+IFN1tFabWhABotg5f5D5MqfR1osrSXCCv6rzoIhra/MHMAM9QSreyv/qqkqk3+zrQwoF0BdaOHkErrCls8YWQ==
X-Received: from pjj13.prod.google.com ([2002:a17:90b:554d:b0:2fc:11a0:c549])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4acf:b0:2ee:aa28:79aa with SMTP id 98e67ed59e1d1-30e830c772dmr35441433a91.6.1747958271209;
 Thu, 22 May 2025 16:57:51 -0700 (PDT)
Date: Thu, 22 May 2025 23:57:36 +0000
In-Reply-To: <20250522235737.1925605-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250522235737.1925605-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
Message-ID: <20250522235737.1925605-8-hramamurthy@google.com>
Subject: [PATCH net-next v3 7/8] gve: Implement ndo_hwtstamp_get/set for RX timestamping
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, jeroendb@google.com, hramamurthy@google.com, 
	andrew+netdev@lunn.ch, willemb@google.com, ziweixiao@google.com, 
	pkaligineedi@google.com, yyd@google.com, joshwash@google.com, 
	shailend@google.com, linux@treblig.org, thostet@google.com, 
	jfraker@google.com, richardcochran@gmail.com, jdamato@fastly.com, 
	vadim.fedorenko@linux.dev, horms@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: John Fraker <jfraker@google.com>

Implement ndo_hwtstamp_get/set to enable hardware RX timestamping,
providing support for SIOC[SG]HWTSTAMP IOCTLs. Included with this support
is the small change necessary to read the rx timestamp out of the rx
descriptor, now that timestamps start being enabled. The gve clock is
only used for hardware timestamps, so started when timestamps are
requested and stopped when not needed.

This version only supports RX hardware timestamping with the rx filter
HWTSTAMP_FILTER_ALL. If the user attempts to configure a more
restrictive filter, the filter will be set to HWTSTAMP_FILTER_ALL in the
returned structure.

Signed-off-by: John Fraker <jfraker@google.com>
Signed-off-by: Ziwei Xiao <ziweixiao@google.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Harshitha Ramamurthy <hramamurthy@google.com>
---
 Changes in v3:
 - Update the title and commit message to show it's adding support for
   ndo functions instead of ioctls (Jakub Kicinski)
 - Utilize extack for error logging instead of dev_err (Jakub Kicinski)
---
 drivers/net/ethernet/google/gve/gve.h         |  2 +
 .../net/ethernet/google/gve/gve_desc_dqo.h    |  3 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 47 +++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  5 +-
 4 files changed, 55 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 97054b272e40..a812612c52ba 100644
--- a/drivers/net/ethernet/google/gve/gve.h
+++ b/drivers/net/ethernet/google/gve/gve.h
@@ -11,6 +11,7 @@
 #include <linux/dmapool.h>
 #include <linux/ethtool_netlink.h>
 #include <linux/netdevice.h>
+#include <linux/net_tstamp.h>
 #include <linux/pci.h>
 #include <linux/ptp_clock_kernel.h>
 #include <linux/u64_stats_sync.h>
@@ -882,6 +883,7 @@ struct gve_priv {
 	/* True if the device supports reading the nic clock */
 	bool nic_timestamp_supported;
 	struct gve_ptp *ptp;
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
index e1ffbd561fac..853e236f024a 100644
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
+		NL_SET_ERR_MSG_MOD(extack, "TX timestamping is not supported");
+		return -ERANGE;
+	}
+
+	if (kernel_config->rx_filter != HWTSTAMP_FILTER_NONE) {
+		kernel_config->rx_filter = HWTSTAMP_FILTER_ALL;
+		if (!priv->nic_ts_report) {
+			err = gve_init_clock(priv);
+			if (err) {
+				NL_SET_ERR_MSG_MOD(extack,
+						   "Failed to initialize GVE clock");
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
index 9aadf8435f8b..0be41a0cdd15 100644
--- a/drivers/net/ethernet/google/gve/gve_rx_dqo.c
+++ b/drivers/net/ethernet/google/gve/gve_rx_dqo.c
@@ -450,7 +450,7 @@ static void gve_rx_skb_hash(struct sk_buff *skb,
  * Note that this means if the time delta between packet reception and the last
  * clock read is greater than ~2 seconds, this will provide invalid results.
  */
-static void __maybe_unused gve_rx_skb_hwtstamp(struct gve_rx_ring *rx, u32 hwts)
+static void gve_rx_skb_hwtstamp(struct gve_rx_ring *rx, u32 hwts)
 {
 	u64 last_read = READ_ONCE(rx->gve->last_sync_nic_counter);
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
2.49.0.1143.g0be31eac6b-goog


