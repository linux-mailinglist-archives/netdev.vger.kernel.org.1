Return-Path: <netdev+bounces-196894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA49AD6DAE
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 12:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB75C3A33F0
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6293230BC0;
	Thu, 12 Jun 2025 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="KTOKy+47"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053E91C32FF
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 10:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749724105; cv=none; b=TQ8JK1YFmrkXI0XA0MCqO+W6Yet1tZAhe8OaNDpP9Bw16FBfmwW6swXnnF2Yis+OmtpOM1w660kiuLRcGfXzEkj5uy9AbZkeLzsB9zBE2lUbO9Mok/5IrvkeQojM9/nuLSkGYTVqFsN/yjBXOE7yShDwLF//h9ZBxKbzwF8PuhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749724105; c=relaxed/simple;
	bh=xWIqj6aprpDfjLRAvATge4t82VpM1CEeDxd5L0CT2ek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eIxOYqG2IBmkZ7ttAUm1xMtAzUtghcbcMRK2Zyey22LsqfBwp27dAOoHTQVNQsjyd4unhSy1Pu9hz2nORKi5Kz3xYDBaT04u5p4ldpoQ1KalbDBA1YZRLpbDLsOLyALQn75IzIeZLT+IRI/5YCiQzH2v/IC4c0TJnuqMxGfC/pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=KTOKy+47; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-553246e975fso843564e87.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 03:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1749724102; x=1750328902; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdrRzDXFOwHG448jvig1wt2IVm7ZK5vVmOxfUEc3Mfw=;
        b=KTOKy+47M9f0qDWFBsMxDcBw8cQ/Q0PKsXAkNy7pjz13cFmUSzfw2boKbWSociwLbh
         yrWKxhE0YErfKnMUxoSk4orFw3kJw8Q2Gq8oiM8+Gj2fn7IMHyIN8yp+tHLsX2p3hUYU
         49b0tW9uz5r6WJ0HD1o6cO9RL2Y3sUYTXuyl7cWqMD922h2JDwbsmtpOEbn2+AePV8uJ
         MvIKn/QaR6hUtI/SPslpf4soeVQlXtJWfnLidxNlRGd7emQYPnKFKXGlNfJvLYqjw8JT
         UcJFp8vdx3o4TnLEEJ/TUMBwmnDdpfxMaODzx9OlB8kN6hYSwSStktTOu9WwAAL8EKn8
         TSAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749724102; x=1750328902;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jdrRzDXFOwHG448jvig1wt2IVm7ZK5vVmOxfUEc3Mfw=;
        b=eGjOpAOK79Je8ZVQDO6B5aOQYAXiAW5h+bkewfI10RHopBvh74C6L9ksVOO6pvxd6o
         jeniWo7hfRPoWClIPhQt2Kresu/3mFqF1DJQew8uKS9jEZqgHQ2VEtkx0pKh3c9nnIiH
         5WMgh0WUbb6CKdccShZOqeyQ/UqSfGK1hs24W04OZgF1S+DbcML/P4btvZEbAQk+Ra1A
         RrksqNNHzZ3BAWbIlY8Rb+9UCgegzAmQb2IRL1R0WFiobln1MsnUUR7AKDvLuhRxfDjj
         vqtrdEyVIAmpMuDSUAD/GMf/4c9dd+TTCGuUB+U66jFUfsweudikc/QasIsjZTfgEQlY
         /2kg==
X-Forwarded-Encrypted: i=1; AJvYcCXY2XQXRY3bKNSgNk0KOCAjRLcHpblJd0z8mXVMb4lbttbw6XPTBOM/wUUVKLvJ+6RfWKnC7mo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsJsBEYQ0MgcyJjAajKUqGfdvuaBkT0eJJep+nq6cHsi7Orl9j
	dbqAAkUFCfjwRyfv/HJ8BzjRRmTFx2BkOp/qmK5jHEI34036Azo9L1Ip+G5GmzfRVJA=
X-Gm-Gg: ASbGncsHq6zigYXwg6hAVCLNGiwZEzIQUuSJPLWJ2Iz2Fg95xgC8WnAzTUNo0F7pSxS
	vjp1kdmh5wwm01qoJ83lJDRme/2BkE2ciQAxNnBloI1tQBMPUTr4PMwPgs8P+tMpsDaC1eWeMHb
	4qOuudzZi05OnP/vtsS75Ex37Xx6WaNL2YHu0hooHBogcvTFYS/pX0zdEIm5RfUs+G+tZQsGQym
	RLBi1r8D0h8ekM61cs1+6L1eWrCAjGfciKevi0YURTOr/7YWcMtPdPlGvZC1QMe9lhfvu6LMZQn
	OgKEh96zY5AJwtpCcHsEeFLrOBRLZo5Tyh0pz5byb0FgGQ9e8WXh5MsySkKrcFsL2X+z1HFpkKQ
	SQisv6hLULifZAJLfiFV0FYIc1lak4dPYt+eyQkoAGw==
