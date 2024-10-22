Return-Path: <netdev+bounces-137950-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D679AB3CF
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1AD3B21EF1
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038761B86D5;
	Tue, 22 Oct 2024 16:24:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEVvjAtC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65F0C1A3049;
	Tue, 22 Oct 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614275; cv=none; b=NRrZPMtDOeDKvg/xrCsMrVyFn9Gm1yKVySXBuvjwqbJSZu0iPRBKeBgqlFy1bVzk3JwBY249ix4zdGqCMpF4/R0Oha1zzHCBHywtSBMf0XjODq4cDd/eAngo7eFyg7qNIJStzgnSn9lLdl5QAdY8PKa5jOqro3skESXFtpTm2s4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614275; c=relaxed/simple;
	bh=iYt/2vPZTTZW0yh6HzQiKqk1JIMrRmfkl+8bbDI91EE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kj0FBsoNYY8KfqW3wVCLAhNf7WCKaogP+EjOvA5fnSA20io0wsLrKIYRRe9QKkVL/VKEMKlgl99ZnRb3BdZSY7YTPtIMoRRmBv9gidcA4K0946jZbY70LWxjF/IAJa+EypmQn9w+v9UnVAU+x1sJHRJ8HDQFaNhLehPWbXmfWxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEVvjAtC; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cbca51687so58507685ad.1;
        Tue, 22 Oct 2024 09:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729614274; x=1730219074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NdsyleTYEsE/bmQMS5mJMOaKVUmrh+ZSoQ7yWH3vIsc=;
        b=nEVvjAtCIOFZbJnIkVv0RDE2MhE2WQdnza7qKmDDTBvromymnyHvF5kXFcGFtSf59E
         Mzs2kgbfC+D2W3awqBDbi93ZCViqGinX85WLC4oYH4fNoCw84RTrhb6bXc7MLPnjPE43
         1gKYjkcoFsIxkXiVt5Ltyfh8ESeD6z3mHs3J7e4Zl6tT36N/VGPoD2+BX6V6fVF8nhcS
         +34ivj0r2HwLFoKzca3L1Hv1LL8/Me1jE5cw9H7taOfVvgd5uAeH48Q7begOqViNssok
         Ypro7Ka9Ume8gT8pX7twoMZgzr1vw+NNQq4+clfik+UY2smkxre7oUCRTUsxUXDZtjDr
         ezTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614274; x=1730219074;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NdsyleTYEsE/bmQMS5mJMOaKVUmrh+ZSoQ7yWH3vIsc=;
        b=YHA55soNFrEb+jauRkJYTIZrevNG3maAuuVJaLafQ3CvZ2O5uNgXneH0lBiDkH9Hxy
         NnVpSZRjA1yy+uDQPahxql7WzZFyxzJ/ezVLBxpRoL7zFy6hlQ5B7lNKyb5Z44wrvY0F
         rxanTaBJFOHIxYkRretDhc3CSKg6f3dle9hYgOoTv+iQ/QnCIwlQnxKnic8KS91uyTOp
         ivkvu0McQi9RCMLadTsrYCZxyWnNOM1ASAAo1qLK1i3+xQH/RZGUxhp08fDo5H+sgpKH
         sylwfN2Iuup9ZYjBHB6d6qHgD0XtIWTSfn0jBlKj20ye02MFsnecUdtjzKa4ix7kAe/k
         up+g==
X-Forwarded-Encrypted: i=1; AJvYcCV4HOaIBJ6aHULAex5OvkmVdDTiRnE7AAPBTrZNQSbYaQYb/u/t/NzeaNKOsxQ48/LLEvFBj6Fk@vger.kernel.org, AJvYcCVbdQ/mNn7Ybm9Tk/xm2TRsXIphJcy9+xuoSnANDo5A6i6S2QH7rESAzNqCEoI/I8VGzZ1bYnqyXAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvaZreLlvV9AtNEnacsz8x2olsnlLEP488ppGyellO+d+gIPnR
	5OvZLq2v3B+TPnqT08s7wLaStnPJ0KjVbFtwyi7XWmIVQjN4Yy2s
X-Google-Smtp-Source: AGHT+IEK6j5nr4/p0sLJgHFw9w1osIn+yDRQdSRNMnr4tNQB5gQ1hzVcmtn9XrNxOJ0y1Rlf7bttlQ==
X-Received: by 2002:a17:902:e544:b0:20c:ef81:db with SMTP id d9443c01a7336-20e5a8a103bmr199735285ad.28.1729614273680;
        Tue, 22 Oct 2024 09:24:33 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee6602sm44755205ad.1.2024.10.22.09.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:24:32 -0700 (PDT)
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
Subject: [PATCH net-next v4 2/8] bnxt_en: add support for tcp-data-split ethtool command
Date: Tue, 22 Oct 2024 16:23:53 +0000
Message-Id: <20241022162359.2713094-3-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241022162359.2713094-1-ap420073@gmail.com>
References: <20241022162359.2713094-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NICs that uses bnxt_en driver supports tcp-data-split feature by the
name of HDS(header-data-split).
But there is no implementation for the HDS to enable or disable by
ethtool.
Only getting the current HDS status is implemented and The HDS is just
automatically enabled only when either LRO, HW-GRO, or JUMBO is enabled.
The hds_threshold follows rx-copybreak value. and it was unchangeable.

