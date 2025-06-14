Return-Path: <netdev+bounces-197680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88EDAAD98F2
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 02:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB4F3BEB80
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 00:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B84E1552FA;
	Sat, 14 Jun 2025 00:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="d14VHIaU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7197C1527B4
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 00:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749859697; cv=none; b=DxtIJhHs+DiPPsvAtuoCr9O2wCYCA3NYW6St0H6mA9po8QtfGDqfnIGsH7t9rQx2HatLsTrykh4h2q4kAjAiiHvdPx3txj5EWNw5/APPckPtANz9mkTAWzebljzkpT8JPdti5YxiiTEQ5ddbKCvKKpraOP9qHBvtOuYU4AzpUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749859697; c=relaxed/simple;
	bh=EQK3/tVjNNDYeAyjzrgQfnPzAGBy80Ah+dNcW93p/UA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CEx4CZktCjDvwroLieL9Z7B0AOfOQhUJNxFyZkmjRCZreox0Tx8pzm8pkkavZ5qGeq1fTCKOL+5nl6qlq0UpTMQmKtcVs/USR4qVwU/lp2u7gKGaGOqI01QoFcSL0185la3RBbD8jEAT0bKgZq38pTMeqbrBs6P1pqAi0wMS7F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=d14VHIaU; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-747dd44048cso2405347b3a.3
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1749859695; x=1750464495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPr9VjvadtEs9339VHOUsV2V/j2hqIq22xXAScQhOxY=;
        b=d14VHIaUgIjaXQSqnrtXWSrOq5aII1mlAQdQeq1xHaC02mubUw+2rmfkhAF0PP5S5k
         ttEbladQP1iXR9ZwRiWikixtCVUjj6jU5RHc9YXnjq+sWyLJXqzLLCuf1q2mpbO+LFKp
         bgGCsfe/IfK8YPtvml0T0pJV9bGdrFahCB+QnaPCsE7CZmmzUPxydRxSG1FiMDqaAT7s
         0d8kq2PVbRIGXQIsovcYBIqgqxSND9m8Q+GK0HPoDiHBmjlUfFiwjYCXoy4NbZtjB628
         DZGmlWfq1tbCAyqAQnQOH6oufFRM+IqKc52C2IBoQGuGwRfZ2t9SsbkyiQXFGcD3EoF+
         LfRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749859695; x=1750464495;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPr9VjvadtEs9339VHOUsV2V/j2hqIq22xXAScQhOxY=;
        b=OJT6OHvV9gWzfNal0YmjuKtb1TTaooSAvQPtlSGed3aW53pNbb4U9sH232w1nf9+nz
         bzGltPJjp0xtuSnGRfWtQtFMNJHBljzycoc+X87vAj1ANSDWWwSuwweIScxUxIdWGVY7
         vcOyojMaaH51Uirsf35gICjbwZslgl7JpSpB/738+JehpnD848HMu5GaarlCnYawjQEE
         VKWb8GZ8trwCyGCcKCt0eGhjyT9anx2QZxY8n9O00J5j8TfR9iN36JqRsw7eEkTVnJXV
         T+ATrKuXWR8fkIv+vp7U/kEN1oMDycnvGJaxJ78zMeksSnY5Fips/pBm44wueCFeIyGr
         zC0Q==
X-Gm-Message-State: AOJu0YzcgbPcDSTIzBYmAcSUN/NVwpCofAwWVWO6PNsbutvYH8Be2cXE
	dJQX1EQkT+zCumWH8SE2vCOSg5mPIaHEsNrlVucmbwkIDLpCql11JjPgypO88Z9yz8efX4C/hx6
	MBFa70iDf1rHKh5ENUP8S3iFOdse4Z13E1AlNhDXV+9RCUV0FIVyTZeFp+uGZZv5N6YJeaw4YpD
	kDLakHvqDHE1Cu80jhx8442SP2v/2GIoK/FYyq+S2Uboa+EglO2R9j1XDse6xciuM=
