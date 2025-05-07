Return-Path: <netdev+bounces-188581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AECAAD83C
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 09:34:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 620A99A32BA
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 07:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D49219A81;
	Wed,  7 May 2025 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hfwVXlMF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D18061DE3A7;
	Wed,  7 May 2025 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746603032; cv=none; b=oinGOyTaG9ePTjdOEuvROk9Q1x1mNnBe8VvzATZNTcqFRX4zlbkRa16bbHitXTDO5r9vDjvbHaL0AGONOpWHXtdWWL9G2Yj5+wYpI3iGC+GQoVzPaSdJDpV7njGphpB1kX6tAceHygVGNJ1j7aYDbgFnDQO46BDQvMxo8D2Tsjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746603032; c=relaxed/simple;
	bh=aQ7ZkE589FOqu19e0ZF0UZjG+7apZ6nuq+K9znDbbBU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VrHxKXN9HE1CtXiTbtKCVTmHAgywmYIi4xcsNEJA+HA7fuBTzvKG51Z49/O4ww/0TC6hUiyZKTl5MFKEntrR72Q3uXkLlNtJzgYphVTBXwSNCj0eE0yFNOWPDOBlX9HwbYwbpvvlZaZ2EqvRbXm+9qAMUR+thyVVHplxqMlXMVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hfwVXlMF; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3a0b308856fso680064f8f.2;
        Wed, 07 May 2025 00:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746603029; x=1747207829; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LPCrYcwgxwX8HStcX4NbBNv+gWEsQw6Mwv753/kPMak=;
        b=hfwVXlMF00ZevEXCywvn6XDJ/98TKlv+BsgbOgTj9Xd7XsdUzJYoaZ5Dxb6cj3wD03
         hvj49vHLt8J2+o9UjOWNpWKTG/RsUk+kZ3Q2lI+/t1Cc5faB6PUrQY3Ry8af5ziHv7xi
         3G1MGoBSQCNprkVsOvt32Y9+DA5GkhU8vNfmlA4yI27Dt2ouP+yrIxYRHffg/xhc+OcI
         GvdP6wOi151LSREoVP03Hpc4O++uCxVfWL1DkmglIy4ogwLvxro7djDFg63baFP7iQpb
         +sGWw7JO1vnr1u9VISFiGkGJEVqi6Vm1pGmW3rgqwHwfhYBTVR+/PfyRqHpcXX+Ut8k6
         i2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746603029; x=1747207829;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LPCrYcwgxwX8HStcX4NbBNv+gWEsQw6Mwv753/kPMak=;
        b=pYZTwPjM51P32IcfxMFcTTMJugzUTDSUMdhe+KMmIN99SzDPvJpiKkZwHOy0Kc4HU6
         ufenteDC4J4AcJuriO17DmpEJx3iNha5NoMj41sAjQbw0zTKwUmbPdavHUyYbkipGcKj
         2tjNwQhRUTxkZwCfWnYlIA3YpCupCrLWQAnGH87+CZ8XESpy59QD/DO423PLYpgtimKK
         GrtX9vBJBK/xXG+cx7CTesnBjRhDHqvSAy0h+xfyNdTzrJp6801jJBJNjg1AP5JLdgDZ
         5We6fEp604RSCc2K/WX1z51NFTV6p/E3eFVPMnQa/i480Lvatx7iTcKdaHhY2UCap0Mx
         FM4g==
X-Forwarded-Encrypted: i=1; AJvYcCVMaUUm1fj3pNENADZlI+BGEgP/CYo0/jCCm5LqWFVRE1nDp3KpJvBRcUl6wngY4Cz/Cvx4ckAV@vger.kernel.org, AJvYcCWVfuEElDzN/L3QYhKGLlrxS+UBnnv7xeSYxmWDMDI29VLw4PFpWHUP02kDXK52sxaflk1XcrC4ch4ZUJQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5/L/iCQdgo4g7NDcU9NQWXUqHBnasnRruy7qLT5CJfVPtCQ3/
	4R+9vP0sGNE2n3uB7PSPT0l17ygYzJNBa8RiLIhFeexBMI3wpBXi
X-Gm-Gg: ASbGncsicCIG6GBrAvx7xfmxdniImsMxOBeYYYh3CUe+WvBYWWmTT4MBWjXqpNgquk7
	/bIJ1JEbSDZOt5a+e8Q5najifPtrb2Av1tWg/ut51di3zcRU8THX1H76TfKSQkv9A/zuOcLkMtq
	fBTOATI764aSquMueYiJ5WtnLmKTrO0Lww7F2nXTtWgstFPLnXzjERBCH57kXyzmNmj11VY8Hce
	g/yY71XKO/wILfcY5+YLMYGDk91n4g4kuHXyAax12VWzcX2tYS87ssfMLWpfDpkpLWNXfu2LQmx
	rQVXiuHXroTml6xnJpPDOwRONbnqmrryFUwVqYVRoIOvJQrgl/Xyl+05G5XRvOdTqfeZSzIoDR8
	ufPfdhP9cBwYmYbxX0iOWslJNR9A=
