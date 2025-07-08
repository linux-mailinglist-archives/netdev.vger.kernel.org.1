Return-Path: <netdev+bounces-205051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4E0AFCFD0
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 17:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB67A1C209BB
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 15:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5DD2E1C65;
	Tue,  8 Jul 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V3UMua6J"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8932B221D87
	for <netdev@vger.kernel.org>; Tue,  8 Jul 2025 15:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751990160; cv=none; b=D3PdTVPzUbC4z5D2ymGaFTwnWbYvDOV6LWPdnVfByq1YZyaR+Bi+afXIfYSPmi9Xwkiycijtw+kAuMf3fjhc5+g02os9pj5aKdr04UV6Ay68qZVuYRbccMPOZUNngOTL2YgBkZkOhSSbtqq+0G1owX4tuJPdzTi4Zy5dQQLSvgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751990160; c=relaxed/simple;
	bh=cW/FeaAa4ouB2tvExXI5bqbv6dXMHBhnMP4ARZE0XZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PkILO0zv8FVFQw2Xloy34DFOUMZRBsEFYtM/C9rDkdBHK7+70IHaOuaqahFsAHCuw06KYEYBYt3M4hN7kHTGEEXizvYEWxQ0JzvrUCtl3iKLMmXjLZBeSrvhMHOEPykgjKIBzgmuWNLFjiUPhENJwyKLmN/0y2dLHpxBcmYNGj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V3UMua6J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADA4CC4CEF6;
	Tue,  8 Jul 2025 15:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751990160;
	bh=cW/FeaAa4ouB2tvExXI5bqbv6dXMHBhnMP4ARZE0XZY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3UMua6JnBJMbj5vlUoSxel5trbAk6rhs1aYv27O9bayIDsDBp1Gd4hibSNofGSOE
	 Kzb3sKyRLr0xhbFD2Z5a4eMrEDkrJysw8myIbPN26wER5dV/IEgF6V22h5UOGvzxBz
	 eSfZq5IWM7F8WPCleVNIMPvOEhGM2lYh0V+gBGdmS7H0s7UANF2Cj4ld6oPyffExUP
	 lSdMUBZV4xc/P21NlMsbykxH4tI2nCAQO5dmhnNwSleAzul7ZDUI7bA5eyqU2YWSqX
	 RViuv/qkxWijKP5+L+qhSXGbFHZPqefX9m6pl0feTlQC1+Kmu531L8is7IrHwR7SOR
	 SRigN517QA1xg==
Date: Tue, 8 Jul 2025 16:55:54 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, andrew@lunn.ch,
	przemyslaw.kitszel@intel.com, anthony.l.nguyen@intel.com,
	sgoutham@marvell.com, gakula@marvell.com, sbhatta@marvell.com,
	bbhushan2@marvell.com, tariqt@nvidia.com, mbloch@nvidia.com,
	leon@kernel.org, gal@nvidia.com, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v3 1/5] eth: otx2: migrate to the *_rxfh_context
 ops
Message-ID: <20250708155554.GN452973@horms.kernel.org>
References: <20250707184115.2285277-1-kuba@kernel.org>
 <20250707184115.2285277-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707184115.2285277-2-kuba@kernel.org>

On Mon, Jul 07, 2025 at 11:41:11AM -0700, Jakub Kicinski wrote:
> otx2 only supports additional indirection tables (no separate keys
> etc.) so the conversion to dedicated callbacks and core-allocated
> context is mostly removing the code which stores the extra tables
> in the driver. Core already stores the indirection tables for
> additional contexts, and doesn't call .get for them.
> 
> One subtle change here is that we'll now start with the table
> covering all queues, not directing all traffic to queue 0.
> This is what core expects if the user doesn't pass the initial
> indir table explicitly (there's a WARN_ON() in the core trying
> to make sure driver authors don't forget to populate ctx to
> defaults).
> 
> Drivers implementing .create_rxfh_context don't have to set
> cap_rss_ctx_supported, so remove it.
> 
> Tested-by: Geetha Sowjanya <gakula@marvell.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


