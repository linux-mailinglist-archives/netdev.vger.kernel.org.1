Return-Path: <netdev+bounces-147964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 714AA9DF779
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 00:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FCCF162473
	for <lists+netdev@lfdr.de>; Sun,  1 Dec 2024 23:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273B61D90BE;
	Sun,  1 Dec 2024 23:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="eHioHpb6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC291D88A6
	for <netdev@vger.kernel.org>; Sun,  1 Dec 2024 23:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733096603; cv=none; b=IncUfI0DpzrsrUQxAlQ/23xcnmjDGe5DxBWsgZzRbfKPbK3RUSd5g5UaNzCsfNIQR5R7cjAysx9wcCp0pyECpWPplI9VDi2vNE06T6fVUi/k2Pn6swDfuN4igu5qCKsFnDI+hBbyS8Qw3BoVl5APM8owp0Sl4DuoWYrUUngbBRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733096603; c=relaxed/simple;
	bh=jjix4xl3/rdiKHdv8t7ujV3oN95qgI7CVFUUpP0vmBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RdXcJ2mqy7v5JgYKxX8a1/SIAUKXgmF1EsVR0DdapQGWacu50oSMHhho1oEqLdWQPO/K7IVo3uvawWUOyVR2iinWdpQfsWF/EtwaE8DA5xw0wUVvgVFsLyEssr6WW2Uv7uvuAzJYrjre+3Q40hsaOHL8IyU7gEBg87aZVzCxDkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=eHioHpb6; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-434a8b94fb5so21098795e9.0
        for <netdev@vger.kernel.org>; Sun, 01 Dec 2024 15:43:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1733096599; x=1733701399; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=U4SM/0P/plRo+eKbxQzKnJf2POS2A9UbZdBZq//sG/s=;
        b=eHioHpb6Z/xyC1hWkRsHoQYg1kj4xIbbMOE964AO0gJDp7+G2ubC4dCbjKcDne18lT
         p3Gd8sLEeIP3FJ4flAmChxE1IQMS0LW4DyXiUtmrZA/FPCX1Lsve/H1Xw07Sg69q8EYO
         IdtIIYmqiOBtHCdTgZKPvMi2VcGc92AwaPNJlo+9wBFjYrDk0d+pRGyW9YMMyaaqtfwj
         hufSdCLfpIZ9lbnKvxRVCVEaN/+SAsZiijJeY59wpDW2RBmljI3DOX8LydRxplCUIDz/
         oi3xOs56L8vb2Mka8I3nptawr8ptwlk0+/2IJp4WqqamO/HG42H25ody86BwKptIaa9h
         MR+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733096599; x=1733701399;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U4SM/0P/plRo+eKbxQzKnJf2POS2A9UbZdBZq//sG/s=;
        b=wI7eDaIsVWywPXRj8RZvT1ZGH02kqbawL1n5gOIBoGbp0tjfo0m22bEKugLK5Tk66g
         rrDWV9T1NEcrQ/lR6rC1B/z1STA98wgu52fpBk23bduWUp+wJ/kl/PpNe3cLnG20zHpF
         MZNn6r92JjUyY9JiD+VaXGz3QoemRu/ixHHEV4d77RnuTWF/tXAE0PUp9PUvADOksA0m
         ZTNT+EubHGYqlTf3oyJ3upx1mXoBj7BLepycMhCYihap5yLNfJXBSzQDGG2Pqb+UOT4O
         SjL8t0XEzn+tOvDqxpwt5MfeKEC28ypb82GebJVH0Q0HWCcBo7d/QSEOXOF1FEJ1kSC2
         nd2g==
X-Forwarded-Encrypted: i=1; AJvYcCV9y6ccPWppaUi0LD2qA54C9Ck5+QdKLcdHZIdpWMy/LNHxJEfXHyvuXv9HNmqKUvlM5d+m7vM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz8/G2mKSD4Pgpyybv7mykAdzvRSPZluQeOwYdsdgkmvmflvwu
	7uizUEZiPBj2ldv7b7/I2vOp1DqK6ltj53b4+nvcssOpJg4gmUxpybn2wRo7WEY=
X-Gm-Gg: ASbGncurI0hyfoNo9GNgyk9rMA6luHJfpF+AsfsU7T2N42T7wjV6xBWH298omnDhw1p
	LTOPr2HeDAEIQhBJlikAHYiGHx9fw8KZa5TDZ1sB2GwLe5Ru4IcICxul23PltDio85GRsq3Tiyf
	X/Da97itFoyis5RTNodKn+OvDUMvE0OvjpXEaXx8qpy79VQSfoYReNPxdtP3a9GBfCJflrcl7sU
	aiQPVUm8d9i0IkW4yfIc7C35PHaL2iyl1yK+FIBjYBTJGmpa+wGKIJL/7ooM7+wScQ9EKDs9dnj
	ls8i332iaA==
