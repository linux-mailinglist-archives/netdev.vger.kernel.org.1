Return-Path: <netdev+bounces-150835-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F7D9EBB04
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C39188849F
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 20:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1990622B596;
	Tue, 10 Dec 2024 20:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTT4OdfT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2C4226862;
	Tue, 10 Dec 2024 20:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733863743; cv=none; b=uM0Zv1ua2R/t8KkcURV+JWnzE8+mKDUjo9j/qIwPE6UYhUWTI7ZUmzoSc+QyBUFpQEt2Ixk7/X1leJJ6p0NXNWPz5hPlO3dxiVnbTsZRSdee8jLebxsZb7S4vgzkJbEBRJpherpecaOcEWdmC3UMLV5uWCXAmerNldMD8AH5BcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733863743; c=relaxed/simple;
	bh=eC8W6t9huecH7q74kCAQR1oz5UQK9e/WxZ8oJb3G3Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AcomdticFFFxXqhsvwXKFVEHWRDmPlY/VA5wGfdqr8VflWu3XDBTxZ6w9IJenAhtwEnyTJZPWY67aAwLgyGIAB1KO0+FRGlMF2vsyr3OQ9j8imfogBtkI4xGI35Ndx9bi8M4Lf/OEeWrNFRFggVNSIKSSgIo1ZmkJGYgnF+wrrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTT4OdfT; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5d3cfa1da14so473483a12.1;
        Tue, 10 Dec 2024 12:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733863739; x=1734468539; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cNaXJ8JhPRuTmwTT3LTe+sP5Z8UoA760Vogy1s7z9Rk=;
        b=iTT4OdfTGMdsekyXZmM2cynTKa5WfsqDbyZS1ehUn/UGIYhyIdIoILeK8EJ8XqJOuk
         gRZPNX7jI4kYJkWkRbOWAvH0dziAvJtolCFB0Yb7dTj8f+wmeEFTdwh7sNmTukEyPH9f
         JDP9gdjw1vOROdW5RG+wBUVmCN8z/rnseZdSoI1KNC4Ame++qicYVpqImW0o3cL9akjr
         h2V3epK8HoEDGfUbx7J2rEKyQrIAVgpTOeyS0xKlUVRm53YEjBc1h/ghfWVe5gvtLXD/
         fsXlWEobuAEL2T0S7zIB/IUQUOcPIrQ7MKKrpczceV5SPabjyPvcN46L2F16jIvllY3q
         lVgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733863739; x=1734468539;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cNaXJ8JhPRuTmwTT3LTe+sP5Z8UoA760Vogy1s7z9Rk=;
        b=MXW/Whn3SjInK0qUzt4sCwOzeHgb67lCpHJB4jf/fgJOiwP77JakOJNad2gdLtWiSp
         exnZWsKVwepK4Gy8f7ED74YsrmlD7vsKSdutlSIrFk3QqOwY9Ji0RvZni+TmX7t2cPfj
         VdYxguP/RhpFG9pv+lzpsMVYAGw2nxqwH7nwbK8DjWAEicgll4mRO4gY0jhJp1qX6Sqi
         FRXQwXtywcpsJXP7hpXcnEA769qB+jWPlCtRw0/KFLwSo0zjoKfN4WV5NBxdTfugCFTP
         3bHBHABrW25PDLoD3AY04BXjQ2R/w7zqijpN+FBocM8mpdJLX6kTd5S9sXzSMMcUpwJd
         i//g==
X-Forwarded-Encrypted: i=1; AJvYcCUZPBR9cpEXrthASDMsaKMIHarrGuyLMzLJabQ+4juPg+8IbqD6RkadtdsxsMfvmtZaowyiwE2gp/fkmP6c@vger.kernel.org, AJvYcCUpgpcOeDxsSEbz72Jarxo2ak9+Jy5160soo0V137pOTM0cQEOknzNKMWcYK/x9YQqj6Lw64qSdWpp5@vger.kernel.org, AJvYcCXwbj8amZNfPsDrI0HkPLwG/UNohBM6QfM703muQPf805OGkBjRepu1K/7k837c4btEPmKTmz8Z@vger.kernel.org
X-Gm-Message-State: AOJu0YxpwQQG5Y+fHyB3bgpe6edhQk2cboT/TYeoNiCkdDYUUrarWVka
	QstWVppkzPiUBkgWf8Sb3mTYqAQZ8iI3HVwjaY+epofhOUzltsop
