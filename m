Return-Path: <netdev+bounces-250619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E826DD3860D
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B266830E1AA6
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D1E339E167;
	Fri, 16 Jan 2026 19:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TnqKRr2H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f99.google.com (mail-qv1-f99.google.com [209.85.219.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 136FA3A1A59
	for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 19:38:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768592289; cv=none; b=H7zawmdAzZuIdIERTdLTlu9yROmcmXBcL55AIssZ2kkn9Kh1gzYWJzlH+RrIIRbGmIbYpCsaVXtyoPQucwDn8NDgq04Hngg0+sM83NiXcPJDEtv+JlApVWDHZzGOAYwPowtLnoTQ/aMsTtfVw75t3r/X9jM2Xl2/2qfpkIdiQn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768592289; c=relaxed/simple;
	bh=G42HEdK63RMSkNcCPQGCk4X08ncSFrRURRT8K21yxRE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CTo0EAsq0jaKdDZbAJGy2g4XmEbFiROYIM2wuVIAfHMuaAfL9xs3RLAHCtkqBzMLyt0/ZWlBn5ribnkxkuzdk5qX9ykNreZDH7Y/5h6zXGxUBXwZu2p7jHoq8R/0chjfnYBc0VVRui/V2ebVwfCynUBSOBBsenuAWUrT6WysAUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=TnqKRr2H; arc=none smtp.client-ip=209.85.219.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f99.google.com with SMTP id 6a1803df08f44-88fcc71dbf4so19600326d6.2
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:38:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768592284; x=1769197084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P5v6be/rvU1Ddm94jt+LcDTFwMP9w1kpc8KK4AcGhZ4=;
        b=HuJIB9yoDlXIBK1LBQVTIoFK6mj87+hIoYy+NSlc/KJ2xYQgwW/fYSPzcg+XHz7TcB
         +wF/bbEUqjSK/Jv6UgvIqzlu6f0GlAf81/a+b97GgXzMAFN8UJVdkAEjWhRovVwb1Yhx
         6PepCuQZ8V4RbyRhcVHQokxg2KKoiuLwBWzn2JAZAn4gw0Bw0RbXsDTvbPqo/x0Dx1Rd
         hVRPps6tfeOdort5JNdGl8ZHMq+Vn9QvDYJ4sacAKiYLv8BF+LEo+sODPTt+Lz5fVVfR
         BLOFR4tFGtj7W8XvLbyERWW/40rHbVpWvScS4ijVD6Uk6iCQTsH13hwOPb3D5SREHZEf
         xk/g==
X-Gm-Message-State: AOJu0YxxnMADnTRTWCJZBkvZ7JN1CWeyeHIEg1CTJuZzY+2Z3qSt+dV5
	aIMO34FBIbM3ZNWiTSm8HamBxCE5XcoINVKizm0K7F2lCQrlME4e+HusImQVJdy28mruKjGSMjh
	8IltgtLe7lf4F15mS1uyJeVi7z62DcQpaR5/Zb1jvh1uqhoPzzeey+nH8+cOjNjoY7FKOMbWHfO
	07JtoflUss92O3Av/fqngd/IenMY9YFEtYeBe+HOWUaMX+CUilsZNf7msxcqjJKLmbfvWXw9Cn5
	qBMMke2FmNe+cZYAQ==
X-Gm-Gg: AY/fxX5hGx5q2UdwlrP5JAbElrWiTcavipyfLCbA45oxgYFrJSlCG1yP1XUuDOQTkmg
	APWmVvqfToOrXSd1RwTrZLVukQaUa1CQWj/ms6TwZd585tWexd1dh3GlcH578RHFoXCwWMJUWmz
	wx9AeQh0xybPeiEQN09WEOJ7IAVlDdjaaoN07CWLgbnU2gac3tQte0CgjsGRUtgUmOOgHB9CvMy
	iZ/p48wZ0ItzllkjDBIIqXnE8TcZ8T9Cxl6qZHYU7gdjsWDmtxj+bk8r4mZRDanDp3NsPu8g05z
	dncEJ4gw7NRR1g/ocRKICeC655VSIEp1w1+VF+LpzLYpxgRmoSR5lXwE88cMINA9nLtad4pSgoG
	d4alVk5WbpYhUNklRjN1aSyiMfeUPlq0ku0Rjj6upRM/XDWyQnGJA5BjRrpZI+Ez0z/u61ZS7Pu
	mVM/KK2I2ofXyeQnq3IH8rf+tZy1QJqzkJITreosnFqO7Lx+ek5ao3Sw==
X-Received: by 2002:a05:6214:5190:b0:88e:c723:6f7d with SMTP id 6a1803df08f44-8942dd6ae36mr50441626d6.34.1768592284214;
        Fri, 16 Jan 2026 11:38:04 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-118.dlp.protect.broadcom.com. [144.49.247.118])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8942e5f2858sm1821906d6.8.2026.01.16.11.38.03
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Jan 2026 11:38:04 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2a0d43fcb2fso52836955ad.3
        for <netdev@vger.kernel.org>; Fri, 16 Jan 2026 11:38:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1768592283; x=1769197083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P5v6be/rvU1Ddm94jt+LcDTFwMP9w1kpc8KK4AcGhZ4=;
        b=TnqKRr2HJHW6c7Y1BW+NnwDF82gK1C9hQtuWGPxPAVs/vPqPC2UC0IBhzjHDGkcWyE
         LZa8Gz16qHm4WOMHSD12eb1aIR5j/WAUc876En9QBdHQFH8CVYQF9OlFJK+jeY6+X8En
         qC4WzFTJtxWYPLSzmzGMR26zjaZywyn746yLI=
X-Received: by 2002:a17:90b:3890:b0:34c:99d6:175d with SMTP id 98e67ed59e1d1-35272ec5844mr3471686a91.2.1768592282941;
        Fri, 16 Jan 2026 11:38:02 -0800 (PST)
X-Received: by 2002:a17:90b:3890:b0:34c:99d6:175d with SMTP id 98e67ed59e1d1-35272ec5844mr3471669a91.2.1768592282527;
        Fri, 16 Jan 2026 11:38:02 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35273121856sm2764909a91.15.2026.01.16.11.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 11:38:02 -0800 (PST)
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
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Rajashekar Hudumula <rajashekar.hudumula@broadcom.com>
Subject: [v5, net-next 1/8] bng_en: Extend bnge_set_ring_params() for rx-copybreak
Date: Sat, 17 Jan 2026 01:07:25 +0530
Message-ID: <20260116193732.157898-2-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260116193732.157898-1-bhargava.marreddy@broadcom.com>
References: <20260116193732.157898-1-bhargava.marreddy@broadcom.com>
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
index 832eeb960bd2..8bd019ea55a2 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -13,6 +13,7 @@
 #include <linux/etherdevice.h>
 #include <linux/if.h>
 #include <net/ip.h>
+#include <net/netdev_queues.h>
 #include <linux/skbuff.h>
 #include <net/page_pool/helpers.h>
 
@@ -2295,7 +2296,6 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 	rx_space = rx_size + ALIGN(NET_SKB_PAD, 8) +
 		SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 
-	bn->rx_copy_thresh = BNGE_RX_COPY_THRESH;
 	ring_size = bn->rx_ring_size;
 	bn->rx_agg_ring_size = 0;
 	bn->rx_agg_nr_pages = 0;
@@ -2334,7 +2334,10 @@ void bnge_set_ring_params(struct bnge_dev *bd)
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
@@ -2367,6 +2370,17 @@ void bnge_set_ring_params(struct bnge_dev *bd)
 	bn->cp_ring_mask = bn->cp_bit - 1;
 }
 
+static void bnge_init_ring_params(struct bnge_net *bn)
+{
+	u32 rx_size;
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
@@ -2456,6 +2470,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bn->rx_dir = DMA_FROM_DEVICE;
 
 	bnge_set_tpa_flags(bd);
+	bnge_init_ring_params(bn);
 	bnge_set_ring_params(bd);
 
 	bnge_init_l2_fltr_tbl(bn);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index fb3b961536ba..557cca472db6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -135,7 +135,8 @@ struct bnge_ring_grp_info {
 	u16	nq_fw_ring_id;
 };
 
-#define BNGE_RX_COPY_THRESH     256
+#define BNGE_DEFAULT_RX_COPYBREAK	256
+#define BNGE_MAX_RX_COPYBREAK		1024
 
 #define BNGE_HW_FEATURE_VLAN_ALL_RX	\
 		(NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX)
@@ -186,7 +187,7 @@ struct bnge_net {
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


