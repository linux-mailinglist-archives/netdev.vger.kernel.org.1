Return-Path: <netdev+bounces-181550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424F2A856C9
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 10:40:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7995B8C3CA1
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 08:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1350296165;
	Fri, 11 Apr 2025 08:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="B0yCSpsF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28AC293B4B
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 08:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744360705; cv=none; b=KaBpaQB9YX8zjfSgkJl5DJpHfqAYZ2YBn+FJHPBzZIDWFcl6I1mv0h2y31GWSQVNYhQQjUPtRKd+eaTe3eKuvANySM/Buz6LbzM+QosNdGJwezSLC5BeClb43xM3uyGOnzLK77fKB752+No3xSFme+OFlEI9eRn694PWCvS7VhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744360705; c=relaxed/simple;
	bh=Epr+eQBTBU+1ATMEcOYwgYpBi+5oAELlBmkst6805Y8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TahLN5iNBRPmJEPRAXCGMr06gHHI1rRrXpyCn79WIxUviEDdVAsARFm++wrydEVoQnjA8y1HNnwERjyqOaRp0E4eg+BX8m4icioHZFZe0/i4ovFTfHK0vcphlNoyc4Wn4xQ3cccYy+865sAmWzQ2iGaBWxjy4Nnwp9BNgJ/PImw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=B0yCSpsF; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43d07ca6a80so8188685e9.1
        for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 01:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1744360702; x=1744965502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=sLffW0MYcqM/kbItIhY6HvWZCj3KnwBnjUOkirxLQ30=;
        b=B0yCSpsFauabFeSmpImWI91WIartpOH5alEONnCw1kOBegi3hhoCX4iuib2tiFKlSP
         BalEWX9Fca/n2N0EWEimJYTzkkAOHI98o8kwImMG9BmPbgCZrrlbBSbQmiIj86ognehR
         Pj453DEfbiOmbqNeD1sRPCHkc+tWpaM3U6dU4jzon+xADOfFZYSb2LLedbPzZGxpsncr
         KNz73O4lK6rGsgOkdKgxZBocN0EtWzKxbrZ23dOqodX6PZxDmuK56P7eN45P0BQWCsRw
         mp4oswBW7RL6JjZ9YWs3FvaIldFA9aUyfeGbvTB/5cFPawKb99CCu/ESbGDVwTS3vW8M
         bzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744360702; x=1744965502;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sLffW0MYcqM/kbItIhY6HvWZCj3KnwBnjUOkirxLQ30=;
        b=PDxj/5ZB6iCRUdg7pMVRGHPn96LjHfpOB7zCqcCqfv31/YKG+qSdja4J0n7/m+D/iH
         u6LaO29FdM0fsZZXGQde5j9VBNksty/B9gaSEVu/iSm+sgabE4MGJ7GMnYcPYh3wPm8y
         KJdp2Fd+dD9upCdlTqxDmFrAoyk920v8h2F81wR1Pckijar8MxSn3T0WQvjE/uXz6g9G
         YD4XLgu0g55Nv/VqNtuqT4bEZH79DvTcJu6EUETzKcL1G5pRGGQft2votX/mZrcUMXRs
         Y9RTW3xCr1oCPqUawH4z9LEpqf8tQek/Nbp1wg3EcQ2WliloKQLtIlhkFY8ljsq3ciX+
         KIoQ==
X-Gm-Message-State: AOJu0YxfQwfA73XsQsuEpqO8mZxrInQMIAxi3+Kx3VwIHOxI7jwe/JjU
	aAsIl5tzFAf6CMIvypc5ws1WBXE3PRtfD4YtPaUr7s37qGyMKw1ZK2ObWqw5iBbr23Q7CIfsuKa
	hmOx6P3itZn4KtvH8nwYDMz3YzJJD2vu+tCJvtE9jQ3zAJig=
X-Gm-Gg: ASbGncsV0Ou6ViAUki2cr70zp2O6+zTwYtrHnbWUAp/8lU5bBGE3t/q8Q/N+Y5kP/LK
	Y4Zn4lHkjOCr7laylH6gdDdXf47orxj7tFoCXEoJRu0bNCKuBVYnpkI7d30ticydJPiuuoPwU17
	I0uj8Y713gjopm4/AKOL8gSi2Jr1c6xSx0T17RuT/kATX+f1pPxMrqkttuRhxlq89Z9oZhON5+0
	1v8xZWzW4WHX40q5gEZoW7UqYib4kei++KXLnRfQWBMIJluCx0/f3n+mr21U67j2qDoAX7KjvWi
	MXSOyFcgvKlEvJXZrwby/8R/3N3cPmNKDF4BGwkxuJBuKkQjuOlq/zZbfppBqf5+5zYfxiRT39D
	2bfEUlgRXelQX7Q==
X-Google-Smtp-Source: AGHT+IF99oxdyDqfyn57Lonv1kNPOlFA9HMh6oBiEUe+C+vJOJbIHsy3y4iVXg2sytLFO2/obYxOuQ==
X-Received: by 2002:a05:600c:a08e:b0:43c:eeee:b706 with SMTP id 5b1f17b1804b1-43f3a9aa66dmr13977265e9.24.1744360702027;
        Fri, 11 Apr 2025 01:38:22 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:e8be:40be:972d:7ee4? ([2001:67c:2fbc:1:e8be:40be:972d:7ee4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f207aed49sm78101205e9.34.2025.04.11.01.38.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Apr 2025 01:38:21 -0700 (PDT)
Message-ID: <af1a5da4-12dc-47bd-8836-9b7bda0281fd@openvpn.net>
Date: Fri, 11 Apr 2025 10:38:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v25 04/23] ovpn: keep carrier always on for MP
 interfaces
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, sd@queasysnail.net, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 Xiao Liang <shaw.leon@gmail.com>
References: <20250407-b4-ovpn-v25-0-a04eae86e016@openvpn.net>
 <20250407-b4-ovpn-v25-4-a04eae86e016@openvpn.net>
 <20250410200325.5621a4f5@kernel.org>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <20250410200325.5621a4f5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/04/2025 05:03, Jakub Kicinski wrote:
> On Mon, 07 Apr 2025 21:46:12 +0200 Antonio Quartulli wrote:
>> +	/* carrier for P2P interfaces is switched on and off when
>> +	 * the peer is added or deleted.
>> +	 *
>> +	 * in case of P2MP interfaces we just keep the carrier always on
>> +	 */
>> +	if (ovpn->mode == OVPN_MODE_MP)
>> +		netif_carrier_on(dev);
> 
> Any reason why you turn it during open rather than leaving it be before
> registration? Now the link is down until first open, then it stays up
> even if user closes?

Mh your concern makes sense.
Originally Andrew suggested adding the carrier_on() to _probe(), which I 
interpreted as _open() (I don't think virtual drivers have any _probe() 
hook).

Being the goal to keep the carrier always on for MP ifaces, I'd say I 
should move the carrier_on() call to newlink().
There I can set the carrier on if MP or off if P2P.

Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


