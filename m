Return-Path: <netdev+bounces-138002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F019AB704
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 21:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 006751C23394
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 19:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF4B1C9ED7;
	Tue, 22 Oct 2024 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I+2tdK6D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62AE51A2658;
	Tue, 22 Oct 2024 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729625861; cv=none; b=MLAGKmaRbtcNb6Alm2XHGw3GynbjgEATVxMUwFf0WEDRNfgaADBoaGb1HvAMIVEafgHTSwFY7R5/atPgNHXasodLQP/LQFSEj3Nikp8tK8SJ9exyUXFccM6kquRH0pvk2QTLaaPbdR2VpS6mLnnhS2F97323xsbWOh35KrZB3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729625861; c=relaxed/simple;
	bh=JTCSLuIKLprzhrsRvKPWUjhnAOpNJgiDkRyH3WefNHo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eKdW8UdML0mekyXAgoZup8K+0030i847h8G8qUcMdR2VLGhrvD9QiBRlZF7OMi4zT7TK2ebe4wYPkfXdRYAIVe4acBtliXxB+SHtZwdLZT1sqwzKB28B1/zkQae9jOoqTMjXHJ7iSPVC7Pk2CKZw6I3Qu5Y34Dpgq/Zt+U4TO3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I+2tdK6D; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-20cd76c513cso50688615ad.3;
        Tue, 22 Oct 2024 12:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729625859; x=1730230659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FNePxcefUzwNW32H0eGg0y+1g6EWQpRSYvqdWLiAgLc=;
        b=I+2tdK6DCsBPrMpRnoo4s7nnjCBrEogrp+wwGpezsCAF3NByJoM4IqSodaOLBXAUIt
         UrN6t9m1cdZRAOXgiupiz+7DZvtXWCQP7K0dO6iHO0EX+K534gyudyRZr5hP7WrKRdRt
         NhdcQt3Kjs1bC2oBZVgwnpPIH2bn1EhMtx7RIZ5VM39a3TVzf2IMZhHLkARYZ05nLHYw
         PbDtAUABYCby3okX2J8ffOz4oEbtZXjRNZhGo3WreHx6TSgTICZnpgoD5HzicyjzDGcU
         1fdkfprnzJc5CTJosuTSA6xfihzKIArGtZi5g1ej8Pgqud52zm3ZYswtThL2tUvhXAzX
         Q3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729625859; x=1730230659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FNePxcefUzwNW32H0eGg0y+1g6EWQpRSYvqdWLiAgLc=;
        b=IMx73OUB8hTjTt+F6jeCl9UfNWgJHWRVyC7eLkBaPq+t/XXbSuUuJRd48tdx/qaXH2
         /5o3zpHK0XWGkB/KymuShNnVmXSDMsGST8292n3XtzG6+1Bjof+ochEEMs3I1ajBz/20
         2Ho7NOuq5nVamp/V4oKJnkcfmqvKtWA5/eWjHIfqevWb/MEQZzJ5uZ9+tlHnNo4iG1Pa
         tI6D7U8oovz9HKIsIhfmx8ZQ7XsgeGltk0PUBveI4YbEyekXiFjpwu1WiPUQpMc5lPTl
         0OMqW2sVBb07L+btX0+R4l7jt58ok4XAzrW+iWPP++Gz16O1BuZWBskrUWy0vhD7nfTm
         5yrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUvz0REj5Pr3O1nJso+HY30NtY9wSgSw2AvyuFYy2nhV8jpC4wpZYmgO8PMjjj3L374MkZwDFEuuFIT7po=@vger.kernel.org
X-Gm-Message-State: AOJu0YyryJqvu4ZoQPz0oyZlUOjoTnmB7u9Pxi8LQkZdm9qQ3X4E0qGd
	xGF2ndgbYcYUCA+iArWLMQ5f2b/f5rbfsf2HerD/+YFyCOa8vI7WTwcYHaCw
