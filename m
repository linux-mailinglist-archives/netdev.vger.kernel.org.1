Return-Path: <netdev+bounces-184930-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F356A97BCA
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 02:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D6C6D17F968
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 00:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10194254B18;
	Wed, 23 Apr 2025 00:48:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06292701BB;
	Wed, 23 Apr 2025 00:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745369309; cv=none; b=UfxtDeTv9fJyibRHVTgyi0tbJmcqJbU+M/k6eD64VpaFtlqsSWRfIe4Ovpdi4IpkiJRGg1mS4ytqkrMF2CiVK/vnk9czz92rke8DPHfCY/GFx9zlfKe3V2YMIwv+3KxCYSrnfWz1lrjpUuIhBZ4sRnSSHyJ+wFlh0ivm6pxuEXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745369309; c=relaxed/simple;
	bh=LO2pIrNpS/fn+qNQSzI73Axcgp2cJmH+0fpGoc1gnvQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ry9So3HCo4dvmYSsFgfimnzqRbh5vE1xlYWa6KQtcuFYKvCZ5RwOvnhqEimPO8Bg/MTrMDbUwGSEeTPplYpjPlnvS1Zpqjn1ajS+2vMOr5p/Ajs3bXXrGyM4jk9VPKMdMOM4t/r+qJAAbccb5EIRGpWq6qZO4ekThXG54XArRNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u7OF6-000000000JG-3jFV;
	Wed, 23 Apr 2025 00:48:14 +0000
Date: Wed, 23 Apr 2025 01:48:02 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next v3] net: ethernet: mtk_eth_soc: convert cap_bit in
 mtk_eth_muxc struct to u64
Message-ID: <ded98b0d716c3203017a7a92151516ec2bf1abee.1745369249.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>

With commit 51a4df60db5c2 ("net: ethernet: mtk_eth_soc: convert caps in
mtk_soc_data struct to u64") the capabilities bitfield was converted to
a 64-bit value, but a cap_bit in struct mtk_eth_muxc which is used to
store a full bitfield (rather than the bit number, as the name would
suggest) still holds only a 32-bit value.

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

Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v3: don't use Fixes: tag
v2: improve commit message

 drivers/net/ethernet/mediatek/mtk_eth_path.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_path.c b/drivers/net/ethernet/mediatek/mtk_eth_path.c
index 7c27a19c4d8f..6fbfb16438a5 100644
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


