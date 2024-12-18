Return-Path: <netdev+bounces-153003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B89FF9F68E7
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:47:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D79D17A4941
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73C741C5CC9;
	Wed, 18 Dec 2024 14:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RcZYboal"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D7D1C5CA6;
	Wed, 18 Dec 2024 14:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533237; cv=none; b=cLwypekEE9Dn7KnH5iIGbF+vY3l/cfOCN2xqjqL7HlnfEfyuGThmvmUVwDNEn/7Zu0kurENtiJBZpi8NtbdmPX+2NJMlhfeByzCXbgQl5wHM4DX4HozoGj61DDGjhDDuNaD6b5DJYEQlsVK2ZWhIsOp8UfvfiY9zsZ+D/+BKfT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533237; c=relaxed/simple;
	bh=ncUAZaty47n8Ay6yLZhAJXQq01xv2i7JiTci3Bn2Wgw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b2lZmM4sWeJoMmKA6NF4FIN0PO8yRjRSSQSeg8YNFMNfDkmNNXnCtCbWVyXSbo7DxeoUG3wbvVM8vIys+ljYB2hjcOdWYSCN1MEOH4gVtMMYQ1l5lHIadxWGrS32XFz/uBs1+bLoS6IFKOXq6FA8PmL6Dw8VGxQ8oFZdgMZ2GPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RcZYboal; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-72764c995e5so4074842b3a.2;
        Wed, 18 Dec 2024 06:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734533234; x=1735138034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gWmOq+VV7HWU+gYZvejEzdD6n/9uNGfIfabXSyBFwA0=;
        b=RcZYboalhUKVoJ3cVDikXO9m+tJHBe2ytuTK7GGpX3o82hr6QEOnHQAjN9yuxyVaxY
         vv8aDUl9INlsjddQnF+ff4kD2iwuGQwKEZKTPeeZ1xRXBHWS54Kq5/EptGgK1xsjXMd7
         R+odD+DZb7bo5XO0I8W5Z0rJ/dM7ezNZSVRuQNsI0Ef5HUhVlpCSRAZtmd2XdCpiCkAa
         2Drd31dZyQKtPXE5AipamhueJ581inpZMeXmDu0PN9rFzC/1G+zXVyBhfetmr1WYOU14
         qTP0GyH3PLMuE6gMEXnFMMIoQ386kGEAEc9yE9vqGhuqJhTqEKeOlGzQhBOTjZ2RTQW2
         1d1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734533234; x=1735138034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gWmOq+VV7HWU+gYZvejEzdD6n/9uNGfIfabXSyBFwA0=;
        b=GZfnIBbE317AVwhxK4DyXhYjHH+4qFVQS1LQKLYnI+5PDJ84EZYbxlpe0uKU3WFLOt
         5qitzCTqmaCX/xapuYnXduf3TrQcq1fGBZENd+ZtbuVIwaGhUtfmnDBKidkMnTtgHg9X
         mfJSAdluHkNw2KgOnTr85KzhefhCdbMzdSeYE/96pL1jh6Xs2LIqk0tVx0g++dhbeA/w
         U2Dr067AfXzaPqodguVhkoRU2oX0lzR8V+50OMlMqX1rEfLqFXTsff4y6pfUyd6E3WOu
         fivcOGRoFtXE2KDSSC6dOe/PSFfX1psSnxUaRA0h6J9YIEi6bV1XAGStzoSCJxGia5Yk
         emcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWo2Ubgf6VgEyoU+MQKtma8E2HaqtZAwO3RFszYWDypYPPxZvjGg+I/5zU5phYJuDkWUhMr21A5@vger.kernel.org, AJvYcCWzet7POqNK9XeyycYa73WZETFJIrimLsm05Pume8zmTc6S58w/8LP3hnSDemwzxd/Z3dO+pwR2mPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YygztGQJECrtw+TViUJmcNyZuk71fpBvUjOiXGccCIWYzPnWEpK
	AKxcJ7cjvUcrPnN3OS9yuOq1lBgu3bmcYT+9toxPqMEUybNZkoDb
X-Gm-Gg: ASbGncvprrmiGchq5iTJvypWTd0w8c/cRWs2UMs29hjpD95QPMLBWc2/EuHNw8q8nSP
	uTBl5jZ14r1JFDIn59ku0yZhURwBTPaoRFLnohEMxyHrYE/Wydsh5YHugJNkpyPWwpNpNPFSk22
	fX0o787eOMwhwmKUwXWyIdbYZDafI15B36zqNm39l1w7KRYXrnHQNEkp9h++dla4lO0RjooCGg7
	UemvbtYXqpYIF0CK6HLJO4uQotyDeOsRqdEcG9xX19DGQ==
X-Google-Smtp-Source: AGHT+IEzLX9OyAR+LPjOI5ySVmibuUBZx0cl2zhW6CyHtWam13KWiNzBk+vkF3h9Ncr9eRzzfh8iYg==
X-Received: by 2002:a05:6a00:10d0:b0:729:597:4f97 with SMTP id d2e1a72fcca58-72a8d2c43dfmr5589492b3a.20.1734533233720;
        Wed, 18 Dec 2024 06:47:13 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac5183sm8912687b3a.29.2024.12.18.06.47.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:47:12 -0800 (PST)
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
	ap420073@gmail.com,
	Andy Gospodarek <gospo@broadcom.com>
Subject: [PATCH net-next v6 3/9] bnxt_en: add support for tcp-data-split ethtool command
Date: Wed, 18 Dec 2024 14:45:24 +0000
Message-Id: <20241218144530.2963326-4-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218144530.2963326-1-ap420073@gmail.com>
References: <20241218144530.2963326-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NICs that uses bnxt_en driver supports tcp-data-split feature by the
name of HDS(header-data-split).
But there is no implementation for the HDS to enable by ethtool.
Only getting the current HDS status is implemented and The HDS is just
automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled.
The hds_threshold follows rx-copybreak value. and it was unchangeable.

