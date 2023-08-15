Return-Path: <netdev+bounces-27724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E998477D01B
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 18:29:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D4F491C20D76
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 16:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2578156C4;
	Tue, 15 Aug 2023 16:29:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E6112B98
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 16:29:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11B2BC433C7;
	Tue, 15 Aug 2023 16:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692116948;
	bh=krOcIuYg6hTWBjxkHEr41A9L5hn7EMMeN3KZMz9T4/s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YCy8JKSO1z40r0lqXc5NJ4zx1Hau50O6Va6z+rH9c25QJ8IwxSTLUjzw24S+Y/LkE
	 YQmKU1N2xE3wgbSS8yqsYMncYfoSjtAbL1CufmXrTq5Ep3ER8MGlvYeLU9fA8jKlue
	 ZrpR9KHOBf1WKRaWAA7xg+q6Hxdmzna603eGjrnnHYSapnftb37cailf8E4zqynBoD
	 8nA9Z47QZDc7RuBaSWEtIsbSJ6TKHhLZxa9Eot///l+/8GrJdz14GPNMyVLqwtTCTe
	 Bhifeo1e5KpqqH0peU+/C1ZZo79+Ibp9NjzuzgKvB4HTHzn8Y45CWfkXhIs+mwk7sm
	 GIf8brhD1ra+g==
Date: Tue, 15 Aug 2023 18:29:03 +0200
From: Simon Horman <horms@kernel.org>
To: Feng Liu <feliu@nvidia.com>
Cc: Simon Horman <horms@kernel.org>,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net v1] virtio_net: Introduce skb_vnet_common_hdr to
 avoid typecasting
Message-ID: <ZNunz1hbqPKpcOgA@vergenet.net>
References: <20230814171845.65930-1-feliu@nvidia.com>
 <ZNtYpohWyjnb883M@vergenet.net>
 <05348d62-586c-4b1f-40bd-5541caca0947@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05348d62-586c-4b1f-40bd-5541caca0947@nvidia.com>

On Tue, Aug 15, 2023 at 11:09:02AM -0400, Feng Liu wrote:
> 
> 
> On 2023-08-15 a.m.6:51, Simon Horman wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Mon, Aug 14, 2023 at 01:18:45PM -0400, Feng Liu wrote:
> > 
> > + "David S. Miller" <davem@davemloft.net>
> >    Eric Dumazet <edumazet@google.com>
> >    Jakub Kicinski <kuba@kernel.org>
> >    Paolo Abeni <pabeni@redhat.com>
> > 
> Thanks for adding David S. Miller.
> 
> > > The virtio_net driver currently deals with different versions and types
> > > of virtio net headers, such as virtio_net_hdr_mrg_rxbuf,
> > > virtio_net_hdr_v1_hash, etc. Due to these variations, the code relies
> > > on multiple type casts to convert memory between different structures,
> > > potentially leading to bugs when there are changes in these structures.
> > > 
> > > Introduces the "struct skb_vnet_common_hdr" as a unifying header
> > > structure using a union. With this approach, various virtio net header
> > > structures can be converted by accessing different members of this
> > > structure, thus eliminating the need for type casting and reducing the
> > > risk of potential bugs.
> > > 
> > > For example following code:
> > > static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> > >                struct receive_queue *rq,
> > >                struct page *page, unsigned int offset,
> > >                unsigned int len, unsigned int truesize,
> > >                unsigned int headroom)
> > > {
> > > [...]
> > >        struct virtio_net_hdr_mrg_rxbuf *hdr;
> > > [...]
> > >        hdr_len = vi->hdr_len;
> > > [...]
> > > ok:
> > >        hdr = skb_vnet_hdr(skb);
> > >        memcpy(hdr, hdr_p, hdr_len);
> > > [...]
> > > }
> > > 
> > > When VIRTIO_NET_F_HASH_REPORT feature is enabled, hdr_len = 20
> > > But the sizeof(*hdr) is 12,
> > > memcpy(hdr, hdr_p, hdr_len); will copy 20 bytes to the hdr,
> > > which make a potential risk of bug. And this risk can be avoided by
> > > introducing struct virtio_net_hdr_mrg_rxbuf.
> > > 
> > > Signed-off-by: Feng Liu <feliu@nvidia.com>
> > > Reviewed-by: Jiri Pirko <jiri@nvidia.com>
> > 
> > I'm unsure if this is 'net' material.
> > 
> 
> It is about the modification of the virtio_net driver. I think it should be
> regarded as `net` material.

To clarify: In general new Networking features go via the net-next tree,
while bug fixes go via the net tree. I was suggesting this
is more appropriate for net-next, and that should be reflected in the
subject.

	Subject: [PATCH net-next] ...

Sorry for not being clearer the first time around.

