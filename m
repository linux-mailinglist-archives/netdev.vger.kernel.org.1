Return-Path: <netdev+bounces-241791-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 47227C883F8
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 07:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2D7F84E45BC
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 06:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCCC826A08F;
	Wed, 26 Nov 2025 06:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DtEx8ndk";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JKDzF5T0"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04A50347DD
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 06:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764138016; cv=none; b=LkClekIetg1iqiYmjSIV1tOBeBTbmhgqEO5f92GNVXshky+W4JX4xUbNN47gY6fqVMBMJ22uqDYz+jnqeQmDgDS9V0PFnXRToEHoMhzP2rkQ0+MoGV32/xHPaCnzCEzLw9syXgSlbnEPA7/gm13tKbgIkBi0EwPhgfIGlTnjXiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764138016; c=relaxed/simple;
	bh=Kje+uZLJok0Cc2VK35vv+EDkVzhGMKWBO0HlobKPkeI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KUBUtx9WKwWFH/ig/Qy77PIstOwiEFTiNRBmzM4sHkHffCX7fQpbnfCC9a5f9uVCMAelMseKb0/y+2AOP9DGLRJug/7RLUdFtodhy8bvPRlxqi5nJB/xY0gGQpJVgbl3942WJIYZh7BW1Fn61qp6t7XnmRL2/eDHA3vpQpT9eHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DtEx8ndk; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JKDzF5T0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764138014;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qngb9/q5hX5E+yRftD3GVAu+tXWI/9Yvu89Exbu6mac=;
	b=DtEx8ndkr9Fy+d2yleT8Z2RR7Rr9+qQA+w9kEfdYKVOTjG4W3Ep/RccyZookydgpp0WFqv
	hfN3tM+GDYMSymWx6L1V/GBZKbDXv5UxyZQgZfnFlq0C09GWsFL/UOTCMZv/Ng5vYBovBN
	wRjvzAxP91K/4xtuq8ajdsnE/pND2Qo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-_GqHdHE_Nreo8Pa99wa6FA-1; Wed, 26 Nov 2025 01:20:12 -0500
X-MC-Unique: _GqHdHE_Nreo8Pa99wa6FA-1
X-Mimecast-MFC-AGG-ID: _GqHdHE_Nreo8Pa99wa6FA_1764138011
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-343daf0f488so6465817a91.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 22:20:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1764138011; x=1764742811; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qngb9/q5hX5E+yRftD3GVAu+tXWI/9Yvu89Exbu6mac=;
        b=JKDzF5T0/mrXrjzex1huKQjzsMc1OYMwkU4BhQ5Pk1bkH9RNwvEesVgCLjEyvcarFw
         C1gPZNlLxJfTMDoGU2kDvhen15zXIC+e2E45wlMD7APGnr63FRawGg80yuOzpiN0RHFc
         kfxmkLduuYcEPlA2MJPUhCv1G/ZrdRWgq0EctCJOdt2BrIgHJQicx0GFVCzChJuIAf2Q
         pjHRMszlGJYdo38sqtH8micgumSfX4aGD5QKJAGU3Lhlq2ozgen8OtYBmP45AcUwmOy4
         BL15P/41S8u00S+8ibkxxM5jLMp21HCq0qR0B55iZ5YTdu3bPCw2oMYEco6wI5pK75+1
         KpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764138011; x=1764742811;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Qngb9/q5hX5E+yRftD3GVAu+tXWI/9Yvu89Exbu6mac=;
        b=gB1lZ7Lj6548AHdj6Knqk8ekIxVGa4XeIQzN0p2y+fQQ/rHj7j4oLORKzcYf3iZXEc
         J+FzdMPCcUh7sWO+/eqk824Lbu+l7w9ztfxLnigCldLQwiQjjbBIEG8JNobSGAelXajf
         QJEMoPBe8dGqRoHRgLndpuCwhT67qYSQUhGlMD4snln+jQqjOza/0ZRMwDeM2RetdsaZ
         Jq//F/K7iiHO5gGxS+u9d7u5OZUz+156MX1kkcHJOOPfhCMOG9lLIZ+GK1xJl4nQnuWT
         mq8YObCZj827yRsAMbDhZa1bpXyfROXqgkI5MDXPtq+7Cs0f+ofVISdd8GI7lRLWvfyJ
         /UXg==
