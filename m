Return-Path: <netdev+bounces-189197-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22E6FAB1115
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03E51C27E90
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 10:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0419D21FF5F;
	Fri,  9 May 2025 10:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBxyxfVF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310E47E1;
	Fri,  9 May 2025 10:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787690; cv=none; b=kStClhRrF/fqabq4Y3r2GvbQ133tNLFUlFc6Qik0ylGaPiD0ffQ7/vgnZ88mLFzj/PvdURHxzRhHSGUMHRo+zhr+3Bd42P/D4ki4azGEnOjuypjF8J/C+nkNzHzZzfD4pP+hHqwH6Kqmt+cNzhjM/zZoK/Eby3FblS7+iw99BNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787690; c=relaxed/simple;
	bh=iGoieQwCSfP1ASWGKoZpoOVrAimJujiUhEJ+oUEPuTI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=swGqdVzjPXjogbwAEsA8vmyYEkDMdZHTJo4XQCU63hSr1quv2FQR5d8ZpXV3AGq+f4qKUZPUQtY0e6Xryvm43XSpJ+rjzkx3tSbxsLRuCJthIGOyTkbg8R4X74esve7ldORGXUSmg4PO/ySuwmsqah3wniw4fnWzEN3c39hxi3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBxyxfVF; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3a1b8e8b2b2so738399f8f.2;
        Fri, 09 May 2025 03:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746787687; x=1747392487; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s9T8T/ReTxgwbEq7ya1SQEkDgr2GKZ+FCDb4DaJFUwk=;
        b=jBxyxfVF50POAcjkwXmD3e5MJaniurxAkPmtxqRDM8mFXua22nnvJ/0E93XOV6/N/0
         BBBoX4pQXK93S1vqSSDDGZTE1fLfMPiwXHHhXyioOv8E44h2rbQliXmHBW4jx+agaJEV
         CGtcHH1PkGs6ssHtON+/h1pUL2+zQFbq/PNcNWiHhWFLbnWVsNHJbFTnk9hl3Mh9NqsH
         +xvSYUjpWIN5k7jeqk7JY80HzFZTUnUNqT5VYkE6aoUPhPhQbvZa6W6nt8mBe1D8Zzf+
         06uiyDa6ga8LoGuDXdS6m5vWQi4xiCC1LJ34OSsns8JEGVUUPsAD+HNXgxOXj4L4+X2b
         6Ysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746787687; x=1747392487;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s9T8T/ReTxgwbEq7ya1SQEkDgr2GKZ+FCDb4DaJFUwk=;
        b=dY+/EK1zGI0KQuGgZQbON6dA3BeJ1dIR5OoKCWvqWebF6xmap9ahI8Wf19DRWvHGol
         pX2keUlnYvn/CdOq9SPQH/3auc1n7JG7JAFTUduRwpP2DL3LZTNrtihU9JB5QezfWDyF
         +f94tVj6CyIMw+q8wfHr3j/lHC9YSGjv6GKamgS0ykWrmhujQm+iK3JyeWWkqYl58FE8
         82sXlehYB6FBBX1g/PsJ5YaoYImx6Z6OnacIh36FatsHQWj5/oSXz9eQ9AqG67asSYm/
         lDZlPSzDjUW5XHZiH+raGt2mfUhCf+Iv0aA2WstB+2eZqaJa0gkIt3+ID5R6MC8enupP
         eWeA==
X-Forwarded-Encrypted: i=1; AJvYcCVb8UdBpwzv3qEU+6T13uPcZ+xYtJyRLs6dfNT1lgGeWGMsCYsIz5TqdRRC4w8O+RoovFqaGQo2luYS8DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhFgcFW1XroWXPGmuEhr0qXJ6xhFajumMLfM5J+K/Ak4f9UPyl
	EbtJZrpUAkQppu7MdI2yA3GBbX9Vur3CfUd8VzbkD3eOP/UBsrJ6C3ASD+z8
X-Gm-Gg: ASbGncv2DlT+T1YJIDVEDBQ8nGnDebmheLuoJ9xklJHWbfCzMu/L3iaQs4LIId/ce4x
	eqSPOgkMljFJmB7gUPDarUK4rVtmVU1g4Wgim44N9QhLEiJ7xFSjcU6YeGUYMLUnsn3gTx0YINn
	cmW+FjeCqFGvklDeWonlUCeNv6wdPAS1172z5fqIADcAYQXq4kZPOQDufszckJQMuN9exIWop4+
	lRqPceMj+rdds0zBhtQ71ejl6YwyksCZH/DuEnB0YqHy4SHKr02p3RGVPEsO7/BSHPBm/kz0gwL
	ZTUz1qoRwh5PrWA22omcjR7oQ2I0x8FuXUv4bim0chnHdyJBUJodMzU8YXyw94f2YQ==
X-Google-Smtp-Source: AGHT+IFtAH91VP8QSNCEvYfohxbRfIAX3co/acDz06MBIE/Bypsf/wab4pdtNVbPUS+FToPQSe8O6Q==
X-Received: by 2002:a05:6000:250e:b0:3a0:8295:9e0f with SMTP id ffacd0b85a97d-3a1f64a42bdmr2186936f8f.54.1746787686982;
        Fri, 09 May 2025 03:48:06 -0700 (PDT)
Received: from localhost.localdomain ([213.74.214.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57ddd5esm2843779f8f.6.2025.05.09.03.48.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 03:48:06 -0700 (PDT)
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
Subject: [PATCH net v3] net: axienet: safely drop oversized RX frames
Date: Fri,  9 May 2025 13:47:55 +0300
Message-Id: <20250509104755.46464-1-ayberkdemir@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250509063727.35560-1-ayberkdemir@gmail.com>
References: <20250509063727.35560-1-ayberkdemir@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Can Ayberk DEMIR <ayberkdemir@gmail.com>

In AXI Ethernet (axienet) driver, receiving an Ethernet frame larger
than the allocated skb buffer may cause memory corruption or kernel panic,
especially when the interface MTU is small and a jumbo frame is received.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")

This bug was discovered during testing on a Kria K26 platform. When an
oversized frame is received and `skb_put()` is called without checking
the tailroom, the following kernel panic occurs:

  skb_panic+0x58/0x5c
  skb_put+0x90/0xb0
  axienet_rx_poll+0x130/0x4ec
  ...
  Kernel panic - not syncing: Oops - BUG: Fatal exception in interrupt

Signed-off-by: Can Ayberk DEMIR <ayberkdemir@gmail.com>
---
Changes in v3:
- Fixed 'ndev' undeclared error → replaced with 'lp->ndev'
- Added rx_dropped++ for statistics
- Added Fixes: tag

Changes in v2:
- This patch addresses style issues pointed out in v1.
---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 47 +++++++++++--------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1b7a653c1f4e..7a12132e2b7c 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1223,28 +1223,37 @@ static int axienet_rx_poll(struct napi_struct *napi, int budget)
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
+				netdev_warn(lp->ndev,
+					    "Dropping oversized RX frame (len=%u, tailroom=%u)\n",
+					    length, skb_tailroom(skb));
+				dev_kfree_skb(skb);
+				lp->ndev->stats.rx_dropped++;
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


