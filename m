Return-Path: <netdev+bounces-281012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YP9qDQ+T62lGOgAAu9opvQ
	(envelope-from <netdev+bounces-281012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:58:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD7246113F
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 17:58:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1443300616C
	for <lists+netdev@lfdr.de>; Fri, 24 Apr 2026 15:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AFA03D564E;
	Fri, 24 Apr 2026 15:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sTYRviJr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41AB83CFF65
	for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 15:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777046283; cv=none; b=a1CkGWOGbh1Rdqn4EafBmzp9z37vcvbiGcs+vC3eHFqMWKpqMe8kXayyJIHxD8edfb54yttnGEGYZBN6/l92/wn9UUiMKz1eOKDCla1ZLLaV6ILe2ieLomfW6mLJow3XH7t2sZYy6jt5YxmyrsVimKTlYuLuwn9uwUTHukv2SyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777046283; c=relaxed/simple;
	bh=+1ftvCaFRzsm43wGy5+bwp8fcU4UHrSJINM9bARr8GM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kWcrqIY8rYUmvABvXk/EN8SrTaihXJBaaauyUq52oj/s4IIHu8nCMBESx9taq/V6q5K1bbEjlQg7AqpuImD+kz52d8NHPxUxV3Rohk4Z+e4pvckv5PF1L8WA5++bCte/SiNG3frWTNoCGLrKPd6ywqHLSjEzHo6Q4hyl/1H0DNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sTYRviJr; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-35da1af3e10so7548869a91.3
        for <netdev@vger.kernel.org>; Fri, 24 Apr 2026 08:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777046282; x=1777651082; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6d9O+EApwiYusXJ1DgeMKm21JvxKbBPp2Rt3rYT/6rc=;
        b=sTYRviJrZzO26EMVgFdwPya/sQ5ESVKvDUPT/XLbVk6n/kI8Y3iZtd+tnNjFQK4qAO
         ZmAG68R8SOd8J4LIq/Uhtz52P1w9zJEi6qOig7Q/LVRLNQxFXNhkdu3Ck9PXQzVssQi4
         +J752KmcowEB6pDO0mZlev8aps1L5MWLLsnydQUEEq0CLPc0Z4h1uBMD8lrmsdyAR+Md
         sGEM7pbYgehiNtrXheqpUmVJipHUsde27NMUutdl44iUx3+w3g4rqLDCp5rwqjHAeodF
         lVfM637cUy3MdApjLNvHJptbfgEEPHkJ4mcjPegloCzp3OSFyiQksCC5fh4EXsCs4nuo
         WgWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777046282; x=1777651082;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6d9O+EApwiYusXJ1DgeMKm21JvxKbBPp2Rt3rYT/6rc=;
        b=sgFi00LsJRgHfGF0Qm0Mhf7GZP4zy2iRRTSkC6wcF7fwPTgAOHy8l22qUu9i3xDUF4
         VOJ4FzBdbGxIhFL9Y8k7KwCA93V/0rhKbLCaVfhAgghgRftA//oMinmF86Pg0MIOkgNI
         nMFFxjg4cBFmG6wk/IZRVHPfV1bBdt67gQOZgmoAEMTIARYt7FfcXKw8vNwwk+gAgUFV
         mMwIhD/15cmP9YPD/tKsYz4m0STUScBmPxTZe0exytnK1PpNQJX0VHGnNrCt4MqSLmpr
         6nDWHDgvKjDXV4Ivr/y85T2wH9XliW1Kr6TatYkmjyHxpAuLQw1BP06Fl6gPIhvAyGsY
         lP7A==
X-Forwarded-Encrypted: i=1; AFNElJ9DzMdpM0DvgD9pdn8DT91zAn3nqtj53J5qUhhTfBOY7Ob86uSGsujmBoIsfMRCMj504wVOLTY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzioaWS4BwocOgZNew300awLdPbste4X4hbqkYL9FjMF/hoH9Hj
	00yejupGVsUbfYazaJOAQgxMgQjj6gfwSE55HckK3K2Oj708jvgu7GYB
X-Gm-Gg: AeBDiev79O2JRmL5ZimasQeI5pmVSjtifejw8hWFv5iKKBWDZArI8rhQdKhyJVelUps
	ozMaMH8Vzxepv7FT/V00ITMKCDkKXdvMXEd1F3kF+2zDWWTVpxNoqZrX1zdx2Ty9uMtlafjucx2
	oVhAhvsPicdbYeigJtNB5oFWzSUXbjPo8JKnb8A8+yCGhQS0oilyaIv0dq8j8OiM6CroZSqljTU
	LiCUFMsif2niCw62HjuU5wa9GeViFDX+ISpugvk8bYdl3IuDHR7JTb4eWRiP0qXVxksnGPUav7x
	s5tMSgPX5sDHbPVV5mtsCSNq0NytZqxzCG134A74GbxTfQHdWOjRMcGQKBHchSmfRG+nPZscJ5C
	dvcS0I4uj468eSZRwPBscDKV6zX4ltJTQWavidKw4z2dq5844+Gurj/wgLAKWEdwfHIPfva0HjE
	KOWuMaT/31s+pPZzXmQJZI76YiOJCl5Z9DsCUrsc+llYqcVusy3oBFygmatd+z/geAFkPFTlrRP
	PzNq0pOyzjsnw2irEEVOw==
X-Received: by 2002:a17:90b:4fcc:b0:35f:b293:7ac6 with SMTP id 98e67ed59e1d1-361403bd8camr35057922a91.6.1777046281644;
        Fri, 24 Apr 2026 08:58:01 -0700 (PDT)
Received: from [192.168.0.5] (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141973c57sm23333233a91.14.2026.04.24.08.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 08:58:01 -0700 (PDT)
Message-ID: <6da66e31-3843-478c-9dd3-b2a9205026fd@gmail.com>
Date: Fri, 24 Apr 2026 23:57:57 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] net: phy: air_en8811h: add AN8811HB MCU
 assert/deassert support
To: Andrew Lunn <andrew@lunn.ch>, Paolo Abeni <pabeni@redhat.com>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bjorn@mork.no, ericwouds@gmail.com,
 frank-w@public-files.de, daniel@makrotopia.org, lucien.jheng@airoha.com,
 albert-al.lee@airoha.com
References: <20260420134506.35164-1-lucienzx159@gmail.com>
 <2f6fd850-e187-4e63-9a32-6b4b72c09905@redhat.com>
 <18d653c9-e8fe-48ed-9524-869f79a63121@lunn.ch>
Content-Language: en-US
From: "Lucien.Jheng" <lucienzx159@gmail.com>
In-Reply-To: <18d653c9-e8fe-48ed-9524-869f79a63121@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8DD7246113F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,vger.kernel.org,mork.no,public-files.de,makrotopia.org,airoha.com];
	TAGGED_FROM(0.00)[bounces-281012-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienzx159@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]


