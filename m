Return-Path: <netdev+bounces-137345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A22C9A58DC
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 04:29:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFAE51F21603
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 02:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFD801799F;
	Mon, 21 Oct 2024 02:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oijx0f1D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19BF14263;
	Mon, 21 Oct 2024 02:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729477746; cv=none; b=fxMOs8C7LgOvgWuVN4qf4DIboIXG0byPyY4CwjyzgAOyoJou+lRDGz2e/0qmwOyXKN+EtuE0gL9wS3M53leOEq5rfHFheNPpkTQexjjUeH1yW/LAogHfy/w0nS3RRTbM3Rma7qfrcSNqVXAmpfZ8ZuSsTSEgIdX5b8+RbLhKwzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729477746; c=relaxed/simple;
	bh=6qtTmtydCnKundBDR3axy9UipvrlBvJigyFpZp6xJmo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drE9upNdPn5CZmd3UsEJwbIO8LPU0gvZvuiifLfSw0E5e+qPZoNTTTUog5cGE4XoArevH5CXKZddLYwMWQZa/njnPWsRaLrg2lBP7g7SZOES0bbQ20r4ifnM6HQVnS2ZeN1BhwOeETW6fI0jVEq28AgvYMuTpCj1nW1yGgUktws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oijx0f1D; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-20c9978a221so45593385ad.1;
        Sun, 20 Oct 2024 19:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729477744; x=1730082544; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZutcxFkjMK9a7hZ9nx5BY2GReswDRsLPMQDv9l5Ojv0=;
        b=Oijx0f1DcLyDWl9EuJvvaV5ocpwOIAJ6bbPLyUlcYe/PEJHOJXFlWklHvMkRLbAzC4
         QwSZsse8Q9RQWWKUvIZTUqXVl3bh6l2l21ByFQBjnzmEZvI6J0mLQa47mIYZNiXgKu45
         Vv3/mmKSJpaTLPsYfbt1sI9VwQsWwtg9aWypDfFbWM0Zb6NA+fvvF9DyISxYwN1lOxt5
         vz1bSUSU2HNXyzN5s5PmMpoAHEs+nu1FGZtm6tXnB3/mkhDu650T21mMw/87i0b1Abzm
         gpnZNr6gvRL27XmWxFFm/fa0I2V5C3HkFl41DhxHDa1zPub5db5+8Vzg/rPnqxUqyxYH
         9zkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729477744; x=1730082544;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZutcxFkjMK9a7hZ9nx5BY2GReswDRsLPMQDv9l5Ojv0=;
        b=ANPt+ZDULiLUiD0LJ+yuW84+OvB+jcyvE6tHLxkkqBozQcDMxPkBlvGS42EOaRbWcC
         vxI/HhGBRS8PYAsqxq4xbuAtW8FJlbWAF+wrqVpjgrK1FtfkX9yIepRlsrWdSDOgN1fF
         S/mmYfHT/9fjLA2gaqgJC4VIWX7dHtybdiUGpiMpDD0UKN89kQSnQ87+gkW2DGkXAoWy
         PP74hZ5bBv6rx+BjRdFGv0PHpAS0P4F6B3AIj2Uf2eEHWMGmM1UpsP7zpUar6/xhIx6x
         4jJjEiLboqosfGaWTsY1F7kLOLW9t8eLi/dYPsgl6xXGtyUD6H+O1pq/U+sqGAFOzy67
         w4Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWLfLlN+XI6hxqZZTDlt0kUvhTJw4Isdiwnqaxuzrc0w1pF1hKoQCt8Jib8kTyFfWh4Zq6XndUhICYrdkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ADXAKjOWE2ImrWBD19Smlu59YQbKIAja839RSpW9N6Zc+wPI
	p6pFqhML8bpd2bzIw4L0wa/lCPHS/7yEtCkoQglw6V27m4tL5nkk369QYKOU
X-Google-Smtp-Source: AGHT+IHfPJlH8pcT5tWiZ4wh/zQbi0gGxk2PgXlCe0H6l5Xp9QtDEZWpIvSjBiL3t2GQjFPikNb30g==
X-Received: by 2002:a05:6a21:e91:b0:1d6:fb3e:78cf with SMTP id adf61e73a8af0-1d92c57c430mr13782764637.41.1729477743878;
        Sun, 20 Oct 2024 19:29:03 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeabb8418sm1551056a12.67.2024.10.20.19.29.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Oct 2024 19:29:03 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: bnxt: use ethtool string helpers
