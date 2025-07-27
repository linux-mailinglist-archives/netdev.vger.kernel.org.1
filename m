Return-Path: <netdev+bounces-210375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C788B12FC0
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 15:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10D4A3B8FA4
	for <lists+netdev@lfdr.de>; Sun, 27 Jul 2025 13:54:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F3C86344;
	Sun, 27 Jul 2025 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e13o1Tjo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE0B4086A
	for <netdev@vger.kernel.org>; Sun, 27 Jul 2025 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753624500; cv=none; b=aswBMh+mQakOM6dVCY0vOVNtj3yGF4XEj0PGvZjX4GnzS6A4gcLUv4x7ktaZjF+l/TceurcI8rnCjBRD+zxuGluWeQ//stvULY/ux/qmCCQ69FAw8z09KjZQhKv1Zs/jlcJGoTigYdCaeSsTunWzK56axRXHUSMCgx09PtVA8bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753624500; c=relaxed/simple;
	bh=VBV63q1aoWk9I7DKDbsgbXB12D2skcqyhUP3A3Znqjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SklGql0+3Q+3/qczGfi6h41ajfOHBNGzeP10pQ1TMT3tkl/JPKvY8lNEuF6ysuMeftYU6E7G6kkI21nierfMTyWg/OmrcZviEKdnBKrlFI34RH7j0jNFfSNPQJZAs7k6kW1KMg8S2zkhFwABm5r3OwHyc1LD3/UW3YeE/GHtoI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e13o1Tjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953CDC4CEEB;
	Sun, 27 Jul 2025 13:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753624500;
	bh=VBV63q1aoWk9I7DKDbsgbXB12D2skcqyhUP3A3Znqjg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e13o1TjofSUu2+33Rj8v98FYFPhLBRjiUPY8/M9yqAbHmHcUbDqjjINQgKotQndC8
	 t8iGZZX4sYj0ayE/LhVObXpdLfRyo34AGFD2St24K6+IHY1nR+HvPcUS/QJxXiIQ9+
	 mZwgOzkomias7KOsMhxQW1mkAeWGt0mzyR9gN3D5r7CqfLHI+bEKy8bdG4R4R0JG+0
	 SkWszvFgQUSWvAOlWHZ4mQgLrfxVZ8zziby+51GUTBESfiO5rvTphUDP0Z8un7Rz4G
	 +qzpr6SDuW1P4d8Elc352ohHZLwspazWCLpI/J41RElps+eHiSBSja9fBJcA1+riuH
	 TLdIqJ5ajfL8Q==
Date: Sun, 27 Jul 2025 14:54:55 +0100
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
Message-ID: <20250727135455.GW1367887@horms.kernel.org>
References: <20250726070356.58183-1-kerneljasonxing@gmail.com>
 <a8eba276-afbf-456c-943d-36144877cfc0@molgen.mpg.de>
 <CAL+tcoD3zwiWsrqDQp1uhegiiFnYs8jcpFVTpuacZ_c6y9-X+Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoD3zwiWsrqDQp1uhegiiFnYs8jcpFVTpuacZ_c6y9-X+Q@mail.gmail.com>

On Sun, Jul 27, 2025 at 06:06:55PM +0800, Jason Xing wrote:
> Hi Paul,
> 
> On Sun, Jul 27, 2025 at 4:36 PM Paul Menzel <pmenzel@molgen.mpg.de> wrote:
> >
> > Dear Jason,
> >
> >
> > Thank you for the improved version.
> >
> > Am 26.07.25 um 09:03 schrieb Jason Xing:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > Resolve the budget negative overflow which leads to returning true in
> > > ixgbe_xmit_zc even when the budget of descs are thoroughly consumed.
> > >
> > > Before this patch, when the budget is decreased to zero and finishes
> > > sending the last allowed desc in ixgbe_xmit_zc, it will always turn back
> > > and enter into the while() statement to see if it should keep processing
> > > packets, but in the meantime it unexpectedly decreases the value again to
> > > 'unsigned int (0--)', namely, UINT_MAX. Finally, the ixgbe_xmit_zc returns
> > > true, showing 'we complete cleaning the budget'. That also means
> > > 'clean_complete = true' in ixgbe_poll.
> > >
> > > The true theory behind this is if that budget number of descs are consumed,
> > > it implies that we might have more descs to be done. So we should return
> > > false in ixgbe_xmit_zc to tell napi poll to find another chance to start
> > > polling to handle the rest of descs. On the contrary, returning true here
> > > means job done and we know we finish all the possible descs this time and
> > > we don't intend to start a new napi poll.
> > >
> > > It is apparently against our expectations. Please also see how
> > > ixgbe_clean_tx_irq() handles the problem: it uses do..while() statement
> > > to make sure the budget can be decreased to zero at most and the negative
> > > overflow never happens.
> > >
> > > The patch adds 'likely' because we rarely would not hit the loop codition
> > > since the standard budget is 256.
> > >
> > > Fixes: 8221c5eba8c1 ("ixgbe: add AF_XDP zero-copy Tx support")
> > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > Reviewed-by: Larysa Zaremba <larysa.zaremba@intel.com>
> > > ---
> > > Link: https://lore.kernel.org/all/20250720091123.474-3-kerneljasonxing@gmail.com/
> > > 1. use 'negative overflow' instead of 'underflow' (Willem)
> > > 2. add reviewed-by tag (Larysa)
> > > 3. target iwl-net branch (Larysa)
> > > 4. add the reason why the patch adds likely() (Larysa)
> > > ---
> > >   drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c | 4 +++-
> > >   1 file changed, 3 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > index ac58964b2f08..7b941505a9d0 100644
> > > --- a/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_xsk.c
> > > @@ -398,7 +398,7 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
> > >       dma_addr_t dma;
> > >       u32 cmd_type;
> > >
> > > -     while (budget-- > 0) {
> > > +     while (likely(budget)) {
> > >               if (unlikely(!ixgbe_desc_unused(xdp_ring))) {
> > >                       work_done = false;
> > >                       break;
> > > @@ -433,6 +433,8 @@ static bool ixgbe_xmit_zc(struct ixgbe_ring *xdp_ring, unsigned int budget)
> > >               xdp_ring->next_to_use++;
> > >               if (xdp_ring->next_to_use == xdp_ring->count)
> > >                       xdp_ring->next_to_use = 0;
> > > +
> > > +             budget--;
> > >       }
> > >
> > >       if (tx_desc) {
> >
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> >
> > Is this just the smallest fix, and the rewrite to the more idiomatic for
> > loop going to be done in a follow-up?
> 
> Thanks for the review. But I'm not that sure if it's worth a follow-up
> patch. Or if anyone else also expects to see a 'for loop' version, I
> can send a V3 patch then. I have no strong opinion either way.

I think we have iterated over this enough (pun intended).
If this patch is correct then lets stick with this approach.

