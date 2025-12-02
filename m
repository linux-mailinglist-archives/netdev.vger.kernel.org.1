Return-Path: <netdev+bounces-243265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 73696C9C619
	for <lists+netdev@lfdr.de>; Tue, 02 Dec 2025 18:25:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4D9E342F59
	for <lists+netdev@lfdr.de>; Tue,  2 Dec 2025 17:25:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE23B2C0298;
	Tue,  2 Dec 2025 17:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gu5J9Mt6";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="OyLrCuMV"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A8B13B5AE
	for <netdev@vger.kernel.org>; Tue,  2 Dec 2025 17:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764696318; cv=none; b=F6/Yif1QCWtgmEvq0exfNSVKwH9ubgavwY9n1L0bHAYUAT8sdvxGSO7LpTMOAElrm+QZEfFIKCthWha7tit0bdPzhRedGJl0L34B7yj7Iaoir3EV0h9ZWedFqqjKzCd39MXDUbwWRoEApoIrNvp3kCadmL0wNoGjjCRLYtePY38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764696318; c=relaxed/simple;
	bh=LeONwRlfxMDeO8d5Wj4MV1xnmUKkp8pf/NeXqhRkNi4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=INRcm0eAXfWDPG+cZ8ixTGNiypml4wk488nce25q7KtYahoX2/4+5XR+wkot3HjFU92QZlXbSNqCrRJpgTIeu7Q8nsopOXTD5Vaq1ID4626AnRTMyyBvruYUPK5F+iOFgDaBprScU/PYZqXE4hMdbH4N3Aw0DEwD7YdytTcBGao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gu5J9Mt6; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=OyLrCuMV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764696315;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JXn588c5bpxnfZakRFCUIVLOq20sEw23l8j2sXRDdAY=;
	b=gu5J9Mt6Qvs2TcLAkHM4Hgk1Cn1lMsM1Q3Vs7fHKsvXT1WnHBSLlHhEpPLcYArFlBeRuYg
	8R9ZKj33y/Pxtmnre6/WdJXLhoooQOdZToi9dub9Lna4n5MraQVbpNX5RPXg1rnR7DXbMb
	TcOpIiL/5OwRpUojo4oWobPs80PXSM0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-UtR491tZP8iufPx6sdmHYw-1; Tue, 02 Dec 2025 12:25:14 -0500
X-MC-Unique: UtR491tZP8iufPx6sdmHYw-1
X-Mimecast-MFC-AGG-ID: UtR491tZP8iufPx6sdmHYw_1764696313
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4779ecc3cc8so28468195e9.3
        for <netdev@vger.kernel.org>; Tue, 02 Dec 2025 09:25:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764696313; x=1765301113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXn588c5bpxnfZakRFCUIVLOq20sEw23l8j2sXRDdAY=;
        b=OyLrCuMVHYuXIzI+C8mByfLlyjJjWSJtWLF+gg8bcYi6fYhtvEjJ7jNqNrzv42SQYX
         r4XpN39cMZnNHcB3lKmolD+Wep9qCs1Wcr34cxfv1MYTbW00iaYM5KZkH4UJFnEP/mY6
         JKT1UbzHOwGjStikU4l3O9IT+THn+UFjhzfDOiE/1WMe6s6khAakttb5V94dqrpow0TZ
         77GGtwkkS6E1y19Qir14KgeVSknjHpLb/BxuPiEw0I3BetFbqN5hzydgmHyo8Ik+2Co/
         KxRUhPFIfrwwPkDIchNuXECVCHrgcdxvyY/MfdXCB19kW3rHMAVQfb1FTM8E9POGIJKf
         kd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764696313; x=1765301113;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JXn588c5bpxnfZakRFCUIVLOq20sEw23l8j2sXRDdAY=;
        b=pUDR10+7FC12Su1fzH4fy06FNy0mL4YaiFDYtWpQYhsIavx0ZKl7uRcfhjxpth3N2l
         xQ44jkekY9H6R40rbfcyeBwtZ8HCwq1t7+Y69QIr/7HxO4ZgUkvn/ysUc/FoNvRNKgfg
         mq8TnXhBSMQd6etEGgZfQPQ9alccnb849eLrRFKnuWhRI9JkrcRBVVAKa/pTeQZQR8J3
         MkxxFGfNT6VZ+G4uenoRKxnXXvQlruEXSF78kZo8nQhdV0GqLNqx2NeFQpf/oSa5yR8s
         c2wsaZYLRq8GKJB6A6iLEqL0aWo/SeuYxLlzLNe+dI1KhWqQAiQgmOqEEGHT6ofxUWYK
         fHrA==