X-Google-Smtp-Source: AGHT+IGMFEbW3kewoiFhwiIdhmG/b2bgCVSsV0qnpHHNcqp+03mzW/XSSQXifX6p6Cue4i8glJvBHQ==
X-Received: by 2002:a05:6512:4004:b0:54f:c6b0:4b67 with SMTP id 2adb3069b0e04-553a5453064mr1024275e87.4.1749724101957;
        Thu, 12 Jun 2025 03:28:21 -0700 (PDT)
Received: from [100.115.92.205] (176.111.185.210.kyiv.nat.volia.net. [176.111.185.210])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-553ac13f0besm68262e87.84.2025.06.12.03.28.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 03:28:21 -0700 (PDT)
Message-ID: <def0704c-38ed-42ac-8287-503ebbb61115@blackwall.org>
Date: Thu, 12 Jun 2025 13:28:19 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/14] net: ipv4: Add a flags argument to
 iptunnel_xmit(), udp_tunnel_xmit_skb()
To: Petr Machata <petrm@nvidia.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@gmail.com>,
 netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 mlxsw@nvidia.com, Pablo Neira Ayuso <pablo@netfilter.org>,
 osmocom-net-gprs@lists.osmocom.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 Taehee Yoo <ap420073@gmail.com>, Antonio Quartulli <antonio@openvpn.net>,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, wireguard@lists.zx2c4.com,
 Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
 linux-sctp@vger.kernel.org, Jon Maloy <jmaloy@redhat.com>,
 tipc-discussion@lists.sourceforge.net
References: <cover.1749499963.git.petrm@nvidia.com>
 <c77a0c8e4ada63a0a69d7011fb901703ebf1f09a.1749499963.git.petrm@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <c77a0c8e4ada63a0a69d7011fb901703ebf1f09a.1749499963.git.petrm@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/9/25 23:50, Petr Machata wrote:
> iptunnel_xmit() erases the contents of the SKB control block. In order to
> be able to set particular IPCB flags on the SKB, add a corresponding
> parameter, and propagate it to udp_tunnel_xmit_skb() as well.
> 
> In one of the following patches, VXLAN driver will use this facility to
> mark packets as subject to IP multicast routing.
> 
> Signed-off-by: Petr Machata <petrm@nvidia.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> ---
> 
> Notes:
> CC: Pablo Neira Ayuso <pablo@netfilter.org>
> CC: osmocom-net-gprs@lists.osmocom.org
> CC: Andrew Lunn <andrew+netdev@lunn.ch>
> CC: Taehee Yoo <ap420073@gmail.com>
> CC: Antonio Quartulli <antonio@openvpn.net>
> CC: "Jason A. Donenfeld" <Jason@zx2c4.com>
> CC: wireguard@lists.zx2c4.com
> CC: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>
> CC: linux-sctp@vger.kernel.org
> CC: Jon Maloy <jmaloy@redhat.com>
> CC: tipc-discussion@lists.sourceforge.net
> 
>   drivers/net/amt.c              |  9 ++++++---
>   drivers/net/bareudp.c          |  4 ++--
>   drivers/net/geneve.c           |  4 ++--
>   drivers/net/gtp.c              | 10 ++++++----
>   drivers/net/ovpn/udp.c         |  2 +-
>   drivers/net/vxlan/vxlan_core.c |  2 +-
>   drivers/net/wireguard/socket.c |  2 +-
>   include/net/ip_tunnels.h       |  2 +-
>   include/net/udp_tunnel.h       |  2 +-
>   net/ipv4/ip_tunnel.c           |  4 ++--
>   net/ipv4/ip_tunnel_core.c      |  4 +++-
>   net/ipv4/udp_tunnel_core.c     |  5 +++--
>   net/ipv6/sit.c                 |  2 +-
>   net/sctp/protocol.c            |  3 ++-
>   net/tipc/udp_media.c           |  2 +-
>   15 files changed, 33 insertions(+), 24 deletions(-)
> 

Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>


