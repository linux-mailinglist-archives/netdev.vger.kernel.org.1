Return-Path: <netdev+bounces-155026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 728A9A00B1C
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87F071882896
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969C91FBCB6;
	Fri,  3 Jan 2025 15:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m770yjdD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A321FBC9C;
	Fri,  3 Jan 2025 15:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916701; cv=none; b=Cbtm9OpNvR070uAh3r1KC5StifZ2TqFMhk0RKpaoEYJcO/7tP3qHOIt7mXAEA7eB8RZVig0DLiqjPDNAmHTFc7ng/IKIWtdbhFjUrQmVDkheDnhBlbTYK/pqe1L57Dq3lRStr6Qwl47Vq++c/awdLTe9SpODXAoa4wOyZqkkaiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916701; c=relaxed/simple;
	bh=NvAJ5hcGuIYAqGMVBq7reo38EMrOI4ZnWrBomY9szSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bGr4IyHYaQJHMVUwGT9KZohqRYyNFSzbERFXHLcMog6oh6ZCfep+2zqe9iJy1LRGpjj5cuAav6f3yyyQSKPjbufr67npTk2hfkbdVqSshdePAvrpFvN8hUH98W2MEjkwcpaYlzH8twkTdENuKhmUfgG2Dp/G2dCo3R4v6BM2Ads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m770yjdD; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-21661be2c2dso156901235ad.1;
        Fri, 03 Jan 2025 07:04:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735916699; x=1736521499; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RnpGvv4lfe2nj6WMe9po2SCX02YRLSRAJWmhEZZK/LU=;
        b=m770yjdDgagSuLZJGPWG2dFcIgAcU09MEzmxvhztYowyJfrjbpKT5OW/LGgxlRC4vX
         so8isbtqxo1vOCXKZQxGcbtQNU9Xu588EVZEbdleG4F2gyD4/DwzmMyCOAWXr/04rK67
         Wkd7yFToYMWDSuyYDflx/MOR9tbne/B7NdZmDqYrPO1Rz6W5+1efOK/n2xGxtS/t/05F
         cBg3Sejs4TJbSmTHR2FZr18lx+ukwR0r1jQrAaTcmBnpgkkxW3wRRWRchZEWg86+IvB+
         wMsZNnHoMEPzXKb+uinRvrMpRR3y/3bkrS7fY/y54Iivf1tI7qmvSV03vVRb4AZVnS6m
         7NFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735916699; x=1736521499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RnpGvv4lfe2nj6WMe9po2SCX02YRLSRAJWmhEZZK/LU=;
        b=IcvXKAFS8AQ/LWuuSI9se6sbMbpo+BQAbAUuhRijWVgtGperqGQWRXHSGO4Pd74CeI
         xXonX0HIh6CI4quV2U2kHAs2GvQ9WU4GXBamGWRW9I+iIRahSfQB7hVsFc3DYqal9+ef
         4iVsuiUdcpb7Hnlk++aay+EPsiBICLs31yZM8mwjVD0pU4O1mx6U4tmNJkkYKXu5pGzf
         yJq1SPHhgkLneH2gK5WtMC4hE1lmko9/crktwx0CyMJZ4/YDLTPHQZNwsYlwNoxxarbZ
         iG4coCPoqoOFFcFj8Rg3dizq56G7XTOapm5O1523/clYJj2nNZ6esuZGtFiZtqUX6TaR
         3GPQ==
X-Forwarded-Encrypted: i=1; AJvYcCWrI/SUw4MOdHDpSW2AWVPicjzeoI3DfdMLf/jNQDpA85HkKDYAwTEKSkf8HvnKCP9Gp/I6FbA7@vger.kernel.org, AJvYcCXXeZRg2tdc14GZdsTa+q2MfHpnQDqZntREt57MLSlxA6VkfypjtWrueAHpY9JWJrdjFjIMdwGa+q0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHbDnGmIwjXbR+onh5DxS9xUfXOyVDc3flXfgMGTWdkdSzliHg
	8oWtOoCHViPVRcRFfcIV7cFSLASnZ+WqdbJAcHsNzl6bxYV58cuq
X-Gm-Gg: ASbGncszBey6J/VZdqgcOdAMi9hR8Nw5arc2l3DCnZVAsz4jzJ5IL6LKR3U7RNqfIa/
	aZIhMxEcxAvsPbCxk1CCHcZzk9D0SQgaAE43TeaahPgJMg8x4aGTZFJaWDlurXzg66SWk7Ua0oE
	9FkVjoU/uGf5LOCG5FZ7Rx8pKT+rHXMlW7wlSYlK0w90AWpwKpmNoBKZbKb6jMx1Et7qJz5k1+k
	y3NUM5HLYpmj8TPNoGVYTiY7QRjUgyWgbTyAcPsN1zwEA==
