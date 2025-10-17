Return-Path: <netdev+bounces-230601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE76ABEBC50
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 22:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237B61AA5B1A
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 20:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E196228469B;
	Fri, 17 Oct 2025 20:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK/8hxh6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1525E27A130
	for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 20:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760734575; cv=none; b=V5fHnI/rul6nbKUPDxJKvZltXClw0YODuXX+WCWyin5MV+n2te4YUlNAFB9t3z7HSqtZLUkFsdSazdzgY76X8Cd18G9nFFy7cL2AaLI31xXkpXcHSVAPQLTAgQSskY77VAL0dBcIlOcY8m8Bwn0BzYNBW+Q1g5Lx6DVvpOlQ00o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760734575; c=relaxed/simple;
	bh=Klkzc4WusbFMg9PPY2eZL0b0eThWKtPGaI/pSp2Treg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WxQzlMjC8HaM/u8BAB2+he+4XWf0D95BaRiL6It48pz6Pzotj+4+5VxWIgpfJweQDgfqrLtb9v8pl3oysSzLdLTU1tsUUvhEiZbBgC/DShPVG6Qq+2wnbNFCDpvhS9RfEA0+KJRafAz135knDqbW42trCOyv4gjCO7qZcffSw30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK/8hxh6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-47117f92e32so11489155e9.1
        for <netdev@vger.kernel.org>; Fri, 17 Oct 2025 13:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760734572; x=1761339372; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=C12qJIzcq7trqDzz0klaWxch1uVCOS8XjPTTwM5i6CA=;
        b=dK/8hxh6Be3Nxen7hFfU1Na5iKWO6Q6We+MBDJwzZFNL20F8+4uE3lBh1LmOA2kOqU
         LFF5UDKlbTp4NVfGKaStKZL4EQC4Bj7W1AoW24+xaPcbjbhJuN5hbBtomS0PnKCN6cWQ
         aQEgEE4JWsJ6xqau8KAcqV+cj57WvMmuQoUAVopAciH0P4/j0KKdbqmvwlVXFhhvfMCm
         p+K3fLKEORd66y77bMPbB8Hs14MeizOEKb4SKw+/snG2U1Bv+V/he4WNgaRd8VmVvzp/
         A5v1j3Kj2bvefEcGnXMVtsasyNqNujir/dCg3C2dLJbhs4SxS9ltEmeO9bxEE+K7FWNI
         oSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760734572; x=1761339372;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C12qJIzcq7trqDzz0klaWxch1uVCOS8XjPTTwM5i6CA=;
        b=P2Q0pHEaFxtkTrM44ead1bSkKa0SkVW+XJH1PLovi66q20BEBrPnLwhNpjyBRQNKeJ
         b2L3hoprGQn4HjTIBT4p3VoXqSd4a65c2e3iHvwQGLFQnG2xchDjvXfAfJT3UqG38sQ3
         Q9YqrE9aqY0FuCFYwDIWPJyJhLTeyjmFlFer5yGZsIu0w+48sikcHAdyhenDtbFaC71d
         EufoOoXXBgyWNRfVKXLsl/0W+bMFgSiqYAPN+2Vu5F9mu4C6kOqsLiNi8bRzTxfrFtK/
         p6CUW+Tq1GJzOXZGDZnSTn+4FIfzNZf2laSgE3j4qZ3kXeG/mH4M3dOKSa8jguWku98R
         vmEw==
X-Forwarded-Encrypted: i=1; AJvYcCXnpxsBRT5K9XKopDIOKjQKzYWoiWWa4C4hw0gEq7p/mCqm5ejQyCDbTjTXwLXl8SmJvk9a+/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgxW1b8hdm8djf3KbBUD4jh3ymfvgQa0gFhVzB7i4g4GOGbDtB
	g433IsTJyzj954oYT9L+lb7uwqj20nf6SV6Ko4VDsVUSpOo9lxNvL/5d