X-Forwarded-Encrypted: i=1; AJvYcCX9k4O6mHhaBkp6LqMVzsMwzW8YkNu+MdfQV/YNL0CqD1sLwVhRwzf3P2SjJnSH4HM0j78Owps=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUtsjP+1JVhueD/ZM4K+1txUpXN//D+p5Q8lAgJalslCImBH/5
	LVKGeE5O7rdP3hdSGzqkt6T3Pukd6pcTlsew4cikiiFMTgcpFp68OorknvNk0njnm2weL59t8ko
	K8Ob4em3JgSm5lLbWCbCj3mvO0ZsVAgl1Wl5npuyGXsJIxeYygZ89RDj/VMIyheHU/jU+L/jOh8
	esWyO5kterQzZNTObDSM+TSrz2ooqYOJC+
X-Gm-Gg: ASbGncso0OZccmAaAZ6CKMmL7RHlrWW5wpgvoZNd6lKzy/GJdldYryGcMdPqA+WK24Z
	SuXXzfWjKhtkOFwzw2KwZpehs8pmlv1TQrR1x7KKmHy5qZ80g7pjwqf16xmeAK5aU67Z2MEHFDu
	zMt0h4cCuzxs1mPKjYNLNceKyCwZgqQI/KgRkqfgqSnZp9vWYvuk77/meS/qMi471Q/L0=
X-Received: by 2002:a17:90b:164c:b0:340:ad5e:cd with SMTP id 98e67ed59e1d1-3475ebe68f2mr5450725a91.5.1764138010805;
        Tue, 25 Nov 2025 22:20:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHzu55sf1O48RMHl8lZNBNVtExhtVSZa0Ee1DJJlPtf1FQGqnXdj3PlCOqZKS4rsNwmmrFfqBE3+vQxRaFEsaw=
X-Received: by 2002:a17:90b:164c:b0:340:ad5e:cd with SMTP id
 98e67ed59e1d1-3475ebe68f2mr5450686a91.5.1764138010263; Tue, 25 Nov 2025
 22:20:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <CACGkMEuboys8sCJFUTGxHUeouPFnVqVLGQBefvmxYDe4ooLfLg@mail.gmail.com>
 <b9fff8e1-fb96-4b1f-9767-9d89adf31060@tu-dortmund.de> <CACGkMEufNLjXj37NBVCW4xdSuVLLV4ZS4WTuRzdaBV-nYgKs8w@mail.gmail.com>
 <ebb431f9-fdd3-4db3-bfd5-70af703ef9b5@tu-dortmund.de> <CACGkMEt_Z0a3kidmmjXcajU2EVi-B6mi832weeumPfZzmLoEPA@mail.gmail.com>
 <9e586a3b-d7fa-4bba-b8d1-39f002e20913@tu-dortmund.de>
In-Reply-To: <9e586a3b-d7fa-4bba-b8d1-39f002e20913@tu-dortmund.de>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 26 Nov 2025 14:19:56 +0800
X-Gm-Features: AWmQ_bmX2z4Rsrd9gTG8Q3jqwi3c_3tBdjzkTDrnhoXnII9EOlWohLhRpPIUfSk
Message-ID: <CACGkMEtSOChfGprjtdoyxxJ7RSEJ=5GyYdS_tpQQa4og-5YvyQ@mail.gmail.com>
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