X-Google-Smtp-Source: AGHT+IEjv7eNp60AKXMnH+R+lkwjTHbrLwa30UxvTOKwt1qqMsHhntWMz3ZxsaYPwKYc0SsvRjLptw==
X-Received: by 2002:a17:902:f609:b0:20b:770b:ad3b with SMTP id d9443c01a7336-20fa706dd31mr2869095ad.0.1729625859497;
        Tue, 22 Oct 2024 12:37:39 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0dd53esm46153575ad.222.2024.10.22.12.37.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Oct 2024 12:37:39 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv2 net-next] net: bnxt: use ethtool string helpers
Date: Tue, 22 Oct 2024 12:37:37 -0700
Message-ID: <20241022193737.123079-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoids having to use manual pointer manipulation.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 v2: use extra variable to avoid line length issues
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 115 ++++++++----------
 1 file changed, 54 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index f71cc8188b4e..90c870c82398 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -705,112 +705,105 @@ static void bnxt_get_ethtool_stats(struct net_device *dev,
 static void bnxt_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 {
 	struct bnxt *bp = netdev_priv(dev);
-	static const char * const *str;
+	const char *str;
 	u32 i, j, num_str;
 
 	switch (stringset) {
 	case ETH_SS_STATS:
 		for (i = 0; i < bp->cp_nr_rings; i++) {
-			if (is_rx_ring(bp, i)) {
-				num_str = NUM_RING_RX_HW_STATS;
-				for (j = 0; j < num_str; j++) {
-					sprintf(buf, "[%d]: %s", i,
-						bnxt_ring_rx_stats_str[j]);
-					buf += ETH_GSTRING_LEN;
+			if (is_rx_ring(bp, i))
+				for (j = 0; j < NUM_RING_RX_HW_STATS; j++) {
+					str = bnxt_ring_rx_stats_str[j];
+					ethtool_sprintf(&buf, "[%d]: %s", i,
+							str);
 				}
-			}
-			if (is_tx_ring(bp, i)) {
-				num_str = NUM_RING_TX_HW_STATS;
-				for (j = 0; j < num_str; j++) {
-					sprintf(buf, "[%d]: %s", i,
-						bnxt_ring_tx_stats_str[j]);
-					buf += ETH_GSTRING_LEN;
+			if (is_tx_ring(bp, i))
+				for (j = 0; j < NUM_RING_TX_HW_STATS; j++) {
+					str = bnxt_ring_tx_stats_str[j];
+					ethtool_sprintf(&buf, "[%d]: %s", i,
+							str);
 				}
-			}
 			num_str = bnxt_get_num_tpa_ring_stats(bp);
 			if (!num_str || !is_rx_ring(bp, i))
 				goto skip_tpa_stats;
 
 			if (bp->max_tpa_v2)
-				str = bnxt_ring_tpa2_stats_str;
+				for (j = 0; j < num_str; j++) {
+					str = bnxt_ring_tpa2_stats_str[j];
+					ethtool_sprintf(&buf, "[%d]: %s", i,
+							str);
+				}
 			else
-				str = bnxt_ring_tpa_stats_str;
-
-			for (j = 0; j < num_str; j++) {
-				sprintf(buf, "[%d]: %s", i, str[j]);
-				buf += ETH_GSTRING_LEN;
-			}
-skip_tpa_stats:
-			if (is_rx_ring(bp, i)) {
-				num_str = NUM_RING_RX_SW_STATS;
 				for (j = 0; j < num_str; j++) {
-					sprintf(buf, "[%d]: %s", i,
-						bnxt_rx_sw_stats_str[j]);
-					buf += ETH_GSTRING_LEN;
+					str = bnxt_ring_tpa_stats_str[j];
+					ethtool_sprintf(&buf, "[%d]: %s", i,
+							str);
 				}
+skip_tpa_stats:
+			if (is_rx_ring(bp, i))
+				for (j = 0; j < NUM_RING_RX_SW_STATS; j++) {
+					str = bnxt_rx_sw_stats_str[j];
+					ethtool_sprintf(&buf, "[%d]: %s", i,
+							str);
+				}
+			for (j = 0; j < NUM_RING_CMN_SW_STATS; j++) {
+				str = bnxt_cmn_sw_stats_str[j];
+				ethtool_sprintf(&buf, "[%d]: %s", i, str);
 			}
-			num_str = NUM_RING_CMN_SW_STATS;
-			for (j = 0; j < num_str; j++) {
-				sprintf(buf, "[%d]: %s", i,
-					bnxt_cmn_sw_stats_str[j]);
-				buf += ETH_GSTRING_LEN;
-			}
-		}
-		for (i = 0; i < BNXT_NUM_RING_ERR_STATS; i++) {
-			strscpy(buf, bnxt_ring_err_stats_arr[i], ETH_GSTRING_LEN);
-			buf += ETH_GSTRING_LEN;
 		}
+		for (i = 0; i < BNXT_NUM_RING_ERR_STATS; i++)
+			ethtool_puts(&buf, bnxt_ring_err_stats_arr[i]);
 
-		if (bp->flags & BNXT_FLAG_PORT_STATS) {
+		if (bp->flags & BNXT_FLAG_PORT_STATS)
 			for (i = 0; i < BNXT_NUM_PORT_STATS; i++) {
-				strcpy(buf, bnxt_port_stats_arr[i].string);
-				buf += ETH_GSTRING_LEN;
+				str = bnxt_port_stats_arr[i].string;
+				ethtool_puts(&buf, str);
 			}
-		}
+
 		if (bp->flags & BNXT_FLAG_PORT_STATS_EXT) {
 			u32 len;
 
 			len = min_t(u32, bp->fw_rx_stats_ext_size,
 				    ARRAY_SIZE(bnxt_port_stats_ext_arr));
 			for (i = 0; i < len; i++) {
-				strcpy(buf, bnxt_port_stats_ext_arr[i].string);
-				buf += ETH_GSTRING_LEN;
+				str = bnxt_port_stats_ext_arr[i].string;
+				ethtool_puts(&buf, str);
 			}
+
 			len = min_t(u32, bp->fw_tx_stats_ext_size,
 				    ARRAY_SIZE(bnxt_tx_port_stats_ext_arr));
 			for (i = 0; i < len; i++) {
-				strcpy(buf,
-				       bnxt_tx_port_stats_ext_arr[i].string);
-				buf += ETH_GSTRING_LEN;
+				str = bnxt_tx_port_stats_ext_arr[i].string;
+				ethtool_puts(&buf, str);
 			}
+
 			if (bp->pri2cos_valid) {
 				for (i = 0; i < 8; i++) {
-					strcpy(buf,
-					       bnxt_rx_bytes_pri_arr[i].string);
-					buf += ETH_GSTRING_LEN;
+					str = bnxt_rx_bytes_pri_arr[i].string;
+					ethtool_puts(&buf, str);
 				}
+
 				for (i = 0; i < 8; i++) {
-					strcpy(buf,
-					       bnxt_rx_pkts_pri_arr[i].string);
-					buf += ETH_GSTRING_LEN;
+					str = bnxt_rx_pkts_pri_arr[i].string;
+					ethtool_puts(&buf, str);
 				}
+
 				for (i = 0; i < 8; i++) {
-					strcpy(buf,
-					       bnxt_tx_bytes_pri_arr[i].string);
-					buf += ETH_GSTRING_LEN;
+					str = bnxt_tx_bytes_pri_arr[i].string;
+					ethtool_puts(&buf, str);
 				}
+
 				for (i = 0; i < 8; i++) {
-					strcpy(buf,
-					       bnxt_tx_pkts_pri_arr[i].string);
-					buf += ETH_GSTRING_LEN;
+					str = bnxt_tx_pkts_pri_arr[i].string;
+					ethtool_puts(&buf, str);
 				}
 			}
 		}
 		break;
 	case ETH_SS_TEST:
 		if (bp->num_tests)
-			memcpy(buf, bp->test_info->string,
-			       bp->num_tests * ETH_GSTRING_LEN);
+			for (i = 0; i < bp->num_tests; i++)
+				ethtool_puts(&buf, bp->test_info->string[i]);
 		break;
 	default:
 		netdev_err(bp->dev, "bnxt_get_strings invalid request %x\n",
-- 
2.47.0


