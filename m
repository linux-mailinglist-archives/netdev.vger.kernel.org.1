Return-Path: <netdev+bounces-103554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED78A908A31
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 12:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25413B2BA5D
	for <lists+netdev@lfdr.de>; Fri, 14 Jun 2024 10:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24A5194132;
	Fri, 14 Jun 2024 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMOttC+p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88FC1922F6;
	Fri, 14 Jun 2024 10:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718361335; cv=none; b=O7YsG1bt3WU9RF58nz3GxgMM1ag16n4YKuVsBW3/em286otkIMFIqPSZMXBaz40Q+5hxq0Rc03KoFAKaSboxHQLdCeCCc8+uXW/FcKstzE/KgslvIOjYI3QEZyYJb1U2if1P5kwTJs07ryOmmTzn7fSygZzLcDcUeCv9ofLeJgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718361335; c=relaxed/simple;
	bh=nmbY+YrSTZFPVTA1p0a3HbRHJgnxgNGMOb8cyV6ZNrg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u1L9VnS/BjbyJmqp7Ux6KrXttcLCh3eZtV2/GzQ3MFmfU8lKsTH84zgmJVE8Qx0u+KSVV7SARCbeomcPzW11KNDrTHwh3OKIjXHDUbsZfZyDS/bjq8EcokUtvB3H2p/C3w2XCT6LQs5moq+xnCbOOEYe63Pw1WaL5Xc3f2I1Z3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMOttC+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38B0C2BD10;
	Fri, 14 Jun 2024 10:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718361335;
	bh=nmbY+YrSTZFPVTA1p0a3HbRHJgnxgNGMOb8cyV6ZNrg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NMOttC+p1sLncB5MngCgxwOxznz/W1nhBecTQZSwBq/ZJ0nhWrGQW3iA9Wr37yBf6
	 SpGG2Im4aksxrK18YsyNdt4aZSrTWcuWrS3wf6+O0pc5UhM/I/YsHa1wC8cosq88tD
	 hYg8vYZapLLqMFzSOqxjMe57TBvED4mKxyWqoCLR5rQmiDmetsY5eDJaVLFULy9PH1
	 dG5nrzXeGNzWL71veELbFA+4aFVKMlNtojQS0VnNzmJuzMDxSE2csOGugSjxMzBqfi
	 9wFdeM/HW4RJF2B0XZ4AXDoy5TdTkY/KKaSCZuLXxaDQ1k+OwMtq4jakH7Ire+zDGT
	 /6uROvWxzPzew==
Date: Fri, 14 Jun 2024 11:35:31 +0100
From: Simon Horman <horms@kernel.org>
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
Cc: netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org,
	corbet@lwn.net, linux-doc@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH iwl-next v2 3/5] ice: add tracking of good transmit
 timestamps
Message-ID: <20240614103531.GA8447@kernel.org>
References: <20240606224701.359706-1-jesse.brandeburg@intel.com>
 <20240606224701.359706-4-jesse.brandeburg@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606224701.359706-4-jesse.brandeburg@intel.com>

On Thu, Jun 06, 2024 at 03:46:57PM -0700, Jesse Brandeburg wrote:
> As a pre-requisite to implementing timestamp statistics, start tracking
> successful PTP timestamps. There already existed a trace event, but
> add a counter as well so it can be displayed by the next patch.
> 
> Good count is a u64 as it is much more likely to be incremented. The
> existing error stats are all u32 as before, and are less likely so will
> wrap less.
> 
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Reviewed-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>

Hi Jesse,

The minor nit below notwithstanding, this looks good for me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.h b/drivers/net/ethernet/intel/ice/ice_ptp.h
> index 3af20025043a..2b15f2b58789 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.h
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.h
> @@ -253,6 +253,7 @@ struct ice_ptp {
>  	struct ptp_clock *clock;
>  	struct hwtstamp_config tstamp_config;
>  	u64 reset_time;
> +	u64 tx_hwtstamp_good;

nit: There should be an entry for @tx_hwtstamp_good added to the Kernel doc
     for this structure.

Also, not strictly related to this patch, but related to Kernel doc.
It would be very nice, IMHO, if some work could be done to add
Return: sections to Kernel docs for the ice and moreover Intel Wired
Ethernet drivers. These are flagged by kernel-doc -none -Wall,
which was recently enabled for NIPA. And there are a lot of them.

>  	u32 tx_hwtstamp_skipped;
>  	u32 tx_hwtstamp_timeouts;
>  	u32 tx_hwtstamp_flushed;
> -- 
> 2.43.0
> 
> 

