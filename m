Return-Path: <netdev+bounces-65760-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C4A83B97A
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 07:15:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E84A81C21280
	for <lists+netdev@lfdr.de>; Thu, 25 Jan 2024 06:15:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B0810A10;
	Thu, 25 Jan 2024 06:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BseD/Y4W"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B73524C
	for <netdev@vger.kernel.org>; Thu, 25 Jan 2024 06:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706163316; cv=none; b=N3x8kop3K+V4QF0hfJuXo4IBFIfDlXibMZctJMa3DYeIYjNpKwK7+WDPlMV/2uF5fT9JbtZYwyolMNAlGkSQKHDcg2wboGxDuh6VUjeAhTsyjIMs6uUlQ0hALBRFZN7LkZR+PrSLFIMGwmbie79HPZ+/S2K0PZkelpK/3GpU1yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706163316; c=relaxed/simple;
	bh=6JeGru3XvCa8nXlEQODiUh3M/6hrKyguOC0vg7/04YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8HD8HMQSd69SZI7+AZIAEsKy7VtMXsQGuyOFYj5PFIUwiS0X+egXq0F38GXXZueVYxPfwP77/kHYnzeJ6mnhOOpE+EVFzppCOh4ArRfgq4abIQwi3JxVuN57fzfMSiis0CUShoqKhJCezcfPYyY/uGwsgzr/Yg30satpLp2+iY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BseD/Y4W; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706163313;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2IDmvyRmiceZrYYUtuhqprWPwfcU14v8Y7/PsE84/l0=;
	b=BseD/Y4W+zfZyBw2AN8VuoPNjmwhlWQr+/1mCbqsRP2ybTHPyAF+nxU4+3jZ/vMkBde1dp
	b4RZUJ4B3z+3lnJi2JyzllZ7a+w5fgJSgIPeSI5dwjaXN50iSBuEWfERveX3Ozj2aH5OaQ
	Bvo7K5ckS34l3it4kuers55Y/n8naAA=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-263-FNbTG9GHPGW9ldjGq_ZF9w-1; Thu, 25 Jan 2024 01:15:11 -0500
X-MC-Unique: FNbTG9GHPGW9ldjGq_ZF9w-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6dfb69507beso6613901a34.2
        for <netdev@vger.kernel.org>; Wed, 24 Jan 2024 22:15:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706163309; x=1706768109;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2IDmvyRmiceZrYYUtuhqprWPwfcU14v8Y7/PsE84/l0=;
        b=GdGrJEEYxNqd1TFEngh5CZ7hb2p4wINYcM9SHN4BdqcF2nsNpfKHdNqJazWd9jyws3
         T+X3h8JRKM0IOu2EdVvKIxN2OTayx9YiR+P7Nj6S1uDBbMWGsDFVpsnEwGTejnqWrKK1
         8mTXNtUHxRik30vhtkNWA4PCzNVA5DlZV5e0jl1i5HV8UPlOujnOVg7KhkC9yA/0v/hl
         WNFVBfBLaHc/tITDqtfZ2+2H8EcBPGjnLmp8JjFwE8XLGUcC7jLbM96bJm4T3YW6s7vs
         Le6nzXhkdXfbGbttAX8A1nn5m3RK4tXFKdMQwa0MLOoXhdjqxZHs9VVPe7BNPnHtDtb4
         sl+g==
X-Gm-Message-State: AOJu0YwcWlJKC2rG3bgjNJHIGPlMpkPsLGMoxofbCbH7WnpBlAskkoJp
	1LwykQpt3ZoFc/qNsml9ORKqPXdtuD+nXPfj4DOrU2xKmiB10J6kshZ+bTXg2FniKisYTAZK6Al
	F2xoXZzTOH3I11aeTwqoNaP/YfAzOflmGjEIY/t8X/e2sq9lVNHX5iKp4iDAoIBtICb6qs0v7Jq
	O1I90toj3TyPR6o4v9aBQX2bL2+7dn
X-Received: by 2002:a05:6358:7e9b:b0:175:c37d:2a47 with SMTP id o27-20020a0563587e9b00b00175c37d2a47mr516722rwn.35.1706163309626;
        Wed, 24 Jan 2024 22:15:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdOKSnNNDuA1Mc8s5btzaLVuZx2QBCLAFYmeBwb54BITgDiwvYegoAx7ubdKYtQcJ4xUFze66Hn2QoKhw82Q4=
X-Received: by 2002:a05:6358:7e9b:b0:175:c37d:2a47 with SMTP id
 o27-20020a0563587e9b00b00175c37d2a47mr516714rwn.35.1706163309328; Wed, 24 Jan
 2024 22:15:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116075924.42798-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuvubWfg8Wc+=eNqg1rHR+PD6jsH7_QEJV6=S+DUVdThQ@mail.gmail.com>
 <1706161325.4430635-1-xuanzhuo@linux.alibaba.com> <1706161768.900584-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1706161768.900584-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Jan 2024 14:14:58 +0800
Message-ID: <CACGkMEug-=C+VQhkMYSgUKMC==04m7-uem_yC21bgGkKZh845w@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] virtio-net: sq support premapped mode
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: netdev@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, virtualization@lists.linux.dev, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 1:52=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> On Thu, 25 Jan 2024 13:42:05 +0800, Xuan Zhuo <xuanzhuo@linux.alibaba.com=
> wrote:
> > On Thu, 25 Jan 2024 11:39:28 +0800, Jason Wang <jasowang@redhat.com> wr=
ote:
> > > On Tue, Jan 16, 2024 at 3:59=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.ali=
baba.com> wrote:
> > > >
> > > > This is the second part of virtio-net support AF_XDP zero copy.
> > > >
> > > > The whole patch set
> > > > http://lore.kernel.org/all/20231229073108.57778-1-xuanzhuo@linux.al=
ibaba.com
> > > >
> > > > ## About the branch
> > > >
> > > > This patch set is pushed to the net-next branch, but some patches a=
re about
> > > > virtio core. Because the entire patch set for virtio-net to support=
 AF_XDP
