Return-Path: <netdev+bounces-119492-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E7D1955E00
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 19:30:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 045BAB21257
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 17:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3E3155C94;
	Sun, 18 Aug 2024 17:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NVkNdbHu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD49F14D452
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 17:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002155; cv=none; b=pDTBwTU9vW3+Kr4xERJ+P/mB83xjW5gIOLtJrGGAOcKRzvsEZMQlF3cjmiX0GBlNmqIyz9NrLl285X5X3lIjfcKUvNMgpyjg8qWzXdTsnYI7xP30i8B78ekJuNlydkRd0YqnE2zAB7b80BmnDvyyr+XYKc+AAIR7+5ZWt0ePheM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002155; c=relaxed/simple;
	bh=bo6Oemt17UiR8uphrtM3lFkju/6XmMZtoXZx2VFaquI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XNs4ppN21mpmzOznukKq6GelZt5rm7TplIuDGIHp158eCNBJ3o6LXUmVaQZctKaHAtgiDES14QlHkemENyp306q8JC71qAUpx2LLn8uV6269VwfKB+olpWNyT5MQH4pbUEC3N8a3uuidaTgS02Kg3VP75dHKg5LugD3v7Lwb/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NVkNdbHu; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-371b97cfd6fso420672f8f.2
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 10:29:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002152; x=1724606952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8blFZbfnGlvrrpro9Mt+fDTe8etw4wnb+/lJOb2V/Lk=;
        b=NVkNdbHuKwNMrkpFHEv+jG0xWdIRbaTxNZrJikljwVoePyrByWQW3BSmHR4OtXu88k
         pxPSc3x/yH46AKIt1kYUj/+0pD3NQok5ykvRWeWsJLV2X/rLLZ2yjyfXpPyA8E8Y5qz9
         NQ8rBbdC0D7ESWVhsC3u40a6FfJ6OkAYexO1vp8LMjM6kr+4vlydPdAwvJjdkonfathC
         RkhkLmKsQ9z9pv4dtiRz3qowGvsAen1Rd2vJmn7Ps8RJ0jtt27zOpJlk+5nMVINZS9lv
         OSuFZZj0mw5zbQLhIzxywFSSxO0LJl61VtkIIT4lX+boFbYv0ola+5vgozV6gNfuO/Dw
         OCyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002152; x=1724606952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8blFZbfnGlvrrpro9Mt+fDTe8etw4wnb+/lJOb2V/Lk=;
        b=U0GJNn5B+ClK/UHE6on4OjGM49OShkFGlN6LuiuPoJ11BIqWnwvga+QeXUJZwert+I
         ZqetP658HnF0lH4KnBPsIlgvorUR0vI1s+uu6pWYRY/nj79XXxIma6M82f6sBbbD6lnk
         llpMTN3HKQ0C1fFLY0/3IlPd5ZeRkyCmVLYsATydrAQEA2pTF6e5I8huKPdTCGCt3T/q
         pzkaxn6b1jykEBChgH8DKAjcJeKDKnUdpoH4DK+I/NnhbQp89WhNpDvfvarEp9OVxx1N
         ZAmCfQ5iazDeP87D/a9O/hhVc2AsTywXiqapNTRkqVhalScNCLa8RE09+IvG9VbeMEXl
         FVbw==
X-Forwarded-Encrypted: i=1; AJvYcCVtIPahhvInQrZAfXNqUkKPEFmzPRdPlvLoMjeXZzKvxKkSyUCLJF1e6gdNi3i13YENjcOq/IDetaYc0hvv9Cd+S/a69vEh
X-Gm-Message-State: AOJu0YwszYoGZ5MnpvWr/bN+z9iPrVoW+OVmI3lKY0gb5+cF+Ebtx5eB
	ocXHEFQ0TJkKOIRus22JulPG3kkGHHFWhZMN/IIj7HlekD42yvvGIij8zTrptdIpSO9ITgKP4a2
	/
X-Google-Smtp-Source: AGHT+IHZWNYxDr1n2Hm+4Vk1yE2Q3KfSWgr7knMmpEN6fGiOFgE6l7GIrD+dz0zW1NTTiyyy6UNsPQ==
X-Received: by 2002:a5d:408a:0:b0:371:8e77:92f with SMTP id ffacd0b85a97d-371946dc42emr4545780f8f.61.1724002152245;
        Sun, 18 Aug 2024 10:29:12 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a35fsm8510315f8f.59.2024.08.18.10.29.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:29:11 -0700 (PDT)
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
Subject: [PATCH net-next 2/4] dt-bindings: net: mediatek,net: add top-level constraints
Date: Sun, 18 Aug 2024 19:29:03 +0200
Message-ID: <20240818172905.121829-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240818172905.121829-1-krzysztof.kozlowski@linaro.org>
References: <20240818172905.121829-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Properties with variable number of items per each device are expected to
have widest constraints in top-level "properties:" block and further
customized (narrowed) in "if:then:".  Add missing top-level constraints
for clocks and clock-names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/mediatek,net.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek,net.yaml b/Documentation/devicetree/bindings/net/mediatek,net.yaml
index 8c00a6f75357..9e02fd80af83 100644
--- a/Documentation/devicetree/bindings/net/mediatek,net.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek,net.yaml
@@ -30,8 +30,13 @@ properties:
   reg:
     maxItems: 1
 
-  clocks: true
-  clock-names: true
+  clocks:
+    minItems: 2
+    maxItems: 24
+
+  clock-names:
+    minItems: 2
+    maxItems: 24
 
   interrupts:
     minItems: 1
-- 
2.43.0