X-Forwarded-Encrypted: i=1; AJvYcCWVp8z45j7pl5JLxgiEzs96DtQK/gMNSqMkn/a1RzI0gAQ6UHZFAgUIXGA1o7g3OmeSAVEewDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOc2KaLUeBAZ1GzOKRLgxEVP5BysuCV7Cfs8skfN/2aCoJjWgS
	DWDMefK0YsoCbqH5D0s1TSeenG0Q/ssCugOP2H77ms8VVbYDo2KWBiz2S04GLt97rB774BK9KlY
	INXls7vjOoIxQllW6p+WUr0XWyYVzoQbyJ/5px9tgYDxu7lNUAh/nYHzH4w==
X-Gm-Gg: ASbGncsV5cRDFDvvoqiZiVVR0jr2NstCo8LJc/6JdhyRNEqBlGsQuHfnL6SjKRS4A92
	L1l63c1v5PQ5Ap8kTYL0dXT2zusnrfnxsYBx1iDfJcyVO2tbWWRjxtz4jIujTjlku23If4ZYNda
	q8JB6mus7NWG6HH/Gg1+ioMCtWuGjswD44n3DXIsACFvLpxMHSm7zUVtPS5Eo9BGjM45Ay1qXDw
	nF64HI7Zo/82Nag9ThGi4J5dEODbGL807tH9R5GOx+qWntbQ//J/aPKe2WGElDvngUSrIVNY1kq
	31yHJdbMsNXXl6gvPtdC6H7mDhMxsOMFT0YHLDKUWrw7OBiBR58jIGX5tTHHjCxvt1eE7w5ToOx
	4ng7TXL0Ku2sgUtC36dj6hyx9F4i9Z5cCt8Aqy/WeCJZ6
X-Received: by 2002:a05:600c:354c:b0:477:a977:b8c2 with SMTP id 5b1f17b1804b1-47904ae7322mr337865335e9.13.1764696312977;
        Tue, 02 Dec 2025 09:25:12 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHkh7ByPGi7xhjZeo3ThVJhYzI6q7/SqPXCw2US6sv2+pHfl14d+WxyoSFo1QrK95vL602NGQ==
X-Received: by 2002:a05:600c:354c:b0:477:a977:b8c2 with SMTP id 5b1f17b1804b1-47904ae7322mr337865065e9.13.1764696312393;
        Tue, 02 Dec 2025 09:25:12 -0800 (PST)
Received: from localhost (net-5-89-201-160.cust.vodafonedsl.it. [5.89.201.160])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42e1ca1a3e4sm34348533f8f.25.2025.12.02.09.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:25:11 -0800 (PST)
From: Paolo Valerio <pvalerio@redhat.com>
To: =?utf-8?Q?Th=C3=A9o?= Lebrun <theo.lebrun@bootlin.com>,
 netdev@vger.kernel.org
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>, Claudiu Beznea
 <claudiu.beznea@tuxon.dev>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>
Subject: Re: [PATCH RFC net-next 0/6] net: macb: Add XDP support and page
 pool integration
In-Reply-To: <DEITSIO441QL.X81MVLL3EIV4@bootlin.com>
References: <20251119135330.551835-1-pvalerio@redhat.com>
 <DEITSIO441QL.X81MVLL3EIV4@bootlin.com>
Date: Tue, 02 Dec 2025 18:24:50 +0100
Message-ID: <87fr9szti5.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hello Th=C3=A9o,

thank you for the feedback

On 26 Nov 2025 at 07:08:14 PM, Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> w=
rote:

