Return-Path: <netdev+bounces-146728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B87D59D54DC
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 22:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 744DC280575
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 21:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7679F1D89FE;
	Thu, 21 Nov 2024 21:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MqQQlfeI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657C119DF66
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 21:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732225270; cv=none; b=AX56/QGdpF7qZ+jLfP2qe+KWGbN1IELxCl7r0ickLtWYZ9jHP4JUhGrktcASj/0DxL99FM8Jzggx8fXLZ1BTPMr8ZHpsDEC9fAPfsNsdtDWDhRELXrfr2S4N/lRU2MxDxUMYwvtCXojnUH10cMsiLHlpqZ744TUPDab4SIK8IUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732225270; c=relaxed/simple;
	bh=a7VIWYsH6966r8qsRHPstqq/wRhz2X9ULMrmkKrJx7g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Oue+OgzQ+/TqznjV+/uMN1FaZcmtgCgJkplY3t0jfYWFPkMzFtsl6Hpi5MTyg24p29NRqnRUTMJCFOCkO9LLZJvY1naiDnsDewTENxALyoDpPbrer/uIkrN3zc41bE+mw1ni2imC+Gk41OHchUhKwA5Ds/QYAlZ8mzgbflBO9k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MqQQlfeI; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-53da5a27771so1637642e87.2
        for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 13:41:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1732225266; x=1732830066; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Xp7BJDK+fpEtWCkgM/D1MY0zmZ7nJzoLAYaUFtGfDwM=;
        b=MqQQlfeIdLYW4L71cg5XQjQoq6Xc46gjX3fdW2pFTdmVCagAv5i35XQTP9VwJhbh9T
         q99+28BUa1OaaNyC1fr/we6cMZZAlD5VIWByIC889qXdohYaF1c+k0aK4NPJlT2rp5Ou
         5RVUIm5YD2nFsRfYXNJpELGxHcIeWwQDNYbQ1YrxzormSsn5+7VBw9P0Sg6J7BV7soq4
         vBlXqwz57WSWjbMpWkRLtZjqS7Rf+mftYNgY1xKS+kA6wCodaQ3eueAnW37pjzHGiGOx
         45uTGXqTcS33y0KIPE7AxRBQiJhar+gmFOCIwNDtjRsH81/rEvSlNbgCitMDh7WCyc8x
         o5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732225266; x=1732830066;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xp7BJDK+fpEtWCkgM/D1MY0zmZ7nJzoLAYaUFtGfDwM=;
        b=OPvPzHEB6VWxHaV+547grzKm1DlkEmHwXsf6P3bsTVE8zDGvtQw7fi1oR1d4jG0v+c
         JqN4I9gbfcBqdU1IGNQvaIa2pcRfiqKrHFP5TaIik9tOhjBxweSFv0QJU9BSB5PMY5KT
         4+KnP2As3BuIKFFJvpK9bjd/8vMGrtsUKf+qdP+Jvc45jaQfFtTecFOcHypsKfLtvuAW
         IBcsq0m5rlRyF810J0/Ph9j4jLe51g1reBjfnqOZW+Wx/0HrEHbwfKgWKIoACfZFwGtR
         D24O8ApteWsv+fHc81nRxY7AuTBXulwZQfWkNdBzLcD25HdIgAEu/YYTadjRVvUE86+i
         Hn1g==
X-Forwarded-Encrypted: i=1; AJvYcCVUJo8um2W1AaaKQOk9968twxo4ZGtxxZ9KptUKVpO1m8zp9nIWzaL34bls6JqFJzIqcAWyr6I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5odtsEhNPBkxLlVf/0VkYbup30+5NmY7r9U/YvaMzElFbIPd6
	G29C+6PQd2tGJ8Nl5FCmyyPckyc5J3kaFrE1QDM3qvHK6PIxVIIXuwz/4H2joJg=
X-Gm-Gg: ASbGncvTLMt/jVB2XqNALF3zfheJguY6x8s/9NasQNTEGj0hsPWXVWSJ47cQ/ZqkFJA
	u2JZn2KR2lKAvmdv4qj65qu+0BRGOIOpZY6mCa+CT0x2ccjAvSOb1j4xDcUPUoqWZD6U3/aSA5O
	+4qOVc9exDtsa5SCdikxxMncMZeS/LaOSZUnxl2PqlV1odzVeBoh6lccCvk30/E8ibQqQ47Wls7
	03DYzSnN81nW7daBEJC2C3YsrGiIaHKEzuB9i+1vLS3r6BGACpOPzlrDXyttPjlXllrdi9SPiKP
	NGA1jTjm4w==
X-Google-Smtp-Source: AGHT+IG2aOB0XzO/z8W/uO9KyC6nKxwoNJWl0ncYXB+fcrk+LyC+9cX/Kn26qAZl6H+D2Fu4TzCAJw==
X-Received: by 2002:a05:6512:1247:b0:53d:a9a4:7567 with SMTP id 2adb3069b0e04-53dd39b4f71mr191025e87.48.1732225266548;
        Thu, 21 Nov 2024 13:41:06 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:f55:fe70:5486:7392? ([2001:67c:2fbc:1:f55:fe70:5486:7392])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3c0044sm197993a12.48.2024.11.21.13.41.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Nov 2024 13:41:04 -0800 (PST)
Message-ID: <2eaf99e0-49d2-43a5-ac51-6f5a8f873d14@openvpn.net>
Date: Thu, 21 Nov 2024 22:41:32 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v11 08/23] ovpn: implement basic TX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Donald Hunter <donald.hunter@gmail.com>,
 Shuah Khan <shuah@kernel.org>, ryazanov.s.a@gmail.com,
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20241029-b4-ovpn-v11-0-de4698c73a25@openvpn.net>
 <20241029-b4-ovpn-v11-8-de4698c73a25@openvpn.net> <Zz3L3lnmcgbdQDqn@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zz3L3lnmcgbdQDqn@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20/11/2024 12:45, Sabrina Dubroca wrote:
> 2024-10-29, 11:47:21 +0100, Antonio Quartulli wrote:
>> +static int ovpn_udp4_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
>> +			    struct dst_cache *cache, struct sock *sk,
>> +			    struct sk_buff *skb)
>> +{
> [...]
>> +	if (unlikely(!inet_confirm_addr(sock_net(sk), NULL, 0, fl.saddr,
>> +					RT_SCOPE_HOST))) {
>> +		/* we may end up here when the cached address is not usable
>> +		 * anymore. In this case we reset address/cache and perform a
>> +		 * new look up
>> +		 */
>> +		fl.saddr = 0;
>> +		bind->local.ipv4.s_addr = 0;
> 
> Here we're updating bind->local without holding peer->lock, that's
> inconsistent with ovpn_peer_update_local_endpoint.

ACK

> 
>> +static int ovpn_udp6_output(struct ovpn_struct *ovpn, struct ovpn_bind *bind,
>> +			    struct dst_cache *cache, struct sock *sk,
>> +			    struct sk_buff *skb)
>> +{
> [...]
>> +	if (unlikely(!ipv6_chk_addr(sock_net(sk), &fl.saddr, NULL, 0))) {
>> +		/* we may end up here when the cached address is not usable
>> +		 * anymore. In this case we reset address/cache and perform a
>> +		 * new look up
>> +		 */
>> +		fl.saddr = in6addr_any;
>> +		bind->local.ipv6 = in6addr_any;
> 
> And here as well.

ACK

Will fix both.
Thank you.

Regards,

> 

-- 
Antonio Quartulli
OpenVPN Inc.


