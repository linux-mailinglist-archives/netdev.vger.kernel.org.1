Return-Path: <netdev+bounces-107126-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE8D919F7F
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 08:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7611C21576
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 06:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432242E40D;
	Thu, 27 Jun 2024 06:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="GDp64eVD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F30CC24B5B
	for <netdev@vger.kernel.org>; Thu, 27 Jun 2024 06:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719470669; cv=none; b=FdADgP0SABsEfWEsIPnwb2WJvrKoC6TKFuaGnGdDFVjJHsvEzwGoJtc4ier1wycE6avtkiXtuhIZvalRBAg1H6MoqP+0mOEFkD5ebTW+SWF29Ja5ehSqrnBZJtdIHDYOLeQndKvN1NSrbLxCq04zR4zyJpPL/b7sf6o5V8E41F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719470669; c=relaxed/simple;
	bh=Ts/UAWvVPIaN6g5Qfqo5XACZ7GMmdwOCjoRBIKPkSxc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXS0YwgZpH8lu0RApzoTh6BIOJaajo8lA66AKrXk0pe5fv2MywLGQTH4Uc5tw45NIPQSoQMfEDfU0BxYqpjm/0MB7Jf37hGJhqbaomkMwU0B9rIvD8dHtVvhg9VcC6xfNRtzNm43RcyV7nRijH96Egxebnm+IJhDDyTzL9oEJmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=GDp64eVD; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57d251b5fccso1365326a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 23:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1719470665; x=1720075465; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=AAJ/NpIKLZ7qXcpHMgCYx2ax1QnGFyFzggmNyT7Sj3M=;
        b=GDp64eVDOKCTdb+fyd1eWJfyoq0uoBtt3CNZTnyOjCuMKI7vTgM7beI7m8gbSAyQ26
         JxvDh4vYJAIOXdFGJO7uaejxf2p/7wpaB9tGDNwE2rnYF/dziQQnFdEQM2nL0sMiT1L7
         TQJV4Tf93pPsb2tWfDYLTYw0QaowH/20LAag0vYJt+FnRA6QuSafLxI/FuJvKSfP/nZl
         W8OMLZokHF6+mOe4he/eWITYt2/ddsQY7Z1sz5NSTA8pmgqnmgT97ASk4fkJer4WvYd9
         Z/m1pCJ3tgXKB8Q3p6tdLQiN5XrRkoCc8/n4lLCTClFMWwd7fjFaSw99657ZuL7ARgGI
         Q+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719470665; x=1720075465;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAJ/NpIKLZ7qXcpHMgCYx2ax1QnGFyFzggmNyT7Sj3M=;
        b=KjXhWuPgxy9N1407/5DJFH5HWgGMzQxWZrXB8/xW4oGRrpR3KD/9zG4W+sjaooCR9N
         XNGXjL4RMoBs6iwal0YNMpysCSjBc4D1qEqqIciOsVpLCcoAGjHPvgjC8Yh2KW7aRYG4
         i6+d8RQjZKo35kkCeB/lnxMDvwJ+FCM2dNGKj1RPQ0hnvyqMP3O/SkbpghK19TLsyllo
         Cx0FnzZwRr2YLr9gf5+5pBO0eduaMA2JSghmODTs+XyzSAmYrIJLVQh+UfgT/jTnnfCP
         nTx1cuRLpGyPVBEBwtNby1V/vWHw2T9wUfnQK55yGiTmKLMnySz31FwYcs2/YRVxxdqB
         4cxw==
X-Gm-Message-State: AOJu0Yyand5Wi/xc3NyVYFGevZIxMtFjWGp3aRIinWAtAX6RmmbGcNPo
	hJb2y5ZPRyKACu8139IEPlqK7PeK+4w90lshpGvrDYP/JMTa/XmRQqpx9P8mW0o=
X-Google-Smtp-Source: AGHT+IEXFKLHhSjOocOrBAYs1kSxZ7uZMub77cGHstwjpd639hDBip3VZMkBgQUobqOO9HAbrOyYsA==
X-Received: by 2002:a50:a417:0:b0:57a:4c22:c0 with SMTP id 4fb4d7f45d1cf-57d4bd6060amr8616813a12.10.1719470665232;
        Wed, 26 Jun 2024 23:44:25 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:2bde:13c8:7797:f38a? ([2001:67c:2fbc:0:2bde:13c8:7797:f38a])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-584d27816f9sm457009a12.75.2024.06.26.23.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 23:44:24 -0700 (PDT)
Message-ID: <78a52cae-2ba8-428b-9b7a-96c96046b2a4@openvpn.net>
Date: Thu, 27 Jun 2024 08:46:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 25/25] testing/selftest: add test tool and
 scripts for ovpn module
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, ryazanov.s.a@gmail.com, pabeni@redhat.com,
 edumazet@google.com, andrew@lunn.ch, sd@queasysnail.net
References: <20240624113122.12732-1-antonio@openvpn.net>
 <20240624113122.12732-26-antonio@openvpn.net>
 <20240625081440.7f65e069@kernel.org>
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
In-Reply-To: <20240625081440.7f65e069@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 25/06/2024 17:14, Jakub Kicinski wrote:
> On Mon, 24 Jun 2024 13:31:22 +0200 Antonio Quartulli wrote:
>> --- a/tools/testing/selftests/Makefile
>> +++ b/tools/testing/selftests/Makefile
>> @@ -67,6 +67,7 @@ TARGETS += net/openvswitch
>>   TARGETS += net/tcp_ao
>>   TARGETS += net/netfilter
>>   TARGETS += nsfs
>> +TARGETS += ovpn
> 
> why not net/ovpn ? I don't mind, but non-networking people will have
> harder time placing ovpn on their mental map without it being under
> net/.

I just put the ovpn folder next to wireguard, hoping it was the right 
thing to do :-D

But it makes sense to move it to net/. Will do.

> 
>>   TARGETS += perf_events
>>   TARGETS += pidfd
>>   TARGETS += pid_namespace
>> diff --git a/tools/testing/selftests/ovpn/Makefile b/tools/testing/selftests/ovpn/Makefile
>> new file mode 100644
>> index 000000000000..edd0d7ff8a12
>> --- /dev/null
>> +++ b/tools/testing/selftests/ovpn/Makefile
>> @@ -0,0 +1,15 @@
>> +# SPDX-License-Identifier: GPL-2.0+ OR MIT
>> +# Copyright (C) 2020-2024 OpenVPN, Inc.
>> +#
>> +CFLAGS = -Wall -I../../../../usr/include
>> +CFLAGS += $(shell pkg-config --cflags libnl-3.0 libnl-genl-3.0)
>> +
>> +LDFLAGS = -lmbedtls -lmbedcrypto
>> +LDFLAGS += $(shell pkg-config --libs libnl-3.0 libnl-genl-3.0)
>> +
>> +ovpn-cli: ovpn-cli.c
>> +
>> +TEST_PROGS = run.sh
> 
> Could you list the scripts individually under TEST_PROGS?
> Maybe add a wrapper for the script that needs to be run with an arg?
> Doing so will integrate with kselftest better and let us track each
> script individually in CI, rather than have one "ovpn / run" test case..

This was my shortcut, because I needed to call the same script twice 
with different arguments. So it was easier to use a wrapper script.

But I'll look into how to properly achieve that without using a wrapper.

Will send v5 shortly then.

Cheers,


-- 
Antonio Quartulli
OpenVPN Inc.

