Return-Path: <netdev+bounces-219225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6F0B40945
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 17:42:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65001160787
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FE332BF41;
	Tue,  2 Sep 2025 15:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHP3WVI+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9977324B34
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 15:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756827660; cv=none; b=WGG3JXkXNMRHEUDcROxadz1WzZEQfjhXO99PpmAbCKYsEFFDKi1ZvwSu3hUqmNt0cemCSOdJ/2GWC9ATInejIL9vT5bSS1z4YK819PhyzijeQIncBuob+bGzVRaZPLM4bauly7e9Jy/UpGcpAQo0UJUwHsRH2ScU/oWjmrA3ml0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756827660; c=relaxed/simple;
	bh=sFLVskm/GZvqeQI/f+rrxfYgvGE1+3DHh+EYMzpJNhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZCyNSd5A/neTYQAa+j0xhSmMzhwjTJ6SU1VYZ/o6tHdLMF9HG1SHwLb/VQ3HaP/Si8ZKsMSLmy/YAuZWbJqC3gk5qzt5p4XguraINFSskMnFzrMPMHT0nokDsgqJDo1Y9BuikkuGRZcsxXirBORjkT8wfMESVdVLiSpdWHJxUxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XHP3WVI+; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b00f6705945so22102066b.1
        for <netdev@vger.kernel.org>; Tue, 02 Sep 2025 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756827657; x=1757432457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wB2hOz6NFjWbWAhm1PV1EJGvhxwPuieGYAKDStpXw6s=;
        b=XHP3WVI+RNDMqCh2yt9MR3dr5UtbbYHT2Wz2J5EYxUGWv9H6xCpv24rlB1wQJbOW2G
         BFwKOtkFkstQEpyiat3sKKgCYFTJ6684+/0+JuMnpgDoDnh3Ebp/Svo0lfDC21GKAOz1
         QzS7Zo+cYl0UzXmpZeaVR3DGA6WvDLzN5YaV9/ESdF5DAiL4D5VaiBTupL/h5cSken9E
         Er02XsJwBnfAxGF4EGI9MLWHiH7XJu5BLuaRrYR4MoqRxt/sR52QJk2tJZkQmF7czjTy
         gOqvM15GPkdu1rw/Jqq49CI10/QHetYDjfhVWFOI3dWhVAag37w223zZVMk3Xii0GeBo
         /LJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756827657; x=1757432457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wB2hOz6NFjWbWAhm1PV1EJGvhxwPuieGYAKDStpXw6s=;
        b=pGk49Q2KFo69QJw6hiXqSywVfmWCmMKWZeciNIYJFDKpro9u8CiwXo4SHumheV0xAk
         kk91LUBFQxDSl45dn4IilIJ4QoxH8ZMM3SYpkWjBYmn/1qTB0ldHqgMqlQQWI3UTSvM/
         GBgn2Gzpw4mKgzeWFmCYvkh5nezCqgIpnbDcZ7GPWWDUQ24Ltg2PvuI3kpfyY7JO1ccn
         AKIv6pv2XO4BJuOKa6hV7c106qQOGOzryVSBRHRocV4/zpZG0jWEKLDWwLf0Ad9zNcw9
         E7iYGFTwu3YZbCjdgNZaVaQua40kUjFyiizkS659We9i2RVUBgI3D4PKu+4FrbCx9twZ
         k2bg==
X-Forwarded-Encrypted: i=1; AJvYcCXxjXC2TlcDoaY31HbZ6VmiUSHJvcl2wGg/14OYofeT87jIcD0yXI2XsqPhCoTSXIUyGD+wFRY=@vger.kernel.org
X-Gm-Message-State: AOJu0YybIUH3XJEhgWXCM0YFL9KuPlTqPliDdi0DfmiYgFqYj1jrYSvt
	joAjoibXE3uzE+Ror5mGLgY8Q5RWkX/0xOhrPY7cF+5Z+Y7LS4ohYZ4+0id1FFeKR2zINmPXuFU
	/fjZu
