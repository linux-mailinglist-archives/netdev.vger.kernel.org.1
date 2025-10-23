Return-Path: <netdev+bounces-231923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AB88BFEB3E
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 02:09:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99BBB3A3951
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 00:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EA115E97;
	Thu, 23 Oct 2025 00:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GFQKLLtt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1982FEACD;
	Thu, 23 Oct 2025 00:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761178152; cv=none; b=jrJeGTumqZIP/nEHS3sObuoWud7gO0P/VI0/wdiD/Zw/S1y1LD/XQik5/zXSvAsE5m4aiXUiu7F1tmyOgUZTlcAQb6e9aj5bXugBbE0gjCZhV0msv16iOiSGR71Uj6yqdmsbOm29MwGknJ75Y2Ya40+59j5VJMf2dGVMYSSMays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761178152; c=relaxed/simple;
	bh=vCz8WiAq/PiG2iOCDmerY0sUy0nHqJY1FRkBgAlBoEQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iMC10QHjbwo4UAtSRcX28SlzKdCNOqpDjORP0cH9L6NWXgfy2a8B9Ubpkutca0KSF4OJ3A08IEIgWOVHw9E4shypdpLSF+/g65bLiE1yUYhCwPr2wbVmF8j26RlHX4xAE5RNeTAqncpMJhouPEFYLyXPIP6TX8ULNTmIpVQyod4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GFQKLLtt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B650C4CEE7;
	Thu, 23 Oct 2025 00:09:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761178152;
	bh=vCz8WiAq/PiG2iOCDmerY0sUy0nHqJY1FRkBgAlBoEQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GFQKLLtt4hSpToub39Br6yoKbtONyv6XQOSOd+0sSIzW0KG96XK8TCXqg4ac131io
	 TNFMvfyoWS5K5aEJAzxCfD8qHLfqpHlLoeF6i0IrGmBgZc11/sz5+X0vL8PHPPHJpC
	 hT536r2JXoeYKlC3xMVFhlrjk23FMTqKyHR7qvBCd46EQwarSEK4CRAYHZzXRhgKfo
	 tejGhaIawfC7amIheQT5JdCWBuxLtnxyamJHizG4XkmgUbGZVPNEwOLP/Dt+3hsohk
	 aDwTcY6Ock7QPQwTsPH/Hi6J4fe2M9i62KQ9AsWPnswp5jxKzB3C3jNxQzwJE9UTdD
	 YlPnzmZVwanBg==
Date: Wed, 22 Oct 2025 17:09:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Mina Almasry <almasrymina@google.com>, Pavel Begunkov
 <asml.silence@gmail.com>, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald
 Hunter <donald.hunter@gmail.com>, Michael Chan <michael.chan@broadcom.com>,
 Pavan Chebbi <pavan.chebbi@broadcom.com>, Jesper Dangaard Brouer
 <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Joshua Washington <joshwash@google.com>,
 Harshitha Ramamurthy <hramamurthy@google.com>, Jian Shen
 <shenjian15@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Jijie Shao
 <shaojijie@huawei.com>, Sunil Goutham <sgoutham@marvell.com>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 hariprasad <hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark
 Bloch <mbloch@nvidia.com>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>, Joe
 Damato <joe@dama.to>, David Wei <dw@davidwei.uk>, Willem de Bruijn
 <willemb@google.com>, Breno Leitao <leitao@debian.org>,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, Jonathan Corbet
 <corbet@lwn.net>
Subject: Re: [PATCH net-next v4 00/24][pull request] Queue configs and large
 buffer providers
Message-ID: <20251022170909.70f1d1e7@kernel.org>
In-Reply-To: <avwfxfpogp7u7ef5wqrfkqsgvzmnytxblwul7e53eaje3zyqyc@7wvlrocyre6j>
References: <cover.1760364551.git.asml.silence@gmail.com>
	<20251013105446.3efcb1b3@kernel.org>
	<CAHS8izOupVhkaZXNDmZo8KzR42M+rxvvmmLW=9r3oPoNOC6pkQ@mail.gmail.com>
	<20251014184119.3ba2dd70@kernel.org>
	<CAHS8izOnzxbSuW5=aiTAUja7D2ARgtR13qYWr-bXNYSCvm5Bbg@mail.gmail.com>
	<20251016184031.66c92962@kernel.org>
	<avwfxfpogp7u7ef5wqrfkqsgvzmnytxblwul7e53eaje3zyqyc@7wvlrocyre6j>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 22 Oct 2025 13:17:43 +0000 Dragos Tatulea wrote:
