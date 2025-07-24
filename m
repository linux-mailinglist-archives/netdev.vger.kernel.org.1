Return-Path: <netdev+bounces-209723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0DEB10958
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 867647B57C8
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2605D283FDD;
	Thu, 24 Jul 2025 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fUeDQzul"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48738283FDE
	for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753357095; cv=none; b=uaSe69R9UOxddy+JhxJAziO2iw9ihzpTaAbIoQ2nRoRwxvLroRuBh0rxjfutId0oP8gWPuK9HfHaJTBJ9PdOV8mhmLrHafQpR6fedIgIzTOrtZnjs0xbtv2VY5A+JG6omNqwtVywsYZlbul8HFT3/gSkXoKe6v193+vid8jixYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753357095; c=relaxed/simple;
	bh=45FaSWcT2H/J/lWN6laN5MjJAEyxRPSxwgKdw545+gM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VmZwu2PkGnUDoAshX5a9b6j5zcuqOIhN8WhQHJOqW97VZeXctQfergYGGbdtocKfE4rDihaIvIFhl/gQJfQrACn+MyeKapYoFr0j9K1qqTplw7g9Y5GedwhJOYW8ReiOj8MW3WQ+efscoOCEZLap8Gp8yBUaigwBPQGJUyvwexE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fUeDQzul; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-456053b5b8cso304565e9.3
        for <netdev@vger.kernel.org>; Thu, 24 Jul 2025 04:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1753357091; x=1753961891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7SfT/H0IaQgoJ9/m5uHIPysxAkedCZccNPDptMCSI2Y=;
        b=fUeDQzulOE2OF4JpbpuxPI+M6XTpLzppdkgTLwraVXNH2fsFHY95kZaA9ySWCsa+I7
         SmBadUQU+AyA5EH/CRMr38oN7HgXJMArRWIlZgBn0u0T+a/J5zC2mSOqm32kMvZmZMoX
         ZtyIuZcnxpVEWV7K9lH1CYiCvvfk8KE57TVf5um61EhMGYt8snSvh5zrhgpbS2sTdYN0
         FQ4v1OyadpRUBlMLqK0CfuJZYWJ89mtTTcxc7lfcV/3E0GFDaYIaqmYldLkD1UFRAWi4
         hB3J9Vt0YnmXEV+wJxY0M5cFu0Jn7Qg8ooYXAOjLhK0nXA+NIz02nvSWF/Vqr8lcQ1+T
         0eQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753357091; x=1753961891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7SfT/H0IaQgoJ9/m5uHIPysxAkedCZccNPDptMCSI2Y=;
        b=CpEQetbW16AEmqjlradj+xRvbhl4qkdgblnKypgxrDb3lQ2XPxy3M5gRdRiFFL3OxD
         503YL08TpAcyMrILJTLXXvEa7xMe5uJm/elvnfY8m0GUttox+Yhme6M3Z5mccanoRuFD
         MdoKlr2na4e0pIhVbAUHf9g9160bW85e/Xak0BvUJNTS0EZETquZy8zvW1JzfWV8XKa1
         ZtVanbBKjFDbF/ba2O81ExNwNlKy28yTjSAEgSqN1SvpYCbBWuo1++s1Y55nv64zcz+Y
         hDvckGjc7w4B0VUZXwnCCOXMdGsUu90MJefksE9wT9u0L49rStcFrW1rS38LRBdzYJ1k
         2dqA==
X-Forwarded-Encrypted: i=1; AJvYcCXcgbHBZWBUUe4Ch+ZH04hpY2PFN41xruh1q3wy7EhIaZVkkcYOeQGWWkZdt78fPBZW+aTjmxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgRkPd8oznmW8iucojBAJdqS1xEKGg/dYnVXHUnXRGKAquKk/F
	5Ms5Luln2BWy2gsObeGob3odmE+6XMD61etYlWKTmMspS/Iotgu+WfDg2AkAo0+3G78=
X-Gm-Gg: ASbGncvT5hpyYvyXSEjFr27p8GkARbQoU08UlqIajNGYS+gQ7FYyijLbQLAhbkCpcXH
	/1HjTMW6LSTqYXD9g6jC29tddf2P+j+OQdBCghtFBj+ae0cRD9ZP1E6YK5Ao2sHxWx+EDJe7tUJ
	NnpLmWM+vAzn5JkWnw91zbBUu7KBPHy/iEwuLaYSRyaW0Cf11nWp+b0nKUbXOZ3x8gXL3DoEslB
	bktcMT2Ond41gIJK/te/v22vtxKRmjjCQDuNr+/i3Fe/5+cNmaVC8GDruwA2Yv5Vh9jbcYrPwDN
	82gFAwGazdRDIG6gtWosFfw7evyVElwTVZq2kv+aAj2GmGVPKOA6rns4Su93BZl+lmrMQJZ59Bi
	eDJsas+cu0x/Uf+hYzt2JUZw5VYJGSSSlcNeV8KfNl1g=
