Return-Path: <netdev+bounces-116576-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE85694B03C
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 21:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B636B25499
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 19:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D6F13D25E;
	Wed,  7 Aug 2024 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QdiCZHlf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1821A13D265
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 19:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723057387; cv=none; b=bfK/7gw7ebYsPes6sb/J0JvJWSMHIGeovEG/WlboFJkWKagleeDV4Rc5QfbvOSX8sJKROXIqENqyABAsN3zKM4T7TrMcCUa9DPUNkLTnncBKm3Ca6nKbkrMIc1M2cUfl8E2KWSZXIqxNgqgaqixbhSwoVhKKfO6+4Bb6ku7JYIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723057387; c=relaxed/simple;
	bh=jvH4H9ZL0ZEcXJdX6iu75x8DhPHSFvt9O85opYrPgv4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=ZtVjnIAsQSiNQnsECEJX/Tl1D7EnwXKP+vOTSQrqyehx9NO2F+t+hkf6TUCXtXpl8DwCnJ5aXrIc9xhPoPJfNMlaGCOKJHWdh2t8Otr+TUmpz/NgVvWrYz3m6qc/4ZDLzLh0BDlYEZhGxrzdyk9nY8m0+CAjGRjJJt5GTlFYjtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdiCZHlf; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1fc587361b6so2460075ad.2
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 12:03:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723057385; x=1723662185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=IOoIXm+MuxR1AySYB881lmyD9eWKiXaFFCzlWiJK/QY=;
        b=QdiCZHlf1XznJqz0RL7ukqTQ+tzUSfCbMAO8sSP3HYw9sk1IR3JNBUrGqgaSdUhSh9
         SIQfJIC95LmHLySOWIOH/0EJbttu12zwCKRl/FPrtP9yPTiMzBLnxSuXs/NLkV4H7e+9
         P+fK60LiIs1AbFXT/KxzqDCW/vnVs+HTZpZEM/F/qu4XLnYTlla5g2VCFgHbFa67pZ8q
         8pqDreGWQpB7kOCz5xmMtcehu5kd9vGEgAyjQtxKiV14VLtbDfpmMniI1cxonz5K8ozU
         wYs29eTUZ6+qHvS88itpgZUX8QE0MCGD1ggbZDZQeY3GF7efjH0eeEdA1awrla8f08vh
         GDOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723057385; x=1723662185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOoIXm+MuxR1AySYB881lmyD9eWKiXaFFCzlWiJK/QY=;
        b=cDubMz3T5y09MC0kNJ7I8bPCGBgvsvrigoEo3Bdq1CTdLmEOUN88Qp12KhOcGvaNkR
         Xvz8yoyVBWMSHx4207bvhHX6M5qWolfEhJwM+rODPSKY6FrbP3AV/D6UdRCCyKp2Oez7
         q2dQdmd3BRyEUVP2kOfIZ9g6A868Dm43/qgr+lFAMBQ8ChDGQY0mk+1IO4cVF2NFBAae
         wBZL5DdD0lTD6KouV3DcJaKGPGsCeGANf6xTLp88QUGv/agvjUIkF5huUxyZBV4qT/79
         ShjG0DOL5hhW6baMP1/IBzg8ExKxC4g3arMUddrHHWirq5qoHRAW0XefHRTxoRfEoHZD
         kCiw==
X-Gm-Message-State: AOJu0YxcxZtD0A9G/t8ponu3MqMbHXQGGY3+X5QVHAjD1XXY3dtEyrUN
	HEA5YXCKVACt7uhtG8Y4mHvRCsOiXDYAQpUBI6jaMaTKuDinkiwjVqkAUA==
