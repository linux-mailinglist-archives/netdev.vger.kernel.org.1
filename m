Return-Path: <netdev+bounces-226199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0EF6B9DDDA
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 09:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62711B22A2B
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 07:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6C8281358;
	Thu, 25 Sep 2025 07:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F+gm0330"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C0120E6
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 07:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758785763; cv=none; b=RIT7dpvORZmaJ1a+5BLasDeLZUtMShssvWF+jpWNM5T3ypZirNuprqtu7hz0XpEewPLb2Ck5QVYVNEycFYk1d9uujcF1kyVEOFDO7VzvTz/rU/Vdqxjn4th+m06jSt+0h3aFXF8h3naymFfFxZTHPDoIPZgTdPAeraorm9Un9QE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758785763; c=relaxed/simple;
	bh=xHdsNs9rPI7Reu2HwSB9FXQv5Sy5le3/Yz14p6anSq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Aq01r+I9qnIkNYRVfgDtfwrR9qK0AbGo2kPfm5YOEV65z6lUI4bcVimSZNYtHm1tE1FrYvSOtmrGsNrAnZCXLTqIYRolWBAZWI5Vjyh7wslUEY2EkUPJ8h93qam6YmJybvtLjJ4hUwVDFFougUpDpVTkp6haevzSDAhdeGMbodM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F+gm0330; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758785760;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=q0kDzZuRdavTuuB8YRXhaNxyxxWXTemY4HhrOpdc3+M=;
	b=F+gm033016TKQ3fxfAFXHvMjI+YBIa11+1xVFrrDrDwnu0r6xG9EHvALTpddqjKPKP7Pji
	lwLwMUp246hQGIpNGgdO4+Yv3fexhbjiRrAD/gZr0BUB9dnNv3gP+L8U6Y+hyOF6uz0lzT
	fOdZEgFLISEHJ8RQrOZpQ6ON875oziw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-3nqhTsP1My-q1trqvY3GEA-1; Thu, 25 Sep 2025 03:35:58 -0400
X-MC-Unique: 3nqhTsP1My-q1trqvY3GEA-1
X-Mimecast-MFC-AGG-ID: 3nqhTsP1My-q1trqvY3GEA_1758785757
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3ee13baf21dso614171f8f.0
        for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 00:35:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758785757; x=1759390557;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q0kDzZuRdavTuuB8YRXhaNxyxxWXTemY4HhrOpdc3+M=;
        b=Vc9KHAX0IAI+eQXLC2bRTwp4/SAdc3xvyyRoUiEb5dQum/4ZSi52EDhHb718SkPi8O
         MhSndtbRDXj/TWmHCqj2IY+OOlq4/ih5atdxSDM7AO/4zjA3xHFFE2SFWOpk7+73WaH7
         ktd7piE/ALMegErllg4AroOlzSNhRwdi6P5vo/KuVuhbyfbGb8vp96Cfw8AnZ1b/vRQr
         Ba1/RNdOEPHqnU0ccYGxuNMa4q4ZphOetdqO49ov4FDr2WYRRX4NPqXRIubnCCTUtvBT
         nnfA2mpNM4+sLcOw/zshd+2FyEFmFuXzWlRG6iAHhAdvdLzbZv5ldgYc436hsqW5kyII
         Ugsw==
X-Gm-Message-State: AOJu0YzpFmqo4dhFJkWGDHm6DUbk3/7kYN6hhBcoNP6mwsVwNp4hk6Id
	0TK3AqYI/5CCZ3mjIykgEJQl7MZVxI+Jk3GHCJ6PInnuDbqTUdqAhl11qyVfsNhq7tuWAKIe9RU
	367InTI/cIPfMscBhS6cmeoOJ0IzV8JHo+k3TSGw0h8xkCfvbc4hRK0+CmThNetPIcA==
X-Gm-Gg: ASbGnct5dxa9DRMckw1h4botkRalag12NwXyUcgaWBMp1T9WvWSIvbUWqLZ9yDslV2t
	TPaXQFRAwfcOJTL/EhmvqhxpBl65K5N4SEH7G06lUJcWoX69I+VttIXS1+aD1SPdXdcfRT02T8l
	gdEGGyKnkxCwGIJhZ/WKzHEbZgfXpRy5Sv+l78jHSpVo4DY8mX4A0LVU2AMLu3sprz1nC7gaw+6
	3AFsi+4IL5VE+t3xWOi4NTHVgMUgVNshUD4FUjdjCezdjQVbnHTmQUEkstKRwY3xyvEOXi2P5Wd
	o8m2cqQ9N3tYLf1G++Fyl/QKpXbQMqK7sIUsDStvyTch+CkOrjWLrXl5BIXha9b71+ljduRhopl
	gmSjMFF9nRfHb
