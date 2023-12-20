Return-Path: <netdev+bounces-59238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8271981A038
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 14:48:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 842791C229A1
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 13:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923953529C;
	Wed, 20 Dec 2023 13:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="qxxP/xo7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AC7F36AFC
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 13:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yb1-f199.google.com (mail-yb1-f199.google.com [209.85.219.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id AABFC3F2C3
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 13:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1703080106;
	bh=cLKk4FLFKZPRJCthkwAAXukNGNTHJtGoc9bArlIgi7E=;
	h=From:In-Reply-To:References:Mime-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=qxxP/xo7cvOnM1juZZr26+NntHIMVegsp4Wq31JF5Tu8muRM8t5aG9NOB8T1pMvEK
	 70u6nh/3MeyurL9bqrQbdxzV/+XFI9z8S1Mhw+HwCaiz+zj6B2yp/gIFvbJEz9Ml23
	 pZaYcYU4+9gXsSYACFm3gCZPmZWiMNtuHTVy4fKWHYjvfVzs5+oenAmGXdpxseKw81
	 WHt67g/tCXIR8KXG/bS0q4wgeHMCY9iZXPbVC1i+Yrnl2rCziTNbdb9D80O0mTn6Ch
	 zMX2I8YtEG06yxXBxIrRy0VvGWEmkGVKqsz2jesbjg3P1AccwZiRdiSRseGBKvPlx6
	 YfYow+OdLG55w==
Received: by mail-yb1-f199.google.com with SMTP id 3f1490d57ef6-dbdae92c10aso650093276.1
        for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 05:48:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703080106; x=1703684906;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cLKk4FLFKZPRJCthkwAAXukNGNTHJtGoc9bArlIgi7E=;
        b=JKXrJi9hfXSuDPp8jZVSM/A6cdkVQZXhQ/aNLlCUEsN7XZ+QjbB3pDaGArG+aE+N3B
         6mMbtxPpf5rKonW8K7atIIRiSWhMjmMUsjaqz4gdrVFqprOEPJqD1QvPKY8AGy2qGjKI
         jvwledd3kZDas7V/tN+nPn8zGi5/xhuaOJ8Mo+uIYVUi7TEb1prSdXR45Ha5/u2jXnFU
         FNR4/qtAJ65sBT1c3TSXgbqMdmb3u21EbIkTJYj2ibn/ZV4LDyW3LjIPgbg2eXQOC44h
         pTfrl7D4x9zXyKnhsy99i8bLG5mIn/gpVnxkG37PYXwmPvs3kX6kDSzj2ujuW4NAZscn
         R99A==
X-Gm-Message-State: AOJu0YwdzwWH3tVdw11b+peo+R6ex8Dn0alO7jwqUSL9fEwgIX4TovKa
	F+ieZlWO1HiOsBLEFLiKqZ+hIu9yuwMwe4BznQXlASEJOAInlrgrwNkm3nWSGx7+TrPui61BGYK
	R/FEHTS3FVtL2ByCRLwS9XZEkDwic6dvk8LApRe5NQXE2S4SxfA==
X-Received: by 2002:a25:903:0:b0:dbc:dbc2:16bd with SMTP id 3-20020a250903000000b00dbcdbc216bdmr7636398ybj.62.1703080105363;
        Wed, 20 Dec 2023 05:48:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGAc0XaKPCbNpSMKwITz2F/kdmz4jNbuavgxZb/kvZBD55MIEy+1R3WMm9C61a7/L2w9ih86rzWOb3+xyezKOI=
X-Received: by 2002:a25:903:0:b0:dbc:dbc2:16bd with SMTP id
 3-20020a250903000000b00dbcdbc216bdmr7636383ybj.62.1703080105113; Wed, 20 Dec
 2023 05:48:25 -0800 (PST)
Received: from 348282803490 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Dec 2023 05:48:24 -0800
From: Emil Renner Berthing <emil.renner.berthing@canonical.com>
In-Reply-To: <20231220004638.2463643-5-cristian.ciocaltea@collabora.com>
References: <20231220004638.2463643-1-cristian.ciocaltea@collabora.com> <20231220004638.2463643-5-cristian.ciocaltea@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 20 Dec 2023 05:48:24 -0800
Message-ID: <CAJM55Z-+2RY+owdd9YJM_CihKqDtAgykSDZN0tLZAGRTRGQhBA@mail.gmail.com>
Subject: Re: [PATCH v5 4/4] riscv: dts: starfive: beaglev-starlight: Setup phy
 reset gpio
To: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>, 
	Emil Renner Berthing <kernel@esmil.dk>, Conor Dooley <conor@kernel.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Richard Cochran <richardcochran@gmail.com>, 
	Andrew Lunn <andrew@lunn.ch>, Jacob Keller <jacob.e.keller@intel.com>
Cc: linux-riscv@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kernel@collabora.com, 
	Emil Renner Berthing <emil.renner.berthing@canonical.com>
Content-Type: text/plain; charset="UTF-8"

Cristian Ciocaltea wrote:
> The BeagleV Starlight SBC uses a Microchip KSZ9031RNXCA PHY supporting
> RGMII-ID which doesn't require any particular setup, other than defining
> a reset gpio, as opposed to VisionFive V1 for which the RX internal
> delay had to be adjusted.
>
> Co-developed-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Emil Renner Berthing <emil.renner.berthing@canonical.com>
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> ---
>  .../boot/dts/starfive/jh7100-beaglev-starlight.dts    | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> index 7cda3a89020a..b79426935bfd 100644
> --- a/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> +++ b/arch/riscv/boot/dts/starfive/jh7100-beaglev-starlight.dts
> @@ -11,3 +11,14 @@ / {
>  	model = "BeagleV Starlight Beta";
>  	compatible = "beagle,beaglev-starlight-jh7100-r0", "starfive,jh7100";
>  };
> +
> +&mdio {
> +	phy: ethernet-phy@7 {
> +		reg = <7>;
> +		reset-gpios = <&gpio 63 GPIO_ACTIVE_LOW>;
> +	};
> +};
> +
> +&gmac {
> +	phy-handle = <&phy>;
> +};

..and here.

