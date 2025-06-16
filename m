Return-Path: <netdev+bounces-198080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B714FADB2F6
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 16:05:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E08E163325
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 14:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 145C5A31;
	Mon, 16 Jun 2025 14:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEPZ+SGR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CB0C2BEFE6;
	Mon, 16 Jun 2025 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750082752; cv=none; b=AApM8k/jm7aYc0CocXOclWg18P69OODJPLTNbskR7x4c5xt+FCLY993YmskZhazb6oFXzsLJ6P3rWO74L3dEYmWDbeAwHjpjn+KNqudhI6G/DeTMy1ad6e64U/s9qYobFqak5GUiI+5Idt3O/6394s4oZKpY50TdRKnc7wOW3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750082752; c=relaxed/simple;
	bh=WzE1aNqujYVsFqob/hOJtHNXP3jA3Px95R81bO5dBX8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sHmQqCduUNdLf9tn0jXFcfhqp7Ha0+X16DWAny7wVYrmzT7mhxhJDllEa3UPd6Xe6tvsl66TM2b2bU0+oqOp3ZAs5J6dxwLVTa39oUJRqH+3Hq3ugldf5WE+rfU/7p3YYOAHqo8XENvndK8kl7ZRuGAfD3KLVoZSKh4sZrX6T/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEPZ+SGR; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4531898b208so4733745e9.3;
        Mon, 16 Jun 2025 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750082748; x=1750687548; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SzdRQROMTVgMksH6Fn4lHaEKC4h3vDSH2xEvADuUVQE=;
        b=eEPZ+SGR88rmCa89HDdVejKbJ3dc25zov/RenIdVwgreO88cVUMI+29l4imJMVqwNO
         AfNdaDE5SeZqIpaDAGD2coPdoIj9iQtWCHyU3AiU6osoBFJhGayw3Nm3Wvuyz2YuG6ba
         EllrgGKml5mm5rRNWFiQGj5KKSIoJ0M/+t3H62oRdRY0rlxWNRCC0SSC+N4OAWZ+GIzg
         B96jWmSDOYqAYESTKCJ02v3AQZsZdZc9pNBBXB5vIVLzEp162BXN1e49WAhbTgpGCeBj
         NCAgaR9Zxe8s6NouYCxO33MxdV0kOY9mxzMJRv7oj0nc2eLclu3SD+S00qmG2U/t4M/7
         qn4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750082748; x=1750687548;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzdRQROMTVgMksH6Fn4lHaEKC4h3vDSH2xEvADuUVQE=;
        b=r7uocN4uXKukInSlaWR4GSCr/9/PQPqHwbJMxdeuFgFu87Vjnbl8oGWjokCc4TVPTR
         f3AlLPrUezsY8o3SdAer5x62N0vU7plJvh1SgfEJCRBwog+aC0qTbJp/nDIJ3GCFnztj
         ysqnkhPMQbsL/PG0d9IINM6aSju0hf/ciFFIIYf9iXyNV0vadHx8ngIwG2AlhJBs59b3
         mAYHVnomn4+4qMI6klkSKVBSnnI5D6vNjApUowlgdDMA4pIRAhL4pq43YPVBxXJ/53rW
         ECH7WjKSJYQyAFtQhBIauAY8ZRz0ROU49+Odp8S4QbYhmCnYgH5qqKlFfxawBw+nwJ+8
         a+Ow==
X-Forwarded-Encrypted: i=1; AJvYcCVwpEHFPaqifj/Y0lncJCl03W4WxbFNx+iSwFLa6Jeznt7FbUDpph/ViqYaV4HXY8d4XZssiQikxiEeG+g=@vger.kernel.org, AJvYcCXfzQLoYnMzPwFRurawno3EnTDJcAU6U2MMU80UCjxAUBqTmbt93e4tZC5qVmPQrFM0vwaEhzvZ@vger.kernel.org
X-Gm-Message-State: AOJu0Yxpf5Lu+BxExurIuw3KrHh+jJoCHYicpTBYGoEZiMz9XBXKWLCr
	+M3S0L5XhtU4m6EcGMLA6XbgvoptjZQQEzwOvby28jPvvAJVh4aKrMUz
X-Gm-Gg: ASbGncs/N90gZw+/mAnb64OG5ww9zS3AcjuqS5NKozTYodyJNrpHeqx4GwNlPRncH+T
	15E4vTIQPI297MU8UhurqrI0tkaj4UxKOg4skIzo4Wfn0S+1Pri6Bf7S/kvfrzt2tdMbXWNkpIU
	3rvMz2rVoqkUd22gCZrDhpgz5dDzdNYkvwqWZ1OAFl4gt8OAk7nsF7U0/Nn+oG6MeCd2SKFVPOM
	N6XIHBLuch2YkQo+lR0vKy9X84QEOru68AfF9SC9XROMxv85xs41Qd8JVdNp3eTxyTC6Dd0ft84
	czZKo0S5N54Tr3QuNKMcrjcLV/R5W/65cq3qAMjK9rsoJ+TMd8WIaJZGChBpWBGFeAwXe/5sFYR
	RRLUXSu4etYF6OzFJkAWaD4XAcPR4kmiy9zfJTq910I4Nw76xWamRgye/Eb1f26Q2w+QDn4mbX8
	A=
