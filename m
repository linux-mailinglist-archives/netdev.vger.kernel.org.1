Return-Path: <netdev+bounces-210387-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A0DB12FFA
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 16:47:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD23218988F0
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 14:47:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5FFF1E260A;
	Sun, 27 Jul 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeUvHq/5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23ED14EC73
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 14:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753627652; cv=none; b=DDAPqwlnjlmxsQOVgoJ4rSkPN+gC58mXEdq4fZ8tzhXgxAUBgRWNqc08JvYh9m4jFVkZQdV7Kd+ehiC69v3jDxACoHk6llYeg5wIDcqZODxPtVUcs2MUT7HbTcS52n9PgSwMadkJ2Jn6JlHvl01IX9MtSBPkUeS3kE2+gwZYd+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753627652; c=relaxed/simple;
	bh=qERj7svUyfRmSz0skHDB6WOw//9NG3XK0/7JHhL5ej8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jNY6x/GC+U9tZOLEHIbkL4cEnQX86KpJm/JanvAFqYr+5CXG+2zzAT1WN5SkpaA5w0pDluESeWrqbZskyVCu8aup+/AjBD52949g08i3yXT11MiJBSwYgsH3UeSYWPF2y9q9uowmTKgVc9YioFirToKy8dEFtzYGf+ceOGLPb14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeUvHq/5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ED6BC4CEEB;
	Sun, 27 Jul 2025 14:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753627652;
	bh=qERj7svUyfRmSz0skHDB6WOw//9NG3XK0/7JHhL5ej8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MeUvHq/5XaTAmVz2TBwWQOcHno/7Cdqcv4YRsesaIYXnF88Q5Ke02RpU78Mb8RWmr
	 7PnjNBtozMUJZLvefUk6GCmOlfKEU4xF32eQDNayj3COrUDtm/tvUAFv3OPSYmc9rz
	 WC9+qA3RS3C/F1mkWGOTzbRUsnY3mKjjeyG9aR2+sw98J2xbOfB3+KXR60BYiSIEWI
	 vjZuYgnFvt1YP+s+n+NHL3cnXiOpKab6jgi1BvSwys6OZHxsGY5JVx+D+IPEHWz0QI
	 OmKnJARRRJlnFKknctseqKvSqanrlV5J1IIVh2tlV1s1X+YrtbRmiVgO7kR5ndO76N
	 VEwNf2gjE0pBQ==
Date: Sun, 27 Jul 2025 15:47:27 +0100
From: Simon Horman <horms@kernel.org>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com, larysa.zaremba@intel.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bjorn@kernel.org,
	maciej.fijalkowski@intel.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [Intel-wired-lan] [PATCH v2 iwl-net] ixgbe: xsk: resolve the
 negative overflow of budget in ixgbe_xmit_zc
Message-ID: <20250727144727.GY1367887@horms.kernel.org>
References: <20250726070356.58183-1-kerneljasonxing@gmail.com>
 <a8eba276-afbf-456c-943d-36144877cfc0@molgen.mpg.de>
 <CAL+tcoD3zwiWsrqDQp1uhegiiFnYs8jcpFVTpuacZ_c6y9-X+Q@mail.gmail.com>
 <20250727135455.GW1367887@horms.kernel.org>
 <CAL+tcoBUKmt5mCq4coLkbqT5Ehb+V6NFDcjOErg_8AYHG4fgcg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoBUKmt5mCq4coLkbqT5Ehb+V6NFDcjOErg_8AYHG4fgcg@mail.gmail.com>

On Sun, Jul 27, 2025 at 10:16:10PM +0800, Jason Xing wrote:
> Hi Simon,
> 
> On Sun, Jul 27, 2025 at 9:55 PM Simon Horman <horms@kernel.org> wrote:
> >
> > On Sun, Jul 27, 2025 at 06:06:55PM +0800, Jason Xing wrote:
> > > Hi Paul,
> > >
> > > On Sun, Jul 27, 2025 at 4:36 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> > > >
> > > > Dear Jason,
> > > >
> > > >
> > > > Thank you for the improved version.
> > > >
> > > > Am 26.07.25 um 09:03 schrieb Jason Xing:
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > Resolve the budget negative overflow which leads to returning true in
> > > > > ixgbe_xmit_zc even when the budget of descs are thoroughly consumed.
> > > > >
> > > > > Before this patch, when the budget is decreased to zero and finishes
> > > > > sending the last allowed desc in ixgbe_xmit_zc, it will always turn back
> > > > > and enter into the while() statement to see if it should keep processing
> > > > > packets, but in the meantime it unexpectedly decreases the value again to
> > > > > 'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc returns
> > > > > true, showing 'we complete cleaning the budget'. That also means
> > > > > 'clean_complete = true' in ixgbe_poll.
> > > > >
> > > > > The true theory behind this is if that budget number of descs are consumed,
> > > > > it implies that we might have more descs to be done. So we should return
> > > > > false in ixgbe_xmit_zc to tell napi poll to find another chance to start
> > > > > polling to handle the rest of descs. On the contrary, returning true here
> > > > > means job done and we know we finish all the possible descs this time and
> > > > > we don't intend to start a new napi poll.
> > > > >
> > > > > It is apparently against our expectations. Please also see how
> > > > > ixgbe_clean_tx_irq() handles the problem: it uses do..while() statement
> > > > > to make sure the budget can be decreased to zero at most and the negative
> > > > > overflow never happens.
> > > > >
> > > > > The patch adds 'likely' because we rarely would not hit the loop codition
> > > > > since the standard budget is 256.
> > > > >
> > > > > Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > > > Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > > > ---
> > > > > Link: https://lore.kernel.org/all/20250720091123.474-3-kerneljasonxing@gmail.com/
> > > > > 1. use 'negative overflow' instead of 'underflow' (Willem)
> > > > > 2. add reviewed-by tag (Larysa)
> > > > > 3. target iwl-net branch (Larysa)
> > > > > 4. add the reason why the patch adds likely() (Larysa)
> > > > > ---
> > > > >   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 +++-
> > > > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > > > index ac58964b2f08..7b941505a9d0 100644
> > > > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > > > @@ -398,7 +398,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
> > > > >       dma_addr_t dma;
> > > > >       u32 cmd_type;
> > > > >
> > > > > -     while (budget-- > 0) {
> > > > > +     while (likely(budget)) {
> > > > >               if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
> > > > >                       work_done = false;
> > > > >                       break;
> > > > > @@ -433,6 +433,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
> > > > >               xdp_ring->next_to_use++;
> > > > >               if (xdp_ring->next_to_use == xdp_ring->count)
> > > > >                       xdp_ring->next_to_use = 0;
> > > > > +
> > > > > +             budget--;
> > > > >       }
> > > > >
> > > > >       if (tx_desc) {
> > > >
> > > > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> > > >
> > > > Is this just the smallest fix, and the rewrite to the more idiomatic for
> > > > loop going to be done in a follow-up?
> > >
> > > Thanks for the review. But I'm not that sure if it's worth a follow-up
> > > patch. Or if anyone else also expects to see a 'for loop' version, I
> > > can send a V3 patch then. I have no strong opinion either way.
> >
> > I think we have iterated over this enough (pun intended).
> 
> Hhh, interesting.
> 
> > If this patch is correct then lets stick with this approach.
> 
> No problem. Tomorrow I will send the 'for loop' version :)

I meant, I think the while loop is fine.
But anything that is correct is fine by me :)

