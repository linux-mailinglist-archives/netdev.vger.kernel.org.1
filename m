Return-Path: <netdev+bounces-189149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E2CAB0AAF
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 08:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED8123AF3DC
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 06:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47DC6267B9D;
	Fri,  9 May 2025 06:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="md0l8X+l"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653F928F4;
	Fri,  9 May 2025 06:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746772674; cv=none; b=JovIxK2YEwbbs1CSzvWzwnz13hiFeQ2eun0GO1ZDKaZiHIWMAxBSU8NmWTpdffLmXm1Qaol6oxAh3pZKGDwra+e2mUVFLIKKM57tMWVsJme39begHvGCjE8kwImeYX2+pNNLKCDmQjTKcxsKKuQxk+FqmQQ4GC9j5KY5iSJfgmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746772674; c=relaxed/simple;
	bh=s4pQVEjbJ40eu1L5qoBwYrySDn9uGLHKDWxlDMpxxfI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MsAolH0elgyIXeqTeBXTecA67A2jklwzk/CsoGbwqBSTbPqKSLzUg3auVlAyFdfa2kX746Jsc7584qJ2Wl0REo/JZkyVgEH7gJS7IIfjg6EHjoVtE2sOjn1g1XbMSxlGkMSnc89YiJ/gJ2UsNdlf/DEVdNGWo6J0UhXjHJl8Hqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=md0l8X+l; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3a0b9303998so824320f8f.0;
        Thu, 08 May 2025 23:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746772670; x=1747377470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OqmG3BJjsmTUqEq8AZgWfba3ERYP+7PeG6T0Jf+wIRU=;
        b=md0l8X+lNNcLI7x1Z/mEodFVk5O0O5Zx0aELUtkcfmq1DHR/ZWcQA3Ud8SfqlwnBLd
         ExLLnNSTEgIqKngz0RRgoeGT4i8wa1Va2Jigwpgp3f7bnOad3xsYyZgG0ernflH+nn2/
         Fa3C4QO3x3uKeGhKh7iLpL+ROVvmsv3lOc4/On+qQZqTFCnsCD5/K8t3AwtB2r8k6AzQ
         veH4IsR27tT3H0QAnnvcZruGuyfst5sjInkBSR4/qubgrVJtCKYq+XPLBs65PKIVl0HN
         xcEmhPIOImHx+GM86oxcuSnilBOZDKzbBaRZuj1SAYLUnU2AZn8QWYcHprXZRkLmWxLm
         uf1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746772670; x=1747377470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OqmG3BJjsmTUqEq8AZgWfba3ERYP+7PeG6T0Jf+wIRU=;
        b=JJB8axmCp0Nc+t3SylFtnwJRrorsYK6gCavwREJlBatd+HRyhrygDYP+kdvkHOd+7x
         AsS16NkeMriuGtHTGc8qp8V+/L0w5a2KZTS1UFqVaqTYQrPDSA+qSXwmRXaCTbg7vBN/
         CTkpOgKKKK2U6PH6J8x1iCNWR/iK+jDlNmdomNBofYgq8xre+OT7K3BDdNnbDVrpzmKN
         eDH0fw3aXIEjTHEa/I3P7Ezf60DLYeAZ7US5FIWyhgg31YSJfLwtYUsb5mwFPYN75kMn
         yMzs3xBuWcE/a7PTkEC5WrS23Pz9c53sZfa7M72FPWsOntorXy1pcQVyeTvPuyA8MoZL
         H1fw==
X-Forwarded-Encrypted: i=1; AJvYcCXt6s/jwj31tC5t5daSRT+0NnvFLaOW6oeAEnu2Jzk20Q2xJFjpqfUjvYqu5XTfE0jw5hTVvABmc8iUGaM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjndE2hOFJ4kLl0bvSjY685P1oT1Cb1RUUmuPRAsUfqS1M4J+B
	fe1o4CM4LZZEh4mRY0qbEmVrRub/Y3pAiFnSekUpXVcLsJSZ/Opq/Dish/DN
X-Gm-Gg: ASbGncuPtW9UDOO41lMQ03n7fWsQGDO6QjXwhBpJ0YPkKgIaE2+5VI6+Jpx9DjI+TNx
	/C6T3sVvy3FPKWeK4OJaTpZu8W8BsPFqroP1Tw199V+2OImRJtR+sdtwaIGbqqpRiVzLoquabUf
	Vox3gSheEcH5As4OTjkvH9DR+cbVeRC7oDeT3+4DJ6VwSjmS21QC7asxkg7SQ7RC7Db7gpZsQCX
	VtmJG71lH09E1NtMxBRRaAUpD0riCRcjGS2XdPxkZ9o/80aJZs6ZE6mHHt3d5YoXaa8pdpgV5A5
	05TY6yDpskWRN62sbGMwbVUPIuKkQXaMhBaEeWgmTW5ztTxhxTZkUO4g9XcsK7uTlw==
