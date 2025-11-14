Return-Path: <netdev+bounces-238755-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B075C5F1C3
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 20:54:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBBC04E829D
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 19:54:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111592F6193;
	Fri, 14 Nov 2025 19:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="WebSyHjv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f99.google.com (mail-yx1-f99.google.com [74.125.224.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1812561AE
	for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 19:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763150039; cv=none; b=S3fPvM7DM6J9GuOae8ZlQnTXctz1tFEPU8QHR3bdc/DSSxo/GxKXFodbhCbhKK4ckgQAD7cBQkVeYziCr1pl87mBbcxUx5yZOKvUIYPJKcu9xFOYPNTwB9SbQoeROQPQlieCzFHPVKmuJR3007Vp4HDfW2gbDGk9tw1xa181V8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763150039; c=relaxed/simple;
	bh=mrDZkwdQ14Mwae8MarBh0NSIneeIVWIw2Dx2Nr6IlDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+Zt/ephmJiBy3U4AcjaNCJda4TPxKziTnXEbe7dt8xCehYLk4nMCGj5QSuLB0CRzDaSmeNVTsuIIinVlSKHjokMAdifVbHpMsHAcj2K25SZcGXR6lpfZUCww8H/bKY9gZgJJD+NaCgeb9Yj4HZe57mF3K2gNFA8lvrAb8LSXNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=WebSyHjv; arc=none smtp.client-ip=74.125.224.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f99.google.com with SMTP id 956f58d0204a3-640d0895d7cso3029776d50.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:53:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763150036; x=1763754836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JyRmhC40tORy7magFBDMbFacme5UfcMblEolAfcxZG8=;
        b=tWAqNMwQFkjXiCmpObKqMms2g6gIVLE5yUVPBXp05tSx/kywY0SEH7QMSJphTUkIYk
         Vf7urL17aKXMb4K4CSBikkWyc/aHwLmSU5hDe6M5x6su6CICG3Zk873RLhzqQtmxj/MH
         O8v5jNAxpi5BPsCYmliLOmETojyVnAhu92JTlO9XHdULp0lz0ygB1N+hUU/aE4N5Dk3M
         ybObatXeCvL5d+1t0B6kePte+OD+HysnmuAtHD0N+YX2qNP3/JjdQcGZvI2kCFlyP5ku
         NIq2EWl2BjLZqdXCiHRQfaf5tjqqT09BGcAwaI+Ahc0NTqnGVM21++cTcTTYfsrQX/wn
         z8Bg==
X-Gm-Message-State: AOJu0YzL3u4azaUDL7KjHfmMVbwP+0ShkDfJqRjYiCLKLYz9SF3jR120
	77IkpNYXHcwDICB3ZL70E7Se4bgWhcDa0B/k2VSHWyu/Q30zDnFc/4mysGszhpIhyzXdcv1sJ9K
	zKwq/gbh/alpbwhLAZv9N7bIi4l5qEZr5vfIpzZmgzU5CaECfd14IemxLfThXZF9ptpHlh0gcr7
	Xh8jDPUdJflXT9IMipvufjRWOFW8k+PldwnB9HSqRy/K2UwBWk5s8T8o0PVS98DD+ugdbcKUMRL
	qBj85FovGWaM0EIew==
X-Gm-Gg: ASbGnctnjUa6T4eyV4k0NTR2lJWMWJd9QIWpCFTdGKSR+bYjDuUJ76p07JBCDgdP4S0
	ud82A+fgW57YzGM+BzbMJKLaSxsGdw+UYesIZQX/5Pn//f2hAuAMc54/T9lhk2xjcVCMTxPpsk5
	lCHWcMbGgrCbtV3z6VFLNmsE1sePF6um92N7wqBp2IVG9oAszFblb28HnA2UER/1bfAsiola6fZ
	hoYmro/5eN7HvqdyyNMS//k9V8i8TU8eZqlwVbpy2SL7edmkUmN3vxjbYaDB2GpSojCSqunTOnU
	emj7lpNwKl/mY8HHrT2P9mzDO0FQbg1ZfB1Hx7AlNn2vIgPuBrF6GiwE2tQlBQj/WpyA+SzIavi
	CKZs9BDk62FVY4pfcVrwOkY4lHCdkRk7YVGavkkFPCMMg+2AKVpsBrYA2TWICjJIpGOgklDsNz9
	3UnCPYjCwKkSHkdbRPlxKY0BDBJAMnbmwDmWns0QN6B/c=
X-Google-Smtp-Source: AGHT+IG5uY0AJnUbViQy21A9IF6lHxPZ7Npo0b80ODSC/BLkr+Q4u3s3upBfAxjMbMh1pLZOkXbz+cWlIjDd
X-Received: by 2002:a05:690e:d84:b0:63f:9fd6:94f5 with SMTP id 956f58d0204a3-6410d0931c7mr6246631d50.8.1763150036235;
        Fri, 14 Nov 2025 11:53:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-6410ea165c0sm476067d50.7.2025.11.14.11.53.55
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Nov 2025 11:53:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-343725e6243so3623727a91.1
        for <netdev@vger.kernel.org>; Fri, 14 Nov 2025 11:53:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1763150034; x=1763754834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyRmhC40tORy7magFBDMbFacme5UfcMblEolAfcxZG8=;
        b=WebSyHjvrajZ2pr8oBjb6xRUovLQik+haZiuTy5lNIuA0yVe5S9aliZQY91DJazmsh
         jZo/Si3LiYvx2ucwSTumbh1Umery+3WlPSmVCzKV+AFlMyurSQpv9nLVKVlynXA+ZaCu
         Ux6DjYc+RLTuRkYQirEELh+brtDQDVDH8C5jc=
X-Received: by 2002:a17:90b:5905:b0:343:7410:5b66 with SMTP id 98e67ed59e1d1-343eac9cd2cmr9440016a91.11.1763150034358;
        Fri, 14 Nov 2025 11:53:54 -0800 (PST)
X-Received: by 2002:a17:90b:5905:b0:343:7410:5b66 with SMTP id 98e67ed59e1d1-343eac9cd2cmr9439992a91.11.1763150033907;
        Fri, 14 Nov 2025 11:53:53 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ea5f9fa4sm3108113a91.0.2025.11.14.11.53.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 11:53:53 -0800 (PST)
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
Subject: [v2, net-next 02/12] bng_en: Extend bnge_set_ring_params() for rx-copybreak
Date: Sat, 15 Nov 2025 01:22:50 +0530
Message-ID: <20251114195312.22863-3-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
References: <20251114195312.22863-1-bhargava.marreddy@broadcom.com>
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


