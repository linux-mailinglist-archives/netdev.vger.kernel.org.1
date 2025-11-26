Return-Path: <netdev+bounces-242018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37D14C8BB51
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 20:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE7B53B4F94
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 19:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB511341642;
	Wed, 26 Nov 2025 19:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Odc60xra"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55DFE341067
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 19:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764186615; cv=none; b=jAuScuNNOl4so3bOLiQmPZHmXee6aYf9aNOzd+XfatS+DBXUEP4VHQ0yZ7kFT6SXcDwHEvHeFUaBos2TGXTgcJotbIISFSprgFy04VPT5E2vywvOPFNPunKbjvu9Mecw/9/bomu2uVSwwcxh7PpN9FL/Jann2IlpvtXU3hIcU+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764186615; c=relaxed/simple;
	bh=hk0dXykGCmNbrFeThn9+TK9B/my7uHNR3BCQlXSq/ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lg2+uKy7Y64/1yEZ1UIFSabSLl11EG7Uqpdvcw92gE+Di8dEk/roCI5SDq9xo2rxmPKNrLuJTWJ7/TvS60l5+Ey+61ZwSVBm0ublola3Nmlk65fHDm3nBytXgGT/9/hi0jmegui/nJXL6g3c/TJ66zE6lRe+hBRX9UQFkjJtgCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Odc60xra; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-8738c6fdbe8so1858836d6.1
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764186613; x=1764791413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lolwq9gTk1seDw4oQyBfgaM19vDbI49PtwNcLlnVu/g=;
        b=J5ed0GLwmUZSZR+GRZZlFqvNSotD6xLe+sed/C0UtARBgcjmP+P28zz5WAUTsqwM6M
         Yst8zPpOGrHp/yyGRdbS0HyCpBh1jMKEPduNSJ/knkWY6AOzBfcIdZtQTFHxe5elMIbS
         wKPJM/7HyP4lYbDXgZuQD1/aZ5XKqu8jXE/N72RxXVm0iEaLXz2y6SRgQHL7CKQrtvIy
         0hPqYiNrSaCTeeps9zBWHz6DujKGm92Png2jVpkPDwu2qSSrnJ0p67CJ16nZjqN2t80G
         YcqM0IOPVQC2AHIceVWrcPJt7W4YhO7/YQ/Ux+yFisL0nh1G/lnbfcrBj1LbbK4QpoDZ
         LtOA==
X-Gm-Message-State: AOJu0Yy6lp34G6vnrUvYqWWxt+QVVgknwD/yuIUKCv9Hf5ruJIcQWify
	TJkZLnHVQeA9lodQ5OoawyjfU4wkf7c9YcG4fu675BJrYwgXUHwmFUx/P9vCVCJjvEd8KayBdae
	h+FbN1nqQdD96H5SObBCZW3TLw1addzfeMYyhyjt8YyfwI9ubw1Ix32nZfmkBXqIXZ1T3Dum5pE
	boEx77dsJMdIjWNSHYjubr3YgRYkaJdOyH7Fl0KbQxG7isfbWdc/Q6GI1vF58YAb74cOJMJStKz
	yJYIaNimefZfOnXm1Qp
X-Gm-Gg: ASbGncvV3vRcYbvzSeWWTGf6GgPH9EYY9PfEAirzjHRwSJuCAznSXrqadjHw+y6RbTD
	PlkF+JglfMq3B2+v5CXTyji30wyY7JeGpUzHdyRfwlDAE+baN6eSh7xjKIJZUuJS5o/tw1zemej
	tlmnBDGw4c9KrTgLxtVK0+Yf7xTU3mjUggY88toNnSIGQmQ9hzQ2lRw38H26jPLIqTh1IOiwIL+
	Y0hOkCtreEfMxknzchINCiC7ySqVbNtyDmdv7NVB38YyShUpw8ctGcaIyT33GMrzu4uKUX0Ru6B
	qU31fT0KzSvOCu9uTXeXE3py6qyCWzq+LzG2NIw5FKTz3kCQSYi9/HQpd4bqSHRVN/x/0RUA9kJ
	poHHkOLLLhpf+fPm5PGZxgcS8WXmVVFjpADfjON+m6jq4Peir/CB4/lt78aCopupAzoEYfWPqUR
	zbezb69I9/xddVs/VJh4XIWMO0AOj1mCvqg/7vB4djSteoT/ep7inyow==
X-Google-Smtp-Source: AGHT+IFl6zhORXYc9M/+V4jk7ckenaqk1LZK3Z1UtKDuDuRklnuLxa/AC1IaSDlY4oMSMqap15LvRUuvf8Qu
X-Received: by 2002:a05:6214:20ab:b0:882:42a7:9a10 with SMTP id 6a1803df08f44-88470145b84mr404156416d6.19.1764186613200;
        Wed, 26 Nov 2025 11:50:13 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-116.dlp.protect.broadcom.com. [144.49.247.116])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8846e57cf6esm23298986d6.18.2025.11.26.11.50.12
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Nov 2025 11:50:13 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-bcecfea0e8aso689641a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 11:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764186611; x=1764791411; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lolwq9gTk1seDw4oQyBfgaM19vDbI49PtwNcLlnVu/g=;
        b=Odc60xraUGWj55a1tY3JcBAjzcxSDIKI86sI4emfLiSMOKGHCci6+ugirxtzHaIi5w
         LMNfJfQ+7QF+14ycwVTBRPQZsb4jFd5Ct7R0p9NwzeLA5r6oBFwXN/boq6MNfhViJTtH
         xau7ClrQKT3sPB2XQAQk2243EQxrWfuhdKOgs=
X-Received: by 2002:a17:902:ea0e:b0:295:5898:ff5c with SMTP id d9443c01a7336-29b6bfa9738mr273543235ad.16.1764186610649;
        Wed, 26 Nov 2025 11:50:10 -0800 (PST)
X-Received: by 2002:a17:902:ea0e:b0:295:5898:ff5c with SMTP id d9443c01a7336-29b6bfa9738mr273542975ad.16.1764186610174;
        Wed, 26 Nov 2025 11:50:10 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e638sm206782375ad.58.2025.11.26.11.50.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 11:50:09 -0800 (PST)
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
Subject: [v3, net-next 02/12] bng_en: Extend bnge_set_ring_params() for rx-copybreak
Date: Thu, 27 Nov 2025 01:19:21 +0530
Message-ID: <20251126194931.455830-3-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
References: <20251126194931.455830-1-bhargava.marreddy@broadcom.com>
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
index 4172278900b..d0462bd1db0 100644
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


