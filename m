Return-Path: <netdev+bounces-228905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A18CBD5CCA
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 20:54:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51A6C18A77BC
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:54:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429932D8384;
	Mon, 13 Oct 2025 18:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iDhhy3hW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF412D6E57
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 18:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760381652; cv=none; b=SVi0B3hatkcQP407APO6KG6dEe7WAwUrcZup4Rbeapu7stQ4zGnmq6hgazVEDNbem5x16SucGIis6AbceSrAmQMQbXyPd5cNzTU2Tl+lBa2Rd6qayoI34kIXZ7FrbB7AE7u+p8Zqc6P9sEWzdOtfvzOIcqjvWBejLKqHGFZ54K0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760381652; c=relaxed/simple;
	bh=Q0A8mwHB6ISznX1IsEIotmy3Sl/eaR8kzKeY3PLseig=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p2BO1ioAingm88kdFgAY/4x2V5C2wLJlqISVqzNLwQu1lde75K9zn9Bivy12xwFhZIeE9dk0mfSzvG1T4y014yjwJBGe9xoJRWHhzrmukpD6ZiLgjwXywJyn2TFgWMJ5WNZXpelYRWfofzQWtq5NCwxGXnb3xG92mDIB6TzAcRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iDhhy3hW; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-875d55217a5so626076585a.2
        for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1760381649; x=1760986449; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHvdDoFLXKQzTfUBohM5QpfVzGeutBShrm8qkwsGAgA=;
        b=iDhhy3hWQseR7B59Wk9B1f1X5jyath/Vv1m6ebI7H29S1vvYX6vMnQ3ToYPWAWwJUf
         KogVPsls1PuYOmBJZZsKhmYfqJWhawxOO/jQW2Zd36FIr0VZwKyytraEV8ZQjhsiquKT
         8U/DgtZm/LBOH3sITn2q+qLwHHdZk/TwqTr0Lgz0PVxEVezb4L01HkZupGnKTuJT3QXX
         QiK7W69yIlzxc12ngLPQ297WhE1NJBvA+bcqRgtWl/6h7ziB37bozqi/nnWtGcLxzF0e
         oPd3Ma2yPQ0FfC6+IjBkEPm7sOjUjvE1B5LQKtDCnTp+4z2xorUoAsBv0RJ+504llQ1n
         umfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760381649; x=1760986449;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHvdDoFLXKQzTfUBohM5QpfVzGeutBShrm8qkwsGAgA=;
        b=ajxaZLbwacGpptD4IlizViBHvQX+x2+WL08ZgsyopSgk6+vAY1DY8Sa2ESCxIyn6up
         jsqV/yPOz4rsWUSFktafa0bqd/LfL5rWDHQwiNucYHHlAm5eVXZrCgQwrBptH0cqeyUQ
         gviuw+EiUlmE5umJUb1RQ2M/61L5nJqHFgNVVis1InLUc3ZKNljpojWTqTWEj6HA4TP+
         NSDi6KD1jgIwqbx5CxZwiSCqrYH6xOV2uu1WK2XmIx2wWhC3Dk4mfqDusaoRe6lhcYYu
         R2hu4InozWvgwgRP7naRyb0Eg7D4UPUhGFceZ6sB/FDLNBiTYOH3JB/I5QltObthFvaw
         aILg==
X-Gm-Message-State: AOJu0YwwbD5YfOPnwQwNKsDbSSyjSIUAAr9O0AOJYq0W4BHUGlsU0lyp
	d0BvIy7leOuiULDWw8mcrQv9A8aGNe3YOllrObMBIwJ2U/rVhT+25bfGM/SZhDXC7LsNxd3t801
	sDimOfrzAhwAFLpEluLYoM5V4a/YutaNgbKp2sm8t
X-Gm-Gg: ASbGnctWYJ7M6SXYShWxubyeoVVIoJMBMaEaHv1cLNvzh4sb0K7jqEXyXqc+5wlG7Vt
	qr5BW/I6e/6bq0sOgDh7L/uDFg0NCYSDLBsnj5rm1r6soPVEoz3aAI0DJu82GfcZJ6t9/0SIyGL
	1CfI0M+xZEKgChckY1/3scAJBTQStK2qXmWFw/i7ugkH4zerQzLHZoCv/hlc45ni8p/jrirBr4w
	pdl+/gurXUSYihOKtSDUTro68cfJ7Nv
