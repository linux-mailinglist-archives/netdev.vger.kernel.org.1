Return-Path: <netdev+bounces-147346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129239D9390
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 09:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3EA73B20F59
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 08:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A1E1A00F4;
	Tue, 26 Nov 2024 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="I9fq4P6E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E6513C3F6
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 08:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732611043; cv=none; b=UdlwCcYz0j72al7ppohCwsV99SMQ7aUZ+SYzbEzAkCXY9epjLnrNfk8kCd14XepR0tA976VZPOPvLuu32ZtfAO+0tenN5HRDRayGvhQNT0WBzJ9TYuIj9+/wAVp+70zN6m2xqw8ma5QsV87coTLdlKhu1/hee9mRrRBGtAg/NsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732611043; c=relaxed/simple;
	bh=EWx5G62/Y+YK81DYJlbG2Y5wZ6MSFWgdnqYCuJyRwYs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qL8/Pqj8uuHHDOkC28UXRt3gDk3wvpqaoHtaO5spqNEekMHofvDBFhau/XCGMyhDzuJ5N+EGzq+a1nGZfOx72J3xEQuUBMDP6SdIZpS6op7g4s1i+f5J6CCKZi2aD8YLK9lq6Og1vyYdTgMZQ/OKl4Vr4pKK2ZlQIk47fp0NevM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=I9fq4P6E; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9f1c590ecdso872541066b.1
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 00:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732611039; x=1733215839; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LzEUGtqc8cId812bM5JKk2t37EetFQWHKlb1nkiKiBQ=;
        b=I9fq4P6Ex0vb7LAI+/PwJQZAhmpaJ3iGogRJtj9S1hBymhzQntoJj9owUhT2AAJq1p
         W1Z3iHnnWCqwLoIefyYaYWkTRqoGua5Gg3xZY7IL8e1YvTsIRXYxMGBf0zR/7WWAuseh
         dattqRS3wOii3wiq9oewTbIexHvpzYNM6PFZnu8LTnXc+P0QPMHMo/F5fbf9c28ZYjRC
         lZuz8dEATOcQW3UUdmsiGglqtD6k7ki6xrzz54YZx142MohwWWGWl1nP0gOG4tMOsB7N
         hneWfPHDN79WhaYDnc1UZBI6cswoXSzNoMnPMVJTQW/LAdFCyXcMOA9EokP8IsSQ6xAO
         SzGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732611039; x=1733215839;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LzEUGtqc8cId812bM5JKk2t37EetFQWHKlb1nkiKiBQ=;
        b=bxqTY5N06xNeJLWRZc+JftQ3Zu3225/M4HS5FFbYGWdG+PNBEanH2YzaLgtV2P0EYU
         MDsu+d/cx6LpPqTpfiSKf4z3sO5BoXg6EE+ad52lMaCBPCkOwQd5tO9R2UJxXb/gB8cF
         fYRI7NrfRO/Rr5jsxpprozqlYAQJQZN7i0qEmjC48kLhYTGnAyaj+H8mNz3PxavZq71L
         VkiETJ8KB5N7G1Z64goCeFKI4jrBkzYB2v88zC22xOJc9DpbOvrKT7whHQiyyS8iPdC7
         A7ivuj4Ta0bNJLkpARE9JgiZp04ELZdq72uTXIBhjmPRuNCwsyGoCcmNndWvzqJLhijH
         Z5hQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeCXAfFBhhtqieFeJQBzQ3CpSXyERihdNmj6EdeXdFUDCdscPqVq86O2i2JYlDffA+qAvj7e0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4RaYMeEKRzJNf0XNZfTNl3JUVPEEguQ/tAZ8Y6ISjJzYMGgBd
	PkPSqsf8gB+htgkkd+qH4CQ8WwyVlA4M58vKGDpJlMKxxeQdB1jk171X1+ongktSpY8Fi0TcmsD
	D
