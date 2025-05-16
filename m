Return-Path: <netdev+bounces-190961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2B2AB97EB
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 10:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EA0E166C6F
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 08:44:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED8122DF85;
	Fri, 16 May 2025 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dj84Ptfj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17DDB22DA1C;
	Fri, 16 May 2025 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747385043; cv=none; b=j5cLuxK7BemHu4GPNCZ+HQ9RBjYuUxnZh9atvmwkvoIO8/U5YvTsgMMz14Nw0XKXTK8hCaTCVT58Xxe9k8o040O8uvx2BFHF3wHufayBREP+48DLEhd1/MslM8rahwT6wJwChcjWP017PmgbMNu+jgaDhBQaphOHJ9OQ1OlV+JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747385043; c=relaxed/simple;
	bh=PEe/BWeTXTas3wR7l/W/bpH8YZaNXD6PalA0ThrUNZg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BF4iF9P3TPbp8yyPCswxPtWFe7+3lIx71OV93l1aqnKmGFiBKsJXyoIq0MQocfdllDL5eDRjd2xQfmHNjTeWsvRT/Gf5/P1xcRglvK4GgNKw6+dgqt3f511ijVNmjuGOEMNnYmZl+nyEHxjmxZNV0y/AcqnTyt9rC6z+hbW7RFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dj84Ptfj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43cf257158fso13212605e9.2;
        Fri, 16 May 2025 01:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747385040; x=1747989840; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wtu7zpoEhIazPVBR9VLrQ2O+ovOuUIuW+9nEGJrTJjc=;
        b=Dj84PtfjvZS/Q5NV3i06KBdZTUEhBpm3wn8GDOk9qb6ySr6Avbz5x6JzFL+pE7QskY
         PPK6/erIMm97OqRHdobfvHVJlr8cxT8FxW9aiLAeyKT7KYK2C1KELsaOlz3xGQnoKxhT
         X5Ky95f75t2NGix6ricmpZRm4OMX7m1fjdcmyLEVN794Avjs+FYsrgBndkHAMrVTRoz3
         cfSenpPx7a4nKtnjNX80962rVHQLhQmOotMKCSjFsPRdI1RVzdkdTwikWUmMR9z9cSZH
         jObhu4t014ODbByHh4MR4+mrkGW4gDbeICHEW89kvjM+Adecvgb/b31v2snougubA01m
         nKYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747385040; x=1747989840;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wtu7zpoEhIazPVBR9VLrQ2O+ovOuUIuW+9nEGJrTJjc=;
        b=bpjx7RTf/L9J3/jK3s63hoggOgD6FgII6uQeyUsclfASvQWgS+HeebwAhOt7m16fwq
         t4VEIn+qYkGv0JSAHLNxIiudD9+3yeWKbUJCf/6hKntLhNiWeJKvxFzgj/JlYVYTsx87
         sn15nTS8R5o1sCV/tD2GoUJr5EraPyhFR+XB477XhAyzRCUAYekL8qXOpc/scLhNgRoC
         CP9fhEyji7feUvY90TP5lVHsnqkszVF+AF2+JKqdx3b1Ji2S+8ToMcZIJ1l+zBPSUHPo
         QUIoO6Z2umPCflfnkHZFRUJ5rzX9l1tJVeIB7K2S0/aSXuyMn27hi3kxzErUfDwbuN/u
         I4Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVgC/+Q/H1FsGGyJYxaqp7ofY80tZDWu3dxNSjrdfqfqQM0E6askpaX2Kv05sS5JcDOV0CFTI+7LsltH7Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/azEuUQhT+oJL3fy4nXRUEyCdE8DdlUPC9CWwNtEoBsnyB0Wo
	s4yL4NYSsvyNP5yDvcadOgLo07v8spK9jdh+ZoKHjpfLe822AqLXyTNoyh9x3ZfK
X-Gm-Gg: ASbGncvyRDUK/uDn6ZIr79UKMs7roH+AXBl/63FOtgByhZy5sy8DBffmqN95GP+ZpLC
	cjtg031NaKiYIULTmdbLv//2bWABBLnvl3Q3FLfFOrGzYcFemMoG4J3vFTOOdCxi6B4jZPF35tT
	0KPLEEih6SO1AacFgXthMqQA3zZVyKcz0NEWq9SShvUvcAfkOaS7LkpaUFwVR58ghDTz4ZRw7LS
	p6/NM4/iBR7jri0bFVtvRf5of9USOWzpfZ3J8JPnYehey+z9nCeYpbg/jcCSDb3tLfTi++ZQb6F
	ehpSxsf+BYK5KSglphN/Uv8itxTAoaDFXDqT7d7RreQ8xx9E9aYdt+c55eLQ9GjWRSrh9TVVqH0
	B
X-Google-Smtp-Source: AGHT+IEYZb/TzXzZVFqdhqGt3K1l/2137LORafBeymggFrs92Lp+L3YIGu5RsSNqD4chBhDRXMQG/Q==
X-Received: by 2002:a05:600c:821b:b0:442:ccfa:18c with SMTP id 5b1f17b1804b1-442ff03c671mr12712175e9.32.1747385039900;
        Fri, 16 May 2025 01:43:59 -0700 (PDT)
Received: from localhost.localdomain ([213.74.214.99])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442fd50ee03sm25352005e9.14.2025.05.16.01.43.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 01:43:59 -0700 (PDT)
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
	Can Ayberk DEMIR <ayberkdemir@gmail.com>,
	Suraj Gupta <suraj.gupta2@amd.com>
Subject: [PATCH net v4] net: axienet: safely drop oversized RX frames
Date: Fri, 16 May 2025 11:43:34 +0300
Message-Id: <20250516084334.2463-1-ayberkdemir@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250509104755.46464-1-ayberkdemir@gmail.com>
References: <20250509104755.46464-1-ayberkdemir@gmail.com>
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

This bug was discovered during testing on a Kria K26 platform. When an
oversized frame is received and `skb_put()` is called without checking
the tailroom, the following kernel panic occurs:

  skb_panic+0x58/0x5c
  skb_put+0x90/0xb0
  axienet_rx_poll+0x130/0x4ec
  ...
  Kernel panic - not syncing: Oops - BUG: Fatal exception in interrupt

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")

Signed-off-by: Can Ayberk DEMIR <ayberkdemir@gmail.com>
Tested-by: Suraj Gupta <suraj.gupta2@amd.com>
---
Changes in v4:
- Moved Fixes: tag before SOB as requested
- Added Tested-by tag from Suraj Gupta

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


