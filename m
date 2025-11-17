Return-Path: <netdev+bounces-239053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88F63C63021
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 09:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2DA554EBF9B
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 08:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE7153164DF;
	Mon, 17 Nov 2025 08:57:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EWvrEJto"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DA431AF18
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 08:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763369839; cv=none; b=Ww2bve4EucVCf5m+Aw8V7cPZZAlyuyUR5wh+ZLicQ+3IC8oeV5+LF9qi7CdrfMb6EjgqikejcH/VOOwJ91gYvxociXR5/zX6MkQY4YFkqgEwt68u2jlTV5p/9Er38K5aU1FqPEl+4b769bN3Rq4FueTJXarLRIJ38/03heEjTgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763369839; c=relaxed/simple;
	bh=ioLqS8GalwouGEb8GwvwRo/Kypwm0iU7NAc0liG+Fho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CsHLTTgnZgwGX/Rt3SpOdTHbBT+sri7guiOGbuAKBj6wBmjrA1HDH7vmvnY72dCKbYUorWX0gNk2mxDh0DbOYeOJmO+SGwersqe1cZqA1zNeVDJ9UPt5T7HELcHxhW3e34InhAe5QeJ7KoCXg1rUgD81nMc7x8zGGV03JXevunc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EWvrEJto; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4eda6a8cc12so39845901cf.0
        for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 00:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763369837; x=1763974637; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CqLaryFBsf9Rs16adOP0tBnlMP/PcQYIuEQ8NalL6s8=;
        b=EWvrEJtofMsjGLVnZ3QTZqyrFO01+s+3+Luns6wyDZhHBYBNL1X72GA0aDRpLhqTTM
         9MXgXYwcl8mxtGatJhRfeX0VjVRlfqv4eYc8Tq2MSXzGQPfsHM8/ky9V4oX2CnOqjr0+
         6LDvnPvMbUlJn4c8gQPD2K6Xnl5cEAjS8aVlD0IWMGUJCfd5fNpeWMO2DADYd28mMjC+
         zXWb4hCHpAWbdkwoPw9asTpjV6GL/5MogVjl9SMj7tH7wip1TAeK1tEX2lPLF6lS4Eou
         pVnpNROBou546fZKC9TQVaqV6yM3SjiHLAPH64fds6b04EwMTqZ09Vo9iqx/j++MpEky
         RZ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763369837; x=1763974637;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CqLaryFBsf9Rs16adOP0tBnlMP/PcQYIuEQ8NalL6s8=;
        b=sr0dXPhAQ/RALRU/H3epW3g8YsjdRp606WBFWBYMvRgQpnGrxFrrPVvee5Y0+cJhEK
         VGoXtiUOoEXjUbrLo45U70R/AUChBEL7Me+f8VOyLE9/SViaSFwirvwcUllT3hrqK5jq
         9GqwO1rhlXFgfQ96M67hFOrKVLMjLv88fSNgpkzrmK+U3Hl1WErd4j5q+PDpb4yPvX5y
         ymJ+fvjhbGE1ovwEW9lUOcVObXxwbnbyB9nP3BsuBi9o79xQUAl84zHu6FwMiPDXayo4
         UQaqhu+CRIhEygPXk8XL7NGVzi2YiRvc/V1a90BRNidQ0dmh6OBzLGmv7vQHpqetBg1/
         Le9w==
X-Forwarded-Encrypted: i=1; AJvYcCU0PZQ7eyE7ix8K/5W1QegP0wLnx6o1uc3i+iWwdpFG80DkyNUShQQyx+xFt+HICL0r2/MrM9Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxieZvDg4qdhZ9SYsARIvzTqWdgGjsJR8IV5Jtajc6b/bmJJmSt
	kuep+Q2cU/lKrjQBFCjvqxzazUkYZmyA67xj8pupfoLRhhzcR/JHwkZAAP1zA3+0QGglLK0H0xC
	Vk+NnnHNYt9L6QmuPFbiWp9dD8aBgi6nWLMmEhgsy
X-Gm-Gg: ASbGncvqWTcO8nYAZHAXIp9nL1BZia/xADGxaZHV0B2TpGjiKQ3I1tMz0JzYUCf2OGb
	li2Cs9Fpqq99dtGQcdkApyGw3FL2mL3ca+tlhhiVnqKAe3/P9/FkeEdheaQ0SFh0Kxz30rngUpz
	E0pD4tXSUoy+5FPWU7VclI1g9MxZX+UBVJdbEpI4wboZoHyEjnAmx+W9KJfgJdN8jDF0KdJSbcy
	W6Scjl427dsWIeHzsWu5b9Ucytu09QsoqgG7gf7wnAgMrgM/cHRWIEjrJNipJMY/XeJ/4U=
