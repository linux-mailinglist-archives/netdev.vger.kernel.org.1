Return-Path: <netdev+bounces-139336-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCEC9B1884
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 16:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 345D2282D4A
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 14:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B3F125A9;
	Sat, 26 Oct 2024 14:12:04 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0F46FB9;
	Sat, 26 Oct 2024 14:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729951923; cv=none; b=DIHHCquTklKDPdYJoFb+QryMnZlduA3gIdEFZJ763Q8KZgr7UeXK4HFhfWx77XLwJW5Sy74vLTuqjMN8DOng25Km4ZUv6YcErGXwjTB+6QWxNenq9wxiyCNMzZ2OoArjgcCB5CrzdnyN6cwZ7hZAWJoUj8dS6cTtm0SnGvAxKkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729951923; c=relaxed/simple;
	bh=w0knoQaLFeZWXWkpbcSJP9KmKIV4ylWnIVSatU++e38=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tXDkeRF9dZXtmuh0hbUZRoeoebBhRSrvfgIxz3q6XOJKtSRsGoeZKSUBuweYSHnLv3dtFYTop1wMdUskkQT6vPDYYQ+c2sl475imJ13Bzlzi0CLSJ0F0D0p2sUlP0+ziH3nBusaHPo2TVuzdw7aro5G2R1kgW0us345+1lKy2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1t4hDa-000000003qV-0Ibp;
	Sat, 26 Oct 2024 13:52:38 +0000
Date: Sat, 26 Oct 2024 14:52:25 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, Sujuan Chen <sujuan.chen@mediatek.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Felix Fietkau <nbd@nbd.name>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net] net: ethernet: mtk_wed: fix path of MT7988 WO firmware
Message-ID: <Zxz0GWTR5X5LdWPe@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

linux-firmware commit 808cba84 ("mtk_wed: add firmware for mt7988
Wireless Ethernet Dispatcher") added mt7988_wo_{0,1}.bin in the
'mediatek/mt7988' directory while driver current expects the files in
the 'mediatek' directory.

Change path in the driver header now that the firmware has been added.

Fixes: e2f64db13aa1 ("net: ethernet: mtk_wed: introduce WED support for MT7988")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/ethernet/mediatek/mtk_wed_wo.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_wo.h b/drivers/net/ethernet/mediatek/mtk_wed_wo.h
index 87a67fa3868d..c01b1e8428f6 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_wo.h
+++ b/drivers/net/ethernet/mediatek/mtk_wed_wo.h
@@ -91,8 +91,8 @@ enum mtk_wed_dummy_cr_idx {
 #define MT7981_FIRMWARE_WO	"mediatek/mt7981_wo.bin"
 #define MT7986_FIRMWARE_WO0	"mediatek/mt7986_wo_0.bin"
 #define MT7986_FIRMWARE_WO1	"mediatek/mt7986_wo_1.bin"
-#define MT7988_FIRMWARE_WO0	"mediatek/mt7988_wo_0.bin"
-#define MT7988_FIRMWARE_WO1	"mediatek/mt7988_wo_1.bin"
+#define MT7988_FIRMWARE_WO0	"mediatek/mt7988/mt7988_wo_0.bin"
+#define MT7988_FIRMWARE_WO1	"mediatek/mt7988/mt7988_wo_1.bin"
 
 #define MTK_WO_MCU_CFG_LS_BASE				0
 #define MTK_WO_MCU_CFG_LS_HW_VER_ADDR			(MTK_WO_MCU_CFG_LS_BASE + 0x000)
-- 
2.47.0


