Return-Path: <netdev+bounces-249460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 21366D19634
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 15:19:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D08E8302F730
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 14:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF5B2E1758;
	Tue, 13 Jan 2026 14:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMUfFQoY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578DF392C36
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 14:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768313639; cv=none; b=fMEJZvitRfDxb48ZxVvQ9lzRznmv+pTz22OYnyMQGY6CUMRgqxB+ryAw7jFvMYf8tEL9MYHY3ssoTITdbV0kNzkrfu0C52gJIdBEv1/UyzRAd9YiPheCYzuHFvi9daFgxTGY2Upw+I5G0nKZlGSvcfTJIUwiGQOGYwNGI8u2SE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768313639; c=relaxed/simple;
	bh=CKKW/gznSDOPnlhwknSKAxHfsRLSGV4Nuag72DM6Dyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ioSL7vKRj1buUaYZNKQZ8otXCNk0W/OnqAyq71UfNrAZg9/xEXqCcSphMbE2DUwarITAe3t+l2Hrmqg/uP409acZNskykiaJ+A7n/BsMi7juZhd/HqXlvjXnhFmR8tWiE77eCmI6kKaPyqM5K8qCEJ5b+VwCvJUk9g35yMrqPC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nMUfFQoY; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-47edffe5540so3020335e9.0
        for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 06:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1768313634; x=1768918434; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wIl4MJEHigyP1D4DG/B4IxRmiFqSM8hzu8VMWNA8Grc=;
        b=nMUfFQoYDK6jx3qMp5cu1uz78jp4NBTslIgEX6eavV+NvzK+ApgVmP+UN6wtR8FvNY
         1MNKHywyzCLyTJR8uaLWWccayWXSBK0/QNUelzx6W/8wdnh/vhwGcChU7FXgk2QC03Ig
         XJX6aNuMZPXNKW0eTaxkhK2lTIfb+q0ypxoChO72ZOqx9RZMts38cT1vFkXqmdAblOFN
         r7W87e1FzDW4hmTzCevxCVknhrkt6/tcKnhBCy4CY4CRBlWJaiN74Nve5K5Lhrju2D2S
         XESymgW0VFtQrG8hHSgbSxHRtAG6ND1Ig5yDyFZU0S+khHkdQ0XWqEsmQFXPL+O66CFo
         Y66Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768313634; x=1768918434;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wIl4MJEHigyP1D4DG/B4IxRmiFqSM8hzu8VMWNA8Grc=;
        b=Vuj2ouljhnwniiDKMeidv6JqtgUbaQkD5EDAnMLlw7QzJ4XJGrUBwmhIu9H6bOsdfN
         Bu8FjWwedXaRpCuuKvsmfV3hT2T1Z2q35sYvdq9qd4eLTbyPOWiZtTJIqw7z+kppc1pn
         vWWg969BZ3LOSaWpVN4hzDXh+CXo9X1XmeAHW0jyM7mg+g+tifYhJaVKA+GGjJQAfbO7
         LEsszsuTgphXzxAoJYTxt4m6+hllIKSAciAlhiWBTP628lPVLauHELwRZ5Z5/Q8w0pP/
         Vl3inOoogNS9GSZvChXltFR37+szge1Ka1mVV+WyHG0U/heRk6ryileYcujyVzfPNkTQ
         3V1Q==
X-Forwarded-Encrypted: i=1; AJvYcCWwuLzPzB1nWLDhq1NT+wB99YuPV9qTamAE+bsNRyzjGtLT3S6+DkJNsVJoytFpIaMn04gGVXc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYerRwGM6/tTjbwwbVrpw3ITEo5LFHuazcL4kQUQoCuMghS75J
	WkDQ8WKTUF0Eu8bb/Xlyi/ft1JigMPvVztLxCHE62DgWRcj1+3xbNfZmCHsnECH1bdk=
