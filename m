Return-Path: <netdev+bounces-250135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 407C9D244B8
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 12:48:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1C2F930EC189
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 11:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E073876B4;
	Thu, 15 Jan 2026 11:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="l53qBHHO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D0837E2E7
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 11:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768477323; cv=none; b=rnaWlU739q8KCW4IEqkjYauxOc2r9tzFRU9z9+Bfgc4giRsgRpYK1DIjuEoTfcDo4wtx2Cz2/ATLd1GT53rmsx1Kc+xq7sMGUxZ0Du5re6YKLL4sKGZBRZwnpytVgwHY6iCBf05UkIX0NOWfl0Udt3ZyuXihGkbPXAg7zxlHNcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768477323; c=relaxed/simple;
	bh=mkQUI++SFEZY6715sy/bRzpJpUAliolL1r9lnHRs51k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sTKZuaAGuyZUqL79xB2tuaNE7/SzQSGRKL9NRy4bFnoQGF/bsMQqd0tOflASWqwXgcjwRay16cf1efbkPlp7VlOQHfdw7tdwbyoUiP+QuR6W5hyveD3P6R3sTfxqKwmBnbMsSfUnmpSt4Xc6R/BwLUKexagqEd9DVHRvL0TNi04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=l53qBHHO; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1232d9f25e9so1439699c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 03:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1768477318; x=1769082118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmhD7xqaP3tJ0Ge3gQd2f9t6bDUERo+PNGIof7/k4qE=;
        b=l53qBHHOC3NN4gnjGmjzOZAahtk/NF+6fvAt9wqb9Im8E7JMc1M/45s2CqXUlB4W0a
         uuZHwx4eFrwNmU2bh3yp7Eoqb2WQitklVmlOsuVApYFjbE5nlv2cINFaj7P3hSAHunTe
         pxT/zsrKT3jXCVb542lNbKos3OrWTtwoQdJiYrKU1WflD0OQ1m8m/renMuVafFd28Gqr
         rFCo2UZhdRHYm+CMV1XgbKCZ7bJhNoY4ZNLDTqzC7wzp28ixZ0q/WqsPxCq8rlwFUG0k
         0Z/Wl4MKmwhFIkRPobQHpEa7OLi5f2q0uVYnp7z22N78r0M+hg8tJi9X5eKpxq2Z64yw
         mk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768477318; x=1769082118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zmhD7xqaP3tJ0Ge3gQd2f9t6bDUERo+PNGIof7/k4qE=;
        b=XDvVaOUrKMgygaNxwhaoMEL/RPnWC3UMqTMgGU8MWkITm6ILItkVQa4xJ4jvqIpbG8
         YKP5GRF/K9IFORgizk2C7hYRUF1l13ynnVsrquPKL3wJH5+eP00JP8FtJIZvDa21H6KP
         2uN7cKoe0xy0pxVu+FRmS+S/u/yacIyFzw48pm4JC0GB7xiapGT7auPWfo9mdDguonhX
         fWzuUvTkD16n7IBXhC1FL2rkiqM8RFIAORF6A4TPP1S/nmXlj0s4eH2+SZPAhFqLKuHC
         PlKzBaK5iJ6CJqK/sXbDFLpMou0uGJCj7VdH1sdRzav77eaAx9CZ2uSUWuLzExTo+zXI
         fmRQ==
X-Forwarded-Encrypted: i=1; AJvYcCVX6oBqMhdpDBmZZ+//CzFyv0RAMIwlGY4TlZB+JR9cRw4w6l1mmO6/8N6zyoGzlOKz8KJ5dak=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCRS2K/PyVn+vMjAGaIropoaA/CNtyEYDFS52Un1WzvAnhYUTH
	DCX6KNlcxbvmTZprhoVy65xsghGQymWiB+8TBXRN1hyy1LQff/zRPoQfYgbijTmSFo4=
X-Gm-Gg: AY/fxX5gBYStAJWtCYpbIXTrbU6HHIHiFGC7D7lrypnnFrLjwZs0R6VSN/c9nxo+nhH
	EqVtsBqszr1C2AztG9+bpn3JxImowUGXRGes/uX7EBE1JMuwWEdVKoe/WyM2k+4O0B6al/ME9jg
	OR9+N1J7JBfal/DiWc/V+evdAibj2GgzJnKu/vesRDNOek+AY/RxX1sPVGeUvv6589mm/1R4X/1
	bOaVFhQ1eop3y7jOoqLqXFaaYJTj5XG/+GJX+kfR1i9sGZoF9vAADINnU2un47pyZsYYTcYR2FX
	oGuIUdT1PqGNYbB2DTENxDOe5m+VsjZGzWYoYIGU6rhnwz5jUzvCvTDDmpdEvDwe/u3GcDzE8qE
	ulfhVH6kkLE5ztwThUe8xtYgJgHgkjaPRW8tlAPsEfEc5XCz5a+qgLGw2DK1ZROAYLoTZnxRc1r
	1L7NiCZCOUP4peTjtAj4m/baVpXHy9a+HdIxLCy9fxt7Fh7p2bdfsugWWnUdPomaPs8aEfaGRQh
	DX6eZRY
X-Received: by 2002:a05:7022:6184:b0:11d:e2a3:2070 with SMTP id a92af1059eb24-1233778b5f3mr6944456c88.44.1768477317748;
        Thu, 15 Jan 2026 03:41:57 -0800 (PST)
Received: from fedora (dh207-14-52.xnet.hr. [88.207.14.52])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-123370a051esm4875347c88.15.2026.01.15.03.41.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jan 2026 03:41:57 -0800 (PST)
From: Robert Marko <robert.marko@sartura.hr>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	lee@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com,
	UNGLinuxDriver@microchip.com,
	linusw@kernel.org,
	olivia@selenic.com,
	richard.genoud@bootlin.com,
	radu_nicolae.pirea@upb.ro,
	gregkh@linuxfoundation.org,
	richardcochran@gmail.com,
	horatiu.vultur@microchip.com,
	Ryan.Wanner@microchip.com,
	tudor.ambarus@linaro.org,
	kavyasree.kotagiri@microchip.com,
	lars.povlsen@microchip.com,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	linux-spi@vger.kernel.org,
	linux-serial@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH v5 10/11] dt-bindings: net: sparx5: do not require phys when RGMII is used
Date: Thu, 15 Jan 2026 12:37:35 +0100
Message-ID: <20260115114021.111324-11-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115114021.111324-1-robert.marko@sartura.hr>
References: <20260115114021.111324-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

LAN969x has 2 dedicated RGMII ports, so regular SERDES lanes are not used
for RGMII.

So, lets not require phys to be defined when any of the rgmii phy-modes are
set.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../bindings/net/microchip,sparx5-switch.yaml     | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
index 5491d0775ede..75c7c8d1f411 100644
--- a/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,sparx5-switch.yaml
@@ -151,10 +151,23 @@ properties:
 
         required:
           - reg
-          - phys
           - phy-mode
           - microchip,bandwidth
 
+        if:
+          not:
+            properties:
+              phy-mode:
+                contains:
+                  enum:
+                    - rgmii
+                    - rgmii-id
+                    - rgmii-rxid
+                    - rgmii-txid
+        then:
+          required:
+            - phys
+
         oneOf:
           - required:
               - phy-handle
-- 
2.52.0


