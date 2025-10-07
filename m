Return-Path: <netdev+bounces-228112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E41BC1933
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 15:53:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 195FD34EC85
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 13:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C48D2E1754;
	Tue,  7 Oct 2025 13:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LClbO9ax"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D7822E1744
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 13:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759845186; cv=none; b=Rd4trlW7JZn5L2kPoTHgkd2120A5+2P7o6ed2euzyjJVS3yZcC1yjLGU8uljeZcNG+b9o0VqDTf2Y0Ze4hTGxFkg/+d6/nkg4Vi89+cyVQSPYwH6MLyb5pfhjiK6uU251O933nQTTGvPTF5R6GufENPa/NcL/uUz62xYGwCUgyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759845186; c=relaxed/simple;
	bh=CpAltLDm5v7eOuRzSStHXfNacG5kcKzy7spbF+NeVxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzxAusbnLh4SofQSR/nggF/Qtp+vFhhvAyWVVcecaaONHWFsy6FDFaz5CbZfvrX2dlcCIxYs2MH89fYqpVYohfqcCHqYXCDAf/fe+VHBEd9fMtRRH6R9qPZJkfY5nVBJoZp5Um2PlgDNWPPtEOmIQtwILsGVp43iNe1R7uodELg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LClbO9ax; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78defc1a2afso93269526d6.2
        for <netdev@vger.kernel.org>; Tue, 07 Oct 2025 06:53:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759845183; x=1760449983; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=q05Yl9Va/2kiKzGDt2DuRF3fP+dFqWnkPT+rCtcMPYw=;
        b=LClbO9axKhZpzncl7zCKmlV2lkHTQr4eO8rBKKdI9gM5t5cxZYTWW4NoAZ/c3x4OUo
         OwckCaPYoipCSNBKtxtMHwJzzW91v7vTccDH5LdqPk6NguUoB9W+MX7wslLnV2EO2ClG
         hOk61vXm88AsGBvTJNb8485XHl60kRc28IafkT9ebbx0fcWq7fqgSRmLs1WK3w+a3Il0
         T3ti28g5awDlDohe8tdWUaS8Q2JVZE9xH4pRC/z7VxYUXmsvkGiDd5ZvBFLd/IgZ5AOS
         bOX1c5LCGSSgCAshzlvHaNhAhsZZTwXWgEMehmxU8a91RIYuzdVZweavnFuVNd0Agq41
         5ezg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759845183; x=1760449983;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q05Yl9Va/2kiKzGDt2DuRF3fP+dFqWnkPT+rCtcMPYw=;
        b=GSeDqnFpFWWGu6ig4ZE4TFv62bohrWAwXXWRtjFcHmB2ozUM1NUzgOLMjenpQuCJvD
         GK69KOJfo/047wSGTHHO+dPu4W7REA/GOoL/3iKHGXdLgPszMcd2hQCwcnoAT7baqJMf
         JKrLJAm3df0EA8mk25b3pgi4kOS2i2jVFklDiLmSs4QfLI9J3a0qycyx7Tw+ZW3R+Mhe
         N5lx8Ad7MqbOIARaRFEo3c9PHhjSyQ2Y6JeQ1Q5cmfKpc4mBb7lJ00tK2plXU5vi4FBL
         hKifYCmgzjW+UXcA+nt3f7MbC4RF/XJ1R1eT9JdXqPHr9r6cp6ue2UXnvvzOw25s4I5u
         ESXw==
X-Forwarded-Encrypted: i=1; AJvYcCVEqJY1F9V87tcJ6K+LU+BbG3YcMQqbvJmPaIS7now24S73khi0YXFzvSmpHn4UY9x2G8vEshE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6WQnd3l/p77GVuPnbRIVE7HdYlCRR3FDiP79oIli37dVv5hpK
	g0pO2fTgdhJZemv/lLWROYgcByGLiBi1pkuIJAvhivjnlTBuxRiVC4Y4yvyXU9kAdTUXAb2Y3Wg
	9McCD548ipe0OYvTJkjxs1Vewa2nUz7s=
X-Gm-Gg: ASbGncsuNLrIPS84nvAG7k3+VqVTvRn5izYasf0i08F8NIaq3GVDzazLAGQXTcsKcCA
	LGgS8Ha2wGh607OJyY7stIzhU6eqPyIIADz5j5GoVShm9uulpU8Nqhzgir0EakZdwiC41+vz2oi
	uXCTaDHGayqxGvr4w1cckdTddBLlK+QbK2vr0iTwfYR7l6HT+5q71L8mksTQs8ZjfVfWfL4BVoq
	ky8rCBVbZuJZuYGvDbX9Fm20S9MPWc=
