Return-Path: <netdev+bounces-147563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED609DA37F
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 09:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E1C5BB21AD7
	for <lists+netdev@lfdr.de>; Wed, 27 Nov 2024 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9ADC170A11;
	Wed, 27 Nov 2024 08:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N4WzDgYV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481F1552F5;
	Wed, 27 Nov 2024 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732694623; cv=none; b=pxdKLiC1nqTXodBlHqJsdxga3lQRMrsKBUWM7OpvZQq2rRsiZ3XS0rqQ8WXtVhkrg3V+Taj+ClXwek7MO8oQhTOphIp7oLoG0pQGyCzqFUntrr87FFbf1QMXktIym0YOHqfO9jBpji4KkvWaDNYBHuNXuxmlD/LEaUg12AiaLoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732694623; c=relaxed/simple;
	bh=ZuMCJ5mITzsbd/8AutxnAljozboXdKYS7dWubDj/68s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LW1QpKXUnTJjUq8koi0PWyRD0jW7PwcZa4w/2aFB2dg99X6lLgCibHLSH0VUFNGVyCLUx3rbmUlwQgLLsE93/y1MyE00L49tW8bKAJWF942RWsNKmmEQO5YewCwF0QM5X+FAL1+rKuh9qKCGiUaB4qBNDoqkaCIlMc+IH8UPS0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N4WzDgYV; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ae3d7222d4so5296424a12.3;
        Wed, 27 Nov 2024 00:03:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732694621; x=1733299421; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HvstvQGGZWpwukBxOMgySPouyXZH3tEoacDeqR0VV4A=;
        b=N4WzDgYVcIi91eGX63Q2c+0x+HvvRw1NvoQKhekVA2mECkixG04XrzwS9CTmnbghII
         wZO+zDerVVeP9qR3xIgiIBUq6NZ6OjXE0r+ht8168ndfm1wkvCF+7CXvUssbW+HX5X9O
         DbvI5uFDvaICrIuAJe092WLhX51bu0PeCZm4zAUGNyNSQCiUQyfcjU0LpThtICFwb/x7
         HO0A52qTylwgS11Vd0ZaZZhUyNHGWDEutsWfJzj9sZW1Ss50BJX2X8HubpyWkun36qe6
         I5Q94SrZDSqhwCQt7mcrr5frPVRyP0q7OKNZC+v12MVWOha91mJ/0F0nD9zIQea4gEkk
         QQuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732694621; x=1733299421;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HvstvQGGZWpwukBxOMgySPouyXZH3tEoacDeqR0VV4A=;
        b=CGraWKg21atLVBSGfYkwscEqXfvMMludekdtnwmJSdRGHwZDOc8TzD3fuOo52Pn9Zv
         0oY4zSoJ2Rz4eHjw3Lom+gwX6umUTsuraTDHTrdEoqAWQqDZlzY+BpcgmOAW9n2OYPFC
         6Qfy6ZFhb8+ZX48fCwSZs6CB10kHwscQO9Cfm1FEp7ZSwAch17tc/kBb1XI8vo8xj8wl
         8hYUYjV0Af1LC7sPg5i9pQIqAcmIP001x+GROS1yyjEyeUYqVq/So3wdTsS47Hzrvexa
         RfFyLJ3oWKG6IHF8wqGuRNNlm3mloshQKbMtsElSrQCBxIpnff1vW66bsxgw/fZbFJ8b
         dclg==
X-Forwarded-Encrypted: i=1; AJvYcCVg8fguZobCTvemTqKo+y8zjVAWDK11FFmr0LhIfVLQdd7vf+65L0K1DeGxQItob/rsM7ALPllT@vger.kernel.org, AJvYcCXA+nufc+94PLXEyChm02odcJyQC9mCNh7cHKOnqFTedDI2QychbKq4MdPMkIHaSPzg8aeebydvGftx@vger.kernel.org, AJvYcCXx0TmoXZC7Kug24HuO6mJf7czFHPOd9vq23sLzvesxqpS5Oou77s4QCPikkxZv9SPkCHfw54oebe3X6zTB@vger.kernel.org
X-Gm-Message-State: AOJu0YynxKimK1cR7gvBSm2pGqKb9sbZ5YN5jGMrurc36nF5ZAGI47Nu
	+7blO2BHP4ciF/Vg6xrpWxqQ+Kxoe/Wvm4iofxkRTvdqyzIeaQZz
