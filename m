Return-Path: <netdev+bounces-157408-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3080A0A3D1
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 14:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A1A0188740D
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 13:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65CBCBE46;
	Sat, 11 Jan 2025 13:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jskJjDgO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3C724B24E
	for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 13:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736601550; cv=none; b=PkWpEl69qtbl7tXjwutWcrTfCDwaaj3hyBp4WspplUpHLsVI4TOLkEFTh6FzKK0oU03qMgKbrv2pMnH/T1LYVoc2cQuKBqItBJ6p80rvnJIfCLZMj+tQa1B3r2XCexKww4zHP9dGu9yg+LJtJ/q5iTNSDf8HcMXp8zPWYdHwJLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736601550; c=relaxed/simple;
	bh=H9x/XUdJ2hyHqzgNhYdJWjG4b+gaNHeSdWRqbaoyEvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qpvck0dkE9EnenzIEw5abWA+clGrkwRr4o1S/3hDHfyV3Ht/jysC0cpl3KV7vYBSwB9Ms3YJrSt0Dqq3BzoLNV0e+x1P0vnTlOowVTUnskoBG7BSFCXidqpJXLvV2rsdEsRxftNciKJv3dbmnlcj1e71wqOXMiI8PaWBEu3Lj/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jskJjDgO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-aaee0b309adso476704866b.3
        for <netdev@vger.kernel.org>; Sat, 11 Jan 2025 05:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736601547; x=1737206347; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dkksPyOAOcUPMZYunqMGkYYHTKz5tAxGKmNmPWumWC4=;
        b=jskJjDgOpumJLXfVRYy8eRPmrf04T2Lrv84JLaShkRNnm1SPpZvwE+Fdfym+fzfP6G
         H1wYqNmDhrTvE+GjtyTMrZG8PPtPnrLQmfYnoL/TexbScMGuXsDYoBm0VExfPTIcaSxk
         uMeye2hVc+BmCmN2df0g7JrVWDfbC+CuhaFl8exNpUKl6kMk6rZkZb/qQxq8GS7iSUHX
         kv5tGPCn0DpdDaxO2B7GP9ie0x6ZhRo1gVFOuISmjMukJ80ydmDFqqZZenZ2swqoZEtU
         SKYvKucLiOJhVjQsycewYEkJwlCbTyopT9BOx8vP2emyHqEhQwJMurHno1qf1pvvg8RZ
         iRRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736601547; x=1737206347;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dkksPyOAOcUPMZYunqMGkYYHTKz5tAxGKmNmPWumWC4=;
        b=qUWMYbz3p/ZIfHIi4dK1YpTeHfb+QObDHEtIS9Md0Y/Wm3lOYSajYDTmoJc4rQdvPl
         8tKOBRwDdqKxtOxbxpqbSliAgA0HTbtWN9BfUSrmdR/etItfjvQQAlr0m/qXmI2OkIhX
         gLW8JF5vZtg+vGrNwIBQIqvvA1pZiKW+35m5LQ6+vePfZGFs31rjWXnG5I1y0tNM7utz
         TJhh77s5bAPozZotTsMwLIVvHKtmcs5scuDiJ7rJ287n7F0GaHw4+Ci9p0Blqpsgil5T
         qc4xOaEnEZKj+7ruAuTmcf6vYdpdokrcp4TOHBzurC/2Va2NbtYKld70thPT2tr/jHh6
         bYZw==
X-Forwarded-Encrypted: i=1; AJvYcCU2bjE2bCEBx0fXK13vbqWVwcfaIbSO8R9Gec6dauKtxmPQz6zotUfZNg+TyZPNttX/7o2IbHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzj7i88LG4gbtLhmU9+WokmrzOMEG1VCyhVGEq76qXERwiSmd6O
	T+cberRMyxhv4og3MYLnZpPuK9Q5REBtaVZJCWEc13KK+N/fZf4K
