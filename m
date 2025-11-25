Return-Path: <netdev+bounces-241351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A2DE9C8307C
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 02:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 868664E2EF1
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 01:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7757B26FDAC;
	Tue, 25 Nov 2025 01:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZN3FzWFu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U5N3bUgO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F021F4615
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 01:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764034507; cv=none; b=iZR0WJ3aCuQdadK3A62AATY+1wekNvXTF0N2pM6+zZpVmgCY3T+pApBlP+XRRbxor9pjOVHEput84hCz2g4nUkCGgU/O5AQShcOv67g4Ael/JsXPHAA7IzdCwDLXHHJU15M+oYYWJgnVPkFFhUGj8kBU5SsyjXhczN2gQmxGfHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764034507; c=relaxed/simple;
	bh=ckot/qGzEsr3y/bUI/Jn66JGbROGHjRMWN0c36mSTIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Cn/oRCi8zIdrW5RN4qAwtoGGlDB+kjOzpvM/ndQDUyBEZil1Dg0uL+ddv7p+3fAeWaOQVA0aAUqIfNysUxDu4ZKff4Ou3wyDYmQspmSd7DQahmVWwDQfIvCd6p/wlNU7O5+dAXPjjM1wfaef2dlQC6MTidgDkE95PV5TmkJoHIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZN3FzWFu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U5N3bUgO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764034504;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9kEJDvqjrIdXsU1IPiVaYED9aR2EYcU0zBZ2650wkuI=;
	b=ZN3FzWFuuss4upTwa7EOWZa2xzhFIBGMCe+y8uzghxCRk+UNSP9NTmpdtB1BWFotIMANmQ
	GL+hmAkfQLmKIZe6YUkwqK+3x9UfGV2WGLzmDeGW5d0d6Q/jRT085yfqSoV7QWo9NdPYSX
	VxLUgjOGeUx6gcAotZR2MT8KcmHb44o=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-RVS7Sxr-O6ikp7FyYg4AMQ-1; Mon, 24 Nov 2025 20:35:02 -0500
X-MC-Unique: RVS7Sxr-O6ikp7FyYg4AMQ-1
X-Mimecast-MFC-AGG-ID: RVS7Sxr-O6ikp7FyYg4AMQ_1764034502
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-93720f67f1cso2713872241.0
        for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 17:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764034502; x=1764639302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9kEJDvqjrIdXsU1IPiVaYED9aR2EYcU0zBZ2650wkuI=;
        b=U5N3bUgOlPYriTEJV5kLypc5R7bY3NNUrIwSxKXXjAHjmOIKTjGb1+CpXfN14mo+b8
         PeHjQJx30HqgVMbsKPaD3HcHBkgTC4CzhypudW72fGg9Bhpy0LjoNXC2wQoP4QtWgRnT
         73eZz/DyR1skmEvy4e3RMXfDIIHNpKN08egofjs6aghOVPhm6CQaNB5+PIoSx4uE1Wxi
         Q2c40rcNFmWvEBSi+FDS5ZLgLfZiPWeHww1nP8CT3Baf0w2O1sGlSpDDFjrGnXJR2dSy
         0jeleA9Sdhk+Wl0r4UHzJz0Q0/7wQDlUQ34smCl7lK2DW2f4hlYjKTlMGRlD7Qw8xsHQ
         emzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764034502; x=1764639302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9kEJDvqjrIdXsU1IPiVaYED9aR2EYcU0zBZ2650wkuI=;
        b=kEBXw1ksIpkUUjBrticX0+dPAlMfYKXYELbsI8iKQp4cwUhK1nZboKcBtNPA7Dvmc5
         t61urgpHSwgPoU2KnYeOhbbWYe/tGGXgnzFw2Hq+2fbCRK63LulVhTjBwiVJyqoLOTD3
         cwWYOdDqxdHISRvGOzsdDE1+qoT9OCSDBSWZsV57ZGZ2b1WLYSvUvkP+8A9MCsb48DVW
         LP8K6qOwilorJczuvV/0pNSUSJyYCQmEEx8+WvKcAZpbhSkXiVwHt8fVPWSu45Ma1S2q
         bUVDxz15DPEwt1n5I7MUI3xuBCpg9+fkrEMsFlxMi0rAPUOaN/8/UkA9kH6EyUmHDt9+
         hY3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWmSV45heR42T34OR3mR5lQjQfkRLJfAfmz8OuAlzNPkp/wO8i6n3/xuuYrpO/KYC0xt8s9tgE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy/Qek7qkh2xPxUM6oqAtn7w1Dxad7XlQ8QhW1H1LSGtkqsqycJ
	NBuM+yMbQ7bzafjgmTeIgGpJ1WqeG1bmM/Vgy1zrKQRQBtQ8WmEJ+N1GrW8cpJHK5NkO+kk41Tp
	pbkZ1Y+bt6n08wQcfPA5k4473dzmzuN9y2k0scpZioKgBVWNtnrRq87B5taIBYh0UJcOZnEBWmG
	AO17rsHj4hDO77vKqOFcbWd64rgLJjBy8Z
