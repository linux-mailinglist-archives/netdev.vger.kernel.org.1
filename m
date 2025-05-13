Return-Path: <netdev+bounces-190000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 72609AB4D8D
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 10:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA9493BC3D1
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 08:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3B41F151D;
	Tue, 13 May 2025 08:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="FflLvMR5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436A61E2823
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 08:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747123351; cv=none; b=Et0HW0UsuL/idWM5LAK5EOsCA+I8BMyJdSrKHLsKVhk7smm65FhD6mFKOOgfb82Cua5ONXy9mVTnh73ULsU9aZbwET9XB1HOU1Iyyxq4kpZmDzExGWBdRu8/J3rGWbone2LThkC6T1W9ostkUXiV7se+GkHOHyIrwLrNxK2ocrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747123351; c=relaxed/simple;
	bh=5DtjNzWIiioS1pj46GI25O+BAnWMtVrQXLeeDxiMXqQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MI/NgMO6u01ipCDmyd2z6Oncn75E5xCnYt/MA8bwVRieHvFcht3xe6sfOpl7D6mlXfKYOyPGHfxsPgLjj2A8BSPdBiQCiuvdc0l51X1AJLIngSeqo00AYbrJvggtpWQV74X8QyjhuuMCv3KCsty2Zt0NHFWLgHRVHCv6SkTOmzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=FflLvMR5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ad21c5d9db2so675471366b.3
        for <netdev@vger.kernel.org>; Tue, 13 May 2025 01:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1747123347; x=1747728147; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=a9qwW61Fs0/qs5pzpbzGNKeMgk82dkUwGhC+Pv8KovY=;
        b=FflLvMR5+V41PGuQ0kHL3ihD/FhIQPOH+WkDteRX7HJvR94zvLoqJpCLbFrAk7Zb/T
         UZEkwIHxzV7JeEtIpmR4cw1yf2aKnnalcgxGpeIgIz6RLRRRzlPTR6jUO3Tm4PWC8OVO
         dZx3PuYzReVlZ20/+QHFyZzFnxL6HYEJwoY7aHAiYu7HPD02+Jte7I8ypocogM44RNld
         RzJ84Flh7BXqbCHZErOVHAsQbmPJwt2MGcjdNrdjzmx1UzMZRrFMULirCavyYBpEWm0h
         dZIEAhyHEd2XQ+XoY76YqVvXxHGLlrmTcCguWpU90vAddZ5i5j0ADcLwvs7ZrnuMIRZO
         tlHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747123347; x=1747728147;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a9qwW61Fs0/qs5pzpbzGNKeMgk82dkUwGhC+Pv8KovY=;
        b=hKAnOsuVZp14zkLvjqkIvNBX4U7U+lcb5Rk/bxPaaeWLJ8k4uhAyBOd0wyUlVeI2Jz
         v15RtCMqTjWFiaisZCXOw58ZfmAAHA9aaSZdb20U2sAs1OZGgwLrRzctg769cpQy24cR
         y7b2lLM1WcPTT7cC4lACeVsEOP7AT+NH2viTaRmfHhYrprznXTwhUftNsSjkaq1I017g
         L8Kv7w77r+cm+JxS9acQ/Qa3wE3XqXktjI6T8AaTgv5Gon2l6rY2Lfz4AvDZPE3xAvBf
         bG/tRcVh+5L6bSwVZi0mmaLvhynVXQvzFfbBr5KuzsnzOLVvsoAA8S8NUTYs7a0esvrF
         hfzg==
X-Forwarded-Encrypted: i=1; AJvYcCWfrCQj/PbvOkgoTn+uhuQb9J0GWUpJDHepMlD9mPa1/3dEir0bH7SJxhtBCM7RLFgUpUByfyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpdFPwrOxd4OsChb9n2a+/88tQ3hkleuJIKYMeAF900sL3Mwcx
	4KRvEfkq55x+/B1c4QBm2dPJ3OiMFAoQeeeOlGvp0oW0oU44wwAvpyEiZeuN52KmOdHsbm0objz
	Cg2Lb7DmS0qRPKwe29qbpnuDIQNc+bH/UEwLL/7ut/fDzCEs=
