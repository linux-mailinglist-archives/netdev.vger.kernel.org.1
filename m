Return-Path: <netdev+bounces-105204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D67B79101C6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 12:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FD70285D6F
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 10:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F2B1AC44B;
	Thu, 20 Jun 2024 10:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HyAS49UG"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259BC1AC42C
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 10:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718880346; cv=none; b=R+fS8qcD1SQXHrvbSdxAND+Afpj/cvBPymAbOAT/D5iF3CFEqvC4cLb86JS1z1hPdMTIDTMLiH/fQbQ1LLf5X3/fLIyde4iuPUTb+xrVgqIYLxZzvUQarTDCG+qYLBFtPVKfg8xFLpiph7bH9dtl9vCIZDkmqZnu7XrJOn/HZAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718880346; c=relaxed/simple;
	bh=zaj6LyIDMEihWzCbErFpYPwqXGOl8xJsckbGCbnb/pc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHWlQ4IjLzAPZVuiHxXlwaFm8H1+KQ81+W4PHEZTDM3qok9LsCFsrKeQ5UlXfDkvSiNv6wv9659eGMHx4Z0QXmGaA6IBJefU3aaphxoKewEs1E1Dnw7AHm282+EHGDH8Hw4Inu8RPcktbPEmqExus2bFHOnQTzAiuWATBNgDo1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HyAS49UG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718880342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DF23mq6K6T0t7prdQfl1sG9b1uQJ8sumJTI6jij76Rg=;
	b=HyAS49UGuxvF10ZdFgji8ZYEuetq0dlXtZYPe5sJjnsLVjDBGOCHA0uK7QJ+nXY6JWF14s
	Crtm2MA4ALICZ5XegmMTLZ73sfzIrApPdi46eA79+IW1aoViL/ciZ2dWTsj/7O/h0sBb+o
	He4kSbAKp3VJEAuCnP/Fw60wko06hPc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-wzrvEEThO12fP46_D8NYjQ-1; Thu, 20 Jun 2024 06:45:41 -0400
X-MC-Unique: wzrvEEThO12fP46_D8NYjQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a6f2662d050so32020466b.3
        for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 03:45:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718880340; x=1719485140;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DF23mq6K6T0t7prdQfl1sG9b1uQJ8sumJTI6jij76Rg=;
        b=myuAhbii8MYZio5J/dfJ7kH6HCqsdXSR5oJETx7tSKAhRtBX7vqVglWMhk0r2aywiH
         lsFLfjB+boGF505HISLuItSyluWrI7QhpVCuHRFRWT1KFMsYQem0x2Jx5X26MLxyA17H
         f5RvMDejuOM7uyhLWfNy4GWnm9Rxf9zcxdUmUw0+UIi8a8/LZkTG1ZKle3mmM6n/wYvR
         6CDP+s7rzX42KOrKP2qLkR4UiMkaAs5Lk0Rb9NItOxZ6MTViAW7AnN/E9n9ckjjo2Dfb
         6E5+j3rJXALQCOfQsq0ILlwNFwl9UmOXl6/y8QxyH7gGhT8csiis7N32N8qHhLSNQLoQ
         obBA==
X-Forwarded-Encrypted: i=1; AJvYcCUliahGuaSfl7goqQlYJjoA4Nxw8IU18IaN2mabuICZOfQNELxEd0mc0/iuJUUTBRuyMkVidfd3P/tuacOSPxAGushWCzXi
X-Gm-Message-State: AOJu0YwpHMe6fHH4nvjmCeOWDqoB5lc1LUJNwr3xdcVBw+eOEI/SdABs
	b1uB4076W92x4zl+/9ZPd+eZyYUOOQ42jtdPZqhNTX2tNBl5xJqP+xUmsKroYk3SaFQn/W7TzL4
	3ZdglS9TjcJal8gxlly/qYkISBiZBmKZrGo6jQMHGoV7yivagCvV31g==
X-Received: by 2002:a17:907:d30e:b0:a6f:61c7:dea7 with SMTP id a640c23a62f3a-a6fab62a895mr309589666b.18.1718880339480;
        Thu, 20 Jun 2024 03:45:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6ASjWfwvVMB0x75+U0AbQhvSTAq5ALWMPjwLkiCD7rqdVPZuTdR/nKQ0TAnYinxKZma542Q==
X-Received: by 2002:a17:907:d30e:b0:a6f:61c7:dea7 with SMTP id a640c23a62f3a-a6fab62a895mr309587066b.18.1718880338849;
        Thu, 20 Jun 2024 03:45:38 -0700 (PDT)
