Return-Path: <netdev+bounces-178775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C53A78DDF
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 14:09:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B719F188977B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 12:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FE33238D42;
	Wed,  2 Apr 2025 12:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cJo7Sg4i"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1062A238176
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 12:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743595770; cv=none; b=P/0vxtsnjC00XyPlnRaw2YUvnrv5k8+s7DzIHWs1Z19B6C3Zgzf3TpMMJZXuGNJpdNwxcMWkMFXlE0BfUTYo4YKtlXaDwdBxrBtkpNvAs9AAfw028tdqwvF6fRcG25gg0sHbxUWbLaXeMNNPAynwF/OVZ1hAFaizjtb9rv5jFi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743595770; c=relaxed/simple;
	bh=Wg1z8V2/B4JD/VkmMUX7ovFl6hWM6zd+l67RaMQrpTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RPfurm+kFp0ACrcGHg2psC3n35Bg7dA3Dm/1XF0EtB67UbU/G5zxSl1TlyG9GQyXkR3uDpg4DtjBg3QaizzJ6U+DUfikqZi2k5kl8X1rl3WIbHUWhSDZoUQqhQ7PmbQZAXOtEJjpV7nYQxpVYVR5Cj8vml1Vf+54+mRrypHgT4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cJo7Sg4i; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-43cfe63c592so67598555e9.2
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 05:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1743595766; x=1744200566; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=eueachpO8hQ6Q2p0BAINU/0/R0gnesEPxhmHrBEI/G0=;
        b=cJo7Sg4ikZUEn0oMGn7MVWau6iGXo31IHfSjlXg5pOtb9GmB4twa+TxRlXiA0wumnc
         47ebRkCVtRoFbMdva+jCMIHsz6Pb0J64IeA/I5QmJyZ44D8el2ttOTdPivRl0T5355Wl
         0e1zjz78ddjFvtpiCbQsGxRTx69BbTCRLVnaksXMxjUXb2VXP40XhMO8zr/tHom4rNh3
         5P4XUZy89/1rw6R6/uqQE1y4w89msZgADn8qZB+ZdkDLuNMudcCvYXx91Q2Q0SQMQW8v
         Mi6HqWNX0zAJlzDK9BgFVg9I16rHjQt9ZK/FVm8WKZXnoQDBmp9z+S+gUuG7Xrg986vK
         Y0QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743595766; x=1744200566;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eueachpO8hQ6Q2p0BAINU/0/R0gnesEPxhmHrBEI/G0=;
        b=o4IGaCyaOP2x59nmXiBcJpGI7EWvGKqN7ApPoAoLxjU2HMTXlfUHfRNFM7Bn28RxCY
         8nxKioCDJPZCJAs8pkAjuzGgI8PjojdfBEnpaRWIotY4185ybZhxQPY9qu8UQq14cO53
         CtsJpEMmwh4eWhgq8Oqtu9itOhXlcYMwWrK1LJhl0OwF7C75zakqS8uEdCQqJfFnKci0
         o+kAHh0RobmTUYc241GnZKzL8OFLlD0KUHhW2tBLTDHiExZ+AEuwEj743N7H791dQ43Y
         SEvSZZv+QqtlLqdw+Lqw/Ytb70PegirkncXJmSvihm25pBshFnvzbTTHy0BaWYP5NQiJ
         WQFg==
X-Gm-Message-State: AOJu0YxjzqoYVZNTRel3beko6A6l/Hi81Xlp9WINqbedtLq1qQ0b3K6j
	5/5yqr0nuFrfgpa1gU5zCj+S7VMtP0LZgC3QhmMsrFSFiMXhtH0Or5ZBvdE3/B5A8YdS6HTUVfR
	6/Qc3JUDctbFB3go5uQI9unbW75jbZxzfm9NZIlVi21TJmdA=
X-Gm-Gg: ASbGncsel1/KaesVWb6G/UejxXXeEGZjn70WXxkb3wHBRpjmgIaVy+31K6KtQip3XkR
	Jgdyy+8WJRoIesn4wUoQVIxUQJ7fTwiR1pzCZ96i+Iyc/+6CdDZ+Hf1Ze43XLi3RKbe/At7zruB
	RZ9iA9tUUvxVAM6tAcFkIpVZAm6W0WaLkYSHhT+93uSm+6D9RHxczyvnJMisf4MyJYc80JSSF73
	AJTxJLNcyvtmDUnG4Y+Nnvbqg/MWvIU6iY6XgIanu3GLMILI1ZkW/cwL6wPFAlxkWQijfcf6kBf
	4q/wgUpfKgXjbjC3uJS86ezLCYvUbjh5PyXW64QuHLGH/RprGvFktiWuZ744Lcrwtg1ZRNu9VSn
	XuhFIttU=
X-Google-Smtp-Source: AGHT+IHUJyVBy/0cEmsudb9JcD3QHGxVskeByPbbtSCTtTi/9G7QE7GiUjn+wuDNWq5WTPOnlwj9NA==
X-Received: by 2002:a5d:47c6:0:b0:391:2c67:7983 with SMTP id ffacd0b85a97d-39c12114efcmr12355213f8f.39.1743595766297;
        Wed, 02 Apr 2025 05:09:26 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:9a9c:dc9e:39c6:2380? ([2001:67c:2fbc:1:9a9c:dc9e:39c6:2380])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b66a75fsm16575022f8f.41.2025.04.02.05.09.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Apr 2025 05:09:25 -0700 (PDT)
Message-ID: <5ad8a942-ccd3-49fb-9835-fe8b081e6150@openvpn.net>
Date: Wed, 2 Apr 2025 14:09:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v24 11/23] ovpn: implement TCP transport
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>,
 David Ahern <dsahern@kernel.org>
References: <20250318-b4-ovpn-v24-0-3ec4ab5c4a77@openvpn.net>
 <20250318-b4-ovpn-v24-11-3ec4ab5c4a77@openvpn.net> <Z-u5p_QLkLKtcxsb@krikkit>
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
In-Reply-To: <Z-u5p_QLkLKtcxsb@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 01/04/2025 12:02, Sabrina Dubroca wrote:
> 2025-03-18, 02:40:46 +0100, Antonio Quartulli wrote:
>> +static void ovpn_tcp_rcv(struct strparser *strp, struct sk_buff *skb)
>> +{
> [...]
>> +	/* we need the first byte of data to be accessible
> 
> nit: and "first byte" here too (that comment could maybe just be dropped?)

ACK.

Regards,

> 
>> +	 * to extract the opcode and the key ID later on
>> +	 */
>> +	if (!pskb_may_pull(skb, OVPN_OPCODE_SIZE)) {
>> +		net_warn_ratelimited("%s: packet too small to fetch opcode for peer %u\n",
>> +				     netdev_name(peer->ovpn->dev), peer->id);
>> +		goto err;
>> +	}
> 

-- 
Antonio Quartulli
OpenVPN Inc.