X-Google-Smtp-Source: AGHT+IHMp136PPm5waiIVotufcSKKJc691e3mLYLnH3GNuVmP6PGBXfFwXXNv7elnDDbhkIW8pLcXB8Uk4uHog+EwMY=
X-Received: by 2002:a05:6214:f6d:b0:792:61c0:beb0 with SMTP id
 6a1803df08f44-879dc87f7c2mr225412096d6.67.1759845183075; Tue, 07 Oct 2025
 06:53:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251006085316.470279-1-Ilia.Gavrilov@infotecs.ru>
 <c5a1c806-2c4c-47c5-b83a-cb83f93369b4@intel.com> <06da20bf-79f6-4ad7-92cc-75f19685b530@infotecs.ru>
 <fa7b9dc7-037f-42f7-87e5-19b3d8a3d2c3@intel.com> <CAJ8uoz1wf6cfRN16pdMZuoWMxVLWfywVymB7NffDpp82vp5dLA@mail.gmail.com>
 <914ddb6c-79ca-49c2-82b1-33be1986eff5@infotecs.ru>
In-Reply-To: <914ddb6c-79ca-49c2-82b1-33be1986eff5@infotecs.ru>
From: Magnus Karlsson <magnus.karlsson@gmail.com>
Date: Tue, 7 Oct 2025 15:52:52 +0200
X-Gm-Features: AS18NWADnzTnI4k242FsY93pjgsfgNOpxkgKkS8SG_jQJSB8WfgBAwzzGsf8A2E
Message-ID: <CAJ8uoz3CeFdAuOd6mjnMBDW45KcY-CQoOUxZt7PB_xAONVYD4w@mail.gmail.com>
Subject: Re: [lvc-project] [PATCH net] xsk: Fix overflow in descriptor validation@@
To: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
	Song Yoong Siang <yoong.siang.song@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Eric Dumazet <edumazet@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Simon Horman <horms@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Magnus Karlsson <magnus.karlsson@intel.com>, 
	"lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 7 Oct 2025 at 15:34, Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru> wrote:
