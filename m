Return-Path: <netdev+bounces-134877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE6A99B6F3
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 22:35:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA5F3282A94
	for <lists+netdev@lfdr.de>; Sat, 12 Oct 2024 20:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDFD319ABAC;
	Sat, 12 Oct 2024 20:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="v3JWTuJO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE13198E70
	for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 20:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728765332; cv=none; b=B8nlOH0ZQdegdL8FIrI3iCSpS1z92cJa3OlHmWoN4QM1blr3sDpBvVgyfGdfCtfGdWqh9BshpLpvk0VMYmEJR4p+5bal8zdu+EMhblZFhT5bAeAB8GTUSpZZATBmVaDHP+m3XX9Jld6P6JAXjbXG06LEHTUEho1pvXwihzlulsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728765332; c=relaxed/simple;
	bh=3+rzSxsqMH0ofbLYBK48GdylevOS91RkTcfy+TL5grU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FAXc0ED0ifDGP9T7OHKQ0UTEqhs8SVPMc5qyZ1EXJn9WJP6TufWQsdm65CWN7jC5gNpk8n9+9I4AtJAKuDZGMzPCKdhRFwntAjhajOmg6HL4I5kF3o/a5zAcnw7wOlVwg+5kwEPkGheInXK39de4jOi3+eAm7bRVX4ENvSMYqWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=v3JWTuJO; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c9454f3bfaso2709454a12.2
        for <netdev@vger.kernel.org>; Sat, 12 Oct 2024 13:35:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728765329; x=1729370129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gHNKgHNUrXFzvsDDr7Hv4Z82UL01qAGHrf80KtxR1+o=;
        b=v3JWTuJOWQ21e1n/UjielkVhTAMbO3r0AgIFbfoTy3XQGhkEHREdAhyeZb3lEeOSqb
         C43zqOgrI4VgST9mBy6nFy9Hafoh+/g2qR8YW9jrBmRUn60V1RMydp4LiN5cFjhKXlEO
         8otzVvz/pFcMqF08dyF5/OFwl+cPTVMmTeZdhvIAPUxnY0ib3HqIi28XPORuBHwnmFjN
         mP2zqPtJ7ZpcdJc69KB4QXzJUb+ThlvfsOxIeqeSpcx9eFVpuAaqCFwvRKLB8CIMnGRi
         +HWCPYBLvwA1a83CQgOg9R6+ZajOmyKraIwp3tP8d705Y1PnM0by/wnsLzigxgoyo0TX
         9XEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728765329; x=1729370129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gHNKgHNUrXFzvsDDr7Hv4Z82UL01qAGHrf80KtxR1+o=;
        b=WOUr1K9jjBabYYJBdz+0tbAhZKuubo8IsV2QOhW0BO93mMc0dH8isG/YFAj3m3D+va
         QV9Fexv7jAX3EGe1ZeInpPEm5tNDM6r7JlrNpv/rr7NyoI4a4HxqOV8cwfv7CElalZjN
         sb3lfNb86c2/W+KTBwjfrTEE0umQpxmd6r4VRVJydeLyN1Ju7PJm+MfeBlDuiztBylyR
         KFZ94FVFEkzJ+Fvfx9KUb4CERdcwYYoNt5U54asVsUS0Dd2opA1xI29kVfg0ZTQ5UAOR
         TegxXY+rZbhOoQHsozgj/CqTGz6h4bHrkoTm9l58Ol6kUCs7/gQBiOfK0EUxbPcvzPkl
         njEg==
X-Forwarded-Encrypted: i=1; AJvYcCU2I0mHkHZKTxOxBgYwIgVzh5OdbwJXppZztUwE9ZNU5d1d+P22TN0r4zW/3F07eH6NAXESFXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiiwgUeew88+N97dI2fRTEo8yzvpJt+sAYkHkNMzXHnjhgmaH9
	GFU3DK5nqDDPtHHCUm4030q7KR/emPZh50XW5+zGMNccmK79vusqOWrbx1jivpk=
X-Google-Smtp-Source: AGHT+IFqBF19dLUZxRHn/RIiJXUYS5mzoKNeWvmbBLeY5MQN/aDULVvgtmxahWSI2OWJCfLWjTS7Qw==
X-Received: by 2002:a05:6402:40c5:b0:5c8:9f3e:1419 with SMTP id 4fb4d7f45d1cf-5c95ac098bfmr2659977a12.5.1728765329156;
        Sat, 12 Oct 2024 13:35:29 -0700 (PDT)
Received: from lino.lan ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c9372940c1sm3164335a12.82.2024.10.12.13.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Oct 2024 13:35:28 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 12 Oct 2024 22:35:22 +0200
Subject: [PATCH 1/2] dt-bindings: net: brcm,unimac-mdio: Add bcm6846-mdio
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241012-bcm6846-mdio-v1-1-c703ca83e962@linaro.org>
References: <20241012-bcm6846-mdio-v1-0-c703ca83e962@linaro.org>
In-Reply-To: <20241012-bcm6846-mdio-v1-0-c703ca83e962@linaro.org>
To: Doug Berger <opendmb@gmail.com>, 
 Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.14.0

The MDIO block in the BCM6846 is not identical to any of the
previous versions, but has extended registers not present in
the other variants. For this reason we need to use a new
compatible especially for this SoC.

Suggested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/linux-devicetree/b542b2e8-115c-4234-a464-e73aa6bece5c@broadcom.com/
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml b/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
index 23dfe0838dca..63bee5b542f5 100644
--- a/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/brcm,unimac-mdio.yaml
@@ -26,6 +26,7 @@ properties:
       - brcm,asp-v2.1-mdio
       - brcm,asp-v2.2-mdio
       - brcm,unimac-mdio
+      - brcm,bcm6846-mdio
 
   reg:
     minItems: 1

-- 
2.46.2