X-Gm-Gg: ASbGncsLxEsJikpqc2pZKImO0ezpIIJDT8H8CC0qUd6skaXbEbNQrNcGzBVfex2hBxT
	MN7ZFwPDg+k81zncpmqM1lyx40v5hVpHaV6SkVY6/SgIkoxR2+/DbyO6EU6DPVuJ5aDqP2HF/Z0
	fSActwKO595wxUuXpFioMjuSb/OOuy1VupBtfA0Yf79xhYobyoYD8oHM3jfZk633WqY+M=
X-Received: by 2002:a05:6102:2906:b0:5df:c15b:4feb with SMTP id ada2fe7eead31-5e1de3443camr4044491137.26.1764034502080;
        Mon, 24 Nov 2025 17:35:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG9YM4D6RF10K5EcFy4iLXgvqD+APcqwC0xD89qRbqzgoKauqLYJ6rVCEmpB17XvI/3ApsYGDHQiC298XyfAew=
X-Received: by 2002:a05:6102:2906:b0:5df:c15b:4feb with SMTP id
 ada2fe7eead31-5e1de3443camr4044480137.26.1764034501590; Mon, 24 Nov 2025
 17:35:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <CACGkMEuboys8sCJFUTGxHUeouPFnVqVLGQBefvmxYDe4ooLfLg@mail.gmail.com>
 <b9fff8e1-fb96-4b1f-9767-9d89adf31060@tu-dortmund.de> <CACGkMEufNLjXj37NBVCW4xdSuVLLV4ZS4WTuRzdaBV-nYgKs8w@mail.gmail.com>
 <ebb431f9-fdd3-4db3-bfd5-70af703ef9b5@tu-dortmund.de>
In-Reply-To: <ebb431f9-fdd3-4db3-bfd5-70af703ef9b5@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 25 Nov 2025 09:34:48 +0800
X-Gm-Features: AWmQ_bkk0DtFTGOvKavrVP7oP-GeqBsUpf0HhfMPTzbDQm7y-NWEOZmLDbWnymM
Message-ID: <CACGkMEt_Z0a3kidmmjXcajU2EVi-B6mi832weeumPfZzmLoEPA@mail.gmail.com>
Subject: Re: [PATCH net-next v6 0/8] tun/tap & vhost-net: netdev queue flow
 control to avoid ptr_ring tail drop
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: willemdebruijn.kernel@gmail.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	mst@redhat.com, eperezma@redhat.com, jon@nutanix.com, 
	tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 24, 2025 at 5:20=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 11/24/25 02:04, Jason Wang wrote:
> > On Fri, Nov 21, 2025 at 5:23=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 11/21/25 07:19, Jason Wang wrote:
> >>> On Thu, Nov 20, 2025 at 11:30=E2=80=AFPM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> This patch series deals with tun/tap and vhost-net which drop incomi=
ng
> >>>> SKBs whenever their internal ptr_ring buffer is full. Instead, with =
this
> >>>> patch series, the associated netdev queue is stopped before this hap=
pens.
> >>>> This allows the connected qdisc to function correctly as reported by=
 [1]
> >>>> and improves application-layer performance, see our paper [2]. Meanw=
hile
> >>>> the theoretical performance differs only slightly:
> >>>>
> >>>> +--------------------------------+-----------+----------+
> >>>> | pktgen benchmarks to Debian VM | Stock     | Patched  |
> >>>> | i5 6300HQ, 20M packets         |           |          |
> >>>> +-----------------+--------------+-----------+----------+
> >>>> | TAP             | Transmitted  | 195 Kpps  | 183 Kpps |
> >>>> |                 +--------------+-----------+----------+
> >>>> |                 | Lost         | 1615 Kpps | 0 pps    |
> >>>> +-----------------+--------------+-----------+----------+
> >>>> | TAP+vhost_net   | Transmitted  | 589 Kpps  | 588 Kpps |
> >>>> |                 +--------------+-----------+----------+
> >>>> |                 | Lost         | 1164 Kpps | 0 pps    |
> >>>> +-----------------+--------------+-----------+----------+
> >>>
> >>
> >> Hi Jason,
> >>
> >> thank you for your reply!
> >>
> >>> PPS drops somehow for TAP, any reason for that?
> >>
> >> I have no explicit explanation for that except general overheads comin=
g
> >> with this implementation.
> >
> > It would be better to fix that.
> >
> >>
> >>>
> >>> Btw, I had some questions:
> >>>
> >>> 1) most of the patches in this series would introduce non-trivial
> >>> impact on the performance, we probably need to benchmark each or spli=
t
> >>> the series. What's more we need to run TCP benchmark
> >>> (throughput/latency) as well as pktgen see the real impact
> >>
> >> What could be done, IMO, is to activate tun_ring_consume() /
> >> tap_ring_consume() before enabling tun_ring_produce(). Then we could s=
ee
> >> if this alone drops performance.
> >>
> >> For TCP benchmarks, you mean userspace performance like iperf3 between=
 a
