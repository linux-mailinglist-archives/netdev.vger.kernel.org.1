Return-Path: <netdev+bounces-116661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAAE294B52C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4192849DF
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 02:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17477D2FB;
	Thu,  8 Aug 2024 02:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CT1YUaxl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3580A2A1D7
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 02:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723085443; cv=none; b=nK3TrhIp95abqdYzUQ/MEE1Qu8nIJz8CqOfNkRqyKQH5wBtBFzlSVjJfSYKsjOvEAICCOZAr44mggJ5yCv2NM94CGOh2fe/n6ME6g2w/npR3WSHbBTEZw8shyOI4m7kNB+fKgPaPxQ9zy2Mo05y9Auav5mUeaBcF3UXqFsYjPhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723085443; c=relaxed/simple;
	bh=0ZlB+FsgkNnSx2A+aU0XXXyMaOrTYWciu4i9GrRw5VM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=miuMqlJgjrnZr3n1xbpcSNp79Mp3rFuy3OhDELKaXyj7cCLBKYtP86LX80RS6GWG3mmLre3OYBoQ6MIEapdnulSbdibYlt8FjvBgUa788blsWUSjzHAPT+Aw2mf6Lbip9Szz3/KePb9zESyIH1n8W8J1ZAcfnBgLB2PpeFDJzUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CT1YUaxl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723085440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JjzVSY9XRdPE0CWW2Bob0wJ+JoI0Vjpz5M6il4IGXg=;
	b=CT1YUaxlLVMYt8kO9BzUqTloU2Wm5Boi89AB3GCmNWy/pi/6x6fmel6vG2nJ269b9p+P5+
	1OR1WiZqJHZ1HuX9cPDj4u6C762a0LuzcrSg5AdRg1x3qhrNL3RwRDW4UOCDeQ7+JZQDHq
	jBHaESHiFhBdOWhcJ+Y200wBa6q45TM=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-fzAGC0cnPW-bq31-X7Jz7g-1; Wed, 07 Aug 2024 22:50:38 -0400
X-MC-Unique: fzAGC0cnPW-bq31-X7Jz7g-1
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-2cb5ba80e77so739758a91.1
        for <netdev@vger.kernel.org>; Wed, 07 Aug 2024 19:50:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723085437; x=1723690237;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7JjzVSY9XRdPE0CWW2Bob0wJ+JoI0Vjpz5M6il4IGXg=;
        b=www44iBgOEA0riPEGwSx0ACdFYN80awKd76SMfmZK3eCW0ztz318mUTAgQ9u01qNky
         8yQjr/2XyNzFXAXX6Lcm7jp2gctG5endvWnjPt2mDI7zYVpI0fCzSETG3QjYOKg2fjT8
         km14aWcJ40M+jEJrZZo8yXXHNlKnoKLCkD67JwtR1PCvZ9J2YqrGvnTY4xEA7OSWbEJH
         9iKu6n40AzU9AszjgryCl/iTee6V1wyLEcINJdDu36Cah2DpX1FB5stUNzfCHPtuVsWe
         uArSBjXTwtlbD5faC3bXLK6z4gkx/L03lPrlj+LdR1EfilUD+bTf5L/f4hbKDgxE+TFs
         +QOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtL6oJ79mGzx6PbAyUNJ5OavCFle1yK8Ov8UeudOyi+2iLQplO1N0Cipld6fujoX9gmT4tzP9dU2ABBD2ytdGZS/P66lo0
X-Gm-Message-State: AOJu0YylaaQSZD63Sxg1DIOguKGbJNqyG7bYQQ40DokI47ioZjjo/MZQ
	CMrRyUHAroFnn3Ej8V0cI+x5goyECvx7yxN3aIcAf/ugpRqtgzu0F3MxxFOlPJcqnde0gEQ0ts7
	TUdr+Coi3XDxLojuZjMIDls5Re93pdrG+Jjy2TonI3Q3fIs9eSlcN3XrC9xYa93e8qHPGNU79pO
	WEfiBYpYn5+kN/4IFWkICa1NNkbtqi
X-Received: by 2002:a17:90a:d902:b0:2cd:2992:e8e5 with SMTP id 98e67ed59e1d1-2d1c347b7cemr642381a91.33.1723085437550;
        Wed, 07 Aug 2024 19:50:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiuVUqPb9qud7D+nQlMFEns+BDAfKQBlVq0UJdATRjPMyWPAorkhuUlV1F5v8WoRm63VtCh8wXLqFGmX73Vt4=
