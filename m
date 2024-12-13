Return-Path: <netdev+bounces-151713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E4F9F0ADC
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FC2418859ED
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:25:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9317C1DE3C8;
	Fri, 13 Dec 2024 11:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b="JRsB8tt8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30ED61DE3BA
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734089126; cv=none; b=AyL5jrPCQ7JbSJsuzHjwUSQ605B2emRw/BIIXa1udIGp8CAABfc6JyNqty6chNmEzT0FVJFk8E6sqjVk+OnJELyd4HGbIWclKq2mLow0dGb57R8PZo2xhJRutxBP4C5PK8zqxA9r80kSFdJ0FohxneiuLx/PGjeDE6lZvfgXAVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734089126; c=relaxed/simple;
	bh=jVVDkd4GtPcl/Ya2Cyzmdc1drC5cqvneJpMuXxxZFQU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=NkqTm9p3RjjHA4DiKTjqmnH2OkwIO5AxdLmqFRYZWs7YJOvjHT6Tng75CuSzq8NekQatkjGUDKHNLaXVMqOse5DCiIhY7vE54Nx3iz/G4x5qvYavODbMxTtg/9c8wDS49tkfxQ9w9wpa/4k7DHBdAkn6e/1NvewQ2HBAZpJHhHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de; spf=none smtp.mailfrom=bisdn.de; dkim=pass (2048-bit key) header.d=bisdn-de.20230601.gappssmtp.com header.i=@bisdn-de.20230601.gappssmtp.com header.b=JRsB8tt8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bisdn.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bisdn.de
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436230de7a3so1876715e9.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 03:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bisdn-de.20230601.gappssmtp.com; s=20230601; t=1734089122; x=1734693922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:autocrypt
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6279siDW6hDqPjOPyrhG12adHJ/zO5tbDEQWXP7oa5Y=;
        b=JRsB8tt8yzzR4jDZBlnlBoyfwIwipILitLtoqU/6vLMBbocIztaLuuSDkakLn/2pFM
         fi1u94YjVzrbwecgaW2XVhZcn9YxsUfpfuTEbEh7GwvsucX8Vrhw2vF7IdkKbE4WQBD5
         KMnfSeCHl1k/UBdx2ljuhs2iSr684a+vSfF0h7M8A1U6HSPBp7ayFH/rRM6FKk38vV83
         5uGtW2Wbb4axHLdxSMkXvy33VtnZ1sJaPdg0kw7IrlvGM57Pw5ywEP/t50uLL+fr85md
         JsNyVml0sQ+8qgGH4Yl/OJrYFPcLPFgGhtWJo9hslAx/JKjtE85Oj18QWex9MZdhnvyo
         wMrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734089122; x=1734693922;
        h=content-transfer-encoding:content-language:in-reply-to:autocrypt
         :references:cc:to:subject:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6279siDW6hDqPjOPyrhG12adHJ/zO5tbDEQWXP7oa5Y=;
        b=s3KpaP3/oowGH7gHvTZDZm3eA2Hb3AeUH1lBQPhVS/z4xZG4oVTFWQTs0h9CybK6DO
         OyJQqHra4y/KmGIDZo3qs2rQXV3dYXIB+ZAYVhgfpy4hQYku5D//VJGx42/whPpPvW67
         ZbqgVVfMYRd8gxMBuEKrSfxvzKOEsCQ43fe/cg8O2vp8+5tn5PqtGBlRIjyAXJtwfOSb
         ds312mePHegY3oyTrfx53SCNcNA05JewFyPxOfI/c0RNCTlEx3Y5lCpdGwlKv1AA310S
         TUAdPGdVw2ncYRdkYDt/2XcOI3D2K6Syc3B7ozy3tFbczKBn2W7jliKNvRjW44IiVqPc
         Tybw==
