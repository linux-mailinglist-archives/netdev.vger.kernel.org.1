Return-Path: <netdev+bounces-177901-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA69A72B2A
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 09:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B30F16DA8F
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 08:13:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3091FFC4E;
	Thu, 27 Mar 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="eKkfVi6F"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0271C1FF7D6
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 08:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743063226; cv=none; b=YWEWl8S6lli1/+EXHV+a5krtfPloRZoqS7l7CysLy0lAzyOKNOvq4EfCaFkBDsSIA4al1qzh6B+qIfyxhMzYzDC5eX69v8O2fEkd/HceimHOQixTdR7CUqjMGkWMsx/RgVpAuEnpMnX2pph1XuC5z5hSX3nv+jbeDGme/579LI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743063226; c=relaxed/simple;
	bh=bTCIQbZfb43JnsDod1rtfij5pP9d9sm1SFgzMjOAryU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lkl+pweqL91x5Zhv1sQKiGk9Fvebk/Sy/aWOJsRkFaq/W60yMkMQ95EdTlv603HJY/6uh53Tn9dQeC/VY8KjAOTcz+pQD37OVX0WK3+1/cJs3DuhWh2lQLMdOZ1GiBYdrWFhl69NVOm4FXOD5i7JVPExuhGoQ4BCNJDa6EBIDag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=eKkfVi6F; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-3913fdd003bso331392f8f.1
        for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 01:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1743063223; x=1743668023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jz00sfAr3h8cNxbqkgl+Nkm67OZ8eaKlmd2X1ZA3QeM=;
        b=eKkfVi6FIHybAbye3vivpv7F5qJh6/WlpVeI1g7ZQZMsHBfrTlrSKzEUSHO1+53gxi
         5QakzQOla++hMT3utMCBUlBEqkld4DLKDw1/qmRN2/NDC2TxjA7eRx9yPhV1PmtYb+1S
         +4UfmLSq1mSixxdmV2KVBVBZUaQ8WuP1OUUnftM/Cug/6eVLQveJXLIFLKjuFxUWji3R
         oFeIftQO0WUB8RIrMQNbBR11TZ7kUzaOXjoMzi7C7XMl1zjazr7dUkYmF64Ibv/mtEJ+
         Y+0+vCVFHFUxB4H8b/Xvm04q3OMP+cu70Bp7XTDejyVW/K0CYapDrqPmQ0uVS0B5Uw1t
         p8Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743063223; x=1743668023;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jz00sfAr3h8cNxbqkgl+Nkm67OZ8eaKlmd2X1ZA3QeM=;
        b=ogqWhDC8zhrfsBn6+B4HFqV4sBRXo5AtrXLp8G05Wip9mTKASzqvXGBi9zIzy4cpDP
         bHw4xUsSP/QShFbB0QZvljtIm1KMDL1kySubXep6l6NoGyHkdt2ALOrseNMoXsbxdQR6
         4sTwNrN7EJtxsmeNMMrcFogULUrLMtK/05flqaKX0MisMrgrgyjJ6zUQEqEWrXHzvhzM
         ReJkvJc7EWTDY6qK5DzWSqlVBlHmLSPrlRDeHMRKKUy0KQX+TsMJWS2H/3C8TMJkh8NE
         4jol4Ck74xgcrmp4U0K5CaBgJrVRTm868myLcjdLWOE9Gy+aMY53CPEMG9ZURWWxIy93
         PzcQ==
X-Gm-Message-State: AOJu0YySDsMbnYxv+GYcbXCdTJ6TsYd+Ab3kkR43zu5tPbA25UjJVGwN
	7iV9YmahptTNV941yWrccSY1kYogEWICd6YBJxYwtJx8gzBjbhdx0FjTWqLggAc=
X-Gm-Gg: ASbGncvIemHM0LEnmdoYP3P76ZdSBZIeSWh7TCwCbzkHUis0gpACJf9CF5s+IwADPEM
	9rTbd4N5ZX9YbvygZHBsrIvzrVxguwGvolDis0QGxdYKZhFjNnZ510z0v4KZ/h2nJtrgsV8zk5D
	mJmNnFqHqq5ilrv5AWPVtvwttIit7goJ9iLS9NtWY18W/MxeyJzgfXVL/rMW0CB+MC/dIuQxoOz
	yp7hHmTX19K8M/sdnAYKi7AVGkzvKtfSZNne20nQwmdJpSQRo/dBnK0//ac3LLrgInHYxBQ3OML
	3sLaDcchdiNyN2Sq1CLt992Icu+6Ftd5OLUFBuzX96oYRVxVCGmPGg==
X-Google-Smtp-Source: AGHT+IHaGU7k1A9qg1y23ZMz5cgJ0D4Cu+DVQXIKfTtvPKv7hvhNHKkbv6hFjGYgP2YHKA+NqagcPQ==
X-Received: by 2002:a5d:64a9:0:b0:39a:c6d1:c343 with SMTP id ffacd0b85a97d-39acc44f0aemr5163077f8f.10.1743063223009;
        Thu, 27 Mar 2025 01:13:43 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e65besm19397452f8f.65.2025.03.27.01.13.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Mar 2025 01:13:42 -0700 (PDT)
