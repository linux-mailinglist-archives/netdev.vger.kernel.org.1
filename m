Return-Path: <netdev+bounces-104954-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E3290F45C
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 18:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 965AC1C20CAA
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE684153561;
	Wed, 19 Jun 2024 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6Xs746q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99A1615099A
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718815473; cv=none; b=E0iVEHpT/eDEbz/yM8iNHvjBINsDpP4EwQ84vzgTtdN20Ng6jxfVuZNA+p1AVwZnGYdhiAkWt/TodYRvR9uMEcBZ/NvBsqe95sqTbZrZlPa2o9xI/dop1hEg11+pWCQuJi9rejFRSmN39auaF198wlEgiXhOLbXHqwur6HxxcqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718815473; c=relaxed/simple;
	bh=Ucq3CIEnp7nuN4eV6bKSXDv5ypODlJoh5abKEQDh/xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gkLFAq36xvbFq0qj50bniUYTcOW7F7WItxK4U/w4q1XOUkzqu1AwczuGIsKDaZSGutMsz7k+cDsRizsxiCJMgguGmoXsI+AP3FG6onGj2ox9pViXWb3v3+1Ibp8s6O16qRoK4K3l0LDv0F+1pqjakMH+IRkfEYJrbTWYLpKrlpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6Xs746q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B996AC4AF08;
	Wed, 19 Jun 2024 16:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718815473;
	bh=Ucq3CIEnp7nuN4eV6bKSXDv5ypODlJoh5abKEQDh/xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B6Xs746qhlaz72V9RWMlblcaW77ENAnN6ZVcdMhqSnmCykMYC3SWyVbwD3jztddLT
	 UosnEpjZE56TD4XBakGNJODtE/emkHqYBIi3mymiWFPGb349R7ObEu8eRKelcXXGfC
	 kDw9M1ik8EwMxaeFpuq9Dj93W2sVFG2C1T7LJCJ98h/zwdwbvTia7sykA+aLebVxej
	 +afO5mH8iITJkZwyzw1Z8Po1vo1IwYoPjOsD903jB2j5UCkvdXgRrl+RFYxkMfqDua
	 178nJoLwzQkn9j71Dk6g5FEdkDkc9s9eTa92J7X4nNWKkARPhSdParEi4IEAb2Gpln
	 f0b/8zLSF8JAQ==
Date: Wed, 19 Jun 2024 17:44:29 +0100
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-net 3/3] ice: Reject pin requests with unsupported
 flags
Message-ID: <20240619164429.GL690967@kernel.org>
References: <20240618104310.1429515-1-karol.kolacinski@intel.com>
 <20240618104310.1429515-4-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618104310.1429515-4-karol.kolacinski@intel.com>

On Tue, Jun 18, 2024 at 12:41:38PM +0200, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The driver receives requests for configuring pins via the .enable
> callback of the PTP clock object. These requests come into the driver
> with flags which modify the requested behavior from userspace. Current
> implementation in ice does not reject flags that it doesn't support.
> This causes the driver to incorrectly apply requests with such flags as
> PTP_PEROUT_DUTY_CYCLE, or any future flags added by the kernel which it
> is not yet aware of.
> 
> Fix this by properly validating flags in both ice_ptp_cfg_perout and
> ice_ptp_cfg_extts. Ensure that we check by bit-wise negating supported
> flags rather than just checking and rejecting known un-supported flags.
> This is preferable, as it ensures better compatibility with future
> kernels.
> 
> Fixes: 172db5f91d5f ("ice: add support for auxiliary input/output pins")
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>

Hi Jacob and Karol,

Some minor feedback from my side.

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index b952cad42f92..5fa377786f4c 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c
> @@ -1591,14 +1591,23 @@ void ice_ptp_extts_event(struct ice_pf *pf)
>   * @store: If set to true, the values will be stored
>   *
>   * Configure an external timestamp event on the requested channel.
> -  */
> -static void ice_ptp_cfg_extts(struct ice_pf *pf, unsigned int chan,
> -			      struct ice_extts_channel *config, bool store)
> + *
> + * Return: 0 on sucess, -EOPNOTUSPP on unsupported flags

nit: success

     Flagged by checkpatch.pl --codespell

> + */
> +static int ice_ptp_cfg_extts(struct ice_pf *pf, unsigned int chan,
> +			     struct ice_extts_channel *config, bool store)
>  {
>  	u32 func, aux_reg, gpio_reg, irq_reg;
>  	struct ice_hw *hw = &pf->hw;
>  	u8 tmr_idx;
>  
> +	/* Reject requests with unsupported flags */
> +	if (config->flags & ~(PTP_ENABLE_FEATURE |
> +			      PTP_RISING_EDGE |
> +			      PTP_FALLING_EDGE |
> +			      PTP_STRICT_FLAGS))
> +	return -EOPNOTSUPP;

The line above should to be indented one more tab.
Clearly this makes no difference at run-time,
but it takes a while (for me) to parse things as-is.

...

> @@ -1697,6 +1708,9 @@ static int ice_ptp_cfg_clkout(struct ice_pf *pf, unsigned int chan,
>  	u32 func, val, gpio_pin;
>  	u8 tmr_idx;
>  
> +	if (config->flags & ~PTP_PEROUT_PHASE)
> +		return -EOPNOTSUPP;

A little further down in this function it is assumed that config may
be NULL. So I think the code above needs to be updated to take that
into account too.

Flagged by Smatch.

...

