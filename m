Return-Path: <netdev+bounces-219075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E42B3F9F9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 11:15:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E5F3B08A1
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 09:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3DE7272E4E;
	Tue,  2 Sep 2025 09:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dFIK/AQg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C4621019C
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 09:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756804543; cv=none; b=rW/TKQoV7kvKNkHjR6MPnkYP0a1jYF4CTdQ1uzjxP+X8qtu6OWD0qnK+9urH96n+TMzYfxrvEHQ+i/IX9mIy6AyxKUDHqDdHAvT8Gn05j/xyOHFELPWbdztCDUM7vb+CO5Dif97AOdi4LrXBHizjdnmmzI3yYV0+5txAgOjxCP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756804543; c=relaxed/simple;
	bh=omOLYYYjh3z0DVh1O46NQbX5aRk5HswOved29mAUMag=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iF6hUW0AhQyd+Ue+TNA10bFEcakXOUIcIa0kSTFdXhRIjghhcsZL5mQFGp9zKLm1GoDd+5905Qz0xzGaZCS2mdMcuZBXbJyoqFz+qTAf0jawZps177SjMN1MfYMfoJ4mARu0WQAb8C2Qk3jP3JTBQzNpHpxRnxkGWFgLEquY5nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dFIK/AQg; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-afcb7a5cff3so92381066b.3
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 02:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756804540; x=1757409340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m/8bnMdkcwBrzdormqUmLTK3k80g92+lN3p1s60KZ+k=;
        b=dFIK/AQgLm7+RhvU01FSTZ87yUpnZpvR3a4PbrcQtUjFxiOnxNvCPv5VATP8qpUNdS
         9+Pgkl2IJK08lDRWovSnq5KkWAGkZQucyhOMEb+5ux34ooFo9pjI0bAxzYMyNRGFuqCo
         HxuLXlxfG1xuNd9s1EDVtyr36jLqJ7WDG3V33PyNXV0t/FHwxzXN2QL1ZJKiZ1vf9zNp
         8F4H0VuVHeZFawqz/uO9BWko1CgXJIrtqCAEikjBvqpQISKmZDUZFXFZ8Z01oB2GVn/V
         x5c5TuJfcFvdobQcqyu8kntFp8JzU5BGC23A+m8Fsx1wKJZK6SWITknua2jwMZMYWrsR
         eCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756804540; x=1757409340;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m/8bnMdkcwBrzdormqUmLTK3k80g92+lN3p1s60KZ+k=;
        b=UNCcS761UES9pPqz2g56+0Bn7O3/WwXNFVJe89qsOtQZkStXSrEdcZqTR3nNxIwUx7
         PpXB31egzTlYm1HWHeN9Emfo+MKqRFyNhbfwlNVl4ev9+jtvNpBY4sw8Swa5xSAMEqLs
         kpN4dYiQzNzORauOvbpl58QLIbgcGS+9pELV0LuAwvF0ll4mUN1y7Y1rMLZ6vEkxWjDj
         E1/NPwCePQc0hJF+SSxvWlfltiCuKQ4sMwo3b/UZ4sp1ociBIiubBvM43YwzVFAXOIPQ
         VmWMLoIFEqU2lBFYDeHkJYdJETJsO2YlemamWkR0eY+wqE1FD3ICZPYYbxsMl0HpEw4E
         GBKA==
X-Forwarded-Encrypted: i=1; AJvYcCUXZ/D/8V+kqcGs3m2a1aQ2owMtxf0SMTiyJXTAPEX2i1Ob2q8UA6sUEiEfSAUL1u0U1R6j70Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyNunk+9bY53lxCd15EyO7+AFU42NcLnkpNBU3fGxXJoV3Tke1H
	ManGhk4ZIT739ibddZu27HUQsZm5kxGFUgPdipwaehRt6afG6vjc7mNfkLbWd6WaHb8=
