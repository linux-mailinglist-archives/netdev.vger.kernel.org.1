Return-Path: <netdev+bounces-255708-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFLJOAU5gGlX4wIAu9opvQ
	(envelope-from <netdev+bounces-255708-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 06:41:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FEC5C856E
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 06:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4F475300828C
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 05:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA58E264FBD;
	Mon,  2 Feb 2026 05:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTeLgWnu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C0C1F94F
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 05:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770010881; cv=none; b=IFIupSc4ELdyGeM2CdO2AZNcNeEc6x5X49mHj8p+YRcZUbwbA/wnNYFdE3L4icF0tzjgqcbXmRsrJAV5OHn4aecLa+uzQ5bQRgPNxbZlhIWD/gKOJPNtSnxQ2UGid1Ow8ac1X/j1mfKAXNsYsJdzRrIF0l1LDLKvufvccnqRu2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770010881; c=relaxed/simple;
	bh=374fjqtyEdgVhwWsr2HpCJEGgFgY/9sUJ7ytMr818tY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r45Klwciz6uivUqjdhnI3McR8a0rusge1mWDuiOta/BpGoLxx+LZYz/mYr6uier2KxXkolkEVd048L+JHbshU4IpH+4kJFungOgDyLI7TdZF/ymVY8SvaQmOnIZOvoWcFptmPzGFTfh0xiQB4qWNHGnAqY/yWgHktNyBXPKP/Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTeLgWnu; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c5513f598c0so1659053a12.0
        for <netdev@vger.kernel.org>; Sun, 01 Feb 2026 21:41:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770010880; x=1770615680; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w/OodEpFjOF1QKMpfh/He7lSljXTwFAUK5yvvx1mDI8=;
        b=QTeLgWnu2AGrIkeTPzfC/TsxCMZ38dbbNuzLzu4rCNAW4JDbwWdfuR+0mHIA6bsB7W
         gsR4CTO/Y3gERnLkCGCmSs0yZ1sJldiGDDT+Yp2ZVlKPlqE0NKGWSM4zuCJm6Mib2TJO
         hw7yV5Dr4BoDumArNC9n0oPM1OU37ZCWcrzm2e7NCZrSVWPm1XX+ev1vbNO+tfOWP7Rg
         5qLqRg+jOOwlLtr6F2AEZw5DA53ZS3cmiuAiSeCGWd4XDI0fzNmO9zpXBTdXXfyB2Mq5
         ieZZlz6bdScIv0GhgrxgoAiABGxSskz6yeYbn5HsU3F803/O5TiryllzYmWWN8+JLL+m
         G36Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770010880; x=1770615680;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w/OodEpFjOF1QKMpfh/He7lSljXTwFAUK5yvvx1mDI8=;
        b=TfQ5Ztm++A6h2e1VZ1arTRNdcSPk9n8FpzMukdy8TFvIYPMHIwukjmq0PzL80bQGjt
         tRsQgPmTV/aUq5raoCc5Ds1NtHY4moFKwaZxjYke+XxBMK87kXcgIYbehoMn8TeIUqor
         zz+Yhmb0SVB8xONk3Dl7uC77kGjNbcASpFRAguPgtTJ8dZpDoV/84vSxrpm+Sf3kps2I
         QzhoO+TmUDkOPOPJpyHhBACx9lwUpJ2w1oD7Nrz/ZeUquRxV/k7joqIIlTsj/MsiYE1r
         1fgK8L+RLgc2FlqWEBEZDp0Iw/3ej/5T4+uFQ1ZP+/N7rEVLt/kyHLf+GPQmaGVgNMRV
         FS0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW6fpTHJDZEUz1OegHLO9VPrezoKcADiIxMzuf+ra9n915WbWoVq2oPD23SgsI5SJyd6et8iA8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw1AecZcxD1p/RFeH/w+Vx3ByeRRG5VdiysYWCAfJAClc+vCjA
	G++ErVrzS1jtjK4j17D7jayWvuZ/sTVorwE6HTedLitDvik7ic1VsnGt
X-Gm-Gg: AZuq6aJn9UWKZMQ4gws/MT8Iik1GRz0gzMuku9tZ8MFKVNrDGFMGeMqm++PuXKE/0ic
	DX+KltZzfJXFMtYGTZrKbAdBNwefzNrfQKFiqawsN6xxSUwTar88tju9tG3CGKNvmy6zBonyCtd
	nHJZGorFb9KoWNWyGZOcmkW6kz3+XMZOAOCd5iQ3mnduDquJObTFmjoZoUPUMCFuxzgO0iVG0+A
	WsE29KTVBpJGtHow93osYVamRUqu6FV8ub936OUP4XO3kqpr/aK9Fhv74Zpa/pUk8+HZctBUgiU
	jhPWMaU2qWzQ+tiAls3yMffO8byBp6daMvdF/5QhU1jVC6eyHtrWqE5Rwoz2SoZwFEABr2zfAjO
	dAWiJBlOXQOTUGWKJII1KoXE0/InsvKeRjreohjmK3vn5EbBw6MTH7U13X1gwEz5mQa9n/wcuNz
	1bmEOUe2rVS2vRLMDc6L7OzrB2OzK8OBSoaRmMWiSqnXI4vZWsDQoUh1mVHvwDE2Rh/kRWNyQAX
	cs=
X-Received: by 2002:a05:6a20:12d6:b0:351:2c6e:6246 with SMTP id adf61e73a8af0-392e0148042mr8658013637.56.1770010879891;
        Sun, 01 Feb 2026 21:41:19 -0800 (PST)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c64276efb16sm13296475a12.4.2026.02.01.21.41.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Feb 2026 21:41:19 -0800 (PST)
Message-ID: <217f7407-ede2-4be8-bbd8-f2e499170e24@gmail.com>
Date: Mon, 2 Feb 2026 13:41:13 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v10,3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for
 Nuvoton MA35 family
To: Jakub Kicinski <kuba@kernel.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org, ychuang3@nuvoton.com, andrew+netdev@lunn.ch,
 linux-stm32@st-md-mailman.stormreply.com, yclu4@nuvoton.com,
 pabeni@redhat.com, davem@davemloft.net, andrew@lunn.ch,
 peppe.cavallaro@st.com, joabreu@synopsys.com, linux-kernel@vger.kernel.org,
 conor+dt@kernel.org, richardcochran@gmail.com, krzk+dt@kernel.org,
 edumazet@google.com, robh@kernel.org, schung@nuvoton.com,
 netdev@vger.kernel.org, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com
References: <20260129054445.416242-4-a0987203069@gmail.com>
 <20260131015008.970729-1-kuba@kernel.org>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <20260131015008.970729-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255708-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lists.ozlabs.org,nuvoton.com,lunn.ch,st-md-mailman.stormreply.com,redhat.com,davemloft.net,st.com,synopsys.com,kernel.org,gmail.com,google.com,foss.st.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[23];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[a0987203069@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 5FEC5C856E
X-Rspamd-Action: no action


On 1/31/2026 9:50 AM, Jakub Kicinski wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: stmmac: dwmac-nuvoton: Add dwmac glue for Nuvoton MA35 family
>
> Adds Gigabit Ethernet support for Nuvoton MA35 series SoCs using
> the stmmac driver framework.
>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
>> --- /dev/null
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
> [ ... ]
>
>> +static struct nvt_priv_data *
>> +nvt_gmac_setup(struct platform_device *pdev, struct plat_stmmacenet_data *plat)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct nvt_priv_data *bsp_priv;
> [ ... ]
>
>> +	bsp_priv->regmap =
>> +		syscon_regmap_lookup_by_phandle_args(dev->of_node, "nuvoton,sys", 1, &macid);
>> +	if (IS_ERR(bsp_priv->regmap)) {
>> +		dev_err_probe(dev, PTR_ERR(bsp_priv->regmap), "Failed to get sys register\n");
>> +		return ERR_PTR(-ENODEV);
>                             ^^^^^^
>
> Should this propagate the actual error code from
> syscon_regmap_lookup_by_phandle_args() instead of always returning
> -ENODEV? If the syscon lookup returns -EPROBE_DEFER, this will lose
> that error code and prevent the driver from properly deferring its
> probe when dependencies aren't ready yet.
>
> Other dwmac drivers (dwmac-loongson1, dwmac-starfive, dwmac-sun8i) use
> something like:
>
>      return dev_err_probe(dev, PTR_ERR(regmap), "...\n");
>
> or
>
>      return PTR_ERR(regmap);
>
> to propagate the error.

Thanks for pointing this out. I'll fix it in the next revision.

Joey

>
>> +	}
> [ ... ]

