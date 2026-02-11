Return-Path: <netdev+bounces-258263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEGDKt9pjGkMnQAAu9opvQ
	(envelope-from <netdev+bounces-258263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:37:03 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CE4BA123E8B
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:37:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3B1AF3004DB2
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 11:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F15D314D0D;
	Wed, 11 Feb 2026 11:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LvzGyf07";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gIXZrN4B"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D058E313E2B
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 11:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770809816; cv=none; b=TK2AaIbmPJ/2F/n0Niac/75B0mDiBYzo2/j+1BvMP1sHdTVLhOEEycMht/Zr29Cfo23z05UzScP8JMoGxEw07B39UcZDhbgnchvWuFBwXOKcx2pgGB0xO4lSnETtv4bIGG6ernGajQcdmQI+QA1zmfIJSHYuhh1ZLptF0K5kOFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770809816; c=relaxed/simple;
	bh=3PiR99vm7GH8FpljaGZm61Ifj7mFlwc9zQM1KJ+nk10=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ACAOv7Vl7rdvRbCZgQpSAdVG732pxbr1w8A6BbkXTfY8Gy8onjGkRPc7gzkulqBJ0RyvnQK1fgJSWhG0b10ZAt6fSM9Ly1WUSDJJwelKgVhJU/nJn7LRJkVg7wxD17CLiXSiu/9Td8eAyJRtQdOfp5KutNoQa9kwEMNN/3cSJ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LvzGyf07; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gIXZrN4B; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770809814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+AnjdGG1nEkolns/Kl/LgypjNWFpwxy9FNDDz9JqrSo=;
	b=LvzGyf078xAoWji1td7ze5p29lKPI+zSlqbX07NUoV9R2uwKPKuW01UQVZ0NBtTxn+u2Rd
	9o5aqHcsnzk24wv6lFpQned5MVkYoCXN2TsQXSCJKsbGu/Y18h9AGm96KnmGQktlUOoPOI
	Yyab/f76Ti0qEsKH/JsHHfmhgYgOa78=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-ofSaRU2mPoSKQMGylyTNVA-1; Wed, 11 Feb 2026 06:36:53 -0500
X-MC-Unique: ofSaRU2mPoSKQMGylyTNVA-1
X-Mimecast-MFC-AGG-ID: ofSaRU2mPoSKQMGylyTNVA_1770809812
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4806cd00e02so29313375e9.0
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 03:36:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770809811; x=1771414611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+AnjdGG1nEkolns/Kl/LgypjNWFpwxy9FNDDz9JqrSo=;
        b=gIXZrN4Bsy7heNXdRGEmMTaCc9I4XJFX3lFU76kv6wigiPztV8iyNW/fEqN59TGOvR
         s6y4F21vxODeXhFpQ/ZOPvB/QkGtg+dWiduuP3DC6SrLx4oyvPHWd9W5y0oy2ALH/gUQ
         hZEknKiURaJ+byMz6nF3Eprc5NilbZJWcrhsZ4t9tvXuM2QPXBd10K/eKWkxuLrqeZiy
         xuOihC8dmYZb6rV5l0UG9uP/ZH48siJ41zq33IHPbWgq27ZNaXEdHK0oKmF07tg1GHDX
         1xYxWGJ3laaThBlVZYni6dvv3c5Lp7vZqNGdFTjgIucaKBk9hlR+Nd3GWWVCU7YnuihH
         p/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770809811; x=1771414611;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+AnjdGG1nEkolns/Kl/LgypjNWFpwxy9FNDDz9JqrSo=;
        b=bTwsZ445OH8XBqtpew1dmKaS65ghowOZHg080TDsUoF+fivnsWoIhYI7/I7hocRkmi
         Br3m9n8v83HnPSSbVPwIEqMpEWgaeKiHU03Q8OuDb9Q0ycqsnVyk/MLq5YOUJgMbceuV
         qQtjYYYn8jMXudEoc6B3OPM1M5eBgGTc3tJc7HGmxYmDoqF7C6r/kcwhMB9mylXGbHjz
         TxXdbMF3wq0elP8EpoNxlwen9QToPaDEWzOL9++nHm96ayybVKH/9A1UZRGZJCs726AQ
         Ki84jvjNa3svJGQiIqKr1lrHjFn16HIvZ2v5XZNyM/MW4oy/373irflx3L2uQObC5pl4
         E+4Q==
X-Gm-Message-State: AOJu0Yx9vKscqJp1Pbxedpjs2XuGuU1XrR8FJza0TrnbsW6+rSReBs9g
	3gy+G24Tdl34zfgkwG83yc+MuxwnUCpatmOmQgRPHWztDgPnOyVNsHTfD51gBngWSpXNnaa1Mjl
	1OBAMe/877a7XzHuw6YOSC7xmjCBllHFk2dob4QK2qGQZ/386OsVvzBg0XZaHwqTS5Q==
X-Gm-Gg: AZuq6aK0XPpkp1zbQ/OO41s/E6Xl7ejSm9cYTME0/mxgt9ln1kw6yBYoGCwp3tliORF
	qsJrgZDgT+RETKlYJeFCB76kQmLl83lMhHt1I+qtristatGnl1TJuzsBQR/l5ikEeZabvBhvRAh
	nj+sLNaKEv8zLAl+4QFncP0f6wytbUmr3hzQrncxEk8E+qRGC0ZlB1shrGo5WlhpYTHpy36dsJl
	9sBAdQn1f5+ayrxdrxt97WT/VTBRAIXg1ePCZPNpG+8MUc8tdLlN/6BfawZZKm20uTafvLo7lMo
	mHHXjZ8IGlrg4xDQngaB616egUoDCDpwk8Ybth+6FAxIrSUoNq42Sv1lFdFVrsY0X8T9Zjs8j6z
	QegWWNLh7hhgr4eCq6Pxu8BTnFQ==
X-Received: by 2002:a05:600c:8b6f:b0:483:4807:20fd with SMTP id 5b1f17b1804b1-4835b9411admr31983315e9.30.1770809811439;
        Wed, 11 Feb 2026 03:36:51 -0800 (PST)
X-Received: by 2002:a05:600c:8b6f:b0:483:4807:20fd with SMTP id 5b1f17b1804b1-4835b9411admr31983025e9.30.1770809810979;
        Wed, 11 Feb 2026 03:36:50 -0800 (PST)
Received: from [192.168.88.32] ([212.105.155.220])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4835a627147sm19394515e9.3.2026.02.11.03.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Feb 2026 03:36:50 -0800 (PST)
Message-ID: <def77227-7b69-4f23-8f68-949173eda6a4@redhat.com>
Date: Wed, 11 Feb 2026 12:36:49 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/4] net: phy: realtek: add RTL8224 polarity support
To: Damien Dejean <dam.dejean@gmail.com>, andrew@lunn.ch, krzk+dt@kernel.org,
 robh@kernel.org, kuba@kernel.org, maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
 hkallweit1@gmail.com
