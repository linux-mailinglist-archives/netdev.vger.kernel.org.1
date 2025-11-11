Return-Path: <netdev+bounces-237730-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CC8C4FC2D
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC8A4189671B
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 21:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F409A3AA198;
	Tue, 11 Nov 2025 20:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LDNY475t"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 619703A9BE9
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 20:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762894751; cv=none; b=PZcusb2PHFs7TkH4UiKD2MSBt7I4eeAjLnzJfLUhiyMOO2TwRwxf5hb+Ryi0qIa+9O3atSD0eC08ivdAvQ3yaqd+yY1LZ0mgvhWAGyW6r/Pz8Rpe4gcTHN+FijGCAZETRJYyjrErAssxBc0Rh1MptVFtIDnqnlSSAyOd1rukxyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762894751; c=relaxed/simple;
	bh=mrDZkwdQ14Mwae8MarBh0NSIneeIVWIw2Dx2Nr6IlDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzENwBa++fYTdck7vtEhzCf1qHv0n8sOZRmYx6DVsAbsto7LEnKL9iVsIWyOjxGPn2Z3eH1R9ITwp8RCcc3iECbShzcZrGSvghvwv5mzYOJKryKAtOF99/05PwwTBxu0pVsgaIaDz0dwFde16nJkspUoDlgop91e9YyPZy/wwCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=LDNY475t; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7c6d699610cso67202a34.0
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:59:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762894749; x=1763499549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyRmhC40tORy7magFBDMbFacme5UfcMblEolAfcxZG8=;
        b=IxR06TqHormek05zPpR6r8d7xvLZatJNlN4to0uRd0qO/VlRmeS6hw6XqcJ3LwhJnQ
         KTwyhC/OdLaSLUva2D5BbCZdhfWGv4+rSo04/KCNt8g9LogOBrIgltbgEh8vGIidqokM
         etPIUsI7R6OGEb/NL70AmzX1nIframK3xx8SE/OkPBzMnzS9kMdwQjjcBg7bwJTBotMi
         1JbmfGUINGePAEqJ7/6N/WfOgeQyROLf10pCidUaWjFqULoLGsgKqdGkBKuzCAFfZtme
         DGAxcoh4ZdYYBK1K6abxnf1J0RS7zwDWCEybH/z1lWUrAXfCriEPJWjzK/JRp4smBrQG
         qtuQ==
X-Gm-Message-State: AOJu0Yw9we+ngsHOVkMgTBT/Tp9ibjFELD7+Os4ykrYSx3XrNrszB5OP
	TrYeHukH9BjeUnEmpDzAs/xfVQ9Q8lmVgr4LtZ0LzOqd/ROc+vCr948gb25Rj1KGTO38ZTO1nGI
	qWsZuxAGmsUPLqYZapF+mQbGLBohcCpfawwdimv35iSv/M3OjZmDH1nes9vUyMPf6HfJ/Rl2EBj
	CttPlc9ZdbjHVxM1S2BymYzA56KhbQqyP5XIa4SEMYZrAchNnZHCUzVT9sD8V8qafb1bkxYnmA9
	2DDigXCJwrO6ys+babr
X-Gm-Gg: ASbGncvk3pbTuzX5P8zTDT4V/Af/Vftyu0/W5N/k3moPwNnacoJAULaelkSLLQSAWjN
	8XE/uAaZaJkd3NflNwnDdQHqspRykUmqfeT0y4jj4ljOer9kH5TyRqtqeWjIuybwgxiX6PxBiN2
	zxiAkksDjASo/fueGPfGmuuytp3fvIu+KqXLqNS3mEVSmqI/Ne565OMNXHTjtRndwLFP2Iok3XG
	LznDDCy3vlhAtKmcc9mdlYOwuMI/IpyVZC1eV5+xxWh7596J407lHo3XjVdOf9OefoGsamDQjVg
	Q/FmeGzeVl0Vgt+x0s51axJvJpvNnHNISli1pKO5NoqcnJqgk+iZuIS2gCGwZWILXtX4xKq3+Ka
	cPixbH1aZoXsBJYIl30U1OmjksdDKfukiQR6Bp7Y0E3+CovO+RETvoGtQ9nZURDu4p787QiLzSj
	6Z4i+o1EK5qMq6o4g9BiMQx7ZO5BSEXBZ59vb9H/66oLA=