X-Gm-Gg: ASbGncvQ6StcEFTUJ+ethlpg3PB/SkWwpRIU6VDNXw6ujESmYZuxSS+YiUghbQy4R2R
	Z7JyC5IX1vwwMl/BH23y7T0wOc08JLAlWSVACPeW2k58Y7NQyQOs8/PqNNEM4oajcMILwWD89MY
	XhdGtO089fdkAfrvHDRQSHbfHGccJnjhv2rrs04aieOb7OG4pbiY4Ynl+LHDGIKSOXvzD57//I/
	s8njW8fdqoxO8cbfAHLrwVtj4XPNY1Fw357gE0UP6JC7urqqdyhm4SI3T/gUT0Pe0xrrj213ODw
	0hndxtMGTsG45VBEJgnYc37rdQYdzm6uiGWtGvZGI+PjcnzoLACRYilsT/QQXdZxG2w6T8+AXUW
	+bxG4daTq/7I/5tWpCBg2g/+s
X-Google-Smtp-Source: AGHT+IHGrJSQ2OgmUHaZg74kc9LdW6jisi7MXVF9eE5/ZSobhmkw15QDw8Gc/pfBw6JM83NN/yTBjg==
X-Received: by 2002:a17:907:c243:b0:ad2:5198:d711 with SMTP id a640c23a62f3a-ad25198d88amr713891666b.10.1747123347303;
        Tue, 13 May 2025 01:02:27 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:29cc:1144:33c3:cb9c? ([2001:67c:2fbc:1:29cc:1144:33c3:cb9c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ad2197bd479sm735226466b.151.2025.05.13.01.02.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 May 2025 01:02:26 -0700 (PDT)
Message-ID: <41bc10eb-8e0f-422d-932f-1135bee567a8@openvpn.net>
Date: Tue, 13 May 2025 10:02:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/10] selftest/net/ovpn: fix crash in case of
 getaddrinfo() failure
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Sabrina Dubroca <sd@queasysnail.net>
References: <20250509142630.6947-1-antonio@openvpn.net>
 <20250509142630.6947-6-antonio@openvpn.net>
 <4b95deb4-d1f2-47c3-96fd-65d2a8edd775@redhat.com>
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
In-Reply-To: <4b95deb4-d1f2-47c3-96fd-65d2a8edd775@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 13/05/2025 09:48, Paolo Abeni wrote:
> On 5/9/25 4:26 PM, Antonio Quartulli wrote:
>> getaddrinfo() may fail with error code different from EAI_FAIL
>> or EAI_NONAME, however in this case we still try to free the
>> results object, thus leading to a crash.
>>
>> Fix this by bailing out on any possible error.
>>
>> Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
>> ---
>>   tools/testing/selftests/net/ovpn/ovpn-cli.c | 10 ++++++++--
>>   1 file changed, 8 insertions(+), 2 deletions(-)
>>
>> diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
>> index 69e41fc07fbc..c6372a1b4728 100644
>> --- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
>> +++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
>> @@ -1753,8 +1753,11 @@ static int ovpn_parse_remote(struct ovpn_ctx *ovpn, const char *host,
>>   
>>   	if (host) {
>>   		ret = getaddrinfo(host, service, &hints, &result);
>> -		if (ret == EAI_NONAME || ret == EAI_FAIL)
>> +		if (ret) {
>> +			fprintf(stderr, "getaddrinfo on remote error: %s\n",
>> +				gai_strerror(ret));
>>   			return -1;
> 
> Side note: you could instead use the libcall error(), even if at this
> point it would be a quite largish self-test refactor.

Thanks for the hint!
I'll add this to my todo list and I'll do a full ovpn-cli.c revamp with 
error().

Regards,

> 
> /P
> 

-- 
Antonio Quartulli
OpenVPN Inc.


