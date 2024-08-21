Return-Path: <netdev+bounces-120614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D14D959F70
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 16:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFE9A1C218A2
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 14:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578E21B1D40;
	Wed, 21 Aug 2024 14:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJ0x3lnF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D4E18C348;
	Wed, 21 Aug 2024 14:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724249605; cv=none; b=ivksj8XK6rCN4KvwCCbuxnJRkEeLHbgtiR669Wtfqqs4estH0okpMsjIB9ZHjp7Lhjbs4Yz1g2eLdXOs5JNCDLRMIuvZCqmcPKghdlNVFGMcQe5sT5HtkcTOzEsI5HueoR7/c0ZKprGm+3P25oCq61zzwssDyp37vlDy569HMZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724249605; c=relaxed/simple;
	bh=wiS4vNnKd5VRD+ghCEcqt+Olqpk4BtfE4JPaEDvV8hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Smg9nQTAWmXoiYP3glM/u2aEKnKT40+PFeooLkNuKI0eOVZXCmAvS+6KvXC7JDDOaOnlLNvq5lcPnwqs6aHPOftfeivLupN7czuPKOFIPP22+jKb4frID8uCZEvd9ZgcORky8XMHcA2yz3Ie10m9gyH/2WGTVsNF1dtZ75ClZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJ0x3lnF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 735D7C32781;
	Wed, 21 Aug 2024 14:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724249604;
	bh=wiS4vNnKd5VRD+ghCEcqt+Olqpk4BtfE4JPaEDvV8hs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YJ0x3lnFSs3c1odcRqgJ2hQU8sdbPbEN7qcafS/iqKB5iP463BWhctvlDDQPiK0se
	 AWMAS06nVrr2yQ9M3sHrfdMotoONhGYAVnfUi6/sVA7B7INgNhnLI81rvkeuQ9Z80m
	 Xo0d49msm8IiU2rwXmkcjhcuX+qfDPHuuxpys242hD3+Q/bHfpzZX0URLJPXQVrP28
	 byKuheUNDMIhSPwleyO+kfsv2QT4bvL7B2MUb5VlzA/iqNkSpRBZUc0iPSd1nN2+dT
	 N1jZlIZfYU4BDiZWo3Lw4Oxz10nOOY6uCN5dSnWJkWD+lo4JqMUIj0PBPKDNcqe3CG
	 4yU6t54f21U1A==
Date: Wed, 21 Aug 2024 15:13:20 +0100
From: Simon Horman <horms@kernel.org>
To: Joseph Huang <joseph.huang.2024@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Joseph Huang <Joseph.Huang@garmin.com>,
	netdev@vger.kernel.org, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/1] net: dsa: mv88e6xxx: Fix out-of-bound access
Message-ID: <20240821141320.GA1722@kernel.org>
References: <20240819222641.1292308-1-Joseph.Huang@garmin.com>
 <72e02a72-ab98-4a64-99ac-769d28cfd758@lunn.ch>
 <20240820183202.GA2898@kernel.org>
 <5da4cc4d-2e68-424c-8d91-299d3ccb6dc8@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5da4cc4d-2e68-424c-8d91-299d3ccb6dc8@gmail.com>

On Tue, Aug 20, 2024 at 03:21:57PM -0400, Joseph Huang wrote:
> On 8/20/2024 2:32 PM, Simon Horman wrote:
> > On Tue, Aug 20, 2024 at 12:58:05AM +0200, Andrew Lunn wrote:
> > > On Mon, Aug 19, 2024 at 06:26:40PM -0400, Joseph Huang wrote:
> > > > If an ATU violation was caused by a CPU Load operation, the SPID is 0xf,
> > > > which is larger than DSA_MAX_PORTS (the size of mv88e6xxx_chip.ports[]
> > > > array).
> > > 
> > > The 6390X datasheet says "IF SPID = 0x1f the source of the violation
> > > was the CPU's registers interface."
> > > 
> > > > +#define MV88E6XXX_G1_ATU_DATA_SPID_CPU				0x000f
> > > 
> > > So it seems to depend on the family.
> > > 
> > > >  >  /* Offset 0x0D: ATU MAC Address Register Bytes 0 & 1
> > > >   * Offset 0x0E: ATU MAC Address Register Bytes 2 & 3
> > > > diff --git a/drivers/net/dsa/mv88e6xxx/global1_atu.c b/drivers/net/dsa/mv88e6xxx/global1_atu.c
> > > > index ce3b3690c3c0..b6f15ae22c20 100644
> > > > --- a/drivers/net/dsa/mv88e6xxx/global1_atu.c
> > > > +++ b/drivers/net/dsa/mv88e6xxx/global1_atu.c
> > > > @@ -457,7 +457,8 @@ static irqreturn_t mv88e6xxx_g1_atu_prob_irq_thread_fn(int irq, void *dev_id)
> > > >  		trace_mv88e6xxx_atu_full_violation(chip->dev, spid,
> > > >  						   entry.portvec, entry.mac,
> > > >  						   fid);
> > > > -		chip->ports[spid].atu_full_violation++;
> > > > +		if (spid != MV88E6XXX_G1_ATU_DATA_SPID_CPU)
> > > > +			chip->ports[spid].atu_full_violation++;
> > > 
> > > So i think it would be better to do something like:
> > > 
> > > 		if (spid < ARRAY_SIZE(chip->ports))
> > > 			chip->ports[spid].atu_full_violation++;
> > 
> > Hi Joseph,
> > 
> > I am curious to know if bounds checking should also
> > be added to other accesses to chip->ports[spid] within this function.
> > 
> 
> Hi Simon,
> 
> From the spec it is unclear to me whether the Load operation could actually
> cause other exceptions. I was only able to reproduce and verify the full
> violation, and that's why I only included that one in the patch.
> 
> I guess we could proactively include the fix for other exceptions as well,
> but without a way to verify them, they could be just dead code and never be
> exercised. Perhaps people who are more familiar with the chip than me could
> chime in. I'm fine either way.

Thanks Joseph,

From my PoV it would be nice to add the checks unless we can be sure they
are not needed. But I do not feel strongly about this.

