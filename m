Return-Path: <netdev+bounces-127436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDF7297562E
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 16:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E65281C9A
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DBFF1AB531;
	Wed, 11 Sep 2024 14:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNtevY0j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6D91AB52C;
	Wed, 11 Sep 2024 14:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066600; cv=none; b=OtBsOKO+eSvqiuNWqUS2axM7MDHCei4m8Q5OVzBZseCpdDEZvdOhSJlYXTbd3xRvfxOVn1Eqj5Ij86explfmhSJK1dH9eMZ3PK6jdd+f6uw5yMZ+1PFIiJQzYRX4dy80sYRdk2s5N9+AUXsH20UCvhzdjLZFerfugigtrH1ncVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066600; c=relaxed/simple;
	bh=EVKiSEr7Zmf+toAJhWkO8ac2WuWLD0rTI5Vk+3jNtCw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t/RCEXsNXuq9/8n0qyCuZFXLA1kh1qmXd8KQkcc0g60kQKlpk37T+VPHO6BxR569GSysHw4fwi5GyxzJrU2PtoNxVrvip2RSEzfTKqsJjCa6msSMBPBEt+IbLgd8x9vmyWkwzTysmsdYbpK2bpZkypK8MyWLkVTZcN/St4YqSEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNtevY0j; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7179802b8fcso4995463b3a.1;
        Wed, 11 Sep 2024 07:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726066599; x=1726671399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8APndETeuPsExoHgnwBfUz0vE90PM6EECgehWNUr71I=;
        b=HNtevY0jIiU9o5hv06Yk1J9NH2A4eO2OVVlYyYf9AfDrSo068m4GZbDRO+CJ8hmobc
         oh7Wc9rWKRZVuAChqgYwyJTNwEnzi/UwF19pjkbjcz+kuILVhwbDnPVCvT954ktQB4+3
         t0XEdsUamP3osbd0WWrnvHSNG6ai9DPygKHSmRW/ZTCqQzU3pW79XiCAJPTGRgmDepb+
         g+CF/QODVC5t+VrXyGnD8cA8eqSnRqF6Lf+9BeUVMzZnP2b0UOsKXymZDW7HeUU06cra
         b3Ub5Fn5Cr1EiLVRSFEGdL8bEDVCx5xgm2b+BHd0wLkzdXCttqowJFgXWGHzuKPfwqgL
         60CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726066599; x=1726671399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8APndETeuPsExoHgnwBfUz0vE90PM6EECgehWNUr71I=;
        b=AjW/VqC/iKh3oqS8o4ULAZ6C0RutKGkBE1XlPwQeIjPP/9SR/C6eql+l8tHEpRthIM
         YlNg6ZQA0xKjl8dejJqzrZCinF8ktWXSlqu+FdRxGh9THCgL/d8kkvE9knBe1iehOo8F
         cZAm55uWgAocY1hzCBRmzuDFC8sTe8bj6vzyKl5AzimxHOTIZiBe5PmqqCwnv2z6vp4p
         wYaRElwpqDQ3e+AhZN0U4vHsl1abSa2IW7ic5xAxSH3LLHz8Xben5Bqy603ttbXrq+xt
         HHtZzX6dn4sBKD1sNCUcc/owNvE3EEx5hXaBqHLr4wxL/39OIA3oKTa2Blv585cRBCPq
         lj+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWGOJho+gEdRdwrmEhDvdRyDeEbkg8iUkLAgUAhOXgq3Tjny/xrG5jRcvGl8H6BkXH88TuIijEcgRY=@vger.kernel.org, AJvYcCWzNBUSivbWKdRc94y7WoESDP6Hm9SoP2zAnMfoC7ugExQkPso14+6CGTgrBl/wcjsqYnMUUOez@vger.kernel.org
X-Gm-Message-State: AOJu0Yxk5XIf3x6e9v7KYkbRJcCMg6XpYjnLN/hfhTH8Hr5lRZK6mqnu
	H9Q43z3YvP4CbQSUNeeTi3G7wbOHYGQ534GsEmOQmhjqQF8AdwL9