X-Gm-Gg: ASbGncvt9z1DE0OLr/iUr432mlp0c8I4T4m11+fmDK/pydLMB2IiUx/bvZgpyoBYvVm
	35ylM5pUOywWGa3LmK3pUL2exNPcnf2tmOc2STDy1hCUDz2yc7e9RMqk2FaaJiIhWUwwOCJtO7G
	55W7zSptFNGTaMD1bjShCK8Gel4GtFbPro6ILSdEfcAzIe/Dup81CEQ31GvHXPJUkgPpx9ziC3d
	bwbe0e8GmlnNvcsGDbWs6ZcZQ8A25lKcpwQWtIPMlfDBHYnBX0nb5UKDA+lnWlDrqM+7q95Fn0Z
	eIVX8pwZxG89
X-Google-Smtp-Source: AGHT+IHSAFZ5rtU6b5UjQuQxST2OcS5wvsAyeFG5HicRhvgtmWnl9FgBt8ILdVteCzPUlhuBGEBm3Q==
X-Received: by 2002:a17:906:1daa:b0:aa5:3853:553d with SMTP id a640c23a62f3a-aa5385358d1mr956149466b.46.1732611039375;
        Tue, 26 Nov 2024 00:50:39 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:9421:3351:41c6:fc75? ([2001:67c:2fbc:1:9421:3351:41c6:fc75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa50b345639sm573047666b.88.2024.11.26.00.50.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Nov 2024 00:50:38 -0800 (PST)
Message-ID: <08044f81-3b57-4abc-b04b-08de0f4735a6@openvpn.net>
Date: Tue, 26 Nov 2024 09:51:12 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 12/23] ovpn: implement TCP transport
To: Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-12-de4698c73a25@openvpn.net> <ZyOhe3yKTiqCF2TH@hog>
 <3df02a8f-72c7-4db9-bb46-a6529082b328@openvpn.net>
 <cf89c31c-7c49-4cd3-a69e-e56207c318de@gmail.com>
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
In-Reply-To: <cf89c31c-7c49-4cd3-a69e-e56207c318de@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/11/2024 02:05, Sergey Ryazanov wrote:
> Hi Antonio,
> 
> the question was addressed to Sabrina, but since I've already touched 
> this topic in the another patch, let me put my 2c here.
> 
> On 16.11.2024 02:33, Antonio Quartulli wrote:
>> On 31/10/2024 16:25, Sabrina Dubroca wrote:
>>> 2024-10-29, 11:47:25 +0100, Antonio Quartulli wrote:
>>>> +static void ovpn_socket_release_work(struct work_struct *work)
>>>> +{
>>>> +    struct ovpn_socket *sock = container_of(work, struct 
>>>> ovpn_socket, work);
>>>> +
>>>> +    ovpn_socket_detach(sock->sock);
>>>> +    kfree_rcu(sock, rcu);
>>>> +}
>>>> +
>>>> +static void ovpn_socket_schedule_release(struct ovpn_socket *sock)
>>>> +{
>>>> +    INIT_WORK(&sock->work, ovpn_socket_release_work);
>>>> +    schedule_work(&sock->work);
>>>
>>> How does module unloading know that it has to wait for this work to
>>> complete? Will ovpn_cleanup get stuck until some refcount gets
>>> released by this work?
>>
>> No, we have no such mechanism.
>> Any idea how other modules do?
>>
>> Actually this makes me wonder how module unloading coordinates with 
>> the code being executed. Unload may happen at any time - how do we 
>> prevent killing the code in the middle of something (regardless of 
>> scheduled workers)?
> 
> Right question! There is a workqueue flushing API intended for 
> synchronization with work(s) execution.
> 
> Here, the system workqueue was used, so technically a 
> flush_scheduled_work() call somewhere in the module_exit handler would 
> be enough.
> 
> On another hand, flushing the system workqueue considered a not so good 
> practice. It's recommended to use a local workqueue. You can find a good 
> example of switching from the system to a local workqueue in 
> cc271ab86606 ("wwan_hwsim: Avoid flush_scheduled_work() usage").
> 
> 
> And if the workqueue is definitely empty at a time of module unloading, 
> e.g. due to flushing on netdev removing, there no requirement to flush 
> it again.

ACK. I wanted to avoid using a local workqueue, but if we have pending 
work that needs flushing I indeed see no other way.

Regards,

> 
> -- 
> Sergey

-- 
Antonio Quartulli
OpenVPN Inc.


