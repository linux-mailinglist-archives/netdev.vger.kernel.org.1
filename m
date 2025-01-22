Return-Path: <netdev+bounces-160220-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E09A18DFC
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 10:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A12416341C
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 09:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AE220FAA6;
	Wed, 22 Jan 2025 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="cwDoOrZl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587AB1C4609
	for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737536404; cv=none; b=jhQLt4J0nEis6yvIcRirVrWolKA3F/2qEit2b95/0Hh9WTfghZJjffgHb3YW+4mIndN1SLjCfzMGUSMDalH30ssyTEQC5a3FzfPoUro4FhB7UlG8tG62Bv65aMSqQVoj3orIqzJO4kwg+3sLbqfEwsRDm35moQ9TTCkqqFxCITA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737536404; c=relaxed/simple;
	bh=/RR9M6/9SpnN8rCBEtvlWtbQhoj1ImP4ZPMQ6mUeN8o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tg9/pbrIveJe547XhER18R0jk2JmLDmC5lhEygFrtcepNW4os9khZ9OssypwYG5bDYKHKi3BOdSOFLsbOQg8DFLFaOvVhhCVH2z8D5d/r78iW5k5hLC3/oTj/9+SwDmOUkLp8K2U90mfmemWQsTls7h/NQEVNDGo5d42RweHsRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=cwDoOrZl; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5da12292b67so10568042a12.3
        for <netdev@vger.kernel.org>; Wed, 22 Jan 2025 01:00:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1737536400; x=1738141200; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=0oXgCE1XaoXt8x9W5eT+CvMMS/oNudIJIItDaJTfrwY=;
        b=cwDoOrZle37cmrJdKoezoe1fioERryk3eLcORRD6DqqOsnHSuIy6EKPmmCqY7GxN8A
         QpkGCV4yBNpNsKphvH3FGMtZuRE7fzn7SReJRULn/YmpM3kirCo2q6fJnwxi7BtxZHqv
         M++JAENLlTHLgb9j3j9vj1gqQXAjf/2+V3Z+q7mZvmsy+OwC3xWRsrKBD1Ua1Vnr98ik
         dfNqsnTT7EKn9KqqLTJoVq9xomWR1J8mO9e56V0iDjB3Ufhrxf6IQ0zgDCA54m/cHexU
         1Ff5w+iVWxcmDzIZra54hQWbtf7TDdjWc82TFg77WUKGhy8popxKpKLhzp6bhVdWTeQO
         YLsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737536400; x=1738141200;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0oXgCE1XaoXt8x9W5eT+CvMMS/oNudIJIItDaJTfrwY=;
        b=bygl7DLHEz1kTweG2zb4PEhh3MFHlooVhPZXr4jVSYuOt+5oGEGmq+ck0ZscMcuNji
         eXtscPx4Auo1oZLxZF2H18F2stoGzs8UjRake+I+rKh3/E+WkO1dt6ZV4zoGwb+x/rC7
         HcxNvCpSSJktm7D0MTbnqJJX49Z9bA9dbyAV20R6PU+QoLGf3NhAzCYCDlNzzzf64U3i
         Y8zMzWYBgUKLRohef7yOomQDiBL3oDOBJkTBMMcrT8j0JD0XU0RPgl3wuBbq15C9Mib1
         M5zCarxerBVu7PTvzq3TcZB9NHZGcgm6FX9qoarD94F9bfCQCMDm92zbMJAhLViJlfQR
         mWyg==
X-Gm-Message-State: AOJu0YwzceqHcq0nReXyBWgZO2e8bP+6APIhciuzLzZwass/XeBLtbWI
	Ugw9m1/50VuIqpPpvSEcIoLpIDi4dRzN0q4rbvcWcobTQGsQyv5Mv92D0XOQDQY=
