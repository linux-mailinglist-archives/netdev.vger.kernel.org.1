Return-Path: <netdev+bounces-197017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F37BCAD756C
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 17:13:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA2073A3D04
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 15:11:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9233D27FB10;
	Thu, 12 Jun 2025 15:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB5J9pT9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514228937C;
	Thu, 12 Jun 2025 15:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749741088; cv=none; b=VqKB2BEu96iM0rQ4fNX0auMI6TU51YHOZgZu47TDEMuqPwQAHG5an2TKwCdeTgaYH7kQci4QJJKmjvxjatvkeHifDMCG/nZfPramyVIU/DI+GwXQV+BrRVAYW9bWpikEOYO3OPazBiCdJAJyztDSMixq14mRHxXbW45qDo/3x2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749741088; c=relaxed/simple;
	bh=unaQiuIZlkFeSx8YV8ZcLV4sr/wHefsUkoyHPA7p3uw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eQN+l4i4UapYF9WJw8Q8S5MTax9JMTzsaly65ScGng0cvDKq/3RrpW9C1EphTg/8p4WVEdN3YXGpLDspVzhYQLyojDHoquaMIhKLUC+MiNrwi4DU1S7PEuv2Ql35S+QMAn4ZwEp/VfxPuV2TWT7wGnnFRVh4y0SSg4EnRKocrbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JB5J9pT9; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4531898b208so1085545e9.3;
        Thu, 12 Jun 2025 08:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749741085; x=1750345885; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pebtx4crYp3NAH6PwfiknDBb0Q1k3Z+dLYGSSugushY=;
        b=JB5J9pT9ouotXmuVTJM6x3vYSHqG3NxLpGmtYKIy1sk2jKJeN0CDIS6OJ4jPYR0plm
         2zK0CLR7VWWaCuzEgBu4wBpmHk91ow86LbOuSjFEipP3gPbUuL4iMAUz97aqOLEAfLbl
         CBDaKFZNUd11LAnHFKcLxV5f22TdHOABGQxpKy4JOx0sARubhlRHVpLQ9gfVWPhxpejT
         DljyccAKiChnNHfjo6okOA8dLdE1YZWktwOf3ivTJL38QF5RKv3IG9ldkb4FVZnXBXtU
         +37qX6h6I0UyDVwDxugl3j+W2vOM1z/tGKO/jVYJ45ZbYjlgRxTSYH+sHsDd8nG8PbZx
         6fqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749741085; x=1750345885;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pebtx4crYp3NAH6PwfiknDBb0Q1k3Z+dLYGSSugushY=;
        b=vsHxp9xGB2ZEJMUzDjckg+9d0XZmi+T4+0KIZ38tEBbO49+EdEjdfLRAIwx1SFJdUW
         zQGCbJ6WdKyPtV4BAWGFl9XnXLAM6lUKL580ZuatqdoI9vKFasnLnKECS2lYkfiW8R1o
         FFR7IGIGy2WG4Yfzlo5XuLTApiFsYMqVCn8ePpp0pddYrXP3Dx4N59Uauw/Xmtw4QRnW
         VV+SZ3ZgXrR8NkTCN8IbBCAdzczqfT/X2gqmLbKfKwYme0+onF3dzZ3LrUml3j7sax7l
         fCE7+m4LakkbDotTctkUML/Cy8cCOnvFwcxKfL6PwfxZd1otFdveMnoLTTD8nWs9i3Ft
         M4nA==
X-Forwarded-Encrypted: i=1; AJvYcCUDsOUqYBz7JsC8TnMWZYRulBfJTLQGBF+Vc+fpClDet/SL0EkV1TeFXXWmx7FZhbmZPao+sYOw@vger.kernel.org, AJvYcCXpckx4Ogh1soR8KPRyj081cJfYz8O0DNBRRbYE3bLQlBlNxFbjjek+AYnBHXJpdr0SCB02IHj56tuYRxU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo3LrpoyoZGQeGPWPD2zIH5TJSwXCgz20vbdTUv84EhcYFPW+g
	Z917dNuKJ0PCM2ZTDejQ4YjcKmyc+0mBUY1BRtgDJkKaXPaI62VfTfu9
X-Gm-Gg: ASbGnctDRIOUf4B57szHqXIaXnnEkfTCjuDEflHwWr0bP+VoxRh+W9IPSyFX4/WM8UW
	Jbzpqg06TSwYEzaTKcyzDIh6LhU/yLV20Mldltwe3uIojVm3wpXacIlBELa/epZXhBFAfxof211
	YjVDj7CRI0JTGUyX0kRMg/J+z+K5ajS6nByEAMHnQIv2VWtt/Q6iszbCzv3fzHd9tnhwDVMxfSW
	RDcvW1icJE/Erl7gIpj9tuOy1CVibYpDKmFQ++B0suF5QYWKSsybLuPN3Uc5D5pjqU2AjoAF3Ho
	fqTScJ9Ic02Ve+2j0xsdwhJQoEyuvsdc2frc8R/+ITGvsrevYAoLufXJm0OPHaiECEm1oRfWe1O
	LovFQ/5FSWnOrvSXTyKoIrQ==