This implements `ethtool -G <interface name> tcp-data-split <value>`
command option.
The value can be <on>, <off>, and <auto> but the <auto> will be
automatically changed to <on>.

HDS feature relies on the aggregation ring.
So, if HDS is enabled, the bnxt_en driver initializes the aggregation
ring.
This is the reason why BNXT_FLAG_AGG_RINGS contains HDS condition.

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v4:
 - Do not support disable tcp-data-split.
 - Add Test tag from Stanislav.

v3:
 - No changes.

v2:
 - Do not set hds_threshold to 0.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c         |  8 +++-----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         |  5 +++--
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 13 +++++++++++++
 3 files changed, 19 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0f5fe9ba691d..91ea42ff9b17 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4473,7 +4473,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
 	bp->rx_agg_ring_size = 0;
 	bp->rx_agg_nr_pages = 0;
 
-	if (bp->flags & BNXT_FLAG_TPA)
+	if (bp->flags & BNXT_FLAG_TPA || bp->flags & BNXT_FLAG_HDS)
 		agg_factor = min_t(u32, 4, 65536 / BNXT_RX_PAGE_SIZE);
 
 	bp->flags &= ~BNXT_FLAG_JUMBO;
@@ -6420,15 +6420,13 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 
 	req->flags = cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_JUMBO_PLACEMENT);
 	req->enables = cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_JUMBO_THRESH_VALID);
+	req->jumbo_thresh = cpu_to_le16(bp->rx_buf_use_size);
 
-	if (BNXT_RX_PAGE_MODE(bp)) {
-		req->jumbo_thresh = cpu_to_le16(bp->rx_buf_use_size);
-	} else {
+	if (bp->flags & BNXT_FLAG_AGG_RINGS) {
 		req->flags |= cpu_to_le32(VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV4 |
 					  VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
 		req->enables |=
 			cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
-		req->jumbo_thresh = cpu_to_le16(bp->rx_copybreak);
 		req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
 	}
 	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 1b83a2c8027b..432bc19b35ea 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2201,8 +2201,6 @@ struct bnxt {
 	#define BNXT_FLAG_TPA		(BNXT_FLAG_LRO | BNXT_FLAG_GRO)
 	#define BNXT_FLAG_JUMBO		0x10
 	#define BNXT_FLAG_STRIP_VLAN	0x20
-	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
-					 BNXT_FLAG_LRO)
 	#define BNXT_FLAG_RFS		0x100
 	#define BNXT_FLAG_SHARED_RINGS	0x200
 	#define BNXT_FLAG_PORT_STATS	0x400
@@ -2223,6 +2221,9 @@ struct bnxt {
 	#define BNXT_FLAG_ROCE_MIRROR_CAP	0x4000000
 	#define BNXT_FLAG_TX_COAL_CMPL	0x8000000
 	#define BNXT_FLAG_PORT_STATS_EXT	0x10000000
+	#define BNXT_FLAG_HDS		0x20000000
+	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
+					 BNXT_FLAG_LRO | BNXT_FLAG_HDS)
 
 	#define BNXT_FLAG_ALL_CONFIG_FEATS (BNXT_FLAG_TPA |		\
 					    BNXT_FLAG_RFS |		\
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 9af0a3f34750..5172d0547e0c 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -854,9 +854,21 @@ static int bnxt_set_ringparam(struct net_device *dev,
 	    (ering->tx_pending < BNXT_MIN_TX_DESC_CNT))
 		return -EINVAL;
 
+	if (kernel_ering->tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED)
+		return -EOPNOTSUPP;
+
 	if (netif_running(dev))
 		bnxt_close_nic(bp, false, false);
 
+	switch (kernel_ering->tcp_data_split) {
+	case ETHTOOL_TCP_DATA_SPLIT_ENABLED:
+		bp->flags |= BNXT_FLAG_HDS;
+		break;
+	case ETHTOOL_TCP_DATA_SPLIT_UNKNOWN:
+		bp->flags &= ~BNXT_FLAG_HDS;
+		break;
+	}
+
 	bp->rx_ring_size = ering->rx_pending;
 	bp->tx_ring_size = ering->tx_pending;
 	bnxt_set_ring_params(bp);
@@ -5345,6 +5357,7 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 				     ETHTOOL_COALESCE_STATS_BLOCK_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
 				     ETHTOOL_COALESCE_USE_CQE,
+	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
 	.get_link_ksettings	= bnxt_get_link_ksettings,
 	.set_link_ksettings	= bnxt_set_link_ksettings,
 	.get_fec_stats		= bnxt_get_fec_stats,
-- 
2.34.1


