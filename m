Return-Path: <netdev+bounces-257510-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mBoEHEC6hWmOFgQAu9opvQ
	(envelope-from <netdev+bounces-257510-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:54:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C721CFC43A
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:54:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6252B3035A84
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 09:53:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDAB63612F2;
	Fri,  6 Feb 2026 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A3N5V1lW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938E22FE56A
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 09:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770371629; cv=none; b=neUHFq6EWBc6QGZdtrkhIogqJBrAQs2NGSuOPBZLoCWx4Aql19W+gOkQ+scjbrbCVnjuIL1PgR/CB/bT4QaTTsreKIts6VB12n18cWU4eK9EoTSy/JnOPDoghwiJRLRX7PJ+weFVw9Nv9OvpWk/vxHlucIScJyLqQLMTora4N+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770371629; c=relaxed/simple;
	bh=lpZn52mSoKUXWbY9xwSEYV5pEcY0PzFHqFwrR06mULU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h9BgFXdtjmzhuqahgq4eYV2T83hmpEPZW0zGpdQ8i7AxXtN4OsGGIAnhPIcHJNYFeObfUHjVzhsHFty6xSSujHrQfeZFvAO3jGMzjuKs3c2cKjzQeO3RVw1+Aj/JOWwbquYNRfie/YdJJzji395EaPIfz8NnaXPOS/AFi7oIvuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A3N5V1lW; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2a947d01939so10303365ad.0
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 01:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770371629; x=1770976429; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qpEDLnYj95OpOlLlWla7+a1PBaolL4JOvRD2mY4U/kc=;
        b=A3N5V1lWQHyhRPbjPi8CzCqlRFpAo1NQDy4i1/t5TDchoGOE3p4yDn9TcjNTZhbmuE
         VYoVhqwC9PeopSklPA/76mPF19Vj/e0JVnxKrdssIxcPX14exmeo/idJx6YW5r4ehaGi
         r0iGFNez2vjzuWc7yur92nlyCNdzGG3UCeq451FIszW7gfsMLPDtw6HqsgnDo8xhRP5L
         4HVOL5huj66sp7I6EvtlVqm+zAPrtidKgAzsUSV93gDTPX2zSUxiKIUTPE6JnYPfDoYA
         VW8SnU5UHf68BgSnwZL0CHxJsUDCuxR6+j2dA2HB6+BiCiIelcyqPoXJwhWQpiu5/cSD
         BYwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770371629; x=1770976429;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qpEDLnYj95OpOlLlWla7+a1PBaolL4JOvRD2mY4U/kc=;
        b=tjXf1y/jqnMe/OXuio6f6thu9HUI8JSMUbKQ3Z3dXZHjRa8jxYkj1bIIjQ34pw1/v8
         n9zw7UQfQMfBPN2stXlZq2g52Bh2URt/uxYsWJmWMdoGiiTmMB1MI3vUj2km3v/afzpm
         oBmIbJ+Crh6egrq6f9Jb3HCQ0aFtsREgmR5msx2VvIGvD1Ax9QftNXwOzHsY869khR3H
         7NmbpP4DN4dbM8Jk2NQ2cHZMsZnOzBoZ4wHIIy5wXHBqvNGtWwcwo6DfLrGf/D0nq0Ab
         hsNDhhgUKAh9DHrLeUEDge1EXNXgdkS0eZQTwoRFmi9ZYYbveykaAdl1c0+vjtVO6CUJ
         v7eQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDwaB/ig8wNzhPX1Zie3jHYRbERj+CACCLoJUgXOgWWV0pSsv9KWb8lO+bGCerQxGwkZTUSZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZmOXFkVfvF60XtEygX3szpyYIOCdVsTwLnHyCINrlouyMYpW
	9aCH/s+FJ5GygF6bLNLoS+7p6YMgVZT8Kn7VyoyR6v48pWEZHBc0Hg61
X-Gm-Gg: AZuq6aLgqnlufVAwMdf4aeR1GvRQUWuXLFTl5k3cVpxik5KQXfaciOgf3XxRXPa8nw6
	wlfxl5pZSs3vTHH6puqKClQ9RdqZHJpOryeb3nXyg09eNXbLDKyP4u5clxe1a0C/a+Q/OZy97xk
	Lp2nq6XFbftzK6P++Q7hkdRLC6vtuvKZUwCAwOT3tsfmhkO/xzZ8PsT2Gl7slUQbsrYkqYEhpw5
	kWs0vCRYjCfs0lsJt8Wsfnl0fj5HLB19FXV/zQTdhuEpDARRVAD4u9LkvBTag3IJJJfYZe0CeR3
	w8elQ3xn3c0AY4XoSf4mVmXgrdfZXH+/OUif5a5I84lbZyjDLRzuzhT91yer6lOQN+ptK0Kp7uU
	e0c5++xBrFigVMLab8D9aD7BjPG5OrqhlVXo281bt5cLVyhO1tDqVP7+dJ76VFHq4iMA5r6Tzds
	5Ir+aPo5qjBAwPlKtNJHlgdkBSqm2C+YHy36M5298l+7Q9nSfpI3clcrOOYSONYBpn
X-Received: by 2002:a17:902:cf4c:b0:295:592f:94a3 with SMTP id d9443c01a7336-2a9519a19e0mr23066635ad.48.1770371628931;
        Fri, 06 Feb 2026 01:53:48 -0800 (PST)
Received: from [192.168.0.100] (60-250-196-139.hinet-ip.hinet.net. [60.250.196.139])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a9521b9761sm19141145ad.48.2026.02.06.01.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Feb 2026 01:53:48 -0800 (PST)
Message-ID: <4281a709-04a4-4b9f-b511-bff0a332f9bd@gmail.com>
Date: Fri, 6 Feb 2026 17:53:42 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 3/3] net: stmmac: dwmac-nuvoton: Add dwmac
 glue for Nuvoton MA35 family
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, mcoquelin.stm32@gmail.com, richardcochran@gmail.com,
 alexandre.torgue@foss.st.com, joabreu@synopsys.com, ychuang3@nuvoton.com,
 schung@nuvoton.com, yclu4@nuvoton.com, peppe.cavallaro@st.com,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 openbmc@lists.ozlabs.org, linux-stm32@st-md-mailman.stormreply.com,
 Andrew Lunn <andrew@lunn.ch>
