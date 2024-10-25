Return-Path: <netdev+bounces-139146-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7D3C9B068E
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 16:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E5C0281DA1
	for <lists+netdev@lfdr.de>; Fri, 25 Oct 2024 14:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A1F1442F3;
	Fri, 25 Oct 2024 14:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lg6zBt1j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A86139CFA;
	Fri, 25 Oct 2024 14:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729868158; cv=none; b=PccH2xR7qu95ktNPNm+VcIU3aX0404Yk1a+0LLvwWmhJdi0ckBZqIfk+Xeod0emrssLIlcu75K+QIi8MbG/lkQe93t7I/jDYTw+Iv6DHpupzypPwDQ0g9mFGFYR76QeQNPlYYWY5L64szkfLK1yO5Zawn2HDY7IR0MUsYf1qnp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729868158; c=relaxed/simple;
	bh=cYC84NVRftr8KOmCtX7HT6d9aXDsbV+gczDOJhFRyN4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ts/WF6OOj5W2BQcz3GPhwcA5DS5r3ttspqkKPYRF8PrrFDzZYiPaL7ri4lD4NTMvnLMBUDgH7LHCi9ER/U9YBf4mzVIYKZ2SZmLXjPOs0ygdBeSvlwqw5bDSTkm8aIfuNupj8Tz6yk6qCyUoJst2b/bUgLzesaH2qK7x5Qpm4bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lg6zBt1j; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-7b1488fde46so137775085a.2;
        Fri, 25 Oct 2024 07:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729868155; x=1730472955; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xb4NK7TZAklqsLZ4WbcSQYfLgzsdssWA6GodMIVJSvo=;
        b=Lg6zBt1jSashAJU2Ef0UmdyB8BeYUdhh+qJ1PYVDX3luwCu6YbQj3P59hCo0wmFf8S
         UYgD58etm8iWTXjTivFsgkw6r/7OICixijk2aFxYMTxNxV2YtztbA2A2K1H0HqyCx0on
         2hbj0O8prsLDLpNIY/Wu+Q63JUUE3ttxgD33tkfKvlS3WDmWDQVUeQjk8ZhIuYFF4PUK
         j3kOk9gQxTbeuTb7ruAgDQAQ6/Hyiog51j/Iiu9jTUvp1Rsv1fZMYQWV9DG6HGHTq7ll
         Et6ys05R1hrgkegJh+0mgRPlepmxuTFjQXff6t8JS62T8tbuHZt/mIFKFjbpyPtjWioA
         XnDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729868155; x=1730472955;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xb4NK7TZAklqsLZ4WbcSQYfLgzsdssWA6GodMIVJSvo=;
        b=sDPfpoOGZO1Jm7PgqhqPjXsuv2oppFk/Qmq9fxmaDJZbEt910Z1zRZVIJSgBgIu3sU
         gTIJluuwdxRZLt3I91o7iSnlHzRHkaCKS+qmSqdfAUgPG9fZMlvWIr9d1VMxdkIyMJ2n
         aqco/VhQh4Ms30rctPahj59tycKTEIUDls+LLgYQc3zdHs0EeSRF7b/ljLNVsm2lHLep
         wsL05L6cgKb1kyRvD28rnrCZNPDvpxzF8i/TXDIAdn2cUKhVVotFGr6S3ara6rPzihR0
         1iV3heOpMMVUo05hKBtNEddmBw3Gb50auEIeufOvO2J5kCqA9LeDx4gXVgd5dseXX+mF
         cT8g==
X-Forwarded-Encrypted: i=1; AJvYcCWV1G1A032Ze9oGreS4CRxROpfXz4ZbdjzChUhl4HunZ10PRlaYLxKWCUizKF0uqIAHDI+u/XZTue7YUfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzG2RgwEfUsKXS1GYOhQr6C+Q0No30g2psKTQiSjIyK3Ebo4p4I
	Dao3a/mA3xZyDIHhjyYB9sT3e6a5ljLHB58VhRnjM6dPZ/wRvr8g