Date: Sun, 20 Oct 2024 19:29:01 -0700
Message-ID: <20241021022901.318647-1-rosenp@gmail.com>
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
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 110 ++++++++----------
 1 file changed, 50 insertions(+), 60 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index f71cc8188b4e..84d468ad3c8e 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -713,18 +713,17 @@ static void bnxt_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 		for (i = 0; i < bp->cp_nr_rings; i++) {
 			if (is_rx_ring(bp, i)) {
 				num_str = NUM_RING_RX_HW_STATS;
-				for (j = 0; j < num_str; j++) {
-					sprintf(buf, "[%d]: %s", i,
+				for (j = 0; j < num_str; j++)
+					ethtool_sprintf(
+						&buf, "[%d]: %s", i,
 						bnxt_ring_rx_stats_str[j]);
-					buf += ETH_GSTRING_LEN;
-				}
 			}
 			if (is_tx_ring(bp, i)) {
 				num_str = NUM_RING_TX_HW_STATS;
 				for (j = 0; j < num_str; j++) {
-					sprintf(buf, "[%d]: %s", i,
+					ethtool_sprintf(
+						&buf, "[%d]: %s", i,
 						bnxt_ring_tx_stats_str[j]);
-					buf += ETH_GSTRING_LEN;
 				}
 			}
 			num_str = bnxt_get_num_tpa_ring_stats(bp);
@@ -736,81 +735,72 @@ static void bnxt_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 			else
 				str = bnxt_ring_tpa_stats_str;
 
-			for (j = 0; j < num_str; j++) {
-				sprintf(buf, "[%d]: %s", i, str[j]);
-				buf += ETH_GSTRING_LEN;
-			}
+			for (j = 0; j < num_str; j++)
+				ethtool_sprintf(&buf, "[%d]: %s", i, str[j]);
 skip_tpa_stats:
 			if (is_rx_ring(bp, i)) {
 				num_str = NUM_RING_RX_SW_STATS;
-				for (j = 0; j < num_str; j++) {
-					sprintf(buf, "[%d]: %s", i,
+				for (j = 0; j < num_str; j++)
+					ethtool_sprintf(
+						&buf, "[%d]: %s", i,
 						bnxt_rx_sw_stats_str[j]);
-					buf += ETH_GSTRING_LEN;
-				}
 			}
 			num_str = NUM_RING_CMN_SW_STATS;
-			for (j = 0; j < num_str; j++) {
-				sprintf(buf, "[%d]: %s", i,
-					bnxt_cmn_sw_stats_str[j]);
-				buf += ETH_GSTRING_LEN;
-			}
-		}
-		for (i = 0; i < BNXT_NUM_RING_ERR_STATS; i++) {
-			strscpy(buf, bnxt_ring_err_stats_arr[i], ETH_GSTRING_LEN);
-			buf += ETH_GSTRING_LEN;
+			for (j = 0; j < num_str; j++)
+				ethtool_sprintf(&buf, "[%d]: %s", i,
+						bnxt_cmn_sw_stats_str[j]);
 		}
+		for (i = 0; i < BNXT_NUM_RING_ERR_STATS; i++)
+			ethtool_puts(&buf, bnxt_ring_err_stats_arr[i]);
+
+		if (bp->flags & BNXT_FLAG_PORT_STATS)
+			for (i = 0; i < BNXT_NUM_PORT_STATS; i++)
+				ethtool_puts(&buf,
+					     bnxt_port_stats_arr[i].string);
 
-		if (bp->flags & BNXT_FLAG_PORT_STATS) {
-			for (i = 0; i < BNXT_NUM_PORT_STATS; i++) {
-				strcpy(buf, bnxt_port_stats_arr[i].string);
-				buf += ETH_GSTRING_LEN;
-			}
-		}
 		if (bp->flags & BNXT_FLAG_PORT_STATS_EXT) {
 			u32 len;
 
 			len = min_t(u32, bp->fw_rx_stats_ext_size,
 				    ARRAY_SIZE(bnxt_port_stats_ext_arr));
-			for (i = 0; i < len; i++) {
-				strcpy(buf, bnxt_port_stats_ext_arr[i].string);
-				buf += ETH_GSTRING_LEN;
-			}
+			for (i = 0; i < len; i++)
+				ethtool_puts(&buf,
+					     bnxt_port_stats_ext_arr[i].string);
+
 			len = min_t(u32, bp->fw_tx_stats_ext_size,
 				    ARRAY_SIZE(bnxt_tx_port_stats_ext_arr));
-			for (i = 0; i < len; i++) {
-				strcpy(buf,
-				       bnxt_tx_port_stats_ext_arr[i].string);
-				buf += ETH_GSTRING_LEN;
-			}
+			for (i = 0; i < len; i++)
+				ethtool_puts(
+					&buf,
+					bnxt_tx_port_stats_ext_arr[i].string);
+
 			if (bp->pri2cos_valid) {
-				for (i = 0; i < 8; i++) {
-					strcpy(buf,
-					       bnxt_rx_bytes_pri_arr[i].string);
-					buf += ETH_GSTRING_LEN;
-				}
-				for (i = 0; i < 8; i++) {
-					strcpy(buf,
-					       bnxt_rx_pkts_pri_arr[i].string);
-					buf += ETH_GSTRING_LEN;
-				}
-				for (i = 0; i < 8; i++) {
-					strcpy(buf,
-					       bnxt_tx_bytes_pri_arr[i].string);
-					buf += ETH_GSTRING_LEN;
-				}
-				for (i = 0; i < 8; i++) {
-					strcpy(buf,
-					       bnxt_tx_pkts_pri_arr[i].string);
-					buf += ETH_GSTRING_LEN;
-				}
+				for (i = 0; i < 8; i++)
+					ethtool_puts(
+						&buf,
+						bnxt_rx_bytes_pri_arr[i].string);
+
+				for (i = 0; i < 8; i++)
+					ethtool_puts(
+						&buf,
+						bnxt_rx_pkts_pri_arr[i].string);
+
+				for (i = 0; i < 8; i++)
+					ethtool_puts(
+						&buf,
+						bnxt_tx_bytes_pri_arr[i].string);
+
+				for (i = 0; i < 8; i++)
+					ethtool_puts(
+						&buf,
+						bnxt_tx_pkts_pri_arr[i].string);
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


