Return-Path: <netdev+bounces-185009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E28CA98176
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 09:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FA0517BC7E
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 07:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AEA526B960;
	Wed, 23 Apr 2025 07:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="UoA2hvKx"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA5B26AA94;
	Wed, 23 Apr 2025 07:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745394392; cv=none; b=pyUBdgIBLO7KTvnQYYPWRpn+HgWFWRlvdCFSMp5EbT7BblWDVA77qPh7E9nTyyJ7z69Ay6eLs4OG34vIqn1gYr7H+1B0Wb4HmpEgA2IQOMxzGe4CQtKa4YZib6735R1anq35bQRt0feqCT1AkBd31j4R9EVhHiYFz/eh8XELzL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745394392; c=relaxed/simple;
	bh=ieGIEe68/sY0LkB9pUFf5H8M4wXXT347ArzmcCtr+PY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qfUXJWtWFxhao6eCy2d5+pxxTlbQM6z8koIeqsZfplLcyuGly6mz/q/LemBqrMaPp2q907YEZQzN4ivyjMVLctD3Y161lNq1Phv2Cd1Tz98HmwQ3Kx5plm1X29WtRHfEF0v/oi3mg9FMzysqYS2zz/aQhh7+G2tgnKDRkmS8o38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=UoA2hvKx; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1745394379; x=1745999179; i=wahrenst@gmx.net;
	bh=RnU3xSQF40Hhx0bwZHsFEem3QLFiD7pLeyUEgGOzJFs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=UoA2hvKxTzOSJiIPJLKh3TKgvw1UNh3K6IuAIHFobQff81aZG88IXvGREYFwO3h3
	 T6dvtxhQ9tXA46c3SWAnNQu3HGo/fG9ucCKMJhCD5jkWbh4S/wkJ9bPiLWtzOQ8ja
	 +PfMSKiLenez0DcVnB4H6NabLITc8LPUsoFDZwnWzSvFtZO4bfotcuWP++10BZBmz
	 a8AEZu+IN+gXlfiEQOofouS6tAomLGgIKhf9v5w6WVVkAdJ5fW2jgBcsS7pqYsYk2
	 M3mfvXnp9E4olxKRt220jOzCjUAbkpXl4gpjRj6tXn+3uSWjWgOf3Vf4JRMgv7Ehx
	 NkJpHE1EymLUZcVTNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([37.4.251.153]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mzhj9-1v2six49uz-0125Cl; Wed, 23
 Apr 2025 09:46:19 +0200
From: Stefan Wahren <wahrenst@gmx.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	Stefan Wahren <wahrenst@gmx.net>
Subject: [PATCH net 2/5] dt-bindings: vertexcom-mse102x: Fix IRQ type in example
Date: Wed, 23 Apr 2025 09:45:50 +0200
Message-Id: <20250423074553.8585-3-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423074553.8585-1-wahrenst@gmx.net>
References: <20250423074553.8585-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:FZ55j3z9iwXBQ/5zjkisqQfLm4Kd8rDFz56LS0P1W8zs8dxN+JZ
 KWlScIM4bRvSuDWTRvgMrSlU4l3M1tgYHPHEFlgjj9beg3dJRsw/0elq4Eu+jCPflMNQ8Tl
 8cFaMi36+jVmR7DdssNfF6AlbA+kZCfTRfpmzXIpDlkNx+hx2XJeydWU4hCPOOtpYroi006
 luj2MEj0NNLUh+dJux4Kw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:er2uLnUYEc4=;xrwlkA5QZTCNdRRkm9RcLGdLy65
 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

According to the MSE102x documentation the trigger type is a
high level.

Fixes: 2717566f6661 ("dt-bindings: net: add Vertexcom MSE102x support")
Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
=2D--
 Documentation/devicetree/bindings/net/vertexcom-mse102x.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/vertexcom-mse102x.yaml =
b/Documentation/devicetree/bindings/net/vertexcom-mse102x.yaml
index 4158673f723c..8359de7ad272 100644
=2D-- a/Documentation/devicetree/bindings/net/vertexcom-mse102x.yaml
+++ b/Documentation/devicetree/bindings/net/vertexcom-mse102x.yaml
@@ -63,7 +63,7 @@ examples:
             compatible =3D "vertexcom,mse1021";
             reg =3D <0>;
             interrupt-parent =3D <&gpio>;
-            interrupts =3D <23 IRQ_TYPE_EDGE_RISING>;
+            interrupts =3D <23 IRQ_TYPE_LEVEL_HIGH>;
             spi-cpha;
             spi-cpol;
             spi-max-frequency =3D <7142857>;
=2D-=20
2.34.1


