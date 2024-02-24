Return-Path: <netdev+bounces-74715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDCE8626E3
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 20:08:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29C01C20BD7
	for <lists+netdev@lfdr.de>; Sat, 24 Feb 2024 19:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3194C624;
	Sat, 24 Feb 2024 19:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mdY1AoOt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743354C622
	for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 19:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708801699; cv=none; b=qz0cFPbyE5/FZz3Ibj1TR/maoCwPRG5dyQURh+IJdT6EItf1/ooqvr3k+XPQmBmnp+sAxl/aj0qjvj7RDvIYgK4+msteQDjdHt1PvbRo7K390x6Ze8xTF9G1w/gCoB8xoi953tKNV/sqM2izzTubQjqe/4tXnUST9nZ/36Gxr5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708801699; c=relaxed/simple;
	bh=ywTdtlsxaTGNOg/0ykAO9vIS5LDXi2sRHe/FWPBh5EQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mtTvTpg4TRJ+rhrZ2u6HjZI6UfDNUOo6BY3hNuBhh3LwihVlc3A4sI2c5TMMWqgJo7sCmoKAdlkgrd0Hd2kTKQ4QV4HqOaljZgIjQIcacOyt9Sn2TccefQhvdDV9R+gcJ7NhdZxmb93JHfmf6zXgrssxMxu5k2/1f2pw160UGnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mdY1AoOt; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so4636a12.1
        for <netdev@vger.kernel.org>; Sat, 24 Feb 2024 11:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708801696; x=1709406496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ITGZMfMCrb1CACtG+hsG+yIMHew98TIZDUao5iyuYr0=;
        b=mdY1AoOtLekbSYrrSz1zpEZVAaFHTcRK7rz/mawpXUuA+XpKUz+N5YbsVB4MwX5qVC
         2NbbjGUhJp/cXqkhXLPc1a6SGoKhpQNLWpwNE6Sl+8SV1zNS0scKWrtm23Z0+TZW+OQR
         BdiyVRXS/vduiL1MAi1arRQcIUqwa1+k2a091QCJVA/AhzFRpvtq1u3moCRAKOk4mpGf
         /61GPEtdJpr5WzkX6iMB0llkeR/QWMXXugf4ESxk5oBp/VovjH2NF8wsnVEZ8LB3vvRR
         QsFTRVlMl7iUDFpl+5fYMj2wAVB7FeJzVGry4egtq5yxWid2/fxHYK6DTG5C8c9qpnD3
         bYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708801696; x=1709406496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ITGZMfMCrb1CACtG+hsG+yIMHew98TIZDUao5iyuYr0=;
        b=elc5Gt8X3Skn/4A+h/fHL9+2TYkSxZMP8ToiRibWcrCzCvWXSst+2UVP1VbOqiKw32
         KJTHe0OABWauGS/4hzNMNxdvRItf09q3c+km055Ng276BFuaDeaOs/YnRvrarrwWhcBu
         l06Gjw7xObuP0Fo+GdJ71T7ZaZcWkWnWdc3OfyW7pBg+hQkNXu+cOIwT1KRgtIeUUBJU
         nydqdS7xtIdcGF7tGCwtUbzhGWRmxu/DB+d0kVB6ZMSUGtEctrDF/+zvcjOLX1mtZgqy
         U8J1S04FuCooP4v/H+BSCyEO6NxhPTPBiHlA4bzOtEUXUr0SeWvfii6ETKwX44KcSqRr
         Vp4g==
X-Forwarded-Encrypted: i=1; AJvYcCX6HD8z61fktOoeB7i38t+Gvv44Rg+ZBPWsxaWHNwhgHCDoWc2mGrLhQhedm62zFpjygwsmkwIVkwqZsaM9Bnf+fHR+x1gg
X-Gm-Message-State: AOJu0Yz02vCujLGDSTjJoT/vbd6bo7WyfwpbeGR22GJcOgt2hPejF7gJ
	l8vCrUFDqG1UU80KTNMeAEw/y3NUQXveUUpDwYsovBO/XTN9D9wO81veq+SpGJ5B+B84eQGiVSY
	f4z/pNrMed4B7gbf6mgirJZxtfKuf27NPgYo3