> > > > should be pushed to net-next, I hope these patches will be merged i=
nto net-next
> > > > with the virtio core maintains's Acked-by.
> > > >
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
> > > >
> > > > ## AF_XDP
> > > >
> > > > XDP socket(AF_XDP) is an excellent bypass kernel network framework.=
 The zero
> > > > copy feature of xsk (XDP socket) needs to be supported by the drive=
r. The
> > > > performance of zero copy is very good. mlx5 and intel ixgbe already=
 support
> > > > this feature, This patch set allows virtio-net to support xsk's zer=
ocopy xmit
> > > > feature.
> > > >
> > > > At present, we have completed some preparation:
> > > >
> > > > 1. vq-reset (virtio spec and kernel code)
> > > > 2. virtio-core premapped dma
> > > > 3. virtio-net xdp refactor
> > > >
> > > > So it is time for Virtio-Net to complete the support for the XDP So=
cket
> > > > Zerocopy.
> > > >
> > > > Virtio-net can not increase the queue num at will, so xsk shares th=
e queue with
> > > > kernel.
> > > >
> > > > On the other hand, Virtio-Net does not support generate interrupt f=
rom driver
> > > > manually, so when we wakeup tx xmit, we used some tips. If the CPU =
run by TX
> > > > NAPI last time is other CPUs, use IPI to wake up NAPI on the remote=
 CPU. If it
> > > > is also the local CPU, then we wake up napi directly.
> > > >
> > > > This patch set includes some refactor to the virtio-net to let that=
 to support
> > > > AF_XDP.
> > > >
> > > > ## performance
> > > >
> > > > ENV: Qemu with vhost-user(polling mode).
> > > > Host CPU: Intel(R) Xeon(R) Platinum 8163 CPU @ 2.50GHz
> > > >
> > > > ### virtio PMD in guest with testpmd
> > > >
> > > > testpmd> show port stats all
> > > >
> > > >  ######################## NIC statistics for port 0 ###############=
#########
> > > >  RX-packets: 19531092064 RX-missed: 0     RX-bytes: 1093741155584
> > > >  RX-errors: 0
> > > >  RX-nombuf: 0
> > > >  TX-packets: 5959955552 TX-errors: 0     TX-bytes: 371030645664
> > > >
> > > >
> > > >  Throughput (since last show)
> > > >  Rx-pps:   8861574     Rx-bps:  3969985208
> > > >  Tx-pps:   8861493     Tx-bps:  3969962736
> > > >  ##################################################################=
##########
> > > >
> > > > ### AF_XDP PMD in guest with testpmd
> > > >
> > > > testpmd> show port stats all
> > > >
> > > >   ######################## NIC statistics for port 0  #############=
###########
> > > >   RX-packets: 68152727   RX-missed: 0          RX-bytes:  381655271=
2
> > > >   RX-errors: 0
> > > >   RX-nombuf:  0
> > > >   TX-packets: 68114967   TX-errors: 33216      TX-bytes:  381443815=
2
> > > >
> > > >   Throughput (since last show)
> > > >   Rx-pps:      6333196          Rx-bps:   2837272088
> > > >   Tx-pps:      6333227          Tx-bps:   2837285936
> > > >   #################################################################=
###########
> > > >
> > > > But AF_XDP consumes more CPU for tx and rx napi(100% and 86%).
> > > >
> > > > ## maintain
> > > >
> > > > I am currently a reviewer for virtio-net. I commit to maintain AF_X=
DP support in
> > > > virtio-net.
> > > >
> > > > Please review.
> > > >
> > >
> > > Rethink of the whole design, I have one question:
> > >
> > > The reason we need to store DMA information is to harden the virtqueu=
e
> > > to make sure the DMA unmap is safe. This seems redundant when the
> > > buffer were premapped by the driver, for example:
> > >
> > > Receive queue maintains DMA information, so it doesn't need desc_extr=
a to work.
> > >
> > > So can we simply
> > >
> > > 1) when premapping is enabled, store DMA information by driver itself
> >
> > YES. this is simpler. And this is more convenience.
> > But the driver must allocate memory to store the dma info.

Right, and this looks like the common practice for most of the NIC drivers.

> >
> > > 2) don't store DMA information in desc_extra
> >
> > YES. But the desc_extra memory is wasted. The "next" item is used.
> > Do you think should we free the desc_extra when the vq is premapped mod=
e?
>
>
> struct vring_desc_extra {
>         dma_addr_t addr;                /* Descriptor DMA addr. */
>         u32 len;                        /* Descriptor length. */
>         u16 flags;                      /* Descriptor flags. */
>         u16 next;                       /* The next desc state in a list.=
 */
> };
>
>
> The flags and the next are used whatever premapped or not.
>
> So I think we can add a new array to store the addr and len.

Yes.

> If the vq is premappd, the memory can be freed.

Then we need to make sure the premapped is set before find_vqs() etc.

>
> struct vring_desc_extra {
>         u16 flags;                      /* Descriptor flags. */
>         u16 next;                       /* The next desc state in a list.=
 */
> };
>
> struct vring_desc_dma {
>         dma_addr_t addr;                /* Descriptor DMA addr. */
>         u32 len;                        /* Descriptor length. */
> };
>
> Thanks.

Thanks

>
> >
> > Thanks.
> >
> >
> > >
> > > Would this be simpler?
> > >
> > > Thanks
> > >
>


