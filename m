Return-Path: <netdev+bounces-244775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADB4CBE6EF
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 15:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77D383096D07
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 14:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EA94315793;
	Mon, 15 Dec 2025 14:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WqE8Zvk0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51A0F3112C0
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 14:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765809726; cv=none; b=gD0JNKsw5VR9jxqFq3T+iKJ0Q9ikKp+LrVEnLCIeb/umjkIxIOzRAreXGcj24clU5Z3YdFr+uHMFml4MFYXOCN1JNtQfwLCbd3UX7hiLkN2yt2cwdQqc92SB6RqWEjyN7ODOBjNHXl4xAc19o57aBxAs/clXZ2Vq+UaxytyArik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765809726; c=relaxed/simple;
	bh=cob0Tfyv5UDCeaXp27/pjebA60syehUznwOe1AVD2+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eX8akeUB9oFA+BNdrySr5zOK1mIOtDa//KMa6i1V5+7Db5CeTVRXZifUVctfMkSA+SohRShs1mJECyFXWVFK/gYpEK5ES2mGqhKyf8aZCLlTwvo4PmtAGrg60gdV9bdYrW/dcLJmPWLSBJi1oNOjkMaSpnxkKh/RVcPJrCj7IEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WqE8Zvk0; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-477b1cc8fb4so21305235e9.1
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 06:42:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1765809722; x=1766414522; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Sjq9hqGMLWVJCvNIjz/5gdBLkm3Fm6/e56WlsVHAzOE=;
        b=WqE8Zvk0BmQIomj4HKAh9M9kmcmPB7Z7NkxV6M1Iv7Tj4Hnw5HyOMrEgT+S7HJ3Iht
         5JqWNhQZZWVFZlwDXSs0xTtG1/6DlBvho1Vo3F0h+GMJbP6ah0tSN9afqa9B/WJCVadk
         HzmJPDvIZ+GWKunrAEd8k5Ehoetdu1FP2vPylOUB8vjFCIrnF55TM+9Vo0C9JIjNlysX
         rbo8liVXpn7IYKusvBVIOUelfEi7AL7ActTbW5PUhAHkvjFtx9TEsI9nLXHRaS68Ny9F
         I0hLnh21FeaBc5FwqWnrGnbfKJsiKrnUp4tl9LapKQXdjKiQFexYhsIToysJDkSIJGrc
         LruA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765809722; x=1766414522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sjq9hqGMLWVJCvNIjz/5gdBLkm3Fm6/e56WlsVHAzOE=;
        b=dLULJFpss29fEjS1AHpY/0PuQnXPNvBlpJ4vNX/pPzoz8LRXyjv2r31uPnCD3BBwco
         ddtohJfs6PTiDOGIsbIjMXQwIEQGrUV0EI7dmuw74Ki2nZkp7F6pRZiF5gYwp70lALuQ
         T0aF4pEHkxYpWsoKm4PcN2kKNxPb3o7I0w4cSyO8MBnRNdeEPJ3RnKl3W5kOm43p4WNR
         iWvY8RbEyZ0JIwlYjz0gSJsiXEkiaoJboH++wkISazHL9f10dGuwj5ZCwH0lHCQplPHP
         /Cx1MVH9VIWXP1NatlTyAUPvBi1513jC1m7K2JhfLN/kGaWWv7QjJjjlRJvXq6+fAdaF
         CuXA==
X-Forwarded-Encrypted: i=1; AJvYcCWlNAP8XVyWpfsbTyfu/9opqnQqTZIWPAX3mjIjY6LxyMEIRQlw6CWTMHxELmqWGH1wJnYyJMg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyU4DrEyesi7GQG+xRnqumvfNNgXRsB9eFQauVkeARO6R/xIrMR
	u5ZoI7PidZ0uN4v0gvZt3K7rTBCjyZ43wLLwuF2uST2Dj/CbW6Vuliz5O30nTl0CvOw=
X-Gm-Gg: AY/fxX7aPFaahWRcvVdS147OAeM0HoPHCkj7D1Pb9U/P2gta2AHrT34k+xWmdSO4Jhl
	rel6iSib+JxHsNPwokMo78pBEt8STjuX7Zose1A6tcdRpaHk9pxfaHpxVwsrUishGW2NVdDdWCU
	Iay7DfAt46L33N5o81XorMLxp/UmVZlFSkG9hd3M0kovPdL1UD+TSkuAUqPGVygpRdLHqo1ike0
	LHftuz+dElVFcI0nDAJWE4fYPiox0hGV6XoXb40Y/xoc5jbkBH+Ev7Z0CkIjcApLQPFV2FSU6jp
	NIjI4vX8LlH45iWyoslLDk2juHRTKCr63eki3Io0bjHHOBOh1N5v1I7Wk9SzWL/zkp3EY+FpAf5
	PZitjxbpjqs1mIWg0GNOYvsAm+vINQr0T4+FyVfEpf0XigUQIQk0ikgbnjWLOKf/WJZoxdp0DXp
	5vGZ4EdZ7nUSjYUQtJ
X-Google-Smtp-Source: AGHT+IEETRagjZzldJ2K5KE+XtO7ZZwocvLnhZyjVLVzDdY/uQUKFKQkatHg2aZmOJSsMWrpNNBzSA==
X-Received: by 2002:a05:600c:8286:b0:477:7ab8:aba with SMTP id 5b1f17b1804b1-47a8f8ab861mr112263225e9.1.1765809721474;
        Mon, 15 Dec 2025 06:42:01 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fb7118267sm22168335f8f.27.2025.12.15.06.42.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:42:00 -0800 (PST)
Date: Mon, 15 Dec 2025 17:41:57 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jan Petrous <jan.petrous@oss.nxp.com>
Cc: s32@nxp.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linaro-s32@linaro.org
Subject: [PATCH v2 3/4] dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
Message-ID: <1ecafee4bd7dc3577adfc4ada8bcc50b5eb3e863.1765806521.git.dan.carpenter@linaro.org>
References: <cover.1765806521.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1765806521.git.dan.carpenter@linaro.org>

The S32 chipsets have a GPR region which has a miscellaneous registers
including the GMAC_0_CTRL_STS register.  Originally, this code accessed
that register in a sort of ad-hoc way, but it's cleaner to use a
syscon interface to access these registers.

We still need to maintain the old method of accessing the GMAC register
but using a syscon will let us access other registers more cleanly.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v2: Add the vendor prefix to the phandle
    Fix the documentation

 .../devicetree/bindings/net/nxp,s32-dwmac.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
index 2b8b74c5feec..a65036806d60 100644
--- a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
@@ -32,6 +32,15 @@ properties:
       - description: Main GMAC registers
       - description: GMAC PHY mode control register
 
+  nxp,phy-sel:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - description: phandle to the GPR syscon node
+      - description: offset of PHY selection register
+    description:
+      This is a phandle/offset pair.  The phandle points to the
+      GPR region and the offset is the GMAC_0_CTRL_STS register.
+
   interrupts:
     maxItems: 1
 
@@ -74,6 +83,7 @@ examples:
         compatible = "nxp,s32g2-dwmac";
         reg = <0x0 0x4033c000 0x0 0x2000>, /* gmac IP */
               <0x0 0x4007c004 0x0 0x4>;    /* GMAC_0_CTRL_STS */
+        nxp,phy-sel = <&gpr 0x4>;
         interrupt-parent = <&gic>;
         interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
         interrupt-names = "macirq";
-- 
2.51.0


