Return-Path: <netdev+bounces-207414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B0DDB0715A
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 11:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC2963B4DDF
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 09:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9941E2F4313;
	Wed, 16 Jul 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oP1kDNkC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD5F28C00D;
	Wed, 16 Jul 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656990; cv=none; b=mHhTLbbtZ4SNIXbuoM2lZQZdKWmjHd5fs27N4WvzfLSCyhNLWOO4WGRih6Sggxcww49Vb3n8xyxN4pm+yXQkxmV19FFVBgq6nG/LyllO/G98bmc+43ndLl3caSH3ABvJPg0kNU1urXn10s9MWOpDxpfJZhxMrIObdYXnSD+lQns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656990; c=relaxed/simple;
	bh=nWcid9/YaCg33CZYX+ZX1917uRt+3s+pK3UeJWQ4nE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X/7RVrY10aO4smC/gLaSHJTEyHMDhKkuuHJSa3uTZUey0IrkankG5WzhcbYbuRVNuW8VQk9wN0SQuaDLiAOn7mOiyrqENCL2pSbMIznON+WdRcEj9y+uNPy1MXXQBJ17eNgIdS3/Hp0KWC7u6yl5kK11IlBgOg5Q82rVZziQqvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oP1kDNkC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC562C4CEF0;
	Wed, 16 Jul 2025 09:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752656990;
	bh=nWcid9/YaCg33CZYX+ZX1917uRt+3s+pK3UeJWQ4nE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oP1kDNkCtjP3B8/zyrdvzANBiwEosQjXsFTRe+gbxR39/a2SrTiKoild6MU7zztPn
	 1Eag85ZQppvo7QZld8JIZg6XHbAkSjper07E1gKv8rLR2geGasVrHwZqMP0aTJYjEl
	 BCdWDvPrkIVieJQQyvGBzom1/h1uw/bhKdq604knRNwkpjqTIexJAzmTjMd1EhUTVX
	 n2ZpBMLIwIx61Q205KknFIRzvqOBOgR/vH6RgttJMzyI2Olcyf9FHW4njw5Rs5D2UA
	 8CZIHFIz300nSM83qk7HW9wixTnbTT0PWsHTUXV027p7hktpL/D4H7T7FmD0DncAsU
	 J6e2X3CJ+BEqA==
Date: Wed, 16 Jul 2025 10:09:45 +0100
From: Simon Horman <horms@kernel.org>
To: carlos.bilbao@kernel.org
Cc: jv@jvosburgh.net, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	sforshee@kernel.org, bilbao@vt.edu
Subject: Re: [PATCH] bonding: Switch periodic LACPDU state machine from
 counter to jiffies
Message-ID: <20250716090945.GL721198@horms.kernel.org>
References: <20250715205733.50911-1-carlos.bilbao@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250715205733.50911-1-carlos.bilbao@kernel.org>

On Tue, Jul 15, 2025 at 03:57:33PM -0500, carlos.bilbao@kernel.org wrote:
> From: Carlos Bilbao <carlos.bilbao@kernel.org>
> 
> Replace the bonding periodic state machine for LACPDU transmission of
> function ad_periodic_machine() with a jiffies-based mechanism, which is
> more accurate and can help reduce drift under contention.
> 
> Signed-off-by: Carlos Bilbao (DigitalOcean) <carlos.bilbao@kernel.org>
> ---
>  drivers/net/bonding/bond_3ad.c | 79 +++++++++++++---------------------
>  include/net/bond_3ad.h         |  2 +-
>  2 files changed, 32 insertions(+), 49 deletions(-)
> 

Hi Carlos,

Some minor feedback from my side.

> diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c

...

> @@ -1471,21 +1451,24 @@ static void ad_periodic_machine(struct port *port, struct bond_params *bond_para
>  			  "Periodic Machine: Port=%d, Last State=%d, Curr State=%d\n",
>  			  port->actor_port_number, last_state,
>  			  port->sm_periodic_state);
> +
>  		switch (port->sm_periodic_state) {
> -		case AD_NO_PERIODIC:
> -			port->sm_periodic_timer_counter = 0;
> -			break;
> -		case AD_FAST_PERIODIC:
> -			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
> -			port->sm_periodic_timer_counter = __ad_timer_to_ticks(AD_PERIODIC_TIMER, (u16)(AD_FAST_PERIODIC_TIME))-1;
> -			break;
> -		case AD_SLOW_PERIODIC:
> -			/* decrement 1 tick we lost in the PERIODIC_TX cycle */
> -			port->sm_periodic_timer_counter = __ad_timer_to_ticks(AD_PERIODIC_TIMER, (u16)(AD_SLOW_PERIODIC_TIME))-1;
> -			break;
>  		case AD_PERIODIC_TX:
>  			port->ntt = true;
> -			break;
> +			if (!(port->partner_oper.port_state &
> +						LACP_STATE_LACP_TIMEOUT))
> +				port->sm_periodic_state = AD_SLOW_PERIODIC;
> +			else
> +				port->sm_periodic_state = AD_FAST_PERIODIC;
> +		fallthrough;

super-nit: maybe one more tab of indentation for the line above.

> +		case AD_SLOW_PERIODIC:
> +		case AD_FAST_PERIODIC:
> +			if (port->sm_periodic_state == AD_SLOW_PERIODIC)
> +				port->sm_periodic_next_jiffies = jiffies
> +					+ HZ * AD_SLOW_PERIODIC_TIME;
> +			else /* AD_FAST_PERIODIC */
> +				port->sm_periodic_next_jiffies = jiffies
> +					+ HZ * AD_FAST_PERIODIC_TIME;

Clang 20.1.8 complains that either a break; or fallthrough; should go here.
For consistency with the code above I'd suggest the latter.


>  		default:
>  			break;
>  		}

...

