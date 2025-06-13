Return-Path: <netdev+bounces-197395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50001AD8899
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:56:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 068E116939F
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 09:56:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86872C159F;
	Fri, 13 Jun 2025 09:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d0Jx9Pmm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D1E2C158B;
	Fri, 13 Jun 2025 09:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749808597; cv=none; b=F8y2ANaFEiM0T34XMwGLhs7GOgW+3uGeCLlSFoYbrePbxaSGnIDkLjUya+shaxkpCM2EBORkKAHb0voa9mSGqZiNDarwoffonQj/Z7inlQL8NzaAXPVTwuA3oOCdFpVpNYtTeoecRc6SWKKz8MReLzXu6vJoHj6TZ3hS4QEGL0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749808597; c=relaxed/simple;
	bh=bPxha2Xcu3gnmDgJ+sO40rP34w3Cu8XjpqJ9R4eEoQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JsB2pqGEb8OLerU8W3nz1xyo6d9hXFonbUb1b4+f0BsT2XYeLnfXNQQTyC3VtTnG0KecI+10hcwqr/6c0YFUiqGAj44ZizYnnXnyYbwOr12+SpLIVv2IAs0F9XAROU5IrPlHEJHXJzX0hMZbkQomkG2XzWH8aZH0X8NlN88loII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d0Jx9Pmm; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3a524caf77eso278694f8f.3;
        Fri, 13 Jun 2025 02:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749808594; x=1750413394; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nce6Ym0vqjs78qejFB/GFy83NREwUyPEHp0148HaRg8=;
        b=d0Jx9PmmTZ+ZGNXo6QEs+PON7TBaSV3Gq6kISJaoBtuk/mfDjfZjbqfAklNxUMgnZF
         lVbCcsSQQ3WfVbiR3Rs5U079bREmH77JPh7Pz3WKlCiV31rW0MfDspJK6tLC7S42+HJr
         ra+eA0b/ZaBk8qqqxEmJzqcdqBqMmO5u+AJChkD6l7GVSnvtWN4+BG3xCrX3Z7c9Tj9r
         5H/KyZcHBN5pEgrENJoOINfSx9hNEdU0YVFYfLM28Q8vLKfkHXSHeA7+kOFYgqh7diyZ
         CP0H4VQ1+2GjSzuKbDJBmx1ZIRyQjDGIzthDn96mj0t1pme9NMayf33xBf+fvcez8RSu
         gGmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749808594; x=1750413394;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nce6Ym0vqjs78qejFB/GFy83NREwUyPEHp0148HaRg8=;
        b=jS8j41CZK56lWXHoQgEXjQJoZsYT/n5jIlK1hK2+36GCp9Y7VOQH/pEkpwrnm6lSME
         gRK5nqbEo1v3/g3O6IKkIA0i1UihqoVTcCvHJYZRTsGN1vziINaek6t9jbOk9ROWzjVd
         T0qaxvFZbtvzWcsLQ5NdmNLv0d/jiolbWBLxA694nWhPsQ/OjMpfXNU7/vEIRBrmT1W3
         nGsCD597Phm02Ev6+cll+6ZXgSL+zjJKJWrFbD8Qx4+Vidaid+faV+zi0x37PkvZDW6n
         EE+0m60R4Uv85YqiuP3LninJSWRiJAWw4+xKaHV3HJEoedPPky3YKytjonp3Ja54Bw6Y
         YR1w==
X-Forwarded-Encrypted: i=1; AJvYcCVagZ4z8FaAmB0BbRYoR5dlmPj7KEpNThg+/CSP2UKLwqxcFbnpn2a8eqa7pVKxFWGd9xfvhdA30FjxC8c=@vger.kernel.org, AJvYcCXhqSLioqLysuYtET6bnY2FLVcDl6xjQ1lOz9aY2cnEXOuTAIg1zYqXvBHIKGv4g7nqyX7dYMjd@vger.kernel.org
X-Gm-Message-State: AOJu0Ywolg5fT1fcNOLU8aZbWPyVRX9dHrRKvWJlY/gEGShKzQZ0H688
	zhdBwt5v7dr+oX9bOMCY6BZHIzfT+vuVAdJT/BHt3hO4xbKuZpzIgOBO
