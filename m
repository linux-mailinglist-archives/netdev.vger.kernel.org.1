Return-Path: <netdev+bounces-154020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1AAE9FAD3C
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 11:40:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0474E188523C
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 10:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9FB1946B1;
	Mon, 23 Dec 2024 10:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DU9AY154"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E5418DF6D
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 10:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734950424; cv=none; b=m1P0GBTuUMamPv06VDb3hEjpsO8pC8oNMf6cns9K+5ykNq735aCtmqP8pRuIZ4xN5onqq5lzqjJry2+27Tv1qZsIGifbHw+9rCYdzCzX2iCC6b+rvQ/JZZOgHOSmpJU+IDXt+YoYOohQYWPIt4qNIwzDPe5WzC8vPhPok765mgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734950424; c=relaxed/simple;
	bh=ydItanMfRrLKIb6x2HACTspnsqMdZK6gqicgj08D9yM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CcRUWEfcvJzRuB9Rha5IbnqLT96KGVjm/7MmjDLTrT0wWg9j2lPEi3INKG2BklGe0pmEXOftCkc8/IQAKMMloT9b15VpgRiriDNPnfyjZnIR1cYzSlAKaLRfbpapkE9ZEBmlbcck7P7I+r5vfiBfZjwzZOor4Fym7PXXFIq2L7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DU9AY154; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-aa6a92f863cso452116566b.1
        for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 02:40:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734950421; x=1735555221; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pf4JaKxuWpYPFUNNneD9DBJ1LyHqPno0jXSxJEHiUZA=;
        b=DU9AY154OPGyGekoOTiB2qVnd1qnRjiVtGbHsu6wRf4eSu2g7d8NJlyS72z7thFo0c
         pAqHyxOEcpSKdjTEuTM2/iy6dKYH7W12WySpdK0mu64rux8AajJUaHLSvkwFaBjYbiSb
         i4Z0pmk/Mi65qo2LoZa8vkUiT4kjay9nhJa2mnRoZCeOBWu7vrdK4PH3sU1r7NOcsZBB
         HTk98UrfgyPKjFGPk/rHGAeZzuOpgom6m6y8n9IUzDCWGm4Mz23ifPBfH7qDGefIu1Fj
         DQ5f7B1h22ZSs6O9XJ+NP6hAvskyEFHjq6JG25FjoHdkfX1rOIQOFK9+vUiDvyn2LawY
         X8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734950421; x=1735555221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf4JaKxuWpYPFUNNneD9DBJ1LyHqPno0jXSxJEHiUZA=;
        b=rtQ691HNsxW0fkQP3qGgav/2pRTNPS2Gap14DaOpcrMEaiaadbQlJ4IeGz68cjVU5j
         b6x4aL1NbQa6muNDTQgK5wBlSec8GHOAX2JdW6nNeh/NZqRpN3J6gkyfB7NtyxU54zfh
         gngFWVvSwD3NxRPJZR+SrxlQWysCHNIjQtQpUhTGVxyOf+xg9J9nPz9l/HcbFPanlQez
         1hDdtTiNy40c0Lgn5ap147w1WuY6QUAb4uiQL8wIHhza4IIOrs7R56LY6CChWTCUuz6+
         9cFPbxlxKu5/cS2ItojOs3+7U0HiVLYIR0tDkm3vnFDlZDRZl4ehLqNSG+cEgzF5FIXt
         ixYw==
X-Forwarded-Encrypted: i=1; AJvYcCVyIkfVI+ZVnDb++OJ1p//oAmRwT9y9+jcD1hLN3LNE9fX6pV+KCJvgJW9E0oweVjCh/0AMXqE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxdvkq1iPo2ln0JJtPoQp/1MKMoF3tIz8nZvw9743+4HrEN5usf
	RUr03w0gmky549ynHTI/ZkFxfbxVX7gD7fX8tltPg8T4kCFG0hHBz8V6yaIGTCcvJ2HrM7ji+wy
	FudsC7nbYm4pDLWzUDnKXu1XU8CY2s+6FZWHr
X-Gm-Gg: ASbGnctqPgIei+X1IeElwAvQcxqBsuHlz+A1J55whxcQhMrpNZtcIiHnnJzZJp0VOEo
	ME2xCenOgk+FhHS4RH+lBeNU6DMr8nWUxhnQfqk4=
X-Google-Smtp-Source: AGHT+IEeISI7MG6p02f1xgY1PkEwSLuzrZfvUIWmxavvUpsUDPxi5Y6edyls/InQwaxFN+6+LftorsnNrrsy+X+TelE=
X-Received: by 2002:a17:907:2d9f:b0:aa6:8186:5cab with SMTP id
 a640c23a62f3a-aac3378becbmr1035267266b.54.1734950420917; Mon, 23 Dec 2024
 02:40:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5fbeecfc311ea182aa1d1c771725ab8b4cac515e.1729778144.git.benoit.monin@gmx.fr>
In-Reply-To: <5fbeecfc311ea182aa1d1c771725ab8b4cac515e.1729778144.git.benoit.monin@gmx.fr>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 23 Dec 2024 11:40:10 +0100
Message-ID: <CANn89iK1hdC3Nt8KPhOtTF8vCPc1AHDCtse_BTNki1pWxAByTQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: skip offload for NETIF_F_IPV6_CSUM if ipv6
 header contains extension
