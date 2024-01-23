Return-Path: <netdev+bounces-65155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D99DD8395ED
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 925392874A4
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9B9280030;
	Tue, 23 Jan 2024 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGJbio0O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8596C187A
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 17:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029653; cv=none; b=e2FlHS6aJDC1fCH0yDIIzYG1THPPu4DiGaRvpq7ryLLGXmLgwfl5kNLH/YBElcnr7UHUFCPCjvclEbDQO7hGzCRVbDh2Hs1HmKbQuQWU65GtXLBS4wQcwQ0Bt56Tpk4tE8nWWerPIPJqJ/2D2bOIMBjQnLKuuztYnLFOlBSQAzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029653; c=relaxed/simple;
	bh=y05+6U/j3fJ0ntOJAyCTQ2S/MJtrJuT/kbavnLl+T2Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jRWSQZzQDsXvCxC1b+vtesdK2vhDpZm9KqHW6ZlEA+syNw/4lCR/1Ln1GfbFD/Q64U393rB6t8YXT+yWxQURZ/EfD7JB+QgC53zSwVjiR9I/PayCdy1nSDU7fzH0nNKvBT081+m2v9WhkhEePTJbIFMWDezSKXQH3bxJiOyfJd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGJbio0O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 855C1C433F1;
	Tue, 23 Jan 2024 17:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706029652;
	bh=y05+6U/j3fJ0ntOJAyCTQ2S/MJtrJuT/kbavnLl+T2Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nGJbio0OGdmtmKdgZlzUjT6+5cJlWI0WnZofCnh3QbgEV5jG2+GxWwD4G5OluOjfr
	 gz2xjbYcUduAvxZ9heWCEmuz+Y9VmCfiXQ5DQpwD/wmLsdMBStVGJIuTuVZc2XDk/v
	 kqt0Uxb1qL+HKBtULxPcWsSb9KV3zwcdkyE5chccvQWR5jPFD77cvdJ3wRYLiqoGk6
	 k79TqXOBZ+kqYYm2S/MVTu/IL75CNUfwIPu9FUso/44Hsu0fk8mX284QSmbtofJMP2
	 INt1Rg3d7b77o0VXJHKonJOzAYIFVHdnCrzxCRaBuvzjmYzzkiSHp35iDenodOlAvK
	 5j3xgBZPCleDg==
Date: Tue, 23 Jan 2024 17:07:29 +0000
From: Simon Horman <horms@kernel.org>
To: Karol Kolacinski <karol.kolacinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com, jesse.brandeburg@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v7 iwl-next 7/7] ice: stop destroying and reinitalizing
 Tx tracker during reset
Message-ID: <20240123170729.GM254773@kernel.org>
References: <20240123105131.2842935-1-karol.kolacinski@intel.com>
 <20240123105131.2842935-8-karol.kolacinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240123105131.2842935-8-karol.kolacinski@intel.com>

On Tue, Jan 23, 2024 at 11:51:31AM +0100, Karol Kolacinski wrote:
> From: Jacob Keller <jacob.e.keller@intel.com>
> 
> The ice driver currently attempts to destroy and re-initialize the Tx
> timestamp tracker during the reset flow. The release of the Tx tracker
> only happened during CORE reset or GLOBAL reset. The ice_ptp_rebuild()
> function always calls the ice_ptp_init_tx function which will allocate
> a new tracker data structure, resulting in memory leaks during PF reset.
> 
> Certainly the driver should not be allocating a new tracker without
> removing the old tracker data, as this results in a memory leak.
> Additionally, there's no reason to remove the tracker memory during a
> reset. Remove this logic from the reset and rebuild flow. Instead of
> releasing the Tx tracker, flush outstanding timestamps just before we
> reset the PHY timestamp block in ice_ptp_cfg_phy_interrupt().
> 
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
> Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


