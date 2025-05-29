Return-Path: <netdev+bounces-194179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7730EAC7B3D
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 11:40:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 719D97A8A4B
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 09:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DB1026C391;
	Thu, 29 May 2025 09:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BMSH4lYt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08B7120299B
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748511643; cv=none; b=IRNPjLpV1MBgetA6mWFTYXSxRelHd4k+EnISOHDqcU1qd/HhKF7VsH3nRGggVaOkcvDMtW3g5tkeZdYnB0SutlCrXE0uBQyHKjjF3aQto5z6bAk8+MP9OVaS/Sg03OVZjW9/nqAeoT9ppUW8CclchxC8kjxqJop1ms3h8U+OCEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748511643; c=relaxed/simple;
	bh=kV/S7ogVST8lfEuUskyByPTSZ1RF1jyO7K0DC6MTjxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cF10/DDaObX2B5pDftyntE3lMCWvUvYztnLgYJ8jCwhFG4okKyru2MZF60zto+EKaIXrTY29h+ddqXq+dEYopmeHgrUkQuH3k0URcX4+JXUM7zQSISlzyirSVw4XrWLgT6Xa01s1njQSoRuypC/6aUuDRPfDkgcyHtZxMlm5RlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BMSH4lYt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-450cf0025c0so4868745e9.3
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 02:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1748511638; x=1749116438; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4pu+YlgghIMm8S+0mWO0i4z2bcpkyplpy4qdWBmyXkw=;
        b=BMSH4lYtUxNz+6w29fbAEApc/DY2gFXmsWtggjLmkP1gjy4oWxSHbHs/e3919of4Kx
         TNsO584QrXrKm54JZPDaX9/O2j3/qI/j0sGDPv4EZV71C87W2SVb/uNist361d0bxeDB
         m0r2yannStjYc0bYYFb3wROC24Ds04kHYiAJDvS2P1Vil9xiRab004V18rsrTqIMJtUh
         eZ2YqNbfWcJShMje0bphKxcfHqD3VfWoL5FaMqOvrX32XkZCuT+SF+VrbFw5qq9Yzk7n
         Bjz6Afa+ZyngZeh7cHbsQf5c2baC+HkHSK3Oh+iiGHvxgpxVqG+D1cvY3+y01wcgS0nq
         CJzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748511638; x=1749116438;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4pu+YlgghIMm8S+0mWO0i4z2bcpkyplpy4qdWBmyXkw=;
        b=r8hDePgSmaqVpjFG1bg6QrT/Se57vBjnEGe2uhyjLsGZ0Zd/umS96yfLDWD35eSxvi
         gwNmUTcNcyHLH0xs4VymjzQyBChmShAw/1Wn667z+eon/FyyzvAVlf2cSQcd4m4Fmkri
         +n66sEuEhDANZNr+IyhpymnRfGNl9/FPr0sPGVlFfGFj0zMv3XzsuCm9317CTONMJ+dr
         Tx56ND8QDj0/aQGfWuWDhrrXntXKjjeMXHX9xBa8jL60oQvciCp8WT3rS01NN/QAAK3L
         KIzr2UKtmyYAyuUJZfNlURIkCtaTr52IMrnAcMN9Ijs8qYhxTqSunRMk+sW0TzDEWioH
         M1WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWt6unR/4vjIsfPxlZZdm3tGbUC2Fm1p3Kc7m8M9tndvzd2C0oP++hTdMmt8b12ay4uL6Qz2CU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyt9etpRH0SNnnikUZpqfJ+ZVgpxfTrl3OnVr4l/bvFg5rxCK3L
	SEmnKmQsMXdO7bLWLL5H/Tc6EoYG1kpn5vN0H9SiCVIhgjGMPHM+Ke3URZz8Fm9NG//QJZnq3AB
	RGGfaleYYft1WRQWrn9nUrHPaG6eyo3Uo0kULAQTjT02qLdFDRpg=
X-Gm-Gg: ASbGnctGI0D+29HQ8Tl4xNdlhmT/uPK3ilZt0UNl72vqKTKTwNJEB8dvUL7d3JbX6iX
	sd3VFLO59TaQzpGTAV6VbM/rXq02bYFRPkwLfhRZysRGwdvc5afSsm2d2A0h/NztayntKYXqKDs
	cNGjZiA2FbARxKW/2ptvH8UJvoc5TU7FhtKW0wqWnL6CmKgYGu1cEPIItVm0jRHWxib0LnMx1UC
	LOxPKt/faax/1LKVMCu2yAAp1JmeAfph7Yr+X4hGsH4ReeUeWotAtrDv4VWDpbfGRM0oQImixV1
	1dZDzlhJpz1lKLJ8da9DBQ5jq8ZcG0JtYOUUsZn72lXyXOE0EnEKlxotv/aOyZCaewoIuEpLrev
	QGevNGHxMeqsouw==