References: <20260205014006.735408-1-a0987203069@gmail.com>
 <20260205014006.735408-4-a0987203069@gmail.com>
 <aYRlKk-cCIhqGWX7@shell.armlinux.org.uk>
Content-Language: en-US
From: Joey Lu <a0987203069@gmail.com>
In-Reply-To: <aYRlKk-cCIhqGWX7@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257510-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,synopsys.com,nuvoton.com,st.com,lists.infradead.org,vger.kernel.org,lists.ozlabs.org,st-md-mailman.stormreply.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[24];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C721CFC43A
X-Rspamd-Action: no action


On 2/5/2026 5:38 PM, Russell King (Oracle) wrote:
> Hi,
>
> On Thu, Feb 05, 2026 at 09:40:05AM +0800, Joey Lu wrote:
>> +
>> +struct nvt_priv_data {
>> +	struct platform_device *pdev;
> This looks to me like it's write-only, does it serve a useful purpose?
>
>> +	struct regmap *regmap;
> This doesn't seem to be used outside of nvt_gmac_setup().
>
>> +};
> Given the above two comments, do you actually need struct nvt_priv_data ?
You are right. I'll drop it in the next revision.
>
>> +
>> +static struct nvt_priv_data *
>> +nvt_gmac_setup(struct platform_device *pdev, struct plat_stmmacenet_data *plat)
>> +{
>> +	struct device *dev = &pdev->dev;
>> +	struct nvt_priv_data *bsp_priv;
>> +	phy_interface_t phy_mode;
>> +	u32 macid, arg, reg;
>> +	u32 tx_delay_step;
>> +	u32 rx_delay_step;
>> +	u32 miscr;
>> +
>> +	bsp_priv = devm_kzalloc(dev, sizeof(*bsp_priv), GFP_KERNEL);
>> +	if (!bsp_priv)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	bsp_priv->regmap =
>> +		syscon_regmap_lookup_by_phandle_args(dev->of_node, "nuvoton,sys", 1, &macid);
>> +	if (IS_ERR(bsp_priv->regmap))
>> +		return ERR_PTR(dev_err_probe(dev, PTR_ERR(bsp_priv->regmap),
>> +				     "Failed to get sys register\n"));
>> +	if (macid > 1) {
>> +		dev_err(dev, "Invalid sys arguments\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	if (of_property_read_u32(dev->of_node, "tx-internal-delay-ps", &arg)) {
>> +		tx_delay_step = 0;
>> +	} else {
>> +		if (arg <= 2000) {
>> +			tx_delay_step = (arg == 2000) ? 0xf : (arg / NVT_PATH_DELAY_STEP);
>> +			dev_dbg(dev, "Set Tx path delay to 0x%x\n", tx_delay_step);
>> +		} else {
>> +			dev_err(dev, "Invalid Tx path delay argument.\n");
>> +			return ERR_PTR(-EINVAL);
>> +		}
>> +	}
>> +	if (of_property_read_u32(dev->of_node, "rx-internal-delay-ps", &arg)) {
>> +		rx_delay_step = 0;
>> +	} else {
>> +		if (arg <= 2000) {
>> +			rx_delay_step = (arg == 2000) ? 0xf : (arg / NVT_PATH_DELAY_STEP);
>> +			dev_dbg(dev, "Set Rx path delay to 0x%x\n", rx_delay_step);
>> +		} else {
>> +			dev_err(dev, "Invalid Rx path delay argument.\n");
>> +			return ERR_PTR(-EINVAL);
>> +		}
>> +	}
> Each of these could be moved into a separate function:
>
> static int nvt_gmac_get_delay(struct device *dev, const char *property)
> {
> 	u32 arg;
>
> 	if (of_property_read_u32(dev->of_node, property, &arg))
> 		return 0;
>
> 	if (arg > 2000) {
> 		dev_err(dev, "Invalid %s argument.\n", property);
> 		return -EINVAL;
> 	}
>
> 	if (arg == 2000)
> 		return 15;
>
> 	return arg / NVT_PATH_DELAY_STEP;
> }
>
> then:
> 	int ret;
>
> 	ret = nvt_gmac_get_delay(dev, "tx-internal-delay-ps");
> 	if (ret < 0)
> 		return ERR_PTR(ret);
>
> 	tx_delay = ret;
>
> 	ret = nvt_gmac_get_delay(dev, "rx-internal-delay-ps");
> 	if (ret < 0)
> 		return ERR_PTR(ret);
>
> 	rx_delay = ret;
I'll update the code according to your suggestions.
>> +
>> +	miscr = (macid == 0) ? NVT_REG_SYS_GMAC0MISCR : NVT_REG_SYS_GMAC1MISCR;
>> +	regmap_read(bsp_priv->regmap, miscr, &reg);
>> +	reg &= ~(NVT_TX_DELAY_MASK | NVT_RX_DELAY_MASK);
>> +
>> +	if (of_get_phy_mode(pdev->dev.of_node, &phy_mode)) {
>> +		dev_err(dev, "missing phy mode property\n");
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	switch (phy_mode) {
>> +	case PHY_INTERFACE_MODE_RGMII:
>> +	case PHY_INTERFACE_MODE_RGMII_ID:
>> +	case PHY_INTERFACE_MODE_RGMII_RXID:
>> +	case PHY_INTERFACE_MODE_RGMII_TXID:
>> +		reg &= ~NVT_MISCR_RMII;
>> +		break;
>> +	case PHY_INTERFACE_MODE_RMII:
>> +		reg |= NVT_MISCR_RMII;
>> +		break;
>> +	default:
>> +		dev_err(dev, "Unsupported phy-mode (%d)\n", phy_mode);
>> +		return ERR_PTR(-EINVAL);
>> +	}
>> +
>> +	if (!(reg & NVT_MISCR_RMII)) {
>> +		reg |= FIELD_PREP(NVT_TX_DELAY_MASK, tx_delay_step);
>> +		reg |= FIELD_PREP(NVT_RX_DELAY_MASK, rx_delay_step);
> You can move this inside the switch above under the RGMII case. Theses
> delays are, after all, only for RGMII.
Got it. I'll move them into the RGMII case.
>> +	}
>> +
>> +	regmap_write(bsp_priv->regmap, miscr, reg);
> Consider:
>
> 	regmap_update_bits(bsp_priv->regmap, miscr,
> 			   NVT_TX_DELAY_MASK | NVT_RX_DELAY_MASK |
> 			   NVT_MISCR_RMII, reg);
>
>> +	plat_dat = devm_stmmac_probe_config_dt(pdev, stmmac_res.mac);
>> +	if (IS_ERR(plat_dat))
>> +		return PTR_ERR(plat_dat);
>> +
>> +	/* Nuvoton DWMAC configs */
>> +	plat_dat->core_type = DWMAC_CORE_GMAC;
> Is the hardware not compatible with any of the compatible types that
> devm_stmmac_probe_config_dt() will automatically set this for you?
> Which version of the core do you have?
>
>> +	plat_dat->tx_fifo_size = 2048;
>> +	plat_dat->rx_fifo_size = 4096;
> There are tx-fifo-depth / rx-fifo-depth properties that can be used to
> describe these in DT.
>
>> +	plat_dat->multicast_filter_bins = 0;
>> +	plat_dat->unicast_filter_entries = 8;
> If this core is v3.50, v3.70 or v3.72, then there are
> snps,multicast-filter-bins and snps,perfect-filter-entries which
> can be used to describe both of these.
>
> Thanks.

Thanks for the feedback.

This GMAC is based on v3.73a. While this specific revision isn’t 
explicitly documented in the current DT binding YAML, the relevant FIFO 
sizing and filter capabilities match the behavior introduced in earlier 
v3.70+ cores.

Given that, I agree it makes sense to describe these parameters using 
the existing DT properties.

I will update the DT and driver accordingly in the next revision.

Joey

>

