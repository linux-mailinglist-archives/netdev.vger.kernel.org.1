Return-Path: <netdev+bounces-250200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B400D24FC8
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 024CF30378AE
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:38:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A1F389DFA;
	Thu, 15 Jan 2026 14:38:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3A32E9749
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487902; cv=none; b=othfo7W7viAKhYjdhBEJLfhe8NR32jDMK1+Oe5MD5c+ud2oUEqza6nh4rdAjLRweX7V77BjNWJN+VykgrcfySFY+sqmeRqTJ27V+f/avjuGtYErW1MoRiDZuCuhN7DhQx3SQDbQZJ1v9kkhhPkTwIKD5k0zOvD0OzQpQpL7VdMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487902; c=relaxed/simple;
	bh=VqwV07kQH4CtC2dzFBLL5ZX1yoUM3ruiZh1l3J4At1o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CEN+n9/wIxNXUg1bmOV5PkyUgNFqYrwSIdukiCpK/EG//NWr8IBNIC2H1xqaf0SLCuKbnlDk1N2FyoXttNTtHdTtwmxf5dAycFty19dwAnDGiwgbIXBPcDBBe/lmhaD27h6s0qynuCR0OgYiKQy8Yb1gwdfDX/vdT0Ta9djoZHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-4042f55de3aso640085fac.1
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:38:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768487894; x=1769092694;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=n4pj0G+Abgyush+HjB0g/8sWijDo1hvace6ej6tDD+M=;
        b=gCzo6PmpVa2FKv93dAnImAjKHY+txyBT4YTNtZw9TVOtYm709r4ETinGtHCVk2yALb
         9V/2kS/c4VObUgH6TcrRggYNjw8/1q9wIFEd4NXa41rzwNtzYMW8vBUiROZYhHbCDBSW
         /p5c5Iu2BWURQ+NJZ0gIwaFH/kQEyzbwIs4P0yme+W2MYOuC/MyZBPufo8TFQQvrRuiE
         Z0fcTq7Wng9jmBhKZkYtUvqGhhD3evmoBMR9luBQRTMDGrqWyi40GFS3MzmaKaMWVrrl
         8dnTsflECYdOE1ksZogd/vKZ7eD2aOAOEnHhs4Vi7/hxKwh/ihF/jW3Vw8E0yIpmxxj7
         bksw==
X-Gm-Message-State: AOJu0Yx49FAFgGde96LFd1ZNAAb/MnU+ovnkCQiOzDk75oOc52+dF2q6
	1nLuEYx42VQNrG4AU31iKo61TOe4Q/z3QufoRYS0T6/3Rlz1F9mNKZDi
X-Gm-Gg: AY/fxX6TVQm0r8KaijSdH4Xc+azXwjmbeawGZPmf9u73JUKs5U0KtNTyA/LVcq/QNrm
	a6/7nGZDXs2fjSHN8bMjlQnWpAMHg0jKL8Yv8iCFfX9qNpKveaYvMVuRpA4+VCQO2h56QZ5oRR7
	IOks4sLW0EWzhwM1BP9zzHfIJkc3b/+1puYgjblFEOvKSsnaY9Hm7aViuGMPAxCmzuht6JqOVxy
	hdFm+PUyL3g412W8cCZdS4IZ/qFoCec1T0Elhulidzmnp/dOuDHbIXW0niFhNkL0yghD7PcCTN3
	EJQcOFHxMfOAqNxp1n+zgQ2jjSU2BVH2hyk0gV2pd3CdGmSL2JIL47IiSiFZuRlMxeV0vT+3HkW
	B206QPYS6yGafdw7LoaSyiyKdFj7Jxmi1DAwooEWu1VLwR0l3lkAEem+wYQkK2HVz6QdV8hdhSP
	jqPw==
X-Received: by 2002:a05:6871:e2d7:b0:3ff:c029:d24c with SMTP id 586e51a60fabf-40429044c12mr1905592fac.17.1768487894611;
        Thu, 15 Jan 2026 06:38:14 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:42::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4040cba2d2asm3965570fac.5.2026.01.15.06.38.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 06:38:14 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 15 Jan 2026 06:37:49 -0800
