Return-Path: <netdev+bounces-129684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DED5298582C
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 13:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6923B1F21F13
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 11:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1A8184551;
	Wed, 25 Sep 2024 11:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="dNVYdDTC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABAA9184101
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 11:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727264217; cv=none; b=otNlXRtZ+IwUXE5Oz+KVv6VQFzj3INQK1twmFh6OH2hHLCPlwBLIsHCa40ykjSIxC4jFxDXGxeBHYGCKWQUJc9cr1Qa3+1mc7j3QtrRMoUPNtiXMs6hHznW1Vsdne0ydJXcpsRWew3lXiqb5BMZBnLcZRAruH9Xj9x7nZEP9rMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727264217; c=relaxed/simple;
	bh=QA6CF7dDS0/Iqo9piIKdv15YNaRxM1Uz5m8MbBF/H3I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T6yKKU6iz4yWQcmQiglQX0zhsJzW7YruQEiivl5E+0p2vvEKdMiAzGvo8tBUcn9qugFyhSshxUgZZuiwLvPMQi8psJp3/QfcUtptP6TCSxmD+RvVO0djSM0o49NTnCrn9uC3Mw+/dAA4fgYkdeRv5tTLpUuHkxf9qYICwNhcHm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=dNVYdDTC; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-374b25263a3so3995712f8f.0
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 04:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1727264214; x=1727869014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Hkd0e6vGxHmjPv43vJ0xMQj8joECyZ9xmlz97LqUYvI=;
        b=dNVYdDTCZoOjNraOCiYHtqfLwo2n6p990w5e8uSm85dZppgNG9Dc2/PVC2Fs96B7yu
         aTaaAR/iKDv5L82J17Hcf2WUiHWq8HaKyvjWTsReH6rCzPtWh5Wv77HMKOAnbweFoygC
         0hUSWfrrCQCNXbPGbUAqU4zzrl+cHB72wB1ihbMcwsKgsVWzxHkpSt6EqK3GIjtBb0iV
         UWu76Zlqtvd5Au5XFVgyHQF1ZvTWEniryQwTiU566m2buHE5t4zik5XxTYtEKVE+nAi5
         2GUDk2p43OKQzvtMzkWP5lukxzHNqGQoO90rpRc5fAXYo+1fHTm3F+qptHaoiAmRqWuE
         2fkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727264214; x=1727869014;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hkd0e6vGxHmjPv43vJ0xMQj8joECyZ9xmlz97LqUYvI=;
        b=UqelltyGeN7nKa+Carp3Z+ORC2OdXLLK3eklsocDeLOHlK+Je+0imbE4N1iG0zEj/h
         wIqv612dF5K0JkGvaGHlVjioxpMfWulFdPO1cBtOjQwGZhXMTOTITJvZh+uB0wjQ7sW0
         h8Eo44z3z90O9NM+lgmWW46hZq+6V8mjTHJWkzy8JDdn0UMA8geoK/yEw5hYJyx7b1Jp
         xSj3eLJxyB4dUK0QkWHSadZXEHPrC4WuKQTRM+OuQ1QkeQ5wT65mV3CEeXcljTbg5UOi
         kI7tFDg2gDu2rAH+OaKrcwRhZbTX/drC1YXcwYd+2sAM4BVJXLk6nx0VIwP5crVR92xZ
         rmFA==
X-Gm-Message-State: AOJu0YwzXP55vJrklj2nmK7sLw7dzw2cf8z1pZr6/3z+g8nlMhXn0wMG
	rhNI3sTccW9xKr6TdCQYFB158ktW92ON4pm8Za3dmIlEnl6MvPb5/pCNboVC73f4hAfmOZjwikQ
	K
X-Google-Smtp-Source: AGHT+IEkcjZpnVEUHjBWZmmIipIxojPKz6ffHHQ/IxUCIsSfYxCWYge2jl+shuijkTIZ0FnfUZDdmQ==
X-Received: by 2002:a5d:4527:0:b0:375:48e6:f30f with SMTP id ffacd0b85a97d-37cc2478d33mr1430710f8f.30.1727264213872;
        Wed, 25 Sep 2024 04:36:53 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:ca1e:6faa:d16e:2292? ([2001:67c:2fbc:1:ca1e:6faa:d16e:2292])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42e969ddd24sm15859905e9.1.2024.09.25.04.36.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Sep 2024 04:36:53 -0700 (PDT)
Message-ID: <1f5f60cb-c4a5-44b9-896f-1c1b8ec6a382@openvpn.net>
Date: Wed, 25 Sep 2024 13:36:53 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 04/25] ovpn: add basic netlink support
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch,
 sd@queasysnail.net
References: <20240917010734.1905-1-antonio@openvpn.net>
 <20240917010734.1905-5-antonio@openvpn.net> <m2wmjabehc.fsf@gmail.com>
 <99028055-f440-45e8-8fb1-ec4e19e0cafa@openvpn.net> <m2o74lb7hu.fsf@gmail.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <m2o74lb7hu.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Donald,

On 18/09/2024 12:07, Donald Hunter wrote:
[...]
> nl80211 is maybe not a good example to follow because it predates the
> ynl specs and code generation. The netdev.yaml spec is a good example of
> a modern genetlink spec. It specifies ops for 'dev-add-ntf' and
> 'dev-del-ntf' that both reuse the definition from 'dev-get' with the
> 'notify: dev-get' attribute:
> 
>      -
>        name: dev-get
>        doc: Get / dump information about a netdev.
>        attribute-set: dev
>        do:
>          request:
>            attributes:
>              - ifindex
>          reply: &dev-all
>            attributes:
>              - ifindex
>              - xdp-features
>              - xdp-zc-max-segs
>              - xdp-rx-metadata-features
>              - xsk-features
>        dump:
>          reply: *dev-all
>      -
>        name: dev-add-ntf
>        doc: Notification about device appearing.
>        notify: dev-get
>        mcgrp: mgmt
>      -
>        name: dev-del-ntf
>        doc: Notification about device disappearing.
>        notify: dev-get
>        mcgrp: mgmt
> 
> The notify ops get distinct ids so they should never be confused with
> normal command responses.

I see most (if not all) modules have named ops dev-del/add/get, while in 
ovpn I am going with new/del-dev (action and object are inverted).

Do you think it'd make sense to change all the op names to follow the 
convention used by the other modules?

Cheers,



-- 
Antonio Quartulli
OpenVPN Inc.