X-Google-Smtp-Source: AGHT+IEzv/FPUGCpExirpUho/BpLTrXMgQkYiLbvu9R83JslzbyWIGXNQAL/kP5P3cKnFdGy05kWAQ==
X-Received: by 2002:a05:600c:3582:b0:441:d244:1463 with SMTP id 5b1f17b1804b1-4533c9c72a2mr32825155e9.0.1750082747657;
        Mon, 16 Jun 2025 07:05:47 -0700 (PDT)
Received: from thomas-precision3591.home (2a01cb00014ec30066fa15afc047b98a.ipv6.abo.wanadoo.fr. [2a01:cb00:14e:c300:66fa:15af:c047:b98a])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4532e24420csm144457775e9.20.2025.06.16.07.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 07:05:47 -0700 (PDT)
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
	Jeff Garzik <jeff@garzik.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] ethernet: alt1: Fix missing DMA mapping tests
Date: Mon, 16 Jun 2025 15:59:55 +0200
Message-ID: <20250616140246.612740-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250613074356.210332b1@kernel.org>
References: <20250613074356.210332b1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Shuah Khan[1], all `dma_map()` functions should be tested
before using the pointer.  This patch checks for errors after all
`dma_map()` calls.

In `atl1_alloc_rx_buffers()`, when the dma mapping fails,
the buffer is deallocated ans marked as such.

In `atl1_tx_map()`, the previously dma_mapped buffers are de-mapped and an
error is returned.

[1] https://events.static.linuxfound.org/sites/events/files/slides/Shuah_Khan_dma_map_error.pdf

Fixes: f3cc28c79760 ("Add Attansic L1 ethernet driver.")
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/atheros/atlx/atl1.c | 43 ++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index cfdb546a09e7..dd0e01d3a023 100644
--- a/drivers/net/ethernet/atheros/atlx/atl1.c
+++ b/drivers/net/ethernet/atheros/atlx/atl1.c
@@ -1869,6 +1869,14 @@ static u16 atl1_alloc_rx_buffers(struct atl1_adapter *adapter)
 		buffer_info->dma = dma_map_page(&pdev->dev, page, offset,
 						adapter->rx_buffer_len,
 						DMA_FROM_DEVICE);
+		if (dma_mapping_error(&pdev->dev, buffer_info->dma)) {
+			buffer_info->alloced = 0;
+			buffer_info->skb = NULL;
+			buffer_info->dma = 0;
+			kfree_skb(skb);
+			adapter->soft_stats.rx_dropped++;
+			break;
+		}
 		rfd_desc->buffer_addr = cpu_to_le64(buffer_info->dma);
 		rfd_desc->buf_len = cpu_to_le16(adapter->rx_buffer_len);
 		rfd_desc->coalese = 0;
@@ -2183,8 +2191,8 @@ static int atl1_tx_csum(struct atl1_adapter *adapter, struct sk_buff *skb,
 	return 0;
 }
 
-static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
-	struct tx_packet_desc *ptpd)
+static int atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
+		       struct tx_packet_desc *ptpd)
 {
 	struct atl1_tpd_ring *tpd_ring = &adapter->tpd_ring;
 	struct atl1_buffer *buffer_info;
@@ -2194,6 +2202,7 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 	unsigned int nr_frags;
 	unsigned int f;
 	int retval;
+	u16 first_mapped;
 	u16 next_to_use;
 	u16 data_len;
 	u8 hdr_len;
@@ -2201,6 +2210,7 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 	buf_len -= skb->data_len;
 	nr_frags = skb_shinfo(skb)->nr_frags;
 	next_to_use = atomic_read(&tpd_ring->next_to_use);
+	first_mapped = next_to_use;
 	buffer_info = &tpd_ring->buffer_info[next_to_use];
 	BUG_ON(buffer_info->skb);
 	/* put skb in last TPD */
@@ -2216,6 +2226,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 		buffer_info->dma = dma_map_page(&adapter->pdev->dev, page,
 						offset, hdr_len,
 						DMA_TO_DEVICE);
+		if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
+			goto dma_err;
 
 		if (++next_to_use == tpd_ring->count)
 			next_to_use = 0;
@@ -2242,6 +2254,9 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 								page, offset,
 								buffer_info->length,
 								DMA_TO_DEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev,
+						      buffer_info->dma))
+					goto dma_err;
 				if (++next_to_use == tpd_ring->count)
 					next_to_use = 0;
 			}
@@ -2254,6 +2269,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 		buffer_info->dma = dma_map_page(&adapter->pdev->dev, page,
 						offset, buf_len,
 						DMA_TO_DEVICE);
+		if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
+			goto dma_err;
 		if (++next_to_use == tpd_ring->count)
 			next_to_use = 0;
 	}
@@ -2277,6 +2294,9 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 			buffer_info->dma = skb_frag_dma_map(&adapter->pdev->dev,
 				frag, i * ATL1_MAX_TX_BUF_LEN,
 				buffer_info->length, DMA_TO_DEVICE);
+			if (dma_mapping_error(&adapter->pdev->dev,
+					      buffer_info->dma))
+				goto dma_err;
 
 			if (++next_to_use == tpd_ring->count)
 				next_to_use = 0;
@@ -2285,6 +2305,22 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 
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
+		buffer_info->dma = 0;
+
+		if (++first_mapped == tpd_ring->count)
+			first_mapped = 0;
+	}
+	return -ENOMEM;
 }
 
 static void atl1_tx_queue(struct atl1_adapter *adapter, u16 count,
@@ -2419,7 +2455,8 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
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