X-Gm-Gg: ASbGnct0d32pwR41/xSnSbZzNA+QZO64fXoUhDZdc863oMBUeyFjm+yaUijl4ZwZTFJ
	01r2YNe08EGTgiPRtAUCOKD34VnFe4FGM4PhcJLcW202QCk18+DrInOHgEPTsrMJWg5D+x1hGiP
	g98vuq6h0JZp0MvswLXKQYnOuBW8kH5UbAtNCkzH3HJoTMlp32AZbdaQACJbhzytZzuHmc8iKAu
	vnSC9JDgdH34zMM1126TIdkan+5iuBABB5i4kj8pJIFHQGvUCiCkGUGwIb2IQXDRCSrWxJSkkTY
	uagxleksHmH8tkfiOI9G1rF3+YRDvcs5u3Ezz0vkSHY/QSSQIUikKhP/Foj7mIcRhRdBmG7rFSF
	S1z4F4Hzj5E1RAWuK9JKaKJhXQCmAY6ks2kJPc5+RlxVRVRqHm6fWAALNavmgiJWR9jHqZmeF1A
	==
X-Google-Smtp-Source: AGHT+IEziPQdq0KF6UI5r4uYSQ+fvzC2O/JjbNzzT8lc5Gibr2CfkffMVFgazAI3BwVOyYBJIIl3ng==
X-Received: by 2002:a05:600c:a10b:b0:439:9a40:aa27 with SMTP id 5b1f17b1804b1-45334b2b435mr6180485e9.5.1749808593874;
        Fri, 13 Jun 2025 02:56:33 -0700 (PDT)
Received: from thomas-precision3591.home (2a01cb00014ec300ef49063bf04e52e9.ipv6.abo.wanadoo.fr. [2a01:cb00:14e:c300:ef49:63b:f04e:52e9])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4531febf905sm88978955e9.0.2025.06.13.02.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 02:56:33 -0700 (PDT)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	Chris Snook <chris.snook@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] (drivers/ethernet/atheros/atl1) test DMA mapping for error code
Date: Fri, 13 Jun 2025 11:54:08 +0200
Message-ID: <20250613095516.116486-1-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250612183234.51a959e9@kernel.org>
References: <20250612183234.51a959e9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

According to Shuah Khan[1], all `dma_map()` functions should be tested
before using the pointer. This patch checks for errors after all `dma_map()`
calls.

In `atl1_alloc_rx_buffers()`, the buffer is deallocated ans marked as such.

In `atl1_tx_map()`, the arleady dma_mapped buffers are de-mapped and an error
is returned.

[1] https://events.static.linuxfound.org/sites/events/files/slides/Shuah_Khan_dma_map_error.pdf

Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/atheros/atlx/atl1.c | 39 ++++++++++++++++++++++--
 1 file changed, 37 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/atheros/atlx/atl1.c b/drivers/net/ethernet/atheros/atlx/atl1.c
index cfdb546a09e7..d3cd51ccf621 100644
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
@@ -2183,7 +2191,7 @@ static int atl1_tx_csum(struct atl1_adapter *adapter, struct sk_buff *skb,
 	return 0;
 }
 
-static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
+static int atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 	struct tx_packet_desc *ptpd)
 {
 	struct atl1_tpd_ring *tpd_ring = &adapter->tpd_ring;
@@ -2195,12 +2203,14 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
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
@@ -2216,6 +2226,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 		buffer_info->dma = dma_map_page(&adapter->pdev->dev, page,
 						offset, hdr_len,
 						DMA_TO_DEVICE);
+		if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
+			goto dma_err;
 
 		if (++next_to_use == tpd_ring->count)
 			next_to_use = 0;
@@ -2242,6 +2254,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 								page, offset,
 								buffer_info->length,
 								DMA_TO_DEVICE);
+				if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
+					goto dma_err;
 				if (++next_to_use == tpd_ring->count)
 					next_to_use = 0;
 			}
@@ -2254,6 +2268,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 		buffer_info->dma = dma_map_page(&adapter->pdev->dev, page,
 						offset, buf_len,
 						DMA_TO_DEVICE);
+		if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
+			goto dma_err;
 		if (++next_to_use == tpd_ring->count)
 			next_to_use = 0;
 	}
@@ -2277,6 +2293,8 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 			buffer_info->dma = skb_frag_dma_map(&adapter->pdev->dev,
 				frag, i * ATL1_MAX_TX_BUF_LEN,
 				buffer_info->length, DMA_TO_DEVICE);
+			if (dma_mapping_error(&adapter->pdev->dev, buffer_info->dma))
+				goto dma_err;
 
 			if (++next_to_use == tpd_ring->count)
 				next_to_use = 0;
@@ -2285,6 +2303,22 @@ static void atl1_tx_map(struct atl1_adapter *adapter, struct sk_buff *skb,
 
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
@@ -2419,7 +2453,8 @@ static netdev_tx_t atl1_xmit_frame(struct sk_buff *skb,
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


