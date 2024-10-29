Return-Path: <netdev+bounces-140181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE8C9B56F9
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 00:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C1A8CB22919
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 23:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9639820B213;
	Tue, 29 Oct 2024 23:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuAKuumZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752291DF753;
	Tue, 29 Oct 2024 23:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730244754; cv=none; b=B8v7Ib0Qf4sO3SiIMVA1EcsC8XPeUs6mKDsJOivQy3ksEuGFaouYJls8fRh4INb7/EypjLWL2K8g3Lb2vNsZ/ZHGj7VLqzQLUNIoUV9Ttqfn3jQ+NeA+aioJapPaGaA/gPa31sCSlLkIM/sCEmq4GMkMe33TrpUnyqDpDpUddGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730244754; c=relaxed/simple;
	bh=fHjxALXRVL8rE86lgAJu8XJmaK1TH3O64slVE572oX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qrusmOqLwMY334kO9MKR/5d8ibmDxaDNLTECysrN69GZ5ZnNT8/VbAdfmjbuIYIj7qPAuReoRUpL1SMwlEH2xMfgfS0DI9H4deUhlQCEDo9s1/w2cfmWAlJdqSTZwGMogReqmyMzsB8fJBD5MdWTX+92wr9Qb3i3uz0K8qzrbA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TuAKuumZ; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20e6981ca77so64727685ad.2;
        Tue, 29 Oct 2024 16:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730244752; x=1730849552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uvx26Gcnp4D1WIrST7Bg3WCzoSlbDlwxsa2DRSIve1s=;
        b=TuAKuumZ4+OA6DYN4sv6Irg5vM81LhTmkYyWwHm54rrZ2nwfM3wakG+elpx4lRejzx
         80g0FF/maA8cqFGKoz5icPv5RSFgJQmEbOK+sZ/rMLls0AzOyMv8aF7nFW8VAlBAHp7n
         S6ug2pmtCVL2NPpB6Y1yMO9EEI2+s8YJslXoziALpoOl+p2BulMEfzLHC0ZiZ4d30HxL
         F4rSvFga7GIW/Mn5yexqvLN9GDRgDWnKj4lZv6uckOWppKn6MBwpz76Pp8p0ztcKHx5+
         y0XFTN8qCoD7IbJb6xxpw/p4aA87weU4WZNUNXvSdaiu9ptWfKzpZ+9lDS5g8Ky3p+re
         QXsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730244752; x=1730849552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uvx26Gcnp4D1WIrST7Bg3WCzoSlbDlwxsa2DRSIve1s=;
        b=VkaZNdU5fqlCjxho/6yroFI/a0c1kCchupnlXsXpMeSjZV/zLUNeR5tQN5YbjzxafF
         shp8yxYlbkkV55jjGd6QG+RJt8Qbzt5WhfV97Mh/VyIz1UPaNOUyZtfhoet+j0MgoFtM
         /wXhwiVea8nG1eZ2bYuSGBFvdpP4pdBfKVrmBlykaQapcthQhBxusBQFq56SwJ/mU32C
         3wLf9CcLjjCMOssH9L5caHVfYHh1hihKP5zqmTaPI6bBe+vgZbh6J10+V/qbSjcwcCCm
         tM+5AwwNA/2Fse9oTM9jOInfL/qqL2DwnMgHtUjl8jO38UtlgL1Z7b+/8o8XmLbYrzm4
         VamQ==
X-Forwarded-Encrypted: i=1; AJvYcCXR8OR5MM49hYE6dJuxj6UIQjOX8v1MnSjBvkgNzMe14RgvnQPp/zM6LLHJVXDAiJ+WG2fKwNcQWz0bclg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBqfpcT3wn9USRg+Ohui+i7oKTWOQ5ZID8Qv7uKNQA5e3pj4SF
	vBHRWTjVFpNRE2xizmV6Rer4Iaas4GLzr9z8rJUug+zryRpapPndLgO/ng==
X-Google-Smtp-Source: AGHT+IFui2pwRlSCuF3KfRJIr/l584TIb7lKTcDurSkqvCAqC8Gnq3/17zVRIK6c5/O/LBURhCWzfQ==
X-Received: by 2002:a17:902:f686:b0:20b:8ef3:67a with SMTP id d9443c01a7336-210c68744a1mr205445375ad.7.1730244751508;
        Tue, 29 Oct 2024 16:32:31 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf43418sm71852125ad.37.2024.10.29.16.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Oct 2024 16:32:31 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Michael Chan <michael.chan@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCHv3 net-next] net: bnxt: use ethtool string helpers
Date: Tue, 29 Oct 2024 16:32:29 -0700
Message-ID: <20241029233229.9385-1-rosenp@gmail.com>
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
Reviewed-by: Michael Chan <michael.chan@broadcom.com>
---
 v3: move str variable down to keep reverse chrismas tree ordering
 v2: use extra variable to avoid line length issues
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c | 115 ++++++++----------
 1 file changed, 54 insertions(+), 61 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
index f71cc8188b4e..96a41891fa5f 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ethtool.c
@@ -705,112 +705,105 @@ static void bnxt_get_ethtool_stats(struct net_device *dev,
 static void bnxt_get_strings(struct net_device *dev, u32 stringset, u8 *buf)
 {
 	struct bnxt *bp = netdev_priv(dev);
-	static const char * const *str;
 	u32 i, j, num_str;
+	const char *str;
 
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


