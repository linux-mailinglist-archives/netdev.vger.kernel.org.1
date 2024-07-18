Return-Path: <netdev+bounces-112019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3469693492A
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 09:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D6B283581
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 07:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2E9978C76;
	Thu, 18 Jul 2024 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="hA88IS83"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556DD55E73
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 07:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721288644; cv=none; b=vFsFnMTY4Hq09GkrvPGZxH0d06S3jGkzHkrV+/Z5fgRefoR4cHrb1Ja45WtW8sVTjuoYj+349imvzmjQuv6yzx4Eu2K+XRGnrGocrIcXdBW5loVqlN2IhIzp+MejtSCKtYj81hf9aU5q3sRyHisf6ccqTAksjSNDqRhr0+wYxDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721288644; c=relaxed/simple;
	bh=XNXo48kjUXCH1wt2w8TExcYRlURpDHBb+jr46reQKN4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QFeeC3OiEjoWF5Np+Kf0i/Pix6j+GWXG5QAwdUvbnohog7EBhZhlylmv+Gl4MdDt29cJTA1iAV/yzH5wNurxYqOD4zQeeTI/LTMEVxzCkVT2vS7aahiM50jRTz7AILfHxeH5tVMhHco979e1Y3ph4b3PmmafRnH51x1CLWq7ziI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=hA88IS83; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-58e76294858so3023272a12.0
        for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 00:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721288640; x=1721893440; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GcNgn3pRaOgqAnTasJ0EGtJ902ovpjPvTHmE9v0p0Xw=;
        b=hA88IS83QMYflsLXZmG9IlYzBXgtp2afQkV/rRTdMtyNn1NBq562QXjvewv8FtewHh
         CS2T67UzAoNI/oWwrCDaJxI5+fpFEvJRs/JWK9RYruW6TJY1dxRtMk67gTO1SHXQpWdo
         iGJwpcCMi7JZsR8MwFK81rJHABJwSQpJaYOUXqCARIt8rxzUwE/8LCalZgWF8iGPOAtX
         dOlXogx+9r41tSRORyAN8vD7Mxv5nbldYzZ6yP2Q8yg+AZasRxUzx2diTuPiZgNbItLb
         y81Hku1whLDoStczagGcgzqwWjDdCRQx/Ur+iG+g3SG8vrrB1Rb35TI0HqkIkgU9S8ZL
         bqNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721288640; x=1721893440;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GcNgn3pRaOgqAnTasJ0EGtJ902ovpjPvTHmE9v0p0Xw=;
        b=iLRqn/c7+0IsIRWHhRt1/O9/9OKs3CXbJh/up8dCunENHph5xIt/OnJmzYSj6c3iHP
         krpgPXPM+13RKfdlhekLBXHAT3gysiPPgYQoyYgz+J5UvCTOHIgdnyU4suDTd+L56xxc
         syEl0Db4LeaG2lYEJwD1ZYXEvUQZ8nEEqH/4wVhooWCPwd62iirReS0c4iBcC4uqPbpl
         9hx7BIP7Ma/QlQ5q4zcmpRjkbfWEx+sKtL3MNQu7oRQYjCU1ci8A85PFhhfdDWcTIZgf
         zkpCIjNUPhikSAMkyMyYeSRAjPptqsKy7YD/zyGr5RBsmZv7BC0K2dopoCGwfFpSnYPB
         +akg==
X-Forwarded-Encrypted: i=1; AJvYcCWLbv7qLP8urWjh9un3TzCpQTalHCa7D6kCxUSfkuc0PjEw5PN0sa1hJg3w0MwFAxbpnOdhMDiKPIMZKiXMnnZ8wgQuLoSP
X-Gm-Message-State: AOJu0YyHYXRiAwfwYP8VCYhwFpQf/oPto5RTs6GWZRACo53vOXpUzKWN
	4bILja++sbbNdyGWXkH1LjVi4oXPMV4hk21eClqF8cw2KjRdfBbFTbRBUxT2zak=
X-Google-Smtp-Source: AGHT+IEbhZ+2P8wCwORMJk7TSiTWcBJ3+WYiqWEFGfXFTvCMym2HvqS76ZO0D+Rat6H7wJAPWGLT/A==
X-Received: by 2002:a17:906:71d0:b0:a77:ca9d:1d46 with SMTP id a640c23a62f3a-a7a0f79c980mr209621666b.33.1721288640523;
        Thu, 18 Jul 2024 00:44:00 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:14d5:6a6d:7aec:1e83? ([2001:67c:2fbc:1:14d5:6a6d:7aec:1e83])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a38f7sm525333866b.32.2024.07.18.00.43.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 00:44:00 -0700 (PDT)
Message-ID: <4c26fc98-1748-4344-bb1c-11d8d47cc3eb@openvpn.net>
Date: Thu, 18 Jul 2024 09:46:00 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 17/25] ovpn: implement keepalive mechanism
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sabrina Dubroca <sd@queasysnail.net>, netdev@vger.kernel.org,
 kuba@kernel.org, ryazanov.s.a@gmail.com, pabeni@redhat.com,
 edumazet@google.com
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-18-antonio@openvpn.net> <ZpU15_ZNAV5ysnCC@hog>
 <73a305c5-57c1-40d9-825e-9e8390e093db@openvpn.net>
 <69bab34d-2bf2-48b8-94f7-748ed71c07d3@lunn.ch>
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
In-Reply-To: <69bab34d-2bf2-48b8-94f7-748ed71c07d3@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/07/2024 04:01, Andrew Lunn wrote:
>>>> +		if (ovpn_is_keepalive(skb)) {
>>>> +			netdev_dbg(peer->ovpn->dev,
>>>> +				   "ping received from peer %u\n", peer->id);
>>>
>>> That should probably be _ratelimited, but it seems we don't have
>>> _ratelimited variants for the netdev_* helpers.
>>
>> Right.
>> I have used the net_*_ratelimited() variants when needed.
>> Too bad we don't have those.
> 
> If you think netdev_dbg_ratelimited() would be useful, i don't see why
> you cannot add it.
> 
> I just did an search and found something interesting in the history:
> 
> https://lore.kernel.org/all/20190809002941.15341-1-liuhangbin@gmail.com/T/#u
> 
> Maybe limit it to netdev_dbg_ratelimited() to avoid the potential
> abuse DaveM was worried about.

I see what Dave says however...

...along the packet processing routine there are several messages (some 
are err or warn or info) which require ratelimiting.
Otherwise you end up with a gazilion log entries in case of a long 
lasting issue.

Right now I am using net_dbg/warn/err/info_ratelimited(), therefore not 
having a netdev counterpart is not really helping with Dave's argument.

I can try to take on this mission after this patchset is in and see what 
Dave/Jakub think about it.


Regards,


-- 
Antonio Quartulli
OpenVPN Inc.

