Return-Path: <netdev+bounces-111864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A373933B9E
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 13:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 973001C22B24
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 11:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF12E14A61B;
	Wed, 17 Jul 2024 11:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="DU/Zziz1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C32179A3
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214076; cv=none; b=MCbYi74Mh0ALsUgEuR4kdsFwlE1FX/XBBTkrueagRYD9lYvTaEtqu4/4CArpnvSEvi+OX0MHtWd59hrL3SCntVl/OjggY/qnhJ+Q+M/lbO2pm1QTft4IZSFbuUvq8Z3A6CtbaN9LHFd8e89P8p6Nfh2B20+LBL4CV9L+MIgdiWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214076; c=relaxed/simple;
	bh=KbVqUgsBeUTpLOMDQdURP+OAgdoVdhDeCfZS6OPMLpE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p3mKPRaf76UIbRN3lcZbDT+xZr/tv57u4pa8cYOfpur3VRqHlQLos0/KuDIoEbnuy3WNhoGobrkKlkq6kQwv7VokxvWGkj5GAkGM7Eugegwc4HAabi4z2NZUPCgm2UNYZHmvyLNUi4el/8iQl1T8JFVLF8kqgn3P4ZzNV9Um900=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=DU/Zziz1; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-36799fb93baso3987715f8f.0
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 04:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721214072; x=1721818872; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0kYraGGuAX4o0VqutEbWRAyEN8kjkhjrvY2a+8grLVY=;
        b=DU/Zziz1wxeLlVEUXpQRJt+m4mn6UsUBbdsDifwDp19nwxTrjt3keixo7JLdARfad2
         4L5gyFqDRtjHw1XmZDadfVSN9A1bB1xcWb7nnG2sDD1/Nji9poJ1B14kTqwuuwTI6D4c
         9IbVKr7LImL9P1h28pZn3E23gBo/f2I9uCLcCv83oBBgmHc5nvwx1PW8KwMubS2b1NeC
         qVZwshWJCU/8p6pqmzKswogb4jL+AFEwcdQe0XjsjpDvxxF6ihJaEHiAY9RrAlueOjIR
         ur7Z3ImCT77DaqYebNHH6pC/ch9PdVbSDfs9NgyY0FmOGKQducS4Vwx667UDpkJGlVMF
         2jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721214072; x=1721818872;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0kYraGGuAX4o0VqutEbWRAyEN8kjkhjrvY2a+8grLVY=;
        b=aNQtO/LFe3e4vJXfy5rQ3iqeUFBYwgQGiEYN3FbhrE6s2ZQl4CpCMWjj0TE7jMpEKr
         yEzmZwSzgj/J67K2UPJSKpouoqCTkz2AoWEkhzKWUw9i3ApJk/d0geNdbZ+cLYD+rv6E
         ADvGeQthNEGoFklUO1M66Yii6SFN3DjKxCkhvwAYYEV77OZ7q+oAsYTTT+PJDmtBkZgX
         UivsRuK9q2QN6Veo0S5yEvSh6r/Av5lRmOEeOiZhVdD6WgPFp49muOcCE0RNhqnWt9cN
         pQnTcJsXMRcOzth424HxcXwKyDavwS1t1m226wxwgzG1QzLlq2rRNdMMErIjOsJXAvz3
         CHoQ==
X-Gm-Message-State: AOJu0YzskvW2W/Te/D0ToMw15p5bCT+C4Vhilt/0gOfXJfQHfY8lSKXE
	WMv6Mwm53gvtttbfRFeLaBvpm7gbtQlumtynTJxvypyRZJJ295fvw0F0yYEWmvU=
