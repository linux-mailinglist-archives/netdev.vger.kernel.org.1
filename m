Return-Path: <netdev+bounces-143665-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E476E9C38E9
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 08:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7771C282151
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 07:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ADB154BFF;
	Mon, 11 Nov 2024 07:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKRAjz/e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5B34D8CB;
	Mon, 11 Nov 2024 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731309364; cv=none; b=lHP8fBo2adD+YZspF+nuni/dGA9o91qkcgM86gPEH7BRALC3GhzQzC14mWwrtaDVkcx+GyfKBZn6AYMqudEHToBvfAGHilsYtlW+4qyNgIyWQxwR2BnC7YPay2BOlGt6VKsy4SgkBA/OR0a1mVUtWfinOauj49EWALbkuH/RpqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731309364; c=relaxed/simple;
	bh=MtbNoPkZSP3Y5Njy2K7u2mmx90uqChP6O2cN6ABOIcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fmrUSy7GaNunSR0bOawO72MgaevHwlH+OFdvE0+paeulfkMLlQOm56YnKYyuwfthIAsSxkAK5osMEpeJiujaK3OXHdfEaQvc2Uu/Y1iqJ8l+34rEWlpE8S8VuUyNVdFfQptWRyioVnaAnUItmys8Td7ZUKbXKpitUWepFvW/J3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKRAjz/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39712C4CED0;
	Mon, 11 Nov 2024 07:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731309363;
	bh=MtbNoPkZSP3Y5Njy2K7u2mmx90uqChP6O2cN6ABOIcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XKRAjz/eahDUknMWLtvCROrA12ro063hkF5u7Z8mH9CIHSXM/0FASrJmh9SZdLOam
	 jWOUohZiomsyOezExQ7XjW4020b2zig53RdHLNoZfxAy3r8cCCBUYcRPwIhxdfga+6
	 QpRL/YrKcgHYh9Ud5UwL8YyCpPocVyZbPkhjPi75xg/3ME962jri9lcEttZDJRrksf
	 +xuJXVXjXghtOP4hbSNAnfuq65Eo3xIxH/nWuiDPGGXHLZc3KUv8RtWpbGwFOrtVdR
	 k+/SxqLtR1LdyKAMTRpeNBmnWXeXWDnXyQ55d0cxLc4JRJEDAvoZnVMbqH4ulVQpMd
	 z7+upqXVQEqqQ==
Date: Mon, 11 Nov 2024 09:15:56 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Bharat Bhushan <bharatb.linux@gmail.com>
Cc: Bharat Bhushan <bbhushan2@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, sgoutham@marvell.com,
	gakula@marvell.com, sbhatta@marvell.com, hkelam@marvell.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, jerinj@marvell.com, lcherian@marvell.com,
	ndabilpuram@marvell.com, sd@queasysnail.net
Subject: Re: [net-next PATCH v9 1/8] octeontx2-pf: map skb data as device
 writeable
Message-ID: <20241111071556.GB71181@unreal>
References: <20241108045708.1205994-1-bbhushan2@marvell.com>
 <20241108045708.1205994-2-bbhushan2@marvell.com>
 <20241110142303.GA50588@unreal>
 <CAAeCc_nPP7FU7KUZoW+9AVPdaqTpVopEKQGVpzHgXkBUzfa1xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAeCc_nPP7FU7KUZoW+9AVPdaqTpVopEKQGVpzHgXkBUzfa1xQ@mail.gmail.com>

On Mon, Nov 11, 2024 at 10:31:02AM +0530, Bharat Bhushan wrote:
> On Sun, Nov 10, 2024 at 7:53 PM Leon Romanovsky <leon@kernel.org> wrote:
> >
> > On Fri, Nov 08, 2024 at 10:27:01AM +0530, Bharat Bhushan wrote:
> > > Crypto hardware need write permission for in-place encrypt
> > > or decrypt operation on skb-data to support IPsec crypto
> > > offload. That patch uses skb_unshare to make skb data writeable
> > > for ipsec crypto offload and map skb fragment memory as
> > > device read-write.
> > >
> > > Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
> > > ---
> > > v7->v8:
> > >  - spell correction (s/sdk/skb) in description
> > >
> > > v6->v7:
> > >  - skb data was mapped as device writeable but it was not ensured
> > >    that skb is writeable. This version calls skb_unshare() to make
> > >    skb data writeable.
> > >
> > >  .../ethernet/marvell/octeontx2/nic/otx2_txrx.c | 18 ++++++++++++++++--
> > >  1 file changed, 16 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > > index 7aaf32e9aa95..49b6b091ba41 100644
> > > --- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
> > > @@ -11,6 +11,7 @@
> > >  #include <linux/bpf.h>
> > >  #include <linux/bpf_trace.h>
> > >  #include <net/ip6_checksum.h>
> > > +#include <net/xfrm.h>
> > >
> > >  #include "otx2_reg.h"
> > >  #include "otx2_common.h"
> > > @@ -83,10 +84,17 @@ static unsigned int frag_num(unsigned int i)
> > >  static dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
> > >                                       struct sk_buff *skb, int seg, int *len)
> > >  {
> > > +     enum dma_data_direction dir = DMA_TO_DEVICE;
> > >       const skb_frag_t *frag;
> > >       struct page *page;
> > >       int offset;
> > >
> > > +     /* Crypto hardware need write permission for ipsec crypto offload */
> > > +     if (unlikely(xfrm_offload(skb))) {
> > > +             dir = DMA_BIDIRECTIONAL;
> > > +             skb = skb_unshare(skb, GFP_ATOMIC);
> > > +     }
> > > +
> > >       /* First segment is always skb->data */
> > >       if (!seg) {
> > >               page = virt_to_page(skb->data);
> > > @@ -98,16 +106,22 @@ static dma_addr_t otx2_dma_map_skb_frag(struct otx2_nic *pfvf,
> > >               offset = skb_frag_off(frag);
> > >               *len = skb_frag_size(frag);
> > >       }
> > > -     return otx2_dma_map_page(pfvf, page, offset, *len, DMA_TO_DEVICE);
> > > +     return otx2_dma_map_page(pfvf, page, offset, *len, dir);
> >
> > Did I read correctly and you perform DMA mapping on every SKB in data path?
> > How bad does it perform if you enable IOMMU?
> 
> Yes Leon, currently DMA mapping is done with each SKB, That's true
> even with non-ipsec cases.
> Performance is not good with IOMMU enabled. Given the context of this
> series, it just extends the same for ipsec use cases.

I know and I don't ask to change anything, just really curious how
costly this implementation is when IOMMU enabled.

Thanks

> 
> Thanks
> -Bharat
> 
> >
> > Thanks
> >
> > >  }
> > >
> > >  static void otx2_dma_unmap_skb_frags(struct otx2_nic *pfvf, struct sg_list *sg)
> > >  {
> > > +     enum dma_data_direction dir = DMA_TO_DEVICE;
> > > +     struct sk_buff *skb = NULL;
> > >       int seg;
> > >
> > > +     skb = (struct sk_buff *)sg->skb;
> > > +     if (unlikely(xfrm_offload(skb)))
> > > +             dir = DMA_BIDIRECTIONAL;
> > > +
> > >       for (seg = 0; seg < sg->num_segs; seg++) {
> > >               otx2_dma_unmap_page(pfvf, sg->dma_addr[seg],
> > > -                                 sg->size[seg], DMA_TO_DEVICE);
> > > +                                 sg->size[seg], dir);
> > >       }
> > >       sg->num_segs = 0;
> > >  }
> > > --
> > > 2.34.1
> > >
> > >
> >