> 
> > > ---
> > >   drivers/net/virtio_net.c        | 29 ++++++++++++++++-------------
> > >   include/uapi/linux/virtio_net.h |  7 +++++++
> > >   2 files changed, 23 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 1270c8d23463..6ce0fbcabda9 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -344,9 +344,10 @@ static int rxq2vq(int rxq)
> > >        return rxq * 2;
> > >   }
> > > 
> > > -static inline struct virtio_net_hdr_mrg_rxbuf *skb_vnet_hdr(struct sk_buff *skb)
> > > +static inline struct virtio_net_common_hdr *
> > > +skb_vnet_common_hdr(struct sk_buff *skb)
> > >   {
> > > -     return (struct virtio_net_hdr_mrg_rxbuf *)skb->cb;
> > > +     return (struct virtio_net_common_hdr *)skb->cb;
> > >   }
> > > 
> > >   /*
> > > @@ -469,7 +470,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> > >                                   unsigned int headroom)
> > >   {
> > >        struct sk_buff *skb;
> > > -     struct virtio_net_hdr_mrg_rxbuf *hdr;
> > > +     struct virtio_net_common_hdr *hdr;
> > >        unsigned int copy, hdr_len, hdr_padded_len;
> > >        struct page *page_to_free = NULL;
> > >        int tailroom, shinfo_size;
> > > @@ -554,7 +555,7 @@ static struct sk_buff *page_to_skb(struct virtnet_info *vi,
> > >                give_pages(rq, page);
> > > 
> > >   ok:
> > > -     hdr = skb_vnet_hdr(skb);
> > > +     hdr = skb_vnet_common_hdr(skb);
> > >        memcpy(hdr, hdr_p, hdr_len);
> > >        if (page_to_free)
> > >                put_page(page_to_free);
> > > @@ -966,7 +967,7 @@ static struct sk_buff *receive_small_build_skb(struct virtnet_info *vi,
> > >                return NULL;
> > > 
> > >        buf += header_offset;
> > > -     memcpy(skb_vnet_hdr(skb), buf, vi->hdr_len);
> > > +     memcpy(skb_vnet_common_hdr(skb), buf, vi->hdr_len);
> > > 
> > >        return skb;
> > >   }
> > > @@ -1577,7 +1578,8 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > >   {
> > >        struct net_device *dev = vi->dev;
> > >        struct sk_buff *skb;
> > > -     struct virtio_net_hdr_mrg_rxbuf *hdr;
> > > +     struct virtio_net_common_hdr *common_hdr;
> > > +     struct virtio_net_hdr_mrg_rxbuf *mrg_hdr;
> > > 
> > >        if (unlikely(len < vi->hdr_len + ETH_HLEN)) {
> > >                pr_debug("%s: short packet %i\n", dev->name, len);
> > > @@ -1597,18 +1599,19 @@ static void receive_buf(struct virtnet_info *vi, struct receive_queue *rq,
> > >        if (unlikely(!skb))
> > >                return;
> > > 
> > > -     hdr = skb_vnet_hdr(skb);
> > > +     common_hdr = skb_vnet_common_hdr(skb);
> > >        if (dev->features & NETIF_F_RXHASH && vi->has_rss_hash_report)
> > > -             virtio_skb_set_hash((const struct virtio_net_hdr_v1_hash *)hdr, skb);
> > > +             virtio_skb_set_hash(&common_hdr->hash_v1_hdr, skb);
> > > 
> > > -     if (hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > > +     mrg_hdr = &common_hdr->mrg_hdr;
> > > +     if (mrg_hdr->hdr.flags & VIRTIO_NET_HDR_F_DATA_VALID)
> > >                skb->ip_summed = CHECKSUM_UNNECESSARY;
> > > 
> > > -     if (virtio_net_hdr_to_skb(skb, &hdr->hdr,
> > > +     if (virtio_net_hdr_to_skb(skb, &mrg_hdr->hdr,
> > >                                  virtio_is_little_endian(vi->vdev))) {
> > >                net_warn_ratelimited("%s: bad gso: type: %u, size: %u\n",
> > > -                                  dev->name, hdr->hdr.gso_type,
> > > -                                  hdr->hdr.gso_size);
> > > +                                  dev->name, mrg_hdr->hdr.gso_type,
> > > +                                  mrg_hdr->hdr.gso_size);
> > >                goto frame_err;
> > >        }
> > > 
> > > @@ -2105,7 +2108,7 @@ static int xmit_skb(struct send_queue *sq, struct sk_buff *skb)
> > >        if (can_push)
> > >                hdr = (struct virtio_net_hdr_mrg_rxbuf *)(skb->data - hdr_len);
> > >        else
> > > -             hdr = skb_vnet_hdr(skb);
> > > +             hdr = &skb_vnet_common_hdr(skb)->mrg_hdr;
> > > 
> > >        if (virtio_net_hdr_from_skb(skb, &hdr->hdr,
> > >                                    virtio_is_little_endian(vi->vdev), false,
> > > diff --git a/include/uapi/linux/virtio_net.h b/include/uapi/linux/virtio_net.h
> > > index 12c1c9699935..db40f93ae8b3 100644
> > > --- a/include/uapi/linux/virtio_net.h
> > > +++ b/include/uapi/linux/virtio_net.h
> > > @@ -201,6 +201,13 @@ struct virtio_net_hdr_mrg_rxbuf {
> > >        struct virtio_net_hdr hdr;
> > >        __virtio16 num_buffers; /* Number of merged rx buffers */
> > >   };
> > > +
> > > +struct virtio_net_common_hdr {
> > > +     union {
> > > +             struct virtio_net_hdr_mrg_rxbuf mrg_hdr;
> > > +             struct virtio_net_hdr_v1_hash hash_v1_hdr;
> > > +     };
> > > +};
> > 
> > Does this belong in the UAPI?
> > I would have assumed it's a Kernel implementation detail.
> > 
> The existing codes, virtio_net.h is in uapi/linux/, I added the new
> structure and followed existing code. My modification is related to Kernel
> implementation detail now.

The header you have modified forms part of the userspace API (UAPI).
Perhaps there is something about virtio_net that makes this correct, but it
seems to me that kernel-internal details don't belong there. 

> 
> > >   #endif /* ...VIRTIO_NET_NO_LEGACY */
> > > 
> > >   /*
> > > --
> > > 2.37.1 (Apple Git-137.1)
> > > 
> > > 
> 

