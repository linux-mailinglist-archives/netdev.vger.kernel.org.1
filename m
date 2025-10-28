Return-Path: <netdev+bounces-233635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE36C16AD0
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 20:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 247D43565D3
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 19:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE9D25A34F;
	Tue, 28 Oct 2025 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="izqZ1AVP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA211713;
	Tue, 28 Oct 2025 19:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761681213; cv=none; b=eSgHmBkZL0vkfIOL/fhZW+TSmvh8mcubjrzOtzf8bmn3h8THUOhD1yon/vK+RGxOcE6NPuiW+Yv6lFA2e2z3THy7QXJpK6h/1QGqIo9AZd+lCRKOHFpvocbZKBOPnGdcFDP+PG2w8IT6R4WFdHIbJsM7J0znUyJiWAhwoZOLesA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761681213; c=relaxed/simple;
	bh=50jNbJSIfsjrwnURWYy7zkQMXptHmNshM9nR/RRLDjU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h+XJ8yqeH7QnseoJkFxKDZwJn6x8HwhOwdRFbm3TDrq8XTOiSixn25Q/zkNgRW9HgvmNKaRfHHygynrbcd3qW6xyyWb0mz5z6QCnYJKCht1eo612bbiLh8YAFaDOQWaOOvD0UbCg67BX06U9tdrXIa4HPyqgR5jshz91i5Fqqvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=izqZ1AVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9C24C4CEE7;
	Tue, 28 Oct 2025 19:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761681213;
	bh=50jNbJSIfsjrwnURWYy7zkQMXptHmNshM9nR/RRLDjU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=izqZ1AVPcpfpqu/CHG6bJBdKPzx5yQwDBl/FuRhKqhr1jZwdTaMSl/Z4oZLbrsDVn
	 ypm58/lPN4cvzD1KPRx/N5fhxVcOBVsqgK93TJm2iJ5ME5DQHWa2SLg+vzmHyeeA9H
	 zZpImkGB5l68gjgLsHR+f2FWOWoL00X+JyPvkFccEr0SXmT8cJhEhmkbQ0YSekBjke
	 lAVkoBchC9V5OBIeh2T9JAitm8spFr6gfjHXtEiszLzk/iG/2XCVQHQljMcarP0zQS
	 BYnRa/glKB2XggJ0vQR2xYS+Iz97zZiqaTjnvcNmS9NUQY2uG3NPO3TDjnoBtLKpll
	 Mj6KQkfnjRkUg==
Date: Tue, 28 Oct 2025 19:53:28 +0000
From: Simon Horman <horms@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	nxne.cnse.osdt.itp.upstreaming@intel.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] ice: implement configurable
 header split for regular Rx
Message-ID: <aQEfOEwOlG8SVMrh@horms.kernel.org>
References: <20251006162053.3550824-1-aleksander.lobakin@intel.com>
 <aP-cgMiJ-y_PX7Xa@horms.kernel.org>
 <5800be3b-9347-452e-97df-d0e7d939fadf@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5800be3b-9347-452e-97df-d0e7d939fadf@intel.com>

On Mon, Oct 27, 2025 at 06:18:01PM +0100, Alexander Lobakin wrote:
> From: Simon Horman <horms@kernel.org>
> Date: Mon, 27 Oct 2025 16:23:28 +0000
> 
> > On Mon, Oct 06, 2025 at 06:20:53PM +0200, Alexander Lobakin wrote:
> >> Add second page_pool for header buffers to each Rx queue and ability
> >> to toggle the header split on/off using Ethtool (default to off to
> >> match the current behaviour).
> >> Unlike idpf, all HW backed up by ice doesn't require any W/As and
> >> correctly splits all types of packets as configured: after L4 headers
> >> for TCP/UDP/SCTP, after L3 headers for other IPv4/IPv6 frames, after
> >> the Ethernet header otherwise (in case of tunneling, same as above,
> >> but after innermost headers).
> >> This doesn't affect the XSk path as there are no benefits of having
> >> it there.
> >>
> >> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> >> ---
> >> Applies on top of Tony's next-queue, depends on Michał's Page Pool
> >> conversion series.
> >>
> >> Sending for review and validation purposes.
> >>
> >> Testing hints: traffic testing with and without header split enabled.
> >> The header split can be turned on/off using Ethtool:
> >>
> >> sudo ethtool -G <iface> tcp-data-split on (or off)
> > 
> > Nice, I'm very pleased to see this feature in the pipeline for the ice driver.
> 
> This is a prereq for io_uring/devmem support in ice which I'm currently
> finishing :>
> 
> (I know it's a bit overdue already, but I couldn't find a free time slot
>  earlier to implement this)

