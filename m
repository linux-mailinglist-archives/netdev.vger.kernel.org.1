Return-Path: <netdev+bounces-189234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E7DAB12F6
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 14:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91438A043AF
	for <lists+netdev@lfdr.de>; Fri,  9 May 2025 12:05:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E725C290DBC;
	Fri,  9 May 2025 12:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b="kT+YU9nW"
X-Original-To: netdev@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50FB290BB3;
	Fri,  9 May 2025 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746792295; cv=none; b=a/tFKv/6VlQawQEdeyod7amuVfBuUP3LdnQHroqXHKF7sU4ZNJeIC/0p6orSmttM5lyRaon05QSP3mrGu579PqpWRlM7aKF0Ec6bVXG0KVX8D952wd8t1HR0Q3PU2f4KugN52tBqG5/i4SL7bI3A1TcCs7uVS6i3344TViU5pak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746792295; c=relaxed/simple;
	bh=bSFVDwN8D4G1us96dI4iB9j9aOSFB1APZESYIHOs2LA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iMXBGkuVGbc8Qk1L2xs3zLmuhip6IGuDzrGDxwr0nwXyrtHqgnJpuBKtp1ebaVhKI10piPjFntLkSHG8uBnyUG9BUCXTBt2QrVc03P0uZsXR///3TWhrl6S1dXfhCgreHZ3i4WSSa8nvpfL0hgnqPvgeBVLZ8uopDh1QZOpa37k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=wahrenst@gmx.net header.b=kT+YU9nW; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1746792282; x=1747397082; i=wahrenst@gmx.net;
	bh=GU9F06VWTq6RKZnt3xFBDMIUJGjf9pRtqn9SeNwBKQs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=kT+YU9nWslwse2W670mja00b5EaJCKm5u/+A53cH/n1V5Lvy/4bsF+lkhEMZaSJz
	 V9ISYJIu8/6y+T8kREjpgo0ycG1esz4fPjJdzYzgOBx1WSq+p+BwoPfUuz8GDx04F
	 Vfqy824uJTxPE3F9vzGLCr3yGWqWrNDmRwfXR4LDjaXUIB0LKy9C5bUZo1l4GN5WI
	 DyLXC7YfKl928I25OT/VDtsC307D6HAT7aQFB4W5y5WJx1CJhMOw8WPWnyEGuA3Ij
	 J1X1CbivvYHH8CuNfnMrhhvtyK5C6FAl5zXCw/IuRQdgYNXLTpLhdkFD22G0l4yOv
	 nsr+gAnDJDPzjDEnVA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from stefanw-SCHENKER ([91.41.216.208]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7sDq-1u9WiB3Y6k-0034ye; Fri, 09
 May 2025 14:04:41 +0200
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
Subject: [PATCH net-next V3 1/6] dt-bindings: vertexcom-mse102x: Fix IRQ type in example
Date: Fri,  9 May 2025 14:04:30 +0200
Message-Id: <20250509120435.43646-2-wahrenst@gmx.net>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250509120435.43646-1-wahrenst@gmx.net>
References: <20250509120435.43646-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:B9f35Slo1ehizVftZtTa/La9brD9AMeRU4oYKK3XZNozqm/2Pwl
 ZUAG/L2F9ScePF9PyT+qdpeHOSh7F6Xm7+9Gn4yktINLx3Gd9GKbgPOPm3eW827irfh7Po/
 IWj9DD1rlWiRg4j82eWIhha8GRHP2HzTHmFeqM4kuZkYGpYX9vUKpRnyVsbjT10r7SdEHlb
 dzzQGOuYd1QILO15xdb0A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OTT0taEpeS0=;Ykk6tuVw1hUFarnxTyOhqwSubfd
 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

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