X-Google-Smtp-Source: AGHT+IGTUYMpFN16v6fvtubInSWKu/cFUOWyVGhUxg1NiVW7Z6eMcBLXhms4TNq/xOsh8qS1xh0xLA==
X-Received: by 2002:a5d:4e52:0:b0:368:2f01:307a with SMTP id ffacd0b85a97d-368316fadf0mr1009886f8f.46.1721214072366;
        Wed, 17 Jul 2024 04:01:12 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:4c30:cffb:9097:30fc? ([2001:67c:2fbc:1:4c30:cffb:9097:30fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dab3cbbsm11288424f8f.17.2024.07.17.04.01.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:01:12 -0700 (PDT)
Message-ID: <b631abf1-b390-45fb-b463-ac49fec0fdfe@openvpn.net>
Date: Wed, 17 Jul 2024 13:03:11 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 22/25] ovpn: kill key and notify userspace in
 case of IV exhaustion
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-23-antonio@openvpn.net> <ZpegDb1F4-uBMwpe@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 xsFNBFN3k+ABEADEvXdJZVUfqxGOKByfkExNpKzFzAwHYjhOb3MTlzSLlVKLRIHxe/Etj13I
 X6tcViNYiIiJxmeHAH7FUj/yAISW56lynAEt7OdkGpZf3HGXRQz1Xi0PWuUINa4QW+ipaKmv
 voR4b1wZQ9cZ787KLmu10VF1duHW/IewDx9GUQIzChqQVI3lSHRCo90Z/NQ75ZL/rbR3UHB+
 EWLIh8Lz1cdE47VaVyX6f0yr3Itx0ZuyIWPrctlHwV5bUdA4JnyY3QvJh4yJPYh9I69HZWsj
 qplU2WxEfM6+OlaM9iKOUhVxjpkFXheD57EGdVkuG0YhizVF4p9MKGB42D70pfS3EiYdTaKf
 WzbiFUunOHLJ4hyAi75d4ugxU02DsUjw/0t0kfHtj2V0x1169Hp/NTW1jkqgPWtIsjn+dkde
 dG9mXk5QrvbpihgpcmNbtloSdkRZ02lsxkUzpG8U64X8WK6LuRz7BZ7p5t/WzaR/hCdOiQCG
 RNup2UTNDrZpWxpwadXMnJsyJcVX4BAKaWGsm5IQyXXBUdguHVa7To/JIBlhjlKackKWoBnI
 Ojl8VQhVLcD551iJ61w4aQH6bHxdTjz65MT2OrW/mFZbtIwWSeif6axrYpVCyERIDEKrX5AV
 rOmGEaUGsCd16FueoaM2Hf96BH3SI3/q2w+g058RedLOZVZtyQARAQABzSdBbnRvbmlvIFF1
 YXJ0dWxsaSA8YW50b25pb0BvcGVudnBuLm5ldD7Cwa0EEwEIAFcCGwMFCwkIBwMFFQoJCAsF
 FgIDAQACHgECF4AFCRWQ2TIWIQTKvaEoIBfCZyGYhcdI8My2j1nRTAUCYRUquBgYaGtwczov
 L2tleXMub3BlbnBncC5vcmcACgkQSPDMto9Z0UzmcxAAjzLeD47We0R4A/14oDKlZxXO0mKL
 fCzaWFsdhQCDhZkgxoHkYRektK2cEOh4Vd+CnfDcPs/iZ1i2+Zl+va79s4fcUhRReuwi7VCg
 7nHiYSNC7qZo84Wzjz3RoGYyJ6MKLRn3zqAxUtFECoS074/JX1sLG0Z3hi19MBmJ/teM84GY
 IbSvRwZu+VkJgIvZonFZjbwF7XyoSIiEJWQC+AKvwtEBNoVOMuH0tZsgqcgMqGs6lLn66RK4
 tMV1aNeX6R+dGSiu11i+9pm7sw8tAmsfu3kQpyk4SB3AJ0jtXrQRESFa1+iemJtt+RaSE5LK
 5sGLAO+oN+DlE0mRNDQowS6q/GBhPCjjbTMcMfRoWPCpHZZfKpv5iefXnZ/xVj7ugYdV2T7z
 r6VL2BRPNvvkgbLZgIlkWyfxRnGh683h4vTqRqTb1wka5pmyBNAv7vCgqrwfvaV1m7J9O4B5
 PuRjYRelmCygQBTXFeJAVJvuh2efFknMh41R01PP2ulXAQuVYEztq3t3Ycw6+HeqjbeqTF8C
 DboqYeIM18HgkOqRrn3VuwnKFNdzyBmgYh/zZx/dJ3yWQi/kfhR6TawAwz6GdbQGiu5fsx5t
 u14WBxmzNf9tXK7hnXcI24Z1z6e5jG6U2Swtmi8sGSh6fqV4dBKmhobEoS7Xl496JN2NKuaX
 jeWsF2rOwE0EZmhJFwEIAOAWiIj1EYkbikxXSSP3AazkI+Y/ICzdFDmiXXrYnf/mYEzORB0K
 vqNRQOdLyjbLKPQwSjYEt1uqwKaD1LRLbA7FpktAShDK4yIljkxhvDI8semfQ5WE/1Jj/I/Q
 U+4VXhkd6UvvpyQt/LiWvyAfvExPEvhiMnsg2zkQbBQ/M4Ns7ck0zQ4BTAVzW/GqoT2z03mg
 p1FhxkfzHMKPQ6ImEpuY5cZTQwrBUgWif6HzCtQJL7Ipa2fFnDaIHQeiJG0RXl/g9x3YlwWG
 sxOFrpWWsh6GI0Mo2W2nkinEIts48+wNDBCMcMlOaMYpyAI7fT5ziDuG2CBA060ZT7qqdl6b
 aXUAEQEAAcLBfAQYAQgAJhYhBMq9oSggF8JnIZiFx0jwzLaPWdFMBQJmaEkXAhsMBQkB4TOA
 AAoJEEjwzLaPWdFMbRUP/0t5FrjF8KY6uCU4Tx029NYKDN9zJr0CVwSGsNfC8WWonKs66QE1
 pd6xBVoBzu5InFRWa2ed6d6vBw2BaJHC0aMg3iwwBbEgPn4Jx89QfczFMJvFm+MNc2DLDrqN
 zaQSqBzQ5SvUjxh8lQ+iqAhi0MPv4e2YbXD0ROyO+ITRgQVZBVXoPm4IJGYWgmVmxP34oUQh
 BM7ipfCVbcOFU5OPhd9/jn1BCHzir+/i0fY2Z/aexMYHwXUMha/itvsBHGcIEYKk7PL9FEfs
 wlbq+vWoCtUTUc0AjDgB76AcUVxxJtxxpyvES9aFxWD7Qc+dnGJnfxVJI0zbN2b37fX138Bf
 27NuKpokv0sBnNEtsD7TY4gBz4QhvRNSBli0E5bGUbkM31rh4Iz21Qk0cCwR9D/vwQVsgPvG
 ioRqhvFWtLsEt/xKolOmUWA/jP0p8wnQ+3jY6a/DJ+o5LnVFzFqbK3fSojKbfr3bY33iZTSj
 DX9A4BcohRyqhnpNYyHL36gaOnNnOc+uXFCdoQkI531hXjzIsVs2OlfRufuDrWwAv+em2uOT
 BnRX9nFx9kPSO42TkFK55Dr5EDeBO3v33recscuB8VVN5xvh0GV57Qre+9sJrEq7Es9W609a
 +M0yRJWJEjFnMa/jsGZ+QyLD5QTL6SGuZ9gKI3W1SfFZOzV7hHsxPTZ6
Organization: OpenVPN Inc.
In-Reply-To: <ZpegDb1F4-uBMwpe@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 17/07/2024 12:42, Sabrina Dubroca wrote:
> 2024-06-27, 15:08:40 +0200, Antonio Quartulli wrote:
>> IV wrap-around is cryptographically dangerous for a number of ciphers,
>> therefore kill the key and inform userspace (via netlink) should the
>> IV space go exhausted.
>>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> ---
>>   drivers/net/ovpn/netlink.c | 39 ++++++++++++++++++++++++++++++++++++++
>>   drivers/net/ovpn/netlink.h |  8 ++++++++
>>   2 files changed, 47 insertions(+)
>>
>> diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
>> index 31c58cda6a3d..e43bbc9ad5d2 100644
>> --- a/drivers/net/ovpn/netlink.c
>> +++ b/drivers/net/ovpn/netlink.c
>> @@ -846,6 +846,45 @@ int ovpn_nl_del_key_doit(struct sk_buff *skb, struct genl_info *info)
>>   	return 0;
>>   }
>>   
>> +int ovpn_nl_notify_swap_keys(struct ovpn_peer *peer)
> 
> This is not getting called anywhere in this version. v3 had a change
> to ovpn_encrypt_one to handle the -ERANGE coming from ovpn_pktid_xmit_next.
> 