X-Gm-Gg: ASbGncvUjQFcEoUno11+UHU85YCkrUJL6S8BDY9iAFdf+RSOti5OCXs+CyWiFL8cgiB
	8MH68EErR5GMICIhSYgp4yvrzui3AcRs69Cqg6tE8s5q2BHWGH1RYpKc8Gcpe/d212H6/qMCPYW
	vI0wi/xTWe2uV1OGn03NTnID7/3GZoadLaj02IDXeehoSk336erxO78wXMR8pnLa4FpxrPWzmdx
	wvEHhJVfjuRNi4999LVK5kMlfCSKSydF0OZL90r6qw3KJ9eM8TYGhGQEXOulH+8odI14r6gf8Og
	5rjaEoZ4gXOYvogiNKlGcEnuWQ791emFiyVjFfIHDpX8FhIefF1UPdkxQN1IFLy+cPEs5k+s1TH
	1e1QT/gvpUN/X7jTgGkKUcHVOXQeJKcYmJbPYFG0ZUkYWfj424zZDhB9sheR5PHNZVzdq9yDkfZ
	mnGv2Gz5QcmkEqG+mqO2jyn/TKPdZXFvt8Y7xNgQsiKfGmCaXNtN0wSh7H2OfOVJuZC8RJBARO6
	Yze8DEN8LjnvfSiVJOslfvpvi1DKHO1d8WNFX3P
X-Google-Smtp-Source: AGHT+IGbK1GYiGSq90AfCM3s0IP97DdTnr+FJIu4trDGK9h3lZNAS+qE7FdF8x0d0hVhDNhvUVLA9w==
X-Received: by 2002:a05:600c:a4c:b0:46e:37fc:def0 with SMTP id 5b1f17b1804b1-471178a23c5mr36281265e9.9.1760734572196;
        Fri, 17 Oct 2025 13:56:12 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f33:9c00:f581:27c5:5f61:b9b? (p200300ea8f339c00f58127c55f610b9b.dip0.t-ipconnect.de. [2003:ea:8f33:9c00:f581:27c5:5f61:b9b])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4715520d747sm13489075e9.14.2025.10.17.13.56.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Oct 2025 13:56:11 -0700 (PDT)
Message-ID: <dc7c8414-55fe-4d86-8e5f-7cf7eeb73f97@gmail.com>
Date: Fri, 17 Oct 2025 22:56:34 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: mdio: use phy_find_first to
 simplify stmmac_mdio_register
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
References: <2a4a4138-fe61-48c7-8907-6414f0b471e7@gmail.com>
 <4a2d59c0-be25-4b83-b732-138d04f62292@lunn.ch>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <4a2d59c0-be25-4b83-b732-138d04f62292@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/2025 10:39 PM, Andrew Lunn wrote:
>> -	int addr, found, max_addr;
>> +	struct phy_device *phydev;
>> +	int addr, max_addr;
>>  
>>  	if (!mdio_bus_data)
>>  		return 0;
>> @@ -668,41 +669,31 @@ int stmmac_mdio_register(struct net_device *ndev)
>>  	if (priv->plat->phy_node || mdio_node)
>>  		goto bus_register_done;
>>  
>> -	found = 0;
>> -	for (addr = 0; addr < max_addr; addr++) {
> 
> With this loop gone...
> 
>> +	phydev = phy_find_first(new_bus);
>> +	if (!phydev || phydev->mdio.addr >= max_addr) {
>>  		dev_warn(dev, "No PHY found\n");
>>  		err = -ENODEV;
>>  		goto no_phy_found;
>>  	}
>>  
>> +	/*
>> +	 * If an IRQ was provided to be assigned after
>> +	 * the bus probe, do it here.
>> +	 */
>> +	if (!mdio_bus_data->irqs && mdio_bus_data->probed_phy_irq > 0) {
>> +		new_bus->irq[addr] = mdio_bus_data->probed_phy_irq;
> 
> ... what is setting addr to a value?
> 
Thanks. Indeed, addr can be removed and here phydev->mdio.addr has to be used.

> 	Andrew

--
pw-bot: cr

