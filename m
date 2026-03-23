Return-Path: <netdev+bounces-270379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GG2UO+3ewGn6NQQAu9opvQ
	(envelope-from <netdev+bounces-270379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 07:34:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 990682ED1C2
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 07:34:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32EAA3007AE1
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 06:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CE731715A;
	Mon, 23 Mar 2026 06:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3VU6Z7A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416E31619A
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 06:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774247474; cv=none; b=WieF9PsuwKw4SdI95xa1ZMMme9KDhppkXu/fMqs3vnon2u6ASWY4vOW0RXArwlfOCtMeqblPBf+MVqCbp+1tRaW0AKba/kG1X7vdMlnAzW1B4ZN7LKBOpeSp/pvcXqAe548nppYv0IIR7DMWqzM9HeWyqnL13DZO3jKlK7TnoLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774247474; c=relaxed/simple;
	bh=dvhEk3O+a2ERwLtOA0cX9p85UC+OOoWreUsEp4G31h4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b0ULM5RHvDuPKe1HCkj7CPeLQrfyhL84ox9xTz2j1oz4KWj0aKV4PNei+teeVZbOc02iDNi7bGHlCkbHq2ikmySKcyfTzBE58M+sqBjvz0ogo+phuDT1ICAsdBKdvqZ13ljgqIC+mv68WKcZiRz6EKr6IIsZhr0qgW9MfHiuQgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3VU6Z7A; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c739d32b72cso2799074a12.2
        for <netdev@vger.kernel.org>; Sun, 22 Mar 2026 23:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774247470; x=1774852270; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+uJOOsx893BHAo1XKwzCoPb5W2B/EQDBZpSJL6AVlTw=;
        b=U3VU6Z7AH8eqwIs3UJ9Xyv7pq07tCbNbdiNXaGZAV9u8U3iWGPGAOT5Pn4DcNShVMc
         TOivh6o9lKZfqOqzMyVickPdAh9uGWWqwgRLI6Mf5K1y8StPp5L5QdeYGDXXIQI3cKf8
         rFeGngvv4f7uDOAkJfDvPnHZS867bLPi1hezbezUnd+t7D6s3gRDfYBnPAWhCmh59l8U
         xoIyB67zx+EGXMOvVVzOovwGoZnS3LPEjlyEGoW4qKc0rW4f35vJazOL8zIzRcfVA8WC
         +zTXJcYrNfNLqQc8Z6/avayID7hSUD5nDmOXjmBZrES3GvEi1RXOw/1lm4r9CZW9eoNI
         4mPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774247470; x=1774852270;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+uJOOsx893BHAo1XKwzCoPb5W2B/EQDBZpSJL6AVlTw=;
        b=mBwcl4wW1plAuTIkvlGYjs/pbMQUPNOFwaQcf3dS2BPmVkOrGIpKR/kvGn4yMt3NDd
         RjrAbQqwizllXLSqbOc+27Jhlf7YCksnz1gg0ds8cZqvsZia6VStxYYElec/3a6ExKzV
         l/rOfVFVt4u39VBhHFnTWcadKXTN0+rTBGHKcQ5OO1uYpWbxBYe21LKZOe0FLgMUEs11
         pb06gNCcJQZsos+fRIl8/mrhuFNXj+s+zrPeUH5CR+IbHNjQnymgrWqkhm12k9+hYCdS
         VrQLcoiKNFdiNF8pnar4SxBrOGkbBpHBsRBbO+4ATmmg4t6h/ERj7PNZLrjlpqw8u7nj
         fsBw==
X-Forwarded-Encrypted: i=1; AJvYcCXBHZ08Xi2OLg3/txSgueH2oCzbqTtNJSm2O8mMCTISRKxibNoTXNYz5tsPB0pgU021rJJtemk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYUkucJPucP+GbIakuZeIZ2b6dhp/zZs0Z0KD5Auih4MYL61u9
	+X21hiq2W0UsCPLuGjaQ8WFq1df0AVIIYf467nYuMAFPQ7wiLyqdf6uI
X-Gm-Gg: ATEYQzzD6sLXY1AW1JO+CTKn7bnRFw0nB9A/Ev0/GmoKgbOZbsHPDnzm9FoaM4bqrBg
	dO/C5G2DAKVcs2m9aqeoPolw1oFyZcqBLCzTKTlY/nouL7AgPpWccaTpuQLJKAddjecud/a641r
	SZMqoeKMl0ExO/JEvSFOGPxZrzVNOoZnpzMDX1zVxSqMreoIMYaRYaJT/RSyH+LSeE0FASvrFyn
	Srf5rs0gOT3vMGzo9OIYMy/MJDpijPAxZmijNvlyEEp/5LFjPEdmYjgnv9e0FK1/uT6YW2MX59Q
	zfh4FpXzsw2LP1OgM6O1JKyNacJ0OJ4+sY6BHVO2krXc/TvYUcXaaegOcIMz8tngvE6tImo7Dgh
	COEhPkhd45fHZZ6tsrxZnrUVers4I/8vyq0exxTGIWTE+BZ19apvG4cqzvuHEzkbB2BoNHRNHJV
	PAS36PaJkJl6cxmiWdmcXD1rEaw4VGEWWbw3+ykFaJ7dkeGvOewty6ZEiqAiK3O9xUDvznbn9ya
	i2/
X-Received: by 2002:a05:6a20:7f82:b0:398:919a:ddf5 with SMTP id adf61e73a8af0-39bce9e9efemr10260089637.24.1774247470439;
        Sun, 22 Mar 2026 23:31:10 -0700 (PDT)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c743a938743sm6476741a12.19.2026.03.22.23.31.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Mar 2026 23:31:09 -0700 (PDT)
Message-ID: <e381ce59-c13d-4cb4-b0d3-70f15a500999@gmail.com>
Date: Mon, 23 Mar 2026 14:31:05 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v14,3/3] net: stmmac: dwmac-nuvoton: Add dwmac glue for
 Nuvoton MA35 family