X-Google-Smtp-Source: AGHT+IHCLk0n7CChlyGeNNaYwg6uIRUr9hUNektP29PgpZeb1nqM267IAAyPOuRtggmau0xzBGKfTA==
X-Received: by 2002:a17:902:da85:b0:1fb:a077:a846 with SMTP id d9443c01a7336-1ff57257ce7mr228120785ad.3.1723057384996;
        Wed, 07 Aug 2024 12:03:04 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1ff5905ee07sm110005185ad.153.2024.08.07.12.03.04
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:03:04 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Subject: [PATCH] net: atlantic: use ethtool_sprintf
Date: Wed,  7 Aug 2024 12:02:53 -0700
Message-ID: <20240807190303.6143-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allows simplifying get_strings and avoids manual pointer manipulation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 .../ethernet/aquantia/atlantic/aq_ethtool.c   | 21 +++++++------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
index d0aecd1d7357..38f22918c699 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ethtool.c
@@ -279,18 +279,16 @@ static void aq_ethtool_get_strings(struct net_device *ndev,
 
 			for (i = 0; i < cfg->vecs; i++) {
 				for (si = 0; si < rx_stat_cnt; si++) {
-					snprintf(p, ETH_GSTRING_LEN,
+					ethtool_sprintf(&p,
 					     aq_ethtool_queue_rx_stat_names[si],
 					     tc_string,
 					     AQ_NIC_CFG_TCVEC2RING(cfg, tc, i));
-					p += ETH_GSTRING_LEN;
 				}
 				for (si = 0; si < tx_stat_cnt; si++) {
-					snprintf(p, ETH_GSTRING_LEN,
+					ethtool_sprintf(&p,
 					     aq_ethtool_queue_tx_stat_names[si],
 					     tc_string,
 					     AQ_NIC_CFG_TCVEC2RING(cfg, tc, i));
-					p += ETH_GSTRING_LEN;
 				}
 			}
 		}
@@ -305,20 +303,18 @@ static void aq_ethtool_get_strings(struct net_device *ndev,
 
 			for (i = 0; i < max(rx_ring_cnt, tx_ring_cnt); i++) {
 				for (si = 0; si < rx_stat_cnt; si++) {
-					snprintf(p, ETH_GSTRING_LEN,
+					ethtool_sprintf(&p,
 						 aq_ethtool_queue_rx_stat_names[si],
 						 tc_string,
 						 i ? PTP_HWST_RING_IDX : ptp_ring_idx);
-					p += ETH_GSTRING_LEN;
 				}
 				if (i >= tx_ring_cnt)
 					continue;
 				for (si = 0; si < tx_stat_cnt; si++) {
-					snprintf(p, ETH_GSTRING_LEN,
+					ethtool_sprintf(&p,
 						 aq_ethtool_queue_tx_stat_names[si],
 						 tc_string,
 						 i ? PTP_HWST_RING_IDX : ptp_ring_idx);
-					p += ETH_GSTRING_LEN;
 				}
 			}
 		}
@@ -338,9 +334,8 @@ static void aq_ethtool_get_strings(struct net_device *ndev,
 			for (si = 0;
 				si < ARRAY_SIZE(aq_macsec_txsc_stat_names);
 				si++) {
-				snprintf(p, ETH_GSTRING_LEN,
+				ethtool_sprintf(&p,
 					 aq_macsec_txsc_stat_names[si], i);
-				p += ETH_GSTRING_LEN;
 			}
 			aq_txsc = &nic->macsec_cfg->aq_txsc[i];
 			for (sa = 0; sa < MACSEC_NUM_AN; sa++) {
@@ -349,10 +344,9 @@ static void aq_ethtool_get_strings(struct net_device *ndev,
 				for (si = 0;
 				     si < ARRAY_SIZE(aq_macsec_txsa_stat_names);
 				     si++) {
-					snprintf(p, ETH_GSTRING_LEN,
+					ethtool_sprintf(&p,
 						 aq_macsec_txsa_stat_names[si],
 						 i, sa);
-					p += ETH_GSTRING_LEN;
 				}
 			}
 		}
@@ -369,10 +363,9 @@ static void aq_ethtool_get_strings(struct net_device *ndev,
 				for (si = 0;
 				     si < ARRAY_SIZE(aq_macsec_rxsa_stat_names);
 				     si++) {
-					snprintf(p, ETH_GSTRING_LEN,
+					ethtool_sprintf(&p,
 						 aq_macsec_rxsa_stat_names[si],
 						 i, sa);
-					p += ETH_GSTRING_LEN;
 				}
 			}
 		}
-- 
2.45.2