To: =?UTF-8?Q?Beno=C3=AEt_Monin?= <benoit.monin@gmx.fr>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Jiri Pirko <jiri@resnulli.us>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Lorenzo Bianconi <lorenzo@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 24, 2024 at 4:01=E2=80=AFPM Beno=C3=AEt Monin <benoit.monin@gmx=
.fr> wrote:
>
> As documented in skbuff.h, devices with NETIF_F_IPV6_CSUM capability
> can only checksum TCP and UDP over IPv6 if the IP header does not
> contains extension.
>
> This is enforced for UDP packets emitted from user-space to an IPv6
> address as they go through ip6_make_skb(), which calls
> __ip6_append_data() where a check is done on the header size before
> setting CHECKSUM_PARTIAL.
>
> But the introduction of UDP encapsulation with fou6 added a code-path
> where it is possible to get an skb with a partial UDP checksum and an
> IPv6 header with extension:
> * fou6 adds a UDP header with a partial checksum if the inner packet
> does not contains a valid checksum.
> * ip6_tunnel adds an IPv6 header with a destination option extension
> header if encap_limit is non-zero (the default value is 4).
>
> The thread linked below describes in more details how to reproduce the
> problem with GRE-in-UDP tunnel.
>
> Add a check on the network header size in skb_csum_hwoffload_help() to
> make sure no IPv6 packet with extension header is handed to a network
> device with NETIF_F_IPV6_CSUM capability.
>
> Link: https://lore.kernel.org/netdev/26548921.1r3eYUQgxm@benoit.monin/T/#=
u
> Fixes: aa3463d65e7b ("fou: Add encap ops for IPv6 tunnels")
> Signed-off-by: Beno=C3=AEt Monin <benoit.monin@gmx.fr>
> ---
> changelog
> * v2:
>     - patch against net instead of net-next
>     - clarify documentation of NETIF_F_IPV6_CSUM
>     - add link to thread describing the problem
>     - add fixes tag
>     - use vlan_get_protocol to check for IPv6
> * v1:
>     - https://lore.kernel.org/netdev/0dc0c2af98e96b1df20bd36aeaed4eb4e27d=
507e.1728056028.git.benoit.monin@gmx.fr/T/#u
> ---
>  net/core/dev.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index ea5fbcd133ae..8453e14d301b 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3639,6 +3639,9 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
>                 return 0;
>
>         if (features & (NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM)) {
> +               if (vlan_get_protocol(skb) =3D=3D htons(ETH_P_IPV6) &&
> +                   skb_network_header_len(skb) !=3D sizeof(struct ipv6hd=
r))
> +                       goto sw_checksum;
>                 switch (skb->csum_offset) {
>                 case offsetof(struct tcphdr, check):
>                 case offsetof(struct udphdr, check):
> @@ -3646,6 +3649,7 @@ int skb_csum_hwoffload_help(struct sk_buff *skb,
>                 }
>         }
>
> +sw_checksum:
>         return skb_checksum_help(skb);
>  }
>  EXPORT_SYMBOL(skb_csum_hwoffload_help);


FYI, this patch broke BIG TCP over IPv6.

[  239.698598] Oops skb_network_header_len()=3D48 skb->len=3D67210
[  239.704122] skb len=3D67210 headroom=3D162 headlen=3D94 tailroom=3D0
               mac=3D(162,14) mac_len=3D0 net=3D(176,48) trans=3D224
               shinfo(txflags=3D0 nr_frags=3D3 gso(size=3D1428 type=3D16 se=
gs=3D47))
               csum(0x1000e0 start=3D224 offset=3D16 ip_summed=3D3
complete_sw=3D0 valid=3D0 level=3D0)
               hash(0xadf29e31 sw=3D0 l4=3D1) proto=3D0x86dd pkttype=3D0 ii=
f=3D0
               priority=3D0x18020 mark=3D0x0 alloc_cpu=3D46 vlan_all=3D0x0
               encapsulation=3D0 inner(proto=3D0x0000, mac=3D0, net=3D0,
trans=3D0)\x00, net=3D0, trans=3D0)
[  239.704153] dev name=3Deth2 feat=3D0x0000030000114ab3
[  239.704155] sk family=3D10 type=3D1 proto=3D6
[  239.704156] skb linear:   00000000: 02 32 00 00 00 00 94 eb 2c 18
9c d8 86 dd 60 2d
[  239.704157] skb linear:   00000010: 31 9e 00 00 00 7f 20 02 0a 0d
87 01 00 00 00 00
[  239.704158] skb linear:   00000020: 00 00 00 00 00 00 20 02 0a 05
68 30 1f 86 00 00
[  239.704159] skb linear:   00000030: 00 00 00 00 00 00 06 00 c2 04
00 01 06 54 ac 4c
[  239.704160] skb linear:   00000040: 81 9b 82 a6 d6 74 ca 75 8d 24
80 18 00 42 69 21
[  239.704161] skb linear:   00000050: 00 00 01 01 08 0a 1b fe e2 2a ca 8f =
78 6e
[  239.704162] skb frag:     00000000: 6e 65 74 70 65 72 66 00 6e 65
74 70 65 72 66 00
[  239.704163] skb frag:     00000010: 6e 65 74 70 65 72 66 00 6e 65
74 70 65 72 66 00
[  239.704163] skb frag:     00000020: 6e 65 74 70 65 72 66 00 6e 65
74 70 65 72 66 00
[  239.704164] skb frag:     00000030: 6e 65 74 70 65 72 66 00 6e 65
74 70 65 72 66 00
[  239.704165] skb frag:     00000040: 6e 65 74 70 65 72 66 00 6e 65
74 70 65 72 66 00
[  239.704166] skb frag:     00000050: 6e 65 74 70 65 72 66 00 6e 65
74 70 65 72 66 00
[  239.704166] skb frag:     00000060: 6e 65 74 70 65 72 66 00 6e 65
74 70 65 72 66 00
[  239.704167] skb frag:     00000070: 6e 65

