Return-Path: <netdev+bounces-239002-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 22A26C61FAF
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 02:08:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC7674E1CB3
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 01:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19261ACEAF;
	Mon, 17 Nov 2025 01:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/fdBoFE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D4F1D6187
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 01:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763341693; cv=none; b=PZ1KwOskOSgOVskodkaQJWn9HWVRk8DuC8fKnpKh/EiJKO4lPac3yt23+F/rNOHyI6/Omd9eT9awjY9nsOLbOl7x2T/GSOxVjrFB3BvwqBtAEzSwiVIVqFmacKO0cPrU2GpxJ0Jen3OdYEEvZau7yC2n2EYfuQlkgaGq5Bbqx6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763341693; c=relaxed/simple;
	bh=35Bwzd72DJ0Uyq/UZl/Z9UgcGJGdMaNMqbePQIC89hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o6J8lGWwG0TZdQuiJ87ypVa6mqk7IjyUebdFQYbLzV7aL/vlV6JmJkRGX8VrVAul8lQdvdiS+0NZg6qxvDci4+htomPGO/6d4fOSiw9Z5nk8NZIrcdgCRfssQifG+sZu8bO7c2dEn/YOR205099nMO1AdN3v9ob0pyXlD3e5pIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/fdBoFE; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-4330d2ea04eso14777395ab.3
        for <netdev@vger.kernel.org>; Sun, 16 Nov 2025 17:08:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763341691; x=1763946491; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VAAjo5LfoQ5aAysgjl9aXplO012k8eEsTDB8RoVLpSY=;
        b=R/fdBoFE5/y9gMy3ngk6t0o3HWqusNAxOjAvNsFpimjU8DgMVXcV4GAtAym5ggcXSv
         B3WMg/Lh3cv+F7NZdvnIuWp2O612mzNrMLXJqyv2E5lf6CkJ8Aieyi3um2wlKvFCsZkM
         Z8n+Q+GT4CIRq6X+/A1U2pnYJKO3F/+GPpSQ/C6Mm6f1tPCoX7XRhniLAf28fRp0n/yB
         pQTAu/UZ5d1w5h9OUz5tNAP1Vapc0ImwjLTWgG3iupZgvlhJ4JkwCVLUbVrNQUlWiowr
         JmL5YyOi+sHiZybH6mDQPI0bIhGq6cq+rmsbzFpSG2LScB5CvAKZXWixkxuqKeFhrOQo
         KQXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763341691; x=1763946491;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VAAjo5LfoQ5aAysgjl9aXplO012k8eEsTDB8RoVLpSY=;
        b=lZpZJSfaJwYxijQRodBoNRaKDM7IwPtIf04MxDudfhqYt/jTnkS7pkTju2Hlxhz/IP
         /yjW7cfIIf6rDqY9R6MFsEW/2CiFK7U5j+KtZsnN953R4FPxHavrAunkssUPsYeBGDVo
         d1umFWQCfnA4hFgSIK9BkyeW4mPMetHD0Goqtq12+l19s2TBGAtv2v8D90m+UVL5vyvo
         lZC0t7uJRDqM2oN1VeLygcyM1xYRoS9Zdod4txEKj9nl3HDtJdCzRLiN6kKzYESBD8KK
         uP1YKuATqs3REuIu9tUFbNLoEDQ6NteION991YYLaPTgAt7LYbHF3oPrIrVynGPiXHdj
         DiTw==
X-Forwarded-Encrypted: i=1; AJvYcCUW0x70G5IADKQTlnLcJ97xnjNq069vgTSJx1q3gwBsqlUzdE1eUXKsGf+th6PG28FWFTQjvyE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCMD0nZyZBinZD8yc2334SAfuixQpgxUpNNCjUn/HAJi5mhX1m
	AFVbo7tixSUg7myQ7a9SbuXkzvxGIWwo5eESVOiHIsABglLQtAu5Ri+/g/EV5rSVXGnzM0z/shG
	Zjp6jT6+L5B4KJ+Lx9uNqCarUsTIGyn0=
X-Gm-Gg: ASbGncs+Ss/2pFz0one2Oen4OrxagIcXKb+MiKnmc+da0/mCynh4J0bpIpF0MsLmfVc
	fZk+uxTsy7a/rk0pmWAt0gOZXFWsq1lLT6h2BYe8e//nxSE8bsuLmV8/485UD0Do/z3SxBj/JHw
	4r4OcpSa1/gH5rAdbauoHX2Gaz/CXQivTRLWB4Nnm17+H/P/mUoMKNlSbkHM4lLBdbFlJOqbT1S
	7fSq+DJKflMLctrUvQOwNaBow/BI1w2Z5/UZZSD6Tvv8RU88JBTZq4STosylie84PaqMw==
X-Google-Smtp-Source: AGHT+IGFSYie/gYqD/UoPEs9DSBCkNYq17gCdKPdUEVDgnhfMViql2HgfDtaQFtNC43RwA9Ti+oTAoDy1XCZ56kRnM4=
X-Received: by 2002:a92:730a:0:b0:434:96ea:ff5f with SMTP id
 e9e14a558f8ab-43496eb0125mr83024725ab.40.1763341691063; Sun, 16 Nov 2025
 17:08:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251116202717.1542829-1-edumazet@google.com> <20251116202717.1542829-4-edumazet@google.com>
In-Reply-To: <20251116202717.1542829-4-edumazet@google.com>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Mon, 17 Nov 2025 09:07:34 +0800
X-Gm-Features: AWmQ_bnuocvIO63u3qqpNWgg01wKZsJZWS6jeRAj8QcbYM9vPWZ9Ypu4dYMcvCY
Message-ID: <CAL+tcoD3-qtq4Kcmo9eb4mw6bdSYCCjxzNB3qov5LDYoe_gtkw@mail.gmail.com>
Subject: Re: [PATCH v3 net-next 3/3] net: use napi_skb_cache even in process context
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 17, 2025 at 4:27=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> This is a followup of commit e20dfbad8aab ("net: fix napi_consume_skb()
> with alien skbs").
>
> Now the per-cpu napi_skb_cache is populated from TX completion path,
> we can make use of this cache, especially for cpus not used
> from a driver NAPI poll (primary user of napi_cache).
>
> We can use the napi_skb_cache only if current context is not from hard ir=
q.
>
> With this patch, I consistently reach 130 Mpps on my UDP tx stress test
> and reduce SLUB spinlock contention to smaller values.
>
> Note there is still some SLUB contention for skb->head allocations.
>
> I had to tune /sys/kernel/slab/skbuff_small_head/cpu_partial
> and /sys/kernel/slab/skbuff_small_head/min_partial depending
> on the platform taxonomy.
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>

Thanks for working on this. Previously I was thinking about this as
well since it affects the hot path for xsk (please see
__xsk_generic_xmit()->xsk_build_skb()->sock_alloc_send_pskb()). But I
wasn't aware of the benefits between disabling irq and allocating
memory. AFAIK, I once removed an enabling/disabling irq pair and saw a
minor improvement as this commit[1] says. Would you share your
invaluable experience with us in this case?

In the meantime, I will do more rounds of experiments to see how they perfo=
rm.

[1]
commit 30ed05adca4a05c50594384cff18910858dd1d35
Author: Jason Xing <kernelxing@tencent.com>
Date:   Thu Oct 30 08:06:46 2025 +0800

    xsk: use a smaller new lock for shared pool case

    - Split cq_lock into two smaller locks: cq_prod_lock and
      cq_cached_prod_lock
    - Avoid disabling/enabling interrupts in the hot xmit path

Thanks,
Jason