X-Google-Smtp-Source: AGHT+IHw06gGDN3zr31JLWJ1Q/qbSH1hi3YVW8+/TRJJ4XJQ/05RFm9FjdAFuvESuwnntbNjmEV+Mg==
X-Received: by 2002:a05:6000:2011:b0:3a1:f653:26a with SMTP id ffacd0b85a97d-3a1f6530370mr1712267f8f.16.1746772670183;
        Thu, 08 May 2025 23:37:50 -0700 (PDT)
Received: from localhost.localdomain ([213.74.214.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442d687ae5asm18325745e9.36.2025.05.08.23.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 23:37:49 -0700 (PDT)
From: Can Ayberk Demir <ayberkdemir@gmail.com>
To: netdev@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Can Ayberk DEMIR <ayberkdemir@gmail.com>
Subject: [PATCH v2] drivers: net: axienet: safely drop oversized RX frames
Date: Fri,  9 May 2025 09:37:27 +0300
Message-Id: <20250509063727.35560-1-ayberkdemir@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250508150421.26059-1-ayberkdemir@gmail.com>
References: <20250508150421.26059-1-ayberkdemir@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Can Ayberk DEMIR <ayberkdemir@gmail.com>

This patch addresses style issues pointed out in v1.

In AXI Ethernet (axienet) driver, receiving an Ethernet frame larger
than the allocated skb buffer may cause memory corruption or kernel panic,
especially when the interface MTU is small and a jumbo frame is received.

Signed-off-by: Can Ayberk DEMIR <ayberkdemir@gmail.com>
---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 46 +++++++++++--------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1b7a653c1f4e..2b375dd06def 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1223,28 +1223,36 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
 			dma_unmap_single(lp->dev, phys, lp->max_frm_size,
 					 DMA_FROM_DEVICE);
 
-			skb_put(skb, length);
-			skb->protocol = eth_type_trans(skb, lp->ndev);
-			/*skb_checksum_none_assert(skb);*/
-			skb->ip_summed = CHECKSUM_NONE;
-
-			/* if we're doing Rx csum offload, set it up */
-			if (lp->features & XAE_FEATURE_FULL_RX_CSUM) {
-				csumstatus = (cur_p->app2 &
-					      XAE_FULL_CSUM_STATUS_MASK) >> 3;
-				if (csumstatus == XAE_IP_TCP_CSUM_VALIDATED ||
-				    csumstatus == XAE_IP_UDP_CSUM_VALIDATED) {
-					skb->ip_summed = CHECKSUM_UNNECESSARY;
+			if (unlikely(length > skb_tailroom(skb))) {
+				netdev_warn(ndev,
+					    "Dropping oversized RX frame (len=%u, tailroom=%u)\n",
+					    length, skb_tailroom(skb));
+				dev_kfree_skb(skb);
+				skb = NULL;
+			} else {
+				skb_put(skb, length);
+				skb->protocol = eth_type_trans(skb, lp->ndev);
+				/*skb_checksum_none_assert(skb);*/
+				skb->ip_summed = CHECKSUM_NONE;
+
+				/* if we're doing Rx csum offload, set it up */
+				if (lp->features & XAE_FEATURE_FULL_RX_CSUM) {
+					csumstatus = (cur_p->app2 &
+							XAE_FULL_CSUM_STATUS_MASK) >> 3;
+					if (csumstatus == XAE_IP_TCP_CSUM_VALIDATED ||
+					    csumstatus == XAE_IP_UDP_CSUM_VALIDATED) {
+						skb->ip_summed = CHECKSUM_UNNECESSARY;
+					}
+				} else if (lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) {
+					skb->csum = be32_to_cpu(cur_p->app3 & 0xFFFF);
+					skb->ip_summed = CHECKSUM_COMPLETE;
 				}
-			} else if (lp->features & XAE_FEATURE_PARTIAL_RX_CSUM) {
-				skb->csum = be32_to_cpu(cur_p->app3 & 0xFFFF);
-				skb->ip_summed = CHECKSUM_COMPLETE;
-			}
 
-			napi_gro_receive(napi, skb);
+				napi_gro_receive(napi, skb);
 
-			size += length;
-			packets++;
+				size += length;
+				packets++;
+			}
 		}
 
 		new_skb = napi_alloc_skb(napi, lp->max_frm_size);
-- 
2.39.5 (Apple Git-154)