X-Google-Smtp-Source: AGHT+IHEX/LXCcXiIAvMWCf1qx+3kkMbx/P3MOisSt6xugJLgd5lVynv5AI5WAJHsRmWmbQAX0ncoNz5Nk1IfQjetPE=
X-Received: by 2002:ac8:5902:0:b0:4de:b0d4:dda4 with SMTP id
 d75a77b69052e-4e6ead7493fmr328872751cf.69.1760381648539; Mon, 13 Oct 2025
 11:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251013101636.69220-1-21cnbao@gmail.com>
In-Reply-To: <20251013101636.69220-1-21cnbao@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 13 Oct 2025 11:53:57 -0700
X-Gm-Features: AS18NWAe_NmExu5WITMBDbR0FpCc3scky7DNzwEUSRCGS5tETmNSC2IUauhYc4w
Message-ID: <CANn89i+wikOQQrGFXu=L3nKPG62rsBmWer5WpLg5wmBN+RdMqA@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: net: disable kswapd for high-order network buffer allocation
To: Barry Song <21cnbao@gmail.com>
Cc: netdev@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Barry Song <v-songbaohua@oppo.com>, 
	Jonathan Corbet <corbet@lwn.net>, Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
	Brendan Jackman <jackmanb@google.com>, Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>, 
	Yunsheng Lin <linyunsheng@huawei.com>, Huacai Zhou <zhouhuacai@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 13, 2025 at 3:16=E2=80=AFAM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> From: Barry Song <v-songbaohua@oppo.com>
>
> On phones, we have observed significant phone heating when running apps
> with high network bandwidth. This is caused by the network stack frequent=
ly
> waking kswapd for order-3 allocations. As a result, memory reclamation be=
comes
> constantly active, even though plenty of memory is still available for ne=
twork
> allocations which can fall back to order-0.
>
> Commit ce27ec60648d ("net: add high_order_alloc_disable sysctl/static key=
")
> introduced high_order_alloc_disable for the transmit (TX) path
> (skb_page_frag_refill()) to mitigate some memory reclamation issues,
> allowing the TX path to fall back to order-0 immediately, while leaving t=
he
> receive (RX) path (__page_frag_cache_refill()) unaffected. Users are
> generally unaware of the sysctl and cannot easily adjust it for specific =
use
> cases. Enabling high_order_alloc_disable also completely disables the
> benefit of order-3 allocations. Additionally, the sysctl does not apply t=
o the
> RX path.
>
> An alternative approach is to disable kswapd for these frequent
> allocations and provide best-effort order-3 service for both TX and RX pa=
ths,
> while removing the sysctl entirely.
>
>
...

> Signed-off-by: Barry Song <v-songbaohua@oppo.com>
> ---
>  Documentation/admin-guide/sysctl/net.rst | 12 ------------
>  include/net/sock.h                       |  1 -
>  mm/page_frag_cache.c                     |  2 +-
>  net/core/sock.c                          |  8 ++------
>  net/core/sysctl_net_core.c               |  7 -------
>  5 files changed, 3 insertions(+), 27 deletions(-)
>
> diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/adm=
in-guide/sysctl/net.rst
> index 2ef50828aff1..b903bbae239c 100644
> --- a/Documentation/admin-guide/sysctl/net.rst
> +++ b/Documentation/admin-guide/sysctl/net.rst
> @@ -415,18 +415,6 @@ GRO has decided not to coalesce, it is placed on a p=
er-NAPI list. This
>  list is then passed to the stack when the number of segments reaches the
>  gro_normal_batch limit.
>
> -high_order_alloc_disable
> -------------------------
> -
> -By default the allocator for page frags tries to use high order pages (o=
rder-3
> -on x86). While the default behavior gives good results in most cases, so=
me users
> -might have hit a contention in page allocations/freeing. This was especi=
ally
> -true on older kernels (< 5.14) when high-order pages were not stored on =
per-cpu
> -lists. This allows to opt-in for order-0 allocation instead but is now m=
ostly of
> -historical importance.
> -

The sysctl is quite useful for testing purposes, say on a freshly
booted host, with plenty of free memory.

Also, having order-3 pages if possible is quite important for IOMM use case=
s.

Perhaps kswapd should have some kind of heuristic to not start if a
recent run has already happened.

I am guessing phones do not need to send 1.6 Tbit per second on
network devices (yet),
an option  could be to disable it in your boot scripts.

