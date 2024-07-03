Return-Path: <netdev+bounces-109064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E11AE926BF4
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 00:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2EB8284A7D
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 22:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF425194A70;
	Wed,  3 Jul 2024 22:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="HwJUGHi+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47255194AC5
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 22:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720047029; cv=none; b=UGKSX9jjhg7MvvFNnz8QB6oG+CK3ac7rNYOYX+iJ+rfXWBrGCySahnr50yDGKnqmnyxsnaVAXxt8/PLuJN6vTdkBWrxU+Z03DVri22TGPstzKRt4SsB9QV6+bZ2EHENVPMOK+j5D0bDgCwIGWQes5s7Ikf/Ilo34k1mLXh4rsBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720047029; c=relaxed/simple;
	bh=y/5XBT2zGJLo4oaSgQhEzSNcfSeLqRTuzxUK43iShk4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jxv05Tui+XT2B+Hv6wNyxQt+IkSAh3Lo+YdhrGtri9Vcx4JO2bzJ2fksfjCNzNCnlzzQMYz1FFDcCgqWlMOzcueu70D/xE2oxAP1hIGfBgjZL1WQH+CvPzihVVQrYhVikh6vDQymzH/Ma+b1N5Gpd04bAnOT5rX/l/2o1ai8nBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=HwJUGHi+; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fa55dbf2e7so34927705ad.2
        for <netdev@vger.kernel.org>; Wed, 03 Jul 2024 15:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1720047028; x=1720651828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQ1mn/CTHjHcc9W+sTHEOUlyKZEA9X33Luiw+Y6JViw=;
        b=HwJUGHi+OHYxiTMusrnwvYCrclq0cOdqZhFNHQaxIjEp6S5x9bsSPSrPkeJfAkoALP
         lhu5rW6fyi5Ucp2CF3QXDIRm8MD0YkJQZPPEagtREpaIp7lZ5w09Ce6o1UMa6T4KsPeX
         Qribz8JYDOHFJUOVFQZFkWeX+PjO1031gxBFwaKLUU1m0cYwudxJEERYy473fA1ltvmG
         HIVS8QQELQe+kcvshC2HhaCdpj0OYt7kwc3ARyFh4XfRrkUBnaDhSvRy0cy4m3sJDJqE
         rTTDJvOao09IZ4lWLjAJR4J66WAzGOdBZHJAX1nBIAFyKCu/9iY0tVNxIeuqkqvZBCf6
         y28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720047028; x=1720651828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JQ1mn/CTHjHcc9W+sTHEOUlyKZEA9X33Luiw+Y6JViw=;
        b=oeGfSrDS4Ijn/TQgKaOnFRISqKYFQvltoaQzKq2W9z2ie5J+LYz2adblvaqX3MKt6o
         WBOmYGuNUebgeNiGGDWLpfV5O/dms1maNA8jgxD7ghnE99HONyNHatVTXuBo4YzTRIcH
         mbrAliv48RAiCFVge7kQf8V6oqzzWIs8Nq39f15A6jJv9pc+Y1NRxkxR5yT/IW2ulhZg
         LDp20cycZupaFa0chKWzI145ObhDgJKVEGFyqQ98PhPKj+wKxXo/xZmTysjNQBAQOMSm
         u66uJH2/r3afcg9RVQdW1Cu7kbQLYHrnLk230FIhKf3nvOm9USZQRUbi0QMsIt7o720w
         0+Kg==
X-Forwarded-Encrypted: i=1; AJvYcCWG/p44Vu9vuxrENjKWEP2Rvc5UhFV6aFTZ8UxteO6BSgN6YgXDLelaETWwc9K9PSX4kxDrwY3qvRAFfe2kF9Fkp+gUMTog
X-Gm-Message-State: AOJu0YxUsDCeD6rnqxumuqikv9XJlAmkrPZlc1uxTWbovetxkwhBzX/M
	lJVxMPdDYeSPqEdVoHfPp2x9QXLDcSqcRKJSqCvKDnjxu9SvQ433d8WFaTHgUQ==
X-Google-Smtp-Source: AGHT+IGa8vzfyd/pKoF9FzRFSbE9pKBdacGN4QEAVONB0O6p6w6GixEhWA5JMCkThFXi/HbAHnpJCg==
X-Received: by 2002:a17:902:f78e:b0:1f7:2a3a:dd9b with SMTP id d9443c01a7336-1fb33e19b57mr121745ad.18.1720047027710;
        Wed, 03 Jul 2024 15:50:27 -0700 (PDT)
Received: from TomsPC.home ([2601:646:8300:55f0:af8e:aa48:5140:2b5b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1faf75b3407sm40242185ad.85.2024.07.03.15.50.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Jul 2024 15:50:27 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	cai.huoqing@linux.dev,
	netdev@vger.kernel.org,
	felipe@sipanda.io
Cc: Tom Herbert <tom@herbertland.com>
Subject: [RFC net-next 07/10] hisilicon: Call skb_set_csum_crc32_unnecessary
Date: Wed,  3 Jul 2024 15:48:47 -0700
Message-Id: <20240703224850.1226697-8-tom@herbertland.com>
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
skb_set_csum_crc32_unnessary instead of setting
CHECKSUM_UNNECESSARY

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 drivers/net/ethernet/hisilicon/hns/hns_enet.c  |  5 ++++-
 .../net/ethernet/hisilicon/hns3/hns3_enet.c    | 18 +++++++++++++-----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
index fd32e15cadcb..f3e8b9cb3779 100644
--- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
@@ -556,7 +556,10 @@ static void hns_nic_rx_checksum(struct hns_nic_ring_data *ring_data,
 		return;
 
 	/* now, this has to be a packet with valid RX checksum */
-	skb->ip_summed = CHECKSUM_UNNECESSARY;
+	if (l4id == HNS_RX_FLAG_L4ID_SCTP)
+		skb_set_csum_crc32_unnecessary(skb);
+	else
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
 }
 
 static int hns_nic_poll_rx_skb(struct hns_nic_ring_data *ring_data,
diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
index a5fc0209d628..5fd98854f72d 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_enet.c
@@ -3908,11 +3908,19 @@ static void hns3_rx_handle_csum(struct sk_buff *skb, u32 l234info,
 					  HNS3_RXD_L4ID_S);
 		/* Can checksum ipv4 or ipv6 + UDP/TCP/SCTP packets */
 		if ((l3_type == HNS3_L3_TYPE_IPV4 ||
-		     l3_type == HNS3_L3_TYPE_IPV6) &&
-		    (l4_type == HNS3_L4_TYPE_UDP ||
-		     l4_type == HNS3_L4_TYPE_TCP ||
-		     l4_type == HNS3_L4_TYPE_SCTP))
-			skb->ip_summed = CHECKSUM_UNNECESSARY;
+		     l3_type == HNS3_L3_TYPE_IPV6)) {
+			switch (l4_type) {
+			case HNS3_L4_TYPE_UDP:
+			case HNS3_L4_TYPE_TCP:
+				skb->ip_summed = CHECKSUM_UNNECESSARY;
+				break;
+			case HNS3_L4_TYPE_SCTP:
+				skb_set_csum_crc32_unnecessary(skb);
+				break;
+			default:
+				break;
+			}
+		}
 		break;
 	default:
 		break;
-- 
2.34.1


