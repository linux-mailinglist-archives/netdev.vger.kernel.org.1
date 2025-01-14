Return-Path: <netdev+bounces-158148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 67139A10959
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69A1718879CD
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 534A6146D55;
	Tue, 14 Jan 2025 14:30:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jPPh6gsh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2B141C94;
	Tue, 14 Jan 2025 14:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865050; cv=none; b=SjRd8ePgI6ZlILCTFEbaRVyvbVkA4vsSXMV1QBfSDkC29TFObcrQ2HNjevqcuZ4zpXE2SycmM9p9oHEB399ym/ljlDdDCiWgcz30FAEXdazMuWw8+eIs1l8YK+E93cbJH1hCGRNvlL36Ih/gGdEFGblxwVVOZAFXE1ubZ5uolTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865050; c=relaxed/simple;
	bh=oOB7HKtxl6QmCAq8bPzGbVc17RCOUI2Sl+ygJjUnoKI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LPf2lTKncauwCOydzyuPP8Ea+Akq5VQjTLrDGhZY2EbHh1tDVtgCwR7fiAjAp8ATY1L9jKTU96lqIJf7EkoLVI97mHlRpV3vrig0h+9uJ23bkramDPB/STojFOtdPvZk0NdBFKlzhCpNVX20jBq7DpJ6rhPHVcaZ7/fWWrfSp1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jPPh6gsh; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2167141dfa1so97934135ad.1;
        Tue, 14 Jan 2025 06:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736865048; x=1737469848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vhVCWNrslkm6iZIefrpS3RD/DxTmVQixP75EKnHEJTk=;
        b=jPPh6gshjnWNB6nyeycPzZT+cePeUI9Irm2/+e/IUS9eHcxkh9ftjsBNj4itbaCmad
         TyLyokCg8NJl2DMUwfiC0p6pWUKmY8A5K0lP3/7+5UPrOW3WwUXAB52FskjseK6MCNCM
         7C5v4Ho4Ra+6WYF04Z3tJ7QkknEc6aWGwgdT3BmuPm7L17EllhPioK0HM3ByOM2+Dj71
         yxHi+5Wh4M0QoJGaX/Zfl7tN2FY2cl+q7nqJYxnytbUzhhBiZX0cBmrLhwrhAndVu4g1
         tN8QInmPIbuIsfPPnmVCefMt2uR2V+a4myppgxDP1iI+ChXbqS18i5J6t1xSFBH5aAqW
         hwHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736865048; x=1737469848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vhVCWNrslkm6iZIefrpS3RD/DxTmVQixP75EKnHEJTk=;
        b=H4PBuOLM05Pahiy39r+ne4MoNwkm3eTFgOda34n+UHptU/cCUmiXqjRwikB/72eg8f
         VFMQBE+4byxVTNSHXDsjxcZHR3zlBzcGfaUf+Br5pahwn6pSfuP3LniK5ckAJ25f8ygF
         m4ReqWbUwBeN2UiZiriPpF0iZy97jYI6rZBbnxkoinRnwtjHIEPekivQ4k/Es8YJ4FCF
         QqSiygbvnXcLxpMTKwKk2i+sW7kRh1xOcnQMjqdPLcIehyDDlTTAaKCP4OCQk00sMCi3
         01lWfOlLvTcLu0TeocOuDZ5CUMyQMNZxWJa8Fa4AzySEugFhUl0g8gjm8JbfWpo4iXRF
         JrKw==
X-Forwarded-Encrypted: i=1; AJvYcCUaRH0EnvE0KZ9rqsB0Rpy4cVKGbe1VWedmfO7Cxpt6/0nHWv8zFT1yhs8/KbxwDeKTUoKW+fKBlNE=@vger.kernel.org, AJvYcCVEDRikDHN6WyN8Y/wawm3H+xLd6Mkl/qdzp5KwFTI2fVOZtdLXWFkXDD3r66ztzsYPhxPdck8B@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5Crlmy3VIE9zh8vKKK+B2G9674g7tUpDNCsnpg2Rur3rAl0BS
	p3wwEFlyiHJJ1ndz+enGFkMcAQK6eAfxQk0WYPzXMGd/LtxfO+iu
X-Gm-Gg: ASbGnctj7JRTtTwK65jVYj008BiEl0oQNolFLjENtj7jxjnrLMn1QoG+55bwg7MgjyH
	5fhboXg+l12u16/6VtHqoCuH7cYZIspDIphPK1cnZyMNdv1bGxneZ/Ha1xwmGbzO/0K/5Jnh9Tg
	37Cc6TTONAN9cWppXkMG5KlMN7DS29NA1T/DQKqZBFPGKITJKKyBAt46nVh5Wb4fppo/62FJn4C
	2ABBYr2W3cmH8T96ykxUQNWgM5pRG9s3olPluZCJHgnPg==
X-Google-Smtp-Source: AGHT+IEsCQchocuKWGOo5d0GSwKE3iy2BBC2w8Tum2vsnQSqh6An2Nfj/aT9mR7oqQA3eR6tVsH/Iw==
X-Received: by 2002:a05:6a21:8805:b0:1e0:cc01:43da with SMTP id adf61e73a8af0-1e8b0af29b8mr21600280637.0.1736865047913;
        Tue, 14 Jan 2025 06:30:47 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a4dfesm7474582b3a.156.2025.01.14.06.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:30:47 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org,
	almasrymina@google.com,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	andrew+netdev@lunn.ch,
	hawk@kernel.org,
	ilias.apalodimas@linaro.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	dw@davidwei.uk,
	sdf@fomichev.me,
	asml.silence@gmail.com,
	brett.creeley@amd.com,
	linux-doc@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	jiri@resnulli.us,
	bigeasy@linutronix.de,
	lorenzo@kernel.org,
	jdamato@fastly.com,
	aleksander.lobakin@intel.com,
	kaiyuanz@google.com,
	willemb@google.com,
	daniel.zahka@gmail.com,
	ap420073@gmail.com