On Tue, Nov 25, 2025 at 10:05=E2=80=AFPM Simon Schippers
<simon.schippers@tu-dortmund.de> wrote:
>
> On 11/25/25 02:34, Jason Wang wrote:
> > On Mon, Nov 24, 2025 at 5:20=E2=80=AFPM Simon Schippers
> > <simon.schippers@tu-dortmund.de> wrote:
> >>
> >> On 11/24/25 02:04, Jason Wang wrote:
> >>> On Fri, Nov 21, 2025 at 5:23=E2=80=AFPM Simon Schippers
> >>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>
> >>>> On 11/21/25 07:19, Jason Wang wrote:
> >>>>> On Thu, Nov 20, 2025 at 11:30=E2=80=AFPM Simon Schippers
> >>>>> <simon.schippers@tu-dortmund.de> wrote:
> >>>>>>
> >>>>>> This patch series deals with tun/tap and vhost-net which drop inco=
ming
> >>>>>> SKBs whenever their internal ptr_ring buffer is full. Instead, wit=
h this
> >>>>>> patch series, the associated netdev queue is stopped before this h=
appens.
> >>>>>> This allows the connected qdisc to function correctly as reported =
by [1]
> >>>>>> and improves application-layer performance, see our paper [2]. Mea=
nwhile
> >>>>>> the theoretical performance differs only slightly:
> >>>>>>
> >>>>>> +--------------------------------+-----------+----------+
> >>>>>> | pktgen benchmarks to Debian VM | Stock     | Patched  |
> >>>>>> | i5 6300HQ, 20M packets         |           |          |
> >>>>>> +-----------------+--------------+-----------+----------+
> >>>>>> | TAP             | Transmitted  | 195 Kpps  | 183 Kpps |
> >>>>>> |                 +--------------+-----------+----------+
> >>>>>> |                 | Lost         | 1615 Kpps | 0 pps    |
> >>>>>> +-----------------+--------------+-----------+----------+
> >>>>>> | TAP+vhost_net   | Transmitted  | 589 Kpps  | 588 Kpps |
> >>>>>> |                 +--------------+-----------+----------+
> >>>>>> |                 | Lost         | 1164 Kpps | 0 pps    |
> >>>>>> +-----------------+--------------+-----------+----------+
> >>>>>
> >>>>
> >>>> Hi Jason,
> >>>>
> >>>> thank you for your reply!
> >>>>
> >>>>> PPS drops somehow for TAP, any reason for that?
> >>>>
> >>>> I have no explicit explanation for that except general overheads com=
ing
> >>>> with this implementation.
> >>>
> >>> It would be better to fix that.
> >>>
> >>>>
> >>>>>
> >>>>> Btw, I had some questions:
> >>>>>
> >>>>> 1) most of the patches in this series would introduce non-trivial
> >>>>> impact on the performance, we probably need to benchmark each or sp=
lit
> >>>>> the series. What's more we need to run TCP benchmark
> >>>>> (throughput/latency) as well as pktgen see the real impact
> >>>>
> >>>> What could be done, IMO, is to activate tun_ring_consume() /
> >>>> tap_ring_consume() before enabling tun_ring_produce(). Then we could=
 see
> >>>> if this alone drops performance.
> >>>>
> >>>> For TCP benchmarks, you mean userspace performance like iperf3 betwe=
en a
> >>>> host and a guest system?
> >>>
> >>> Yes,
> >>>
> >>>>
> >>>>>
> >>>>> 2) I see this:
> >>>>>
> >>>>>         if (unlikely(tun_ring_produce(&tfile->tx_ring, queue, skb))=
) {
> >>>>>                 drop_reason =3D SKB_DROP_REASON_FULL_RING;
> >>>>>                 goto drop;
> >>>>>         }
> >>>>>
> >>>>> So there could still be packet drop? Or is this related to the XDP =
path?
> >>>>
> >>>> Yes, there can be packet drops after a ptr_ring resize or a ptr_ring
> >>>> unconsume. Since those two happen so rarely, I figured we should jus=
t
> >>>> drop in this case.
> >>>>
> >>>>>
> >>>>> 3) The LLTX change would have performance implications, but the
> >>>>> benmark doesn't cover the case where multiple transmission is done =
in
> >>>>> parallel
> >>>>
> >>>> Do you mean multiple applications that produce traffic and potential=
ly
> >>>> run on different CPUs?
> >>>
> >>> Yes.
> >>>
> >>>>
> >>>>>
> >>>>> 4) After the LLTX change, it seems we've lost the synchronization w=
ith
> >>>>> the XDP_TX and XDP_REDIRECT path?
> >>>>
> >>>> I must admit I did not take a look at XDP and cannot really judge if=
/how
> >>>> lltx has an impact on XDP. But from my point of view, __netif_tx_loc=
k()
> >>>> instead of __netif_tx_acquire(), is executed before the tun_net_xmit=
()
> >>>> call and I do not see the impact for XDP, which calls its own method=
s.
> >>>
> >>> Without LLTX tun_net_xmit is protected by tx lock but it is not the
> >>> case of tun_xdp_xmit. This is because, unlike other devices, tun
> >>> doesn't have a dedicated TX queue for XDP, so the queue is shared by
> >>> both XDP and skb. So XDP xmit path needs to be protected with tx lock
> >>> as well, and since we don't have queue discipline for XDP, it means w=
e
> >>> could still drop packets when XDP is enabled. I'm not sure this would
> >>> defeat the whole idea or not.
> >>
> >> Good point.
> >>
> >>>
> >>>>>
> >>>>> 5) The series introduces various ptr_ring helpers with lots of
> >>>>> ordering stuff which is complicated, I wonder if we first have a
> >>>>> simple patch to implement the zero packet loss
> >>>>
> >>>> I personally don't see how a simpler patch is possible without using
> >>>> discouraged practices like returning NETDEV_TX_BUSY in tun_net_xmit =
or
> >>>> spin locking between producer and consumer. But I am open for
> >>>> suggestions :)
> >>>
> >>> I see NETDEV_TX_BUSY is used by veth:
> >>>
> >>> static int veth_xdp_rx(struct veth_rq *rq, struct sk_buff *skb)
> >>> {
> >>>         if (unlikely(ptr_ring_produce(&rq->xdp_ring, skb)))
> >>>                 return NETDEV_TX_BUSY; /* signal qdisc layer */
> >>>
> >>>         return NET_RX_SUCCESS; /* same as NETDEV_TX_OK */
> >>> }
> >>>
> >>> Maybe it would be simpler to start from that (probably with a new tun=
->flags?).
> >>>
> >>> Thanks
> >>
> >> Do you mean that this patchset could be implemented using the same
> >> approach that was used for veth in [1]?
> >> This could then also fix the XDP path.
> >
> > I think so.
>
> Okay, I will do so and submit a v7 when net-next opens again for 6.19.
>
> >
> >>
> >> But is returning NETDEV_TX_BUSY fine in our case?
> >
> > If it helps to avoid packet drop. But I'm not sure if qdisc is a must
> > in your case.
>
> I will try to avoid returning it.
>
> When no qdisc is connected, I will just drop like veth does.
>
> >
> >>
> >> Do you mean a flag that enables or disables the no-drop behavior?
> >
> > Yes, via a new flags that could be set via TUNSETIFF.
> >
> > Thanks
>
> I am not a fan of that, since I can not imagine a use case where
> dropping packets is desired.

