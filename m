Return-Path: <netdev+bounces-155025-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 266D2A00B1A
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 16:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED83164595
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 15:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1AE01FA14B;
	Fri,  3 Jan 2025 15:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLtVbXku"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 033911A8F9A;
	Fri,  3 Jan 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735916692; cv=none; b=RZsPdgx074xn9kwvgr+7SZvZe8+q+knDBSVVzPfgrQE+APBJOFbw6aVAy+ntUBbRwh4iPDhuXowuGXx0BatKAL4nslm6NESqNDKGrNfIglqvxllQ0OuJIQRFbsaHOunVJStWAPJLOHwaOqHrjMxi2LyDcXOT+qgAlQ+cfmHcJM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735916692; c=relaxed/simple;
	bh=L6MYuD3u+xSbD2EiSkVnWj+5AwYiSsdjyBao+vMBte8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PO4fARJqBuINPYZOn0O+FhOijlI8GEKuAgq125pIu6IFs6eho4HDN4AUcD0x4nHbvhxSL9ROKdyakxa+xwnnvnu5+FgeA6w8d9Foh430dect+HhbY4mRiAu6cJuDBnHsbYSL8idqbFuiMakXxCtW2Cx5WyXbXOYuU6xPzzg+JxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLtVbXku; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-21644aca3a0so95331175ad.3;
        Fri, 03 Jan 2025 07:04:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735916690; x=1736521490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SdIIZFCtcHdPgbtASbzKTVWoOAIV4vHIvwfLf2MMccc=;
        b=bLtVbXkuWGoy1Hnq2QmsAFwvBeTLfGzIatQxQgmnDU+m5A43G92zkoPhfkAH/atJq0
         3RnrNaWyFFtDBQ21ScSzYJph6MWtdYH//o5onkSjHAMaoEctHQ7hWj+ON4NtREu8gwY5
         TaNMxWeB6yNaltotM9gOV0PXv6Gz8mPpReOAFqvok7qFBqeGupkC7yvfwuq3XP9gHU0i
         TynhsS/T7wzIgbZUR6fVUOlh0SPTVCC7Np2+skzBlbst5/km6KGjaShkl2KglPWgmdu0
         EcOjADRO09uXc0ujd+683QmRt2pLbznqMhvZaeKSKHmHBMuZqAxFEDH8+LCOsM4uNBSv
         9CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735916690; x=1736521490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SdIIZFCtcHdPgbtASbzKTVWoOAIV4vHIvwfLf2MMccc=;
        b=n664miVsmD4MsXP/8qovWo9d7YOpjSl0mphOAqoHq6fZGK30y/MOFAJ1L8c5DyLR+q
         sF82W2MjPbr2+PU8oGYlKxyg1y3YW36vTTLh6L8B2ZspOoy/5/Tue4RdxkuXCsU0//og
         n8JhTv5i8vmEtU+43EHpNx+dODOyeDTwWLxEoZhnRDiCdo6xJ4yfnlCvcjdXKYx8oh3d
         oeS0V4Cvwb3ceveIq4oRSeHLgTNC6K36epB4BVhMBH2luL3T4w3xGnsOI9E1t7nNM1lc
         ImC1ZnolMULw4DVeD/gnQ7neLVd6v5eXjZuWuVryKm58fL3lZp/G0qeJWZ2C3uhInQZo
         am5w==
X-Forwarded-Encrypted: i=1; AJvYcCX6Kq/A3lrpjOpGd/A7sY4sptDOtczVIt6vUGhnvg6aeXLKXOpU/FiOR48x6gqR94o9rpKuY1CO@vger.kernel.org, AJvYcCXpKa7NF/vv6tjKhHDnnQwh5InqG++8AKQbmFZ0aIYXp1kFs8UMo6kqNNUDTuZ5XMs/3Fus0eLFNxk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg3SC4cilngOwaauMHykqLNz+9QNHczDnKq3l/9N6pP10MY2L0
	go8jAFcW3kNif03nzdUFBjnW7ePjgW/AqElPgNuJlQ7hUdV/yh11
X-Gm-Gg: ASbGncsZLKn3WhxooQnoxT7nsB0cMSmbYa5jY2oWr867xjVAQOMJiq6mgErmW9ptR8t
	7AMirND/2+HQ2Gbj5BEHjhTHL/gY2xPWKh/f25AP8dgdqKwTjWSXchSvmLvLybsTUx7SqNq1HjF
	yGuJfCzO+gUohO/Vt0Upn+rYOC5BkAVqL5azOL0Qw8GINeR3nGTLeJISdzX85OT8GXN+mwg0xhm
	syrOPIB46jIK3T8s10XVpLs/kfr7xjq0Px0zqq8O0jgFg==
X-Google-Smtp-Source: AGHT+IHVVgUmC3Nf91vr5cN4Fy5E0NKLIHPA1YOFxQZj26nPS1aeoSIz2Hkpayi/7/kIdqZzLYxucA==
X-Received: by 2002:a17:903:2444:b0:215:e98c:c5d9 with SMTP id d9443c01a7336-219e6e9fb2emr617498715ad.18.1735916690056;
        Fri, 03 Jan 2025 07:04:50 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9629d0sm247047255ad.41.2025.01.03.07.04.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 07:04:49 -0800 (PST)
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
Subject: [PATCH net-next v7 08/10] bnxt_en: add support for hds-thresh ethtool command
Date: Fri,  3 Jan 2025 15:03:23 +0000
Message-Id: <20250103150325.926031-9-ap420073@gmail.com>
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
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 7 ++++++-
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 7198d05cd27b..df03f218a570 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4603,6 +4603,7 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
 static void bnxt_init_ring_params(struct bnxt *bp)
 {
 	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
+	bp->dev->ethtool->hds_thresh = BNXT_DEFAULT_RX_COPYBREAK;
 }
 
 /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
@@ -6562,6 +6563,7 @@ static void bnxt_hwrm_update_rss_hash_cfg(struct bnxt *bp)
 
 static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 {
+	u16 hds_thresh = (u16)bp->dev->ethtool->hds_thresh;
 	struct hwrm_vnic_plcmodes_cfg_input *req;
 	int rc;
 
@@ -6578,7 +6580,7 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
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
index 413007190f50..829697bfdab3 100644
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
@@ -869,6 +872,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
 			bp->flags &= ~BNXT_FLAG_HDS;
 	}
 
+	dev->ethtool->hds_thresh = kernel_ering->hds_thresh;
 	bp->rx_ring_size = ering->rx_pending;
 	bp->tx_ring_size = ering->tx_pending;
 	bnxt_set_ring_params(bp);
@@ -5390,7 +5394,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
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


