Return-Path: <netdev+bounces-149139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 046C79E4751
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 23:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EE681880371
	for <lists+netdev@lfdr.de>; Wed,  4 Dec 2024 22:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EA0194C92;
	Wed,  4 Dec 2024 22:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="JjtGJJ8q"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080B219258E
	for <netdev@vger.kernel.org>; Wed,  4 Dec 2024 22:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733349612; cv=none; b=cTHKDBiNKLBVsEmjuGbdin7w6L1gpNzKDl9C/x3kU+pYRiDJxhRkDg4UKlU794q5V8Wjw75oUgb5Yh0Z592U3LCB3dywnJo0p/sH29jvfvbEg40iI2asvGeNejEQ3GpJVJ+qw9LFQSufrLtt2Dm3Rto7NrXkzaZ7kNNAL3uX1gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733349612; c=relaxed/simple;
	bh=JkcIAM91r/usHn1z2oEvKtFtxrcKK8x3o/5KVw9Rzrk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L+WWNNpqqkyG7is3kbZSeP7thd76GXewHnPge0KbJIM7l0ajyAhIMNUoTwaM+xLc6AiUYpHJwT4fy3lIewWeaOtHiz847d0TsYbq2X34YExYiOtUkizwKAwx2syG575s572Uyrz+CcrGCPtBy0E/Cf9mM/szbxO6gi9hOUuz6dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=JjtGJJ8q; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-215c4000c20so2511045ad.3
        for <netdev@vger.kernel.org>; Wed, 04 Dec 2024 14:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1733349610; x=1733954410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD2vLQ+kCmEEbBFG9T4QFSvg3ZJokpXJzCPukjWjJZQ=;
        b=JjtGJJ8qNhRxakrIz6ULzgvHkF2dfvi+i2eSLR0Wm4e0Q4xugAUfeNTUTW6AQwlFiT
         muU3OUxygfVCYxFWMsR5M9ATbkt7SIBp/VoIppZlePcp2IaIZPDmeyg7HcpIRM9UWbdh
         4D5FnehgCEC59FhXI4udUe2UPl3aC5eMS+VUY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733349610; x=1733954410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD2vLQ+kCmEEbBFG9T4QFSvg3ZJokpXJzCPukjWjJZQ=;
        b=IKPvw0blFaunJ/ueMit2aZe1UArBb+5bDOs+C5lXL8OOap6XorMP7beB0VKjHuKrPF
         ojdCWD++gHafj7eiscZXQm/PLoMHPTrfGYw/O0A+n0Pcn3s8j1bO7f+19EkBD5QNtSGr
         cmvfPMKcDtHyc9aUMoiETI7+K1PkwhkQT5QBT83P3YfkFN1eg0ZLTP1wmaTCN0Ehg8io
         pg30xZ5QzCr6oLkr1IN+LS+zqhpADgqwwpQ1jU+d2UkD/DtLGZFjmPH9YUAmStOjaQYu
         ZYpqzm/eYBtOrWkOHHQR15u7WfZN3BtkWapDRS0nE0DZ30MdHE2NzGztY3wBSeuL2YWv
         w00w==
X-Gm-Message-State: AOJu0Yxqiv41qFDvdwy2uXKBBI0uH0BKCxKfFk30QO03GZfHFUj4AZl+
	rtQMmcwy4X2ykWtfoyN8F0UQArYVcdAVRZg501k2wNORGI3PmIAULpUFn3V5vpKwddHElRibT/9
	x6A==
X-Gm-Gg: ASbGnctn8JDPnd1LzmNgKfdoYQtCRXfjCcHmbbEJEB2sFiESZSRKSTNRrvK2AFR2QQO
	moP/TduDL3F0qPC3OfPLixWZDlbNVh4mesdDXaf3xUVWTYpfsysUoHKH8mzjpca6m75H6knu9CD
	TgzIAR1NMCl6y5Vxwf5pU5EXtx3SYgFY0Kvc+5/N8DoURVSa1mktxzYkzavSzmsikDg8NYA3EDp
	W4y4/Mr/WbAX5xROJZB9ST6zjFIJeGpNA59SCXKTCSyidUCYc40qSPBBvIlJ8UEGjp1XjKED9z4
	g2pePaQQfszZ5A0Fu6f2eER1mQ==
