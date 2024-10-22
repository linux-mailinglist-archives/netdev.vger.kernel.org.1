Return-Path: <netdev+bounces-137952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B12289AB3D3
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D408284626
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D37491B5820;
	Tue, 22 Oct 2024 16:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HdlILm5R"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32FFF1B5328;
	Tue, 22 Oct 2024 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729614293; cv=none; b=hHdMj/wvtF8OIuOkNpFmzmxrc08bEmK559ydL9PkxczHFH15jce1UPdD0j6dlss3STsUkctlHVha4xhD5PBymGCurvXQiBQS27RnFuT0zQ3VYWv6DLZ/SXeRnPqAFUrpfaTjtNk7EndOZCFumOx3YbJu+5g+sI7E2tJYrdcrqEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729614293; c=relaxed/simple;
	bh=r43HHVuG45hKVbkKwTH13LCZ57WQBhv+WpnuCvGovXI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MyPEwgMApHPRCaqggMCSci/MVbEIrBSOruTmI3Z//5wqx1TAHH8qZ2PmTrGUnQbZ4i8bLFE0dC0jdu3wZfyhLv+LZEBgG3M8eor9DWu5jyVAXwGTzCN2k61NOpwGCcWxTXA2EOrIyWhlUtW2D664EKruVOyzvJyRJYNr70Bm60Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HdlILm5R; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-20c805a0753so50644055ad.0;
        Tue, 22 Oct 2024 09:24:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729614291; x=1730219091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hy95q8r37bfEG2aBYalMfLWWzDv1bix/9nybInsLQMc=;
        b=HdlILm5RS2uwN9KEhtG60u7OgkratYnrGLzlWyoaQY7A4J5gr3tomysoYH00niCwzg
         kt7EvLqnl6lIdBpBKg6nv9w++kqgj/pYor+jDwJ7jJDnL/W6CyHtQDvaMSht97OS7Os2
         chWfsCyB0FoGBfMYrX7FjhB2UNUgJ01e7oQ4d34WCsbEh5oMszWrRwCs3z6eMy9SE/6D
         0QjJAdFZfB/CyH7yHv+8wIlTyUuJgUGMwQ9fKQF1hg6ys9OiQhsxxR4K0dNXBQhtnEc6
         ldKcW2h9XVa/v2Ut5DYI33KDUZic61w5F04f/6oKvO9wUGdyEUlP0TIxoRDZiBH09Goh
         ED1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729614291; x=1730219091;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hy95q8r37bfEG2aBYalMfLWWzDv1bix/9nybInsLQMc=;
        b=hEaFVF44lY4xQyRdRoup2xlQXbhyevw6V41npcbmk2bBUf8E0n8itMDI9vTu8csuHW
         EPgagEgyi+i3vWmum0eejhdLIUSp92bXgSxPN4pntn1u+yyVy9VZyiMJsUH1imkqyYPy
         bxTUn6uaRwAQ7draJv9v5KwvOs6Pxp37xvCqrcarXXaXVwIq7p46qDIX/o09NZz0m3Qk
         X/i8s1zzoW6QN2bb69ZMf+u03fl50DLVuxLss6Cof5WfpsiathoLLoaem3RKWqx8V2Xr
         YLKSEJkQszYeTSX5Z4C7MiNsJJ8Jdc/3zQ7dzo0HaEgNgYssIstbJF8beAe0ZWwCzIez
         B+nA==
X-Forwarded-Encrypted: i=1; AJvYcCWygm+YbaX1GWS+TAR0ayj08qmJHL0LdPtm2suqgi24ZM1fzhmBzCDJN6++XvAN8JnhQBG4Puj9@vger.kernel.org, AJvYcCXLO84RnWSjGpguzOBQBT0EQxb+RPYszUjdGu9DKwxmNjMGz56XYA3W/qH485SA69+KMjoUZ34MpmM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpjRHrXbBnjWuVsa8AMvk9/UI5O7GABvZFwGl0nD9Rgabh3qnS
	d/E46D4qDah6U2HimNn1TVyclE/5K7fiqypXo8cbbrxhMZvIrU2+
X-Google-Smtp-Source: AGHT+IEMTTlf95wdKnnc911AeYwCz+7RCJqoqFpkhp9lbJv7+wjgr8Lg6+9msqm0NE1W31mVGpgxTw==
X-Received: by 2002:a17:903:2443:b0:20c:6bff:fca1 with SMTP id d9443c01a7336-20e5a7790f5mr201144755ad.23.1729614291278;
        Tue, 22 Oct 2024 09:24:51 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7eee6602sm44755205ad.1.2024.10.22.09.24.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 09:24:50 -0700 (PDT)
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
Subject: [PATCH net-next v4 4/8] bnxt_en: add support for header-data-split-thresh ethtool command
Date: Tue, 22 Oct 2024 16:23:55 +0000
Message-Id: <20241022162359.2713094-5-ap420073@gmail.com>
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
index 91ea42ff9b17..7d9da483b867 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4453,6 +4453,7 @@ void bnxt_set_tpa_flags(struct bnxt *bp)
 static void bnxt_init_ring_params(struct bnxt *bp)
 {
 	bp->rx_copybreak = BNXT_DEFAULT_RX_COPYBREAK;
+	bp->hds_threshold = BNXT_DEFAULT_RX_COPYBREAK;
 }
 
 /* bp->rx_ring_size, bp->tx_ring_size, dev->mtu, BNXT_FLAG_{G|L}RO flags must
@@ -6427,7 +6428,7 @@ static int bnxt_hwrm_vnic_set_hds(struct bnxt *bp, struct bnxt_vnic_info *vnic)
 					  VNIC_PLCMODES_CFG_REQ_FLAGS_HDS_IPV6);
 		req->enables |=
 			cpu_to_le32(VNIC_PLCMODES_CFG_REQ_ENABLES_HDS_THRESHOLD_VALID);
-		req->hds_threshold = cpu_to_le16(bp->rx_copybreak);
+		req->hds_threshold = cpu_to_le16(bp->hds_threshold);
 	}
 	req->vnic_id = cpu_to_le32(vnic->fw_vnic_id);
 	return hwrm_req_send(bp, req);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 432bc19b35ea..e467341f1e5b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2361,6 +2361,8 @@ struct bnxt {
 	u8			q_ids[BNXT_MAX_QUEUE];
 	u8			max_q;
 	u8			num_tc;
+#define BNXT_HDS_THRESHOLD_MAX	256
+	u16			hds_threshold;
 
 	unsigned int		current_interval;
 #define BNXT_TIMER_INTERVAL	HZ
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index 5172d0547e0c..73e821a23f56 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -840,6 +840,9 @@ static void bnxt_get_ringparam(struct net_device *dev,
 	ering->rx_pending = bp->rx_ring_size;
 	ering->rx_jumbo_pending = bp->rx_agg_ring_size;
 	ering->tx_pending = bp->tx_ring_size;
+
+	kernel_ering->hds_thresh = bp->hds_threshold;
+	kernel_ering->hds_thresh_max = BNXT_HDS_THRESHOLD_MAX;
 }
 
 static int bnxt_set_ringparam(struct net_device *dev,
@@ -869,6 +872,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
 		break;
 	}
 
+	bp->hds_threshold = (u16)kernel_ering->hds_thresh;
 	bp->rx_ring_size = ering->rx_pending;
 	bp->tx_ring_size = ering->tx_pending;
 	bnxt_set_ring_params(bp);
@@ -5357,7 +5361,8 @@ const struct ethtool_ops bnxt_ethtool_ops = {
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


