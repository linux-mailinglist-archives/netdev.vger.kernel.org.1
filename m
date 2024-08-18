Return-Path: <netdev+bounces-119494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A9193955E0E
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 19:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FC301F2144B
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5F5F156875;
	Sun, 18 Aug 2024 17:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cu5/pbPB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A2114D29C
	for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 17:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724002159; cv=none; b=DqrG727Ic4rQQzPhy4vo1IDpao0dybBkC6VcOLdw50Fy3CYPIVhBaJaO/RgolCAMG+bx+AOn4RAeOKZByeh77pH1NDL5xskvTNofNxctcsANBm4d/QhG0poE5FMzXQJgVtia8g1kVit94c5/UfP/kyf+WlmRkveHsEXIAh4Kjro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724002159; c=relaxed/simple;
	bh=u3LI4Mk7eTmteZbd26ULN0NFsDdnlkh5zLeBBwZf8GU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KET/64z4Pp4XY4VRmL1D6PXkrreCPurMylbWY6Fg4H2H56PD9NANkcPwIayXMDp1lngDuspAW7/5jD4cwrQhXvpoBwe7fdV/mgrgyDO/SLAhd5ia/PfCYVmZr3m0lJilkXF8b+/kaNHXveCvIE23YSHZ4lGvuJr2NWBzCSbJnUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cu5/pbPB; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-37193ef72a4so1556589f8f.1
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 10:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1724002156; x=1724606956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8es/l2u9z7YHRxm+My9mNPpeISEV38hkj5XsiYsgUE=;
        b=Cu5/pbPB56Y3jYuYGzHZZFEG0lj0CJRvLUAjT5KRhGsLQs8ost3dBuxbf1+MnraAAg
         Ur6KCrmmlpowZIAsL8w19BVI/b6+dhTL6KavtF+F+Y35wRJ8TLQ/1QeWVNohrzX4K/ty
         UPGYc7Fl44DgG8fSFHSnERcRw9STLfMRogyxFRYs+XMu4d2W2b4p5wvPK+7DMuOOq3EO
         Qj4m48MpGGzc+E9ddKiuCzEtRdl5vhftALOu1p6Qn8MQZCxPAvwpUjNQ76BrJcrGYHSh
         RF7CmnN14yTkB0U474N9DUCjsDzdKmvfyCUQ0T1zmH4xvw8CWC4+zB2plKjA8xXiGgMZ
         xSww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724002156; x=1724606956;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8es/l2u9z7YHRxm+My9mNPpeISEV38hkj5XsiYsgUE=;
        b=pskwxhLlgx1TsYcUiZ8hpCm40ETzZ9UxjBYCJbl9EVBs5yqyBrxIsZ96ca7wAsDk45
         T7XvcV6DzRyiYboym+LVM3igbWvxiay/BLSKzVGJdtTHLonfsWJ17peJAv0+QAoWp72+
         Mon4xPvWitInTKWDYJDlF/hW6H6/DjDtsaCPa1W6tDj/980e3cDoGU3vtUAbxREzlWzj
         +5kUJ7VIadoTtgRLWugfN0DpjlTDTMye4S+dA/w36Np73+r8ISURCn8rqwXZmbiBO9vT
         JlTIDQVWSy0LsfpERRfvI43HRy4qgDaau0LnKFs6LxE84OHoPoJ/4dxRICVlUasuBbS+
         wb6w==
X-Forwarded-Encrypted: i=1; AJvYcCXPoRoOUXodMlfEdhbX/c8vOlo8smIsYYnVwHA4l/9U0K7CdKJ7FdFL9sK96usRZQ5Nkd+U9icE/j5DvzQuSkbFR9KxinW6
X-Gm-Message-State: AOJu0YxxKfAkdr0Kp7KZ4DLr1DSw7uYi2m/WnK8O7CAUKPETLw4ZNLey
	8vG1fjC7XHVxGtC850SuZ3+NW4xN021hGsw35zJI5Y3MFGvCIJHaE/fqgTEGlBLI4vkUpYV2e6C
	u
X-Google-Smtp-Source: AGHT+IGDihqENsu32+YwhVnlSe0afwAWIr3NedxRFUFDhgEflC/5EBBcl/lZ8aHqbdVFXfdVdizpFQ==
X-Received: by 2002:a5d:4f0f:0:b0:362:8201:fa3 with SMTP id ffacd0b85a97d-3719465e8a6mr7100101f8f.34.1724002156139;
        Sun, 18 Aug 2024 10:29:16 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3718985a35fsm8510315f8f.59.2024.08.18.10.29.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 10:29:15 -0700 (PDT)
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
Subject: [PATCH net-next 4/4] dt-bindings: net: socionext,uniphier-ave4: add top-level constraints
Date: Sun, 18 Aug 2024 19:29:05 +0200
Message-ID: <20240818172905.121829-4-krzysztof.kozlowski@linaro.org>
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
for clock-names and reset-names.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/net/socionext,uniphier-ave4.yaml  | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.yaml b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.yaml
index b0ebcef6801c..4eb63b303cff 100644
--- a/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.yaml
+++ b/Documentation/devicetree/bindings/net/socionext,uniphier-ave4.yaml
@@ -41,13 +41,17 @@ properties:
     minItems: 1
     maxItems: 4
 
-  clock-names: true
+  clock-names:
+    minItems: 1
+    maxItems: 4
 
   resets:
     minItems: 1
     maxItems: 2
 
-  reset-names: true
+  reset-names:
+    minItems: 1
+    maxItems: 2
 
   socionext,syscon-phy-mode:
     $ref: /schemas/types.yaml#/definitions/phandle-array
-- 
2.43.0


