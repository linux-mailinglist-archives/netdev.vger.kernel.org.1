Return-Path: <netdev+bounces-144504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B259C7A3B
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:48:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC85FB2FD90
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E739201113;
	Wed, 13 Nov 2024 17:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFeglS91"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A17200C8B;
	Wed, 13 Nov 2024 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519205; cv=none; b=XrVNonTPRuWLUCyLSmkO91QGGAaJkKfUkBFSArqOrtM0sgpmk3MTkLubB/bWbEA7wa2ayAmsmTtSjNMbJMcuHqEjYXVo2MeEUQI+c04liZjOGY1C7IfbHvFgCUb9pyO0ZIOXxIzJGFdB5995/SRjVXep42GAfTDi6r66EdZOfk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519205; c=relaxed/simple;
	bh=a0ywURpwXp6Ch+RXxe+fppgK0QrL+KyFhF57mCEYTVU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Jkvyb/H9u5ao7pFXMPmH56csXiiwWB2vny8I3bGBGFuFqWp9sJAXq6u//omC0F8MmK5M2xdrjXuNM+TN2byL062/EXtPOm6E1K3KFUzhoqVM4nZXLbZ0K7hfaSnIx38CJBuqViuWF0u2nP1rV8BRFBvuVg8cyFnoU0dcw5Ma72w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YFeglS91; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-20cb47387ceso75973925ad.1;
        Wed, 13 Nov 2024 09:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731519203; x=1732124003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aux97D7sQGZHNOQCnimj2somiyMj9aLWgp4W224VQM8=;
        b=YFeglS91HGtdStAd7z2/W8En7RWzrN6oS0qS1Qv1XfKTs8i5Ij9WJ/OaHFWrnVP9Vq
         wEEjYnp/AzGqYITnqCET586JQ6OHr7fCVPYArU+b4nRMDLHihXRqARRrH5ygpcssJTCT
         A+mZqNzbxBJd4TpY88DRv1bUKE/RtkYJv/Iv2J/k/C/HJe69lQZpxU7lfm+r8fauT6+N
         Lq9KRt3fSHlqiai0WV5hC6fpsiVANBV4iB6uP0Ag2qtCXxRIjx32wtF2bujTrGEwVMYy
         4m7Vhxo+PoWan0uYi5ib2VCvNFRd4+n/0+hoqeSolwdAdi0EgDOhKNK9y4LAPGi1b9zz
         QPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519203; x=1732124003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aux97D7sQGZHNOQCnimj2somiyMj9aLWgp4W224VQM8=;
        b=GuGQJfLf7zvwu0HNz7cQOuvpPAfkcRR6HYg/G8it+YYyuMqAzZReHFx8We2z0ar496
         fqBdbOqHIwYTkU/kH+xAMn3569Y4/zzAcXeBK6Wd0ups2MUZGu6IlfP7v5WGJXzliBdL
         9uT+Oak27jdo6jzucAaKwVf1wR9RuxRnIknX888CEv0zVEjr0oT7EHGCknN3TodWo6bh
         ++r0zU/CciGQLwm9ywKUcU4tlhv3wDMG5T/lPpn2z9pqTusfQqJ+eEcaI/IgJUlIdeJX
         L6+HAaIvyV1w6xyoBI/90uCKVOQOJ8kHd7KCVryM23Veoc3nzd2Bjw90NpNaURQLCyyc
         ottw==
X-Forwarded-Encrypted: i=1; AJvYcCVmngRa81BvQ6l7nJll3WPG7LEvTMbvN1xDxRS/jGZP9mVKHGEQBzh7XYWdyAUCqlKK9HVFOTTL@vger.kernel.org, AJvYcCVnUf3LQc0X45NR3WB9h+UajyvH0RH0geFZH9sfMMnTl7HVcVEnLwbzA0i4uBz1UdkaETaRWiEWXxw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyA/U8Dib9r0TAd7aVTKpBSKsy6EYYztwoV7YqntCktnEBPegWY
	sSsFisD3QcU18n/gpaT6oOhMQOA3fge5/aUOOtRSp7qTIc+vs414
X-Google-Smtp-Source: AGHT+IEUx+Hu8gz7B4kW9m2Z15XEfm72UxuByLcQdNj/r5pm6lSMRtOWPTewy4q0Mz+xY0EHTvFG3Q==
X-Received: by 2002:a17:902:f541:b0:211:6b21:73d9 with SMTP id d9443c01a7336-2118359c225mr277915125ad.37.1731519203089;
        Wed, 13 Nov 2024 09:33:23 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7df5sm113140765ad.19.2024.11.13.09.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:33:22 -0800 (PST)
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
Subject: [PATCH net-next v5 5/7] bnxt_en: add support for header-data-split-thresh ethtool command
Date: Wed, 13 Nov 2024 17:32:19 +0000
Message-Id: <20241113173222.372128-6-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241113173222.372128-1-ap420073@gmail.com>
References: <20241113173222.372128-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bnxt_en driver has configured the hds_threshold value automatically
when TPA is enabled based on the rx-copybreak default value.
Now the header-data-split-thresh ethtool command is added, so it adds an
implementation of header-data-split-thresh option.

Configuration of the header-data-split-thresh is allowed only when
the header-data-split is enabled. The default value of
header-data-split-thresh is 256, which is the default value of
rx-copybreak, which used to be the hds_thresh value.

   # Example:
   # ethtool -G enp14s0f0np0 tcp-data-split on header-data-split-thresh 256
   # ethtool -g enp14s0f0np0
   Ring parameters for enp14s0f0np0:
   Pre-set maximums:
   ...
   Header data split thresh:  256
   Current hardware settings:
   ...
   TCP data split:         on
   Header data split thresh:  256

Tested-by: Stanislav Fomichev <sdf@fomichev.me>
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

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

 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 7 ++++++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 608bcca71676..27d6bac3a69a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4454,6 +4454,7 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
 static void bnxt_init_ring_params(struct bnxt *bp)
 {
 	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
+	bp->hds_threshold = BNXT_DEFAULT_RX_COPYBREAK;
 }
 
 /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
@@ -6429,7 +6430,7 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 					  VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
 		req->enables |=
 			cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
-		req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
+		req->hds_threshold = cpu_to_le16(bp->hds_threshold);
 	}
 	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
 	return hwrm_req_send(bp, req);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 3a7d2f3ebb2a..058db26fb255 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2362,6 +2362,8 @@ struct bnxt {
 	u8			q_ids[BNXT_MAX_QUEUE];
 	u8			max_q;
 	u8			num_tc;
+#define BNXT_HDS_THRESHOLD_MAX	256
+	u16			hds_threshold;
 
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index b0054eef389b..a51a4cedecb9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -833,6 +833,9 @@ static void bnxt_get_ringparam(struct net_device *dev,
 	ering->rx_pending = bp->rx_ring_size;
 	ering->rx_jumbo_pending = bp->rx_agg_ring_size;
 	ering->tx_pending = bp->tx_ring_size;
+
+	kernel_ering->hds_thresh = bp->hds_threshold;
+	kernel_ering->hds_thresh_max = BNXT_HDS_THRESHOLD_MAX;
 }
 
 static int bnxt_set_ringparam(struct net_device *dev,
@@ -868,6 +871,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
 	else if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
 		bp->flags &= ~BNXT_FLAG_HDS;
 
+	bp->hds_threshold = (u16)kernel_ering->hds_thresh;
 	bp->rx_ring_size = ering->rx_pending;
 	bp->tx_ring_size = ering->tx_pending;
 	bnxt_set_ring_params(bp);
@@ -5363,7 +5367,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
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


