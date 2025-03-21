Return-Path: <netdev+bounces-176832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6AEA6C4F2
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 22:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E9327A7518
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 21:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4B43230D0F;
	Fri, 21 Mar 2025 21:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gwBwuXmZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C131230BDC
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 21:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591840; cv=none; b=MIz+MZNhX//3zQnWVydanktubgoSpnROWd0TSmDmGx6uNAFjmHY+0o2uLZzn6+dA+btYlI1mpqK1IPtFA6uCr3lKHxw3iSlDqQZjlbg9OTgSWTkXwEEsR2zZLHd0juPRRsUy6zgC2ywdPqTfCc5Jl7TnFWLNST6WJJcbqPG5c1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591840; c=relaxed/simple;
	bh=IqVLT/fj0Pa/es+R02oKGA+IlnPtbFjP/pfs6cWq5ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KEwjxtO4/hN0HhPBXICZrXzYSb6HvUcXoEaX0xtu6YI5KR05e+KTMQrGPFhLD4VYqjBdCfndXtASSuCv1vP0JvtTN8KkzOs/fpGaaIHY2BMAL3P6vKZWr7z7JY4mDOJmB8e0+iDNZH8V4SFYAaOBcnCGeV9gS+RbZfAQLepu1Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gwBwuXmZ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2260c915749so35049345ad.3
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 14:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742591837; x=1743196637; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2zoSVAv9eAagIOw9dYpuP931ulMdAEfWrIR+6VNfhxQ=;
        b=gwBwuXmZGO6z2Dk7stFv+hyRXVJVKPGE5ixQW4YPTFQACMDqewk1wO5mBrLuLO8ksQ
         ShRwhXuiWwyqL5fkwCv6ElU4zk2Y0JQX6cAumptSm4+BBaS18M5splpiG7HUfMogpLO5
         pccD8pAd0QKULLKRSPkdHtLs7TLYpuYAzTWR8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742591837; x=1743196637;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2zoSVAv9eAagIOw9dYpuP931ulMdAEfWrIR+6VNfhxQ=;
        b=opO7qIrY1VppXs0gbA+290PPtktb4VO840SfsTXTNS+VzsbUu9Bd42F9h9yPT8heOM
         ZStiSfx6dSzINvfZJrZDohoeD9PnFUsvnjzgDHPjtPthATOy9mnjpxSKpU/pUjlSGl4j
         oQgNQUu1LySNWViDQKxi68SvdWS9dxt8qhBUXc6zEL3SC9lbhKLABR/b5+h9pgsa2WPt
         0xmN/K2yE2/gD28pvHUk/bH60lHdc3gCBZYHEFqde7BWdaTgCVCIR0mIeSCZY9oI6ZGH
         ORw+JKLoa9rSoTbD/X3L+MfMlKZ9VYHnC9xoO6z9Pv1kKVPdoaAtPYUGoAEnHJacLeKK
         +t1Q==
X-Gm-Message-State: AOJu0Yz0KEIuhqAl2H/UByLYK81LXtmCZXkpcjS9GzTWeC8y4AIDMu+0
	QL1/mOaVszG9mcxaIJe+ROpQ8lgFCYe7GH2pjGauOZuVGFcq+AZ60EQONALcjw==
X-Gm-Gg: ASbGncvq1ka9xQx6evXE0DCc6j4LX5qVSB58MgLffqUoLI2Nxh7J5kZ0sDmP6xc7IgT
	XEepBsliT7A+KsyGNcYyDnH2IqThak7YJdtAO0eykzGmKBxDHjAoCnPM0m3S303BCS8tLgK7dtF
	Mi6fnw7dfai4KlnKtIO9cHz5OGy5t8YI6oKbeHa3ulNScg7FlKxf9CiJZQC+aeZ60ZUBvWFg6Qy
	FTZmzr8SFhjNvzm6nYrKdrgn8tLAGkHun38AShKmp0DBudD6LO/4jKeBAxm3inRqw5popI5bjpi
	xMEcd9nHHFdgPol6EsODX/3DaPbQWY1oVaAABt06uMEB/g3akP7sE0aeVilwpS7Znubtkrxf+Wj
	HWdtmGIGNj8pnqsPyaRmC