X-Received: by 2002:a17:90a:d902:b0:2cd:2992:e8e5 with SMTP id
 98e67ed59e1d1-2d1c347b7cemr642363a91.33.1723085436969; Wed, 07 Aug 2024
 19:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801135639.11400-1-hengqi@linux.alibaba.com>
 <CACGkMEtBeUnDeD0zYBvpwjhQ4Lv0dz8mBDQ_C-yP1VEaQdv-0A@mail.gmail.com>
 <20240802090822-mutt-send-email-mst@kernel.org> <CACGkMEvPdiKS7+S5Btk+uMwtwRnPfTd6Brwz2acgBfNAnTXMFA@mail.gmail.com>
 <20240805015308-mutt-send-email-mst@kernel.org> <CACGkMEsL6fyf9ecY8_LpT5_=hHKFzW7==4DBer_w9xEpGUkRtw@mail.gmail.com>
 <20240806091923-mutt-send-email-mst@kernel.org> <CACGkMEtqozm3mr_ZhsfAY5mzTm9gT0arNs-6Avov5kX48uXsrg@mail.gmail.com>
 <20240807063041-mutt-send-email-mst@kernel.org>
In-Reply-To: <20240807063041-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 8 Aug 2024 10:50:24 +0800
Message-ID: <CACGkMEuRSp5fOEC88mT6FWgPkcfvib6jf_rqGhQjBYEqfOa_Nw@mail.gmail.com>
Subject: Re: [PATCH net-next] virtio_net: Prevent misidentified spurious
 interrupts from killing the irq
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 7, 2024 at 6:37=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com> =
wrote:
>
> On Wed, Aug 07, 2024 at 12:06:16PM +0800, Jason Wang wrote:
> > On Tue, Aug 6, 2024 at 9:25=E2=80=AFPM Michael S. Tsirkin <mst@redhat.c=
om> wrote:
> > >
> > > On Tue, Aug 06, 2024 at 11:18:14AM +0800, Jason Wang wrote:
> > > > On Mon, Aug 5, 2024 at 2:29=E2=80=AFPM Michael S. Tsirkin <mst@redh=
at.com> wrote:
> > > > >
> > > > > On Mon, Aug 05, 2024 at 11:26:56AM +0800, Jason Wang wrote:
> > > > > > On Fri, Aug 2, 2024 at 9:11=E2=80=AFPM Michael S. Tsirkin <mst@=
redhat.com> wrote:
> > > > > > >
> > > > > > > On Fri, Aug 02, 2024 at 11:41:57AM +0800, Jason Wang wrote:
> > > > > > > > On Thu, Aug 1, 2024 at 9:56=E2=80=AFPM Heng Qi <hengqi@linu=
x.alibaba.com> wrote:
> > > > > > > > >
> > > > > > > > > Michael has effectively reduced the number of spurious in=
terrupts in
> > > > > > > > > commit a7766ef18b33 ("virtio_net: disable cb aggressively=
") by disabling
> > > > > > > > > irq callbacks before cleaning old buffers.
> > > > > > > > >
> > > > > > > > > But it is still possible that the irq is killed by mistak=
e:
> > > > > > > > >
> > > > > > > > >   When a delayed tx interrupt arrives, old buffers has be=
en cleaned in
> > > > > > > > >   other paths (start_xmit and virtnet_poll_cleantx), then=
 the interrupt is
> > > > > > > > >   mistakenly identified as a spurious interrupt in vring_=
interrupt.
> > > > > > > > >
> > > > > > > > >   We should refrain from labeling it as a spurious interr=
upt; otherwise,
> > > > > > > > >   note_interrupt may inadvertently kill the legitimate ir=
q.
> > > > > > > >
> > > > > > > > I think the evil came from where we do free_old_xmit() in
> > > > > > > > start_xmit(). I know it is for performance, but we may need=
 to make
> > > > > > > > the code work correctly instead of adding endless hacks. Pe=
rsonally, I
> > > > > > > > think the virtio-net TX path is over-complicated. We probab=
ly pay too
> > > > > > > > much (e.g there's netif_tx_lock in TX NAPI path) to try to =
"optimize"
> > > > > > > > the performance.
> > > > > > > >
> > > > > > > > How about just don't do free_old_xmit and do that solely in=
 the TX NAPI?
> > > > > > >
> > > > > > > Not getting interrupts is always better than getting interrup=
ts.
> > > > > >
> > > > > > Not sure. For example letting 1 cpu to do the transmission with=
out the
> > > > > > dealing of xmit skbs should give us better performance.
> > > > >
> > > > > Hmm. It's a subtle thing. I suspect until certain limit
> > > > > (e.g. ping pong test) free_old_xmit will win anyway.
> > > >
> > > > Not sure I understand here.
> > >
> > > If you transmit 1 packet and then wait for another one anyway,
> > > you are better off just handling the tx interrupt.
> >
> > Yes for light load but not for heavy load like pktgen and others probab=
ly.
>
> If you are extermely busy sending packets, and you don't really care
> when they are freed, and the vq is deep
> and you have another, idle CPU, and sending interrupt does not need
> a vmexit - moving work out at the cost of an interrupt will be a win.

Exactly.

>
>
> > >
> > >
> > > > >
> > > > > > > This is not new code, there are no plans to erase it all and =
start
> > > > > > > anew "to make it work correctly" - it's widely deployed,
> > > > > > > you will cause performance regressions and they are hard
> > > > > > > to debug.
> > > > > >
> > > > > > I actually meant the TX NAPI mode, we tried to hold the TX lock=
 in the
> > > > > > TX NAPI, which turns out to slow down both the transmission and=
 the
> > > > > > NAPI itself.
> > > > > >
> > > > > > Thanks
> > > > >
> > > > > We do need to synchronize anyway though, virtio expects drivers t=
o do
> > > > > their own serialization of vq operations.
> > > >
> > > > Right, but currently add and get needs to be serialized which is a
> > > > bottleneck. I don't see any issue to parallelize that.
> > >
> > > Do you see this in traces?
> >
> > I mean current virtio_core requires the caller to serialize add/get:
> >
> > virtqueue_add() {
> > START_USE()
> > END_USE()
> > }
> >
> > virtqueue_get() {
> > START_USE()
> > END_USE()
> > }
> >
> > It seems to be a limitation of the current driver not the spec itself
> > which means we can find some way to allow those to be executed in
> > parallel.
> >
> > One example is to use ptr_ring to maintain a free id list or it is not
> > even needed in the case of in order.
>
> All quite tricky.

Yes but most modern NIC doesn't require serialization between add and get.

>
> But again - do you have traces showing contention on tx lock?
>
> Until we do, it's pointless to try and optimize: make changes to
> code, see if performance changes - is not a good way to do this,
> the system is too chaotic for that.

Yes. E.g 2 vcpus 1 queue. Pktgen 64 burst on vcpu0, perf top -C 1 shows:

 94.01%  [kernel]              [k] queued_spin_lock_slowpath
   0.93%  [kernel]              [k] native_apic_mem_eoi
   0.83%  [kernel]              [k] __irqentry_text_start
   0.48%  [kernel]              [k] vring_interrupt
   0.22%  perf                  [.] io__get_char
...

And calltrace shows it came from virtnet_poll_tx().

Reduce bursts may decrease the contention, e.g if burst 4 I can see
15% and if burst is 1, I can only see 4% in
queued_spin_lock_slowpath() in guests. Burst indeed increases the
performance but we pay the price as it may hold the tx lock for a
little bit a long time which slows down the NAPI.

Burst mode should be normal as we have BQL and qdisc bulk dequeuing
may work more. Generally, it's not a good idea to block NAPI/softirq
for a long time as it may delay other bh.

Thanks



>
>
> > >
> > > > > You could try to instead move
> > > > > skbs to some kind of array under the tx lock, then free them all =
up
> > > > > later after unlocking tx.
> > > > >
> > > > > Can be helpful for batching as well?
> > > >
> > > > It's worth a try and see.
> > >
> > > Why not.
> > >
> > > > >
> > > > >
> > > > > I also always wondered whether it is an issue that free_old_xmit
> > > > > just polls vq until it is empty, without a limit.
> > > >
> > > > Did you mean schedule a NAPI if free_old_xmit() exceeds the NAPI qu=
ota?
> > >
> > > yes
> > >
> > > > > napi is supposed to poll until a limit is reached.
> > > > > I guess not many people have very deep vqs.
> > > >
> > > > Current NAPI weight is 64, so I think we can meet it in stressful w=
orkload.
> > > >
> > > > Thanks
> > >
> > > yes, but it's just a random number.  since we hold the tx lock,
> > > we get at most vq size bufs, so it's limited.
> >
> > Ok.
> >
> > Thanks
> >
> > >
> > > > >
> > > > > --
> > > > > MST
> > > > >
> > >
>


