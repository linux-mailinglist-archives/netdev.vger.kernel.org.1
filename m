Return-Path: <netdev+bounces-187743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60042AA95B9
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 16:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20B3417A6CD
	for <lists+netdev@lfdr.de>; Mon,  5 May 2025 14:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DCB125D8FB;
	Mon,  5 May 2025 14:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="ZQUVzi7u"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064A425D1E2;
	Mon,  5 May 2025 14:24:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746455099; cv=none; b=dyUUJx/xU2fVEwN7XcflE/03k+lRSORhaw+owPCXzqaQ0hfNPMwGmpUbqYioT3hw9E7bYl5EjqdVBaKkdAfixlow2MBP6I/qFXTwQQAizNaNbagqHbZb+2P+DIkjb5mM0q7yq0zcdF0DX6dynDBzSHnqe0zHkm0i+G2fz1KAxdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746455099; c=relaxed/simple;
	bh=w7srEuJvDS3jqogQy0UT6//+FiZ/3mi+NzLVrIU7PPQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ibOXnIoO4a+cWdN4CWcfWLDBXQguz1BggJ2gKVcL1drE6MIN1/2FkCS2eCZ2EqjsXtVAw3GzreTSITbq2sksDsbb8lFveK4ACGT5CDre52prgRqI7yzvwOYSN10RSlq/YW+tO4+1f3z73kx1kSAOMK9vdevnfY3D/WhgpM0oPFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=ZQUVzi7u; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746455087; x=1747059887; i=wahrenst@gmx.net;
	bh=S+PA42pDbZuoudSRYN0nQd8xRxPPk1PgnYLAayn8MHE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ZQUVzi7uNyt8FjTBXhxI5AFbzX/m/rZdJ3KfvjTR1H41bYws9nU9pPhVUuvN7hy7
	 dMEnxJtCEvukX6cucoCMqv8Zss5voZWR3R4uCXAf22YPr5BvEgHoyL9D2f18u7369
	 HJwU79et5AkN77S03pSf6zWkvqvj4GK2I7u8GV1si+tCWbmRKHc6NuBJalfxdjfdk
	 8AhavVZVbcO5lGIymB3I7DEObjMG1cdteCBgt+RhMygVmAlYbd0Utyi93GdsAiSBJ
	 481RMdLJgcQV3SlsFJ0kaNya+Nz3eUFne30aPd1O/SKfo8TMY3dW0VzcjU1EEn+Ce
	 B1IM4vQJHpz6hQz1dw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N7zBb-1v7oSL3rPf-00yFML; Mon, 05
 May 2025 16:24:47 +0200
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
Subject: [PATCH net-next 1/5] dt-bindings: vertexcom-mse102x: Fix IRQ type in example
Date: Mon,  5 May 2025 16:24:23 +0200
Message-Id: <20250505142427.9601-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250505142427.9601-1-wahrenst@gmx.net>
References: <20250505142427.9601-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZyiFp+3JSXBIrzucnFScPx9wjLkyBUZhPOunDvgL4Ak4da99jLH
 NCxKjbiaIW7spPtylAHSEkfClAaV4ke66QTeHeVjvglIruNcd3G9e4QMj90FPN6WMh34goV
 VbQCUH14wc6rjh+4naNuRvNARiVJTrIHSJEx6eS8mShTQ6FvKtZTBZPy/8NickopL9ZKP9/
 MmFptTSsDWC4PR3jP/wOg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wswFOgck+7s=;xi0uEZXa8O2CD6YwTOTaLsG4Z5K
 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
 XcFICBpYjHIZM=

According to the MSE102x documentation the trigger type is a
high level.

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


