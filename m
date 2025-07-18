Return-Path: <netdev+bounces-208243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C41B0AAF9
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 22:09:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 91E095A5A7F
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 20:09:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761591DF970;
	Fri, 18 Jul 2025 20:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVKxT+fT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5261DD517
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 20:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752869339; cv=none; b=CI46aQQEhT8BPGNiTcWf7R6GVVOr7xAd7VnnJSz/0AWBw/DGP2exvPj32kN74CmgDJq0gk/IwNn89DSfiZpRbmsVAR8oVaD9OIP/10k9YQpy+FLrI1D9p9XdE475haJV1Gq7TwT5K6C67PSVjloYsRsHzI02nN5Y4MqJYLix29Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752869339; c=relaxed/simple;
	bh=NIAirv361kSK6wQiQmEm6VjaF36ZiNPPXMjFWF6plVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dtKx6QTTBe6kPlFzXDoPoq64+AQzQbf+xyn7CKjpJ/K+aMTO6Aop8bpYUTOn3dGoYrEi+urSwIjmyXMN+5HNUuDKiSHdb9Kaoxn/dE4I4J3XavuGovp+IwqDVGyTQIm6EKo7wS3c8MvQs/fVo1ezG+e4hQCjiEw7fa9CQPASTnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVKxT+fT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8CDC4CEEB;
	Fri, 18 Jul 2025 20:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752869338;
	bh=NIAirv361kSK6wQiQmEm6VjaF36ZiNPPXMjFWF6plVw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oVKxT+fTu3BKTXZmbOMbGvbjWZlFeMQZlnIg7O3zbf1V+GSIHoiHklNba75yOYL59
	 MHzFKlhzZ/+QJfDB7ugDVYY8dcyAQrW9bOvHnpAd6eAgHsV7n+XDHbuHkZvyJMZ0xx
	 e0wJ0w/Q5hawTXUP0l8tGaPCvOVGjF4IOpSBVkBTT5WxSFF++tyT3zBYYq/uu23wry
	 NmoHKc0KH33mpwrhcar1FBW43a5+H8/V8xVHUz30t/7m9EZjw026+QZtwsAfjd3B9V
	 BJXecBSNFqsvibI3WpNVK6TN1C7UDg28LNE2rl/sNDuCi0DYlZhLTfivQy4NSMMLcD
	 Gszq4HObfooNw==
Date: Fri, 18 Jul 2025 21:08:55 +0100
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Intel Wired LAN <intel-wired-lan@lists.osuosl.org>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	vgrinber@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net 2/2] ice: don't leave device non-functional if Tx
 scheduler config fails
Message-ID: <20250718200855.GN2459@horms.kernel.org>
References: <20250717-jk-ddp-safe-mode-issue-v1-0-e113b2baed79@intel.com>
 <20250717-jk-ddp-safe-mode-issue-v1-2-e113b2baed79@intel.com>
 <20250718165024.GI2459@horms.kernel.org>
 <95ddc646-d348-45e3-b1f8-b0f114163b11@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95ddc646-d348-45e3-b1f8-b0f114163b11@intel.com>

On Fri, Jul 18, 2025 at 12:56:29PM -0700, Jacob Keller wrote:
> 
> 
> On 7/18/2025 9:50 AM, Simon Horman wrote:
> > On Thu, Jul 17, 2025 at 09:57:09AM -0700, Jacob Keller wrote:
> >>
> >> Fixes: 91427e6d9030 ("ice: Support 5 layer topology")
> >> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> > 
> > Thanks for the extensive explanation.
> > 
> 
> Thanks. This took me forever to track down exactly what went wrong,
> enough that I had to have the customer send me the card back because we
> thought the firmware was unrecoverable and bricked.

Ouch!

...

> >>  	msleep(1000);
> >>  	ice_reset(hw, ICE_RESET_CORER);
> >> -	/* CORER will clear the global lock, so no explicit call
> >> -	 * required for release.
> >> -	 */
> >> +	ice_check_reset(hw);
> >>  
> >> -	return 0;
> >> +reinit_hw:
> > 
> > nit: I think you can move this label above ice_check_reset().
> >      As the only place that jumps to this label calls ice_check_reset()
> >      immediately before doing so. If so, renaming the label might
> >      also be appropriate (up to you on all fronts:)
> > 
> 
> You're right thats probably slightly better. I'm not sure its worth a
> re-roll vs getting this fix out since its a pretty minor difference.

Yes, agreed. I'm happy to let this lie if you prefer.

...

