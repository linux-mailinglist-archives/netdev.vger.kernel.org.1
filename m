Return-Path: <netdev+bounces-250190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69760D24C9E
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 14:46:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CB75E3016EE5
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 13:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC0A26A1B9;
	Thu, 15 Jan 2026 13:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XMTwZ0wG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1611246335;
	Thu, 15 Jan 2026 13:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768484781; cv=none; b=UxzSWLSTpfvFACYaFLlx8FPzllHpx0OwZigz1a5mSzYCiKcy67mL4PiAEsF44jGuTl3dqn4G3J+2hdKl9CPmQYjlCDrxRc70P5z4ATrgGtlIJpoWBhI4RZB3ahwXr46grvAnd+sKfHx/xUztG8rb4Lf3YyEacn2s1RB+g/N5ksM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768484781; c=relaxed/simple;
	bh=8MRyKRz8IvMus1kq1/5ub85wIPLibbkZ/kfRUJuAgiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=coHFJFVw9ryflLZQ3H194s7tv5jASLqswZjCwmPwKZRcg5eUXAhQ2nJkxvx0xrktFY1veTQgzosVpnlEeWzxKfrJhR0LJ7yGwCoXkTNpIL6rN0C9wKpmh47OpKh7NsTaRCw3tdlBq2PTMrK3YUMic8/IgbhO51dW01gXZh4KfFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XMTwZ0wG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 139C6C116D0;
	Thu, 15 Jan 2026 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768484780;
	bh=8MRyKRz8IvMus1kq1/5ub85wIPLibbkZ/kfRUJuAgiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XMTwZ0wG1UG0ucc/vvymtFTd7wOnrMrQw2KBfN6vQD6o3PoOl4WZ77J+vXD0DBo5n
	 KjNSEVBPgpcedu5Cp0egMTZuUGFhYqJjFofwN/H4EwtLCMpkGD3jNnRd/O2c9F/BLV
	 fAO0GyTwU0WQ7ZqFzAQqTmvWk7ui2lSTV8VHRLN/zqSKDYNMHqnitxtAriRriTBiB1
	 w/iWMp/8QQbNXYFshE2eZNT6+EBgRfH6GiOgTERNWPAJnbCet6QtyuBrDvIGbxtGuA
	 hRqhSoWXkdhYt2n1yHqbw8xVLUxLwhjxLmLPDu9mNO+mi9rVzp/r8bGYbkemoEanX1
	 xgSBEjQvSXCTA==
Date: Thu, 15 Jan 2026 13:46:15 +0000
From: Simon Horman <horms@kernel.org>
To: Vimlesh Kumar <vimleshk@marvell.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Sathesh B Edara <sedara@marvell.com>,
	Shinas Rasheed <srasheed@marvell.com>,
	Haseeb Gani <hgani@marvell.com>,
	Veerasenareddy Burru <vburru@marvell.com>,
	Satananda Burla <sburla@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [EXTERNAL] Re: [PATCH net v3 3/3] octeon_ep_vf: ensure dbell
 BADDR updation
Message-ID: <aWjvp85mp80JUyGo@horms.kernel.org>
References: <20260107131857.3434352-1-vimleshk@marvell.com>
 <20260107131857.3434352-4-vimleshk@marvell.com>
 <aWUHrqOpf-6hZqlu@horms.kernel.org>
 <MN6PR18MB54664F9D22C6374CEE5FBCF3D38CA@MN6PR18MB5466.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN6PR18MB54664F9D22C6374CEE5FBCF3D38CA@MN6PR18MB5466.namprd18.prod.outlook.com>

On Thu, Jan 15, 2026 at 09:34:23AM +0000, Vimlesh Kumar wrote:
> 
> 
> > -----Original Message-----
> > From: Simon Horman <horms@kernel.org>
> > Sent: Monday, January 12, 2026 8:10 PM
> > To: Vimlesh Kumar <vimleshk@marvell.com>
> > Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Sathesh B Edara
> > <sedara@marvell.com>; Shinas Rasheed <srasheed@marvell.com>; Haseeb
> > Gani <hgani@marvell.com>; Veerasenareddy Burru <vburru@marvell.com>;
> > Satananda Burla <sburla@marvell.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>
> > Subject: [EXTERNAL] Re: [PATCH net v3 3/3] octeon_ep_vf: ensure dbell
> > BADDR updation
> > 
> > On Wed, Jan 07, 2026 at 01: 18: 56PM +0000, Vimlesh Kumar wrote: > Make
> > sure the OUT DBELL base address reflects the > latest values written to it. > >
> > Fix: > Add a wait until the OUT DBELL base address register > is updated
> > On Wed, Jan 07, 2026 at 01:18:56PM +0000, Vimlesh Kumar wrote:
> > > Make sure the OUT DBELL base address reflects the latest values
> > > written to it.
> > >
> > > Fix:
> > > Add a wait until the OUT DBELL base address register is updated with
> > > the DMA ring descriptor address, and modify the setup_oq function to
> > > properly handle failures.
> > >
> > > Fixes: 2c0c32c72be29 ("octeon_ep_vf: add hardware configuration APIs")
> > > Signed-off-by: Sathesh Edara <sedara@marvell.com>
> > > Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> > > Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
> > > ---
> > > V3:
> > > - Use reverse christmas tree order variable declaration.
> > > - Return error if timeout happens during setup oq.
> > 
> > ...
> > 
> > > diff --git a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> > > b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> > > index d70c8be3cfc4..6446f6bf0b90 100644
> > > --- a/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> > > +++ b/drivers/net/ethernet/marvell/octeon_ep_vf/octep_vf_rx.c
> > > @@ -171,7 +171,9 @@ static int octep_vf_setup_oq(struct octep_vf_device
> > *oct, int q_no)
> > >  		goto oq_fill_buff_err;
> > >
> > >  	octep_vf_oq_reset_indices(oq);
> > > -	oct->hw_ops.setup_oq_regs(oct, q_no);
> > > +	if (oct->hw_ops.setup_oq_regs(oct, q_no))
> > > +		goto oq_fill_buff_err;
> > > +
> > 
> > Hi Vimlesh, all,
> > 
> > I think that a new label needs to be added to the unwind ladder such that
> > octep_vf_oq_free_ring_buffers() is called if the error condition above is met.
> > 
> > Likewise in patch 2/3.
> 
> Hi Simon, 
> 
> octep_vf_oq_free_ring_buffers() is being called from the caller function octep_vf_setup_oqs() in the error case and hence not required over here.

Ok. I'm not a big fan of asymmetric clean-up paths.
But I agree that would prevent leaks.

...