Subject: [PATCH net-next v9 09/10] netdevsim: add HDS feature
Date: Tue, 14 Jan 2025 14:28:51 +0000
Message-Id: <20250114142852.3364986-10-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250114142852.3364986-1-ap420073@gmail.com>
References: <20250114142852.3364986-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

HDS options(tcp-data-split, hds-thresh) have dependencies between other
features like XDP. Basic dependencies are checked in the core API.
netdevsim is very useful to check basic dependencies.

The default tcp-data-split mode is UNKNOWN but netdevsim driver
returns ENABLED when ethtool dumps tcp-data-split mode.
The default value of HDS threshold is 0 and the maximum value is 1024.

ethtool shows like this.

ethtool -g eni1np1
Ring parameters for eni1np1:
Pre-set maximums:
...
HDS thresh:             1024
Current hardware settings:
...
TCP data split:         on
HDS thresh:             0

ethtool -G eni1np1 tcp-data-split on hds-thresh 1024
ethtool -g eni1np1
Ring parameters for eni1np1:
Pre-set maximums:
...
HDS thresh:             1024
Current hardware settings:
...
TCP data split:         on
HDS thresh:             1024

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v9:
 - Rebase on the top of net-next.

v8:
 - Do not set hds_config and hds_thresh in the nsim_set_ringparam.

v7:
 - Add datapath implementation.
 - Remove kernel_ethtool_ringparam in the struct nsim_ethtool.

v6:
 - Patch added.

 drivers/net/netdevsim/ethtool.c   | 12 +++++++++++-
 drivers/net/netdevsim/netdev.c    |  9 +++++++++
 drivers/net/netdevsim/netdevsim.h |  3 +++
 3 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 5fe1eaef99b5..9e0df40c71e1 100644
--- a/drivers/net/netdevsim/ethtool.c
+++ b/drivers/net/netdevsim/ethtool.c
@@ -2,7 +2,6 @@
 // Copyright (c) 2020 Facebook
 
 #include <linux/debugfs.h>
-#include <linux/ethtool.h>
 #include <linux/random.h>
 
 #include "netdevsim.h"
@@ -72,6 +71,12 @@ static void nsim_get_ringparam(struct net_device *dev,
 	struct netdevsim *ns = netdev_priv(dev);
 
 	memcpy(ring, &ns->ethtool.ring, sizeof(ns->ethtool.ring));
+	kernel_ring->tcp_data_split = dev->ethtool->hds_config;
+	kernel_ring->hds_thresh = dev->ethtool->hds_thresh;
+	kernel_ring->hds_thresh_max = NSIM_HDS_THRESHOLD_MAX;
+
+	if (kernel_ring->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
+		kernel_ring->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
 }
 
 static int nsim_set_ringparam(struct net_device *dev,
@@ -161,6 +166,8 @@ static int nsim_get_ts_info(struct net_device *dev,
 
 static const struct ethtool_ops nsim_ethtool_ops = {
 	.supported_coalesce_params	= ETHTOOL_COALESCE_ALL_PARAMS,
+	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
+					  ETHTOOL_RING_USE_HDS_THRS,
 	.get_pause_stats	        = nsim_get_pause_stats,
 	.get_pauseparam		        = nsim_get_pauseparam,
 	.set_pauseparam		        = nsim_set_pauseparam,
@@ -182,6 +189,9 @@ static void nsim_ethtool_ring_init(struct netdevsim *ns)
 	ns->ethtool.ring.rx_jumbo_max_pending = 4096;
 	ns->ethtool.ring.rx_mini_max_pending = 4096;
 	ns->ethtool.ring.tx_max_pending = 4096;
+
+	ns->netdev->ethtool->hds_config = ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
+	ns->netdev->ethtool->hds_thresh = 0;
 }
 
 void nsim_ethtool_init(struct netdevsim *ns)
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index d013b6498539..f92b05ccdca9 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -15,6 +15,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -54,6 +55,7 @@ static int nsim_forward_skb(struct net_device *dev, struct sk_buff *skb,
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	struct ethtool_netdev_state *ethtool;
 	struct net_device *peer_dev;
 	unsigned int len = skb->len;
 	struct netdevsim *peer_ns;
@@ -74,6 +76,13 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		rxq = rxq % peer_dev->num_rx_queues;
 	rq = peer_ns->rq[rxq];
 
+	ethtool = peer_dev->ethtool;
+	if (skb_is_nonlinear(skb) &&
+	    (ethtool->hds_config != ETHTOOL_TCP_DATA_SPLIT_ENABLED ||
+	     (ethtool->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	      ethtool->hds_thresh > len)))
+		skb_linearize(skb);
+
 	skb_tx_timestamp(skb);
 	if (unlikely(nsim_forward_skb(peer_dev, skb, rq) == NET_RX_DROP))
 		goto out_drop_cnt;
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index a70f62af4c88..dcf073bc4802 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -16,6 +16,7 @@
 #include <linux/debugfs.h>
 #include <linux/device.h>
 #include <linux/ethtool.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/kernel.h>
 #include <linux/list.h>
 #include <linux/netdevice.h>
@@ -36,6 +37,8 @@
 #define NSIM_IPSEC_VALID		BIT(31)
 #define NSIM_UDP_TUNNEL_N_PORTS		4
 
+#define NSIM_HDS_THRESHOLD_MAX		1024
+
 struct nsim_sa {
 	struct xfrm_state *xs;
 	__be32 ipaddr[4];
-- 
2.34.1