Right, it's just for the case when we can see regression for some specific =
test.

> veth does not introduce a flag either.
>
> Of course, if there is a major performance degradation, it makes sense.
> But I will benchmark it, and we will see.

Exactly.

Thanks

>
> Thank you!
>
> >
> >>
> >> Thanks!
> >>
> >> [1] Link: https://lore.kernel.org/netdev/174559288731.827981.874825783=
9971869213.stgit@firesoul/T/#u
> >>
> >>>
> >>>>
> >>>>>
> >>>>>>
> >>>>>> This patch series includes tun/tap, and vhost-net because they sha=
re
> >>>>>> logic. Adjusting only one of them would break the others. Therefor=
e, the
> >>>>>> patch series is structured as follows:
> >>>>>> 1+2: new ptr_ring helpers for 3
> >>>>>> 3: tun/tap: tun/tap: add synchronized ring produce/consume with qu=
eue
> >>>>>> management
> >>>>>> 4+5+6: tun/tap: ptr_ring wrappers and other helpers to be called b=
y
> >>>>>> vhost-net
> >>>>>> 7: tun/tap & vhost-net: only now use the previous implemented func=
tions to
> >>>>>> not break git bisect
> >>>>>> 8: tun/tap: drop get ring exports (not used anymore)
> >>>>>>
> >>>>>> Possible future work:
> >>>>>> - Introduction of Byte Queue Limits as suggested by Stephen Hemmin=
ger
> >>>>>
> >>>>> This seems to be not easy. The tx completion depends on the userspa=
ce behaviour.
> >>>>
> >>>> I agree, but I really would like to reduce the buffer bloat caused b=
y the
> >>>> default 500 TUN / 1000 TAP packet queue without losing performance.
> >>>>
> >>>>>
> >>>>>> - Adaption of the netdev queue flow control for ipvtap & macvtap
> >>>>>>
> >>>>>> [1] Link: https://unix.stackexchange.com/questions/762935/traffic-=
shaping-ineffective-on-tun-device
> >>>>>> [2] Link: https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Rese=
arch/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVers=
ion.pdf
> >>>>>>
> >>>>>
> >>>>> Thanks
> >>>>>
> >>>>
> >>>> Thanks! :)
> >>>>
> >>>
> >>
> >
>


