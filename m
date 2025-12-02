Return-Path: <netdev+bounces-243184-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 81CD4C9B01E
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 10:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 88187348F0E
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 09:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C8C830C619;
	Tue,  2 Dec 2025 09:57:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D9526738B;
	Tue,  2 Dec 2025 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764669464; cv=none; b=JH0EN2pqMkzRuaBz53ZGLjY8+UMogru8HTAElULBbcDz/qrzCG+T3DJWMHVyFtYBBL9ptQRhLuPm+MyZOFguMBmMxooZEZhe+xflSJRj3jLfoAiZJwxne92Xcq2ph/XsRZiTrLgp4gF4VXj9dLb5Ge+Pz7mvLwmrXKbg/X5nwl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764669464; c=relaxed/simple;
	bh=rRwzE6ilhM5Eq19qh7mtfdT8C9obDvOe7Fr/ltLd5Hs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=qT3pswN3A+x3vRbmfj00H8LGOzg/bGh23pm9ZvqpxdCTZ4m6E57Ydi5RQqkWCdrmYFoPY+Wh0kfTPJZ8L9hY2Jgm7yC7rS9AfpgPxjpcEbgX1AoLwZTMj9yv4jDYfj4l+plpb613/dkQm9DwiR3ZLMHbpZqcDg3BUxUrvCsKYCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98.2)
	(envelope-from <daniel@makrotopia.org>)
	id 1vQN8O-000000003Gu-1RBE;
	Tue, 02 Dec 2025 09:57:24 +0000
Date: Tue, 2 Dec 2025 09:57:21 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Rasmus Villemoes <ravi@prevas.dk>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>
Subject: [PATCH net-next] net: dsa: mxl-gsw1xx: fix SerDes RX polarity
Message-ID: <ca10e9f780c0152ecf9ae8cbac5bf975802e8f99.1764668951.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

According to MaxLinear engineer Benny Weng the RX lane of the SerDes
port of the GSW1xx switches is inverted in hardware, and the
SGMII_PHY_RX0_CFG2_INVERT bit is set by default in order to compensate
for that. Hence also set the SGMII_PHY_RX0_CFG2_INVERT bit by default in
gsw1xx_pcs_reset().

Fixes: 22335939ec90 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
Reported-by: Rasmus Villemoes <ravi@prevas.dk>
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
Sent to net-next as the commit to be fixed is only in net-next.

 drivers/net/dsa/lantiq/mxl-gsw1xx.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dsa/lantiq/mxl-gsw1xx.c b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
index 0816c61a47f12..cf33a16fd183b 100644
--- a/drivers/net/dsa/lantiq/mxl-gsw1xx.c
+++ b/drivers/net/dsa/lantiq/mxl-gsw1xx.c
@@ -255,10 +255,16 @@ static int gsw1xx_pcs_reset(struct gsw1xx_priv *priv)
 	      FIELD_PREP(GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT,
 			 GSW1XX_SGMII_PHY_RX0_CFG2_FILT_CNT_DEF);
 
-	/* TODO: Take care of inverted RX pair once generic property is
+	/* RX lane seems to be inverted internally, so bit
+	 * GSW1XX_SGMII_PHY_RX0_CFG2_INVERT needs to be set for normal
+	 * (ie. non-inverted) operation.
+	 *
+	 * TODO: Take care of inverted RX pair once generic property is
 	 *       available
 	 */
 
+	val |= GSW1XX_SGMII_PHY_RX0_CFG2_INVERT;
+
 	ret = regmap_write(priv->sgmii, GSW1XX_SGMII_PHY_RX0_CFG2, val);
 	if (ret < 0)
 		return ret;
-- 
2.52.0

