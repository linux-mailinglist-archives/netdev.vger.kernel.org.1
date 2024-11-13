Return-Path: <netdev+bounces-144502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 70F859C7A1F
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 18:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0EBDB2778D
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 17:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883402022E2;
	Wed, 13 Nov 2024 17:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fJXns/FM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED6442022EA;
	Wed, 13 Nov 2024 17:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731519188; cv=none; b=L4M71jSMvrNRiiMsCtcy5hIwmWxD1LcBIat3OtQ0ck3hp7oVTS7vqvxlZ1TJYZvBZkVQVx6m6cSfrb+Ko9lICN0b2kupGs5lgNKAlgFoS6zcVNOrMQpk+Bfwbt+0zNWPAEt1q7Et3hmGAf08aolTTtD9ONx2+Xec3akYg5MvkNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731519188; c=relaxed/simple;
	bh=28VI3Ejowj0Y4k0yUbjgXhUpafNQk9OsXPmVwl0rans=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lPTuRYowFf70u983Lk5/lKuWxeazpRJLNTl7La+UGKxF5rfc3rWCEd5SGPcf64SfZovVQELn0vNQJ4xVcSxpOdJWHZkGrBLgfDRy3wsmmocj4spPCVAsnyMCZrSE++UDhYLCB35pKA98jotw1VVvJ2CHqEzyoqvdwmeRJx1qMZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fJXns/FM; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20cb7139d9dso68805865ad.1;
        Wed, 13 Nov 2024 09:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731519185; x=1732123985; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=amy2lNuziNprXzNpSXa/Em2y3IstMk3e4quzHvr6Z64=;
        b=fJXns/FMhJ1TJjkIePF+OLTpZVMWbQK9EdcNsR9/0+l1NboeAocUPnNukqHs3dPkGY
         RIr/Eb2do1z62iXpB6Mi2tOUSyTxzO6PLppCbaFw4rZ/D4t8EGl8moX46SUwD/dNOMT4
         yYJUn5UM8D61fDuSpPIjM8F4KpDZQr/FFIEt3ZBIUzzityqWwhSRENxyZgPBwHXumLw3
         ZEPLOcGXglGvuw5f7gcIxO3SsiWWoQlYpgsAzmefLAj3VN216O0tmNhPqszVtMYIcTOx
         puerTgtcfT2WL2gDulz65AjZii4nXltmPjSH+zssdkM+AX6Qxksjhp+HVsOPSJOUb96l
         e+bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731519185; x=1732123985;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amy2lNuziNprXzNpSXa/Em2y3IstMk3e4quzHvr6Z64=;
        b=o2MaHpxdGryPKatnL1sxx6MyNzr+m4D4PZA+K0EOGi6NL+3kFM+9/TQk2jJugg4VfS
         Hvnjw/2zTEPwWYFpMzaae0dlXZeCbfZ0oGPmpqrx03ry6rV0FdH0x5L5Y/KPAiairfhg
         0LpYwMb63QkhEe5WtTprzGnqoORFYYv4Rrqu/D4B/G+j1K2SzrXJRL8t/H14gnRpiOOq
         vXYXLauPvAdaniHqVqGpTvwusvQOD3SPb7Vq9jFi7hWU3pioIdagwkC5SVZWBWPeb/H5
         S5ixa/KpasaZCRQLV6I6VbEqX7AjvoUnCKoXb2NMx7BqXNPeUI/osfnA7/qJWBfHHXGF
         /CGA==
X-Forwarded-Encrypted: i=1; AJvYcCU1Otd1Al7qB50Dakrq2uL16d2/QOAMQ2MMDF4NxSLKMH+3cEFzA2oMBVdxdINTcjdbRrg0zV3Sbqk=@vger.kernel.org, AJvYcCWSASIy3kmyqH43wxhZN1Seip5luT9xkTMEMBtgfND3kf7gYqI9F41kd1aKDujQQoRED2SnQCft@vger.kernel.org
X-Gm-Message-State: AOJu0YwwY0BKmjflow3uWwaEkRmP034vMDk9dwpwSZBd4f+C30URq0GZ
	goPbONtVkjmf41BPVSKFcFFAwgsTPdSVxUEA3IvR9xFj/9VpruR/