References: <20260207092539.647768-1-dam.dejean@gmail.com>
 <20260207092539.647768-4-dam.dejean@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260207092539.647768-4-dam.dejean@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258263-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,lunn.ch,kernel.org,bootlin.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CE4BA123E8B
X-Rspamd-Action: no action

On 2/7/26 10:25 AM, Damien Dejean wrote:
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 4f0c1b72f7e0..d15d3b41e5d1 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -172,6 +172,7 @@
>  #define RTL8224_SRAM_RTCT_LEN(pair)		(0x8028 + (pair) * 4)
>  
>  #define RTL8224_VND1_MDI_PAIR_SWAP		0xa90
> +#define RTL8224_VND1_MDI_POLARITY_SWAP		0xa94
>  
>  #define RTL8366RB_POWER_SAVE			0x15
>  #define RTL8366RB_POWER_SAVE_ON			BIT(12)
> @@ -1861,9 +1862,51 @@ static int rtl8224_mdi_config_order(struct phy_device *phydev)
>  	return ret;
>  }
>  
> +static int rtl8224_mdi_config_polarity(struct phy_device *phydev)
> +{
> +	struct device_node *np = phydev->mdio.dev.of_node;
> +	u8 offset = (phydev->mdio.addr & 3) * 4;
> +	u32 polarity = 0;
> +	int ret, val;
> +
> +	ret = of_property_read_u32(np, "enet-phy-pair-polarity", &polarity);
> +
> +	/* Do nothing if the property is not present */
> +	if (ret == -EINVAL)
> +		return 0;
> +
> +	if (ret)
> +		return ret;
> +
> +	if (polarity & ~0xf)
> +		return -EINVAL;
> +
> +	phy_lock_mdio_bus(phydev);
> +	val = __phy_package_read_mmd(phydev, 0, MDIO_MMD_VEND1,
> +				     RTL8224_VND1_MDI_POLARITY_SWAP);
> +	if (val < 0) {
> +		ret = val;
> +		goto exit;
> +	}
> +
> +	val &= ~(0xf << offset);
> +	val |= polarity << offset;
> +	ret = __phy_package_write_mmd(phydev, 0, MDIO_MMD_VEND1,
> +				      RTL8224_VND1_MDI_POLARITY_SWAP, val);
> +exit:
> +	phy_unlock_mdio_bus(phydev);
> +	return ret;
> +}
> +
>  static int rtl8224_config_init(struct phy_device *phydev)
>  {
> -	return rtl8224_mdi_config_order(phydev);
> +	int ret;
> +
> +	ret = rtl8224_mdi_config_order(phydev);
> +	if (ret)
> +		return ret;
> +
> +	return rtl8224_mdi_config_polarity(phydev);

This very close to what you implemented into patch 2/4. Likely you can
deduplicate the code a bit factoring out some common helper.

Side notes: you should include the target tree in the subj prefix -
'net-next' in this case, a per patch changelog for the introduced
changes WRT the previous revision and a cover letter.

Also note that net-next is now closed for the merge window; you will
have to wait unit ~23 Feb before reposting.

/P

>  }
>  
>  static int rtl8224_probe(struct phy_device *phydev)