X-Gm-Gg: ASbGncvqXKzTFNJiH6FOr9xj1CCr8rWdA0JZF05VQEdUV4OTYfrFlxEUEjt1uNCNNfj
	X8FBGtnlT8zdOBFD7StTJWOcg23qrn+DMujHIO0MPCUSCGyWJXzJYgksk5rByHf6BZKFpCRICKu
	dBUHbGLdPWtGo7lfMqjXzC/Khu3L2e7nZ8MuhKNb4XaaV7jjenwSRCf3PnMbmOBBB7y+fIsgfjr
	iWFRnQlAyLH79SUkF4ZI7jLd5OlmRiiXTFq9T3iZ2sQ4F1DP+fyGrbMNifzaRgWFA0zAkLJhWW5
	Pm/ZBLmcmhJGvUluV6UMeTJdRaiO
X-Google-Smtp-Source: AGHT+IHRo3XtMbkGU/iUkrZZ9kDEO66Pm5yljji2WIQGTrvtOISCN9QXMkeyFyIaUUK12nAZ7FFb4Q==
X-Received: by 2002:a05:6a21:3288:b0:1e0:d380:fe61 with SMTP id adf61e73a8af0-1e0e0b9dbf6mr3148053637.45.1732694621422;
        Wed, 27 Nov 2024 00:03:41 -0800 (PST)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de531308sm9618017b3a.110.2024.11.27.00.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2024 00:03:40 -0800 (PST)
Message-ID: <fb61cf82-b14d-4f58-99bb-9677305a0aa6@gmail.com>
Date: Wed, 27 Nov 2024 16:03:36 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for
 Nuvoton MA35 family
To: Krzysztof Kozlowski <krzk@kernel.org>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 mcoquelin.stm32@gmail.com, richardcochran@gmail.com
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com
References: <20241118082707.8504-1-a0987203069@gmail.com>
 <20241118082707.8504-4-a0987203069@gmail.com>
 <7c132784-87db-44f9-8be4-a0805e438735@kernel.org>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <7c132784-87db-44f9-8be4-a0805e438735@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Krzysztof Kozlowski 於 11/26/2024 6:10 PM 寫道:
> On 18/11/2024 09:27, Joey Lu wrote:
>> +
>> +static struct nvt_priv_data *
>> +nuvoton_gmac_setup(struct platform_device *pdev, struct plat_stmmacenet_data *plat)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct nvt_priv_data *bsp_priv;
>> +	phy_interface_t phy_mode;
>> +	u32 tx_delay, rx_delay;
>> +	u32 macid, arg, reg;
>> +
>> +	bsp_priv = devm_kzalloc(dev, sizeof(*bsp_priv), GFP_KERNEL);
>> +	if (!bsp_priv)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	bsp_priv->regmap =
>> +		syscon_regmap_lookup_by_phandle_args(dev->of_node, "nuvoton,sys", 1, &macid);
>> +	if (IS_ERR(bsp_priv->regmap)) {
>> +		dev_err(dev, "Failed to get sys register\n");
> Syntax is: return dev_err_probe
I will use dev_err_probe instead.
>
>> +		return ERR_PTR(-ENODEV);
>> +	}
>> +	if (macid > 1) {
>> +		dev_err(dev, "Invalid sys arguments\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>
>
> ...
>
I will use dev_err_probe instead.
>> +
>> +	ret = stmmac_dvr_probe(&pdev->dev, plat_dat, &stmmac_res);
>> +	if (ret)
>> +		return ret;
>> +
>> +	/* We support WoL by magic packet, override pmt to make it work! */
>> +	plat_dat->pmt = 1;
>> +	dev_info(&pdev->dev, "Wake-Up On Lan supported\n");
>
> Drop, driver should be silent on success.
Got it.
>
>> +	device_set_wakeup_capable(&pdev->dev, 1);
>> +
>> +	return 0;
>> +}
>
>
> Best regards,
> Krzysztof

Thanks!

BR,

Joey