X-Gm-Gg: ASbGncuHnto3MJVIzFxytvptNKQ0rwni+n/S9E6H9Nb6ohjw9GnufUfLRaor6GyhSYq
	5TrJOscxE0lPfCdVXzbES6xaCgH+6Bb2OP7lGhDbTryY3BTbVYaQ6xom+YqAy+WOsoCKOBu1MoL
	t1PaoeHI1BV7+/5LB/3nIMFhql124jU80lFL0ZQ6vIjnme3dLqclGaGO27TP4iFYEdEexmcibPp
	TKi8ehJ83G8UoWsiEDoOgHiVJi/5WGhIQ13RWu+7D33EhySxMDZkajrEfONNI7miuLmVYYcBfDP
	5ELz6voJykbvVWMGrzuA8SLdbzJX+mAJjyaqKHXCcQNzF0+kzapsyksqE+HIMTF1S5Gvk3pZELM
	oMtTSJc8qNr91n9loKlp5SL8nfASUIfAsEkjmmQ6pzsMCROW8pkQFj4U=
X-Google-Smtp-Source: AGHT+IGsSFPfLqX1TSTY7vx9/w5ZifFk746DiQHROlsIAv27SMqvJyUuB9Px6z4DG9dMMXNer8ncTw==
X-Received: by 2002:a17:907:95a2:b0:b01:989f:46d0 with SMTP id a640c23a62f3a-b0198ae8b17mr566468666b.11.1756804539611;
        Tue, 02 Sep 2025 02:15:39 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aff15fccb15sm877008866b.98.2025.09.02.02.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 02:15:38 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Matthew Gerlach <matthew.gerlach@altera.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next 1/2] dt-bindings: net: altr,socfpga-stmmac: Constrain interrupts
Date: Tue,  2 Sep 2025 11:15:27 +0200
Message-ID: <20250902091526.105905-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=912; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=omOLYYYjh3z0DVh1O46NQbX5aRk5HswOved29mAUMag=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBotrWu6Rq20SlnUGOaA358hH5nv1fnKm5T701YM
 YgxMdCPxreJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLa1rgAKCRDBN2bmhouD
 100DD/9FY3aTCBs5BXmVSlnhJDkPZWHvDYOPI4Ae46T6toYdFe0oHBCT1ivV3pDoDGSKU73VZdG
 4E82JAx/MwQyjQ4F4iyK/iN6J1wXAQ6i61V+oYGoyKS+lR4eroU9Dx8odZXyXbdyVq3lU3sO+MG
 TDML8f+YKLY/tOdjh+vJcUU+n7Ipf9HjXQKFVmWNzWlcopnWLu+hCztmEm523MO/p1nwr7EbwzS
 AE+Q93zwfJEIQvKPuS9HS1E/MCAEVvrv+j8hvLkvmDxui+woZc/NUr111q/CmX1NgYQVyjmtExN
 /BwHQi0xOsvXemvA1ABLngFYG/dTIRx8KEfwl6pEKcqZj6MZrsUok0KLHgP0q0yP0RJEGikumsY
 mXQV/LE1skdf/aP0YwXf/b6CQ7zUG+u7gs7mGvZhYthkIhPxlmSbMsX/+TsZYDGTLu/qSfQYuT5
 WVsC78X2Hv5kVCE3+9mfwv4cuAU8quFWeKWOzdzIvNMX63WhjHv+91/WFpl17WfG6XXdGSlgztf
 R5hp2f+n5jEtt0OlSWeRqSWMezS3EsPt0fbsgR8Jub4XEpAM22Xh5X9nBqMYS2HEBd+j7hbvtib
 2d7ORY8wvGFU4MGzahiBEwPT0rO4qhj4XqcoWUECr78rM46doe2LQeEOP2JfNG/jl5b4jREKBwl 30tClks5II7F44g==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

STMMAC on SoCFPGA uses exactly one interrupt in in-kernel DTS and common
snps,dwmac.yaml binding is flexible, so define precise constrain for
this device.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/altr,socfpga-stmmac.yaml       | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
index 3a22d35db778..fc445ad5a1f1 100644
--- a/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
+++ b/Documentation/devicetree/bindings/net/altr,socfpga-stmmac.yaml
@@ -62,6 +62,13 @@ properties:
       - const: stmmaceth
       - const: ptp_ref
 
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: macirq
+
   iommus:
     minItems: 1
     maxItems: 2
-- 
2.48.1