Received: from redhat.com ([2.52.146.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f5c925e97sm712786766b.168.2024.06.20.03.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 03:45:38 -0700 (PDT)
Date: Thu, 20 Jun 2024 06:45:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, netdev@vger.kernel.org,
	virtualization@lists.linux.dev,
	Thomas Huth <thuth@linux.vnet.ibm.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Subject: Re: [PATCH 2/2] virtio_net: fixing XDP for fully checksummed packets
 handling
Message-ID: <20240620064508-mutt-send-email-mst@kernel.org>
References: <20240617131524.63662-1-hengqi@linux.alibaba.com>
 <20240617131524.63662-3-hengqi@linux.alibaba.com>
 <CACGkMEvj8fvXkCxDFQ1-Cyq5DL=axEf1Ch1zVnuQUNQy6Wjn+g@mail.gmail.com>
 <1718680517.8370645-12-hengqi@linux.alibaba.com>
 <CACGkMEsa3AsPkweqS0-BEjSw5sKW_XM669HVSN_eX7-8KVG8tQ@mail.gmail.com>
 <1718875728.9338605-7-hengqi@linux.alibaba.com>
 <20240620061710-mutt-send-email-mst@kernel.org>
 <1718879236.1007793-10-hengqi@linux.alibaba.com>
 <1718879929.7095907-12-hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1718879929.7095907-12-hengqi@linux.alibaba.com>

On Thu, Jun 20, 2024 at 06:38:49PM +0800, Heng Qi wrote:
> On Thu, 20 Jun 2024 18:27:16 +0800, Heng Qi <hengqi@linux.alibaba.com> wrote:
> > On Thu, 20 Jun 2024 06:19:01 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > On Thu, Jun 20, 2024 at 05:28:48PM +0800, Heng Qi wrote:
> > > > On Thu, 20 Jun 2024 16:33:35 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > On Tue, Jun 18, 2024 at 11:17 AM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > > > >
> > > > > > On Tue, 18 Jun 2024 11:10:26 +0800, Jason Wang <jasowang@redhat.com> wrote:
> > > > > > > On Mon, Jun 17, 2024 at 9:15 PM Heng Qi <hengqi@linux.alibaba.com> wrote:
> > > > > > > >
> > > > > > > > The XDP program can't correctly handle partially checksummed
> > > > > > > > packets, but works fine with fully checksummed packets.
> > > > > > >
> > > > > > > Not sure this is ture, if I was not wrong, XDP can try to calculate checksum.
> > > > > >
> > > > > > XDP's interface serves a full checksum,
> > > > > 
> > > > > What do you mean by "serve" here? I mean, XDP can calculate the
> > > > > checksum and fill it in the packet by itself.
> > > > > 
> > > > 
> > > > Yes, XDP can parse and calculate checksums for all packets.
> > > > However, the bpf_csum_diff and bpf_l4_csum_replace APIs provided by XDP assume
> > > > that the packets being processed are fully checksumed packets. That is,
> > > > after the XDP program modified the packets, the incremental checksum can be
> > > > calculated (for example, samples/bpf/tcbpf1_kern.c, samples/bpf/test_lwt_bpf.c).
> > > > 
> > > > Therefore, partially checksummed packets cannot be processed normally in these
> > > > examples and need to be discarded.
> > > > 
> > > > > > and this is why we disabled the
> > > > > > offloading of VIRTIO_NET_F_GUEST_CSUM when loading XDP.
> > > > > 
> > > > > If we trust the device to disable VIRTIO_NET_F_GUEST_CSUM, any reason
> > > > > to check VIRTIO_NET_HDR_F_NEEDS_CSUM again in the receive path?
> > > > 
> > > > There doesn't seem to be a mandatory constraint in the spec that devices that
> > > > haven't negotiated VIRTIO_NET_F_GUEST_CSUM cannot set NEEDS_CSUM bit, so I check this.
> > > > 
> > > > Thanks.
> > > 
> > > The spec says:
> > > 
> > > \item If the VIRTIO_NET_F_GUEST_CSUM feature was negotiated, the
> > >   VIRTIO_NET_HDR_F_NEEDS_CSUM bit in \field{flags} can be
> > >   set: if so, the packet checksum at offset \field{csum_offset} 
> > >   from \field{csum_start} and any preceding checksums
> > >   have been validated.  The checksum on the packet is incomplete and
> > >   if bit VIRTIO_NET_HDR_F_RSC_INFO is not set in \field{flags},
> > >   then \field{csum_start} and \field{csum_offset} indicate how to calculate it
> > >   (see Packet Transmission point 1).
> > > 
> > > 
> > > So yes, NEEDS_CSUM without VIRTIO_NET_F_GUEST_CSUM is at best undefined.
> > > Please do not try to use it unless VIRTIO_NET_F_GUEST_CSUM is set.
> > 
> > I've seen it before, but thought something like
> >  "The device MUST NOT set the NEEDS_CSUM bit if GUEST_CSUM has not been negotiated"
> > would be clearer.
> > 
> > Furthermore, it is still possible for a malicious device to set the bit.
> 
> Hint:
> We previously checked and used DATA_VALID and NEEDS_CSUM bits, but never checked
> to see if GUEST_CSUM was negotiated.


That would be out of spec then. Might be too late to fix.

> > 
> > Thanks.
> > 
> > > 
> > > And if you want to be flexible, ignore it unless VIRTIO_NET_F_GUEST_CSUM
> > > has been negotiated.
> > > 
> > > 
> > > 
> > > 
> > > 
> > > > > 
> > > > > >
> > > > > > Thanks.
> > > > > 
> > > > > Thanks
> > > > > 
> > > > > >
> > > > > > >
> > > > > > > Thanks
> > > > > > >
> > > > > > > > If the
> > > > > > > > device has already validated fully checksummed packets, then
> > > > > > > > the driver doesn't need to re-validate them, saving CPU resources.
> > > > > > > >
> > > > > > > > Additionally, the driver does not drop all partially checksummed
> > > > > > > > packets when VIRTIO_NET_F_GUEST_CSUM is not negotiated. This is
> > > > > > > > not a bug, as the driver has always done this.
> > > > > > > >
> > > > > > > > Fixes: 436c9453a1ac ("virtio-net: keep vnet header zeroed after processing XDP")
> > > > > > > > Signed-off-by: Heng Qi <hengqi@linux.alibaba.com>
> > > > > > > > ---
> > > > > > > >  drivers/net/virtio_net.c | 20 +++++++++++++++++++-
> > > > > > > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > > > > > > >
> > > > > > > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > > > > > > index aa70a7ed8072..ea10db9a09fa 100644
> > > > > > > > --- a/drivers/net/virtio_net.c
> > > > > > > > +++ b/drivers/net/virtio_net.c
> > > > > > > > @@ -1360,6 +1360,10 @@ static struct sk_buff *receive_small_xdp(struct net_device *dev,
> > > > > > > >         if (unlikely(hdr->hdr.gso_type))
> > > > > > > >                 goto err_xdp;
> > > > > > > >
> > > > > > > > +       /* Partially checksummed packets must be dropped. */
> > > > > > > > +       if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> > > > > > > > +               goto err_xdp;
> > > > > > > > +
> > > > > > > >         buflen = SKB_DATA_ALIGN(GOOD_PACKET_LEN + headroom) +
> > > > > > > >                 SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> > > > > > > >
> > > > > > > > @@ -1677,6 +1681,10 @@ static void *mergeable_xdp_get_buf(struct virtnet_info *vi,
> > > > > > > >         if (unlikely(hdr->hdr.gso_type))
> > > > > > > >                 return NULL;
> > > > > > > >
> > > > > > > > +       /* Partially checksummed packets must be dropped. */
> > > > > > > > +       if (unlikely(hdr->hdr.flags & VIRTIO_NET_HDR_F_NEEDS_CSUM))
> > > > > > > > +               return NULL;
> > > > > > > > +
> > > > > > > >         /* Now XDP core assumes frag size is PAGE_SIZE, but buffers
> > > > > > > >          * with headroom may add hole in truesize, which
> > > > > > > >          * make their length exceed PAGE_SIZE. So we disabled the
> > > > > > > > @@ -1943,6 +1951,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > > > > > > >         struct net_device *dev = vi->dev;
> > > > > > > >         struct sk_buff *skb;
> > > > > > > >         struct virtio_net_common_hdr *hdr;
> > > > > > > > +       u8 flags;
> > > > > > > >
> > > > > > > >         if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> > > > > > > >                 pr_debug("%s: short packet %i\n", dev->name, len);
> > > > > > > > @@ -1951,6 +1960,15 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > > > > > > >                 return;
> > > > > > > >         }
> > > > > > > >
> > > > > > > > +       /* 1. Save the flags early, as the XDP program might overwrite them.
> > > > > > > > +        * These flags ensure packets marked as VIRTIO_NET_HDR_F_DATA_VALID
> > > > > > > > +        * stay valid after XDP processing.
> > > > > > > > +        * 2. XDP doesn't work with partially checksummed packets (refer to
> > > > > > > > +        * virtnet_xdp_set()), so packets marked as
> > > > > > > > +        * VIRTIO_NET_HDR_F_NEEDS_CSUM get dropped during XDP processing.
> > > > > > > > +        */
> > > > > > > > +       flags = ((struct virtio_net_common_hdr *)buf)->hdr.flags;
> > > > > > > > +
> > > > > > > >         if (vi->mergeable_rx_bufs)
> > > > > > > >                 skb = receive_mergeable(dev, vi, rq, buf, ctx, len, xdp_xmit,
> > > > > > > >                                         stats);
> > > > > > > > @@ -1966,7 +1984,7 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > > > > > > >         if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> > > > > > > >                 virtio_skb_set_hash(&hdr->hash_v1_hdr, skb);
> > > > > > > >
> > > > > > > > -       if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > > > > > > > +       if (flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > > > > > > >                 skb->ip_summed = CHECKSUM_UNNECESSARY;
> > > > > > > >
> > > > > > > >         if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > > > > > > > --
> > > > > > > > 2.32.0.3.g01195cf9f
> > > > > > > >
> > > > > > >
> > > > > >
> > > > > 
> > > 
> > 


