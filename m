Return-Path: <netdev+bounces-154722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC769FF96A
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 13:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C56A3A2C69
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 12:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84F319258A;
	Thu,  2 Jan 2025 12:41:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0464C3FE4;
	Thu,  2 Jan 2025 12:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735821707; cv=none; b=d40hFy+jdSSz6i/PBFDlpd8Cev2D3HdqOxhWcNdpLcSKUrg6uG0QB4Vh1EZXgC3q6GwHlVe02YotDC2Mcx56Hb9tAXUMPAtQkdbviWu/AChk7ecb4oUIwivkf8XrV1NtswKXd4RHM48zt0EqtDEguq9ID3YzOl7PxuTXfwNGo7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735821707; c=relaxed/simple;
	bh=0gXpUzHDkjStrBONH3A2q3pKD0geXFPCLkiK9DDL/0g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=sjvCjHScVfVPTehznb4SRfizQ9sWZIKrCOklDaz5a9yuw9lV3zP6sfADtm2KG0gHsDgX4rS3NMje8lxq0bZ1JCtGEgxz+BNZRUNsVyjD2VzV982CSSR+yIi1xZqB/AWUQfE5sBaQd+/kDTwsj9pgGfXkXbRA1HdFQf6OXmhdA4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tTKWE-000000007Jn-1li5;
	Thu, 02 Jan 2025 12:41:42 +0000
Date: Thu, 2 Jan 2025 12:41:21 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: netdev@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, Daniel Golle <daniel@makrotopia.org>,
	Alexander Couzens <lynxis@fe80.eu>
Cc: Russell King <rmk+kernel@armlinux.org.uk>,
	Eric Woudstra <ericwouds@gmail.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	John Crispin <john@phrozen.org>
Subject: [PATCH net-next] net: pcs: pcs-mtk-lynxi: correctly report in-band
 status capabilities
Message-ID: <Z3aJccb1vW14aukg@pidgin.makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Neither does the LynxI PCS support QSGMII, nor is in-band-status supported
in 2500Base-X mode. Fix the pcs_inband_caps() method accordingly.

Fixes: 520d29bdda86 ("net: pcs: pcs-mtk-lynxi: implement pcs_inband_caps() method")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
drivers/net/pcs/pcs-mtk-lynxi.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcs/pcs-mtk-lynxi.c b/drivers/net/pcs/pcs-mtk-lynxi.c
index 7de804535229..ed91cd7a406a 100644
--- a/drivers/net/pcs/pcs-mtk-lynxi.c
+++ b/drivers/net/pcs/pcs-mtk-lynxi.c
@@ -93,11 +93,12 @@ static unsigned int mtk_pcs_lynxi_inband_caps(struct phylink_pcs *pcs,
 {
 	switch (interface) {
 	case PHY_INTERFACE_MODE_1000BASEX:
-	case PHY_INTERFACE_MODE_2500BASEX:
 	case PHY_INTERFACE_MODE_SGMII:
-	case PHY_INTERFACE_MODE_QSGMII:
 		return LINK_INBAND_DISABLE | LINK_INBAND_ENABLE;
 
+	case PHY_INTERFACE_MODE_2500BASEX:
+		return LINK_INBAND_DISABLE;
+
 	default:
 		return 0;
 	}
-- 
2.47.1