X-Google-Smtp-Source: AGHT+IH+MnlNwa+mKfnYWerJnvT+05mEc77N4U0sR7aT0piVfxvgGgL3543LPKu18wSlD+rtznF7C60YsTeC8sBQrKY=
X-Received: by 2002:a50:c355:0:b0:565:123a:ccec with SMTP id
 q21-20020a50c355000000b00565123accecmr139505edb.3.1708801689070; Sat, 24 Feb
 2024 11:08:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220021804.9541-1-shijie@os.amperecomputing.com>
 <CANn89iJoHDzfYfhcwVvR4m7DiVG-UfFNqm+D1WD-2wjOttk6ew@mail.gmail.com>
 <bea860f8-a196-4dff-a655-4da920e2ebfa@amperemail.onmicrosoft.com>
 <CANn89i+1uMAL_025rNc3C1Ut-E5S8Nat6KhKEzcFeC1xxcFWaA@mail.gmail.com> <c2bd73b6-b21f-4ad8-a176-eec677bc6cf3@amperemail.onmicrosoft.com>
In-Reply-To: <c2bd73b6-b21f-4ad8-a176-eec677bc6cf3@amperemail.onmicrosoft.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 24 Feb 2024 20:07:55 +0100
Message-ID: <CANn89i+Cr1Tbdxqy6fB-sOLca+AHFc-3-0xGktVUsQFFMVsC0A@mail.gmail.com>
Subject: Re: [PATCH] net: skbuff: allocate the fclone in the current NUMA node
To: Shijie Huang <shijie@amperemail.onmicrosoft.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: Huang Shijie <shijie@os.amperecomputing.com>, kuba@kernel.org, 
	patches@amperecomputing.com, davem@davemloft.net, horms@kernel.org, 
	ast@kernel.org, dhowells@redhat.com, linyunsheng@huawei.com, 
	aleksander.lobakin@intel.com, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, cl@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 9:37=E2=80=AFAM Shijie Huang
<shijie@amperemail.onmicrosoft.com> wrote:
>
>
> =E5=9C=A8 2024/2/20 16:17, Eric Dumazet =E5=86=99=E9=81=93:
> > On Tue, Feb 20, 2024 at 7:26=E2=80=AFAM Shijie Huang
> > <shijie@amperemail.onmicrosoft.com> wrote:
> >>
> >> =E5=9C=A8 2024/2/20 13:32, Eric Dumazet =E5=86=99=E9=81=93:
> >>> On Tue, Feb 20, 2024 at 3:18=E2=80=AFAM Huang Shijie
> >>> <shijie@os.amperecomputing.com> wrote:
> >>>> The current code passes NUMA_NO_NODE to __alloc_skb(), we found
> >>>> it may creates fclone SKB in remote NUMA node.
> >>> This is intended (WAI)
> >> Okay. thanks a lot.
> >>
> >> It seems I should fix the issue in other code, not the networking.
> >>
> >>> What about the NUMA policies of the current thread ?
> >> We use "numactl -m 0" for memcached, the NUMA policy should allocate
> >> fclone in
> >>
> >> node 0, but we can see many fclones were allocated in node 1.
> >>
> >> We have enough memory to allocate these fclones in node 0.
> >>
> >>> Has NUMA_NO_NODE behavior changed recently?
> >> I guess not.
> >>> What means : "it may creates" ? Please be more specific.
> >> When we use the memcached for testing in NUMA, there are maybe 20% ~ 3=
0%
> >> fclones were allocated in
> >>
> >> remote NUMA node.
> > Interesting, how was it measured exactly ?
>
> I created a private patch to record the status for each fclone allocation=
.
>
>
> > Are you using SLUB or SLAB ?
>
> I think I use SLUB. (CONFIG_SLUB=3Dy,
> CONFIG_SLAB_MERGE_DEFAULT=3Dy,CONFIG_SLUB_CPU_PARTIAL=3Dy)
>

A similar issue comes from tx_action() calling __napi_kfree_skb() on
arbitrary skbs
including ones that were allocated on a different NUMA node.

This pollutes per-cpu caches with not optimally placed sk_buff :/

Although this should not impact fclones, __napi_kfree_skb() only ?

commit 15fad714be86eab13e7568fecaf475b2a9730d3e
Author: Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Mon Feb 8 13:15:04 2016 +0100

    net: bulk free SKBs that were delay free'ed due to IRQ context

What about :

diff --git a/net/core/dev.c b/net/core/dev.c
index c588808be77f563c429eb4a2eaee5c8062d99582..63165138c6f690e14520f11e32d=
c16f2845abad4
100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5162,11 +5162,7 @@ static __latent_entropy void
net_tx_action(struct softirq_action *h)
                                trace_kfree_skb(skb, net_tx_action,
                                                get_kfree_skb_cb(skb)->reas=
on);

-                       if (skb->fclone !=3D SKB_FCLONE_UNAVAILABLE)
-                               __kfree_skb(skb);
-                       else
-                               __napi_kfree_skb(skb,
-                                                get_kfree_skb_cb(skb)->rea=
son);
+                       __kfree_skb(skb);
                }
        }