X-Gm-Gg: ASbGncvX6Op4WZm/kziAH564jvH+CWWi7fnk9jODQmz0sd0H5KhyEm9jTaIgnBXfYV+
	zdeLup9Q+MyqC/VwKcbUZWJQFwJAsz7CgfLhFWN6ddLDJ22Fzcicow7nVCJfTfezXbzsJui22ok
	r8Ye81yJhdLKZBQkfsh5tdNEq+AZ+3x28odDWQWQZ0MXvL07yDW6+k/Wf+v6CC+Uga0NgABjy0t
	slfgBZD46ZHPFmjw0htXU7kEIhWLF+IP8lqejkxoJKoKb35BWObzGmsOVDdRq7iEcnLpJNgZW6+
	drgTQM/X0j969TA9UGHbwLjhmKYSO8Ga8eI7rQas5YRViIn4GQ0R6dPczEXtkwwvDTbdDe8Db9d
	s+aWzVSkaOSkg9O6qVLnvXVJp0AcGu0DvxA==
X-Google-Smtp-Source: AGHT+IEWMtUipiwvP55o7SnFFNedcIB9J8Y92SnsL3bGTAtWU6+jlkNHHkULu5G9fMF+Xt5W8a2bmQ==
X-Received: by 2002:a17:907:3cc3:b0:afc:ebfd:c285 with SMTP id a640c23a62f3a-aff0edc4d6cmr819502266b.1.1756827657134;
        Tue, 02 Sep 2025 08:40:57 -0700 (PDT)
Received: from kuoka.. ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b0438102debsm418746666b.66.2025.09.02.08.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Sep 2025 08:40:56 -0700 (PDT)
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
Subject: [PATCH v2 1/2] dt-bindings: net: altr,socfpga-stmmac: Constrain interrupts
Date: Tue,  2 Sep 2025 17:40:52 +0200
Message-ID: <20250902154051.263156-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=968; i=krzysztof.kozlowski@linaro.org;
 h=from:subject; bh=sFLVskm/GZvqeQI/f+rrxfYgvGE1+3DHh+EYMzpJNhc=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBotxAEs7Pi4pRQzSl+H723I8RHNxnqQ8YsTSkC4
 vkxAmnxXj+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaLcQBAAKCRDBN2bmhouD
 1+k/D/0UuXc2i9vi5ZJEk2QSnLsML7RPV42gQabAHH1WKmWnL4CAxBu79LPPNM4a7I1ooZ1jhtF
 Mr0HfnWsGPBrGmp8I1/uv/bXwxzHoXkai/Nz6y8C7yM+JNberjHA+TiBdQVzwbVM3RrI3EPANB3
 lWmBIcSxHKokKT6EaVY1AKnmFgurZZ6y0eBstHMsdJ6ELNsyPVyS6BaAUipo++or72IL3/XbP8t
 o30+Rbvby6HDByLMYbdefwjD4wAzJUzz8Y4uN+rOxXGvErZC3E1bvX2mJG5WVYkRRwTSN+cWw3R
 YUEAJdS3sN0m7TIPexcrKhSmyvNL+7CebE/kX8UNOcms6KyQpmTkmoiwlKEITwCuKHu7rqCcloj
 kXbG0f20Poz5QjpvoBJMOu13+2qCJcWhUCRNVXOGGHVR1EEKa71BYZzwH+6eM1Di4nxFa901haa
 MPJ/wDC6mZ5vqxoKG1aMzF8c5gTYUdO8z/1pyNpGzkwLLdQdFo+k33FRQmngLKLdN3TmFgHHaya
 RVG8d1yntleXzsQP6HRY2mICIMlwAy2wmRJpiusUUYtjnOE96Z3zIcA3TBfTXlXA92EGeJtuUKv
 O16pHUiaXsjIP1644k6rtwNhNVpYEVZ1NJokD2I0xZ5+2h1/Xa7D3vHI9tqIkagc3GnIv4q92i7 pJ52l3zbCm7aBLQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp; fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B
Content-Transfer-Encoding: 8bit

STMMAC on SoCFPGA uses exactly one interrupt in in-kernel DTS and common
snps,dwmac.yaml binding is flexible, so define precise constraint for
this device.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Minor typo in commit msg.
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