This implements `ethtool -G <interface name> tcp-data-split <value>`
command option.
The value can be <on> and <auto>.
The value is <auto> and one of LRO/GRO/JUMBO is enabled, HDS is
automatically enabled and all LRO/GRO/JUMBO are disabled, HDS is
automatically disabled.

HDS feature relies on the aggregation ring.
So, if HDS is enabled, the bnxt_en driver initializes the aggregation ring.
This is the reason why BNXT_FLAG_AGG_RINGS contains HDS condition.

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Tested-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v6:
 - Disallow to attach XDP when HDS is in use.
 - Add Test tag from Andy.

v5:
 - Do not set HDS if XDP is attached.
 - Enable tcp-data-split only when tcp_data_split_mod is true.

v4:
 - Do not support disable tcp-data-split.
 - Add Test tag from Stanislav.

v3:
 - No changes.

v2:
 - Do not set hds_threshold to 0.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  2 +-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  5 +++--
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 21 +++++++++++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c |  4 ++++
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index c31894b9187e..42ffaa88ae4e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4623,7 +4623,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
 	bp->rx_agg_ring_size = 0;
 	bp->rx_agg_nr_pages = 0;
 
-	if (bp->flags & BNXT_FLAG_TPA)
+	if (bp->flags & BNXT_FLAG_TPA || bp->flags & BNXT_FLAG_HDS)
 		agg_factor = min_t(u32, 4, 65536 / BNXT_RX_PAGE_SIZE);
 
 	bp->flags &= ~BNXT_FLAG_JUMBO;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index b73de5683063..847dedf61a9e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2244,8 +2244,6 @@ struct bnxt {
 	#define BNXT_FLAG_TPA		(BNXT_FLAG_LRO | BNXT_FLAG_GRO)
 	#define BNXT_FLAG_JUMBO		0x10
 	#define BNXT_FLAG_STRIP_VLAN	0x20
-	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
-					 BNXT_FLAG_LRO)
 	#define BNXT_FLAG_RFS		0x100
 	#define BNXT_FLAG_SHARED_RINGS	0x200
 	#define BNXT_FLAG_PORT_STATS	0x400
@@ -2266,6 +2264,9 @@ struct bnxt {
 	#define BNXT_FLAG_ROCE_MIRROR_CAP	0x4000000
 	#define BNXT_FLAG_TX_COAL_CMPL	0x8000000
 	#define BNXT_FLAG_PORT_STATS_EXT	0x10000000
+	#define BNXT_FLAG_HDS		0x20000000
+	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
+					 BNXT_FLAG_LRO | BNXT_FLAG_HDS)
 
 	#define BNXT_FLAG_ALL_CONFIG_FEATS (BNXT_FLAG_TPA |		\
 					    BNXT_FLAG_RFS |		\
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 4cdfff5d531c..25eb5931aea9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -840,16 +840,36 @@ static int bnxt_set_ringparam(struct net_device *dev,
 			      struct kernel_ethtool_ringparam *kernel_ering,
 			      struct netlink_ext_ack *extack)
 {
+	u8 tcp_data_split = kernel_ering->tcp_data_split;
 	struct bnxt *bp = netdev_priv(dev);
+	u8 hds_config_mod;
+
+	hds_config_mod = tcp_data_split != dev->ethtool->hds_config;
 
 	if ((ering->rx_pending > BNXT_MAX_RX_DESC_CNT) ||
 	    (ering->tx_pending > BNXT_MAX_TX_DESC_CNT) ||
 	    (ering->tx_pending < BNXT_MIN_TX_DESC_CNT))
 		return -EINVAL;
 
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED && hds_config_mod)
+		return -EOPNOTSUPP;
+
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    hds_config_mod && BNXT_RX_PAGE_MODE(bp)) {
+		NL_SET_ERR_MSG_MOD(extack, "tcp-data-split is disallowed when XDP is attached");
+		return -EOPNOTSUPP;
+	}
+
 	if (netif_running(dev))
 		bnxt_close_nic(bp, false, false);
 
+	if (hds_config_mod) {
+		if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
+			bp->flags |= BNXT_FLAG_HDS;
+		else if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
+			bp->flags &= ~BNXT_FLAG_HDS;
+	}
+
 	bp->rx_ring_size = ering->rx_pending;
 	bp->tx_ring_size = ering->tx_pending;
 	bnxt_set_ring_params(bp);
@@ -5354,6 +5374,7 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 				     ETHTOOL_COALESCE_STATS_BLOCK_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
 				     ETHTOOL_COALESCE_USE_CQE,
+	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
 	.get_link_ksettings	= bnxt_get_link_ksettings,
 	.set_link_ksettings	= bnxt_set_link_ksettings,
 	.get_fec_stats		= bnxt_get_fec_stats,
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index f88b641533fc..1bfff7f29310 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -395,6 +395,10 @@ static int bnxt_xdp_set(struct bnxt *bp, struct bpf_prog *prog)
 			    bp->dev->mtu, BNXT_MAX_PAGE_MODE_MTU);
 		return -EOPNOTSUPP;
 	}
+	if (prog && bp->flags & BNXT_FLAG_HDS) {
+		netdev_warn(dev, "XDP is disallowed when HDS is enabled.\n");
+		return -EOPNOTSUPP;
+	}
 	if (!(bp->flags & BNXT_FLAG_SHARED_RINGS)) {
 		netdev_warn(dev, "ethtool rx/tx channels must be combined to support XDP.\n");
 		return -EOPNOTSUPP;
-- 
2.34.1


