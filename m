Return-Path: <netdev+bounces-157424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE580A0A440
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 15:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CE31188A89C
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975EE1ACEDA;
	Sat, 11 Jan 2025 14:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Abz9kT7n"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B11AC435;
	Sat, 11 Jan 2025 14:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736606823; cv=none; b=u5q/7gdcysnR9oRVGkmE0sGXcPxGh+Ipy0YgIN34Luqefn2pW0WaOCIaZ2f0SdJwhXE7eM4O3sfbOQg5ZJPEacAemWgFakOrtpfEdi+QKkUQZ4ufor7LWNwcXXZeHGioqWgAlmxBvSg4Sno+G5dKU+rSSUntLsaT9EhIFUxr2q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736606823; c=relaxed/simple;
	bh=B8fSBhnMbnkd4uR1kfgOWhUnWKdhAmpBc9d0C2mjuvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jyZQhyN5egKgU9nuzB8tOKvWqwupR1Ai2AzDF7Wdv9y4rVs6UbfXq+NKmRb03/o6TD+PDLjWm/S4KR5/5sraosgBuiA2InxUYgfiwZs/xw9RFiJ/Dh+0ObF6jT7mRm4nR1fTpckJEJGaPjF2lc2SKrauJxg6pc9Y+0/UIbhd3qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Abz9kT7n; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21631789fcdso52213095ad.1;
        Sat, 11 Jan 2025 06:47:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736606821; x=1737211621; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TXFGFJwQwhEvgrT0UhbMHXejXuAuLyl+ackMNSHnAe0=;
        b=Abz9kT7nOH+W4GJTry6gpDY4unxx8I2H+Nk9OIxca4pg1PG9xVggbpHv4+PMIGBnFb
         sbeL+75CMcYxOnj9LukuQGEC3f4RH8Ssi4gldzhYEviugkVlrfK8mpRIbMt+TnnVuDgw
         Ius1cr0oK9D/Jl/uXyFEMrzhvdvzNlCl8oJyRRczk3P3eHboaob+cGu2sdiEka9bXuGZ
         CaGadTdg1fEDg9Se7YdwrupFzoVHZGarJ49KXnBdgZ2yT1CJSrJDILX+b++xnSCQ+0fX
         o9c4LU4MBuxzJTNtUhC2dMBA9lEC/xrDVmcaSUK2VDENlcTDC8QAUl2oCeD0eSMGIkXa
         HcGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736606821; x=1737211621;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TXFGFJwQwhEvgrT0UhbMHXejXuAuLyl+ackMNSHnAe0=;
        b=c+TV+uR0sJ8UHVakn4p7A1d79+Guw1pdIUWYimgYXNd4SN4ii9ecAbMlXAxDLaDqlh
         f7c2ar2hQ+ails3eD+8trYRIZd1picBt6lDeo03RYGndxAS/muoNCBMDUHc806rbo+D0
         o8E1hnXabVtbkrSaKoW1Idvn70AkXZOuWkEe0imG2XM2jw4UKF20cJkBUpi3/4QA7DLy
         UhOMHuUyCSjx5uPYNYIVOmI9ZIR5nLEPqtyme7/yXz31UsshVGrvtVVrmurFwRztWpA5
         nofp59ANR5DGRq8QtEhYldp7lv0u/mrdbB/DMYnJqsTdomrxq2B2hRh7o+gO87Njb3JQ
         dkJg==
X-Forwarded-Encrypted: i=1; AJvYcCWBvEPlgU87E+L/TDuDPtzgCgMRcNTdN1NmMwzqEvJ1BpQdqNFbC//QpeQzZNUzwXtK0WoimQWdGlk=@vger.kernel.org, AJvYcCWEchXMV5kIsbaPbkSYRd5248ATIKTxmfM+wsn50b7m/6ABfnfMyQlUGMpkVEYptJ4VzE75E4LD@vger.kernel.org
X-Gm-Message-State: AOJu0YynrwSX5JIN2Hx/Ru8hWG76k9UcQJhYJdBwg6Wjiquz8Srln7eL
	67QW5aeNvWxteiPvlldHb+FdLkczcTHyJGUxqWjOTqs/tOvxT511
X-Gm-Gg: ASbGnctr2u6ZVzh/dYPXpWPXkmfkINQe4lbl3rA0E3EBL8kG8NICQT+LgQ2hr5E8hVG
	iEIk5fF4RIpymMU6NQEkqsPcmHmgwHNjn7WWMgujUamPQ45HIaD8n7dE0CHSJo6zNq5FdQpmx14
	BX5z00lR3FLh6ysNSy+Dg9OAeIyIkqd/e6HIIqCd+pkl1WXAR6inNa61ZoLEZ9oApztkGXDvVoh
	9vwv8F3Vb7FKKhKpj/gSD3mT71KPoQhBOz9/LXx9XZkPA==
X-Google-Smtp-Source: AGHT+IEk3kTwxfkZdpvZ/zTwufQ4a0BPvLXi0hGXVWRqt1Ay5qncv5T3UCnn5R9H82Dtj2sABez7qg==
X-Received: by 2002:a05:6a20:9150:b0:1e1:9e9f:ae4 with SMTP id adf61e73a8af0-1e8b15f7db0mr10330695637.13.1736606821208;
        Sat, 11 Jan 2025 06:47:01 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d40594a06sm3097466b3a.80.2025.01.11.06.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 06:47:00 -0800 (PST)
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
Subject: [PATCH net-next v8 08/10] bnxt_en: add support for hds-thresh ethtool command
Date: Sat, 11 Jan 2025 14:45:11 +0000
Message-Id: <20250111144513.1289403-9-ap420073@gmail.com>
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