Darn! I must have missed this. This must have been removed by accident 
during the n-th rebase/reshuffle. Thanks for pointing it out.

> Assuming this was getting called just as the TX key expires (like it
> was in v3), I'm a bit unclear on how the client can deal well with
> this event.

Correct assumption.

> 
> I don't see any way for userspace to know the current IV state (no
> notification for when the packetid gets past some threshold, and
> pid_xmit isn't getting dumped via netlink), so no chance for userspace
> to swap keys early and avoid running out of IVs. And then, since we
> don't have a usable primary key anymore, we will have to drop packets
> until userspace tells the kernel to swap the keys (or possibly install
> a secondary).
> 
> Am I missing something in the kernel/userspace interaction?

There are two events triggering userspace to generate a new key:
1) time based
2) packet count based

1) is easy: after X seconds/minutes generate a new key and send it to 
the kernel. It's obviously based on guestimate and normally our default 
works well.

2) after X packets/bytes generate a new key. Here userspace keeps track 
of the amount of traffic by periodically polling GET_PEER and fetching 
the VPN/LINK stats.


A future improvement could be to have ovpn proactively notifying 
userspace after reaching a certain threshold, but for now this mechanism 
does not exist.



I hope it helps.

Cheers,



-- 
Antonio Quartulli
OpenVPN Inc.

