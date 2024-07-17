Return-Path: <netdev+bounces-111865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A782933C0E
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 13:15:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16C9A2822AC
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 11:15:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D614517F4E1;
	Wed, 17 Jul 2024 11:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="XrqbKVx4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AB4017F398
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 11:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721214896; cv=none; b=RLca/s1rOxHvaHmC/BhPDIfVCZkQKIUMm7C8rBcVKDITtJcbO/Bojv6sQ4Fjcme33k1VjBt7sx+8ZkgbbsC6W4UNlNwYA6IGCPCJkSY7m6OOzKNN5Sv0jSftNhjeVOFQ+gLFlaj0/L4pJuqAw4uynJC/AbrGu8mku+ZiMgCflSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721214896; c=relaxed/simple;
	bh=Qb4WiWxYGqH2MVdH81ULVX23ZalvYuhZMQM//tdZzjQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i6NnZXeyFg3OQ0MfdEx8u3+Tr49xZwrRd1AQ4abrSK/KnTRM1iG7YlPGQmYoIwWMjTPOHu2Gk02O01Ha6yZX+NDQY50sCxln8fvi+p4z1Z8PtXYhBfR/tIKkZ518KfnZhe5CYlPSw/oQsk6Nds3GXJ55hRyYTnbG73EZdCYFv0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=XrqbKVx4; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-59f9f59b827so2020382a12.1
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 04:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721214893; x=1721819693; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=6NBC0F09vWUXQLem97ovSRXEr04B6B6Qv/fkvPg7Dxc=;
        b=XrqbKVx49dF8owIoDDWYslPJCp4rgizjIWs8EKTIj+ezaWXFreXU5BSEC63WQ5AetV
         WRw/ANF8A8xJqoEckr5FVM3vZo/VGg9h/MZ4tPjl+oEAXnJSIP2DqnNaVVjoqotlul+D
         ii6XkMh9sVAHDVECfoTVBvg08XRqD/VjiGeBWWwUoS7wi49Ki6vWQnWN95Av8Ez66v2X
         O8FHbpXszmWuzVhvq3e8j0TGleu7afkHte30fNLSchwiBMeWzHbqNf22xu2ftYxjVAPD
         2MzGWV66tUKW+ltTnK1waBUiXbzduw9z1t27Sjzv3xkvaejMyYU9w2VJpba9736DJ/vi
         Rdgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721214893; x=1721819693;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6NBC0F09vWUXQLem97ovSRXEr04B6B6Qv/fkvPg7Dxc=;
        b=A/5DLlHnkzVe2xJvgYw+m+jwOwMGbvGb7nSJfbd9FcH8GzLEPDUBxBMObmKqxX0S5U
         B/1bJ5yzujaEAvmGDQOosox9hs/zYxBcCmq3bgZ+mwznMWlIrz72vdIsvg5RrrH5DDKm
         8XLIiEMg3KZcLsxOrCxj5hn2DprXiE4nd3m52ow8Ay166sZfobbc+0InG7gELagVT2K8
         5oWAQZC3Xk+n5KJGWLcWFZL7b/Tt6hbCh+nkvCa0qGVpBIjqGjnx11b7LaYQia2dq0Fv
         TvX1f6NFKNw8dddaoIErzkj4MjnHlrRLgjMXLGA85wwE6FKxpVy8q4DP6FmvX5NyhzWN
         cgQg==
X-Gm-Message-State: AOJu0YwQmdzbuYLaAZBhJm9EqoKaz4m0qEzfRDNAxl3Xw6a3tm9vQAmF
	yEDReQ6sahNfRqUEyxXoGfadRNXCO3BjK3qB/e/eBudc0i+CjlJUbFNjr2vvgPNX8Bvn15/nvL6
	J
X-Google-Smtp-Source: AGHT+IG8wT8+XionTEBPAfJiBdWbXvF2KjjJclfMX0Yxw1g/wKMfgTzq98jSzB68kCUCrfXrqPh29Q==
X-Received: by 2002:a50:d713:0:b0:59e:9f15:efc1 with SMTP id 4fb4d7f45d1cf-5a05d5c6c87mr1074853a12.36.1721214892831;
        Wed, 17 Jul 2024 04:14:52 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:4c30:cffb:9097:30fc? ([2001:67c:2fbc:1:4c30:cffb:9097:30fc])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59fa2d7d87dsm2263141a12.31.2024.07.17.04.14.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 04:14:52 -0700 (PDT)
Message-ID: <ab4cb84c-afcf-40e7-a5ed-af5f764af10d@openvpn.net>
Date: Wed, 17 Jul 2024 13:16:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 23/25] ovpn: notify userspace when a peer is
 deleted
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-24-antonio@openvpn.net> <Zpeizmu-FOHCsPy0@hog>
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
In-Reply-To: <Zpeizmu-FOHCsPy0@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 17/07/2024 12:54, Sabrina Dubroca wrote:
> 2024-06-27, 15:08:41 +0200, Antonio Quartulli wrote:
>> diff --git a/drivers/net/ovpn/peer.c b/drivers/net/ovpn/peer.c
>> index 2105bcc981fa..23418204fa8e 100644
>> --- a/drivers/net/ovpn/peer.c
>> +++ b/drivers/net/ovpn/peer.c
>> @@ -273,6 +273,7 @@ void ovpn_peer_release_kref(struct kref *kref)
>>   
>>   	ovpn_peer_release(peer);
>>   	netdev_put(peer->ovpn->dev, NULL);
> 
> I don't think you can access peer->ovpn once you release that
> reference, if this peer was holding the last reference the netdev (and
> the ovpn struct) could be gone while we're accessing it in
> ovpn_nl_notify_del_peer.

I see what you mean.
I will move notify_del_peer up above, before the release

> 
>> +	ovpn_nl_notify_del_peer(peer);
>>   	kfree_rcu(peer, rcu);
>>   }
>>   
>> diff --git a/drivers/net/ovpn/peer.h b/drivers/net/ovpn/peer.h
>> index 8d24a8fdd03e..971603a70090 100644
>> --- a/drivers/net/ovpn/peer.h
>> +++ b/drivers/net/ovpn/peer.h
>> @@ -129,6 +129,7 @@ static inline bool ovpn_peer_hold(struct ovpn_peer *peer)
>>   
>>   void ovpn_peer_release(struct ovpn_peer *peer);
>>   void ovpn_peer_release_kref(struct kref *kref);
>> +void ovpn_peer_release(struct ovpn_peer *peer);
> 
> nit: dupe of 2 lines before

ops

Thanks!

> 

-- 
Antonio Quartulli
OpenVPN Inc.

