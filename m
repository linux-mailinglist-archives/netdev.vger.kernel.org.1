Return-Path: <netdev+bounces-141213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 624919BA0FD
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 16:10:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 262FD280351
	for <lists+netdev@lfdr.de>; Sat,  2 Nov 2024 15:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91D718BB87;
	Sat,  2 Nov 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K6+oBM5c"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BDD19BBA
	for <netdev@vger.kernel.org>; Sat,  2 Nov 2024 15:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730560238; cv=none; b=O+ObJYICYyg5xIFfY8268hGXSuQwNRM5Xt/FJGoTQq7J1fCnuelTgjcLfMBC5qsG1hGPHZWEpHGZf7MFeKFJUwj2sA7BUqOUAiLkwA1xyWwrqE7ljt786V7FHFRNSuo5t6shi2GxLDUD3jRn8gRD84E3Nvvtd36nBw6zDNn/Zvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730560238; c=relaxed/simple;
	bh=BRzbZbvrsonkgSCIr2qVQooEeByYk+usY3bS4Qx8zQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o1lqx4M+QXZHq3wxyeEorqayPWj9m/344MpCeF08JrkLAjEokTu1DA5bm9NSSUXH1oClZExo+2H0NsT/0v1LwczKApiCk195u+ueCE00bgxM8LnLtUbgWsh0OsX+Ok8OjvzJkzxsL/Hj3ps1L2Gj80MHcrWpciFoxEN6/L2ovAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K6+oBM5c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2D1C4CEC3;
	Sat,  2 Nov 2024 15:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730560238;
	bh=BRzbZbvrsonkgSCIr2qVQooEeByYk+usY3bS4Qx8zQw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K6+oBM5cE0qJwqVV0nahfYdSTaZElo0JurFanzJjXGeFn5ccVxPrTrPrxlU90cYrF
	 30camoDKYiuGPLnhULPXCGPlcUgeB+gEoFaEh6pI0EKBRbpl420m/TFqSn9MF2DIrv
	 a3GnbH+ZySPAqktmDDRhM2UNtJtDsH+QYCw94XsHlsHcB5lxD0aAAqKcuhtG3Y8UpK
	 lsBCpXCKXzqzBdFUYMeGDcI+PHIjEKHl4kLve7P7Mh/SK3Q5ZZ7lLU7S/UyPUfVHGb
	 SksoXeH+/MI1wAq7750kDgUyuU1rlsjS5DTCWRLojEr2Q46U+HeQaTh/SOR43PzxIH
	 Fmz9jW3BnK8qQ==
Date: Sat, 2 Nov 2024 15:10:33 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: Re: [PATCH v3 iwl-net 2/4] ice: Fix quad registers read on E825
Message-ID: <20241102151033.GP1838431@kernel.org>
References: <20241028204543.606371-1-grzegorz.nitka@intel.com>
 <20241028204543.606371-3-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241028204543.606371-3-grzegorz.nitka@intel.com>

On Mon, Oct 28, 2024 at 09:45:41PM +0100, Grzegorz Nitka wrote:
> From: Karol Kolacinski <karol.kolacinski@intel.com>
> 
> Quad registers are read/written incorrectly. E825 devices always use
> quad 0 address and differentiate between the PHYs by changing SBQ
> destination device (phy_0 or phy_0_peer).
> 
> Add helpers for reading/writing PTP registers shared per quad and use
> correct quad address and SBQ destination device based on port.
> 
> Rename rmn_0 to phy_0 and remove rmn_1 and rmn_2 as E82X HW does not
> support it. Rename eth56g_phy_1 to phy_0_peer.
> 
> Fixes: 7cab44f1c35f ("ice: Introduce ETH56G PHY model for E825C products")
> Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> ---
> V2 -> V3: Replaced lower/upper_32_bits calls with lower/upper_16_bits
> V1 -> V2: Fixed kdoc issues
> 
>  drivers/net/ethernet/intel/ice/ice_common.c   |   2 +-
>  .../net/ethernet/intel/ice/ice_ptp_consts.h   |  75 ++----
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 237 +++++++++++-------
>  drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  37 ++-
>  drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   7 +-
>  drivers/net/ethernet/intel/ice/ice_type.h     |   1 -
>  6 files changed, 177 insertions(+), 182 deletions(-)

This patch seems to mix bug fixes and cleanup.
Which leads to a rather large patch - larger than is desirable for stable IMHO.

Could we consider a more minimal fix for iwl-net.
And then follow-up with clean-ups for iwl?

...