X-Google-Smtp-Source: AGHT+IEu/ptSpWA2NpNjS+NYr1/sRscpVV0jrp9hLsf3tiygLm8YoCl4M+445JSF+xJhWl/p+2HyLw==
X-Received: by 2002:a05:600c:a10c:b0:453:bf1:8895 with SMTP id 5b1f17b1804b1-453248c4e85mr20185585e9.5.1749741084643;
        Thu, 12 Jun 2025 08:11:24 -0700 (PDT)
Received: from thomas-precision3591.. ([2a0d:e487:219f:b2e4:a011:1902:f9c3:4790])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-3a561996d30sm2254335f8f.31.2025.06.12.08.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 08:11:24 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] (drivers/ethernet/atheros/atl1) test DMA mapping for error code
Date: Thu, 12 Jun 2025 17:05:34 +0200
Message-ID: <20250612150542.85239-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Shuah Khan[1], all `dma_map()` functions should be tested
before using the pointer. This patch checks for errors in `dma_map()`
calls and in case of failure, unmaps the previously dma_mapped regions
and returns an error.

[1] https://events.static.linuxfound.org/sites/events/files/slides/Shuah_Khan_dma_map_error.pdf

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/atheros/atlx/atl1.c | 38 ++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index cfdb546a09e7..99d7a37b4ddf 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -1869,6 +1869,13 @@ static u16 atl1_alloc_rx_buffers(struct atl1_adapter *adapter)
 		buffer_info->dma = dma_map_page(&pdev->dev, page, offset,
 						adapter->rx_buffer_len,
 						DMA_FROM_DEVICE);
+		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
+			buffer_info->alloced = 0;
+			buffer_info->skb = NULL;
+			kfree_skb(skb);
+			adapter->soft_stats.rx_dropped++;
+			break;
+		}
 		rfd_desc->buffer_addr = cpu_to_le64(buffer_info->dma);
 		rfd_desc->buf_len = cpu_to_le16(adapter->rx_buffer_len);
 		rfd_desc->coalese = 0;
@@ -2183,7 +2190,7 @@ static int atl1_tx_csum(struct atl1_adapter *adapter, struct sk_buff *skb,
 	return 0;
 }
 
-static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
+static int atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 	struct tx_packet_desc *ptpd)
 {
 	struct atl1_tpd_ring *tpd_ring = &adapter->tpd_ring;
@@ -2195,12 +2202,14 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 	unsigned int f;
 	int retval;
 	u16 next_to_use;
+	u16 first_mapped;
 	u16 data_len;
 	u8 hdr_len;
 
 	buf_len -= skb->data_len;
 	nr_frags = skb_shinfo(skb)->nr_frags;
 	next_to_use = atomic_read(&tpd_ring->next_to_use);
+	first_mapped = next_to_use;
 	buffer_info = &tpd_ring->buffer_info[next_to_use];
 	BUG_ON(buffer_info->skb);
 	/* put skb in last TPD */
@@ -2216,6 +2225,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 		buffer_info->dma = dma_map_page(&adapter->pdev->dev, page,
 						offset, hdr_len,
 						DMA_TO_DEVICE);
+		if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
+			goto dma_err;
 
 		if (++next_to_use == tpd_ring->count)
 			next_to_use = 0;
@@ -2242,6 +2253,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 								page, offset,
 								buffer_info->length,
 								DMA_TO_DEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
+					goto dma_err;
 				if (++next_to_use == tpd_ring->count)
 					next_to_use = 0;
 			}
@@ -2254,6 +2267,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 		buffer_info->dma = dma_map_page(&adapter->pdev->dev, page,
 						offset, buf_len,
 						DMA_TO_DEVICE);
+		if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
+			goto dma_err;
 		if (++next_to_use == tpd_ring->count)
 			next_to_use = 0;
 	}
@@ -2277,6 +2292,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 			buffer_info->dma = skb_frag_dma_map(&adapter->pdev->dev,
 				frag, i * ATL1_MAX_TX_BUF_LEN,
 				buffer_info->length, DMA_TO_DEVICE);
+			if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
+				goto dma_err;
 
 			if (++next_to_use == tpd_ring->count)
 				next_to_use = 0;
@@ -2285,6 +2302,22 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 
 	/* last tpd's buffer-info */
 	buffer_info->skb = skb;
+
+	return 0;
+
+ dma_err:
+	while (first_mapped != next_to_use) {
+		buffer_info = &tpd_ring->buffer_info[first_mapped];
+		dma_unmap_page(&adapter->pdev->dev,
+			       buffer_info->dma,
+			       buffer_info->length,
+			       DMA_TO_DEVICE);
+		buffer_info->dma = NULL;
+
+		if (++first_mapped == tdp_ring->count)
+			first_mapped = 0;
+	}
+	return -ENOMEM;
 }
 
 static void atl1_tx_queue(struct atl1_adapter *adapter, u16 count,
@@ -2419,7 +2452,8 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
 		}
 	}
 
-	atl1_tx_map(adapter, skb, ptpd);
+	if (atl1_tx_map(adapter, skb, ptpd))
+		return NETDEV_TX_BUSY;
 	atl1_tx_queue(adapter, count, ptpd);
 	atl1_update_mailbox(adapter);
 	return NETDEV_TX_OK;
-- 
2.43.0


