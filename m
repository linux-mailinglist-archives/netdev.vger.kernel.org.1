Return-Path: <netdev+bounces-153005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6125D9F68E9
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 15:48:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 927577A48EF
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 14:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F64B1C5CA6;
	Wed, 18 Dec 2024 14:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnLDRKS7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5251C173D;
	Wed, 18 Dec 2024 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734533254; cv=none; b=qN6DWG9sTGRDULQxv6KDU44B//4k7Tiu+7YPIEAH1sqndGvxkIMNGd/RfOLQ8Li1ZtUBoMmoRfKJBZ/1hPXc+RXJ8TIV989CjoxbYHNVnEP7VykJXSmYKNak2Jaa+uiRR1qnZqdTCX9/Xbl7uWuR7z8YJwknV7v5p+71GaXj/Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734533254; c=relaxed/simple;
	bh=8YM8iAR9+QKCqaHmSP6TVLMsr/5O5UQQs+bBLc15YCo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cT3EXvycjTySwu6evRr2fUL9Ib7SKBMxprS5IF34ky6h8CXqa6yv5jZSIVURzvwld5n4sOhvOXpz6DDD3LtitjA30Pa9KB/+fRGjuZKy8d/RamSbwqT7x4nN4DxLbvBjxGPTdIr3PFNBGiDmUw9pAVqeglaAxqyj5fWaxYqZZ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnLDRKS7; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-725c86bbae7so5751819b3a.3;
        Wed, 18 Dec 2024 06:47:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734533252; x=1735138052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLj75mm4bSKqr3MH7QwBOZtnbqJWJgdC12woJpde5Ko=;
        b=DnLDRKS7c7JmEp+n10Su5TOKKH6iwAKC/yTTPoMldd2d45LSKKY9V9oDDv9c0pYgPB
         mh+hnw9Sdy+eqRh/ecrrn/KkyIHgStnhl3RJn6pA++VjglCcIYmknByrTBhnmuhD0T2G
         wT2ZyWsRzYF5QzIN13zc/EEzeg8gxCCHgbLsBD2fbu/Ip+IfyM2I96yK6zLmofRv4sNj
         F0a/Qaun1KoJHLlDltc2dOQpWE+kQJxFEE7tH5wh1MvL/3VJV0RDaY24ykYEkF+4Lkgj
         EMW9mgj3+6Z6URvLxTD3/tTx3JtWoCvLdJcu6G1hUSi1eo/z7q0MXh2inAFVUMVArk1/
         N81g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734533252; x=1735138052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LLj75mm4bSKqr3MH7QwBOZtnbqJWJgdC12woJpde5Ko=;
        b=qjpkAAtJodOEw7Ou1p+XsU8FW5LmMRuFr8QwK4t3RKfOTtDmpVm24sNkX0rPpWcnHd
         ht7uBXixmHblrGNdSdQ02Ossqd5Hs5L4GfYG661memKqt2agbzkgbid5wR7Gk41k18VJ
         JB0JK9zzWxNBUUdVK+JHvVzughy3pprHXqjZ5RtrGX69TkMgltdnkhvts9tt6nWNOeMz
         7ZTHN6y1AlBGMFbg7tFvnm4SPl/yHmlgsCAUtE8D9oktwL3I4e0uRgY1YbxqqB++odgW
         m2rgSZQ5ebFac1J1fXVwhdX4bbTDflilkoTeJqrdG7XRVpSNx/VWj9jDk85ahhu7XHTd
         yaig==
X-Forwarded-Encrypted: i=1; AJvYcCX8h4u1n7cIdYUh1eDIHC9++HZeDNnnZ6ezgMfB9LTGjNrjdRN4lSC8liaIBQN5TeKYt0N5QPic@vger.kernel.org, AJvYcCXxxLVYFHofhdnNBDpkuiaB7NVchjyVCWtPwsRswL49jCZmS2vR7uPCPkX7GPNNx5eOKb+aNaOgg4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza0+ZeCDEuxjjr5KRP+fzrZ+QP5BI0uL0OMRhMFLWmv0xEgFb4
	VVM+9NNgDVU5ZFAMEwL9wJ9tEjsn9N5EiEekScRZ0oHMuwMmB5Gx
X-Gm-Gg: ASbGncvKKETEiQ8q/1ki1mTgaPn/AuQ4HabBHaeIKsY2zoVgcLuWJznYkpLg+72WqAg
	XBRCapnlhBGpbW9TvvKHaKWXg9gkQMBU9mBKDnm35Vao9HkwUEE8JVvHRpkUux+bYP6GtLipCUj
	BQ/GPp+C5iLRbjzfn1e3QTZlX7JuYQ23Jy9i/nh4SR4kgvEAMIHRNDP1M6lvB1l3B4/mOYmKh4l
	IGp84o/Od2FpgEO+4c3b6BQp7xTP/c4ZRFDCBkFBONOyw==
X-Google-Smtp-Source: AGHT+IElePXpmfejI03ZVIWyz9L2q0s4RbYiYRe/U6V82PBPiG2lMdcaZEcz6bgPESNScSXKgZftDw==
X-Received: by 2002:a05:6a00:3905:b0:725:9f02:489a with SMTP id d2e1a72fcca58-72a8d2c4061mr4177044b3a.17.1734533251933;
        Wed, 18 Dec 2024 06:47:31 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72918ac5183sm8912687b3a.29.2024.12.18.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Dec 2024 06:47:31 -0800 (PST)
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
Subject: [PATCH net-next v6 5/9] bnxt_en: add support for hds-thresh ethtool command
Date: Wed, 18 Dec 2024 14:45:26 +0000
Message-Id: <20241218144530.2963326-6-ap420073@gmail.com>
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

 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 7 ++++++-
 3 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 42ffaa88ae4e..5b16b2ef7739 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4603,6 +4603,7 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
 static void bnxt_init_ring_params(struct bnxt *bp)
 {
 	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
+	bp->hds_threshold = BNXT_DEFAULT_RX_COPYBREAK;
 }
 
 /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
@@ -6578,7 +6579,7 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 					  VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
 		req->enables |=
 			cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
-		req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
+		req->hds_threshold = cpu_to_le16(bp->hds_threshold);
 	}
 	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
 	return hwrm_req_send(bp, req);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 847dedf61a9e..8fc4d630ee21 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2404,6 +2404,8 @@ struct bnxt {
 	u8			q_ids[BNXT_MAX_QUEUE];
 	u8			max_q;
 	u8			num_tc;
+#define BNXT_HDS_THRESHOLD_MAX	1023
+	u16			hds_threshold;
 
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 25eb5931aea9..921e7e8333e8 100644
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
@@ -870,6 +873,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
 			bp->flags &= ~BNXT_FLAG_HDS;
 	}
 
+	bp->hds_threshold = (u16)kernel_ering->hds_thresh;
 	bp->rx_ring_size = ering->rx_pending;
 	bp->tx_ring_size = ering->tx_pending;
 	bnxt_set_ring_params(bp);
@@ -5374,7 +5378,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
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


