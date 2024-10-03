Return-Path: <netdev+bounces-131676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3AB98F394
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 18:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3381F2127B
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0549C1A4F30;
	Thu,  3 Oct 2024 16:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ImjvmkAR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3F6145B1F;
	Thu,  3 Oct 2024 16:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727971627; cv=none; b=f/UmWQVIM89Y/NEZeOt91R2X+5Ib9OWWprJCUB+M/iGYLhT3NfJGCLlKEb7NjkGQRTJinRjE1IFNm59LdEm7xBSkVW6h1Df43TWwkzw7diTDGDI7DWjFYwc+wkSkiszri0K2a/P8gCZYwdYecmXAUtrINn3O1nQN91QYpwrfrnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727971627; c=relaxed/simple;
	bh=dJyNekBNc8xXABNnImPmso0iUEUZlWUfmjCiYWP14Bg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N8Oe7PVvquTw0Gfa1NFBtlTdk0oGO4UoyHoJbX3N8k02GNrUkdqZhvQbuk47MuI+bOg+8JN25mtZ3ycUzsZhoZO5AkwS2MYFMRsSdh5hy7E667Z3xMvmNRb+iYZU9D9TTS/Eu+7M44wfg4MzpwG84TM+a1f+Q3c9FnLM7RNeFqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ImjvmkAR; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2e09a276ec6so971859a91.0;
        Thu, 03 Oct 2024 09:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727971625; x=1728576425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PGWzXPKXZdtX1z7l0g6rkXvuhx9rs3LPkv24/Z68kAY=;
        b=ImjvmkAROcmdwT9U+q8Wrfus0nHywqDlsmb9RmMMZ1EwN5D6bnEES2z8lRdbwx9Cdj
         vhQFcvPcPY2jRGPVMxaWOBcK4CxgjKLzp2PwYRARnXs29nBx0Ah87UKC/nFzxcxjuva+
         vxdg7G8ZUF1QvEFnqzHednSYqekyZJdYw9yNgjtBrgVTr/1FD+U2ba3KsBtzXcwhS6cX
         5viSw7XeKXv1AToWeUzg6X5BLFVbLAt7p92NAfurAhceMRWn7k84pV0SZisAFM5Q0Kba
         UvGBBeW8fpoMPYteIKvxfySlxpsBRdRt/CBJzaV2JZE1gHyMCHBPSztHm/UDUcCXyb6r
         Oxdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727971625; x=1728576425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PGWzXPKXZdtX1z7l0g6rkXvuhx9rs3LPkv24/Z68kAY=;
        b=HRfe2Rlhd8MGwuL6u12rl1mey5QzNAHsKC8OKeH4IPEczbMUA9csnez6uuVvWqbITf
         WFMo1xiJRXyhq204sNz3fXVWxuTSEvzaTlQTVt56r4aZZXNppnJ6gBnSxFO2cFA08TI9
         QGQRcZMOOFxn6T8Z34jPQy8NrtGkGVOJe8wTLkjdjv8e6FKLNn75I8EyztbPuyoGX2Lx
         rKGOhF931ajVaxxodvYE462snjdG6PXrS41CwCMQqWZOv69JLK+zzkKM1niJFL8tD3D8
         QSh+vIqaPH3m6Cn88pPnKLOAyR74X3oY/Dnr2o0mmyIT6YXlwhU/vjBvEOYpcsDieVem
         i8dQ==
X-Forwarded-Encrypted: i=1; AJvYcCUmrICRXO1fCICF4TT178I93M/q9xEb7tP/dv8SITFJRQWvYC+j2MkUQvLo9VbrfqOiKhK62Dy7@vger.kernel.org, AJvYcCWl5UCKNlQCFv6wK+7uJ5J+RHqbiBYXBGnWtFYe7U5zs9beeOijjUsCNaoCVYJRCqEiL4TWzINEjNc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNdt4eksfJtFNufTKRMN73v8PE/bdZHum5jLJIH16oXzz7N+2S
	F4qCRFgEa6kzM1+chmopd0o+VSpQttQaHyUofU/PWrWzbjvxbcPD
X-Google-Smtp-Source: AGHT+IHd88tWg+GAZM5L8SwqHpasZ2OsB82J9zIx3y/+bYDhetGMZ+mwaqGfs63UwgPG4L1vlqE/Gw==
X-Received: by 2002:a17:90b:3908:b0:2e0:7d60:759 with SMTP id 98e67ed59e1d1-2e18456b525mr8751634a91.3.1727971625398;
        Thu, 03 Oct 2024 09:07:05 -0700 (PDT)
Received: from ap.. ([182.213.254.91])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20bef7071f1sm10425435ad.292.2024.10.03.09.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Oct 2024 09:07:04 -0700 (PDT)
From: Taehee Yoo <ap420073@gmail.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	almasrymina@google.com,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	donald.hunter@gmail.com,
	corbet@lwn.net,
	michael.chan@broadcom.com
Cc: kory.maincent@bootlin.com,
	andrew@lunn.ch,
	maxime.chevallier@bootlin.com,
	danieller@nvidia.com,
	hengqi@linux.alibaba.com,
	ecree.xilinx@gmail.com,
	przemyslaw.kitszel@intel.com,
	hkallweit1@gmail.com,
	ahmed.zaki@intel.com,
	paul.greenwalt@intel.com,
	rrameshbabu@nvidia.com,
	idosch@nvidia.com,
	asml.silence@gmail.com,
	kaiyuanz@google.com,
	willemb@google.com,
	aleksander.lobakin@intel.com,
	dw@davidwei.uk,
	sridhar.samudrala@intel.com,
	bcreeley@amd.com,
	ap420073@gmail.com
Subject: [PATCH net-next v3 4/7] bnxt_en: add support for tcp-data-split-thresh ethtool command
Date: Thu,  3 Oct 2024 16:06:17 +0000
Message-Id: <20241003160620.1521626-5-ap420073@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241003160620.1521626-1-ap420073@gmail.com>
References: <20241003160620.1521626-1-ap420073@gmail.com>
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
   TCP data split thresh:  256
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
   TCP data split thresh:  256
   Current hardware settings:
   ...
   TCP data split:         off
   TCP data split thresh:  n/a

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---

v3:
 - Drop validation logic tcp-data-split and tcp-data-split-thresh.

v2:
 - Patch added.

 drivers/net/ethernet/broadcom/bnxt/bnxt.c         | 3 ++-
 drivers/net/ethernet/broadcom/bnxt/bnxt.h         | 2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

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
index e9ef65dd2e7b..af6ed492f688 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -839,6 +839,9 @@ static void bnxt_get_ringparam(struct net_device *dev,
 	else
 		kernel_ering->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_DISABLED;
 
+	kernel_ering->tcp_data_split_thresh = bp->hds_threshold;
+	kernel_ering->tcp_data_split_thresh_max = BNXT_HDS_THRESHOLD_MAX;
+
 	ering->tx_max_pending = BNXT_MAX_TX_DESC_CNT;
 
 	ering->rx_pending = bp->rx_ring_size;
@@ -871,6 +874,7 @@ static int bnxt_set_ringparam(struct net_device *dev,
 	case ETHTOOL_TCP_DATA_SPLIT_UNKNOWN:
 	case ETHTOOL_TCP_DATA_SPLIT_ENABLED:
 		bp->flags |= BNXT_FLAG_HDS;
+		bp->hds_threshold = (u16)kernel_ering->tcp_data_split_thresh;
 		break;
 	case ETHTOOL_TCP_DATA_SPLIT_DISABLED:
 		bp->flags &= ~BNXT_FLAG_HDS;
-- 
2.34.1