To: Simon Horman <horms@kernel.org>
Cc: richardcochran@gmail.com, devicetree@vger.kernel.org,
 edumazet@google.com, linux-stm32@st-md-mailman.stormreply.com,
 joabreu@synopsys.com, linux-kernel@vger.kernel.org, krzk+dt@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 netdev@vger.kernel.org, conor+dt@kernel.org, schung@nuvoton.com,
 linux-arm-kernel@lists.infradead.org, davem@davemloft.net, robh@kernel.org,
 yclu4@nuvoton.com, andrew@lunn.ch, mcoquelin.stm32@gmail.com,
 ychuang3@nuvoton.com, openbmc@lists.ozlabs.org, peppe.cavallaro@st.com,
 alexandre.torgue@foss.st.com
References: <20260316055427.1310569-4-a0987203069@gmail.com>
 <20260318082346.1825390-1-horms@kernel.org>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <20260318082346.1825390-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270379-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,google.com,st-md-mailman.stormreply.com,synopsys.com,kernel.org,redhat.com,lunn.ch,nuvoton.com,lists.infradead.org,davemloft.net,lists.ozlabs.org,st.com,foss.st.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 990682ED1C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 3/18/2026 4:23 PM, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
>
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> net: stmmac: dwmac-nuvoton: Add dwmac glue for Nuvoton MA35 family
>
> Add support for Gigabit Ethernet on Nuvoton MA35 series using dwmac
> driver.
>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig b/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
>> +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> [ ... ]
>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
>> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
>> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> [ ... ]
>
>> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
>> --- /dev/null
>> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-nuvoton.c
>> @@ -0,0 +1,136 @@
> [ ... ]
>
>> +static int nvt_gmac_probe(struct platform_device *pdev)
>> +{
>> +	struct plat_stmmacenet_data *plat_dat;
>> +	struct stmmac_resources stmmac_res;
>> +	struct device *dev = &pdev->dev;
>> +	struct nvt_priv_data *priv;
>> +	int ret;
>> +
>> +	ret = stmmac_get_platform_resources(pdev, &stmmac_res);
>> +	if (ret)
>> +		return dev_err_probe(dev, ret, "Failed to get platform resources\n");
>> +
>> +	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
>> +	if (IS_ERR(plat_dat))
>> +		return dev_err_probe(dev, PTR_ERR(plat_dat), "Failed to get platform data\n");
>> +
>> +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
>> +	if (!priv)
>> +		return dev_err_probe(dev, -ENOMEM, "Failed to allocate private data\n");
>> +
>> +	priv->regmap = syscon_regmap_lookup_by_phandle_args(dev->of_node, "nuvoton,sys",
>> +							    1, &priv->macid);
>> +	if (IS_ERR(priv->regmap))
>> +		ret = dev_err_probe(dev, PTR_ERR(priv->regmap), "Failed to get sys register\n");
>> +
>> +	if (priv->macid > 1)
>> +		ret = dev_err_probe(dev, -EINVAL, "Invalid sys arguments\n");
>>                                                                                    ^^^^
> Does this code return the error on failure? The dev_err_probe() result is
> assigned to ret but the function continues execution without returning.
>
> Russell King's v12 review suggested using set_phy_intf_sel callback,
> which led to significant refactoring in v12. This refactoring appears to
> have inadvertently broken the error handling here and below.
>
> The code should be:
> 	if (IS_ERR(priv->regmap))
> 		return dev_err_probe(dev, PTR_ERR(priv->regmap), "Failed to get sys register\n");
>
> 	if (priv->macid > 1)
> 		return dev_err_probe(dev, -EINVAL, "Invalid sys arguments\n");
>
> See Russell's v12 review:
> https://lore.kernel.org/netdev/aYsurPBMnzWDZCco@shell.armlinux.org.uk/

Sorry for missing that, I'll fix it so that function properly returns 
failure.

Joey

>
>> +
>> +	plat_dat->bsp_priv = priv;
>> +	plat_dat->set_phy_intf_sel = nvt_set_phy_intf_sel;
>> +
>> +	return stmmac_pltfr_probe(pdev, plat_dat, &stmmac_res);
>> +}
> [ ... ]

