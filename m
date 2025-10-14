Return-Path: <netdev+bounces-229023-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9975BD722E
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 05:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A10C64E0F6D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 03:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D02925D1E9;
	Tue, 14 Oct 2025 03:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XVm3JBGW"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D54F1E990E
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 03:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760411121; cv=none; b=qCjsT9ub5w1orVMrw4jyqvTS+o3cVucfMvYK/qzEAHxO7vU7OE7x3MWZIJa8uQX9aTghMS+WXs8jRVZcW7XBTLIwHIxN7LpUxpf/1H5uny3kOa2uHhSlBLix6K30ueIQMxl9/kAP8mtpSKzV1tkhN5UBkA4dhfuHzwcOnBspBwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760411121; c=relaxed/simple;
	bh=2zFXF2f99jKId4gKPdq3erUBauFqlQjsWc/vhzPoVqc=;
	h=Message-ID:Subject:Date:From:To:Cc:References:In-Reply-To; b=IlEdaJ0iZ8b7T0FZZpuTciPNWBNEkVxkDeS8kFDpqEM6wieCQ7KPqyNA3YPMCNcKrfASHSUlaDA1YKibCQfZnA2IvVVya2yI6hA5OTKD25st+oLoHcvNsnp236AGAMbBoF9uLwni3RuN+a3MnjOL8HKsETNbdOHAtdjyz6G1ZIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XVm3JBGW; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1760411115; h=Message-ID:Subject:Date:From:To;
	bh=2AvOauspF847lpGez8fmTz8kAejFlW/772jQBolRogg=;
	b=XVm3JBGWnQMAchEQx9bkYeh9rugqWXobGkNxJBaIV+6ClcBZqo0rO/yZ8HGjJ+z8FQLabyLy4UK61T8OrSZ8gVYenir1dQYo4CoMK3FdFgZ4csyjjbKEN6nMfXhtgEWa8yR6j4yMwucS54PTM2Tpmnh8N7P+qwyB+KcmkSHGh+8=
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com fp:SMTPD_---0WqA2mqb_1760410798 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 14 Oct 2025 10:59:59 +0800
Message-ID: <1760410698.4630306-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net v2 3/3] virtio-net: correct hdr_len handling for tunnel gso
Date: Tue, 14 Oct 2025 10:58:18 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>,
 Willem de Bruijn <willemb@google.com>,
 Jiri Pirko <jiri@resnulli.us>,
 Alvaro Karsz <alvaro.karsz@solid-run.com>,
 Heng Qi <hengqi@linux.alibaba.com>,
 virtualization@lists.linux.dev,
 netdev@vger.kernel.org
References: <20251013020629.73902-1-xuanzhuo@linux.alibaba.com>
 <20251013020629.73902-4-xuanzhuo@linux.alibaba.com>
 <27931e85-451f-4711-9681-38db2563efc2@redhat.com>
In-Reply-To: <27931e85-451f-4711-9681-38db2563efc2@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

On Mon, 13 Oct 2025 10:11:31 +0200, Paolo Abeni <pabeni@redhat.com> wrote:
> On 10/13/25 4:06 AM, Xuan Zhuo wrote:
> > The commit a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP
> > GSO tunneling.") introduces support for the UDP GSO tunnel feature in
> > virtio-net.
> >
> > The virtio spec says:
> >
> >     If the \field{gso_type} has the VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV4 bit or
> >     VIRTIO_NET_HDR_GSO_UDP_TUNNEL_IPV6 bit set, \field{hdr_len} accounts for
> >     all the headers up to and including the inner transport.
> >
> > The commit did not update the hdr_len to include the inner transport.
> >
> > Fixes: a2fb4bc4e2a6a03 ("net: implement virtio helpers to handle UDP GSO tunneling.")
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> Side note: qemu support for UDP GSO tunneling is available in qemu since
> commit a5289563ad.
>
> > ---
> >  include/linux/virtio_net.h | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/include/linux/virtio_net.h b/include/linux/virtio_net.h
> > index e059e9c57937..765fd5f471a4 100644
> > --- a/include/linux/virtio_net.h
> > +++ b/include/linux/virtio_net.h
> > @@ -403,6 +403,7 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
> >  	struct virtio_net_hdr *hdr = (struct virtio_net_hdr *)vhdr;
> >  	unsigned int inner_nh, outer_th;
> >  	int tnl_gso_type;
> > +	u16 hdr_len;
> >  	int ret;
> >
> >  	tnl_gso_type = skb_shinfo(skb)->gso_type & (SKB_GSO_UDP_TUNNEL |
> > @@ -434,6 +435,23 @@ virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
> >  	outer_th = skb->transport_header - skb_headroom(skb);
> >  	vhdr->inner_nh_offset = cpu_to_le16(inner_nh);
> >  	vhdr->outer_th_offset = cpu_to_le16(outer_th);
> > +
> > +	switch (skb->inner_ipproto) {
> > +	case IPPROTO_TCP:
> > +		hdr_len = inner_tcp_hdrlen(skb);
> > +		break;
> > +
> > +	case IPPROTO_UDP:
> > +		hdr_len = sizeof(struct udphdr);
> > +		break;
> > +
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	hdr_len += skb_inner_transport_offset(skb);
> > +	hdr->hdr_len = __cpu_to_virtio16(little_endian, hdr_len);
>
> I'm not sure this is the correct fix.
>
> virtio_net_hdr_tnl_from_skb() just called virtio_net_hdr_from_skb() on
> the inner header. The virtio spec also specifies:
>
> """
>  If the VIRTIO_NET_F_GUEST_HDRLEN feature has been negotiated,
>  \field{hdr_len} indicates the header length that needs to be replicated
>  for each packet. It's the number of bytes from the beginning of the packet
>  to the beginning of the transport payload.
> """
>
> If `hdr_len` is currently wrong for UDP GSO packets, it's also wrong for
>  plain GSO packets (without UDP tunnel) and the its value should be
> possibly fixed in virtio_net_hdr_from_skb().

YES. This is what the commit #2 does.

Thanks.


>
> Thanks,
>
> Paolo
>

