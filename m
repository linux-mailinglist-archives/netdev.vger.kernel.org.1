Return-Path: <netdev+bounces-249088-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00136D13C7D
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 16:47:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49594300761A
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 15:40:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFDF3612CB;
	Mon, 12 Jan 2026 15:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KDyXM7+h"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FD12E282B
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768232442; cv=none; b=S3AAX4tswWOAKLMaN1JsNmLrRF9ynNzExOX5y0gie7ArUsxMMEKpkXHFpkkLg6TdL0m+gSl1EIP90G5sainEZh9w39rEwwB5/a7ZU2hD1rc7EH6fuI4Gqh8jmslqeenEETGU6KsJmb07JAm/R6oo6VYXllQY337ChsGMll6/bI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768232442; c=relaxed/simple;
	bh=S7KNPztVqVvamGiodW7Ohav+2c6tatorRI36ZPUSq2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ga3hPpvK5S5mt8cAiylGhnZ1TXrnCWI6aR9Wbun9AAil2gAyLN5GNBEG2tzrSC4grnesPX3pxxX69E7h4IPMt0dGRrJ7p1eH2PBiRZAI/4BH/hLzBRkqt640u3YeWrXbEvgAGPlIVRjAkYzSSRd2nc3MViuBSGxQmm/TixO4euw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KDyXM7+h; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=lWLa8BFP1kgFKIVhYHsABv9gUrFzoQq7hdhn+zK+9lg=; b=KDyXM7+h/r5vhFmAdBPSQ4jZFD
	YpitUKL3WbtTV7H0fQ5bhm/hVRJUlf75Mx4QvFPYKcFHH//tpB6QZE0vt3wGH+BItSpnGsJCWr67c
	aBEaFUjxR/ixOyI7MBZexiITOE6LtYpT0KHkwN4I5R/wHb/aNarRkKJk0rDo8l0AvXjI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vfK22-002V1O-Lj; Mon, 12 Jan 2026 16:40:38 +0100
Date: Mon, 12 Jan 2026 16:40:38 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: Re: [PATCH iwl-next v1 6/7] ixgbe: replace EEE enable flag with
 state enum
Message-ID: <8f976990-1087-4ba0-a06d-c0538c39d2a3@lunn.ch>
References: <20260112140108.1173835-1-jedrzej.jagielski@intel.com>
 <20260112140108.1173835-7-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112140108.1173835-7-jedrzej.jagielski@intel.com>

On Mon, Jan 12, 2026 at 03:01:07PM +0100, Jedrzej Jagielski wrote:
> Change approach from using EEE enabled flag to using newly introduced
> enum dedicated to reflect state of the EEE feature.
> 
> New enum is required to extend on/off state with new forced off state,
> which is set when EEE must be temporarily disabled due to unsupported
> conditions, but should be enabled back when possible.
> 
> Such scenario happens eg when link comes up with newly negotiated
> speed which is not one of the EEE supported link speeds.
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> ---
>  drivers/net/ethernet/intel/ixgbe/ixgbe.h         | 11 ++++++++++-
>  drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c |  4 ++--
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c    |  4 ++--
>  3 files changed, 14 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe.h b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> index 14d275270123..9f52da4ec711 100644
> --- a/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe.h
> @@ -324,6 +324,14 @@ enum ixgbe_ring_state_t {
>  	__IXGBE_TX_DISABLED,
>  };
>  
> +enum ixgbe_eee_state_t {
> +	IXGBE_EEE_DISABLED,	/* EEE explicitly disabled by user */
> +	IXGBE_EEE_ENABLED,	/* EEE enabled; for E610 it's default state */
> +	IXGBE_EEE_FORCED_DOWN,	/* EEE disabled by link conditions, try to
> +				 * restore when possible

This is a bit odd. What generally happens is the PHY advertises what
it supports. It receives what the link partner advertises. It then
runs a resolver to determine what the result of the negotiation is,
and then informs the MAC of the result. The configuration does not
change if the resolved state means EEE is disabled. The PHY keeps on
advertising what it was configured with. If the link changes such that
the resolved state does allow EEE, the notification to the MAC will
indicate this.

It seems to me you are mixing up configuration and state.

	Andrew