X-Google-Smtp-Source: AGHT+IGloTURxwE1dU+QnMLX51vNMCm0IjURW0xHmmC87uccnrc9zCjlEuHTvSB3XoKDYy1Q98b1Vg==
X-Received: by 2002:a05:600d:11:b0:456:4bb5:c956 with SMTP id 5b1f17b1804b1-45868d6b4ccmr22625275e9.7.1753357091441;
        Thu, 24 Jul 2025 04:38:11 -0700 (PDT)
Received: from kuoka.. ([178.197.203.90])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458704aaf20sm18329565e9.0.2025.07.24.04.38.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 04:38:10 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Hennerich <michael.hennerich@analog.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] dt-bindings: net: Replace bouncing Alexandru Tachici emails
Date: Thu, 24 Jul 2025 13:37:59 +0200
Message-ID: <20250724113758.61874-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1901; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=45FaSWcT2H/J/lWN6laN5MjJAEyxRPSxwgKdw545+gM=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBoghsWBEmBafEeHRtRGJFliMCpvIzCTxrEH8ZE6
 7sbsMzYYZuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaIIbFgAKCRDBN2bmhouD
 116PD/9ml2y2WOFTg7mpMdyOnPb4/iF/0R5DE4b95e7QeX7tBhleeGN/7Cd2ezr1mSTS43lCIv+
 uoY2XPUEyGDufj4rC7NZyFluis69FFz3NYp7WGMNEuweiGeUseSqrWZD4jAd9h/nMkGYLURamG5
 zuw67L+EeUxRxFQz3tBlexhbO9eBF0LrVjZdyrrdkl/bMCCgOohRbIiT0dJJg6Tfnx4T2w11Xep
 U1WYD1CxMfMckGlC6s4V6CSL1gMBvdTxb2VyCgmBd/1xVWKGNcnFrdTyXY87paz54rZ39t+3N+H
 gMHUJ2rvuRYdD7FZVubJ0TkNwBlwexhJKsPLLz+1nHNhIldx5Hxd1T+m2Zc2AdQ2f6rW+IsiA35
 D/sDKShzFWXKn9LIFXYfEW0JgRTHHCkaVHAOqxwrssUWXIVQHQGU2PCLmvMTcI/QTTL2QPLHP2i
 1xNJ3aWxWwfPjtC79BWjkEh77sqPMs+1CtAv94aDmRzYbXS/YbPUp+VIc56OpMy5TyowVmjjBdG
 Dn64rtb9nwVRaW3Gppou03B7Cybb/rUnZs/S7VdtoSAR0hJu1H3lKJMjQ51C5Fg7wqQuvEuNeR+
 0TpW3ko9S+d/7U2gUB+xgZtEmZDOieWDC7EP4XY5zy8i2fzwi+FBWnw37V/25aNlcL5o+fma7SY pRkGEm3acQXAdtQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

Emails to alexandru.tachici@analog.com bounce permanently:

  Remote Server returned '550 5.1.10 RESOLVER.ADR.RecipientNotFound; Recipient not found by SMTP address lookup'

so replace him with Marcelo Schmitt from Analog.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

I don't know who from Analog should maintain these devices, so I chosen
author from Analog of one of last commits.

Marcelo Schmitt, could you confirm that you are okay (or not) with this?
---
 Documentation/devicetree/bindings/net/adi,adin.yaml     | 2 +-
 Documentation/devicetree/bindings/net/adi,adin1110.yaml | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/adi,adin.yaml b/Documentation/devicetree/bindings/net/adi,adin.yaml
index 929cf8c0b0fd..c425a9f1886d 100644
--- a/Documentation/devicetree/bindings/net/adi,adin.yaml
+++ b/Documentation/devicetree/bindings/net/adi,adin.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: Analog Devices ADIN1200/ADIN1300 PHY
 
 maintainers:
-  - Alexandru Tachici <alexandru.tachici@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
 
 description: |
   Bindings for Analog Devices Industrial Ethernet PHYs
diff --git a/Documentation/devicetree/bindings/net/adi,adin1110.yaml b/Documentation/devicetree/bindings/net/adi,adin1110.yaml
index 9de865295d7a..0a73e01d7f97 100644
--- a/Documentation/devicetree/bindings/net/adi,adin1110.yaml
+++ b/Documentation/devicetree/bindings/net/adi,adin1110.yaml
@@ -7,7 +7,7 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 title: ADI ADIN1110 MAC-PHY
 
 maintainers:
-  - Alexandru Tachici <alexandru.tachici@analog.com>
+  - Marcelo Schmitt <marcelo.schmitt@analog.com>
 
 description: |
   The ADIN1110 is a low power single port 10BASE-T1L MAC-
-- 
2.48.1


