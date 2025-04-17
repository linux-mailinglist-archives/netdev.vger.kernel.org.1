Return-Path: <netdev+bounces-183837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A6DD6A922EB
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 18:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A5037AB833
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E541254AFC;
	Thu, 17 Apr 2025 16:42:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B872F35973;
	Thu, 17 Apr 2025 16:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744908146; cv=none; b=nwkrw0hNcAS/mGQyUznGnpKZM0hReCABKyMqHQPFL9PigpuL3h4pMJYxNO5Kn5D7VMvnW+FNEWCR6psfxVWVpRv3+UipaPrhIpi+QPJ/1Iklq6kIcTLTbhunfFZAAWQ8iPk3D4hcQvoJi1mrtIpyOJOiRD8r86hAkbLEeiT1zaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744908146; c=relaxed/simple;
	bh=Yk13GbJg6uRZcMPD4wlifpeBZXXXTA/RowAd4MaGLiU=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=GW6ygcyYw9Bg7nbGvd3vzu4J/w9SSCfyNNaYcv0X/LnqCcxopA9eWhclHIbxjHTxebSaGbHk0RjLDdVxDChFcPP2SuoP8rs0fiAGqm9cfXDLfjuz5Kx1rYaHKTnNO02A76VYL1TfWaoE8HqEuCVLxLb8mg2Ir0m4noOy0hJd4ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u5SH7-000000002ZV-1ibD;
	Thu, 17 Apr 2025 16:42:19 +0000
Date: Thu, 17 Apr 2025 17:42:16 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3] net: ethernet: mtk_eth_soc: convert cap_bit in
  mtk_eth_muxc struct to u64
Message-ID: <d6d3f9421baa85cdb7ff56cd06a9fc97ba0a77f9.1744907886.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>

The capabilities bitfield was converted to a 64-bit value, but a cap_bit
in struct mtk_eth_muxc which is used to store a full bitfield (rather
than the bit number, as the name would suggest) still holds only a
32-bit value.

Change the type of cap_bit to u64 in order to avoid truncating the
bitfield which results in path selection to not work with capabilities
above the 32-bit limit.

The values currently stored in the cap_bit field are
MTK_ETH_MUX_GDM1_TO_GMAC1_ESW:
 BIT_ULL(18) | BIT_ULL(5)

MTK_ETH_MUX_GMAC2_GMAC0_TO_GEPHY:
 BIT_ULL(19) | BIT_ULL(5) | BIT_ULL(6)

MTK_ETH_MUX_U3_GMAC2_TO_QPHY:
 BIT_ULL(20) | BIT_ULL(5) | BIT_ULL(6)

MTK_ETH_MUX_GMAC1_GMAC2_TO_SGMII_RGMII:
 BIT_ULL(20) | BIT_ULL(5) | BIT_ULL(7)

MTK_ETH_MUX_GMAC12_TO_GEPHY_SGMII:
 BIT_ULL(21) | BIT_ULL(5)

While all those values are currently still within 32-bit boundaries,
the addition of new capabilities of MT7988 as well as future SoC's
like MT7987 will exceed them. Also, the use of a 32-bit 'int' type to
store the result of a BIT_ULL(...) is misleading.

Fixes: 51a4df60db5c2 ("net: ethernet: mtk_eth_soc: convert caps in mtk_soc_data struct to u64")
Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: improve commit message, target net-next instead of net tree

 drivers/net/ethernet/mediatek/mtk_eth_path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_path.c b/drivers/net/ethernet/mediatek/mtk_eth_path.c
index 7c27a19c4d8f4..6fbfb16438a51 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_path.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_path.c
@@ -14,7 +14,7 @@
 
 struct mtk_eth_muxc {
 	const char	*name;
-	int		cap_bit;
+	u64		cap_bit;
 	int		(*set_path)(struct mtk_eth *eth, u64 path);
 };
 
-- 
2.49.0