X-Google-Smtp-Source: AGHT+IFkxvItP4r6zd9To7kU+8mtrX7FKFscGnaLN0+OQtyFj8zqVfn81MOX/LzQrCo1equ2PL+hBw==
X-Received: by 2002:a05:620a:17a8:b0:7b1:4579:80fc with SMTP id af79cd13be357-7b186d0c9demr702413285a.60.1729868155113;
        Fri, 25 Oct 2024 07:55:55 -0700 (PDT)
Received: from localhost (86.235.150.34.bc.googleusercontent.com. [34.150.235.86])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b18d278294sm60984685a.20.2024.10.25.07.55.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Oct 2024 07:55:54 -0700 (PDT)
Date: Fri, 25 Oct 2024 10:55:53 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?QmVub8OudCBNb25pbg==?= <benoit.monin@gmx.fr>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Jiri Pirko <jiri@resnulli.us>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?UTF-8?B?QmVub8OudCBNb25pbg==?= <benoit.monin@gmx.fr>
Message-ID: <671bb179d039d_34060c294fd@willemb.c.googlers.com.notmuch>
In-Reply-To: <5fbeecfc311ea182aa1d1c771725ab8b4cac515e.1729778144.git.benoit.monin@gmx.fr>
References: <5fbeecfc311ea182aa1d1c771725ab8b4cac515e.1729778144.git.benoit.monin@gmx.fr>
Subject: Re: [PATCH v2 net] net: skip offload for NETIF_F_IPV6_CSUM if ipv6
 header contains extension
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

Beno=C3=AEt Monin wrote:
> As documented in skbuff.h, devices with NETIF_F_IPV6_CSUM capability
> can only checksum TCP and UDP over IPv6 if the IP header does not
> contains extension.
> =

> This is enforced for UDP packets emitted from user-space to an IPv6
> address as they go through ip6_make_skb(), which calls
> __ip6_append_data() where a check is done on the header size before
> setting CHECKSUM_PARTIAL.
> =

> But the introduction of UDP encapsulation with fou6 added a code-path
> where it is possible to get an skb with a partial UDP checksum and an
> IPv6 header with extension:
> * fou6 adds a UDP header with a partial checksum if the inner packet
> does not contains a valid checksum.
> * ip6_tunnel adds an IPv6 header with a destination option extension
> header if encap_limit is non-zero (the default value is 4).
> =

> The thread linked below describes in more details how to reproduce the
> problem with GRE-in-UDP tunnel.
> =

> Add a check on the network header size in skb_csum_hwoffload_help() to
> make sure no IPv6 packet with extension header is handed to a network
> device with NETIF_F_IPV6_CSUM capability.
> =

> Link: https://lore.kernel.org/netdev/26548921.1r3eYUQgxm@benoit.monin/T=
/#u
> Fixes: aa3463d65e7b ("fou: Add encap ops for IPv6 tunnels")
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@gmx.fr>

Reviewed-by: Willem de Bruijn <willemb@google.com>

> ---
> changelog
> * v2:
>     - patch against net instead of net-next
>     - clarify documentation of NETIF_F_IPV6_CSUM
>     - add link to thread describing the problem
>     - add fixes tag
>     - use vlan_get_protocol to check for IPv6
> * v1:
>     - https://lore.kernel.org/netdev/0dc0c2af98e96b1df20bd36aeaed4eb4e2=
7d507e.1728056028.git.benoit.monin@gmx.fr/T/#u
> ---
>  net/core/dev.c | 4 ++++
>  1 file changed, 4 insertions(+)
> =

> diff --git a/net/core/dev.c b/net/core/dev.c
> index ea5fbcd133ae..8453e14d301b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3639,6 +3639,9 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
>  		return 0;
> =

>  	if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
> +		if (vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6) &&
> +		    skb_network_header_len(skb) !=3D sizeof(struct ipv6hdr))
> +			goto sw_checksum;

skb_network_header_len requires skb->transport_header to be set.

This is not true for all egress packets. See for instance commit
d2aa125d6290 ("net: Don't set transport offset to invalid value").

But it should be true for all CHECKSUM_PARTIAL packets. See for
instance skb_partial_csum_set. So LGTM.

Just calling this out as it is not obvious and in case someone
does know a counter example of CHECKSUM_PARTIAL and
!skb_transport_header_was_set.