Andrew Lunn 於 2026/4/23 下午 07:58 寫道:
>>> @@ -1175,10 +1281,22 @@ static int an8811hb_probe(struct phy_device *phydev)
>>>   		return -ENOMEM;
>>>   	phydev->priv = priv;
>>>   
>>> +	mdiodev = mdio_device_create(phydev->mdio.bus,
>>> +				     phydev->mdio.addr + EN8811H_PBUS_ADDR_OFFS);
>> Sashiko says:
>>
>> Can this create an out-of-bounds array access if the base PHY address is
>> high?
>> The mdio_map array in struct mii_bus has a fixed size of PHY_MAX_ADDR (32).
>> If phydev->mdio.addr is 24 or higher, adding EN8811H_PBUS_ADDR_OFFS (8)
>> will result in an address of 32 or more.
>> Neither mdio_device_create() nor mdio_device_register() validate that
>> the address is within PHY_MAX_ADDR. When mdiobus_register_device()
>> executes mdiodev->bus->mdio_map[mdiodev->addr] = mdiodev, could this
>> write past the end of the array and corrupt adjacent memory?
> This has been discussed once, but Sashiko has a shorter memory than a
> goldfish. It is guaranteed by hardware design that + 8 will work.

Got it

Thanks

>
> 	  Andrew