> On Thu, Oct 16, 2025 at 06:40:31PM -0700, Jakub Kicinski wrote:
> > On Wed, 15 Oct 2025 10:44:19 -0700 Mina Almasry wrote:  
> > > I think what you're saying is what I was trying to say, but you said
> > > it more eloquently and genetically correct. I'm not familiar with the
> > > GRO packing you're referring to so. I just assumed the 'buffer sizes
> > > actually posted to the NIC' are the 'buffer sizes we end up seeing in
> > > the skb frags'.  
> > 
> > I don't think that code path exists today, buffers posted are frags
> > in the skb. But that's easily fixable.
> >   
> > > I guess what I'm trying to say in a different way, is: there are lots
> > > of buffer sizes in the rx path, AFAICT, at least:
> > > 
> > > 1. The size of the allocated netmems from the pp.
> > > 2. The size of the buffers posted to the NIC (which will be different
> > > from #1 if the page_pool_fragment_netmem or some other trick like
> > > hns3).
> > > 3. The size of the frags that end up in the skb (which will be
> > > different from #2 for GRO/other things I don't fully understand).
> > > 
> > > ...and I'm not sure what rx-buf-len should actually configure. My
> > > thinking is that it probably should configure #3, since that is what
> > > the user cares about, I agree with that.
> > > 
> > > IIRC when I last looked at this a few weeks ago, I think as written
> > > this patch series makes rx-buf-len actually configure #1.  
> > 
> > #1 or #2. #1 for otx2. For the RFC bnxt implementation they were
> > equivalent. But hns3's reading would be that it's #2.
> > 
> > From user PoV neither #1 nor #2 is particularly meaningful.
> > Assuming driver can fragment - #1 only configures memory accounting
> > blocks. #2 configures buffers passed to the HW, but some HW can pack
> > payloads into a single buf to save memory. Which means that if previous
> > frame was small and ate some of a page, subsequent large frame of
> > size M may not fit into a single buf of size X, even if M < X.
> > 
> > So I think the full set of parameters we should define would be
> > what you defined as #1 and #2. And on top of that we need some kind of
> > min alignment enforcement. David Wei mentioned that one of his main use
> > cases is ZC of a buffer which is then sent to storage, which has strict
> > alignment requirements. And some NICs will internally fragment the
> > page.. Maybe let's define the expected device behavior..
> > 
> > Device models
> > =============
> > Assume we receive 2 5kB packets, "x" means bytes from first packet,
> > "y" means bytes from the second packet.
> > 
> > A. Basic-scatter
> > ----------------
> > Packet uses one or more buffers, so 1:n mapping between packets and
> > buffers.
> >                        unused space
> >                       v
> >  1kB      [xx] [xx] [x ] [yy] [yy] [y ]
> > 16kB      [xxxxx            ] [yyyyy             ]
> > 
> > B. Multi-packet
> > ---------------
> > The configurations above are still possible, but we can configure 
> > the device to place multiple packets in a large page:
> >  
> >                  unused space
> >                 v
> > 16kB, 2kB [xxxxx |yyyyy |...] [..................]
> >       ^
> >       alignment / stride
> > 
> > We can probably assume that this model always comes with alignment
> > cause DMA'ing frames at odd offsets is a bad idea. And also note
> > that packets smaller that alignment can get scattered to multiple
> > bufs.
> > 
> > C. Multi-packet HW-GRO
> > ----------------------
> > For completeness, I guess. We need a third packet here. Assume x-packet
> > and z-packet are from the same flow and GRO session, y-packet is not.
> > (Good?) HW-GRO gives us out of order placement and hopefully in this
> > case we do want to pack:
> > 
> > 16kB, 2kB [xxxxxzzzzz |.......] [xxxxx.............]
> >                      ^
> >       alignment / stride
> >   
>                                    ^^^^^
>                                    is this y?

Yes, my bad

> Not sure I understand this last representation: if x and z are 5kB
> packets each and the stride size is 2kB, they should occupy 5 strides:
> 
> 16kB, 2kB [xx|xx|xz|zz|zz|.......] [yy|yy|y |............]
> 
> I think I understand the point, just making sure that I got it straight.
> Did I?

Yes, that's right. I was trying to (poorly) express that the alignment
is not:

  16kB, 2kB [xx|xx|x |zz|zz|z |.....] [yy|yy|y |............]

IOW that HW-GRO is expected to pack (at least by default).

> > End of sidebar. I think / hope these are all practical buffer layouts
> > we need to care about.
> > 
> > 
> > What does user care about? Presumably three things:
> >  a) efficiency of memory use (larger pages == more chance of low fill)
> >  b) max size of a buffer (larger buffer = fewer iovecs to pass around)
> >  c) alignment
> > I don't think we can make these map 1:1 to any of the knobs we discussed
> > at the start. (b) is really neither #1 (if driver fragments) nor #2 (if
> > SW GRO can glue back together).
> > 
> > We could simply let the user control #1 - basically user control
> > overrides the places where driver would previously use PAGE_SIZE.
> > I think this is what Stan suggested long ago as well.
> >
> > But I wonder if user still needs to know #2 (rx-buf-len) because
> > practically speaking, setting page size >4x the size of rx-buf-len
> > is likely a lot more fragmentation for little extra aggregation.. ?  
> So how would rx-buf-len be configured then? Who gets to decide if not the
> user: the driver or the kernel?