> >> host and a guest system?
> >
> > Yes,
> >
> >>
> >>>
> >>> 2) I see this:
> >>>
> >>>         if (unlikely(tun_ring_produce(&tfile->tx_ring, queue, skb))) =
{
> >>>                 drop_reason =3D SKB_DROP_REASON_FULL_RING;
> >>>                 goto drop;
> >>>         }
> >>>
> >>> So there could still be packet drop? Or is this related to the XDP pa=
th?
> >>
> >> Yes, there can be packet drops after a ptr_ring resize or a ptr_ring
> >> unconsume. Since those two happen so rarely, I figured we should just
> >> drop in this case.
> >>
> >>>
> >>> 3) The LLTX change would have performance implications, but the
> >>> benmark doesn't cover the case where multiple transmission is done in
> >>> parallel
> >>
> >> Do you mean multiple applications that produce traffic and potentially
> >> run on different CPUs?
> >
> > Yes.
> >
> >>
> >>>
> >>> 4) After the LLTX change, it seems we've lost the synchronization wit=
h
> >>> the XDP_TX and XDP_REDIRECT path?
> >>
> >> I must admit I did not take a look at XDP and cannot really judge if/h=
ow
> >> lltx has an impact on XDP. But from my point of view, __netif_tx_lock(=
)
> >> instead of __netif_tx_acquire(), is executed before the tun_net_xmit()
> >> call and I do not see the impact for XDP, which calls its own methods.
> >
> > Without LLTX tun_net_xmit is protected by tx lock but it is not the
> > case of tun_xdp_xmit. This is because, unlike other devices, tun
> > doesn't have a dedicated TX queue for XDP, so the queue is shared by
> > both XDP and skb. So XDP xmit path needs to be protected with tx lock
> > as well, and since we don't have queue discipline for XDP, it means we
> > could still drop packets when XDP is enabled. I'm not sure this would
> > defeat the whole idea or not.
>
> Good point.
>
> >
> >>>
> >>> 5) The series introduces various ptr_ring helpers with lots of
> >>> ordering stuff which is complicated, I wonder if we first have a
> >>> simple patch to implement the zero packet loss
> >>
> >> I personally don't see how a simpler patch is possible without using
> >> discouraged practices like returning NETDEV_TX_BUSY in tun_net_xmit or
> >> spin locking between producer and consumer. But I am open for
> >> suggestions :)
> >
> > I see NETDEV_TX_BUSY is used by veth:
> >
> > static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
> > {
> >         if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb)))
> >                 return NETDEV_TX_BUSY; /* signal qdisc layer */
> >
> >         return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
> > }
> >
> > Maybe it would be simpler to start from that (probably with a new tun->=
flags?).
> >
> > Thanks
>
> Do you mean that this patchset could be implemented using the same
> approach that was used for veth in [1]?
> This could then also fix the XDP path.

I think so.

>
> But is returning NETDEV_TX_BUSY fine in our case?

If it helps to avoid packet drop. But I'm not sure if qdisc is a must
in your case.

>
> Do you mean a flag that enables or disables the no-drop behavior?

Yes, via a new flags that could be set via TUNSETIFF.

Thanks

>
> Thanks!
>
> [1] Link: https://lore.kernel.org/netdev/174559288731.827981.874825783997=
1869213.stgit@firesoul/T/#u
>
> >
> >>
> >>>
> >>>>
> >>>> This patch series includes tun/tap, and vhost-net because they share
> >>>> logic. Adjusting only one of them would break the others. Therefore,=
 the
> >>>> patch series is structured as follows:
> >>>> 1+2: new ptr_ring helpers for 3
> >>>> 3: tun/tap: tun/tap: add synchronized ring produce/consume with queu=
e
> >>>> management
> >>>> 4+5+6: tun/tap: ptr_ring wrappers and other helpers to be called by
> >>>> vhost-net
> >>>> 7: tun/tap & vhost-net: only now use the previous implemented functi=
ons to
> >>>> not break git bisect
> >>>> 8: tun/tap: drop get ring exports (not used anymore)
> >>>>
> >>>> Possible future work:
> >>>> - Introduction of Byte Queue Limits as suggested by Stephen Hemminge=
r
> >>>
> >>> This seems to be not easy. The tx completion depends on the userspace=
 behaviour.
> >>
> >> I agree, but I really would like to reduce the buffer bloat caused by =
the
> >> default 500 TUN / 1000 TAP packet queue without losing performance.
> >>
> >>>
> >>>> - Adaption of the netdev queue flow control for ipvtap & macvtap
> >>>>
> >>>> [1] Link: https://unix.stackexchange.com/questions/762935/traffic-sh=
aping-ineffective-on-tun-device
> >>>> [2] Link: https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Resear=
ch/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersio=
n.pdf
> >>>>
> >>>
> >>> Thanks
> >>>
> >>
> >> Thanks! :)
> >>
> >
>


