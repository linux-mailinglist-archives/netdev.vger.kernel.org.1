Return-Path: <netdev+bounces-250205-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D232D25016
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 15:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 979E430AB97C
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83D73A6404;
	Thu, 15 Jan 2026 14:38:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D9D3A4ADB
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 14:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768487906; cv=none; b=awdbXGwOjsHLFuwuB9KVLt/h6Oz5blTmWVlw1ZIvkG6n1DcYcEDTThOqGjQ+a/TwDOfTE4Q6SQvSTFr0/13Se4Aa0kzUHyKElkexbubtmjaHqbDwUADRfVV5y2QTm3RsqlNhXq1B6edM3Ut4zhFRvArN/0zFibW/xokOVakcB1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768487906; c=relaxed/simple;
	bh=ZmkU1zoakMVbweOFvSLi3xSqjtnIUISr6NFIqxyt0qw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZFY8Y8eJ/m4q+tKYSFFWgAUsgnotxj/40ztQAG9MrvUyWYs98wkE/VRUQrGKsM5Ktx8WkrTQgJK1FWjJ606H4RzkAvf3rRzncgx4P9klCai0IMTHYtrJXahYd9TrhGlZUVmU5tAJjfjc9DKGUcJxBfA8LeX7wjiIVWdwJ9M9tac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-4043bcd09f2so352413fac.3
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 06:38:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768487899; x=1769092699;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PTVF6JzvrMmVirS5IvqK1B086oNYhsYDQqMiO8SDgo0=;
        b=mokH7esLkDaP5z0AMX14axhiuD81zY0mOURsakgN5b+DCe0FOmAMsaMifJqOUZWlft
         5ANlkCYaDFyfFwIFECboClylTmm5yTvU+hBaFT2djoiHv+U/6wuuC6viuNf3nYQqyZJL
         as76QvIVaB+aNcStUYidKaQ6K5pOQ9RNUcBQkE8JSkxnDOOuWQAXq9fPuLHpcSV9R1ML
         HtN7NYe0nhme3wn+MBUkLz9/q3qlkYRtr6RZR0JC2+KCSzrV1C//gNzUAnr5AVTeXgv9
         R0KnXD0JCZYjkheJShQHFpMLdkm/5Br1xHzRxOuttkEcalhuXj7DLz/2rk3MY3g8l8J0
         d3rA==
X-Gm-Message-State: AOJu0YwuYbG11VcG237mnsAp0EKAjbUr5Cpdci9uTpM0Wr8Mj2p/HeeB
	72n7LgAHhcVVLI9y1c0mr8Ovdw+p3OuK/pTkNoTiSddvGLDGFAxOkcC+u4UqLg==
X-Gm-Gg: AY/fxX6+GODpW/XLGz/gMT97NydW9qGgSZ38W43M1i41v+tYwQhg7IpLARxKHQQ7YT0
	HV0s1o++Gol+7RXcqLigYczUQ4A08aExIcaeoGkHOJ7cOuVDoLUnolSBaQav75mVaeeUvL0Bi9a
	OwtVcWxlhC3aK5T8Z+CQfXpeiJGegTdJaGSyQfdWRuKvRu6vtVojzbyidU8bCotG3UWDpK7Z5py
	lzL+QF/TleOsaO2m7EUDRoPck+8a/npwkg9IwFJt3vZc+Cd4rS2lBUiZw7q7IiFh5RD9Ptia0jr
	fbb5Y5hGG7fEnZFMvAJXUI7H7+qcYMIblIC7JS4mQXg8d7Xwmf4RMiWAOY4vPGQlDrl7GwUYmxl
	h6qZVpQGdcaWQrMYuYUOoN0K7AOToL1NcE6fHlhhJ2XKfOUAq0xQQKMllrZtv7dAvlkPCdD13P3
	dv
X-Received: by 2002:a05:6870:b0e7:b0:3ec:60f1:c7ff with SMTP id 586e51a60fabf-40406f4cfbdmr4508780fac.11.1768487898129;
        Thu, 15 Jan 2026 06:38:18 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:1::])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4040997ffacsm3714996fac.6.2026.01.15.06.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 06:38:17 -0800 (PST)
