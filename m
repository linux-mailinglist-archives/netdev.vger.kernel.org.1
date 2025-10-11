Return-Path: <netdev+bounces-228598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A1F7BCF7C3
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 17:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D60CD347180
	for <lists+netdev@lfdr.de>; Sat, 11 Oct 2025 15:03:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69BFF18A921;
	Sat, 11 Oct 2025 15:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eAvSBGBB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44D5C1E480
	for <netdev@vger.kernel.org>; Sat, 11 Oct 2025 15:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760195012; cv=none; b=SY8a2NRRzKBWM3WKmag4z19192ub9FHihzqLeQ9afyHqR7NChwABfU3IX1KQHC3FQhruUOdG2lFIDq6gTl7tqbtb3k9F4x2VguvpfwAxuHxcRxo10fJObFij3I4KAn/FJLbe5CSaFn3S1IZRvfQZfp1VSQJEMhFdvhYUkm4xLDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760195012; c=relaxed/simple;
	bh=b6EdLmV6B3+GD7OoEyD5jUcVCGvRMVnc835CfKljTrs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXlIW8ZfxQG3EGN2uDX/NNFMbatgD84SnCb5sU32uavMMioC4BDbz0aM/BHKg1lzdqCvCofPvCZnTBV093XZmvmoaSIm1rl2rU2K+TAujxb5uQyr6uIV5Y4BBHFwK/1RDzhyEUUeQI4/Hb260YfFB1Wlr+8NnV+O8J1V5WMiOKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eAvSBGBB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B863C4CEF4;
	Sat, 11 Oct 2025 15:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760195011;
	bh=b6EdLmV6B3+GD7OoEyD5jUcVCGvRMVnc835CfKljTrs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eAvSBGBBJHHtzAoqbi+raaM0PPk6z2C6qVHJYhwHn6su6sBCu8HUGgL9Ox95aw39n
	 IEoGiZYk/KvEylRIZY2CupYglOAwPuQWiGUBco1erCUed6RDKs66QBIa5JWTzozBZt
	 Bc7SI8gCpeFCMMkFlx5cBV6mFiIL4y2ITezDAi1h2RPVRpdzyZAYKfZAJv/Nz7xwnt
	 Y16SIUpRt+DCB9RW19fIFjkGI3LH4POJnGlUsqxp9dim4MxeU9hwdqWb+hfjFfi5Tm
	 MppYpSDvlyusvBLpXeT/flK1q4CAQ58AJZRLw5SAdh5oiueLB5GXjMnuocqmdvCQx1
	 8umcFo7enpj2Q==
Date: Sat, 11 Oct 2025 16:03:27 +0100
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: airoha: Take into account out-of-order tx
 completions in airoha_dev_xmit()
Message-ID: <aOpxv3SPSrMDB3Ib@horms.kernel.org>
References: <20251010-airoha-tx-busy-queue-v1-1-9e1af5d06104@kernel.org>
 <aOo0woPiMxjABFv2@horms.kernel.org>
 <aOpc8d0dPGOnwfJE@lore-desk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOpc8d0dPGOnwfJE@lore-desk>

On Sat, Oct 11, 2025 at 03:34:41PM +0200, Lorenzo Bianconi wrote:
> > On Fri, Oct 10, 2025 at 07:21:43PM +0200, Lorenzo Bianconi wrote:
> > > Completion napi can free out-of-order tx descriptors if hw QoS is
> > > enabled and packets with different priority are queued to same DMA ring.
> > > Take into account possible out-of-order reports checking if the tx queue
> > > is full using circular buffer head/tail pointer instead of the number of
> > > queued packets.
> > > 
> > > Fixes: 23020f0493270 ("net: airoha: Introduce ethernet support for EN7581 SoC")
> > > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> > > ---
> > >  drivers/net/ethernet/airoha/airoha_eth.c | 15 ++++++++++++++-
> > >  1 file changed, 14 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
> > > index 833dd911980b3f698bd7e5f9fd9e2ce131dd5222..5e2ff52dba03a7323141fe9860fba52806279bd0 100644
> > > --- a/drivers/net/ethernet/airoha/airoha_eth.c
> > > +++ b/drivers/net/ethernet/airoha/airoha_eth.c
> > > @@ -1873,6 +1873,19 @@ static u32 airoha_get_dsa_tag(struct sk_buff *skb, struct net_device *dev)
> > >  #endif
> > >  }
> > >  
> > > +static bool airoha_dev_is_tx_busy(struct airoha_queue *q, u32 nr_frags)
> > > +{
> > > +	u16 index = (q->head + nr_frags) % q->ndesc;
> > > +
> > > +	/* completion napi can free out-of-order tx descriptors if hw QoS is
> > > +	 * enabled and packets with different priorities are queued to the same
> > > +	 * DMA ring. Take into account possible out-of-order reports checking
> > > +	 * if the tx queue is full using circular buffer head/tail pointers
> > > +	 * instead of the number of queued packets.
> > > +	 */
> > > +	return index >= q->tail && (q->head < q->tail || q->head > index);
> > 
> > Hi Lorenzo,
> 
> Hi Simon,
> 
> thx for the review.
> 
> > 
> > I think there is a corner case here.
> > Perhaps they can't occur, but here goes.
> > 
> > Let us suppose that head is 1.
> > And the ring is completely full, so tail is 2.
> > 
> > Now, suppose nr_frags is ndesc - 1.
> > In this case the function above will return false. But the ring is full.
> > 
> > Ok, ndesc is actually 1024 and nfrags should never be close to that.
> > But the problem is general. And a perhaps more realistic example is:
> > 
> >   ndesc is 1024
> >   head is 1008
> >   The ring is full so tail is 1009
> >   (Or head is any other value that leaves less than 16 slots free)
> >   nr_frags is 16
> > 
> > airoha_dev_is_tx_busy() returns false, even though the ring is full.
> 
> yes, you are right, this corner case is not properly managed by the proposed
> algorithm, thx for pointing this out.
> 
> > 
> > Probably this has it's own problems. But if my reasoning above is correct
> > (is it?) then the following seems to address it by flattening and extending
> > the ring. Because what we are about is the relative value of head, index
> > and tail. Not the slots they occupy in the ring.
> > 
> > N.B: I tetsed the algorirthm with a quick implementation in user-space.
> > The following is, however, completely untested.
> > 
> > static bool airoha_dev_is_tx_busy(struct airoha_queue *q, u32 nr_frags)
> > {
> > 	unsigned int tail = q->tail < q->head ? q->tail + q->ndesc : q->tail;
> > 	unsigned int index = q->head + nr_frags;
> > 
> > 	return index >= tail;
> > }
> 
> I agree, the algorithm you proposed properly manages the 99% of the cases. The
> only case where it fails is when the queue is empty (so tail = head = x,
> e.g. x = 0). In this case we would have:
> 
> 	- q->ndesc = 1024
> 	- q->tail = q->head = 0
> 	- tail = 0
> 	- index = n (e.g. n = 1)
> 	- index >= tail ==> 1 >= 0 ==> busy (but the queue is actually empty).
> 
> I guess we should add a minor change in the tail definition:
> 
> 	u32 tail = q->tail <= q->head ? q->tail + q->ndesc : q->tail;
> 
> so:
> 	- q->ndesc = 1024
> 	- q->tail = q->head = 0
> 	- tail = 1024
> 	- index = n (e.g. n = 1)
> 	- index >= tail => 1 < 1024 => OK
> 
> Can you spot any downside with this approach?
> I tested the proposed approach and it seems to be working fine.

Thanks, agreed.
Sorry for the out by one error.


