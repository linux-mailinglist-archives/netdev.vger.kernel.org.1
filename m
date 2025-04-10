Return-Path: <netdev+bounces-181337-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BBEA8484F
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 17:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5D3D16CD38
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 15:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D9791D6DAA;
	Thu, 10 Apr 2025 15:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jrTMwi1p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3986F8635B
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 15:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744299839; cv=none; b=Cm6e3j3UAbXDcTSXBMJHB1qSoMiXD1Udco0YFDhfBQWfgCxB6UFTKqWGW7yNsnhQhhGxqJPI+JQKnfSvmV5jrHMYWHGhp/TMf4/6qmuRwNpSvpOKm5UgzxSHmnL2JFoICLNPcq2Kwz7j9o8tbtObcc93lFmMNpsqD3pbpU7dM9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744299839; c=relaxed/simple;
	bh=ujPioiSC71kHjkyR9Rl+7giBhDd2pP+J47UzH4ybU3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UeiESCcWaqpmNn0om5b2cThuar+m4euoUSChO2UL6d027e75ERYwr3EbXY1JsS9l/zDsXvrwUoafE9c+zaGTTcDrYqxD2zPHIS1xBg/LT9yi/TOtwRv3Cm9x7C1zwG4aNCEdDbio9gItY+lUozrpPZY1/XJ2YqlZJuuno/6YUQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jrTMwi1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32CA2C4CEDD;
	Thu, 10 Apr 2025 15:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744299838;
	bh=ujPioiSC71kHjkyR9Rl+7giBhDd2pP+J47UzH4ybU3o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jrTMwi1pMJTam1Y99jBhSepSHKQQJ24mAf0O0tY0lf6qTzPsaKH459k9JR55gVcJj
	 34nQlYs7KRFIo6J5Q1cP0BJOrw2TnXFaZMWAvnEPb87E2+QlemjvR430Ri4Ndmc6HL
	 ucH8A8YvfJnXQWPcInO87U6S5px5n0YAF63mv8vcNxcxM/HQErXxEaYC7BjNGTKWV/
	 mWorvEZ1rzTJavkcTwtiMj97DsfPNzFk+nPkmFqSIqyyn6Q0P6EHKkV4xvwn+Mro2F
	 F0b/cjX+7C5c/EOI7K2vRNMmB+EQFIpAe3Icuk2bOPCT5oAoW6gsNZ5UbvYg57wKNm
	 DfFOdWnXeRbnQ==
Date: Thu, 10 Apr 2025 16:43:53 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>, netdev@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Michal Schmidt <mschmidt@redhat.com>,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>
Subject: Re: [PATCH iwl-net v3] ice: use DSN instead of PCI BDF for
 ice_adapter index
Message-ID: <20250410154353.GU395307@horms.kernel.org>
References: <20250408134655.4287-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408134655.4287-1-przemyslaw.kitszel@intel.com>

On Tue, Apr 08, 2025 at 03:46:55PM +0200, Przemek Kitszel wrote:
> Use Device Serial Number instead of PCI bus/device/function for
> index of struct ice_adapter.
> Functions on the same physical device should point to the very same
> ice_adapter instance.
> 
> This is not only simplification, but also fixes things up when PF
> is passed to VM (and thus has a random BDF).

Maybe it's just me but "fixes things up" seems a bit vague for
a fix for net. Could something more specific go here?

> 
> Suggested-by: Jacob Keller <jacob.e.keller@intel.com>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Jiri Pirko <jiri@resnulli.us>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> CC: Karol Kolacinski <karol.kolacinski@intel.com>
> CC: Grzegorz Nitka <grzegorz.nitka@intel.com>
> CC: Michal Schmidt <mschmidt@redhat.com>
> CC: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> CC: Michal Kubiak <michal.kubiak@intel.com>
> 
> v3:
>  - Add fixes tag (Michal K)

The fixes tag seems to have got lost in transit.

I believe it should be [1]:

Fixes: 0e2bddf9e5f9 ("ice: add ice_adapter for shared data across PFs on the same NIC")

[1] https://lore.kernel.org/intel-wired-lan/7f700a89-7058-4c16-b53a-2e84bbed8542@intel.com/

>  - add missing braces (lkp bot), turns out it's hard to purge C++ from your mind
>  - (no changes in the collision handling on 32bit systems)
> 
> v2:
> https://lore.kernel.org/intel-wired-lan/20250407112005.85468-1-przemyslaw.kitszel@intel.com/
>  - target to -net (Jiri)
>  - mix both halves of u64 DSN on 32bit systems (Jiri)
>  - (no changes in terms of fallbacks for pre-prod HW)
>  - warn when there is DSN collision after reducing to 32bit
> 
> v1:
> https://lore.kernel.org/netdev/20250306211159.3697-2-przemyslaw.kitszel@intel.com

...