X-Google-Smtp-Source: AGHT+IEGry5gbnlcC9i6jJZft+4fkopD4jnCwZOiO/ww7qpuCTXWh1ican4+qKz811xtt2gQ66BwHQ==
X-Received: by 2002:a17:902:f550:b0:215:a04a:89d5 with SMTP id d9443c01a7336-219e6e859d8mr583560315ad.2.1735916698808;
        Fri, 03 Jan 2025 07:04:58 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9629d0sm247047255ad.41.2025.01.03.07.04.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:04:58 -0800 (PST)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
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
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org
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
Subject: [PATCH net-next v7 09/10] netdevsim: add HDS feature
Date: Fri,  3 Jan 2025 15:03:24 +0000
Message-Id: <20250103150325.926031-10-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250103150325.926031-1-ap420073@gmail.com>
References: <20250103150325.926031-1-ap420073@gmail.com>
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

v7:
 - Add datapath implementation.
 - Remove kernel_ethtool_ringparam in the struct nsim_ethtool.

v6:
 - Patch added.

 drivers/net/netdevsim/ethtool.c   | 15 ++++++++++++++-
 drivers/net/netdevsim/netdev.c    |  9 +++++++++
 drivers/net/netdevsim/netdevsim.h |  3 +++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/net/netdevsim/ethtool.c b/drivers/net/netdevsim/ethtool.c
index 5fe1eaef99b5..fb0136def48a 100644
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
@@ -85,6 +90,9 @@ static int nsim_set_ringparam(struct net_device *dev,
 	ns->ethtool.ring.rx_jumbo_pending = ring->rx_jumbo_pending;
 	ns->ethtool.ring.rx_mini_pending = ring->rx_mini_pending;
 	ns->ethtool.ring.tx_pending = ring->tx_pending;
+	dev->ethtool->hds_config = kernel_ring->tcp_data_split;
+	dev->ethtool->hds_thresh = kernel_ring->hds_thresh;
+
 	return 0;
 }
 
@@ -161,6 +169,8 @@ static int nsim_get_ts_info(struct net_device *dev,
 
 static const struct ethtool_ops nsim_ethtool_ops = {
 	.supported_coalesce_params	= ETHTOOL_COALESCE_ALL_PARAMS,
+	.supported_ring_params		= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
+					  ETHTOOL_RING_USE_HDS_THRS,
 	.get_pause_stats	        = nsim_get_pause_stats,
 	.get_pauseparam		        = nsim_get_pauseparam,
 	.set_pauseparam		        = nsim_set_pauseparam,
@@ -182,6 +192,9 @@ static void nsim_ethtool_ring_init(struct netdevsim *ns)
 	ns->ethtool.ring.rx_jumbo_max_pending = 4096;
 	ns->ethtool.ring.rx_mini_max_pending = 4096;
 	ns->ethtool.ring.tx_max_pending = 4096;
+
+	ns->netdev->ethtool->hds_config = ETHTOOL_TCP_DATA_SPLIT_UNKNOWN;
+	ns->netdev->ethtool->hds_thresh = 0;
 }
 
 void nsim_ethtool_init(struct netdevsim *ns)
diff --git a/drivers/net/netdevsim/netdev.c b/drivers/net/netdevsim/netdev.c
index e068a9761c09..fc365661039e 100644
--- a/drivers/net/netdevsim/netdev.c
+++ b/drivers/net/netdevsim/netdev.c
@@ -15,6 +15,7 @@
 
 #include <linux/debugfs.h>
 #include <linux/etherdevice.h>
+#include <linux/ethtool_netlink.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/netdevice.h>
@@ -51,6 +52,7 @@ static int nsim_forward_skb(struct net_device *dev, struct sk_buff *skb,
 static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 {
 	struct netdevsim *ns = netdev_priv(dev);
+	struct ethtool_netdev_state *ethtool;
 	struct net_device *peer_dev;
 	unsigned int len = skb->len;
 	struct netdevsim *peer_ns;
@@ -71,6 +73,13 @@ static netdev_tx_t nsim_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		rxq = rxq % peer_dev->num_rx_queues;
 	rq = &peer_ns->rq[rxq];
 
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
index bf02efa10956..648905f8475e 100644
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


