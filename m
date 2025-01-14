Return-Path: <netdev+bounces-158147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D465EA10957
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 15:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E22681887230
	for <lists+netdev@lfdr.de>; Tue, 14 Jan 2025 14:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FB514600F;
	Tue, 14 Jan 2025 14:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IC2tNE9i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6FA7E105;
	Tue, 14 Jan 2025 14:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736865040; cv=none; b=FxIdx7QXp2pr2AhafJm+bbEauwUb6A76Iu+VfkM+TSVMLiW3fYju9sHO1Wc8lYQTCLBfyyUyyHXz2A4p3Ot5twX/H9iXs/Dm6xVrCUtQ64o2w2bXADRhdIOSC7wUhJSRpRqkdyF96CPmMK1A3Piz9pDeMv6HRykTuLTprCC9hMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736865040; c=relaxed/simple;
	bh=NxdCcWgZjIQdKCN2i8i35vUmQ9Q3zb9goBI5wLHZw2c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dVDZaU0MlPXph1+N9qSFozVdnzq9w/QTn9SH46dHCUCPwR6gtfcaysupFbAmLBjrtWJrBVdYg0HT2BtQLdva2gmUdPsgwIhJGHeu93cBhF2PrRaYaB8oM/KFzD83UqhXbX//+bCFiubdpjPH8hwqd2gYT1oiqdJgOSsnkEJwrMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IC2tNE9i; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-218c8aca5f1so120007845ad.0;
        Tue, 14 Jan 2025 06:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736865038; x=1737469838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXCmCNgsZ+TRdie/2O5md9ditizTLBUi52YNNDbW5YE=;
        b=IC2tNE9ifOM8vlMfDmAPF795WsXEK68K5i9MY3M107iZXMb9rg3GD+k1Kt0TzG70UJ
         KvdzYniB/mJ45QvAG/a64Odc4+wBs54jCXJ4Z5MnZwgl6OTc9Sg9TDzf6Tks8LZNh3lT
         1PMUNJfBw86L7FpeaGrO+SCJ+Cy9o2cpV+J9QFSvvdU7wslkNwAMmAXlYur23qKi1enW
         Y9MSGH9VaPsr7RqnTLceQNG39pHBRSoqYvN0C+ewAr6TrVIDiO4efwnbn827jZn2jtqO
         rEqAMXseASyiasRBGmRxmklWA3GY7F4jw2WmuNOjvIA7TgGN+pSBr8aQsYdtLDVzUBFb
         tVtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736865038; x=1737469838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JXCmCNgsZ+TRdie/2O5md9ditizTLBUi52YNNDbW5YE=;
        b=lMqrzf6sVVnM3qmEMAS/+KfqOAANbI79qKc3jRPXK/QllYPZBW773eY8/otT+FaI8N
         XUgr0AkD1UosJUAHnfKrQXkRjOK4i/VWsVbi5yVFLFXpiSvrG/A8Fhdyr5PmJ88GJeUZ
         2cx4pVonsORzWKKN0pHF9OFHsw9chD5J06MUla4GHEvVVe5k9ZWXhRcsEw1xC9o0Cvgt
         sP9XUQQVPBJJMajOmPe+p8Vir3/e0TGicCrFI4+kTNxdHSGX5/rzOIKCThvQVOih2vOD
         KJ31DoLpBswBRzZHucPJTHNX8nVkYLk+cw16i9BUuymZ1lQ6ZQpeOJktuPKv+BoDgRqE
         S7iQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4miY07A5tQsWyUrhzUkZ6u8vuqKRCeWVP5mRmhDrLVYdPLc2Of1OedNK/hipDQPQTAhWZEqVt@vger.kernel.org, AJvYcCX0Ul3dAIwF8CRP4KYE3E+nn+9gQ1fV9KoKSkKhXOIZ5N4+z28nx9BrjFd+X5KpEIqVWib70mHWX3A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzp1f6KW0J/IRSfcGWEgYldCPHcSLRYvpU8ADXIXFoiTYCYSzCV
	jXtnlNfk5P8ndxsJuH8SVrCba/Lv56rs3RhG0dXfn80fLGUF5pI3
X-Gm-Gg: ASbGncs6yTRlGOas31t6dFed0IbppZKh0wXpo7eIYb3un/10fKXzDslJsgGYLE5UERO
	AmhIlrhqaOtnIjHB+WljJ53bkGhTe3eTLLGnOFKgwiI4KTsTCMHpvmnephoxXUfxOPyEPteHOcb
	OMthbqTNbmYnapzeNixoKMdZMR9/NnV1I2/GSOWf9D2GNWJzC+YWE7m8c+Ky/DkmvH31FJvYWN0
	5pNpMIPdKWPhAtpnjEr4gBW5vYBbT/LOqu1m2ZMc8Bxsw==
