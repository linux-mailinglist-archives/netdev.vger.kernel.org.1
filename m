Return-Path: <netdev+bounces-183075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CEF62A8AD06
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F3C5A3B8A55
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A690B1E47AE;
	Wed, 16 Apr 2025 00:52:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF311DF744;
	Wed, 16 Apr 2025 00:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744764734; cv=none; b=BrilseaPmHo5BHCloneXOwAYcGrl3nq3RFldIxjw3JZDw+1b4mTAxrNoUWVbsYgx8zb/jBT7UzZRS90DE5LjYUJzKlcVfWTH2V6QEVQ6iObRIbCeSVpXe8gJ8ZRSpnUMIuUSXIAuH3Zrz94hpoQSD3oy/IqN6/QXbmW/DDR7dNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744764734; c=relaxed/simple;
	bh=nwsQLdLZmq54o/e/2BRbHL1tnBU089j3kv7JzVfVQLE=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5Q8ry3TeY2KZT9+Tv13oo/pvfmfsX/XSuHzm2R4bbMIluZGq/W0DbnUmdZwwz2mqvlIGoyUTRKWjbQ3GfGBKTZQKUIcgkoqi7DQ+NM0DECqJujZdwRgMFf30hU6EHKy8WwLUTlfhWkvTkzyFENRn+0041gu115DR2kg1fYaVyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1u4qy0-000000001UU-3ks7;
	Wed, 16 Apr 2025 00:52:06 +0000
Date: Wed, 16 Apr 2025 01:52:03 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net v2 5/5] net: ethernet: mtk_eth_soc: convert cap_bit in
 mtk_eth_muxc struct to u64
Message-ID: <99177094f957c7ad66116aba0ef877df42590dec.1744764277.git.daniel@makrotopia.org>
References: <8ab7381447e6cdcb317d5b5a6ddd90a1734efcb0.1744764277.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ab7381447e6cdcb317d5b5a6ddd90a1734efcb0.1744764277.git.daniel@makrotopia.org>

From: Bo-Cun Chen <bc-bocun.chen@mediatek.com>

The capabilities bitfield was converted to a 64-bit value, but a cap_bit
in struct mtk_eth_muxc which is used to store a full bitfield (rather
than the bit number, as the name would suggest) still holds only a
32-bit value.

Change the type of cap_bit to u64 in order to avoid truncating the
bitfield which results in path selection to not work with capabilities
above the 32-bit limit.

Fixes: 51a4df60db5c2 ("net: ethernet: mtk_eth_soc: convert caps in mtk_soc_data struct to u64")
Signed-off-by: Bo-Cun Chen <bc-bocun.chen@mediatek.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: improve commit description

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