X-Gm-Gg: ASbGnctBOpDQ10+9bTQ0wsh3881V2Zhi+uDsnv0oxzD+J1Q+CHCX6QZglbTAk6tTAej
	JF4fwZnPMd8NReEbCG1uWSBc0JW14qw2pb9gKuZoIixWY3I0/0w6N09cHCyYHeefh+XVRB7zAM6
	gDGQcGj17P2lr7pIhpxYNa7C/eVi5Z6YDKZhs96hKQLo3R6SVRBAD6WGMk9AqUIt3i3ydpPXqVl
	A7SiBIaQUNdu1wkXVyUWUWv4H/W8SEzzl2E5tzPTA==
X-Google-Smtp-Source: AGHT+IGLMYMcvq7FgOuv7NZ8he4Vn2DR++ElkPFM38fkihjTAen52Se+4+I+zeFNB7FVdS9rJ+bpJw==
X-Received: by 2002:a05:6402:40cd:b0:5d3:d4cf:feba with SMTP id 4fb4d7f45d1cf-5d43314d465mr45987a12.7.1733863739337;
        Tue, 10 Dec 2024 12:48:59 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d14c74c3d5sm8097292a12.52.2024.12.10.12.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2024 12:48:58 -0800 (PST)
Date: Tue, 10 Dec 2024 22:48:55 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	upstream@airoha.com
Subject: Re: [net-next PATCH v11 3/9] dt-bindings: net: dsa: Document support
 for Airoha AN8855 DSA Switch
Message-ID: <20241210204855.7pgvh74irualyxbn@skbuf>
References: <20241209134459.27110-1-ansuelsmth@gmail.com>
 <20241209134459.27110-4-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241209134459.27110-4-ansuelsmth@gmail.com>

On Mon, Dec 09, 2024 at 02:44:20PM +0100, Christian Marangi wrote:
> Document support for Airoha AN8855 5-port Gigabit Switch.
> 
> It does expose the 5 Internal PHYs on the MDIO bus and each port
> can access the Switch register space by configurting the PHY page.

typo: configuring
Also below.

> 
> Each internal PHY might require calibration with the fused EFUSE on
> the switch exposed by the Airoha AN8855 SoC NVMEM.

This paragraph should be irrelevant to the switch binding.

> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> ---
>  .../net/dsa/airoha,an8855-switch.yaml         | 105 ++++++++++++++++++
>  MAINTAINERS                                   |   1 +
>  2 files changed, 106 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> 
> diff --git a/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> new file mode 100644
> index 000000000000..63bcbebd6a29
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
> @@ -0,0 +1,105 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/net/dsa/airoha,an8855-switch.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Airoha AN8855 Gigabit Switch
> +
> +maintainers:
> +  - Christian Marangi <ansuelsmth@gmail.com>
> +
> +description: >
> +  Airoha AN8855 is a 5-port Gigabit Switch.
> +
> +  It does expose the 5 Internal PHYs on the MDIO bus and each port
> +  can access the Switch register space by configurting the PHY page.
> +
> +  Each internal PHY might require calibration with the fused EFUSE on
> +  the switch exposed by the Airoha AN8855 SoC NVMEM.
> +
> +$ref: dsa.yaml#
> +
> +properties:
> +  compatible:
> +    const: airoha,an8855-switch
> +
> +  reset-gpios:
> +    description:
> +      GPIO to be used to reset the whole device
> +    maxItems: 1

Since this affects the whole device, the SoC node (handled by the
MFD driver) should handle it. Otherwise you expose the code to weird
race conditions where one child MFD device resets the whole chip after
the other MFD children have probed, and this undoes their settings.

> +
> +  airoha,ext-surge:
> +    $ref: /schemas/types.yaml#/definitions/flag
> +    description:
> +      Calibrate the internal PHY with the calibration values stored in EFUSE
> +      for the r50Ohm values.

Doesn't seem that this pertains to the switch.

