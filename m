Return-Path: <netdev+bounces-189227-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1E66AB12D6
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 450023AF1D5
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C56628FAAC;
	Fri,  9 May 2025 12:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="J+9yxXHZ"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71255233735;
	Fri,  9 May 2025 12:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792104; cv=none; b=fg8wD7plHTi2LC2GP0c+PNPGYbAdxTY+3vtCRKmABxlTewgMTtq25wstsaBt/qFmItmtTRnKTAraKjUM8pUEpbSOq4JsKn93900S3L8NeEL0prVoUFfxM3+fW9n5+oK1JLZL51SMAiQmZusbkDGJfF/FIDIt1yb1EP8KzDHmPWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792104; c=relaxed/simple;
	bh=bSFVDwN8D4G1us96dI4iB9j9aOSFB1APZESYIHOs2LA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dSNNVH91YdgELb4dppWDt6D6jCDmxaVXowe11MbYDIkNvN4guekZPUftR5XhH+pLWLbKXX/k15S00DHUN6uyicKEO7mBkE1Cob/bkx+z00U8VsbvyLt+EuLBA1NRHbU667CrvBHz1QZFP5wUAsaZkyxu57jLMMHBtk1/kUgTrfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=J+9yxXHZ; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746792089; x=1747396889; i=wahrenst@gmx.net;
	bh=GU9F06VWTq6RKZnt3xFBDMIUJGjf9pRtqn9SeNwBKQs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=J+9yxXHZ/tQLxSml7wER3I+oaMrcv+NZBKMw8eR65R7CeYMaGQhJylLyW+iu/eso
	 lcr4pTacE2w61+JEzbgeLHt4YoYn7SNoscXC9MzquQHyoiU7OKeX/Hh3jQmvdbWJU
	 q8ghrDcvMokbc/o27Haka5SKkzcRQrjVKmUHf+WQhdd8G3C90vt+xLdkxaAi3rdLi
	 FHjSRAHqA7UUwe58tYtnZeQ9+UjiSCtIIl3FdFSD38Gu3f6ySlhcZCgAj3HLaUPLg
	 HvhfkJwGUv/JXeCya+bThEbZlg3s82Rx33VOkK1SgLoTcAwH0MguEYZOQc5xHaBjF
	 S716ZkqdtZQkPZGvPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N5G9t-1vBL0G09yv-00uNuB; Fri, 09
 May 2025 14:01:29 +0200
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
	Stefan Wahren <wahrenst@gmx.net>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next V2 1/6] dt-bindings: vertexcom-mse102x: Fix IRQ type in example
Date: Fri,  9 May 2025 14:01:12 +0200
Message-Id: <20250509120117.43318-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509120117.43318-1-wahrenst@gmx.net>
References: <20250509120117.43318-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W5sp2zNO+BQYJQJOcTcPefQ7mxRhzzkrzkW8ldocIqzkrMszT1R
 ACb0pNBX0kYh+p5ylSDOC/5VgT2MtHniNCmHGO4VCoTCLtAiN7GtXhK+tFLSqVgiidr5G2r
 XRnvl/rbRl3LWCUii69dEmaJN0BkvKwrfSP+wP30tkxVynzrkGjp4umcD/bkBtwMKYMYfc2
 cqrZfkmho5Y+s2vFqvaEw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HAurlq+XaDA=;l6a449MM0b89hxH/oSMkf4bqMpN
 +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
 rdABGuS7MxME0/FIYyiMZVbCC

According to the MSE102x documentation the trigger type is a
high level.

Signed-off-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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