Driver.

> I don't understand what you mean by "setting page size >4x the size of
> rx-buf-len". I thought it was the other way around: rx-buf-len is an
> order of page size. Or am I stuck in the mindset of the old proposal?

Yes, rx-buf-len is a good match for model A (basic-scatter).
But in other models it becomes a bit difficult to define the exact
semantics. 

> > Tho, admittedly I think user only needs to know max-rx-buf-len
> > not necessarily set it.
> > 
> > The last knob is alignment / reuse. For allowing multiple packets in
> > one buffer we probably need to distinguish these cases to cater to
> > sufficiently clever adapters:
> >  - previous and next packets are from the same flow and
> >    - within one GRO session
> >    - previous had PSH set (or closed the GRO for another reason,
> >      this is to allow realigning the buffer on GRO session close)
> >   or
> >    - the device doesn't know further distinctions / HW-GRO
> >  - previous and next are from different flows
> > And the actions (for each case separately) are one of:
> >  - no reuse allowed (release buffer = -1?)
> >  - reuse but must align (align to = N)
> >  - reuse don't align (pack = 0)
> >   
> I am assuming that different HW will support a subset of these
> actions and/or they will apply differently in each case (hence the 4
> knobs?).

Yup! All the knobs are optional, we can also define extra ones if use
cases come up and HW can support it. Hopefully we can get selftests 
to validate the devices behave as configured.

> For example, in mlx5 the actions would work only for the second case
> (at the end of a GRO session).

Nice, I think that's the most useful one.

Not sure whether we should define all 4 from the start, or just
document them as a "plan", what the implicit default is expected 
to be (e.g. HW-GRO packs within a session) and then add as HW/users 
come around.

> > So to restate do we need:
> >  - "page order" control
> >  - max-rx-buf-len
> >  - 4 alignment knobs?
> >  
> We do need at least 1 alignment knob.
> 
> > Corner cases
> > ============
> > I. Non-power of 2 buffer sizes
> > ------------------------------
> > Looks like multiple devices are limited by width of length fields,
> > making max buffer size something like 32kB - 1 or 64kB - 1.
> > Should we allow applications to configure the buffer to 
> > 
> >     power of 2 - alignment 
> > 
> > ? It will probably annoy the page pool code a bit. I guess for now
> > we should just make sure that uAPI doesn't bake in the idea that
> > buffers are always power of 2.  
> What if the hardware uses a log scheme to represent the buffer
> length? Then it would still need to align down to the next power of 2?

Yes, that's fine, pow-of-2 should obviously work. I was trying to say
that we shouldn't _require_ power-of-2 in uAPI, because devices with
are limited to (power-of-2 - 1) would strand ~half of the max length.

> > II. Fractional page sizes
> > -------------------------
> > If the HW has max-rx-buf-len of 16k or 32k, and PAGE_SIZE is 64k
> > should we support hunking devmem/iouring into less than a PAGE_SIZE?  

Thanks for the comments!

