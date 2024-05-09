Return-Path: <netdev+bounces-94938-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB72B8C1098
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 15:45:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4429E1F2113D
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 13:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08396158D69;
	Thu,  9 May 2024 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZbVbaKL8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E134C13FFC
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 13:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715262338; cv=none; b=lq1bsv5lNyuHVNfjiFdclmt+8fhnyeNe2rrWSF4Ne7mciqSkDAdG7X4jqC4KeRRkeIdExeXtFTF6GA8R3vK4CModUP40VUVeqZ4/4kjBJhQJL5apCC4F/qLT6eKCBWcKzzWYHKEUkIizL1NGfPAYFJ4Ovq4JzxQhkEc/MFP/BEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715262338; c=relaxed/simple;
	bh=jM+yc1AUi5kGvRGaf0dm2vQJF5JYKArXCe4c/hAUnVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awEtWyENLYyI2tkwZy9uWvGq3FRWk1DdV2o94kYvm+sgQWU+dpO0gnyg1SVY2unB+wK5PhJI9KH5fVA6Py0WpgUotgaMSLmTMiGYzQ2HEzDGUi3FCMbIz2cjqvAeeFubMp3MNQMrxPeBqYHRF4N+/9AGc6lakQH0DucN9JcWFOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZbVbaKL8; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41ba1ba55e8so6094375e9.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 06:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715262335; x=1715867135; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sMktLJu1U8niDfDGtQP1VO3fzjjUpt9MkpKE4ypLHCU=;
        b=ZbVbaKL8zuQwrS4jn+hsO//jpVSxtpZnyY9ac1JXjN0ZKkVCfZXu6mGgfNgdsgAJ9V
         x5gPbP5wYyBgxMn0YkGYSyDcc/IISB4YzqeoMT8j0CGJzW/qJ43z8KWV6FPta0+buKYN
         H2/gp4/EXakRMuS0+EsASsLvHSfQCJUVnNcy0vGTOoIQxBEHhLjkkSFznpyEDBmCRHx4
         o90UTwZgDEWkogZJ2HjyzSlrT3aZGQTBrLkgpZoFvuG0A3Z6auSYImn3oViE0CMv3Gqb
         My/6WEAVEDWR0CTOtmHYMVrfexIx2s0qZVc7kru8MHoKJz3paozAUPcN4BJj8TxwFHNh
         RN4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715262335; x=1715867135;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sMktLJu1U8niDfDGtQP1VO3fzjjUpt9MkpKE4ypLHCU=;
        b=SEJHeaat4VQzhMKwr7hkWA7A0vBBkTFyD8Kau20eQOV+M1jaYfteCv3YWcT3b65zHS
         D+uf4O6qyoCLRzOhIlfAU+sfaNfBHyixH4WPZ+BApBVoYlaO/+A7c1TSegaGMy7yLZ1Q
         pJQgkvBW4ab/JF7ReIvctE9PDOODXAISY7e17/Sa3ngtGeIXRe72j2xRdBdculxC3NZY
         jG1MzQytKnyyV2846dTJA7Z6ZJgD7AY3LJjlaWnTceVx6qY4k3hPP2ItFhPhwwB1X8g6
         DSfAgGI8U61rZNnoWDooruB3gaF3Qzc2sN4fAcn6py5jCS3a04w4dUMIopaosFbCYBup
         44OQ==
X-Gm-Message-State: AOJu0YwDKKiM3aqq1xMDmtk1R1MbuRatQCYMI7LjiFKyJlJ7KOjFmXex
	a79DN7vLR1ZsLdOncsdZq/x064Mp0eauXcBmvC7YPsssrn73jLW0TiNVHtWbmiE=
