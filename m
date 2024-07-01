Return-Path: <netdev+bounces-108258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3EF91E8A4
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 21:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19B571C202F9
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 19:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E980B16F907;
	Mon,  1 Jul 2024 19:28:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF4616F914;
	Mon,  1 Jul 2024 19:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719862116; cv=none; b=i8GnfeFn8ylaE1dOX8N0DNLdiJW/aeIliLSrOQ5oSUJe5AdfHx2gVivmOG8SgUf17VRfHaIBmLmtffpL5cDrvmQ0OAdEQp8kPNZfuSXpPeXbeuHsg16gNcgMmtatLkKq6K2/NC21c6TM5ZIAy/ydAzGh2DgZEf08xWjGQqdl2rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719862116; c=relaxed/simple;
	bh=QOtHbplpXCj5IzyYIvxEHL7NzC/0t8Gv57xJ5XashPQ=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jG6rylUtxS7VypVAonF4AFfErzSVbHMnMFLgV95JjSaHwQM2pED9GWyZhO5P8LtS69fU4pg+xl9W6/IWBZtygwueLTYhR2a148WAFUmlDxXauopBrByI8gPNen0cGCSpNMOAAXTxSkJkhHoUkkfgkdEFOpx/Bz+JRbHbXREa7Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sOMhJ-000000000Vo-1Tfb;
	Mon, 01 Jul 2024 19:28:21 +0000
Date: Mon, 1 Jul 2024 20:28:14 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Elad Yifee <eladwf@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: [PATCH net-next] net: ethernet: mediatek: Allow gaps in MAC
 allocation
Message-ID: <379ae584cea112db60f4ada79c7e5ba4f3364a64.1719862038.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Some devices with MediaTek SoCs don't use the first but only the second
MAC in the chip. Especially with MT7981 which got a built-in 1GE PHY
connected to the second MAC this is quite common.
Make sure to reset and enable PSE also in those cases by skipping gaps
using 'continue' instead of aborting the loop using 'break'.

Fixes: dee4dd10c79a ("net: ethernet: mtk_eth_soc: ppe: add support for multiple PPEs")
Suggested-by: Elad Yifee <eladwf@gmail.com>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
Note that this should go to 'net-next' because the commit being fixed
isn't yet part of the 'net' tree.

 drivers/net/ethernet/mediatek/mtk_eth_soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_eth_soc.c b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
index 13d78d9b3197..2529b5b607c8 100644
--- a/drivers/net/ethernet/mediatek/mtk_eth_soc.c
+++ b/drivers/net/ethernet/mediatek/mtk_eth_soc.c
@@ -3396,7 +3396,7 @@ static int mtk_open(struct net_device *dev)
 
 		for (i = 0; i < MTK_MAX_DEVS; i++) {
 			if (!eth->netdev[i])
-				break;
+				continue;
 
 			target_mac = netdev_priv(eth->netdev[i]);
 			if (!soc->offload_version) {
-- 
2.45.2