X-Gm-Gg: ASbGncsK4yVwiNtpe6kNZLeAZGkGgAS0/6ZGFEU9uzSM/SinJbkqswq3B94ouQIyRwP
	tM1i1TVA3xVKFeaRUEy1o+GxKGibAiCNibCys8vz8XiiWol9y+Ssvi+LCDUilUHHUaKLQJ9PtYe
	7Q8il0xWm5IoMY8NmSNf55dPWpc6asDwfUgWnVi2Aosy0xY0LHJ/3coqijt2pr0zgHth09EruKT
	0VSqRZHQ2hKX2gWmR4TaEDAVrSO51c3Lao2BiEWaLSjre2TtV5Ov7Q0g5ZYBh9aL/jmw86avWMd
	qk36RNJfEUYcoik0r3gzifYsF5UvPcmG+yEF8zZQPTxyjljjmelVNzmdMKv5jVY/BeYu8NRMUIe
	5v/pWnzKZS2S6pa9gRfWQ21t6vzqshXqOcgn0ikrHLeYztPas
X-Google-Smtp-Source: AGHT+IE2MAaIa1p2ojfclSZ9jQ3IkcEW+1IovXClw6mD3YTEXJWARjDwQA9yy/i9mhMd3vOKePUQyw==
X-Received: by 2002:a17:907:2dac:b0:aae:eb0b:f39a with SMTP id a640c23a62f3a-ab2abc6ea73mr1335294666b.42.1736601546772;
        Sat, 11 Jan 2025 05:19:06 -0800 (PST)
Received: from ?IPV6:2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd? (dynamic-2a02-3100-a90d-e100-d8f1-2ffc-4f48-89fd.310.pool.telefonica.de. [2a02:3100:a90d:e100:d8f1:2ffc:4f48:89fd])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-ab2c9060f80sm273499766b.36.2025.01.11.05.19.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jan 2025 05:19:05 -0800 (PST)
Message-ID: <0212f9e8-8f60-461b-a7fe-bd4054f3689b@gmail.com>
Date: Sat, 11 Jan 2025 14:19:04 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/9] net: phy: c45: don't accept disabled EEE
 modes in genphy_c45_ethtool_set_eee
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <a002914f-8dc7-4284-bc37-724909af9160@gmail.com>
 <5964fa47-2eff-4968-894c-0b7f487d820c@gmail.com>
 <Z4I4ADNO1nSdZRja@shell.armlinux.org.uk>
 <472f6fe4-18ff-4124-ba43-fd757df7cb4d@gmail.com>
 <Z4JBld9d_UkBgRR4@shell.armlinux.org.uk>
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
In-Reply-To: <Z4JBld9d_UkBgRR4@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11.01.2025 11:01, Russell King (Oracle) wrote:
> On Sat, Jan 11, 2025 at 10:44:25AM +0100, Heiner Kallweit wrote:
>> On 11.01.2025 10:21, Russell King (Oracle) wrote:
>>> On Sat, Jan 11, 2025 at 10:06:02AM +0100, Heiner Kallweit wrote:
>>>> Link modes in phydev->eee_disabled_modes are filtered out by
>>>> genphy_c45_write_eee_adv() and won't be advertised. Therefore
>>>> don't accept such modes from userspace.
>>>
>>> Why do we need this? Surely if the MAC doesn't support modes, then they
>>> should be filtered out of phydev->supported_eee so that userspace knows
>>> that the mode is not supported by the network interface as a whole, just
>>> like we do for phydev->supported.
>>>
>>> That would give us the checking here.
>>>
>> Removing EEE modes to be disabled from supported_eee is problematic
>> because of how genphy_c45_write_eee_adv() works.
>>
>> Let's say we have a 2.5Gbps PHY and want to disable EEE at 2.5Gbps. If we
>> remove 2.5Gbps from supported_eee, then the following check is false:
>> if (linkmode_intersects(phydev->supported_eee, PHY_EEE_CAP2_FEATURES))
>> What would result in the 2.5Gbps mode not getting disabled.
> 
> Ok. Do we at least remove the broken modes from the supported mask
> reported to userspace?
> 
I think that's something we could do in addition, to provide a hint to the
user about unavailable modes. It wouldn't remove the need for the check here.
ethtool doesn't check the advertisement against the supported modes.
And even if it would, we must not rely on input from user space being sane.