X-Google-Smtp-Source: AGHT+IG4dCgXB5VVyl6+jHMkGjNm05hoXwWk1dKyaqEf+YtJFD67BoX0Qe3u0N881HClgiblLiz43Q==
X-Received: by 2002:a05:600c:5123:b0:434:9dcb:2f84 with SMTP id 5b1f17b1804b1-434afb8decdmr132773415e9.2.1733096599203;
        Sun, 01 Dec 2024 15:43:19 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:4d54:a2d3:baf:1503? ([2001:67c:2fbc:1:4d54:a2d3:baf:1503])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434aa74efbesm163047565e9.7.2024.12.01.15.43.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 Dec 2024 15:43:17 -0800 (PST)
Message-ID: <4f620d2d-9916-4a6f-9049-30201b0a7523@openvpn.net>
Date: Mon, 2 Dec 2024 00:43:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 18/23] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-18-de4698c73a25@openvpn.net> <ZzIlxRbic7qLVD4F@hog>
 <136282ad-77d9-4799-bd2d-f3c3c9df99c0@openvpn.net> <ZzSH-Ke4wuJcis0q@hog>
 <5ae6f624-5196-42f7-a0b8-85e2847b3fdf@openvpn.net> <Z0nzHn3OsNeUIQPZ@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z0nzHn3OsNeUIQPZ@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 29/11/2024 18:00, Sabrina Dubroca wrote:
> 2024-11-14, 11:32:36 +0100, Antonio Quartulli wrote:
>> On 13/11/2024 12:05, Sabrina Dubroca wrote:
>>> 2024-11-12, 15:26:59 +0100, Antonio Quartulli wrote:
>>>> On 11/11/2024 16:41, Sabrina Dubroca wrote:
>>>>> 2024-10-29, 11:47:31 +0100, Antonio Quartulli wrote:
>>>>>> +void ovpn_peer_hash_vpn_ip(struct ovpn_peer *peer)
>>>>>> +	__must_hold(&peer->ovpn->peers->lock)
>>>>>
>>>>> Changes to peer->vpn_addrs are not protected by peers->lock, so those
>>>>> could be getting updated while we're rehashing (and taking peer->lock
>>>>> in ovpn_nl_peer_modify as I'm suggesting above also wouldn't prevent
>>>>> that).
>>>>>
>>>>
>>>> /me screams :-D
>>>
>>> Sorry :)
>>>
>>>> Indeed peers->lock is only about protecting the lists, not the content of
>>>> the listed objects.
>>>>
>>>> How about acquiring the peers->lock before calling ovpn_nl_peer_modify()?
>>>
>>> It seems like it would work. Maybe a bit weird to have conditional
>>> locking (MP mode only), but ok. You already have this lock ordering
>>> (hold peers->lock before taking peer->lock) in
>>> ovpn_peer_keepalive_work_mp, so there should be no deadlock from doing
>>> the same thing in the netlink code.
>>
>> Yeah.
>>
>>>
>>> Then I would also do that in ovpn_peer_float to protect that rehash.
>>
>> I am not extremely comfortable with this, because it means acquiring
>> peers->lock on every packet (right now we do so only on peer->lock) and it
>> may defeat the advantage of the RCU locking on the hashtables.
>> Wouldn't you agree?
> 
> Hmpf, yeah. Then I think you could keep most of the current code,
> except doing the rehash under both locks (peers + peer), and get
> ss+sa_len for the rehash directly from peer->bind (instead of using
> the ones we just defined locally in ovpn_peer_float, since they may
> have changed while we released peer->lock to grab peers->lock). We may
> end up "rehashing" twice into the same bucket if we have 2 concurrent
> peer_float calls (call 1 sets remote r1, call 2 sets a new one r2,
> call 1 hashes according to r2, call 2 also rehashes based on r2). That
> should be ok (it can happen anyway that a "real" rehash lands in the
> same bucket).

I think the double rehashing is ok. It's a double float happening so we 
expect a double rehashing in any case.

> 
> peer_float {
>    spin_lock(peer)
>    match/update bind
>    spin_unlock(peer)
> 
>    if (MP) {
>      spin_lock(peers)
>      spin_lock(peer)
>      rehash using peer->bind->remote rather than ss
>      spin_unlock(peer)
>      spin_unlock(peers)
>    }
> }
> 
> 
> Does that sound reasonable?

Yeah, not very elegant, but this is what we need :)

Thanks!

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