X-Google-Smtp-Source: AGHT+IFetTlh5BYHg8AgVOPUCNwrqc5YM/rhO3Ou3VJ0DriTDP2fyYKqS3lEUw7KiUyXe+48P6WtswONb8fxOViL4w==
X-Received: from pfee1.prod.google.com ([2002:a05:6a00:bc81:b0:746:25af:51c4])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:244f:b0:746:2591:e531 with SMTP id d2e1a72fcca58-7489cfffc62mr1523220b3a.12.1749859694394;
 Fri, 13 Jun 2025 17:08:14 -0700 (PDT)
Date: Sat, 14 Jun 2025 00:07:53 +0000
In-Reply-To: <20250614000754.164827-1-hramamurthy@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250614000754.164827-1-hramamurthy@google.com>
X-Mailer: git-send-email 2.50.0.rc1.591.g9c95f17f64-goog
Message-ID: <20250614000754.164827-8-hramamurthy@google.com>
Subject: [PATCH net-next v5 7/8] gve: Implement ndo_hwtstamp_get/set for RX timestamping
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
 Changes in v5:
  - Utilize ptp_cancel_worker_sync instead of unregistering the PHC
    every time when rx timestamping is disabled. (Jakub Kicinski)
  - Add gve_clock_nic_ts_read before the ptp_schedule_worker to do
    the first refresh. (Jakub Kicinski)

 Changes in v3:
 - Update the title and commit message to show it's adding support for
   ndo functions instead of ioctls (Jakub Kicinski)
 - Utilize extack for error logging instead of dev_err (Jakub Kicinski)
---
 drivers/net/ethernet/google/gve/gve.h         |  2 +
 .../net/ethernet/google/gve/gve_desc_dqo.h    |  3 +-
 drivers/net/ethernet/google/gve/gve_main.c    | 46 +++++++++++++++++++
 drivers/net/ethernet/google/gve/gve_rx_dqo.c  |  5 +-
 4 files changed, 54 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
index 527e17da60bc..be4b5791c245 100644
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
index bc2f36962ee8..7fff1409b121 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -727,6 +727,7 @@ static void gve_teardown_device_resources(struct gve_priv *priv)
 	gve_free_counter_array(priv);
 	gve_free_notify_blocks(priv);
 	gve_free_stats_report(priv);
+	gve_teardown_clock(priv);
 	gve_clear_device_resources_ok(priv);
 }
 
@@ -2047,6 +2048,46 @@ static int gve_set_features(struct net_device *netdev,
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
+
+	if (kernel_config->tx_type != HWTSTAMP_TX_OFF) {
+		NL_SET_ERR_MSG_MOD(extack, "TX timestamping is not supported");
+		return -ERANGE;
+	}
+
+	if (kernel_config->rx_filter != HWTSTAMP_FILTER_NONE) {
+		if (!priv->nic_ts_report) {
+			NL_SET_ERR_MSG_MOD(extack,
+					   "RX timestamping is not supported");
+			kernel_config->rx_filter = HWTSTAMP_FILTER_NONE;
+			return -EOPNOTSUPP;
+		}
+
+		kernel_config->rx_filter = HWTSTAMP_FILTER_ALL;
+		gve_clock_nic_ts_read(priv);
+		ptp_schedule_worker(priv->ptp->clock, 0);
+	} else {
+		ptp_cancel_worker_sync(priv->ptp->clock);
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
@@ -2058,6 +2099,8 @@ static const struct net_device_ops gve_netdev_ops = {
 	.ndo_bpf		=	gve_xdp,
 	.ndo_xdp_xmit		=	gve_xdp_xmit,
 	.ndo_xsk_wakeup		=	gve_xsk_wakeup,
+	.ndo_hwtstamp_get	=	gve_get_ts_config,
+	.ndo_hwtstamp_set	=	gve_set_ts_config,
 };
 
 static void gve_handle_status(struct gve_priv *priv, u32 status)
@@ -2277,6 +2320,9 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
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
2.50.0.rc1.591.g9c95f17f64-goog


