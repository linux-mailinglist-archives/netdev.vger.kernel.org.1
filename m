Return-Path: <netdev+bounces-170380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B95A48692
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFDC91639E6
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 17:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A57E51DE2AA;
	Thu, 27 Feb 2025 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enwMmSL1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80F711CB9EA
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 17:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740677247; cv=none; b=XtdGQcH23sSkRSce27s3z+RJYqRgKGvme1eFhHennoE8qVewkYLa/DzSdEtsKGLv7gvoshAm7S3ZE1TyE9xvdbYfFrzkzfkMP2QM6pGqcGoz2FSncdUdv7Fzzdj/e296aqNmAS0FbFxLJAqPvHCEsEsRRiSK7lsC9fhqm/L/gXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740677247; c=relaxed/simple;
	bh=3rbgKRdPD57Q4504inUanYwfL6bZjk7Ar3Z9m1kYk8U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQvThgjwLYyvmv/YcNFFtJDKfGwzqClimDc2tle1Ikc8C5qb8SWIEnGHz11W9OFh3u5kVmvhEKB68wFNWvFm7Fqx2gtrc0anp62Ma6Zr71RxY+HK4jaM/y20KiRXF2h9nP7Db0MSGMHkiGIOhYdWlgtNuq0zIry5Pt3Cz06kqcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enwMmSL1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA61EC4CEDD;
	Thu, 27 Feb 2025 17:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740677247;
	bh=3rbgKRdPD57Q4504inUanYwfL6bZjk7Ar3Z9m1kYk8U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=enwMmSL1/rsdzfIYr8EZwClm9n5DN/KczIfu5ZOLTIJke0YNXaNWs8JQkh4gidrLr
	 sgaqcHu5EYUf3T2noL7fw7ATnbwcRAUwPslurErbY0Vamw8d5XM2lMSyTNnJCATQe7
	 4T8c4jLs2nXkqV9zAP+pGaPY9ZsO8d1aoa3orasd7YcdHKHI87usXvfsTrcBlksihu
	 Na40zuhZSoiCHu+2Ed+IVNvfPfYuq9vmdkitoUrMEWvuUYZZPby0WA6cNCtaQiconA
	 Pc+MrVdDLJ3BWanxm3sd4KKGiV29NefHy0x99lBoprjKbs8cg1bjJp2FBxGwe6ylHR
	 JS5KTjT7zNzhg==
Date: Thu, 27 Feb 2025 17:27:23 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-net v1] ice: fix lane number calculation
Message-ID: <20250227172723.GG1615191@kernel.org>
References: <20250221093949.2436728-1-grzegorz.nitka@intel.com>
 <20250225095021.GK1615191@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225095021.GK1615191@kernel.org>

On Tue, Feb 25, 2025 at 09:50:21AM +0000, Simon Horman wrote:
> On Fri, Feb 21, 2025 at 10:39:49AM +0100, Grzegorz Nitka wrote:
> > E82X adapters do not have sequential IDs, lane number is PF ID.
> > 
> > Add check for ICE_MAC_GENERIC and skip checking port options.
> 
> This I see.

Sorry, this was part of an earlier draft. Please ignore.

> 
> > 
> > Also, adjust logical port number for specific E825 device with external
> > PHY support (PCI device id 0x579F). For this particular device,
> > with 2x25G (PHY0) and 2x10G (PHY1) port configuration, modification of
> > pf_id -> lane_number mapping is required. PF IDs on the 2nd PHY start
> > from 4 in such scenario. Otherwise, the lane number cannot be
> > determined correctly, leading to PTP init errors during PF initialization.
> > 
> > Fixes: 258f5f9058159 ("ice: Add correct PHY lane assignment")
> > Co-developed-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > Signed-off-by: Karol Kolacinski <karol.kolacinski@intel.com>
> > Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> > Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Reviewed-by: Milena Olech <milena.olech@intel.com>
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

I only meant to send this part :)

