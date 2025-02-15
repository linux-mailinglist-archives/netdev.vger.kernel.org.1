Return-Path: <netdev+bounces-166677-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B459A36EEA
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 15:59:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EEEC9188129F
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 14:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716E81D86FB;
	Sat, 15 Feb 2025 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwUQSjPe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DF884400
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 14:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739631585; cv=none; b=IlE1WFLb83PyPTZjYhlPfEuen29jzaxiR2QqD7EVj4ys7ZEHyUSpfVzasBXQfVf1juzCFtZeIryhyCmBho2JZnVg8mTOVYkJE+UChCWrzFJgAqM77eFX0cUAUnWyL8fSeY4roi1pY2LC9pOfMvktkdo5fO6hzbtUmDhIUNrOvic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739631585; c=relaxed/simple;
	bh=KZIZ2YjjJfOnL3t0lW4BtdAn69ETS3FBkScbdmN5n2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qsmcqmz06xmFwI7dXopKIAsHHrmpzpVC41enk33Djxd2eWH3BVENGFIAqDDJkaiNSvLw4Baq4sIvDxeDL7PUX248scIcuEUuz17xnsaQIyifLQ2ldHL9xKsYNbkx4QyzDgySGUhC0gy9eB/HZdy0NXBaMPJpKbqkT+B2aTz/Wio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwUQSjPe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21B6DC4CEDF;
	Sat, 15 Feb 2025 14:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739631585;
	bh=KZIZ2YjjJfOnL3t0lW4BtdAn69ETS3FBkScbdmN5n2I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwUQSjPeFfFkTjMYnVmHe7tOnnn5OFOHfLGa3Nr+PI5yRJy86Q0h+fk620+Pk51PM
	 aMWnAKsbd0Gfvrv9N1eIcteupoF+EcthBhheAptnWL75DFJCyKC2lpjKy4upE/RsGN
	 HrxihxYrNXbiVfLJpGT//M/CtKDsbmwkW+QKq7ufQvUsMkb6hPmG1zM21OVT3TlYZ2
	 nufbEbHyZqWEf4aAZkId7Ao+L4so3+WxZLsAtBJGIgGFyckWqcoPGHWkCHR8lS9c3N
	 CkoDjjuGDRZ0PcxopK/7KHpoZNIOjOjWQ014n07/lCi3KwbvFuEQfST+FYlB5Wcfmp
	 G2yQ/ecN/LC3g==
Date: Sat, 15 Feb 2025 14:59:41 +0000
From: Simon Horman <horms@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev <netdev@vger.kernel.org>,
	Anthony Nguyen <anthony.l.nguyen@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: Re: [PATCH iwl-net] ice: ensure periodic output start time is in the
 future
Message-ID: <20250215145941.GQ1615191@kernel.org>
References: <20250212-jk-gnrd-ptp-pin-patches-v1-1-7cbae692ac97@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212-jk-gnrd-ptp-pin-patches-v1-1-7cbae692ac97@intel.com>

On Wed, Feb 12, 2025 at 03:54:39PM -0800, Jacob Keller wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> On E800 series hardware, if the start time for a periodic output signal is
> programmed into GLTSYN_TGT_H and GLTSYN_TGT_L registers, the hardware logic
> locks up and the periodic output signal never starts. Any future attempt to
> reprogram the clock function is futile as the hardware will not reset until
> a power on.
> 
> The ice_ptp_cfg_perout function has logic to prevent this, as it checks if
> the requested start time is in the past. If so, a new start time is
> calculated by rounding up.
> 
> Since commit d755a7e129a5 ("ice: Cache perout/extts requests and check
> flags"), the rounding is done to the nearest multiple of the clock period,
> rather than to a full second. This is more accurate, since it ensures the
> signal matches the user request precisely.
> 
> Unfortunately, there is a race condition with this rounding logic. If the
> current time is close to the multiple of the period, we could calculate a
> target time that is extremely soon. It takes time for the software to
> program the registers, during which time this requested start time could
> become a start time in the past. If that happens, the periodic output
> signal will lock up.
> 
> For large enough periods, or for the logic prior to the mentioned commit,
> this is unlikely. However, with the new logic rounding to the period and
> with a small enough period, this becomes inevitable.
> 
> For example, attempting to enable a 10MHz signal requires a period of 100
> nanoseconds. This means in the *best* case, we have 99 nanoseconds to
> program the clock output. This is essentially impossible, and thus such a
> small period practically guarantees that the clock output function will
> lock up.
> 
> To fix this, add some slop to the clock time used to check if the start
> time is in the past. Because it is not critical that output signals start
> immediately, but it *is* critical that we do not brick the function, 0.5
> seconds is selected. This does mean that any requested output will be
> delayed by at least 0.5 seconds.
> 
> This slop is applied before rounding, so that we always round up to the
> nearest multiple of the period that is at least 0.5 seconds in the future,
> ensuring a minimum of 0.5 seconds to program the clock output registers.
> 
> Finally, to ensure that the hardware registers programming the clock output
> complete in a timely manner, add a write flush to the end of
> ice_ptp_write_perout. This ensures we don't risk any issue with PCIe
> transaction batching.
> 
> Strictly speaking, this fixes a race condition all the way back at the
> initial implementation of periodic output programming, as it is
> theoretically possible to trigger this bug even on the old logic when
> always rounding to a full second. However, the window is narrow, and the
> code has been refactored heavily since then, making a direct backport not
> apply cleanly.
> 
> Fixes: d755a7e129a5 ("ice: Cache perout/extts requests and check flags")
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks for the excellent patch description.

Reviewed-by: Simon Horman <horms@kernel.org>

...

