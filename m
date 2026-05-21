Return-Path: <netdev+bounces-290494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKW1DPgfD2pSGAYAu9opvQ
	(envelope-from <netdev+bounces-290494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:08:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A57F45A7F2D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 17:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 842C832DCD8D
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 14:37:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9363DB301;
	Thu, 21 May 2026 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xf3Qa7WK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DAB3D9DA7
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374027; cv=none; b=F4hNHyy5DshqMxOMh+qWyIziEDmzZqn/Gz5B2HXhUoXgrKeXAUovkZH0SjY1PQtt1LA++HbX0EgORUEm4dfk1JyJyuoKmoliVsJRcFwCwPjwJuYXIFDk0xSS01QkGd0nlbYAfdZQ2ceitBgHoyNmltxvFlBnN/h0jhUatEemjO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374027; c=relaxed/simple;
	bh=M3ST9lIDCvFMVutkVnk3WNUwJAYEzBIw9shmvATYFzE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YUDsNmA1dmjZDU42WReVkZu5EG488I/ya3t2Z9L13aI0sDKw+pNi6w80/dhJ9JyOPKq/Nsp4lFQM3wY/iXDRhZbgmaJug1xXOAnFdxdQ8FbvdlV0QIV38+PHnphLFbrcQXB8BAi0VKvi+///f4M9E0KjH4GJo0cQbXu54BtFMwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xf3Qa7WK; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-367c26471f5so3925161a91.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 07:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779374025; x=1779978825; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/hd2hkytsjU7+i14htqMoAzLGX+mC1QI1rvLUvekrzE=;
        b=Xf3Qa7WKn9SPJi2A/5uS6fbuCzhqKI/OykMhFelWmq/f5rEPc474izPNKbfvTyXzbe
         F+EtSTIjQJrF8uj5FgA9l3GZCaQjiyzbnN1qqOrErcr443dQCRbG2hXn1wIh3LeuJIXn
         8iuUIPecA4w47lBigrhfssR5olufSWwoYsR9vy/Sr5ZLLWhIgYYst6RRkMzXcatiumdd
         RTJZq89zAKG/Dk0vKhto5hNdscooYnQmM+xUcx1r6jCBzQgQtNJH/ZQJXGkdRx9uDWML
         Gc6X83Hx82xj2f7i9U6OK6PshUYv3Y4I0xkM9XwyF7iG/8XI22Y/4Ba3HihHcFoSSfd/
         JUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779374025; x=1779978825;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/hd2hkytsjU7+i14htqMoAzLGX+mC1QI1rvLUvekrzE=;
        b=CogmVJ00cmTIOcbvyd5/sg0KBfIVyl8FzFhRDlZ6tVgD3x3pfacRHR6Ogw14Nje5P5
         GYKlKdqO5cqB1cuPKxAeX1GAy9woi4q98LTzbXmemm/4RXbjv6AcFYxQhbvWuh5UNhiz
         CoPSzTvvCkjhlCd/FEDEOFZP9JCuFYak6nw315vuNWB0FrK0LU2PSCcpkHYnwUlwQD5e
         dg5TNK+E+KCuxnZsAMG/erRikJzX6uqVtcwy5llJhu67oaWHuudR2bJfAxbGnlXGrofO
         EWyry9E5I7abUYp/iMA/fvxctLpuHQrv0pa9jeOJoU3l3CRtIw9AqYcTSMVlwzw7H+6C
         /1Wg==
X-Forwarded-Encrypted: i=1; AFNElJ8pt5dPDjd6L036aKXTjA7IlFW/oQ2e8hTDdHllJOUZ5vCqQH0fsWHBSEpnU3r8J17CElsbC4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy4qS3qfFv70+kS0Etj2N3nAYasTY2kEViMHKm6mgJ7+lVFx/iz
	Lo59PIOhPMA962hPF7TTd/mnAWciVzMf56k8eGdtHmivQyOTTEuR33pC
X-Gm-Gg: Acq92OGNiXzs/OU59LNkHQEARHRh4oL/OcqYUSGFQYekltXKBDVxCcm3ZlXZGexwZqT
	qMT4kP0VgZy19SjQven1r8J7BVnVmXu6RHAqDDwliZx5y7+YvHCCP7XSxsWXLzAn9NfqKoUU7OV
	XO7V0nnCIee2O5ouUUX5l4eiUMDgumsHCyuBxDvkjH2YkbVHkoTtJbirpmm/XEnKZOTqVIPxutv
	NlUGrH/a8DkGUTtCmYtgdu7EGJ8m2H6qgyv+FmI63FPhgOuVI+WjXV4VUZPwDUDb0m66MHYdOVx
	4i4T3nfeepWJZqRZm/e8AB8WKz+/vc2HahRNI9rAZSXJjHR9Kd8ZHF3mpOxNKu2F/6u7wp+y+h5
	rp5RpUPBGxPsrRqg80fXvnlGSZ9ErE+/vIeo8GBvI4sbmx3DNXZeSrvX74NpuPFhUDCFtwMjkdY
	pgwzhMNX/cxNNd3BqDiVuRNSBXnLAtG0uMbi2Pg9p8ItAm05zZcmJJyy9YMKMlL9Q/8xqXy24dQ
	r59PDsmw7w=
X-Received: by 2002:a17:90b:48cd:b0:368:147f:bd2b with SMTP id 98e67ed59e1d1-36a456300e9mr3192582a91.23.1779374024990;
        Thu, 21 May 2026 07:33:44 -0700 (PDT)
Received: from [192.168.0.4] (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3c847c9asm3373414a91.0.2026.05.21.07.33.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2026 07:33:44 -0700 (PDT)
Message-ID: <237d0599-a2ff-4770-940b-fe3840de776c@gmail.com>
Date: Thu, 21 May 2026 22:33:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@mork.no,
 ericwouds@gmail.com, frank-w@public-files.de, daniel@makrotopia.org,
 lucien.jheng@airoha.com, albert-al.lee@airoha.com
References: <20260517065041.50155-1-lucienzx159@gmail.com>
 <20260520165424.5e61d5d9@kernel.org>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <20260520165424.5e61d5d9@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,vger.kernel.org,mork.no,public-files.de,makrotopia.org,airoha.com];
	TAGGED_FROM(0.00)[bounces-290494-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienzx159@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A57F45A7F2D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub

Jakub Kicinski 於 2026/5/21 上午 07:54 寫道:
> On Sun, 17 May 2026 14:50:41 +0800 Lucien.Jheng wrote:
>> +static int __air_pbus_reg_write(struct mdio_device *mdiodev,
>> +				u32 pbus_reg, u32 pbus_data)
>> +{
>> +	int ret;
>> +
>> +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_EXT_PAGE_ACCESS,
>> +			      upper_16_bits(pbus_reg));
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_PBUS_ADDR_HIGH,
>> +			      (pbus_reg & GENMASK(15, 6)) >> 6);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr,
>> +			      (pbus_reg & GENMASK(5, 2)) >> 2,
>> +			      lower_16_bits(pbus_data));
> Please add proper defines for these GENMASK'ed fields and use
> FIELD_GET() to access the fields?
I will update it in the next patch.
>
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	return __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_PBUS_DATA_HIGH,
>> +			       upper_16_bits(pbus_data));
>> +}
>> @@ -1175,10 +1281,21 @@ static int an8811hb_probe(struct phy_device *phydev)
>>   		return -ENOMEM;
>>   	phydev->priv = priv;
>>
>> +	mdiodev = mdio_device_create(phydev->mdio.bus,
>> +				     phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS);
> AI says:
>
> What happens when phydev->mdio.addr is in the range 24..31?
> MDIO addresses 0..31 are all valid 5-bit hardware addresses, so a
> strap-selected AN8811HB at address >= 24 makes
> phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS land in 32..39. struct
> mii_bus has mdio_map[PHY_MAX_ADDR] with PHY_MAX_ADDR == 32, and
> mdiobus_register_device() does:
> 	if (mdiodev->bus->mdio_map[mdiodev->addr])
> 		return -EBUSY;
> 	...
> 	mdiodev->bus->mdio_map[mdiodev->addr] = mdiodev;
> with no bounds check on mdiodev->addr. The OOB read from
> mdio_map[32..39] may return garbage that happens to be non-NULL
> (probe fails with -EBUSY) or NULL (the OOB store overwrites adjacent
> fields of struct mii_bus such as phy_mask, phy_ignore_ta_mask, or
> the irq[] array).
> Even without corruption, every later __air_pbus_reg_write() goes
> through __mdiobus_write(), which has:
> 	if (addr >= PHY_MAX_ADDR)
> 		return -ENXIO;
> so each MCU assert/deassert silently fails with -ENXIO, which seems
> to contradict the commit message:
>      so every firmware load or MCU restart on AN8811HB correctly
>      sequences the reset control registers.
> Should an8811hb_probe() reject configurations where
> phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS >= PHY_MAX_ADDR, or
> otherwise enforce the assumed strap-pin constraint?

As previously discussed, the fact that the AN8811HB PHY address is 
restricted to 8–15 (decimal)—meaning the PBUS address will only be 
within the range of 16–21 (decimal)—will be documented in the comments 
of the upcoming version.

Thanks