X-Google-Smtp-Source: AGHT+IHG/443kL7kidUg661UEiKuY2CcHZg7CbCwIEI6Ahv4Y3I3M5SF1N6uwF7nEoekmdoxRnDGOA==
X-Received: by 2002:a17:902:ef12:b0:224:249f:9734 with SMTP id d9443c01a7336-22780c54cfemr82881955ad.4.1742591837446;
        Fri, 21 Mar 2025 14:17:17 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4a034sm22386055ad.98.2025.03.21.14.17.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 14:17:16 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	osk@google.com,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>
Subject: [PATCH net 1/2] bnxt_en: Mask the bd_cnt field in the TX BD properly
Date: Fri, 21 Mar 2025 14:16:38 -0700
Message-ID: <20250321211639.3812992-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250321211639.3812992-1-michael.chan@broadcom.com>
References: <20250321211639.3812992-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bd_cnt field in the TX BD specifies the total number of BDs for
the TX packet.  The bd_cnt field has 5 bits and the maximum number
supported is 32 with the value 0.

CONFIG_MAX_SKB_FRAGS can be modified and the total number of SKB
fragments can approach or exceed the maximum supported by the chip.
Add a macro to properly mask the bd_cnt field so that the value 32
will be properly masked and set to 0 in the bd_cnd field.

Without this patch, the out-of-range bd_cnt value will corrupt the
TX BD and may cause TX timeout.

The next patch will check for values exceeding 32.

Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 4 ++--
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     | 2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 3 +--
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 0ddc3d41e2d8..158e9789c1f4 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -564,7 +564,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 					TX_BD_FLAGS_LHINT_512_AND_SMALLER |
 					TX_BD_FLAGS_COAL_NOW |
 					TX_BD_FLAGS_PACKET_END |
-					(2 << TX_BD_FLAGS_BD_CNT_SHIFT));
+					TX_BD_CNT(2));
 
 		if (skb->ip_summed == CHECKSUM_PARTIAL)
 			tx_push1->tx_bd_hsize_lflags =
@@ -639,7 +639,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	dma_unmap_addr_set(tx_buf, mapping, mapping);
 	flags = (len << TX_BD_LEN_SHIFT) | TX_BD_TYPE_LONG_TX_BD |
-		((last_frag + 2) << TX_BD_FLAGS_BD_CNT_SHIFT);
+		TX_BD_CNT(last_frag + 2);
 
 	txbd->tx_bd_haddr = cpu_to_le64(mapping);
 	txbd->tx_bd_opaque = SET_TX_OPAQUE(bp, txr, prod, 2 + last_frag);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 2373f423a523..3b4a044db73e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -82,6 +82,8 @@ struct tx_bd {
 #define TX_OPAQUE_PROD(bp, opq)	((TX_OPAQUE_IDX(opq) + TX_OPAQUE_BDS(opq)) &\
 				 (bp)->tx_ring_mask)
 
+#define TX_BD_CNT(n)	(((n) << TX_BD_FLAGS_BD_CNT_SHIFT) & TX_BD_FLAGS_BD_CNT)
+
 struct tx_bd_ext {
 	__le32 tx_bd_hsize_lflags;
 	#define TX_BD_FLAGS_TCP_UDP_CHKSUM			(1 << 0)
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 299822cacca4..d71bad3cfd6b 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -48,8 +48,7 @@ struct bnxt_sw_tx_bd *bnxt_xmit_bd(struct bnxt *bp,
 		tx_buf->page = virt_to_head_page(xdp->data);
 
 	txbd = &txr->tx_desc_ring[TX_RING(bp, prod)][TX_IDX(prod)];
-	flags = (len << TX_BD_LEN_SHIFT) |
-		((num_frags + 1) << TX_BD_FLAGS_BD_CNT_SHIFT) |
+	flags = (len << TX_BD_LEN_SHIFT) | TX_BD_CNT(num_frags + 1) |
 		bnxt_lhint_arr[len >> 9];
 	txbd->tx_bd_len_flags_type = cpu_to_le32(flags);
 	txbd->tx_bd_opaque = SET_TX_OPAQUE(bp, txr, prod, 1 + num_frags);
-- 
2.30.1


