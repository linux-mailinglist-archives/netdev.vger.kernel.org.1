Return-Path: <netdev+bounces-189020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5E2AAFE41
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 17:07:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66D883A9474
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 15:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A4727A90D;
	Thu,  8 May 2025 15:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahfM9PJD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5923248166;
	Thu,  8 May 2025 15:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716682; cv=none; b=eIlpIuMlmbw9sIEypH7r36q4U/oBszPZ1WcLwK7c2d6qWjYJg3+1RzQd23WJPfuND2uhuy6liNE98O1OcWHeXeKw/859I1GtdCTIDL7gsFihvacE2oWKIE77SB7qTk8dK05T3PRiIKqsntn4I7BL+8QCo/m9cYrN+nkXrDiH33c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716682; c=relaxed/simple;
	bh=XVGMs2zZ9XDVJ3xOsw9xnGxs3fbN+Md4eA0UKHjMaRU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=o5eeaZtfVigRElU1tl40KBGnCNfHryi4XKgbNQCvDw4LaNhorbIkRrm/bPZl9G+G8TJEL3rmV3+OoUUf5+jiFM3xuVFCySL7SwlKei3NoIPeqCcvStHchfbfA6gwDsooo379ZFfdXnOZyZhzNRGHFUA9BmGwiohfJZpqTvPTwA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahfM9PJD; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3a0ac853894so930116f8f.3;
        Thu, 08 May 2025 08:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746716679; x=1747321479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FpvcT+h5EwgFmmmOYWFbj4igRatQjVb1OnlSMKQiQvU=;
        b=ahfM9PJDtch+7/csV29gzetFM+0Vf9O5cuGFssDg95vOTUmgN7Y/HIy7RlrX6AAqbn
         av9jhkzAHlNpmbB+uZCvkllRufojytkh46V2PJIxnXuYFaAHgsNDjDCYEjBHgTHX90rU
         llzOqA/mg7d2xRmR3UGx0z2RmjxAKHdFBBL+MWtpXJB308J5aQRSQwLq9pXN3eLYNJJN
         Y2xxYuqeFvPnDxSNX+Vt2Okd+VGsCFDVG98ZnBWbGlj3qO6xrOX0bDUiHQawxWwZGx3L
         PiHdbP8mBt4qtP50LGf0wEJVnIO3OpApTAd5gReys7Z5Z4IOWYwuXNLAT7ZuCLvrm0ED
         PdCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746716679; x=1747321479;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FpvcT+h5EwgFmmmOYWFbj4igRatQjVb1OnlSMKQiQvU=;
        b=TYu28tSRhh9Z/4aI6Ii64AuLHEyd4QWIy6NcWGI/zyelHaZjytsSiY491d0ZLoTsXE
         1xLRjmBdVXgB9AiyzCi8fmNmeegW6C0I1xDrOGJ9BAjPYINVSdSc+yMAdcpOOpApCB8H
         uy3YK2tri1KuCDcZGwEl9kQgYtlvXugjU/yBZWHHbvqE7Q3jUDp654PSSGMQW5DIYwyq
         9TEJuVwdlSGaQy6VZKi0pQh7P3oEZKTsrwg2+kBlXjPbES7cm9XFGRsQkPHrecAMPDei
         RiIY95nI6LIbjdhAJxKNcBeMk+lhGSCkBU/e5eZavgVPk21yeRm2SlP5sDRoJinlLbwx
         FymQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDAoTUm8knpdySYmlCH5f3eqyCNL1fwBJn26r58f5hWGClfVklgJf4AlUKWu91uhMLQYfaRM7KuKFoFIE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/c3rP0HmLJPsktPDrLhlFKtWLbstsYbmD/otbkSHIqMWyKkzA
	wDU8ZJTOLoUmMK6hMkA8aASWHO6m/LY1ZxyQEK2RPIQRPqCT6d4BcHA0iK3K
X-Gm-Gg: ASbGncth5IROpNYmOLc/bNbJ7iRSgV68cIIxhD7XlfJuvu7puXNhK2vny0znd06B5j+
	XhEYHGzpnq8VZQ2t0ibxoKmN+Cr0jzSRfl7bjIsHfm+XHn/E/8J10FWEJwcl9nzOk5e98hlGW5x
	UxG0xeeCOUuuiJEzvLWEpIRSXo8igEBRiC2sYjFyjrCGLvCJwLko/cBBlKfHCl7ab+WtA+zdRWS
	9EA3FigkP9nk+c3jgWyDnhXnibvkgbST3ssqhkabMGaa1jgkqLTyF5ujQa89sq1HG4ZkOmiHVWK
	dfB3+orwJtJ8EzN5nwzf/1ybbd0OfnAwrbPYl69BNHA2WVRbQhJXubbeQLcYYV5yKw==
X-Google-Smtp-Source: AGHT+IEHPtrPOJK+eqjwUZlcxZzsXijqzqCZn5IRrwfimc0LTvg8y1VHds9nI52eOIsgIthyfm8/8A==
X-Received: by 2002:a05:6000:1447:b0:3a0:836e:4a26 with SMTP id ffacd0b85a97d-3a0ba0eedfbmr2521969f8f.37.1746716667591;
        Thu, 08 May 2025 08:04:27 -0700 (PDT)
Received: from localhost.localdomain ([213.74.214.99])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f57de087sm232671f8f.16.2025.05.08.08.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 08:04:27 -0700 (PDT)
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
Subject: [PATCH] drivers: net: axienet: safely drop oversized RX frames
Date: Thu,  8 May 2025 18:04:21 +0300
Message-Id: <20250508150421.26059-1-ayberkdemir@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Can Ayberk DEMIR <ayberkdemir@gmail.com>

In AXI Ethernet (axienet) driver, receiving an Ethernet frame larger
than the allocated skb buffer may cause memory corruption or kernel panic,
especially when the interface MTU is small and a jumbo frame is received.

Signed-off-by: Can Ayberk DEMIR <ayberkdemir@gmail.com>
---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 46 +++++++++++--------
 1 file changed, 27 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1b7a653c1f4e..a74ac8fe8ea8 100644
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
+						"Dropping oversized RX frame (len=%u, tailroom=%u)\n",
+						length, skb_tailroom(skb));
+				dev_kfree_skb(skb);
+				skb = NULL;
+			}else{
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
+						csumstatus == XAE_IP_UDP_CSUM_VALIDATED) {
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


