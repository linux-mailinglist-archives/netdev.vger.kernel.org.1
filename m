Return-Path: <netdev+bounces-191147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C2EABA34E
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 20:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BC291B624B3
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 18:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F46327C862;
	Fri, 16 May 2025 18:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZnoD0jW9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE27A15747D
	for <netdev@vger.kernel.org>; Fri, 16 May 2025 18:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747421911; cv=none; b=M/hlf+AO13v/Tu1LycPb9A4dHQxadFgQS+FIrLoyJA84++trFdOYGdQIYDipmN5m3F8Z7na84xL1tVVSKoXJINs8w69SmcOxRyJ0fWfpZw1GG2ZyjWk+cCxeM89xZdO8WJHBRamWWrxQuh91MM9+xqWaihGL73s3ruzv6gkd8TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747421911; c=relaxed/simple;
	bh=3AY5SGR35cR14wQVfUdYCMitT4wK09ObHsv/J+MjvWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEBla3HilJ8L53vtOWJjMH9bOtdVLkLvFoRO3nJrUR32RjpmdChVRldEoJc1qrJq8GQi3bgnkuyBWFgCl+QyJXh1yB2AfEXjBB8MsXoEyMr/xJyE/TUHaHcym0a+xtRVqxCCxn0CmNiTGuDRWiL/iHIUilFGJvpVhI/bzfCXTwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZnoD0jW9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E86C4CEE4;
	Fri, 16 May 2025 18:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747421910;
	bh=3AY5SGR35cR14wQVfUdYCMitT4wK09ObHsv/J+MjvWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZnoD0jW9odqfMZaOLRfBIP+YETeoYQJC3IvquhERpMfRK6I9PNKYB5AgZrE50kj/w
	 yGLGOozhLsOiR1hUYq9kSI/dqxp+L1faMsWCMi2ZtzLSW5Md0D6RgqN0OrSB2nlDGh
	 U44sX2F5YLpt3JPSgqCKNjnsZEXkHncsHYQ+um8f8JUxnM4hYhB4DIH/HCzRifPR3V
	 3nAz8on/EXeG+UhfWrTdBgvz9Iar9LnQ22cLF2ZcMU/p/7Xad66NV9L/64TuUgq6Eu
	 3TPurFA/Elkv34XE/Rjaubo6CzK61UiK3uaQNyXhNxjVfd1yokTSoMIpQ/MA+dQR+6
	 JDhMptlGCFa9w==
Date: Fri, 16 May 2025 19:58:27 +0100
From: Simon Horman <horms@kernel.org>
To: Anton Nadezhdin <anton.nadezhdin@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, richardcochran@gmail.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH iwl-net v3] ice/ptp: fix crosstimestamp reporting
Message-ID: <20250516185827.GG3339421@horms.kernel.org>
References: <20250515123236.232338-1-anton.nadezhdin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250515123236.232338-1-anton.nadezhdin@intel.com>

On Thu, May 15, 2025 at 02:32:36PM +0200, Anton Nadezhdin wrote:
> Set use_nsecs=true as timestamp is reported in ns. Lack of this result
> in smaller timestamp error window which cause error during phc2sys
> execution on E825 NICs:
> phc2sys[1768.256]: ioctl PTP_SYS_OFFSET_PRECISE: Invalid argument
> 
> Before commit "Provide infrastructure for converting to/from a base clock"

Hi Anton,

Thanks for your patch.

I have some feedback on the form of the commit message, I hope it is useful.

The correct syntax for fully citing a commit is:
commit 6b2e29977518 ("timekeeping: Provide infrastructure for converting
to/from a base clock")

> the parameter use_nsec was not required. "Remove convert_art_to_tsc()"
> rework shall already contain use_nsecs=true.

I think it would be clearer to express this something along these lines.

  This problem was introduced in commit d4bea547ebb57 ("ice/ptp: Remove
  convert_art_to_tsc()") which omitted setting use_nsecs to true when
  converting the ice driver to use convert_base_to_cs().

Or if there is only one Fixes tag, as I propose below, and there is
no reference to any other commit in the commit message, you could shorten
it a bit to.

  This problem was introduced in the cited commit which omitted setting
  use_nsecs to true when converting the ice driver to use
  convert_base_to_cs().

OTOH, if you think it is useful you could add something like this. But
IMHO it isn't adding much value and I'd leave it out based on less being
more.

  convert_base_to_cs() was added by commit 6b2e29977518 ("timekeeping:
  Provide infrastructure for converting to/from a base clock").

> 
> Testing hints (ethX is PF netdev):
> phc2sys -s ethX -c CLOCK_REALTIME  -O 37 -m
> phc2sys[1769.256]: CLOCK_REALTIME phc offset -5 s0 freq      -0 delay    0
> 
> Fixes: d4bea547ebb57 ("ice/ptp: Remove convert_art_to_tsc()")

My understanding is that the patch cited above (d4bea547ebb57) introduced
the bug being addressed. And that it did so by incorrectly using the
infrastructure added by the patch cited below (6b2e29977518e).

Thus, as the aim is to highlight which commit introduced the bug, I think
that only the fixes tag above should be present (and the one below should
be removed).

> Fixes" 6b2e29977518e ("timekeeping: Provide infrastructure for converting to/from a base clock")

Not strictly relevant if this tag is removed (see above)
but the correct syntax is Fixes: ... (not Fixes" ...).

> Signed-off-by: Anton Nadezhdin <anton.nadezhdin@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>

The code change itself looks correct to me.

...

