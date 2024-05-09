Return-Path: <netdev+bounces-94827-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69BF78C0CB0
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 10:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7F851F21F19
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 08:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5806413C8E7;
	Thu,  9 May 2024 08:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="aSlj/YyT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 681DB1D6A5
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 08:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715243972; cv=none; b=jhmPH/n9KIFrYSE5omO7LcrjwICLu41W6rUdlWt0m5Z0F2gx61x+BzGNqsM7oxMXddK3uvWMjgpdCcW1TPJLUSEoTVIxTL/xMo/PwC20efemRjh4wEJ832+x3n++Uz1CVjiKS0Nv+TYpU+kZabSx7FYhxSi6NiFkNbsIE23KEek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715243972; c=relaxed/simple;
	bh=BeuZ3x1jB4LdjWtXFS1gEqePzr+XowBOQECTOfqrwNU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wy6A737UxgnybFhK+JfMdvYHo1Jp4na+oyVxeTmOZ4sCRQO1b6tfYlxwoYPAMYF1RYEA3qtBGMfrKRi6q8FG+Oa3Mk2tAWvOg9TeuvDul3xjMPiTIAVqb2fEeCBqa7aB9QBkkToj7spfa4cs9VF96X1HJl8J/3gC/T/00IBHoWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=aSlj/YyT; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-792b8bca915so43187485a.2
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 01:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715243969; x=1715848769; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dlsEfC3epJh7DJ9fePkI3R60/oJ66hrdgZ1QXv62bJw=;
        b=aSlj/YyTx3rqRQxo/3H0MQoj7WZ0eVtgKIlquOFLGBq/EvMOeYfUtvL7jLqtzp2Uen
         RzhJZDQ4NRpPRJnawSOlsd8dVODu+67p0l+8jTfb8a+GuWVTnksQfGuD53Dfk91X1kqp
         dMzARxfL8X3LjwQsNko8eIoUsSm+gTSnADUWdsCUECfwan4ityOqxZhxxn+PWVJf69sP
         HYu0E95ATTDO0I1piDER5sliXEht1fOOVRLs68PALX9FSJC1dC/fvKWPKGKS7hHXfW98
         fbQN0HHHo72I5QIfm7Yz1tdO6S8eBsJ/pb1jUoF7kNiXZ3DYn1oaZ43C9wqay5Kt4A7A
         8/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715243969; x=1715848769;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dlsEfC3epJh7DJ9fePkI3R60/oJ66hrdgZ1QXv62bJw=;
        b=fOBWg3G1Me5HQnZuYdoYffRa7YqSLn7LUDttHurnnPOxeuqY6LHc77VW9bg/m8Aohy
         4JUVAbD9rkvS+ZvglH32GAm2nUbfaBlRNozljtA24m8WdsjYY3KWHh4tta0Zj46YvL0i
         ZnVmzHpPlfsO5zGGFuQxve975h2PLutDE2URVj4dSg1ucFJcJfv8qwJvhate0mvP9Do5
         jrp8PywD5880ia9BfTF6PI81k6X79rg3PCsoBotjFRhD6NZnScNmjwkvQnuECRgTVf9u
         G09Pnj9C1WmIHYbkVZmElBe1Z1qDmwsCiqrq+0Jyl0R25JvVGpvYMiXc2kSY+w+AtU8K
         /u7Q==
X-Gm-Message-State: AOJu0YzRHQWIvZHkgVqRn7igP3qcymMO9fjX72jNjaczWJRQtWJNLmEe
	xsHfqZzhqU/gd3iEo/+3kkzdEYipjCQeRidu/kiNkzzzj8gpx81abIGnKtMpnuU=
X-Google-Smtp-Source: AGHT+IH3QmvN2V3S+F+WU5cLXXgdWt61/xZ7b5hiZYaAXlLXqsxQRCeIWtcrZq3duHowPlQx3TfAjQ==
X-Received: by 2002:ae9:e604:0:b0:792:c26c:7055 with SMTP id af79cd13be357-792c26ca708mr24154385a.10.1715243969181;
        Thu, 09 May 2024 01:39:29 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:6fcd:499b:c37e:9a0? ([2001:67c:2fbc:0:6fcd:499b:c37e:9a0])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-792bf28c903sm43397885a.50.2024.05.09.01.39.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 May 2024 01:39:28 -0700 (PDT)
Message-ID: <75d07da4-0f0d-4870-914b-cce242b8dc54@openvpn.net>
Date: Thu, 9 May 2024 10:40:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 24/24] testing/selftest: add test tool and
 scripts for ovpn module
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 Andrew Lunn <andrew@lunn.ch>, Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-25-antonio@openvpn.net>
 <20240507165539.5c1f6ee5@kernel.org>
 <d32b5a97-df69-4486-98ae-f73d9f3fb954@openvpn.net>
 <20240508175013.1686e04e@kernel.org>
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
In-Reply-To: <20240508175013.1686e04e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/05/2024 02:50, Jakub Kicinski wrote:
> On Wed, 8 May 2024 11:51:46 +0200 Antonio Quartulli wrote:
>>>> +TEST_GEN_PROGS_EXTENDED = ovpn-cli
>>>
>>> TEST_GEN_FILES - it's not a test at all, AFAICT.
>>
>> This binary is just a helper and it is used by the scripts below.
>>
>> I only need it to be built before executing the run.sh script.
>>
>> Isn't this the right VARIABLE to use for the purpose?
> 
> I don't think so, but the variables are pretty confusing I could be
> wrong. My understanding is that TEST_GEN_PROGS_EXTENDED is for tests.
> But tests which you don't want to run as unit tests. Like performance
> tests, or some slow tests I guess. TEST_GEN_FILES is for building
> dependencies and tools which are themselves not tests.

I just re-tested and you are indeed right.
Will switch to TEST_GEN_FILES.

Thanks a lot!


-- 
Antonio Quartulli
OpenVPN Inc.

