Return-Path: <netdev+bounces-247841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6009CFF1EF
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:33:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F3E8230019C1
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3693644C0;
	Wed,  7 Jan 2026 17:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9k8CT2B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A203624C8
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 17:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767805520; cv=none; b=RL4PBQmm/QsHqKBverb/mqYMOVTsr7i0PdEbUQi2LynfzDyQKeN5JNI4u2Ir0AZBvJs/dz8ZkQ/Ma16uVpRmmI0KFKvcG0DHotMztRMqLPwDrJqlCDEUi/Uzb06RXkHaXMADqkbxG6lj8h9dnVi2hxPmg2dSFSBqaEW/hEDFUaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767805520; c=relaxed/simple;
	bh=GZVPnIihlbssrlAxnEReq4xRAteXUX7SCOOZGsQW5EI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TTv50EUNSBK6b0ssmY2qwI7oFWg4MbZfdsHMYZkafJwvXD9Gm4qmGruBcu36zKA23SOzIhR4IRQx6M5zgMDtqiUA8gdMKPqDhwUN/aGxSZaLLaMP7vuGl65AMZHPFdqvcv6AxyH4Sl7Qg+GZYCdo4cz9zbYVSVzikK+flJCKJh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9k8CT2B; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-8bb6a27d3edso209177985a.3
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 09:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767805517; x=1768410317; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dOc8XfG+0s04myYixo5Pf4CHGB1gH0OMOC9SxKCE8Xo=;
        b=B9k8CT2BOs46lSMT9jF+qAMoMzBY8WRc4BUjN65S+IwiGDxy7GLhk7yKpCCbP8fuUO
         ZoDEemxFxhsyQj2ERol15t6RwvT0Cbm0sddEgr1n+1lmaKajIDzZyq0kUO2glvNJ5d/k
         AYzq/TSWh80u82SKfiijeFHP+CFiPAGnVz4xHmJRfOaSl3B4DbpszZU6g5KBVzdxeNWf
         QOM7ZtfeRGMv6FZsvQsbYa7OD1wZ8G49jimFb5wCSQKvYovq8rgNCa1vTtHNQnta0ejt
         HnDILz/cIbUBepJwiVIWkwvnJi2ZJQSRyKl6giGN1c3sl2EPDbs+ZYmVJzRjmYBSWb9L
         bEBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767805517; x=1768410317;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dOc8XfG+0s04myYixo5Pf4CHGB1gH0OMOC9SxKCE8Xo=;
        b=vuMR6AKHEa8UIBr4HW1kFVIzsFzg2zLyuflh2XmsXv00dNdZVwbRiLdWMc5fNHqFan
         Pe55bp1Ap+TSavUTkQEvMc72Wqakapl0ZPOExd1PywyuQ9S2ZrnVFu/WVGy4wegWMqqZ
         GYyNN48pK24pjZVJVjFt4OP+d97+q++m0nN73Dn8FJSCVZKQ0ZFMM15EJckgeNGaybXS
         6m5SC1AdfqIdM9A29nk22b4j/TFx+IjZDgxrin2Ds/Wka+RcJRvLAdZv/FTNF9BbTEtV
         5d83D0A+hVhJknfSkwZuX8qkBUV0rfd8XyjQfQDvWJgch7eSH6BAcMMTZOyAFnHVbm+0
         LdSw==
X-Forwarded-Encrypted: i=1; AJvYcCUDiQIDD3kawajvcq8ZQSVccDv1+dX8GyIHCz+uNYq85NcH7cq/uN5eBol4tC5txZdQQuw8AEI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKN3RF32ZGtB59bpvlj+qhzusGyX9R7LRYJEEeY2+MEJLGylbR
	oj9IQ9gkyImZocpD42gCOuta+CbKhMA0CPMJe7bNjnnW+wLaZJiojz+u