X-Google-Smtp-Source: AGHT+IEtwb6worQ6Lxmmmk0tp7B5/jO3BluqmMDpZWo0agV9QtKGuoYLiQcxf5XK8JNxMOVqDpmA1A==
X-Received: by 2002:a17:902:e743:b0:214:f87b:9dfb with SMTP id d9443c01a7336-215bd21460bmr115664825ad.30.1733349610164;
        Wed, 04 Dec 2024 14:00:10 -0800 (PST)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72541814873sm12897937b3a.153.2024.12.04.14.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 14:00:09 -0800 (PST)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	Colin Winegarden <colin.winegarden@broadcom.com>,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 1/2] bnxt_en: Fix GSO type for HW GRO packets on 5750X chips
Date: Wed,  4 Dec 2024 13:59:17 -0800
Message-ID: <20241204215918.1692597-2-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20241204215918.1692597-1-michael.chan@broadcom.com>
References: <20241204215918.1692597-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The existing code is using RSS profile to determine IPV4/IPV6 GSO type
on all chips older than 5760X.  This won't work on 5750X chips that may
be using modified RSS profiles.  This commit from 2018 has updated the
driver to not use RSS profile for HW GRO packets on newer chips:

50f011b63d8c ("bnxt_en: Update RSS setup and GRO-HW logic according to the latest spec.")

However, a recent commit to add support for the newest 5760X chip broke
the logic.  If the GRO packet needs to be re-segmented by the stack, the
wrong GSO type will cause the packet to be dropped.

Fix it to only use RSS profile to determine GSO type on the oldest
5730X/5740X chips which cannot use the new method and is safe to use the
RSS profiles.

Also fix the L3/L4 hash type for RX packets by not using the RSS
profile for the same reason.  Use the ITYPE field in the RX completion
to determine L3/L4 hash types correctly.

Fixes: a7445d69809f ("bnxt_en: Add support for new RX and TPA_START completion types for P7")
Reviewed-by: Colin Winegarden <colin.winegarden@broadcom.com>
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 14 ++++++--------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  3 +++
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 4ec4934a4edd..79f2d56d7bc8 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -1531,7 +1531,7 @@ static void bnxt_tpa_start(struct bnxt *bp, struct bnxt_rx_ring_info *rxr,
 		if (TPA_START_IS_IPV6(tpa_start1))
 			tpa_info->gso_type = SKB_GSO_TCPV6;
 		/* RSS profiles 1 and 3 with extract code 0 for inner 4-tuple */
-		else if (cmp_type == CMP_TYPE_RX_L2_TPA_START_CMP &&
+		else if (!BNXT_CHIP_P4_PLUS(bp) &&
 			 TPA_START_HASH_TYPE(tpa_start) == 3)
 			tpa_info->gso_type = SKB_GSO_TCPV6;
 		tpa_info->rss_hash =
@@ -2226,15 +2226,13 @@ static int bnxt_rx_pkt(struct bnxt *bp, struct bnxt_cp_ring_info *cpr,
 		if (cmp_type == CMP_TYPE_RX_L2_V3_CMP) {
 			type = bnxt_rss_ext_op(bp, rxcmp);
 		} else {
-			u32 hash_type = RX_CMP_HASH_TYPE(rxcmp);
+			u32 itypes = RX_CMP_ITYPES(rxcmp);
 
-			/* RSS profiles 1 and 3 with extract code 0 for inner
-			 * 4-tuple
-			 */
-			if (hash_type != 1 && hash_type != 3)
-				type = PKT_HASH_TYPE_L3;
-			else
+			if (itypes == RX_CMP_FLAGS_ITYPE_TCP ||
+			    itypes == RX_CMP_FLAGS_ITYPE_UDP)
 				type = PKT_HASH_TYPE_L4;
+			else
+				type = PKT_HASH_TYPE_L3;
 		}
 		skb_set_hash(skb, le32_to_cpu(rxcmp->rx_cmp_rss_hash), type);
 	}
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 23f1aff214b4..c9f1cb7e3740 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -267,6 +267,9 @@ struct rx_cmp {
 	(((le32_to_cpu((rxcmp)->rx_cmp_misc_v1) & RX_CMP_RSS_HASH_TYPE) >>\
 	  RX_CMP_RSS_HASH_TYPE_SHIFT) & RSS_PROFILE_ID_MASK)
 
+#define RX_CMP_ITYPES(rxcmp)					\
+	(le32_to_cpu((rxcmp)->rx_cmp_len_flags_type) & RX_CMP_FLAGS_ITYPES_MASK)
+
 #define RX_CMP_V3_HASH_TYPE_LEGACY(rxcmp)				\
 	((le32_to_cpu((rxcmp)->rx_cmp_misc_v1) & RX_CMP_V3_RSS_EXT_OP_LEGACY) >>\
 	 RX_CMP_V3_RSS_EXT_OP_LEGACY_SHIFT)
-- 
2.30.1


