Return-Path: <netdev+bounces-111883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 429E2933E26
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 16:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9812A284985
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 14:05:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8C98180A8D;
	Wed, 17 Jul 2024 14:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ZGC6niYx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038D1802A3
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721225141; cv=none; b=cgBWRC8JOGLrgR1xyiLGiUqAPi5p2zKcwJjJIcfJ0iB8tVtrFCOA2JP2SIuSNCHnR362hFx3du+YybYFb+pDYH/nr883T1qTBi0w6ES+paIpQw09zlWxblW7CRurYkng6vrgzs4TgYUUKHkr/Op21LrtFWMtAPJF8RIP4p7Vmlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721225141; c=relaxed/simple;
	bh=NlY7LOyEgRV28JMMZjEvpxN9ScO1llGDvocy+W5H/cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sXoGIDQeAPzMzzG8F+88CeCQjH+Ij58fzlpPk0sqVaasyboWgS4fIN4t6qnXK1t/tm+C3h54EehMaJZxn06kI1CjAoJ1xJt680EFLIZ0qpkgF/eKy/JGU1Sb+EYgVp71d0cLM9w6hkpqOx+28IznVnJctLf//+x2CEBzkX67oso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ZGC6niYx; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso712519766b.0
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 07:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721225138; x=1721829938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dgWCNSKhgtmVunehI6EAumprIeAoePTiA1aoGRjPfkc=;
        b=ZGC6niYxZzZNva6kTaGVcD+R83nDlvlMg2OoMAtsgJG7y7gM6fU/FAoD1Gdd/CXD0y
         Hw4jJBWFE5iXPU3XSO4gVy7h1SbBDIDhKYGqbHFpcgs/hjFKSM6z+8idJoBahSB/IpWR
         187F0BysEINe+BJtrP/jmlLT8U8RWsPUO/aN5QMRre5pgLahl/lRfiAgxSQ6aBqhrmkV
         vhQcJ2nyiShAiII2SDcJXUr3zVtyOkz0o2w74WkifAmo9WZvVZWHelU+1dq0x/zlOl4v
         qDz0mmA1jcif0FoyLmqAXYLg6gvp6hnvJO28O41qlUk9n3LLusKZt+yGhmSdGvK2yXcK
         4X3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721225138; x=1721829938;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dgWCNSKhgtmVunehI6EAumprIeAoePTiA1aoGRjPfkc=;
        b=XmdfUwZT4WBFC5mOSmQHvfAUTpmRdAXbY16m1ZiBB9mJ2XoVieIwUKRtU90kpoFXQg
         BF1K2rNdWY+0k3HVQNkuSHdOkeucbTGyjkaXsD2/YIk+WGHLztFeFhM5knYrND+vG1/9
         GWTM7N8wfVYCP/xNHEyiBp3e9UHPLxd22nEraVI+yrHYGtJDzZeZGLkWfmpot90erXBp
         WDlY7MnWqDQZf8GSj9gxp+QKc/mYctYdiOqSgBraDCB8fCni6C/ngKc62F1cGzTwJO0d
         FZVCVoTTyGwaurexnsH/TGYf6lvluNSWs9+N52ORvjDqpJtSg2SfQquWCNpid3XcPMKM
         RbLw==
X-Gm-Message-State: AOJu0Ywrol9oo7150xH4VygsgZYKUMxCcU4/jopj3LtS+f/ROzu0K5wf
	Txxb4X0zhJF9M0ZNESat92syRANBajJQB4Xsbxk+/+Jr4V9EsqlsfRZru2LLuUw=
X-Google-Smtp-Source: AGHT+IGqC+2j7CSHkjHALJD45lid1yeTIJ6ut11HBVrffzvjicKDHyvZMt4/7Yiwili9SRQGcRuKgw==
X-Received: by 2002:a17:906:454a:b0:a77:ab40:6d7f with SMTP id a640c23a62f3a-a7a011c2080mr136610166b.43.1721225137717;
        Wed, 17 Jul 2024 07:05:37 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:4c30:cffb:9097:30fc? ([2001:67c:2fbc:1:4c30:cffb:9097:30fc])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc5a3a3bsm448393066b.34.2024.07.17.07.05.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 07:05:37 -0700 (PDT)
Message-ID: <2be7caf2-33ea-4e38-bb84-0886220cfc48@openvpn.net>
Date: Wed, 17 Jul 2024 16:07:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 16/25] ovpn: implement peer lookup logic
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-17-antonio@openvpn.net> <ZpUf_1gdsZvoLYbn@hog>
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
In-Reply-To: <ZpUf_1gdsZvoLYbn@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 15/07/2024 15:11, Sabrina Dubroca wrote:
> 2024-06-27, 15:08:34 +0200, Antonio Quartulli wrote:
>>   /**
>>    * ovpn_peer_check_by_src - check that skb source is routed via peer
>>    * @ovpn: the openvpn instance to search
>>    * @skb: the packet to extra source address from
> 
> nit, just noticed now but should be fixed in patch 12: s/to extra/to extract/

argh. thanks!

> 
> [...]
>> @@ -324,11 +576,11 @@ static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
>>   	struct sockaddr_storage sa = { 0 };
>>   	struct sockaddr_in6 *sa6;
>>   	struct sockaddr_in *sa4;
>> +	struct hlist_head *head;
>>   	struct ovpn_bind *bind;
>>   	struct ovpn_peer *tmp;
>>   	size_t salen;
>>   	int ret = 0;
>> -	u32 index;
>>   
>>   	spin_lock_bh(&ovpn->peers->lock);
>>   	/* do not add duplicates */
>> @@ -364,30 +616,27 @@ static int ovpn_peer_add_mp(struct ovpn_struct *ovpn, struct ovpn_peer *peer)
>>   			goto unlock;
>>   		}
>>   
>> -		index = ovpn_peer_index(ovpn->peers->by_transp_addr, &sa,
>> -					salen);
>> -		hlist_add_head_rcu(&peer->hash_entry_transp_addr,
>> -				   &ovpn->peers->by_transp_addr[index]);
>> +		head = ovpn_get_hash_head(ovpn->peers->by_transp_addr, &sa,
>> +					  salen);
>> +		hlist_add_head_rcu(&peer->hash_entry_transp_addr, head);
>>   	}
> 
> These changes to ovpn_peer_add_mp (and the replacement of
> ovpn_peer_index with ovpn_get_hash_head) could be squashed into the
> previous patch.

hmm true. will do.


Thanks!


> 

-- 
Antonio Quartulli
OpenVPN Inc.

