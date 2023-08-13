Return-Path: <netdev+bounces-27097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9968E77A5B7
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 11:03:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29250280F42
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 09:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A59F61FB9;
	Sun, 13 Aug 2023 09:03:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854A87E
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 09:03:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92D6C433C7;
	Sun, 13 Aug 2023 09:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691917397;
	bh=wL7aCqb94Cdrt5jofRLuQExYraS5Rk/IOXsF4HRviZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=pAGMMuT7SjxOMH85jrVhbeUR+xXUM/R/qQA6Zi57fPbtWS7C1b2FMoguz6De30SiQ
	 Jg0KVE7WCGMNEby20RXO/rPV5QjJYduJNdLJI/yULQnb4LCsO7gkrX0VJ1n4AspfMJ
	 zNfNWdJJZADle2YKz7moYHMBR1Kp0g+2fjKM/dGjfUkY61c80YpXEwRQFYmzOz3NgK
	 9cMhEeUkjpSq1pdjflHosJIcEvc0geXP+npWIwh6b5AXmiVL95P/s7/to0ztYkexVU
	 Y7bdW1x8qNq6zrnYJvc0oBN/Mw3CyVbvj8X40PN/+zJCA8Qqb6FJ69xMyaPNgwuYKz
	 cItg/tcuicceA==
Date: Sun, 13 Aug 2023 12:03:13 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: fix receive buffer size miscalculation
Message-ID: <20230813090313.GG7707@unreal>
References: <20230810235110.440553-1-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810235110.440553-1-jesse.brandeburg@intel.com>

On Thu, Aug 10, 2023 at 04:51:10PM -0700, Jesse Brandeburg wrote:
> The driver is misconfiguring the hardware for some values of MTU such that
> it could use multiple descriptors to receive a packet when it could have
> simply used one.
> 
> Change the driver to use a round-up instead of the result of a shift, as
> the shift can truncate the lower bits of the size, and result in the
> problem noted above. It also aligns this driver with similar code in i40e.
> 
> The insidiousness of this problem is that everything works with the wrong
> size, it's just not working as well as it could, as some MTU sizes end up
> using two or more descriptors, and there is no way to tell that is
> happening without looking at ice_trace or a bus analyzer.
> 
> Fixes: efc2214b6047 ("ice: Add support for XDP")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> ---
> v2: added fixes tag pointing to the last time this line was modified in
> v5.5 instead of pointing back to the introduction of the driver.
> ---
>  drivers/net/ethernet/intel/ice/ice_base.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>