X-Forwarded-Encrypted: i=1; AJvYcCU09RSVbLzFeCwf99xNej8CxCGWsViEMu/4AUbnbYcJ+O82xgdsHy98ZaHzrAdK9AjdzhicMKI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/4x/7dH0JzGTkQm6jukq2HnoIiN3Zi5uL8A2MHX2+E/NXPpBO
	Hw/goeoM50Ok513NhKAxLAsXo0894tEJL1oMQ/XaK+ucTypiB/DXGdYmTHiTijN8Db1Ipx7x4gq
	io6s0wBj4H2W2+1wuxzyllVyOUcqc3G3Kmu6XRjv/M5gaQZn80xpIUDu2xv4g/N4=
X-Gm-Gg: ASbGncv4wvb+2dylpC1S/3BROKZN4+fRsYOE11XzKQYHmQUqZLINCMyf5lFNKmr1Mph
	OKfU5a0qWGXzjhyO0cB/9URwXKWoP9rUqUDLvK/mWzYfOLxJkJLPQR+9u3H62wJFY+xhjqzLr6t
	IbONW39LRQ5GzR2WAYVMWrghTeEhCVb1doeMDqwYc2YObnoR8sK51AfV311LjI1frnpQBLw7VBC
	2SljGLxG8iZ9Cvey9SHHDvqOBh4HwjuZ9m1byDQQwQJqYsK6fwOBdx61Pa9em8=
X-Google-Smtp-Source: AGHT+IG2n1+TronxhEygzTlzgQL6OyWDwWWHO3T6emy4eTRieOlanhn10eScWY8HoOhk8275H5ilog==
X-Received: by 2002:a05:6000:2ad:b0:385:fd31:ca30 with SMTP id ffacd0b85a97d-3889ad36430mr554250f8f.14.1734089122349;
        Fri, 13 Dec 2024 03:25:22 -0800 (PST)
Received: from [172.16.103.202] ([62.80.99.152])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-387824a5085sm6790399f8f.38.2024.12.13.03.25.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Dec 2024 03:25:21 -0800 (PST)
Message-ID: <3bdc6e3c-49d4-46ec-9c36-85e324e5e2b4@bisdn.de>
Date: Fri, 13 Dec 2024 12:25:20 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Jonas Gorski <jonas.gorski@bisdn.de>
Subject: Re: [PATCH RFC] net: bridge: handle ports in locked mode for ll
 learning
To: Ido Schimmel <idosch@nvidia.com>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Roopa Prabhu
 <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Hans Schultz <schultz.hans@gmail.com>,
 "Hans J. Schultz" <netdev@kapio-technology.com>, bridge@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241210140654.108998-1-jonas.gorski@bisdn.de>
 <20241210143438.sw4bytcsk46cwqlf@skbuf>
 <CAJpXRYTGbrM1rK8WVkLERf5B_zdt20Zf+MB67O5M0BT0iJ+piw@mail.gmail.com>
 <20241210145524.nnj43m23qe5sbski@skbuf>
 <CAJpXRYS3Wbug0CADi_fnaLXdZng1LSicXRTxci3mwQjZmejsdQ@mail.gmail.com>
 <Z1lQblzlqCZ-3lHM@shredder>
 <CAJpXRYRsJB1JC+6F8TA-0pYPpqTja5xqmDZzSM06PSudxVVZ6A@mail.gmail.com>
 <Z1mmnIPjYCyBWYLG@shredder> <fb085904-e1c2-4bbf-b826-b6ba67d283b5@bisdn.de>
 <Z1rWRorUo7ivWJdO@shredder>
Autocrypt: addr=jonas.gorski@bisdn.de; keydata=
 xjMEZxdk5BYJKwYBBAHaRw8BAQdAPu67BaIt3vpOuFNykN1bTGnMCt3SfaTAdTgdx7x3aM3N
 JEpvbmFzIEdvcnNraSA8am9uYXMuZ29yc2tpQGJpc2RuLmRlPsKPBBMWCAA3FiEEFDg1Kr+u
 iVjQpdfy5Kt7/8+fcMYFAmcXZOQFCQWjmoACGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDkq3v/
 z59wxkUZAP4uDlkfv1WhuDjPUaeL9uL33RUo4mUwIYQLAR8gKQk5lgEAiQvKbFvrB2Zz8Tbs
 anWvhWddIu1L9D4KMdoayMpCqQrOOARnF2TkEgorBgEEAZdVAQUBAQdAQSvRRbcsAY5GLbFn
 qnD2JZ3hGcjOviBjgQpPQV48MSMDAQgHwn4EGBYIACYWIQQUODUqv66JWNCl1/Lkq3v/z59w
 xgUCZxdk5AUJBaOagAIbDAAKCRDkq3v/z59wxuVgAP9D6DwrhASXLN8c5uy/BYuaMznIfqf5
 6R95DltdAG2xigD/TCGATSNdLFd253kU+qiZPLWwcqNouB2cTa1ItM1N/AU=