Great, I'm very pleased to hear io_uring/devmem support is in the pipeline.

> 
> > 
> > ...
> > 
> >> diff --git a/drivers/net/ethernet/intel/ice/ice_txrx.c b/drivers/net/ethernet/intel/ice/ice_txrx.c
> > 
> > ...
> > 
> >> @@ -836,6 +858,20 @@ bool ice_alloc_rx_bufs(struct ice_rx_ring *rx_ring, unsigned int cleaned_count)
> >>  		 */
> >>  		rx_desc->read.pkt_addr = cpu_to_le64(addr);
> >>  
> >> +		if (!hdr_fq.pp)
> >> +			goto next;
> >> +
> >> +		addr = libeth_rx_alloc(&hdr_fq, ntu);
> >> +		if (addr == DMA_MAPPING_ERROR) {
> >> +			rx_ring->ring_stats->rx_stats.alloc_page_failed++;
> >> +
> >> +			libeth_rx_recycle_slow(fq.fqes[ntu].netmem);
> >> +			break;
> >> +		}
> >> +
> >> +		rx_desc->read.hdr_addr = cpu_to_le64(addr);
> >> +
> >> +next:
> > 
> > Is performance the reason that a goto is used here, rather than, say, putting
> > the conditional code in an if condition? Likewise in ice_clean_rx_irq?
> 
> Not the performance, but the thing that I can avoid introducing +1
> indentation level for 9 lines. I don't like big `if` blocks.
> IIRC there's no strong rule regarding this?
> 
> (same for ice_clean_rx_irq)

Ok. I'd lean towards an if condition. But I don't feel strongly about it.

> 
> > 
> >>  		rx_desc++;
> >>  		ntu++;
> >>  		if (unlikely(ntu == rx_ring->count)) {
> >> @@ -933,14 +969,16 @@ static int ice_clean_rx_irq(struct ice_rx_ring *rx_ring, int budget)
> >>  		unsigned int size;
> >>  		u16 stat_err_bits;
> >>  		u16 vlan_tci;
> >> +		bool rxe;
> >>  
> >>  		/* get the Rx desc from Rx ring based on 'next_to_clean' */
> >>  		rx_desc = ICE_RX_DESC(rx_ring, ntc);
> >>  
> >> -		/* status_error_len will always be zero for unused descriptors
> >> -		 * because it's cleared in cleanup, and overlaps with hdr_addr
> >> -		 * which is always zero because packet split isn't used, if the
> >> -		 * hardware wrote DD then it will be non-zero
> >> +		/*
> >> +		 * The DD bit will always be zero for unused descriptors
> >> +		 * because it's cleared in cleanup or when setting the DMA
> >> +		 * address of the header buffer, which never uses the DD bit.
> >> +		 * If the hardware wrote the descriptor, it will be non-zero.
> >>  		 */
> > 
> > The update to this comment feels like it could be a separate patch.
> > (I know, I often say something like that...)
> 
> But this update is tied closely to the header split itself. Before this
> patch, this update would make no sense as there are no header buffers.
> After this patch, this comment will be outdated already without this
> update :D

Thanks for the clarification, I was expecting you would say something like
that.

I think everything I mentioned in my previous email was
covered by your response. So feel free to add:

Reviewed-by: Simon Horman <horms@kernel.org>


