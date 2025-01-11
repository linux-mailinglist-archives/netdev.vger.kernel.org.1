Return-Path: <netdev+bounces-157426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0A9A0A444
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:47:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD5316A2BE
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:47:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA841ADFFE;
	Sat, 11 Jan 2025 14:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lKUJDFfg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4DAC1ACEDA;
	Sat, 11 Jan 2025 14:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736606833; cv=none; b=u7xzt4+r0yUMQGYuK5tsCqgDFHvez+4KlOYA0TjnVFsDNpqU5JrZoYm0tIkWg45SkXdFW7DIwv2oJkmmC7JqCvQ0D+4/xOAQwQpplOHTj2PPxVPsG91WteMufluoCKtIt/mMSeHAsRS89m3obSt3UpL4P6P09sMfwSNpDh12hVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736606833; c=relaxed/simple;
	bh=xQPGkqd3QXhUmeJxb3Z6lDJdnVUTD0HBQTjEkzm6Los=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bHAbB/ZvoDFDCAOo643OkzV1L92IJ5b36EfjABhwjO7vjxse9iDUEwq0IQju1WiC+jnOpwcRkGOaZHYxAaPgnsMOlASRulvfkTnmmMkZ3+DmTL8SGOnWyBmynaeLry/lrhOj/FTAOkPuwavf4tO1aLn7NpDwlcmFKd0uo3arIa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lKUJDFfg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2156e078563so43537605ad.2;
        Sat, 11 Jan 2025 06:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736606831; x=1737211631; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=15zxhVcll/uVzwLl4srfX0ThEUvDwvmdVFl4uwOIbQA=;
        b=lKUJDFfgoWODPukiYoXn2y+E4jheLSMSWvPmq0W5GFpWSBZlQ9giSEoOLu6Tf4Ofqd
         2o6Gmltg3UtaSDJOU2oTUr4yewt3vj5QqzOIUPdBo97wYBT0SFykQWSOBt1jPvI836EB
         kYqmihcqelXPkHCHYAuV+bHfriiHYx/HXvXh0+NQpKGubq90YEMbGwBj2zHIlmnpsi+Y
         0vgGnxK3mqhlFNw/Wp7fjkS19/kry36e12cU9dsNEsYokAnRZobSOnqsFn9Ta6RBUf1z
         0W17KFFawZ5/GUgSATCis5z7P/lN8bFPgDhTAXNyy8urp1fjAsFm4g0xM24SgWZN1412
         MW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736606831; x=1737211631;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=15zxhVcll/uVzwLl4srfX0ThEUvDwvmdVFl4uwOIbQA=;
        b=PPVaZUbGdTc0g2cOfOnCraJKBaSc96uPEJQ3vUrYczRbtibinEp4JqU78uzmuwII9N
         VLFppuHotBFXxhVGii5SjDYSKCsNggOwthbdPkMhZgdf7XYPi8/D1JcfKlKpNpx7nsso
         nwRIbimC/0Mpvr8WWwid33KOKEeI5XggCjh3OGh1Wb9yOCCMhWv0f5uE0xLSsxhbXpI7
         k3n/MBZpvkdHYc6GYgNykQKL9dVI8G9uzWzMMzZhe/LUy+XoANpWtNjtDGrwNwpdw/0n
         4J26QgMgpfbNFfu5sxo6F3BIdgM/jiXA3gULiW+kBhcxqKd0nPKgidbd6u0mF2iEooz0
         nrkg==
X-Forwarded-Encrypted: i=1; AJvYcCVrrpLcQ3lqvUv7khFEuGiEqgQflbsGgz4vvC9RiQwO/kitcUOKPfEd1NYUn/IKQkerMJfS0IBu@vger.kernel.org, AJvYcCWL3VYpBDfDTJMdMl7SSxqQRBpG6ZNaAzLy4waKuviiPLxcJf9QG1cc4sUs1t/qV2yli/xqSI0P7UI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEAF6rzCeR/4Cckm7O9WD5Du8bwxX/+vIJ+lVZjcE2mqPOPxG9
	zE+8r8qp1Bo9zLvsDr8ElINPex/xfmCs+0lKS6GleaR8GxEqy0IW
X-Gm-Gg: ASbGncvvOTY/WqP+cU0jjy1tGnbQt2DA1SHsc8MqYuq48jw75sjkMDFSa1nJfvDG/BB
	xoQb78qdkzzbVtTV7pPrdqrkuChFA9/zfQKCJ2tQe2JChOYBcxsGQ4fb7F2EDomzNZlXv//05GM
	Mw5DDpNOJEzJRCAYqxoHwYPyX8+WrXd8nQtCm1Q28+0g8UClEI7FeFqTw5WlityC8n4Mddj7exH
	/jYqFrxgn15CPyJ48q86tZaU6CqAq2gjqiju5vikCLpPg==
X-Google-Smtp-Source: AGHT+IEtyXV5rkpwRx0SdkhPGlvarAGZlX76er42hN1u62c+nwwt4Wk/spMMzuw9sToZdu+0/tmVNQ==
X-Received: by 2002:aa7:9a87:0:b0:725:ef4b:de21 with SMTP id d2e1a72fcca58-72d21fc701dmr20239342b3a.20.1736606831127;
        Sat, 11 Jan 2025 06:47:11 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40594a06sm3097466b3a.80.2025.01.11.06.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 06:47:10 -0800 (PST)
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
Subject: [PATCH net-next v8 09/10] netdevsim: add HDS feature
Date: Sat, 11 Jan 2025 14:45:12 +0000
Message-Id: <20250111144513.1289403-10-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250111144513.1289403-1-ap420073@gmail.com>
References: <20250111144513.1289403-1-ap420073@gmail.com>
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


