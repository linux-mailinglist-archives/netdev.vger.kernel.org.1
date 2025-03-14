Return-Path: <netdev+bounces-174895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D988A61281
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 14:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 174063BC6EE
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5622200105;
	Fri, 14 Mar 2025 13:23:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03711FF7D4
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958615; cv=none; b=Yj1LrzHZKvFx6ODgfAxZbJtDwyDwWIlRavUrvNMnvzt+XdYN+BRP9n2XVukMiArXnYEYXFg4UpNGNwuO59S1kq4BI6v9+mGH+7EHB/MbDEff3xDO6NdOOu0NS94Vx/tJaczKWxFzGGKh1zswmxkwapU9AmPmkKVjkss+eT2SP6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958615; c=relaxed/simple;
	bh=dT0c0u+wfawVH0nlpWMHU+yE6c1Gd2Ir4z21PVqyRwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cVj8Ab4HkNs0DoG5TekuKq0DHC+UuO/i6cNlaj4gwqSO/Ut56oPcUNR/Js1VUXoXxTTwiSKfgmTaqjzi5cELX1oUVGI5VXwxZLGu6S/pIde9S7KwWlvVd7nEZZBM+kU76zKvH2Xc+C7r0O7RQUItQ4jT/YytvfxSYoarmajd/bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt50e-0001jM-2q
	for netdev@vger.kernel.org; Fri, 14 Mar 2025 14:23:32 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt50d-005i5y-21
	for netdev@vger.kernel.org;
	Fri, 14 Mar 2025 14:23:31 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 4B3453DBC0D
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 13:23:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5FDBC3DBBEA;
	Fri, 14 Mar 2025 13:23:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5e0fd1b2;
	Fri, 14 Mar 2025 13:23:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Frank Li <Frank.Li@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 3/4] dt-bindings: can: fsl,flexcan: add i.MX94 support
Date: Fri, 14 Mar 2025 14:19:17 +0100
Message-ID: <20250314132327.2905693-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250314132327.2905693-1-mkl@pengutronix.de>
References: <20250314132327.2905693-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

From: Frank Li <Frank.Li@nxp.com>

Add compatible string "fsl,imx94-flexcan" for the i.MX94 chip, which
is backward compatible with i.MX95. Set it to fall back to
"fsl,imx95-flexcan".

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20250307190816.2971810-1-Frank.Li@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 37e3e4f48762..f81d56f7c12a 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -45,6 +45,10 @@ properties:
           - enum:
               - nxp,s32g3-flexcan
           - const: nxp,s32g2-flexcan
+      - items:
+          - enum:
+              - fsl,imx94-flexcan
+          - const: fsl,imx95-flexcan
 
   reg:
     maxItems: 1
-- 
2.47.2



