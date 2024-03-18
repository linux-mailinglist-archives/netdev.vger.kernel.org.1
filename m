Return-Path: <netdev+bounces-80299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A89087E425
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 08:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208EF280E06
	for <lists+netdev@lfdr.de>; Mon, 18 Mar 2024 07:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5007222EFB;
	Mon, 18 Mar 2024 07:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sOgJdyBA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2DA2263E
	for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 07:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710747382; cv=none; b=P5qyiFvhA7348d3ubt9D42qUqReQxUhirGrIHDeLCv7sYWusDVBPqAVVfyME51PrPFCuEhBsv2n3l+AwrJYrrXVXKZXCy5kpR/vBv6TMMKhrQWMR2W068ECpNnqmzu+V6ClAW9PMD6HQiyT3nQs/hK0/BNljVSnYh6nl7xvWK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710747382; c=relaxed/simple;
	bh=Md4o0qJ8lUko0AhbWk3KKm+2tQIMSvfoWRAOIoEfCaY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BKIpDc6tOphWs/SaOek7CFsGdzHSMGBmydPSLXcfIqpHQLQ9tX5CcY5/cSq7yp5ptKbsQ+V5Dkd+R5WtymP/kHTWBU8Xm6II9Iyx/jK28iAjUpu/qV62OqdPtdqNbldZt1idQcBFnH9kqX6mYOq9Hq2LdddDoKOLbBxna+aJiW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sOgJdyBA; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-568aa3096e9so4572409a12.0
        for <netdev@vger.kernel.org>; Mon, 18 Mar 2024 00:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710747379; x=1711352179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MfjiiYYXEp81SaS6PQp9hkSFCb7c2xr3ZnLROIncV98=;
        b=sOgJdyBAACMaK75J9W9Q3OCPAFW42XIZtWxDvgXocYUrLNyk3rR9xkEvgVRcxbtllG
         L1PaEnhLCN8eWlo9i1w72ZwyV0mgDBjiaLMKkL0GjN/1mS8VT/4xizOwdJ4vMJBvnR1Z
         V5BYKF+b2lF2bFnmoo4CqDUD9h9nBHKIUcbcokQ91mEHMB17SVcP/19DFYTH1pHondpB
         8yKoL8rQZHmNl+m/NVREQ4b4oGuqieTrRZgZmnLhYcW9JRas29JUe1RPBfDVcG9kVc85
         yY6Kyw6K4nnmKe9lw+tNq9sfE0ngdGvQZsW9Q9OmihxJqH28kpN6TjsWoeKwZK2Lm32r
         AHmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710747379; x=1711352179;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MfjiiYYXEp81SaS6PQp9hkSFCb7c2xr3ZnLROIncV98=;
        b=NgnH+7NXrSEqEaqIdIypIjemDe5CKUywcm1ozbL5clzk6wzMnDYpJ46VSK+mtP60zg
         1PV5Pgk9yBVeG9jOxQkbHRCVw3M5NOebmiXSKEuU2IQTPoPyQlCnTOGxp0b7UyzQhqjZ
         y7hpVhkZmxU931mGhU+g59Da2v+j8oWqd4y+rP5fYkHNA9IqoACtKvaUKfdfF2qVDb7C
         9t6PTnCw6+uUS5lMcgsP9oATmdsLrzKgCruTPMTv292z09+YPy93OclDkqgUdLlr3Wm7
         k0IB7tSQgb2oem5vuTKyHSLyiQyzJdaeUhTskynDDrgzRYfHADPT5quksisokbhVd1UZ
         yzig==
X-Forwarded-Encrypted: i=1; AJvYcCWR4VWzeMfXwtnMJg7coEeSU7+X6DJcsLiLFUYY7nUM/OaIZcFVimhiHqPY3DC79vtZMBrnoNJX7FpPAoX5uSPnaf8bWCbU
X-Gm-Message-State: AOJu0YyNdetkY7MwOIpSyVRfsITaCEH/f77V1wAj3fImGw5RxJbyiTuW
	DTZUbeBsYFwKSedzjla6Omj1yNFXlhX+uwiCZsvS+ptv05i4pt8bmWuWyq3+0Lo=
X-Google-Smtp-Source: AGHT+IEa+fkX+R3HtaY5jARiu8UhuzhoenRKPwtRIcYIVNLvMrDRbi+IkiMFsyIULGGxUp9hdlv9Jw==
X-Received: by 2002:a17:907:3e8a:b0:a46:3d7d:35c with SMTP id hs10-20020a1709073e8a00b00a463d7d035cmr16103686ejc.30.1710747378886;
        Mon, 18 Mar 2024 00:36:18 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id hj11-20020a170906874b00b00a46a04d7daesm2589682ejb.115.2024.03.18.00.36.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 00:36:18 -0700 (PDT)
Message-ID: <c8a6d671-8391-440f-b4da-28eaf1a68b73@linaro.org>
Date: Mon, 18 Mar 2024 08:36:14 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] arm64: dts: S32G3: Introduce device tree for
 S32G-VNP-RDB3
To: Wadim Mueller <wafgo01@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 Chester Lin <chester62515@gmail.com>, =?UTF-8?Q?Andreas_F=C3=A4rber?=
 <afaerber@suse.de>, Matthias Brugger <mbrugger@suse.com>,
 NXP S32 Linux Team <s32@nxp.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Jose Abreu <joabreu@synopsys.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Richard Cochran <richardcochran@gmail.com>,
 Simon Horman <horms@kernel.org>, Andrew Halaney <ahalaney@redhat.com>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Johannes Zink <j.zink@pengutronix.de>, Shenwei Wang <shenwei.wang@nxp.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Swee Leong Ching <leong.ching.swee@intel.com>,
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, linux-clk@vger.kernel.org
References: <20240315222754.22366-1-wafgo01@gmail.com>
 <20240315222754.22366-2-wafgo01@gmail.com>
 <cc55daa1-0256-48d1-97a4-0f755fb4951b@linaro.org>
 <20240317231000.GA22886@bhlegrsu.conti.de>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240317231000.GA22886@bhlegrsu.conti.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/03/2024 00:10, Wadim Mueller wrote:
>>> +
>>> +			mtl_tx_setup_gmac0: tx-queues-config {
>>> +				snps,tx-queues-to-use = <5>;
>>> +				#address-cells = <1>;
>>> +				#size-cells = <0>;
>>> +
>>> +				queue@0 {};
>>> +				queue@1 {};
>>> +				queue@2 {};
>>> +				queue@3 {};
>>> +				queue@4 {};
>>> +			};
>>> +
>>> +			gmac0_mdio: mdio0 {
>>
>> mdio?
>>
> 
> Can you please explain what the problem with mdio is? Is it the label?
> 

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation


Best regards,
Krzysztof


