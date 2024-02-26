Return-Path: <netdev+bounces-74916-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E1D86751B
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 13:36:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 338ADB217DE
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 12:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88107605DD;
	Mon, 26 Feb 2024 12:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TiG2qLMz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90D4605B7
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 12:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708950559; cv=none; b=qRv+y6sCL1QikmEP8SjUfxnGaYF7Kq2PwZM7BcUrxSRVh9AULSEo/EfBM0AzO1aOShIQ9BWq8o9IMcxudo4tJLazz6ywHuaoTWhnObvya8dZuIlfBk7rkwZl8ItrnSNxcJnE2bNOdXUcRTENZj2W/WjimBPkHNh4q5o9ipX7QjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708950559; c=relaxed/simple;
	bh=GXBeYP8/NZGB5qf7XT5SAdvVmTap9xNVMLCGmPvvpCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PN1Q1yXEwr6wrVpJX+ukuTURQ7dUW+hCVbgJgUHKoZX4HpoEBVAS7eR9aE8ELZKE4+q3fT4K9vTL5SxWJsaTBg7hc2RkQcQF24sn6dlMB4zb1d+OpHdunrlun4gxwh9nultniGgIC9bKCrEUcNq7zXtV1X0HRLdM8XpIx9Zz/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TiG2qLMz; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a43488745bcso134352566b.3
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 04:29:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708950556; x=1709555356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9HdH6UtXyV/jkzcX4bUHV7TOheGh3mZ5gM3aVou29Dg=;
        b=TiG2qLMz5qJUgsGBdPzBPRSIIHYodgqkh/gNB/BM6T1KlnLmfDxFxyhgvVDg1GIxUf
         HrOqaW1zdWMvApiLo+aQRhiYuMeUT7kCbEAvGZed8tk1VR9EyG7Oj/l7tCx6GTOuO7TJ
         9RzvX/dczCo3hda3Yi7fQeK1+Om5723GU5XSbKUENrXe8qKRhVjeu7lwryvo8UaNkAqh
         v38/TiSXL+pascDs4rUj+b0SxDxWwOthDdje3OjGdFT5//y6UD92cGshiYfnv5hsigbE
         UU9D8+TUy9Fi+DR9uEwhzIuUetSNKSRX0qwjjOzgLddYLIN2A7oZZ/uX9C+MpLkTOE8t
         SVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708950556; x=1709555356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9HdH6UtXyV/jkzcX4bUHV7TOheGh3mZ5gM3aVou29Dg=;
        b=jofZkp8ri6VXVKD1qNboJxAxI69lX0BFN+Ds+lzEcqgQDkOp0GJWVZTAjlkzkBiwSc
         sdcObhYcPCg+MxJrlY2OzZ/Hb5bqIOfUzELW0DPkIXmJ+J60pYSN94uHRJfxX6FAhfFL
         mEKfn1+lM3UOpzavHBZlrVkAf1XfcRNVd5wsEVu1N2OmyMmEJrWzoZv4ATVZ1bzpRONF
         40RUn6i787dun+n/DNOl6oTPqGjY1l5OpceqBZCYGlmYWoEMovAk18djc9hZMu21yVAq
         TMgA21irvH5iiHgjFLk6i2w011//ZbrZPLna8S1h/De2yS2ubPgvDH3onZbzbpTwlHca
         NWbg==
X-Forwarded-Encrypted: i=1; AJvYcCXJoMPGhhqx5ZiQjnihJVgOciBFoReICA/ukYJoBzkoSMXmk4cxZk+BiE99VqXMGV040aOyzLPrAZmjRJ6Oa3g+jZr5U6Y1
X-Gm-Message-State: AOJu0YxHY8NsOJG6s+Joun05aKBUy6qmVHivSEGCEEAS791uOMlKDF/w
	nS2zgnGkyV72GUjiD41saxjp9BQCgvRe06qvp8sgnUEe27OiQcHMXwAU5fiUTdM=
X-Google-Smtp-Source: AGHT+IHqozMTz0LD5vswK7bz7pL+WRBEhCMhfrrlLmOZUkgEm9k8MLdczRTNH55JCrx0Mk5cSvGapQ==
X-Received: by 2002:a17:906:6bcb:b0:a43:3c7a:39f8 with SMTP id t11-20020a1709066bcb00b00a433c7a39f8mr2340993ejs.71.1708950556073;
        Mon, 26 Feb 2024 04:29:16 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id fj10-20020a1709069c8a00b00a42ffa6b85asm2048272ejc.114.2024.02.26.04.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 04:29:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] dt-bindings: net: ethernet-controller: drop redundant type from label
Date: Mon, 26 Feb 2024 13:29:13 +0100
Message-Id: <20240226122913.87669-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dtschema defines label as string, so $ref in other bindings is
redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/ethernet-controller.yaml | 1 -
 1 file changed, 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index d14d123ad7a0..b2785b03139f 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -14,7 +14,6 @@ properties:
     pattern: "^ethernet(@.*)?$"
 
   label:
-    $ref: /schemas/types.yaml#/definitions/string
     description: Human readable label on a port of a box.
 
   local-mac-address:
-- 
2.34.1