X-Gm-Gg: ASbGncsvUPfVFYSPizz2HikqGypG7bqvhU/JvRBmyfR65ZhwD1Nknq3N8dIX5SE6HIb
	bfZpNisB88p5WugsjCDrhwkW+ZBw166qSZE92RX3mqzOMa+/dKijh6B1cmxJi+7SWK2uoEjpzUD
	Q0qqsgpSJk+4JKcdB3LbvonNSNgE/Y/YMUZJHiISUM4BYN6LEXOAJmDvcYqWaQuQ4SZDKTXy0cD
	++WJkSKVJYGOyiBoAYGZ16nfpi23QQLy4aWL7vyym2N25P4SIXq2yIujHW9Esfbr2x/L1Jwnqk0
	rEcmzf6/MChBSHKCsV/FHa6SqAlqcQfE
X-Google-Smtp-Source: AGHT+IGqjBoHcrAgstqiYGUstBhsoDbGAW2U0PXH5VCJmHADXwdCEfNsZDB975wKrxe3yT+2NxzSmw==
X-Received: by 2002:a05:6402:2101:b0:5d1:2377:5af3 with SMTP id 4fb4d7f45d1cf-5db7d2dc12amr48792970a12.5.1737536400499;
        Wed, 22 Jan 2025 01:00:00 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:20a5:b2b6:52e6:12de? ([2001:67c:2fbc:1:20a5:b2b6:52e6:12de])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab398524e78sm744842466b.121.2025.01.22.00.59.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Jan 2025 01:00:00 -0800 (PST)
Message-ID: <09cee612-2d94-4c8a-b388-123f498bf0bc@openvpn.net>
Date: Wed, 22 Jan 2025 10:00:58 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v18 20/25] ovpn: implement peer
 add/get/dump/delete via netlink
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Donald Hunter <donald.hunter@gmail.com>, Shuah Khan <shuah@kernel.org>,
 ryazanov.s.a@gmail.com, Andrew Lunn <andrew+netdev@lunn.ch>,
 Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Xiao Liang <shaw.leon@gmail.com>
References: <20250113-b4-ovpn-v18-0-1f00db9c2bd6@openvpn.net>
 <20250113-b4-ovpn-v18-20-1f00db9c2bd6@openvpn.net> <Z4pDpqN2hCc-7DGt@hog>
 <6f907895-4f5f-450f-8aa7-709625e4bb25@openvpn.net> <Z5CxhYdNHKMMljx5@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Z5CxhYdNHKMMljx5@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 22/01/2025 09:51, Sabrina Dubroca wrote:
> 2025-01-22, 01:40:47 +0100, Antonio Quartulli wrote:
>> On 17/01/2025 12:48, Sabrina Dubroca wrote:
>> [...]
>>> With the delayed socket release (which is similar to what was in v11,
>>> but now with refcounting on the netdevice which should make
>>> rtnl_link_unregister in ovpn_cleanup wait [*]), we may return to
>>> userspace as if the peer was gone, but the socket hasn't been detached
>>> yet.
>>>
>>> A userspace application that tries to remove the peer and immediately
>>> re-create it with the same socket could get EBUSY if the workqueue
>>> hasn't done its job yet. That would be quite confusing to the
>>> application.
>>>
>>> So I would add a completion to wait here until the socket has been
>>> fully detached. Something like below.
>>>
>>> [*] I don't think the current refcounting fully protects against that,
>>> I'll comment on 05/25
>>
>> Sabrina, after the other changes I acknowledged, do you still have comments
>> for 5/25?
> 
> The call_rcu vs _put was all I had for this.
> 

Ok!

> Note that you have to wait until ~Feb 4th before you can resubmit
> (since net-next is currently closed). I'll take another look at this
> revision next week, since I've only checked a few specific things
> (mainly related to peer and socket destruction) so far.

Alright!
In the meantime I'll take these days to perform more tests (possibly 
extending the selftest suite a little bit).

If you want to compare this patchset with the very latest code 
(including your suggestions), you can check the main branch at:

https://github.com/openvpn/linux-kernel-ovpn

Thanks a lot!

Best Regards,


-- 
Antonio Quartulli
OpenVPN Inc.