X-Google-Smtp-Source: AGHT+IEoEga8alCdX88X31NkHMXuOKZB4oKBp3b4LfgA/tL38S4rtfDeWWlbrOhlmwhO8jzb8fRw3Q==
X-Received: by 2002:a05:6000:2382:b0:3a4:f038:af87 with SMTP id ffacd0b85a97d-3a4f038b054mr1400301f8f.47.1748511638142;
        Thu, 29 May 2025 02:40:38 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:d079:e260:1678:9b60? ([2001:67c:2fbc:1:d079:e260:1678:9b60])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c8b4sm1478830f8f.36.2025.05.29.02.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 02:40:37 -0700 (PDT)
Message-ID: <40126ac9-f911-4216-ba69-5e5ef051dd63@openvpn.net>
Date: Thu, 29 May 2025 11:40:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/4] ovpn: properly deconfigure UDP-tunnel
To: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Oleksandr Natalenko <oleksandr@natalenko.name>
References: <20250527134625.15216-1-antonio@openvpn.net>
 <20250527134625.15216-2-antonio@openvpn.net>
 <39ca5468-733b-49c4-a00d-27c2ab85b795@redhat.com>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <39ca5468-733b-49c4-a00d-27c2ab85b795@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Paolo,

On 29/05/2025 11:25, Paolo Abeni wrote:
> On 5/27/25 3:46 PM, Antonio Quartulli wrote:
>> diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
>> index dde52b8050b8..9ffc4e0b1644 100644
>> --- a/net/ipv4/udp.c
>> +++ b/net/ipv4/udp.c
>> @@ -2900,7 +2900,7 @@ void udp_destroy_sock(struct sock *sk)
>>   			if (encap_destroy)
>>   				encap_destroy(sk);
>>   		}
>> -		if (udp_test_bit(ENCAP_ENABLED, sk)) {
>> +		if (udp_test_and_clear_bit(ENCAP_ENABLED, sk)) {
> 
> Nothing should use 'sk' after udp_destroy_sock(), no need to clear the
> bit (same in ipv6 code)

Ok, then I guess that in ovpn I need to check if SOCK_DEAD is set and, 
if so, just bail out.

> 
>>   			static_branch_dec(&udp_encap_needed_key);
>>   			udp_tunnel_cleanup_gro(sk);
>>   		}
>> diff --git a/net/ipv4/udp_tunnel_core.c b/net/ipv4/udp_tunnel_core.c
>> index 2326548997d3..624b6afcf812 100644
>> --- a/net/ipv4/udp_tunnel_core.c
>> +++ b/net/ipv4/udp_tunnel_core.c
>> @@ -98,6 +98,28 @@ void setup_udp_tunnel_sock(struct net *net, struct socket *sock,
>>   }
>>   EXPORT_SYMBOL_GPL(setup_udp_tunnel_sock);
>>   
>> +void cleanup_udp_tunnel_sock(struct sock *sk)
>> +{
>> +	/* Re-enable multicast loopback */
>> +	inet_set_bit(MC_LOOP, sk);
>> +
>> +	/* Disable CHECKSUM_UNNECESSARY to CHECKSUM_COMPLETE conversion */
>> +	inet_dec_convert_csum(sk);
>> +
>> +	udp_sk(sk)->encap_type = 0;
>> +	udp_sk(sk)->encap_rcv = NULL;
>> +	udp_sk(sk)->encap_err_rcv = NULL;
>> +	udp_sk(sk)->encap_err_lookup = NULL;
>> +	udp_sk(sk)->encap_destroy = NULL;
>> +	udp_sk(sk)->gro_receive = NULL;
>> +	udp_sk(sk)->gro_complete = NULL;
>> +
>> +	rcu_assign_sk_user_data(sk, NULL);
>> +	udp_tunnel_encap_disable(sk);
>> +	udp_tunnel_cleanup_gro(sk);
>> +}
>> +EXPORT_SYMBOL_GPL(cleanup_udp_tunnel_sock);
> 
> IMHO the above code should not land into a generic tunnel helper, as the
> tunnel scope always correspond to the sk scope - except for openvpn.
> 

Ok.
I thought udp_tunnel was the right place because this helper is an 
explicit counterpart for setup_udp_tunnel_sock().

But since there are no other users, I can move this code inside ovpn.

> Also IMHO no need to do udp_tunnel_encap_disable(), it will called as
> needed at sk close() time. Yep, that means that the stack will have
> transient additional overhead until the sock is not destroyed, but IMHO
> it's not worthy the extra complexity (export symbol, additional stub,
> more files touched...)

That's true: removing that part will greatly simplify the patch.

If we agree that we can live with the transient overhead, then ok, I 
will remove the udp_tunnel_encap_disable() part and simplify this commit.


Thanks for the feedback, Paolo!


Regards,

-- 
Antonio Quartulli
OpenVPN Inc.