X-Google-Smtp-Source: AGHT+IEkOxZgWNmNt/GPvenbt9U+wTSEiaidHaOWMGZxbNjN3fgbNqwZ6zhJkB0/SCIuSl2kY12zfA==
X-Received: by 2002:a05:600c:3496:b0:41f:202e:36f0 with SMTP id 5b1f17b1804b1-41f71ccc463mr45908255e9.12.1715262335190;
        Thu, 09 May 2024 06:45:35 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:6fcd:499b:c37e:9a0? ([2001:67c:2fbc:0:6fcd:499b:c37e:9a0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41fccee934csm26027185e9.38.2024.05.09.06.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 06:45:34 -0700 (PDT)
Message-ID: <bf6ee90f-d0db-435d-96cb-c715ecab3afc@openvpn.net>
Date: Thu, 9 May 2024 15:46:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 08/24] ovpn: introduce the ovpn_socket object
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-9-antonio@openvpn.net> <ZjuyIOK6BY3r9YCI@hog>
 <53dc5388-630f-47e1-a6c1-6c3bb91ee2ac@openvpn.net> <ZjzQgog9NfFiR6CP@hog>
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
 jeWsF2rOwE0EY5uLRwEIAME8xlSi3VYmrBJBcWB1ALDxcOqo+IQFcRR+hLVHGH/f4u9a8yUd
 BtlgZicNthCMA0keGtSYGSxJha80LakG3zyKc2uvD3rLRGnZCXfmFK+WPHZ67x2Uk0MZY/fO
 FsaMeLqi6OE9X3VL9o9rwlZuet/fA5BP7G7v0XUwc3C7Qg1yjOvcMYl1Kpf5/qD4ZTDWZoDT
 cwJ7OTcHVrFwi05BX90WNdoXuKqLKPGw+foy/XhNT/iYyuGuv5a7a1am+28KVa+Ls97yLmrq
 Zx+Zb444FCf3eTotsawnFUNwm8Vj4mGUcb+wjs7K4sfhae4WTTFKXi481/C4CwsTvKpaMq+D
 VosAEQEAAcLBfAQYAQgAJhYhBMq9oSggF8JnIZiFx0jwzLaPWdFMBQJjm4tHAhsMBQkCx+oA
 AAoJEEjwzLaPWdFMv4AP/2aoAQUOnGR8prCPTt6AYdPO2tsOlCJx/2xzalEb4O6s3kKgVgjK
 WInWSeuUXJxZigmg4mum4RTjZuAimDqEeG87xRX9wFQKALzzmi3KHlTJaVmcPJ1pZOFisPS3
 iB2JMhQZ+VXOb8cJ1hFaO3CfH129dn/SLbkHKL9reH5HKu03LQ2Fo7d1bdzjmnfvfFQptXZx
 DIszv/KHIhu32tjSfCYbGciH9NoQc18m9sCdTLuZoViL3vDSk7reDPuOdLVqD89kdc4YNJz6
 tpaYf/KEeG7i1l8EqrZeP2uKs4riuxi7ZtxskPtVfgOlgFKaeoXt/budjNLdG7tWyJJFejC4
 NlvX/BTsH72DT4sagU4roDGGF9pDvZbyKC/TpmIFHDvbqe+S+aQ/NmzVRPsi6uW4WGfFdwMj
 5QeJr3mzFACBLKfisPg/sl748TRXKuqyC5lM4/zVNNDqgn+DtN5DdiU1y/1Rmh7VQOBQKzY8
 6OiQNQ95j13w2k+N+aQh4wRKyo11+9zwsEtZ8Rkp9C06yvPpkFUcU2WuqhmrTxD9xXXszhUI
 ify06RjcfKmutBiS7jNrNWDK7nOpAP4zMYxYTD9DP03i1MqmJjR9hD+RhBiB63Rsh/UqZ8iN
 VL3XJZMQ2E9SfVWyWYLTfb0Q8c4zhhtKwyOr6wvpEpkCH6uevqKx4YC5
Organization: OpenVPN Inc.
In-Reply-To: <ZjzQgog9NfFiR6CP@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/05/2024 15:32, Sabrina Dubroca wrote:
> 2024-05-08, 22:38:58 +0200, Antonio Quartulli wrote:
>> On 08/05/2024 19:10, Sabrina Dubroca wrote:
>>> 2024-05-06, 03:16:21 +0200, Antonio Quartulli wrote:
>>>> diff --git a/drivers/net/ovpn/socket.c b/drivers/net/ovpn/socket.c
>>>> new file mode 100644
>>>> index 000000000000..a4a4d69162f0
>>>> --- /dev/null
>>>> +++ b/drivers/net/ovpn/socket.c
>>> [...]
>>>> +
>>>> +/* Finalize release of socket, called after RCU grace period */
>>>
>>> kref_put seems to call ovpn_socket_release_kref without waiting, and
>>> then that calls ovpn_socket_detach immediately as well. Am I missing
>>> something?
>>
>> hmm what do we need to wait for exactly? (Maybe I am missing something)
>> The ovpn_socket will survive a bit longer thanks to kfree_rcu.
> 
> The way I read this comment, it says that ovpn_socket_detach will be
> called after one RCU grace period, but I don't see where that grace
> period would come from.
> 
>      ovpn_socket_put -> kref_put(release=ovpn_socket_release_kref) ->
>        ovpn_socket_release_kref -> ovpn_socket_detach
> 
> No grace period here.
> 
> Or am I misinterpreting the comment? There will be a grace period
> caused by kfree_rcu before the ovpn_socket is actually freed, is that
> what the comment means?

Forgive me - only now I realized that you were referring to what the 
comment says.

That comment is just totally busted. I think it was there since the code 
was doing something totally different and was carried over and over by 
mistake.

Sorry

-- 
Antonio Quartulli
OpenVPN Inc.