X-Google-Smtp-Source: AGHT+IFMgWTfs5UZsrcb7otb8gHtwBsSU5JtHlwfzqTA0/licTW8YuBUSbfCRG0ePaF7qfr3JHfkww==
X-Received: by 2002:a05:6a20:43ab:b0:1e1:b1e4:e750 with SMTP id adf61e73a8af0-1e88d1c2651mr40083047637.18.1736865038156;
        Tue, 14 Jan 2025 06:30:38 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d406a4dfesm7474582b3a.156.2025.01.14.06.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2025 06:30:37 -0800 (PST)
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
	ap420073@gmail.com,
	Andy Gospodarek <gospo@broadcom.com>
Subject: [PATCH net-next v9 08/10] bnxt_en: add support for hds-thresh ethtool command
Date: Tue, 14 Jan 2025 14:28:50 +0000
Message-Id: <20250114142852.3364986-9-ap420073@gmail.com>
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

The bnxt_en driver has configured the hds_threshold value automatically
when TPA is enabled based on the rx-copybreak default value.
Now the hds-thresh ethtool command is added, so it adds an
implementation of hds-thresh option.

Configuration of the hds-thresh is applied only when
the tcp-data-split is enabled. The default value of
hds-thresh is 256, which is the default value of
rx-copybreak, which used to be the hds_thresh value.

The maximum hds-thresh is 1023.

   # Example:
   # ethtool -G enp14s0f0np0 tcp-data-split on hds-thresh 256
   # ethtool -g enp14s0f0np0
   Ring parameters for enp14s0f0np0:
   Pre-set maximums:
   ...
   HDS thresh:  1023
   Current hardware settings:
   ...
   TCP data split:         on
   HDS thresh:  256

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Tested-by: Andy Gospodarek <gospo@broadcom.com>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v9:
 - No changes.

v8:
 - Do not set hds_thresh in the bnxt_set_ringparam.

v7:
 - Use dev->ethtool->hds_thresh instead of bp->hds_thresh

v6:
 - HDS_MAX is changed to 1023.
 - Add Test tag from Andy.

v5:
 - No changes.

v4:
 - Reduce hole in struct bnxt.
 - Add ETHTOOL_RING_USE_HDS_THRS to indicate bnxt_en driver support
   header-data-split-thresh option.
 - Add Test tag from Stanislav.

v3:
 - Drop validation logic tcp-data-split and tcp-data-split-thresh.

v2:
 - Patch added.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 4 +++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 6 +++++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f029559a581e..caddb5cbc024 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4610,6 +4610,7 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
 static void bnxt_init_ring_params(struct bnxt *bp)
 {
 	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
+	bp->dev->ethtool->hds_thresh = BNXT_DEFAULT_RX_COPYBREAK;
 }
 
 /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
@@ -6569,6 +6570,7 @@ static void bnxt_hwrm_update_rss_hash_cfg(struct bnxt *bp)
 
 static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 {
+	u16 hds_thresh = (u16)bp->dev->ethtool->hds_thresh;
 	struct hwrm_vnic_plcmodes_cfg_input *req;
 	int rc;
 
@@ -6585,7 +6587,7 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 					  VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
 		req->enables |=
 			cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
-		req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
+		req->hds_threshold = cpu_to_le16(hds_thresh);
 	}
 	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
 	return hwrm_req_send(bp, req);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 7dc06e07bae2..8f481dd9c224 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2779,6 +2779,8 @@ struct bnxt {
 #define SFF_MODULE_ID_QSFP28			0x11
 #define BNXT_MAX_PHY_I2C_RESP_SIZE		64
 
+#define BNXT_HDS_THRESHOLD_MAX			1023
+
 static inline u32 bnxt_tx_avail(struct bnxt *bp,
 				const struct bnxt_tx_ring_info *txr)
 {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 413007190f50..540c140d52dc 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -833,6 +833,9 @@ static void bnxt_get_ringparam(struct net_device *dev,
 	ering->rx_pending = bp->rx_ring_size;
 	ering->rx_jumbo_pending = bp->rx_agg_ring_size;
 	ering->tx_pending = bp->tx_ring_size;
+
+	kernel_ering->hds_thresh = dev->ethtool->hds_thresh;
+	kernel_ering->hds_thresh_max = BNXT_HDS_THRESHOLD_MAX;
 }
 
 static int bnxt_set_ringparam(struct net_device *dev,
@@ -5390,7 +5393,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 				     ETHTOOL_COALESCE_STATS_BLOCK_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
 				     ETHTOOL_COALESCE_USE_CQE,
-	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
+	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT |
+				  ETHTOOL_RING_USE_HDS_THRS,
 	.get_link_ksettings	= bnxt_get_link_ksettings,
 	.set_link_ksettings	= bnxt_set_link_ksettings,
 	.get_fec_stats		= bnxt_get_fec_stats,
-- 
2.34.1