X-Google-Smtp-Source: AGHT+IGCDa7qdowhMpB5IoqoRUAGt/c5pP33bP9J+IxNTn23cLL/FMQq6+vqXe7WCG2WY2LOIa+Zog==
X-Received: by 2002:a5d:5f82:0:b0:3a0:831d:267c with SMTP id ffacd0b85a97d-3a0b49a814dmr1615992f8f.18.1746603028697;
        Wed, 07 May 2025 00:30:28 -0700 (PDT)
Received: from [192.168.1.24] (90-47-60-187.ftth.fr.orangecustomers.net. [90.47.60.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0b22bd6a3sm3426127f8f.27.2025.05.07.00.30.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 May 2025 00:30:27 -0700 (PDT)
Message-ID: <aca3151b-e550-4e3b-b677-504151f5fff7@gmail.com>
Date: Wed, 7 May 2025 09:30:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 00/11] net: dsa: b53: accumulated fixes
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Kurt Kanzenbach <kurt@linutronix.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250429201710.330937-1-jonas.gorski@gmail.com>
 <52f4039a-0b7e-4486-ad99-0a65fac3ae70@broadcom.com>
 <CAOiHx=n_f9CXZf_x1Rd36Fm5ELFd03a9vbLe+wUqWajfaSY5jg@mail.gmail.com>
 <20250506134252.y3y2rqjxp44u74m2@skbuf>
 <CAOiHx=kFhH-fB0b-nHPhEzgs1M_vBnzPZN48ZCzOs8iW7YTJzA@mail.gmail.com>
 <531074c1-f818-4c0a-b8d1-be63ace38d5f@gmail.com>
 <CAOiHx=kiLgvTBVupJDqZzW1Dfn9RhiWxDfF2ZXiSR8Qk5ea2YQ@mail.gmail.com>
Content-Language: en-US
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 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
 WlfRzlpjIPmdjgoicA==
In-Reply-To: <CAOiHx=kiLgvTBVupJDqZzW1Dfn9RhiWxDfF2ZXiSR8Qk5ea2YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 5/6/2025 9:48 PM, Jonas Gorski wrote:
> On Tue, May 6, 2025 at 9:03 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
>>
>>
>>
>> On 5/6/2025 4:27 PM, Jonas Gorski wrote:
>>> On Tue, May 6, 2025 at 3:42 PM Vladimir Oltean <olteanv@gmail.com> wrote:
>>>>
>>>> / unrelated to patches /
>>>>
>>>> On Wed, Apr 30, 2025 at 10:43:40AM +0200, Jonas Gorski wrote:
>>>>>>> I have a fix/workaround for that, but as it is a bit more controversial
>>>>>>> and makes use of an unrelated feature, I decided to hold off from that
>>>>>>> and post it later.
>>>>>>
>>>>>> Can you expand on the fix/workaround you have?
>>>>>
>>>>> It's setting EAP mode to simplified on standalone ports, where it
>>>>> redirects all frames to the CPU port where there is no matching ARL
>>>>> entry for that SA and port. That should work on everything semi recent
>>>>> (including BCM63XX), and should work regardless of VLAN. It might
>>>>> cause more traffic than expected to be sent to the switch, as I'm not
>>>>> sure if multicast filtering would still work (not that I'm sure that
>>>>> it currently works lol).
>>>>>
>>>>> At first I moved standalone ports to VID 4095 for untagged traffic,
>>>>> but that only fixed the issue for untagged traffic, and you would have
>>>>> had the same issue again when using VLAN uppers. And VLAN uppers have
>>>>> the same issue on vlan aware bridges, so the above would be a more
>>>>> complete workaround.
>>>>
>>>> I don't understand the logic, can you explain "you would have had the
>>>> same issue again when using VLAN uppers"? The original issue, as you
>>>> presented it, is with bridges with vlan_filtering=0, and does not exist
>>>> with vlan_filtering=1 bridges. In the problematic mode, VLAN uppers are
>>>> not committed to hardware RX filters. And bridges with mixed
>>>> vlan_filtering values are not permitted by dsa_port_can_apply_vlan_filtering().
>>>> So I don't see how making VID 4095 be the PVID of just standalone ports
>>>> (leaving VLAN-unaware bridge ports with a different VID) would not be
>>>> sufficient for the presented problem.
>>>
>>> The issue isn't the vlan filtering, it's the (missing) FDB isolation
>>> on the ASIC.
>>
>> Could not we just use double tagging to overcome that limitation?
> 
> Wouldn't that break VLAN filtering on a vlan aware bridge? AFAICT
> double tagging mode is global, the VLAN table is then used for
> customer (port) assignment, so you can't filter on the inner/802.1Q
> tag anymore. Also learning would then essentially become SVL IIUCT.
> Also I think there aren't switches that support double tagging, but
> don't support EAP. EAP mode might be the easier way. Assuming there
> isn't a gotcha I have overlooked.

If EAP works, sure that seems like the way to go then.
-- 
Florian