X-Google-Smtp-Source: AGHT+IH9x4SJxPM2GxLCSJtUCzv4mHUufsz/223ZQf+3joz4oj8B0tw9AD7gWzrLPOU4yP7Z0yst5g==
X-Received: by 2002:a17:903:41c3:b0:20c:e65c:8c6c with SMTP id d9443c01a7336-21183d34368mr269317115ad.19.1731519185064;
        Wed, 13 Nov 2024 09:33:05 -0800 (PST)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21177dc7df5sm113140765ad.19.2024.11.13.09.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 09:33:04 -0800 (PST)
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
Subject: [PATCH net-next v5 3/7] bnxt_en: add support for tcp-data-split ethtool command
Date: Wed, 13 Nov 2024 17:32:17 +0000
Message-Id: <20241113173222.372128-4-ap420073@gmail.com>
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
Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

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
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 19 +++++++++++++++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d521b8918c02..608bcca71676 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -4474,7 +4474,7 @@ void bnxt_set_ring_params(struct bnxt *bp)
 	bp->rx_agg_ring_size = 0;
 	bp->rx_agg_nr_pages = 0;
 
-	if (bp->flags & BNXT_FLAG_TPA)
+	if (bp->flags & BNXT_FLAG_TPA || bp->flags & BNXT_FLAG_HDS)
 		agg_factor = min_t(u32, 4, 65536 / BNXT_RX_PAGE_SIZE);
 
 	bp->flags &= ~BNXT_FLAG_JUMBO;
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index d1eef880eec5..3a7d2f3ebb2a 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -2202,8 +2202,6 @@ struct bnxt {
 	#define BNXT_FLAG_TPA		(BNXT_FLAG_LRO | BNXT_FLAG_GRO)
 	#define BNXT_FLAG_JUMBO		0x10
 	#define BNXT_FLAG_STRIP_VLAN	0x20
-	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
-					 BNXT_FLAG_LRO)
 	#define BNXT_FLAG_RFS		0x100
 	#define BNXT_FLAG_SHARED_RINGS	0x200
 	#define BNXT_FLAG_PORT_STATS	0x400
@@ -2224,6 +2222,9 @@ struct bnxt {
 	#define BNXT_FLAG_ROCE_MIRROR_CAP	0x4000000
 	#define BNXT_FLAG_TX_COAL_CMPL	0x8000000
 	#define BNXT_FLAG_PORT_STATS_EXT	0x10000000
+	#define BNXT_FLAG_HDS		0x20000000
+	#define BNXT_FLAG_AGG_RINGS	(BNXT_FLAG_JUMBO | BNXT_FLAG_GRO | \
+					 BNXT_FLAG_LRO | BNXT_FLAG_HDS)
 
 	#define BNXT_FLAG_ALL_CONFIG_FEATS (BNXT_FLAG_TPA |		\
 					    BNXT_FLAG_RFS |		\
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index adf30d1f738f..b0054eef389b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -840,6 +840,8 @@ static int bnxt_set_ringparam(struct net_device *dev,
 			      struct kernel_ethtool_ringparam *kernel_ering,
 			      struct netlink_ext_ack *extack)
 {
+	u8 tcp_data_split_mod = kernel_ering->tcp_data_split_mod;
+	u8 tcp_data_split = kernel_ering->tcp_data_split;
 	struct bnxt *bp = netdev_priv(dev);
 
 	if ((ering->rx_pending > BNXT_MAX_RX_DESC_CNT) ||
@@ -847,9 +849,25 @@ static int bnxt_set_ringparam(struct net_device *dev,
 	    (ering->tx_pending < BNXT_MIN_TX_DESC_CNT))
 		return -EINVAL;
 
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
+	    tcp_data_split_mod)
+		return -EOPNOTSUPP;
+
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    tcp_data_split_mod && BNXT_RX_PAGE_MODE(bp)) {
+		NL_SET_ERR_MSG_MOD(extack, "tcp-data-split is disallowed when XDP is attached");
+		return -EOPNOTSUPP;
+	}
+
 	if (netif_running(dev))
 		bnxt_close_nic(bp, false, false);
 
+	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
+	    tcp_data_split_mod)
+		bp->flags |= BNXT_FLAG_HDS;
+	else if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_UNKNOWN)
+		bp->flags &= ~BNXT_FLAG_HDS;
+
 	bp->rx_ring_size = ering->rx_pending;
 	bp->tx_ring_size = ering->tx_pending;
 	bnxt_set_ring_params(bp);
@@ -5345,6 +5363,7 @@ const struct ethtool_ops bnxt_ethtool_ops = {
 				     ETHTOOL_COALESCE_STATS_BLOCK_USECS |
 				     ETHTOOL_COALESCE_USE_ADAPTIVE_RX |
 				     ETHTOOL_COALESCE_USE_CQE,
+	.supported_ring_params	= ETHTOOL_RING_USE_TCP_DATA_SPLIT,
 	.get_link_ksettings	= bnxt_get_link_ksettings,
 	.set_link_ksettings	= bnxt_set_link_ksettings,
 	.get_fec_stats		= bnxt_get_fec_stats,
-- 
2.34.1