X-Gm-Gg: AY/fxX7b5Euc0hflMiYPytpc7LiVhpumsfcZhl2W5SLtPoT5v4a9+qdNH7Xb679icAv
	sYE48fvUU8FESs5euted56552PRY+W30KA1rz1zsFf6WqSvqHz4VGFDqh7y8cqcTetHozqPLjWl
	hq+spmjpPw3DnYqcVlZB/j9Rh4id9uXZShxH6AMrpR3DGbqT9m0Xo6BzgP1XD6NznjJMD6nJGOk
	AgV0JQ2W6t5dA9Q8uVrBY1yJNN8GTQnF/k7Vfp+3/CuhHSGam6LYOKh7bAvJr1IFwafv0+N3GQx
	1tx+/CtiH8BxJSKYN8xmCAn0WsNig5oKQ5WxxPFOUkJ10GohGL2ftJFMug8lP+8fEwGPyXU4rrA
	0qZpCxxj7VzdNubgEv9oILkRE3pdEyHGauGbc703QSSYdT1FSTVwscm2awdsLaT6u31odJyiACV
	UppU0UIgDg5mgE2z1W
X-Google-Smtp-Source: AGHT+IHkyPQVUw8xs93KfcHsRE5T/d53G146wp+tXJe4SYI9ShWK2S78YZfw2MZQRgqiABbgN1Oeug==
X-Received: by 2002:a05:6000:3104:b0:432:7068:17d with SMTP id ffacd0b85a97d-432c3775aa7mr27685504f8f.20.1768313634216;
        Tue, 13 Jan 2026 06:13:54 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0e19bfsm44033372f8f.18.2026.01.13.06.13.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 06:13:53 -0800 (PST)
Date: Tue, 13 Jan 2026 17:13:32 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jan Petrous <jan.petrous@oss.nxp.com>, Frank Li <Frank.li@nxp.com>
Cc: s32@nxp.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linaro-s32@linaro.org, imx@lists.linux.dev
Subject: [PATCH v3 2/3] dt-bindings: net: nxp,s32-dwmac: Use the GPR syscon
Message-ID: <7662931f7cbafe29fc94c132afce07ba44b09116.1768311583.git.dan.carpenter@linaro.org>
References: <cover.1768311583.git.dan.carpenter@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1768311583.git.dan.carpenter@linaro.org>

The S32 chipsets have a GPR region which has a miscellaneous registers
including the GMAC_0_CTRL_STS register.  Originally, this code accessed
that register in a sort of ad-hoc way, but it's cleaner to use a
syscon interface to access these registers.

We still need to maintain the old method of accessing the GMAC register
but using a syscon will let us access other registers more cleanly.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
v3: Better documentation about what GMAC_0_CTRL_STS register does.
v2: Add the vendor prefix to the phandle
    Fix the documentation

 .../devicetree/bindings/net/nxp,s32-dwmac.yaml       | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
index 2b8b74c5feec..cc0dd3941715 100644
--- a/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,s32-dwmac.yaml
@@ -32,6 +32,17 @@ properties:
       - description: Main GMAC registers
       - description: GMAC PHY mode control register
 
+  nxp,phy-sel:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - description: phandle to the GPR syscon node
+      - description: offset of PHY selection register
+    description:
+      This phandle points to the GMAC_0_CTRL_STS register which controls the
+      GMAC_0 configuration options.  The register lets you select the PHY
+      interface and the PHY mode.  It also controls if the FTM_0 or FTM_1
+      FlexTimer Modules connect to GMAC_O.
+
   interrupts:
     maxItems: 1
 
@@ -74,6 +85,7 @@ examples:
         compatible = "nxp,s32g2-dwmac";
         reg = <0x0 0x4033c000 0x0 0x2000>, /* gmac IP */
               <0x0 0x4007c004 0x0 0x4>;    /* GMAC_0_CTRL_STS */
+        nxp,phy-sel = <&gpr 0x4>;
         interrupt-parent = <&gic>;
         interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
         interrupt-names = "macirq";
-- 
2.51.0


