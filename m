Return-Path: <netdev+bounces-119491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A458D955DFE
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 19:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F20DB21600
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 17:30:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB0A3153573;
	Sun, 18 Aug 2024 17:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="paFN9aOS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F01494BB
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 17:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002154; cv=none; b=PJO7oQsP56IJyKO/uLoBqgdqz462J0nCoZJiPLWYQm7RpbomSjWFhVHPL+YriIFxCe74oT4ZOUDkYOQM+qHPfT7sV7+uHV4n+C9voG2q0fAE1GgTX8HEIWyJ6v9EM0QVZDGxSWTBAV0F6g9PQnbQLCyLLdvfQ0qx0nsQJM7UK3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002154; c=relaxed/simple;
	bh=qo4RqSrI+Xyz+o83PeyJscCvl1idzKiReGcMhpUR4p8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e6V6hJuo+YYwsIZIf+sduB1m41dLemNhkDQ8yMRdPA6aOkj2Znb8G9qOCLc9sZz6JR/KOK8OPjE4J/aXQtQZVImuqZCFgENEwHHzz1OX1ndTo2KiF9DtCHQP4zpYG6T+oEIyE942pzEW4bP0RIxmtfG8vSxiB3KK9QScWwmYSOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=paFN9aOS; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42816ca782dso29516545e9.2
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 10:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002150; x=1724606950; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0CjQK1KNzHVntTC0DMWrSHcz+PiTjzfj1MSfy1NDuc8=;
        b=paFN9aOSwOaosC0lboXNudZjng70eTm5n/O/vXl/GV3oLwkPTXrSpoM03lspNgTbIi
         0a4CxwozDfOfJX1JMmaeYKh3zUb7norIumOqCMORUWwFjwoBi6tdpUXzjeu60p9+TGb/
         Lm6BSWRhpeP495G1ZTCF3dysgBdORJBgyY1IezEF2JJHkqjQ04XalZECK+pkm7QGxar9
         TirznFCveqOu70JrWzghZEYi+zKUaVDYVGHduuox1zsRKnDF7VeqxuBXXVZH4YZpLOoW
         Y3W0WAs2VHcc21h3iLRywWTyruotyS7jEuXG47+/HgCNs0TkOLoJDmgg7iUMFdDbVKPg
         TSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002150; x=1724606950;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0CjQK1KNzHVntTC0DMWrSHcz+PiTjzfj1MSfy1NDuc8=;
        b=D86MR9tbnz7mgtrJz5gOOZfxaRMfNTHDhtCK6cajl2jcWIGasxrwW8cm1LcN91xPG8
         rsrGIhDUdHLoWR0ewxcKdD140i7VLmmdJfwb4wlFFxxt7wqyoOotkmDrp6VemYsal06Y
         QY7czqd3HPabW+tYMUJ+0PJGBr0yw/cJ75NdT/9D2Bm+usVyTpHliEBrDc8mhpQT6erf
         O5vw/7lOI+6oscnG7WWTnd8dsdGtnlMhR3kn8GY30w0UTAmD/v5Pz7HlgGdN28/jGolJ
         o7EfS0K/D1xPf2pbB1t1JTWOuRGU5emclUBYU90rEba2JbSmrguDVn94nF8PKtg8HcRp
         Lr9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWxUirTJhhlBKmJoepWeWplo/TuMo5B9ECtwj3M+QHDa/vb2/nUMuJcTXBNuuw3p/JWnbxvM3VTX5Ke0PvwmY34+lk6IFEt
X-Gm-Message-State: AOJu0YyUdAdSUgVgUxAtyYW/N/KxFo7QEx4d80hfqpK8R/HEB6b9MTZZ
	QpDeZEZIKNTgFbV4oJXBTObO/l7XsSzBrLp08Kc4DQ91gaq5vq8eOs1OB5yXvC+ltNV98k6Byc7
	E
X-Google-Smtp-Source: AGHT+IHVSICVAMx+qHSqk3Vlj4Vd8bvZ+oQ57yyU7L62VJrgm0bid26o1BgKAEh04NfnNQ975R706A==
X-Received: by 2002:a5d:6848:0:b0:362:b906:99c4 with SMTP id ffacd0b85a97d-371a74784a6mr2851156f8f.58.1724002150234;
        Sun, 18 Aug 2024 10:29:10 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a35fsm8510315f8f.59.2024.08.18.10.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:29:09 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Sergei Shtylyov <sergei.shtylyov@gmail.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next 1/4] dt-bindings: net: mediatek,net: narrow interrupts per variants
Date: Sun, 18 Aug 2024 19:29:02 +0200
Message-ID: <20240818172905.121829-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Each variable-length property like interrupts must have fixed
constraints on number of items for given variant in binding.  The
clauses in "if:then:" block should define both limits: upper and lower.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/mediatek,net.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index 686b5c2fae40..8c00a6f75357 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -127,6 +127,7 @@ allOf:
     then:
       properties:
         interrupts:
+          minItems: 3
           maxItems: 3
 
         clocks:
@@ -183,6 +184,7 @@ allOf:
     then:
       properties:
         interrupts:
+          minItems: 3
           maxItems: 3
 
         clocks:
@@ -222,6 +224,7 @@ allOf:
     then:
       properties:
         interrupts:
+          minItems: 3
           maxItems: 3
 
         clocks:
-- 
2.43.0