From: Breno Leitao <leitao@debian.org>
Date: Thu, 15 Jan 2026 06:37:52 -0800
Subject: [PATCH net-next 5/9] net: lan743x: convert to use
 .get_rx_ring_count
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260115-grxring_big_v2-v1-5-b3e1b58bced5@debian.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1782; i=leitao@debian.org;
 h=from:subject:message-id; bh=ZmkU1zoakMVbweOFvSLi3xSqjtnIUISr6NFIqxyt0qw=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBpaPvSiriTlKIUDSeJf3lyJx9g6J6MwyhEctVFY
 ba4DAlbwuKJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaWj70gAKCRA1o5Of/Hh3
 bYGCEACmHWrdtJTxtxtEmPPsX2CeZeEu2PQnQ02h7u0Ib3t+jiBGMhQ+DE00fb6SaZ/NvhGaoVx
 JuAR4M1YkjB+Tk0v4vwjG6Oy2wV5kKYKEQYeyfQ/83Z/3IUdh7ZQZwxthVp2CXkXjyHrphQBMYL
 GG8JrctzvRlB+2D9g0j+zyj/GMqO9VJZTNH96L10ou/rLQ4+9T/BEPmRcb2qGqpEx60l5Ktx247
 ETGowL7+DQaU8c3gDAlxynxQjMnbUSekFRULTh18op7QHoYiNQRtobXYZ1KtkldyJ7De90NKkMn
 yWURpk8doDCRoFPxQjMdnlkRdaneJUYsxm04loj3GsZ0eImOy8rCPn4cgGGNNWa0RuXSk5X6dSL
 a+VQ2/vVYkEpT9AGUZtRZ4q+lockReA8gyKfK6sFn3vrq7nG3iXLfssxZZBbl20XzFqYcl3PQW4
 NblPb965fHv3x28BoERrvWIHuTWiVEgu+UBH1HxS8Rba4VjCDRq5oHPVpntdEtHFoAmL+BcvQsf
 pzwwKNVkx5oXzjVs8kQFZwYqf6Up7r9X813J4StIvuBTJ824A6Uua93RU7bGZbR22GWJOY92OIQ
 UeEkI8QYoBKvYD1472AUPavTrJvrRX9iye7NceceDRk6067lh3ReIEDlfgeFThiSz/Q6W+oFkFf
 9hMtYgoMGDE86pw==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Use the newly introduced .get_rx_ring_count ethtool ops callback instead
of handling ETHTOOL_GRXRINGS directly in .get_rxnfc().

Since ETHTOOL_GRXRINGS was the only command handled by
lan743x_ethtool_get_rxnfc(), remove the function entirely.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/ethernet/microchip/lan743x_ethtool.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index 40002d9fe274..8a3c1ecc7866 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -931,16 +931,9 @@ static int lan743x_ethtool_get_rxfh_fields(struct net_device *netdev,
 	return 0;
 }
 
-static int lan743x_ethtool_get_rxnfc(struct net_device *netdev,
-				     struct ethtool_rxnfc *rxnfc,
-				     u32 *rule_locs)
+static u32 lan743x_ethtool_get_rx_ring_count(struct net_device *netdev)
 {
-	switch (rxnfc->cmd) {
-	case ETHTOOL_GRXRINGS:
-		rxnfc->data = LAN743X_USED_RX_CHANNELS;
-		return 0;
-	}
-	return -EOPNOTSUPP;
+	return LAN743X_USED_RX_CHANNELS;
 }
 
 static u32 lan743x_ethtool_get_rxfh_key_size(struct net_device *netdev)
@@ -1369,7 +1362,7 @@ const struct ethtool_ops lan743x_ethtool_ops = {
 	.get_priv_flags = lan743x_ethtool_get_priv_flags,
 	.set_priv_flags = lan743x_ethtool_set_priv_flags,
 	.get_sset_count = lan743x_ethtool_get_sset_count,
-	.get_rxnfc = lan743x_ethtool_get_rxnfc,
+	.get_rx_ring_count = lan743x_ethtool_get_rx_ring_count,
 	.get_rxfh_key_size = lan743x_ethtool_get_rxfh_key_size,
 	.get_rxfh_indir_size = lan743x_ethtool_get_rxfh_indir_size,
 	.get_rxfh = lan743x_ethtool_get_rxfh,

-- 
2.47.3