X-Google-Smtp-Source: AGHT+IGy9OSvr42m8WJ46ZATfSY9G59MIEIg3PMHu7SfwmYHtI8wBF7ebNJ9knnfQmsre2+z+7QF+A==
X-Received: by 2002:a05:6a20:551f:b0:1cf:66a1:4d8e with SMTP id adf61e73a8af0-1cf66a14e2bmr3142494637.17.1726066598732;
        Wed, 11 Sep 2024 07:56:38 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2076af278aasm664995ad.28.2024.09.11.07.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 07:56:36 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	corbet@lwn.net,
	michael.chan@broadcom.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org
Cc: ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	kory.maincent@bootlin.com,
	ahmed.zaki@intel.com,
	paul.greenwalt@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	aleksander.lobakin@intel.com,
	ap420073@gmail.com
Subject: [PATCH net-next v2 4/4] bnxt_en: add support for tcp-data-split-thresh ethtool command
Date: Wed, 11 Sep 2024 14:55:55 +0000
Message-Id: <20240911145555.318605-5-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240911145555.318605-1-ap420073@gmail.com>
References: <20240911145555.318605-1-ap420073@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bnxt_en driver has configured the hds_threshold value automatically
when TPA is enabled based on the rx-copybreak default value.
Now the tcp-data-split-thresh ethtool command is added, so it adds an
implementation of tcp-data-split-thresh option.

Configuration of the tcp-data-split-thresh is allowed only when
the tcp-data-split is enabled. The default value of
tcp-data-split-thresh is 256, which is the default value of rx-copybreak,
which used to be the hds_thresh value.

   # Example:
   # ethtool -G enp14s0f0np0 tcp-data-split on tcp-data-split-thresh 256
   # ethtool -g enp14s0f0np0
   Ring parameters for enp14s0f0np0:
   Pre-set maximums:
   ...
   Current hardware settings:
   ...
   TCP data split:         on
   TCP data split thresh:  256

It enables tcp-data-split and sets tcp-data-split-thresh value to 256.

   # ethtool -G enp14s0f0np0 tcp-data-split off
   # ethtool -g enp14s0f0np0
   Ring parameters for enp14s0f0np0:
   Pre-set maximums:
   ...
   Current hardware settings:
   ...
   TCP data split:         off
   TCP data split thresh:  n/a

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v2:
 - Patch added.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 9 +++++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f046478dfd2a..872b15842b11 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4455,6 +4455,7 @@ static void bnxt_init_ring_params(struct bnxt *bp)
 {
 	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
 	bp->flags |= BNXT_FLAG_HDS;
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
index 35601c71dfe9..48f390519c35 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2311,6 +2311,8 @@ struct bnxt {
 	int			rx_agg_nr_pages;
 	int			rx_nr_rings;
 	int			rsscos_nr_ctxs;
+#define BNXT_HDS_THRESHOLD_MAX	256
+	u16			hds_threshold;
 
 	u32			tx_ring_size;
 	u32			tx_ring_mask;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index ab64d7f94796..5b1f3047bf84 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -839,6 +839,8 @@ static void bnxt_get_ringparam(struct net_device *dev,
 	else
 		kernel_ering->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_DISABLED;
 
+	kernel_ering->tcp_data_split_thresh = bp->hds_threshold;
+
 	ering->tx_max_pending = BNXT_MAX_TX_DESC_CNT;
 
 	ering->rx_pending = bp->rx_ring_size;
@@ -864,6 +866,12 @@ static int bnxt_set_ringparam(struct net_device *dev,
 		return -EINVAL;
 	}
 
+	if (kernel_ering->tcp_data_split_thresh > BNXT_HDS_THRESHOLD_MAX) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "tcp-data-split-thresh size too big");
+		return -EINVAL;
+	}
+
 	if (netif_running(dev))
 		bnxt_close_nic(bp, false, false);
 
@@ -871,6 +879,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
 	case ETHTOOL_TCP_DATA_SPLIT_UNKNOWN:
 	case ETHTOOL_TCP_DATA_SPLIT_ENABLED:
 		bp->flags |= BNXT_FLAG_HDS;
+		bp->hds_threshold = (u16)kernel_ering->tcp_data_split_thresh;
 		break;
 	case ETHTOOL_TCP_DATA_SPLIT_DISABLED:
 		bp->flags &= ~BNXT_FLAG_HDS;
-- 
2.34.1


