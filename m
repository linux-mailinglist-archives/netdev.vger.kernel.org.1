Return-Path: <netdev+bounces-109062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7C76926BF2
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 00:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 07166B219D1
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C6B1194A54;
	Wed,  3 Jul 2024 22:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="HQwTWfcW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC001946AD
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 22:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047027; cv=none; b=DBZWC1ClbEPiRCykzVtRkQkS1I3rjOzaTy+oyWkcNO7uewBwo8+1q4789qI624VcEUCJFpFlqhraYd6gQN9KSV5hSttdhE/MxVSbGOGTKmRxKu8L/XuzCRiKjhVrJ/sJ59VlrPcQlk8fsZlrHgJE0VCHVabOdM2WRQSh949ZHgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047027; c=relaxed/simple;
	bh=GK9+4fsw5mg3MTHQHZsEP8Nb3K40cBkZUobb4VT8edY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W5ChA40eaVgvJuSdobBkbr2mK8n9mqZhGpTF7/yWOif6UKS0oBGKae9bIMbRW6XOYGU2K2UzjnK5sL7qGuhJSU4BwcwfpbK9VSjbcT6gkIALuqN4u1Glzod1oZ3t0BxicM2VkOphzbc1/AZiEnhbjtI8ZSJaVhy0DSljCVqd610=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=HQwTWfcW; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1f9ffd24262so13245ad.0
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 15:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1720047025; x=1720651825; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgUwi2TajpGKplBiRXJeG7L0Ro59oIO9Uz5u0Fl3C4I=;
        b=HQwTWfcWAnkwvxNjxlrG/WP3iitdUDUWWvApiTpPZmjvzyFbVLFzTT8p+1U7GbMFoC
         kZAZnk2hGbjiEB4YNgIqyreDzRLpiQn6km0e/IIch0q1UYBm/DygjTsDh6XJYxZUcO3x
         VA7A+2TAS+LWXL+8RuyGjWrHRFlQmpiVGdgLC5hb4bN3P8jmA2+fg0gtmw46f8RpkBnN
         j+8V7khSoaYF3hS2dymvyaLQbfAxtFH1Uqa+VBtqkACo1hjLV1yOVvJ2FIIr4KWtDpAE
         r4LCIMkAxFGW5WsHQZoSd5dN48l3dg4Oa6wWJDioFA2lCXTjvl0GjkgOa2KUCG+xRSGK
         Zh0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047025; x=1720651825;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qgUwi2TajpGKplBiRXJeG7L0Ro59oIO9Uz5u0Fl3C4I=;
        b=qNCyjnMufFMW8DLZLKROmpbnLHWQIPVFxuyNV9n8uh7TRRAjNoc6lDYJCjBJSvMVIE
         V/amyFItSt3fUJzO40A3DOhYdeyMm7g3i+HCpEChMekfpaf237MZYz3jXUjXNhd3in9/
         lYN/kpeJGJaA1xNCxkLZ+du8+Dm62cVF2CdnfaXPkCye9hEx7nlEbknJ+asXGGyCMIKJ
         zLH380VuZSX/cQi+x/EaqCuviYau5FnBXOEksVXaLdvDSs8UYhHOBc5TXBt4DRBLLPx4
         Z1T8mlzwtUnpRtO1lGehJm7uQkrPUaRxMDU5S3xSFjU/NDbDHqbR56mbfsp5JUhUOBLr
         ycKg==
X-Forwarded-Encrypted: i=1; AJvYcCVVaWMSe7YagvDKEX2M9hclYZ/b6YtARm+mJvV1+GHOcNi2k+zf09EK2dBrrLQoYJ1yvA/k1KahEBCypNADmkOPHfUP0nJn
X-Gm-Message-State: AOJu0YxIU/AX9iptxD0RDw2y0GOfNMq27eNsaAeIIXoRWUhkKQFt8VIS
	FpuXlwymnQMs5VSwD8XcXcb8uw4/pNtXEbVoa4VeTEm/xkPeawdy1CtOZZ7XXw==
X-Google-Smtp-Source: AGHT+IEGx6Hc6SuyMDHoBdQypFFwS7PBiucaSyCsci3e/42za3IQqfSn6uhJ3zDm1omCYe9IUvqr7A==
X-Received: by 2002:a17:903:2308:b0:1fb:2ba3:2f6c with SMTP id d9443c01a7336-1fb33ef9152mr24465ad.52.1720047025138;
        Wed, 03 Jul 2024 15:50:25 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:af8e:aa48:5140:2b5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faf75b3407sm40242185ad.85.2024.07.03.15.50.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 15:50:24 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [RFC net-next 05/10] cavium_thunder: Call skb_set_csum_crc32_unnecessary
Date: Wed,  3 Jul 2024 15:48:45 -0700
Message-Id: <20240703224850.1226697-6-tom@herbertland.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240703224850.1226697-1-tom@herbertland.com>
References: <20240703224850.1226697-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a validated offload CRC for SCTP is detected call
skb_set_csum_crc32_unnecessary instead of setting
CHECKSUM_UNNECESSARY

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 drivers/net/ethernet/cavium/thunder/nicvf_main.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cavium/thunder/nicvf_main.c b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
index aebb9fef3f6e..72157f9542c5 100644
--- a/drivers/net/ethernet/cavium/thunder/nicvf_main.c
+++ b/drivers/net/ethernet/cavium/thunder/nicvf_main.c
@@ -824,7 +824,10 @@ static void nicvf_rcv_pkt_handler(struct net_device *netdev,
 	skb_record_rx_queue(skb, rq_idx);
 	if (netdev->hw_features & NETIF_F_RXCSUM) {
 		/* HW by default verifies TCP/UDP/SCTP checksums */
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
+		if (cqe_rx->l4_type == L4TYPE_SCTP)
+			skb_set_csum_crc32_unnecessary(skb);
+		else
+			skb->ip_summed = CHECKSUM_UNNECESSARY;
 	} else {
 		skb_checksum_none_assert(skb);
 	}
-- 
2.34.1