Message-ID: <d47e7da3-4b84-4688-a1f1-8019383a3e48@tuxon.dev>
Date: Thu, 27 Mar 2025 10:13:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/13] net: macb: Add "mobileye,eyeq5-gem"
 compatible
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alex@ghiti.fr>, Samuel Holland <samuel.holland@sifive.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Russell King <linux@armlinux.org.uk>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-mips@vger.kernel.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>
References: <20250321-macb-v1-0-537b7e37971d@bootlin.com>
 <20250321-macb-v1-10-537b7e37971d@bootlin.com>
 <ea5de004-a26c-43a1-9408-0089fa18b44d@tuxon.dev>
 <D8PITUNTWTXA.366TNSXDUL48G@bootlin.com>
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
Content-Language: en-US
In-Reply-To: <D8PITUNTWTXA.366TNSXDUL48G@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi, Theo,

On 25.03.2025 19:25, Théo Lebrun wrote:
>>> +	}
>>> +
>>> +	regmap_read(regmap, gp, &reg);
>>> +	reg &= ~EYEQ5_OLB_GP_RGMII_DRV;
>>> +	if (phy_interface_mode_is_rgmii(bp->phy_interface))
>>> +		reg |= FIELD_PREP(EYEQ5_OLB_GP_RGMII_DRV, 0x9);
>>> +	reg |= EYEQ5_OLB_GP_TX_SWRST_DIS | EYEQ5_OLB_GP_TX_M_CLKE;
>>> +	reg |= EYEQ5_OLB_GP_SYS_SWRST_DIS | EYEQ5_OLB_GP_SYS_M_CLKE;
>>> +	regmap_write(regmap, gp, reg);
>> To me it looks like this code could be abstracted as a phy driver. E.g.,
>> check the init_reset_optional() and its usage on "cdns,zynqmp-gem" (phy
>> driver here: drivers/phy/xilinx/phy-zynqmp.c).
> I thought about that question. Options to implement that sequence are:
> 
>  - (1) Implement a separate PHY driver, what you are proposing. I just
>    made a prototype branch to see what it'd look like. Nothing too
>    surprising; mostly the above sequence is copy-pasted inside
>    phy_init|power_on(). I see two issues:
> 
>     - First, a practical one. This adds a lot of boilerplate for no
>       obvious benefit compared to a raw registers read/write sequence
>       inside macb_config->init().

The macb is used by various platforms. If the settings proposed in this
patch (platform specific AFAICT) could be abstracted and used with generic
APIs I think would be better this way.

> 
>       The main reason for that boilerplate is to allow reuse of a PHY
>       across MACs;

And/or avoid having platform specific code in the macb driver.

> here we already know that cannot be useful because
>       the EyeQ5 has two GEMs and nothing else. Those registers are
>       EyeQ5-specific.
> 
>     - Second, a semantic one. The registers we are touching are *not*
>       the PHY's registers. They are configuring the PHY's integration:
>       its input PLL, resets, etc.
> 
>  - (2) Second, taking into account that what we are configuring isn't
>    the PHY itself but its resources, we could try modeling each
>    individual register+field as a reset / clock / pin control (there is
>    some drive strength in here, *I think*). Issue: this would get
>    messy, fast.
>     - A single register would expose many resources.
>     - The sequence in macb_config->init() would need to be the exact
>       same order. IE we can't abstract much.
> 
>    Something like this pseudocode (which is a bad idea, we'd all agree
>    here):
> 
>       reset_deassert(bp->eq5_sgmii_reset);
>       reset_deassert(bp->eq5_sgmii_reset_pwr);
>       reset_deassert(bp->eq5_phy_reset_tx);
>       reset_deassert(bp->eq5_phy_reset_sys);
> 
>       if (bp->phy_interface == PHY_INTERFACE_MODE_SGMII) {
>          pinctrl_select_state(bp->eq5_phy_input_pinctrl, bp->eq5_pins_sgmii);
> 
>          reset_deassert(bp->eq5_sgmii_reset);
>          clk_prepare_enable(bp->eq5_sgmii_phy_input_pll);
> 
>          reset_deassert(bp->eq5_sgmii_reset_pwr);
>       } else {
>          pinctrl_select_state(bp->eq5_pinctrl, bp->eq5_pins_rgmii);
>       }
> 
>       reset_deassert(bp->eq5_phy_reset_tx);
>       reset_deassert(bp->eq5_phy_reset_sys);
>       clk_prepare_enable(bp->eq5_phy_mclk_tx);
>       clk_prepare_enable(bp->eq5_phy_mclk_sys);

This looks complicated to me.

> 
>  - (3) Keep the sequence in macb_config->init(). Plain and simple.
>     - Issue: it is somewhat unrelated platform-specific code that's
>       present inside macb_main.c.

For maintainability I would prefer to avoid this.

> 
> The two serious options are (1) and (3).
> (1) is what you proposed and (3) is what's in the series.

I prefer (1) if it can be done.

Thank you,
Claudiu


