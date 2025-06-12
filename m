Return-Path: <netdev+bounces-196898-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6CD6AD6DCA
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:32:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2321882B08
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28151233D8E;
	Thu, 12 Jun 2025 10:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="wX513kwv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6949523644D
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724225; cv=none; b=kEghMAgs7KV5eqqxJ6TAD82EjvJgVEXP0095Av7JFbB7Ol4uA57DlzKYul1qJV9qYn0DPiS9TBGy7j8rYBHYJexRCwaoGOKbYPcgfwDPjtWq6GwzS8+wDrXy6uORVVE+yINPATHaBqTpr4qr5JZNBMcWGOZ8dCizpBA3Tr8EL+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724225; c=relaxed/simple;
	bh=XPYAplTFO6Yef6rwBWN715imVh12yk6t+0PlXtePNbc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ciY1jqsB8CUPRniXvF1rf1qUFgIIm2K3pgjKoOICuq8L5+/s9xhH7GtZQKOaL+8EnFlhUjY52bP66N5yQ/sHqgvFu/gQPCl0eEJr/hiSmLwwL4TbqKwUZnIoyktaIeBQmbi+6GuR5y0nh4Rsl36tYIGrJEwxcrJ8eYo4sNJNu4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=wX513kwv; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-54998f865b8so691064e87.3
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724221; x=1750329021; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ps9SPp/7d3ta1ZJHXWTSlkgDc3VQONBarz4LtJAiAIw=;
        b=wX513kwvB6LCUvt9OhVRt0PNb2aYu/Z5XbVdzsuh+3PD/XW1mdsLXHPsuM1/OAF7BP
         A6n1cFVlcS7kR7jpEjnZxJi5mwlooXmc+S1AGQz/aNWZF1vJq6UND9b08ttcSalNT/AB
         jmsXFQUTvrl0oLwQ9YfFwLG2h6CB60aVFYLtOdAUZJwIApj7XkX0YBdBuqrr0fUuPrU0
         +9kpsKurp/IKUXIxKpeaF/qDUDMvLN8ZG3Y60AuXAmcD90Di6R7AR1HuNx81GogaxeU9
         XsCCA1c8ktjT0JA0ezdxs4n4H7FGb6V8S7m5CNS4y90Vv1pxJUcW3bxa7VN++1fpEGKL
         Gygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724221; x=1750329021;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ps9SPp/7d3ta1ZJHXWTSlkgDc3VQONBarz4LtJAiAIw=;
        b=nv7KDMJplPkYoMDMkhtzF1LEK5OZRTmvRovHfYWNK4qpvXQQw/KpP9jCDIGZbgf31D
         RGVBi/upDepCFHhGr4VJG8MTVVGAgJx8ggD7BrME8x6/n0t0/McgoIjQCP7IlUOL/ltG
         qSLAQABZfoD55bCa1TNWwZVijzwjeCS2JCeRC3SLPouyByaCquGItT2FuhzknZ6POFh0
         5P96LoD4NOkYw/ZHRdaMnEqZcmGQoD+gmtmebSbPuYSIT3Ud3wZ3IF4bHrq0nB0ia66b
         Z9g70Bx+l+qrOkeaXdgEJePRZuPZkkifv+oi+YNwLvttxCLS8Kaop2WZAcy/GnftPWah
         lHsA==
X-Forwarded-Encrypted: i=1; AJvYcCXeJx5n+SECWk48s5vRbIFTuiX0FidpruwlVBaceSFZH4ez8dIkU1lVfH/bHNBXKTSht3zSwZI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN/kLYE6YPZPzoUbpipjI1p7qr+u2jJhlQqM0MnPN8MUxjixJB
	W6VRHIEmpT1/tx9stiplxm7PMjqqz9rhUEkZknOtB+SnVWMBkXdaWFAUM4A/JMRCgKU=
X-Gm-Gg: ASbGncv3GVAuVwWiWCRpMSYSI5ZCVscKrRRNjqhi2f57Abbmm35Sj1aRvAt9mTnfPUk
	1HH1j/Qkpx+H5mhyei4W92ReN7qJiUD47gLr+iJvuGfFAgHv0iWLh8j2Z+4pJ2AN+9Hj0wgnEV7
	WpOnEKNuhpudmkMuw0lbGmqFF4daeUV7rAEjyFnijmhafOWf38ROEq78CzxJp7abnkKidpFW+8f
	KWFcidNcX9lryQ44nis+xqUi785abjS7iR0Yr7K8jZ23buGRIly6+75LNfZwN8/8L+T7RQJcF+H
	O2BgCyjNbUxP7N776/OEXKWd6TSJm6ANwpSkb+29c6Xjp4FOozuIh2C0b4seKIF1w9szGTg4jtp
	JXznVl6QHB3ws4kUJ6Y2F3L7XEpRaaSc=
X-Google-Smtp-Source: AGHT+IGofb04mPHf3tVs9D8lbg9rn7L1AkCcWEQ0drmDahn731hM1waV/Jnjc8Pu5ds9TsJw94Dxeg==
X-Received: by 2002:a05:6512:3d1b:b0:553:a8bb:7472 with SMTP id 2adb3069b0e04-553a8bb7668mr478884e87.15.1749724221410;
        Thu, 12 Jun 2025 03:30:21 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac1ad5aasm65062e87.127.2025.06.12.03.30.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:30:20 -0700 (PDT)
Message-ID: <2b7323f1-09bb-45fb-89fa-21cc51af69f0@blackwall.org>
Date: Thu, 12 Jun 2025 13:30:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/14] net: ipv6: Add a flags argument to
 ip6tunnel_xmit(), udp_tunnel6_xmit_skb()
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com
References: <cover.1749499963.git.petrm@nvidia.com>
 <ae11785a7fecd87c0bea9ee91704727692e0b3e5.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ae11785a7fecd87c0bea9ee91704727692e0b3e5.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:50, Petr Machata wrote:
> ip6tunnel_xmit() erases the contents of the SKB control block. In order to
> be able to set particular IP6CB flags on the SKB, add a corresponding
> parameter, and propagate it to udp_tunnel6_xmit_skb() as well.
> 
> In one of the following patches, VXLAN driver will use this facility to
> mark packets as subject to IPv6 multicast routing.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC:Pablo Neira Ayuso <pablo@netfilter.org>
> CC:osmocom-net-gprs@lists.osmocom.org
> CC:Andrew Lunn <andrew+netdev@lunn.ch>
> CC:Antonio Quartulli <antonio@openvpn.net>
> CC:"Jason A. Donenfeld" <Jason@zx2c4.com>
> CC:wireguard@lists.zx2c4.com
> CC:Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> CC:linux-sctp@vger.kernel.org
> CC:Jon Maloy <jmaloy@redhat.com>
> CC:tipc-discussion@lists.sourceforge.net
> 
>   drivers/net/bareudp.c          | 3 ++-
>   drivers/net/geneve.c           | 3 ++-
>   drivers/net/gtp.c              | 2 +-
>   drivers/net/ovpn/udp.c         | 2 +-
>   drivers/net/vxlan/vxlan_core.c | 3 ++-
>   drivers/net/wireguard/socket.c | 2 +-
>   include/net/ip6_tunnel.h       | 3 ++-
>   include/net/udp_tunnel.h       | 3 ++-
>   net/ipv6/ip6_tunnel.c          | 2 +-
>   net/ipv6/ip6_udp_tunnel.c      | 5 +++--
>   net/sctp/ipv6.c                | 2 +-
>   net/tipc/udp_media.c           | 2 +-
>   12 files changed, 19 insertions(+), 13 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