> Hello Paolo,
>
> So this is an initial review, I'll start here with five series-wide
> topics and send small per-line comments (ie nitpicks) in a second stage.
>
>
>
> ### Rx buffer size computation
>
> The buffer size computation should be reworked. At the end of the series
> it looks like:
>
> static int macb_open(struct net_device *dev)
> {
>     size_t bufsz =3D dev->mtu + ETH_HLEN + ETH_FCS_LEN + NET_IP_ALIGN;
>
>     // ...
>
>     macb_init_rx_buffer_size(bp, bufsz);
>
>     // ...
> }
>
> static void macb_init_rx_buffer_size(struct macb *bp, size_t size)
> {
>     if (!macb_is_gem(bp)) {
>         bp->rx_buffer_size =3D MACB_RX_BUFFER_SIZE;
>     } else {
>         bp->rx_buffer_size =3D size
>             + SKB_DATA_ALIGN(sizeof(struct skb_shared_info))
>             + MACB_PP_HEADROOM;
>
>         if (bp->rx_buffer_size > PAGE_SIZE)
>             bp->rx_buffer_size =3D PAGE_SIZE;
>
>         if (bp->rx_buffer_size % RX_BUFFER_MULTIPLE)
>             bp->rx_buffer_size =3D roundup(bp->rx_buffer_size, RX_BUFFER_=
MULTIPLE);
>     }
> }
>
> Most of the issues with this code is not stemming from your series, but
> this big rework is the right moment to fix it all.
>
>  - NET_IP_ALIGN is accounted for in the headroom even though it isn't
>    present if !RSC.
>

that's something I noticed and I was a unsure about the reason.

>  - When skbuff.c/h allocates an SKB buffer, it SKB_DATA_ALIGN()s
>    headroom+data. We should probably do the same. In our case it would
>    be:
>
>    bp->rx_buffer_size =3D SKB_DATA_ALIGN(MACB_PP_HEADROOM + size) +
>                         SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
>    // or
>    bp->rx_buffer_size =3D SKB_HEAD_ALIGN(MACB_PP_HEADROOM + size);
>
>    I've not computed if it can ever give a different value to your
>    series in terms of total size or shinfo alignment. I'd guess it is
>    unlikely.
>

I'll take a look at this

>  - If the size clamping to PAGE_SIZE comes into play, we are probably
>    doomed. It means we cannot deal with the MTU and we'll probably get
>    corruption. If we do put a check in place, it should loudly fail
>    rather than silently clamp.
>

That should not happen, unless I'm missing something.
E.g., 9000B mtu on a 4K PAGE_SIZE kernel should be handled with multiple
descriptors. The clamping is there because according with how the series
creates the pool, the maximum buffer size is page order 0.

Hardware-wise bp->rx_buffer_size should also be taken into account for
the receive buffer size.

> TLDR: I think macb_init_rx_buffer_size() should encapsulate the whole
> rx buffer size computation. It can use bp->rx_offset and add on top
> MTU & co. It might start failing if >PAGE_SIZE (?).
>

ack, I'll move that part

>
>
> ### Buffer variable names
>
> Related: so many variables, fields or constants have ambiguous names,
> can we do something about it?
>
>  - bp->rx_offset is named oddly to my ears. Offset to what?
>    Maybe bp->rx_head or bp->rx_headroom?
>

bp->rx_headroom sounds a good choice to me, but if you have a stronger
preference for bp->rx_head just let me know.

>  - bp->rx_buffer_size: it used to be approximately the payload size
>    (plus NET_IP_ALIGN). Now it contains the XDP headroom and shinfo.
>    That's on GEM, because on MACB it means something different.
>
>    This line is a bit ironic and illustrates the trouble:
>       buffer_size =3D SKB_WITH_OVERHEAD(bp->rx_buffer_size) - bp->rx_offs=
et
>
>  - data in gem_rx|gem_rx_refill|gem_free_rx_buffers() points to what we
>    could call skb->head, ie start of buffer & start of XDP headroom.
>    Its name implied skb->data to me, ie after the headroom.
>
>    It also made `data - page_address(page) + bp->rx_offset` hard to
>    understand. It is easier for me to understand that the following is
>    the page fragment offset till skb->data:
>
>       buff_head + bp->rx_headroom - page_address(page)
>