X-Google-Smtp-Source: AGHT+IGraBqR+kJP4I1VEqI9z+PmUJlE4sJnaGmANAYG4lhcJqdWQMGpcDOhEDbHSP/r8qPeFQXt1senDrB+P1dfXyo=
X-Received: by 2002:a05:622a:87:b0:4ee:1c10:729f with SMTP id
 d75a77b69052e-4ee1c1076admr44182261cf.35.1763369836456; Mon, 17 Nov 2025
 00:57:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com> <20251116202717.1542829-4-edumazet@google.com>
 <CAL+tcoD3-qtq4Kcmo9eb4mw6bdSYCCjxzNB3qov5LDYoe_gtkw@mail.gmail.com> <CAL+tcoBpUg=ggf6nQpYeZyAcMbXobuJtyUdN98G1HpcuUqFZ+w@mail.gmail.com>
In-Reply-To: <CAL+tcoBpUg=ggf6nQpYeZyAcMbXobuJtyUdN98G1HpcuUqFZ+w@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 17 Nov 2025 00:57:04 -0800
X-Gm-Features: AWmQ_bmG17gbJq3shqejaPuM4Ja_ptmKw5Og12lq2yIJwUPCMpms4jnbYWzFByM
Message-ID: <CANn89iJb8hLw7Mx1+Td_BK7gGm5guRaUe6zdhqRqtfdw_0gLzA@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/3] net: use napi_skb_cache even in process context
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 12:41=E2=80=AFAM Jason Xing <kerneljasonxing@gmail.=
com> wrote:
>
> On Mon, Nov 17, 2025 at 9:07=E2=80=AFAM Jason Xing <kerneljasonxing@gmail=
.com> wrote:
> >
> > On Mon, Nov 17, 2025 at 4:27=E2=80=AFAM Eric Dumazet <edumazet@google.c=
om> wrote:
> > >
> > > This is a followup of commit e20dfbad8aab ("net: fix napi_consume_skb=
()
> > > with alien skbs").
> > >
> > > Now the per-cpu napi_skb_cache is populated from TX completion path,
> > > we can make use of this cache, especially for cpus not used
> > > from a driver NAPI poll (primary user of napi_cache).
> > >
> > > We can use the napi_skb_cache only if current context is not from har=
d irq.
> > >
> > > With this patch, I consistently reach 130 Mpps on my UDP tx stress te=
st
> > > and reduce SLUB spinlock contention to smaller values.
> > >
> > > Note there is still some SLUB contention for skb->head allocations.
> > >
> > > I had to tune /sys/kernel/slab/skbuff_small_head/cpu_partial
> > > and /sys/kernel/slab/skbuff_small_head/min_partial depending
> > > on the platform taxonomy.
> > >
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> >
> > Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
> >
> > Thanks for working on this. Previously I was thinking about this as
> > well since it affects the hot path for xsk (please see
> > __xsk_generic_xmit()->xsk_build_skb()->sock_alloc_send_pskb()). But I
> > wasn't aware of the benefits between disabling irq and allocating
> > memory. AFAIK, I once removed an enabling/disabling irq pair and saw a
> > minor improvement as this commit[1] says. Would you share your
> > invaluable experience with us in this case?
> >
> > In the meantime, I will do more rounds of experiments to see how they p=
erform.
>
> Tested-by: Jason Xing <kerneljasonxing@gmail.com>
> Done! I managed to see an improvement. The pps number goes from
> 1,458,644 to 1,647,235 by running [2].
>
> But sadly the news is that the previous commit [3] leads to a huge
> decrease in af_xdp from 1,980,000 to 1,458,644. With commit [3]
> applied, I observed and found xdpsock always allocated the skb on cpu
> 0 but the napi poll triggered skb_attempt_defer_free() on another
> call[4], which affected the final results.
>
> [2]
> taskset -c 0 ./xdpsock -i enp2s0f1 -q 1 -t -S -s 64
>
> [3]
> commit e20dfbad8aab2b7c72571ae3c3e2e646d6b04cb7
> Author: Eric Dumazet <edumazet@google.com>
> Date:   Thu Nov 6 20:29:34 2025 +0000
>
>     net: fix napi_consume_skb() with alien skbs
>
>     There is a lack of NUMA awareness and more generally lack
>     of slab caches affinity on TX completion path.
>
> [4]
> @c[
>     skb_attempt_defer_free+1
>     ixgbe_clean_tx_irq+723
>     ixgbe_poll+119
>     __napi_poll+48
> , ksoftirqd/24]: 1964731
>
> @c[
>     kick_defer_list_purge+1
>     napi_consume_skb+333
>     ixgbe_clean_tx_irq+723
>     ixgbe_poll+119
> , 34, swapper/34]: 123779
>
> Thanks,
> Jason

Hi Jason.

It is a bit hard to guess without more details (cpu you are using),
and perhaps perf profiles.
In particular which cpu is the bottleneck ?

1) There is still the missing part about tuning NAPI_SKB_CACHE_SIZE /
NAPI_SKB_CACHE_BULK, I was hoping you could send the patch we
discussed earlier ?

2) I am also working on allowing batches of skbs for skb_attempt_defer_free=
().

Another item I am working on is to let the qdisc being serviced
preferably not by the cpu performing TX completion,
I mentioned about making qdisc->running a sequence that we can latch
in __netif_schedule().
(Idea is to be able to not spin on qdisc spinlock from net_tx_action()
if another cpu was able to call qdisc_run())