In-Reply-To: <Z1rWRorUo7ivWJdO@shredder>
Content-Language: en-US
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: quoted-printable


On 12.12.24 13:25, Ido Schimmel wrote:
> On Thu, Dec 12, 2024 at 10:50:10AM +0100, Jonas Gorski wrote:
>> The original patch (just disabling LL learning if port is locked) has
>> the same issue as mine, it will indirectly break switchdev offloading
>> for case 2 when not using MAB (the kernel feature).
>>
>> Once we disable creating dynamic entries in the kernel, userspace needs
>> to create them,
>=20
> But the whole point of the "locked" feature is to defer the installation
> of FDB entries to user space so that the control plane will be able to
> decide which hosts can communicate through the bridge. Having the kernel
> auto-populate the FDB based on incoming packets defeats this purpose,
> which is why the man page mentions the "no_linklocal_learn" option and
> why I think there is a very low risk of regressions from the original
> patch.
>=20
>> and userspace dynamic entries have the user bit set, which makes them
>> get ignored by switchdev.
>=20
> The second use case never worked correctly in the offload case. It is
> not a regression.

Ah, I just noticed I incorrectly assumed that unlocking an entry just=20
means removing the locked flag, but any change from user space also=20
implicitly adds the user bit. So they would never get offloaded.

So there currently is no way to get offloaded dynamic entries with=20
locked ports, regardless of MAB or not. And implementing that is=20
definitely not a oneliner.

>> FWIW, my proposed change/fix would be:
>>
>> diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
>> index ceaa5a89b947..41b69ea300bf 100644
>> --- a/net/bridge/br_input.c
>> +++ b/net/bridge/br_input.c
>> @@ -238,7 +238,8 @@ static void __br_handle_local_finish(struct sk_buff =
*skb)
>>   	    nbp_state_should_learn(p) &&
>>   	    !br_opt_get(p->br, BROPT_NO_LL_LEARN) &&
>>   	    br_should_learn(p, skb, &vid))
>> -		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid, 0);
>> +		br_fdb_update(p->br, p, eth_hdr(skb)->h_source, vid,
>> +			      p->flags & BR_PORT_MAB ? BIT(BR_FDB_LOCKED) : 0);
>=20
> IIUC, this will potentially roam FDB entries to unauthorized ports,
> unlike the implementation in br_handle_frame_finish(). I documented it
> in commit a35ec8e38cdd ("bridge: Add MAC Authentication Bypass (MAB)
> support") in "1. Roaming".
Good point, missed that br_fdb_update() will automatically clear the=20
locked flag on roaming regardless of flags including it.

So disregard that idea as well, and we would need to do what I=20
originally proposed to allow locked learning via link local traffic.

But since there is no difference between kernel entries that userspace=20
unlocked and dynamic entries userspace added as I now found out, it also=20
isn't needed at all. Userspace can just add dynamic entries if needed.

So in conclusion, I agree with the original patch. Shall I resend it?=20
Should I extend the commit message?

Best Regards,
Jonas

--=20
BISDN GmbH
K=C3=B6rnerstra=C3=9Fe 7-10
10785 Berlin
Germany


Phone:=20
+49-30-6108-1-6100


Managing Directors:=C2=A0
Dr.-Ing. Hagen Woesner, Andreas=20
K=C3=B6psel


Commercial register:=C2=A0
Amtsgericht Berlin-Charlottenburg HRB 141569=20
B
VAT ID No:=C2=A0DE283257294