>
> On 10/7/25 15:44, Magnus Karlsson wrote:
> > On Tue, 7 Oct 2025 at 14:11, Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
> >> Date: Tue, 7 Oct 2025 11:19:19 +0000
> >>
> >>> On 10/6/25 18:19, Alexander Lobakin wrote:
> >>>> From: Ilia Gavrilov <Ilia.Gavrilov@infotecs.ru>
> >>>> Date: Mon, 6 Oct 2025 08:53:17 +0000
> >>>>
> >>>>> The desc->len value can be set up to U32_MAX. If umem tx_metadata_len
> >>>>
> >>>> In theory. Never in practice.
> >>>>
> >>>
> >>> Hi Alexander,
> >>> Thank you for the review.
> >>>
> >>> It seems to me that this problem should be considered not from the point of view of practical use,
> >>> but from the point of view of security. An attacker can set any length of the packet in the descriptor
> >>> from the user space and descriptor validation will pass.
> >>>
> >>>
> >>>>> option is also set, then the value of the expression
> >>>>> 'desc->len + pool->tx_metadata_len' can overflow and validation
> >>>>> of the incorrect descriptor will be successfully passed.
> >>>>> This can lead to a subsequent chain of arithmetic overflows
> >>>>> in the xsk_build_skb() function and incorrect sk_buff allocation.
> >>>>>
> >>>>> Found by InfoTeCS on behalf of Linux Verification Center
> >>>>> (linuxtesting.org) with SVACE.
> >>>>
> >>>> I think the general rule for sending fixes is that a fix must fix a real
> >>>> bug which can be reproduced in real life scenarios.
> >>>
> >>> I agree with that, so I make a test program (PoC). Something like that:
> >>>
> >>>       struct xdp_umem_reg umem_reg;
> >>>       umem_reg.addr = (__u64)(void *)umem;
> >>>       ...
> >>>       umem_reg.chunk_size = 4096;
> >>>       umem_reg.tx_metadata_len = 16;
> >>>       umem_reg.flags = XDP_UMEM_TX_METADATA_LEN;
> >>>       setsockopt(sfd, SOL_XDP, XDP_UMEM_REG, &umem_reg, sizeof(umem_reg));
> >>>       ...
> >>>
> >>>       xsk_ring_prod__reserve(tq, batch_size, &idx);
> >>>
> >>>       for (i = 0; i < nr_packets; ++i) {
> >>>               struct xdp_desc *tx_desc = xsk_ring_prod__tx_desc(tq, idx + i);
> >>>               tx_desc->addr = packets[i].addr;
> >>>               tx_desc->addr += umem->tx_metadata_len;
> >>>               tx_desc->options = XDP_TX_METADATA;
> >>>               tx_desc->len = UINT32_MAX;
> >>>       }
> >>>
> >>>       xsk_ring_prod__submit(tq, nr_packets);
> >>>       ...
> >>>       sendto(sfd, NULL, 0, MSG_DONTWAIT, NULL, 0);
> >>>
> >>> Since the check of an invalid descriptor has passed, kernel try to allocate
> >>> a skb with size of 'hr + len + tr' in the sock_alloc_send_pskb() function
> >>> and this is where the next overflow occurs.
> >>> skb allocates with a size of 63. Next the skb_put() is called, which adds U32_MAX to skb->tail and skb->end.
> >>> Next the skb_store_bits() tries to copy -1 bytes, but fails.
> >>>
> >>>  __xsk_generic_xmit
> >>>       xsk_build_skb
> >>>               len = desc->len; // from descriptor
> >>>               sock_alloc_send_skb(..., hr + len + tr, ...) // the next overflow
> >>>                       sock_alloc_send_pskb
> >>>                               alloc_skb_with_frags
> >>>               skb_put(skb, len)  // len casts to int
> >>>               skb_store_bits(skb, 0, buffer, len)
> >>
> >> Oh, so you actually have a repro for this. This is good. I suggest you
> >> resubmitting the patch and include this repro in the commit message, so
> >> that it will be clear that it's actually possible to trigger the problem
> >> in the kernel using a malicious/broken userspace application.
> >>
>
> I'll add the repro from this e-mail in the next patch version,
> the full source is too long.
>
> >> (also pls remove those double `@@` from the subject next time)
> >>
>
> ok
>
> >> I'd also like to hear from Maciej and/or others what they think about
> >> this problem (that the userspace can set packet len to U32_MAX). Should
> >> we just go with this proposed u64 propagation or maybe we need to limit
> >> the maximum length which could be sent from the userspace?
> >
> > I prefer that we do not set a limit on it and go with the proposed
> > solution since I do not know what a future proof size limit would be.
> > Somebody could come up with a new virtual device that can send really
> > large packets, who knows.
> >
>
> The limit is already checked in the xp_aligned_validate_desc() function:

What I meant was, let us not introduce a new limit. I like your
proposed solution.

> static inline bool xp_aligned_validate_desc(struct xsk_buff_pool *pool,
>                                             struct xdp_desc *desc)
> {
>
> ...
>         if (offset + len > pool->chunk_size)
>                 return false;
> ...
> }
>
> and pool->chunk_size can't be more than PAGE_SIZE:
>
> static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
> {
>         u32 chunk_size = mr->chunk_size, headroom = mr->headroom;
>         ...
>
>         if (chunk_size < XDP_UMEM_MIN_CHUNK_SIZE || chunk_size > PAGE_SIZE) {
>                 /* Strictly speaking we could support this, if:
>                  * - huge pages, or*
>                  * - using an IOMMU, or
>                  * - making sure the memory area is consecutive
>                  * but for now, we simply say "computer says no".
>                  */
>
>                 return -EINVAL;
>         }
>         ...
> }
>
> The problem is exactly the overflow.
>
> >> In any case, you raised a good topic.
> >>
> >>>
> >>>> Static Analysis Tools have no idea that nobody sends 4 Gb sized network
> >>>> packets.
> >>>>
> >>>
> >>> That's right. Static analyzer is only a tool, but in this case, the overflow
> >>> highlighted by the static analyzer can be used for malicious purposes.
> >>
> >> +1
> >>
> >> Also I really do hope Infotecs stayed independent from the govs and
> >> doesn't take part in any dual-purpose/gov-related projects.
> >>
> >> Thanks,
> >> Olek
> >>
>

