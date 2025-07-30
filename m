Return-Path: <netdev+bounces-210991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E9D7B160DC
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 14:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B77560FB7
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 12:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB46256C70;
	Wed, 30 Jul 2025 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TMVBu5NE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A2B153598
	for <netdev@vger.kernel.org>; Wed, 30 Jul 2025 12:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753880375; cv=none; b=BEErpcmsHWqR9nNs/Myk4NF4OHDiPz00EfVnMlVCiWj+5RYrTkH2bw2/Gz+V62Y5jtdfE7yoe4+TaNhYZaWoVamwCeDS/dkNzEGp/gZrx4K9xRTmdJjFOum/QONVTtTJgtmUkaH20JL6VvhIcrHgqrfo1texhJt6dnr1Rm0GJ/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753880375; c=relaxed/simple;
	bh=Qynl247JVKrvQqgbDgyES1qff+f5qRU7sk5KiM2QPaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d8/pGoxDoH21DLGiTxto7O/XZKfF7b0iQANx4IrvZCw3EycJu1jFzZmt6ymYUhBxKhPZtUc0Dcuq27uePBAzMdfdpL+HAwuGyhCkiy+qfxFr14aaNtdtf1kBGTmw5eStwKF6DaFQz7LYSuvPKZXtd6oM4pkLrYkpgdWx5yjbG1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TMVBu5NE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iADRZ//WWXRXjGs7WIF2HBGPV2WioKL2v6FOCPlk2wo=; b=TMVBu5NEEdA129a6t06UhmSCIZ
	AtodenEp2SxCUhmZHVV/sJ/952omEbbUaRRigTXa1EdkLUL4wwhVZhJ2M59S0S0ybJRWplvXl7S+b
	anB1aEU79TnMXfKK6qEDo2ck2EwnJTAn8Ga3qehVpRzn8JUv2S1A6LQEBpAyjQbzgNT4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uh6Or-003HN0-9y; Wed, 30 Jul 2025 14:59:17 +0200
Date: Wed, 30 Jul 2025 14:59:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Gal Pressman <gal@nvidia.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Tariq Toukan <tariqt@nvidia.com>, intel-wired-lan@lists.osuosl.org,
	Donald Hunter <donald.hunter@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: Re: [RFC PATCH] ethtool: add FEC bins histogramm report
Message-ID: <459b5f33-ccb2-4392-9833-f67fcedeaead@lunn.ch>
References: <20250729102354.771859-1-vadfed@meta.com>
 <982c780a-1ff1-4d79-9104-c61605c7e802@lunn.ch>
 <1a7f0aa0-47ae-4936-9e55-576cdf71f4cc@linux.dev>
 <9c1c8db9-b283-4097-bb3f-db4a295de2a5@lunn.ch>
 <4270ff14-06cd-4a78-afe7-1aa5f254ebb6@linux.dev>
 <c52af63b-1350-4574-874e-7d6c41bc615d@lunn.ch>
 <424e38be-127d-49d8-98bf-1b4a2075d710@linux.dev>
 <20250729185146.513504e0@kernel.org>
 <b16f0738-9b73-46f4-93ba-edcf84eb961a@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b16f0738-9b73-46f4-93ba-edcf84eb961a@nvidia.com>

On Wed, Jul 30, 2025 at 08:39:25AM +0300, Gal Pressman wrote:
> On 30/07/2025 4:51, Jakub Kicinski wrote:
> > On Tue, 29 Jul 2025 19:07:59 +0100 Vadim Fedorenko wrote:
> >> On 29/07/2025 18:31, Andrew Lunn wrote:
> >>>> The only one bin will have negative value is the one to signal the end
> >>>> of the list of the bins, which is not actually put into netlink message.
> >>>> It actually better to change spec to have unsigned values, I believe.  
> >>>
> >>> Can any of these NICs send runt packets? Can any send packets without
> >>> an ethernet header and FCS?
> >>>
> >>> Seems to me, the bin (0,0) is meaningless, so can could be considered
> >>> the end marker. You then have unsigned everywhere, keeping it KISS.  
> >>
> >> I had to revisit the 802.3df-2024, and it looks like you are right:
> >> "FEC_codeword_error_bin_i, where i=1 to 15, are optional 32-bit
> >> counters. While align_status is true, for each codeword received with
> >> exactly i correctable 10-bit symbols"
> >>
> >> That means bin (0,0) doesn't exist according to standard, so we can use
> >> it as a marker even though some vendors provide this bin as part of
> >> histogram.
> > 
> > IDK, 0,0 means all symbols were completely correct.
> > It may be useful for calculating bit error rate?
> 
> Exactly. mlx5 will use (0, 0) for sure.

Sorry, i did not spend time to read the standard and issued this was
related to frame length somehow, like the RMON statistics which have
bins for packet length counts.

	Andrew