X-Received: by 2002:a5d:5f45:0:b0:3fc:54ff:edb6 with SMTP id ffacd0b85a97d-40e4886dfefmr2146907f8f.35.1758785757042;
        Thu, 25 Sep 2025 00:35:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGMrQWsgs8R3CgAHJ3shccVJraeNo+j1rT5n10j0m06BQ9RlPFHZSmbWVMukj8qDl7gVfpQwA==
X-Received: by 2002:a5d:5f45:0:b0:3fc:54ff:edb6 with SMTP id ffacd0b85a97d-40e4886dfefmr2146872f8f.35.1758785756609;
        Thu, 25 Sep 2025 00:35:56 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fc7e2c6b3sm1786662f8f.54.2025.09.25.00.35.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Sep 2025 00:35:56 -0700 (PDT)
Message-ID: <b2257603-382c-4624-9192-2860208162c9@redhat.com>
Date: Thu, 25 Sep 2025 09:35:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/2] lantiq_gswip fixes
To: Daniel Golle <daniel@makrotopia.org>,
 Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Hauke Mehrtens <hauke@hauke-m.de>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
References: <20250918072142.894692-1-vladimir.oltean@nxp.com>
 <20250919165008.247549ab@kernel.org>
 <20250918072142.894692-1-vladimir.oltean@nxp.com>
 <20250919165008.247549ab@kernel.org> <aM3-Tf9kHkNP2XRN@pidgin.makrotopia.org>
 <aM3-Tf9kHkNP2XRN@pidgin.makrotopia.org>
 <20250922110717.7n743dmxrcrokf4k@skbuf> <20250922113452.07844cd2@kernel.org>
 <aNNxC7-b3hduosIh@pidgin.makrotopia.org>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <aNNxC7-b3hduosIh@pidgin.makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/24/25 6:18 AM, Daniel Golle wrote:
> On Mon, Sep 22, 2025 at 11:34:52AM -0700, Jakub Kicinski wrote:
>> On Mon, 22 Sep 2025 14:07:17 +0300 Vladimir Oltean wrote:
>>> - I don't think your local_termination.sh exercises the bug fixed by
>>>   patch "[1/2] net: dsa: lantiq_gswip: move gswip_add_single_port_br()
>>>   call to port_setup()". The port has to be initially down before
>>>   joining a bridge, and be brought up afterwards. This can be tested
>>>   manually. In local_termination.sh, although bridge_create() runs
>>>   "ip link set $h2 up" after "ip link set $h2 master br0", $h2 was
>>>   already up due to "simple_if_init $h2".
>>
>> Waiting for more testing..
> 
> I've added printk statements to illustrate the function calls to
> gswip_port_enable() and gswip_port_setup(), and tested both the current
> 'net' without (before.txt) and with (after.txt) patch
> "net: dsa: lantiq_gswip: move gswip_add_single_port_br() call to port_setup()"
> applied. This makes it obvious that gswip_port_enable() calls
> gswip_add_single_port_br() even though the port is at this point
> already a member of another bridge.

Out of sheer ignorance is not clear to me why gswip_port_enable() is
apparently invoked only once while gswip_port_setup() is apparently
invoked for each dsa port.

> I'm ready to do more testing or spray for printk over it, just let me
> know.
> 
>>
>>> - If the vast majority of users make use of this driver through OpenWrt,
>>>   and if backporting to the required trees is done by OpenWrt and the
>>>   fixes' presence in linux-stable is not useful, I can offer to resend
>>>   this set plus the remaining patches all together through the net-next
>>>   tree, and avoid complications such as merge conflicts.
>>
>> FWIW I don't even see a real conflict when merging this. git seems to
>> be figuring things out on its own.
> 
> My concern here was the upcoming merge of the 'net' tree with the
> 'net-next' tree which now already contains the splitting of the driver
> into .h and .c file, and moved both into a dedicated folder.
> This may result in needing (trivial) manual intervention.

AFAICT, when Jakub wrote 'merging this' he referred exactly to the 'net'
-> 'net-next' merge.

> It would be great if all of Vladimir's patches can be merged without
> a long delay, so more patches adding support for newer hardware can
> be added during the next merge window. Especially the conversion of
> the open-coded register access functions to be replaced by regmap_*
> calls should only be committed after Vladimir's fixes.

This should not be a problem. Even moving these patches to net-next,
they could be applied before the upcoming net-next PR (if Vladimir
repost them soon enough). Even in the worst case scenario - targeting
net-next and missing this PR - there should not be any delay for
follow-up patches, as such patches will likely have to wait for the
merge window closure anyway.

Given the above, that we are very close to 6.17, and the fixed here is
quite old, I suggest moving this series to net-next - unless someone
comes with a good reasoning to do otherwise. @Vladimr, could you please
re-post for net-next?

Thanks!

Paolo


