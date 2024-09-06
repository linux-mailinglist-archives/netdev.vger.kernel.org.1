Return-Path: <netdev+bounces-125918-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6178896F435
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5BA1C22101
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FCFC1CCB37;
	Fri,  6 Sep 2024 12:24:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="gEgQETj7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 317AC17C9B
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725625463; cv=none; b=GC4vz1bYGo4QIp4TWNj6daih3M4FQrNYh5fp7rH63cOUkrZJXIwyMHbRictQ9wN21PUmfx9RVlMaTJR6BKMfyjAnSZIMTdsAUPNLjKwE4l9+stFRQFyKbNjD4hSM+m8rrkrmChawOeyZSWbGkbE3DN4wZxnoXOHT9jy0eNNIdy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725625463; c=relaxed/simple;
	bh=DjBTEXINyNhJcsH6hyZktRaPFb3/5YXmwU6p+qdvSJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HwYhpkuH1MfO629znzfZkjfinC8vOFNBBiM4HsR7zLAUjy5KwBaLxD1RgcvcvJBuPD6+Cg6Gz/JvOgP7fPbfjMPXOdtMLJcGMd+3S0aYyKtwZ0gJ9QUHgJwxg/d/WSz5jhD2rXZTuiJz3WKQ9DpKRvFHObzo/no5ZyjSjHQUbpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=gEgQETj7; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42c94e59b93so16838385e9.1
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 05:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1725625459; x=1726230259; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=7Cgpw98WNoGdUXXSKYixdT//ltCaTVkEeRruS1pN5Ak=;
        b=gEgQETj747wf5WAyflRGQpP/PtjmUBH20wgpV1yA4R+QszTSUdGnjErLwvkl1eaN57
         n7WawY9EpnmP/DhghQw7J4M5OZQPlTZuWZuDKRUnyQIzd56nwLC40wrHevqpFqB6ZtZ7
         SsmJzz3urTey6r0z61qTj7T8ndOv29fvysUgIWRolkgd+X6QEfKqyx6EPwMm5LIwLH5h
         7ArmLVu5nO+sRmNpNrr3dP/d13z6LPHl8yhLv+96hqhQab2AlTLgYERMwqHvV7/voHYt
         VmtKvlWpMSZAjI7LQCgHUlxBbT+3NenzRIK6BXoLrBE+0EFy0nw8lwkt5sOoaq1sqo58
         WMjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725625459; x=1726230259;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Cgpw98WNoGdUXXSKYixdT//ltCaTVkEeRruS1pN5Ak=;
        b=NQXM0Ege2SkCSe+gppE9fh4mVyAP+fsieBAcAKsrX433XJ+IvLlHRE18D+p7ZBgHlo
         W2EhzVTPmnHjmTNlVC30vRMHioPWvmB//5zQe9qxmJOuLJi/oLEIGYAerO+UgQwhWy/L
         5A9Jy+PJOXJzmYJCZrG3JxExHNc4WIaAboQsLBvUiL7hyQvYIzIDvR0O+LidhcrVP6lu
         NL/T345szjIKsXzQjYtukEsUC1EbjwjSa6f9i8Rm0UkAPv/BIz1Nxw6Oai1rea13Lc+Z
         nOtoAecaIjSuswApV2xkrYsDJx2D0IICwQ5BtBI/gVTWgb+/JZwfANPJgJIsxCFAuqyo
         FGhQ==
X-Gm-Message-State: AOJu0YzSDqJpVV+b+FEW+ARJBz2gCc8BgtReIjjhJN0JCoYSUTGU3fA7
	EgcAD0tdR8hv4qmJeusxV9GlSv+mYSGJAQIsBomkLWC8KthtP5taQMf9pHEHkNE=
X-Google-Smtp-Source: AGHT+IFMc8FeQCQ5RxzgpsMhBIV1VRxGykkxSU74o5PYb1hGCX3AxPA8Y7XM3prnRkQ8N2lbiqXIXg==
X-Received: by 2002:a05:600c:1389:b0:426:6fb1:6b64 with SMTP id 5b1f17b1804b1-42c95af7f03mr57006705e9.7.1725625459302;
        Fri, 06 Sep 2024 05:24:19 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:9b0:9865:5539:6303? ([2001:67c:2fbc:1:9b0:9865:5539:6303])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ca05ca937sm18832255e9.14.2024.09.06.05.24.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Sep 2024 05:24:18 -0700 (PDT)
Message-ID: <331569ef-6387-4703-9d72-4ab704259efa@openvpn.net>
Date: Fri, 6 Sep 2024 14:26:25 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 03/25] net: introduce OpenVPN Data Channel
 Offload (ovpn)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch,
 steffen.klassert@secunet.com, antony.antony@secunet.com
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-4-antonio@openvpn.net> <ZtnCUJOTO9d1raQV@hog>
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
In-Reply-To: <ZtnCUJOTO9d1raQV@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 05/09/2024 16:38, Sabrina Dubroca wrote:
> 2024-08-27, 14:07:43 +0200, Antonio Quartulli wrote:
>> diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
>> index 9920b3a68ed1..c5743288242d 100644
>> --- a/drivers/net/Kconfig
>> +++ b/drivers/net/Kconfig
>> @@ -115,6 +115,19 @@ config WIREGUARD_DEBUG
>>   
>>   	  Say N here unless you know what you're doing.
>>   
>> +config OVPN
>> +	tristate "OpenVPN data channel offload"
>> +	depends on NET && INET
>> +	select NET_UDP_TUNNEL
>> +	select DST_CACHE
>> +	select CRYPTO
>> +	select CRYPTO_AES
>> +	select CRYPTO_GCM
>> +	select CRYPTO_CHACHA20POLY1305
> 
> and STREAM_PARSER for TCP encap?

Right, thanks!

> 
>> +	help
>> +	  This module enhances the performance of the OpenVPN userspace software
>> +	  by offloading the data channel processing to kernelspace.
>> +
> 

-- 
Antonio Quartulli
OpenVPN Inc.