ack, will change this

>  - MACB_MAX_PAD is ambiguous. It rhymes with NET_SKB_PAD which is the
>    default SKB headroom but here it contains part of the headroom
>    (XDP_PACKET_HEADROOM but not NET_IP_ALIGN) and the tailroom (shinfo).
>

uhm, looking at this, I think NET_IP_ALIGN should be part of it (for the
!rsc case).
I'll revisit this part, though.

>  - Field `data` in `struct macb_tx_buff` points to skb/xdp_frame but my
>    initial thought was skb->data pointer (ie after headroom).
>    What about va or ptr or buff or frame or ...?
>

I see. At some point I considered buff, but then I realized
tx_buff->buff was not perfect, hence data :)

I guess one between frame or va works, thanks.

> TLDR: I had a hard time understanding size/offset expressions (both from
> existing code and the series) because of variable names.
>

ack. Will revisit this aspect based on your suggestions.

>
>
> ### Duplicated buffer size computations
>
> Last point related to buffer size computation:
>
>  - it is duplicated in macb_set_mtu() but forgets NET_IP_ALIGN & proper
>    SKB_DATA_ALIGN() and,
>
>  - it is duplicated in gem_xdp_setup() but I don't see why because the
>    buffer size is computed to work fine with/without XDP enabled. Also
>    this check means we cannot load an XDP program before macb_open()
>    because bp->rx_buffer_size =3D=3D 0.
>
> TLDR: Let's deduplicate size computations to minimise chances of getting
> it wrong.
>

ack

>
>
> ### Allocation changes
>
> I am not convinced by patches 1/6 and 2/6 that change the alloc strategy
> in two steps, from netdev_alloc_skb() to page_pool_alloc_pages() to
> page_pool_alloc_frag().
>
>  - The transient solution isn't acceptable when PAGE_SIZE is large.
>    We have 16K and would never want one buffer per page.
>
>  - It forces you to introduce temporary code & constants which is added
>    noise IMO. MACB_PP_MAX_BUF_SIZE() is odd as is the alignment of
>    buffer sizes to page sizes. It forces you to deal with
>    `bp->rx_buffer_size > PAGE_SIZE` which we could ignore. Right?
>
> TLDR: do alloc changes in one step.
>

yes, makes sense I'll squash them.

>
>
> ### XDP_SETUP_PROG if netif_running()
>
> I'd like to start a discussion on the expected behavior on XDP program
> change if netif_running(). Summarised:
>
> static int gem_xdp_setup(struct net_device *dev, struct bpf_prog *prog,
>              struct netlink_ext_ack *extack)
> {
>     bool running =3D netif_running(dev);
>     bool need_update =3D !!bp->prog !=3D !!prog;
>
>     if (running && need_update)
>         macb_close(dev);
>     old_prog =3D rcu_replace_pointer(bp->prog, prog, lockdep_rtnl_is_held=
());
>     if (running && need_update)
>         return macb_open(dev);
> }
>
> Have you experimented with that? I don't see anything graceful in our
> close operation, it looks like we'll get corruption or dropped packets
> or both. We shouldn't impose that on the user who just wanted to swap
> the program.
>
> I cannot find any good reason that implies we wouldn't be able to swap
> our XDP program on the fly. If we think it is unsafe, I'd vote for
> starting with a -EBUSY return code and iterating on that.
>

I didn't experiment much with this, other than simply adding and
removing programs as needed during my tests. Didn't experience
particular issues.

The reason a close/open sequence was added here was mostly because I was
considering to account XDP_PACKET_HEADROOM only when a program was
present. I later decided to not proceed with that (mostly to avoid
changing too many things at once).

Given the geometry of the buffer remains untouched in either case, I
see no particular reasons we can't swap on the fly as you suggest.

I'll try this and change it, thanks!

> TLDR: macb_close() on XDP program change is probably a bad idea.
>
> Thanks,
>
> --
> Th=C3=A9o Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com