X-Gm-Gg: AY/fxX7yUf7EBfYI0kdMnTjwyBu4LIGGGElAKTh1FBxCbLMnZa1zlUjjSucdp3s1P4w
	4sLdw6/cKivVdEkAJKbfluR3S9prtEqHQSalke/6PJzrS7lSQyZdof8jAiGOJSQQD7g5VatEWmE
	ASuYI8TmNGnufisiuDf82kwZttrLqcBtm30dWA6QbXYKTYiLV+dGk9UFrehmpx+Z7N/aZ3YVDWo
	OmfWghfpVBAmMx2P7dZAFFfnLv4qpxHZIQaYKxd574GTCpYZM0qFxMOyeIDMwjYdjx/ilTcKv0f
	Ix1Ae9+3ljjI30rIfCFafyPQeH+4Y66RU3F8jXcDCsJgtvy85U7xnCOTKRadBKpKpo2Kl4mIEh3
	Ltuug/f1xr9C0Rpnf42kpflLju47gEgEcqu5Xy8ESaOL0QNE8LrV0/3RPde7KGhQoTW5ChinDsM
	q1UzP2f910b1wX74C5
X-Google-Smtp-Source: AGHT+IHexZZHvIX4wJ9N9GsO9bANEN/avMjXKz+s9jn7FEl2rkDaHTwvV6tUPNS67dV+YcgpZH3t+Q==
X-Received: by 2002:a05:620a:7087:b0:8be:64e5:52b9 with SMTP id af79cd13be357-8c389408be6mr323212485a.57.1767805517246;
        Wed, 07 Jan 2026 09:05:17 -0800 (PST)
Received: from ?IPV6:2601:18f:901:12c::100d? ([2601:18f:901:12c::100d])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c37f51cdcesm405934685a.26.2026.01.07.09.05.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jan 2026 09:05:16 -0800 (PST)
Message-ID: <099019ee-05f4-457b-a82b-0fac55d8dd48@gmail.com>
Date: Wed, 7 Jan 2026 12:05:15 -0500
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 net-next v2] ipv6: use the right ifindex when replying
 to icmpv6 from localhost
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org,
 linux-kselftest@vger.kernel.org
References: <20260107153841.5030-1-fmancera@suse.de>
Content-Language: en-US
From: Brian Haley <haleyb.dev@gmail.com>
In-Reply-To: <20260107153841.5030-1-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Fernando,

On 1/7/26 10:38 AM, Fernando Fernandez Mancera wrote:
> When replying to a ICMPv6 echo request that comes from localhost address
> the right output ifindex is 1 (lo) and not rt6i_idev dev index. Use the
> skb device ifindex instead. This fixes pinging to a local address from
> localhost source address.
> 
> $ ping6 -I ::1 2001:1:1::2 -c 3
> PING 2001:1:1::2 (2001:1:1::2) from ::1 : 56 data bytes
> 64 bytes from 2001:1:1::2: icmp_seq=1 ttl=64 time=0.037 ms
> 64 bytes from 2001:1:1::2: icmp_seq=2 ttl=64 time=0.069 ms
> 64 bytes from 2001:1:1::2: icmp_seq=3 ttl=64 time=0.122 ms
> 
> 2001:1:1::2 ping statistics
> 3 packets transmitted, 3 received, 0% packet loss, time 2032ms
> rtt min/avg/max/mdev = 0.037/0.076/0.122/0.035 ms
> 
> Fixes: 1b70d792cf67 ("ipv6: Use rt6i_idev index for echo replies to a local address")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> ---
> v2: no changes
> ---
>   net/ipv6/icmp.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
> index 5d2f90babaa5..5de254043133 100644
> --- a/net/ipv6/icmp.c
> +++ b/net/ipv6/icmp.c
> @@ -965,7 +965,9 @@ static enum skb_drop_reason icmpv6_echo_reply(struct sk_buff *skb)
>   	fl6.daddr = ipv6_hdr(skb)->saddr;
>   	if (saddr)
>   		fl6.saddr = *saddr;
> -	fl6.flowi6_oif = icmp6_iif(skb);
> +	fl6.flowi6_oif = ipv6_addr_type(&fl6.daddr) & IPV6_ADDR_LOOPBACK ?
> +			 skb->dev->ifindex :
> +			 icmp6_iif(skb);
>   	fl6.fl6_icmp_type = type;
>   	fl6.flowi6_mark = mark;
>   	fl6.flowi6_uid = sock_net_uid(net, NULL);

Using ipv6_addr_loopback(&fl6.daddr) might be more efficient as it does 
a direct comparison of the address.

-Brian

