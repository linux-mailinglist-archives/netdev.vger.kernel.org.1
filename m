Return-Path: <netdev+bounces-108166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E82E91E0A7
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 15:26:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D8121C219D1
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A5F15E5C2;
	Mon,  1 Jul 2024 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5xkmTMO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9067415E5BA
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 13:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719840407; cv=none; b=o/Sb56Y5TOLJkPgen8lhUj2TFJYwjuHUnqB4CHhBwXRilsZARC6fSgER6hUP64NQ6RowBU4HdOqEA4iOUzlssv8EOpPM3O/tvhVzhM6TyxMP+hXAuo5j2Ql5f3Bi8EA9yRVw7E7oH0ZfWV3kpVBlKrCF21+QJNx9W6hqIg1jjtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719840407; c=relaxed/simple;
	bh=UECbh9wJXU8IDXyagbQVCkv9/60GTr2VMGPjK0k90E8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adx43eudHYvx73r1FONvzZzX8u5SfvyzNnc1YtCus6NuO8fcV6K9+JnSCvgmR/As6jdpUs5EYnUifhPHty26/s2kbiqWeMyfNnXMTbg0oPs4jvKRynrPj1hzg4qANEBArMpi+4mzCobYyEu4lCPlaaAE7NEjqG6GaHzXFtibF4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5xkmTMO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF6E3C116B1;
	Mon,  1 Jul 2024 13:26:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719840407;
	bh=UECbh9wJXU8IDXyagbQVCkv9/60GTr2VMGPjK0k90E8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=M5xkmTMOC3vYvqztucl18WmOQ3yZGZINLUX5oieDt/bwByEjUUaqC+fQxUU4BRWJz
	 B8wH5GQmkWfHWcBkOb3axyWOmQB7ZdpTzW/4C7oquN12h9IEXwrjKkpRGAGisnMtKE
	 JK+xj5qwdO12exV0a7nKVC4/45BYmS5hQgmrew28u4cQ/BrDxXVpKFoDUlYrp/cpJc
	 MG3SCB/Zv6pZ3RDLoO+paFUryzvxuXrZpZvA+I8rgFDonZJ4fC8ep22SAoFJrov6UL
	 qUXp3wZWvrYYdIQ3H81x9A7BDIZ3O5pnl46Q6dc9Z0916gD7kfGCM6b3jIInRNCvES
	 DQhZH4WsdLeeg==
Date: Mon, 1 Jul 2024 14:26:43 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH iwl-next 4/7] ice: Cache perout/extts requests and check
 flags
Message-ID: <20240701132643.GB17134@kernel.org>
References: <20240627151127.284884-9-karol.kolacinski@intel.com>
 <20240627151127.284884-13-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627151127.284884-13-karol.kolacinski@intel.com>

On Thu, Jun 27, 2024 at 05:09:28PM +0200, Karol Kolacinski wrote:
> Cache original PTP GPIO requests instead of saving each parameter in
> internal structures for periodic output or external timestamp request.
> 
> Factor out all periodic output register writes from ice_ptp_cfg_clkout
> to a separate function to improve readability.
> 
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h

...

> @@ -259,13 +246,18 @@ struct ice_ptp_pin_desc {
>   * @work: delayed work function for periodic tasks
>   * @cached_phc_time: a cached copy of the PHC time for timestamp extension
>   * @cached_phc_jiffies: jiffies when cached_phc_time was last updated
> - * @ext_ts_chan: the external timestamp channel in use
> + * @kworker: kwork thread for handling periodic work
>   * @ext_ts_irq: the external timestamp IRQ in use
>   * @pin_desc: structure defining pins
>   * @ice_pin_desc: internal structure describing pin relations
> +<<<<<<< HEAD
>   * @kworker: kwork thread for handling periodic work
>   * @perout_channels: periodic output data
>   * @extts_channels: channels for external timestamps
> +=======
> + * @perout_rqs: cached periodic output requests
> + * @extts_rqs: cached external timestamp requests
> +>>>>>>> de618462ed43 (ice: Cache perout/extts requests and check flags)
>   * @info: structure defining PTP hardware capabilities
>   * @clock: pointer to registered PTP clock device
>   * @tstamp_config: hardware timestamping configuration

I think something went wrong when resolving a merge at some point :)

...