X-Google-Smtp-Source: AGHT+IG7qA5tibPl10X8v1fwq+9MzbB904fg0FS71DhY/doiE4mRVLimIMXhKQ91jhNdke7hjU+WdaCB85EV
X-Received: by 2002:a05:6830:6d4c:b0:7c7:955:f120 with SMTP id 46e09a7af769-7c72e1f7161mr289936a34.11.1762894749257;
        Tue, 11 Nov 2025 12:59:09 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-101.dlp.protect.broadcom.com. [144.49.247.101])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7c6f0b17ea9sm1121079a34.0.2025.11.11.12.59.08
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Nov 2025 12:59:09 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-340d3b1baafso264290a91.3
        for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 12:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1762894747; x=1763499547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyRmhC40tORy7magFBDMbFacme5UfcMblEolAfcxZG8=;
        b=LDNY475tYiv/8NssCEioU916lIBV+RB9lPBF2NVyK6kt6S+rgqgp7JEbPhvhcEHngt
         KBwjVvk+YoJigW1XK4gzECY4z12insTZtSf84Y3LcagDixqw/BNpH/mv7jNHuBJgt5X0
         D/q+sTnu2hfij/LFQiY/dThVZMXRsKKFvn6+0=
X-Received: by 2002:a17:90b:1fc7:b0:32e:7bbc:bf13 with SMTP id 98e67ed59e1d1-343ddf0cf34mr670657a91.34.1762894747106;
        Tue, 11 Nov 2025 12:59:07 -0800 (PST)
X-Received: by 2002:a17:90b:1fc7:b0:32e:7bbc:bf13 with SMTP id 98e67ed59e1d1-343ddf0cf34mr670643a91.34.1762894746765;
        Tue, 11 Nov 2025 12:59:06 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf18b53574sm497131a12.38.2025.11.11.12.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 12:59:06 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [net-next 02/12] bng_en: Extend bnge_set_ring_params() for rx-copybreak
Date: Wed, 12 Nov 2025 02:27:52 +0530
Message-ID: <20251111205829.97579-3-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
References: <20251111205829.97579-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Add rx-copybreak support in bnge_set_ring_params()

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 19 +++++++++++++++++--
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  5 +++--
 2 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 4172278900b..8785bf57d82 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -13,6 +13,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if.h>
 #include <net/ip.h>
+#include <net/netdev_queues.h>
 #include <linux/skbuff.h>
 #include <net/page_pool/helpers.h>
 
@@ -2313,7 +2314,6 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 	rx_space = rx_size + ALIGN(NET_SKB_PAD, 8) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	bn->rx_copy_thresh = BNGE_RX_COPY_THRESH;
 	ring_size = bn->rx_ring_size;
 	bn->rx_agg_ring_size = 0;
 	bn->rx_agg_nr_pages = 0;
@@ -2352,7 +2352,10 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 		bn->rx_agg_ring_size = agg_ring_size;
 		bn->rx_agg_ring_mask = (bn->rx_agg_nr_pages * RX_DESC_CNT) - 1;
 
-		rx_size = SKB_DATA_ALIGN(BNGE_RX_COPY_THRESH + NET_IP_ALIGN);
+		rx_size = max3(BNGE_DEFAULT_RX_COPYBREAK,
+			       bn->rx_copybreak,
+			       bn->netdev->cfg_pending->hds_thresh);
+		rx_size = SKB_DATA_ALIGN(rx_size + NET_IP_ALIGN);
 		rx_space = rx_size + NET_SKB_PAD +
 			SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	}
@@ -2385,6 +2388,17 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 	bn->cp_ring_mask = bn->cp_bit - 1;
 }
 
+static void bnge_init_ring_params(struct bnge_net *bn)
+{
+	unsigned int rx_size;
+
+	bn->rx_copybreak = BNGE_DEFAULT_RX_COPYBREAK;
+	/* Try to fit 4 chunks into a 4k page */
+	rx_size = SZ_1K -
+		NET_SKB_PAD - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
+	bn->netdev->cfg->hds_thresh = max(BNGE_DEFAULT_RX_COPYBREAK, rx_size);
+}
+
 int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 {
 	struct net_device *netdev;
@@ -2474,6 +2488,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bn->rx_dir = DMA_FROM_DEVICE;
 
 	bnge_set_tpa_flags(bd);
+	bnge_init_ring_params(bn);
 	bnge_set_ring_params(bd);
 
 	bnge_init_l2_fltr_tbl(bn);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 85c4f6f5371..b267f0b14c1 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -136,7 +136,8 @@ struct bnge_ring_grp_info {
 	u16	nq_fw_ring_id;
 };
 
-#define BNGE_RX_COPY_THRESH     256
+#define BNGE_DEFAULT_RX_COPYBREAK	256
+#define BNGE_MAX_RX_COPYBREAK		1024
 
 #define BNGE_HW_FEATURE_VLAN_ALL_RX	\
 		(NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX)
@@ -187,7 +188,7 @@ struct bnge_net {
 	u32			rx_buf_size;
 	u32			rx_buf_use_size; /* usable size */
 	u32			rx_agg_ring_size;
-	u32			rx_copy_thresh;
+	u32			rx_copybreak;
 	u32			rx_ring_mask;
 	u32			rx_agg_ring_mask;
 	u16			rx_nr_pages;
-- 
2.47.3