Subject: [PATCH net-next 2/9] net: tsnep: convert to use .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-grxring_big_v2-v1-2-b3e1b58bced5@debian.org>
References: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
In-Reply-To: <20260115-grxring_big_v2-v1-0-b3e1b58bced5@debian.org>
To: Ajit Khaparde <ajit.khaparde@broadcom.com>, 
 Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>, 
 Somnath Kotur <somnath.kotur@broadcom.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Shay Agroskin <shayagr@amazon.com>, Arthur Kiyanovski <akiyano@amazon.com>, 
 David Arinzon <darinzon@amazon.com>, Saeed Bishara <saeedb@amazon.com>, 
 Bryan Whitehead <bryan.whitehead@microchip.com>, 
 UNGLinuxDriver@microchip.com, Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Raju Rangoju <Raju.Rangoju@amd.com>, 
 Potnuri Bharat Teja <bharat@chelsio.com>, 
 Nicolas Ferre <nicolas.ferre@microchip.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Jiawen Wu <jiawenwu@trustnetic.com>, 
 Mengyuan Lou <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Breno Leitao <leitao@debian.org>
X-Mailer: b4 0.15-dev-47773
X-Developer-Signature: v=1; a=openpgp-sha256; l=1647; i=leitao@debian.org;
 h=from:subject:message-id; bh=VqwV07kQH4CtC2dzFBLL5ZX1yoUM3ruiZh1l3J4At1o=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpaPvRXdQiLep1rFYIYQ2D4H5vs5OvolAtazC0M
 O/7iI/pc/uJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWj70QAKCRA1o5Of/Hh3
 bdcNEACK6R+vJJPtW8yLH04hKVq5d3PRhPSvRYiADaz5srmrMsfCXAVavitSAfOLb29EpgQlEef
 6I95MtC+vloxjsg+uluNGS/j5LTm2U3A8fHWijO3PQXNngVL1c5I+rBBBWZQqJEb3UEaKgtIBKz
 MLowyR2FFvubs0MEGXemyyR67ofdf5CtNDGpd8TPz0WmBkjX8DJ7bvjqG6mZ624T00ODQWAY2lv
 PHEMcm9ZfccLDCJiQhRk5+gdrSjED1Gz9+Ku5yOPue7p6ArvHR1z4vDWrjVgtMBs4I/l6P39tw9
 lsHE4X+ZRFztAZam0EzU1nF/0n1idvfdRN9boefz6WwwnzShz0tpgvq8U6BW8PoEFFLeGfeW1PG
 fmzmZSWz7D5RcOiTubf/h7/+vqsk7bD1EDJwVBanoEUYv8J+rbRSGgye321FGo/6hPSIW8gYB8a
 OodoPKdZoNLbib5yL+VPTnXSjFn0uilyPPw/Vsb7HF+E/nEtd+0qLUlpUue93flveq8kf/6OggZ
 43tIwDvSUydlJEGQfOAEbIC0eh1u+fuLacrxoxvTJKaT79Ea0gWw8/5n/cxTOBj3NOX2URG2UDK
 yqsKFU04o2wH1tFSJTpwYsNEY+KGV+igZGmLK76DdcwsVlIXCevVKZ6+SMQsluSW7n26vLg4fWE
 Q+QEg46BHDlNhlw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/engleder/tsnep_ethtool.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/engleder/tsnep_ethtool.c b/drivers/net/ethernet/engleder/tsnep_ethtool.c
index 228a638eae16..d11168278515 100644
--- a/drivers/net/ethernet/engleder/tsnep_ethtool.c
+++ b/drivers/net/ethernet/engleder/tsnep_ethtool.c
@@ -257,15 +257,19 @@ static int tsnep_ethtool_get_sset_count(struct net_device *netdev, int sset)
 	}
 }
 
+static u32 tsnep_ethtool_get_rx_ring_count(struct net_device *netdev)
+{
+	struct tsnep_adapter *adapter = netdev_priv(netdev);
+
+	return adapter->num_rx_queues;
+}
+
 static int tsnep_ethtool_get_rxnfc(struct net_device *netdev,
 				   struct ethtool_rxnfc *cmd, u32 *rule_locs)
 {
 	struct tsnep_adapter *adapter = netdev_priv(netdev);
 
 	switch (cmd->cmd) {
-	case ETHTOOL_GRXRINGS:
-		cmd->data = adapter->num_rx_queues;
-		return 0;
 	case ETHTOOL_GRXCLSRLCNT:
 		cmd->rule_cnt = adapter->rxnfc_count;
 		cmd->data = adapter->rxnfc_max;
@@ -469,6 +473,7 @@ const struct ethtool_ops tsnep_ethtool_ops = {
 	.get_sset_count = tsnep_ethtool_get_sset_count,
 	.get_rxnfc = tsnep_ethtool_get_rxnfc,
 	.set_rxnfc = tsnep_ethtool_set_rxnfc,
+	.get_rx_ring_count = tsnep_ethtool_get_rx_ring_count,
 	.get_channels = tsnep_ethtool_get_channels,
 	.get_ts_info = tsnep_ethtool_get_ts_info,
 	.get_coalesce = tsnep_ethtool_get_coalesce,

-- 
2.47.3


