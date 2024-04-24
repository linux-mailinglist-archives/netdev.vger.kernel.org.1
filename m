Return-Path: <netdev+bounces-90975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B5D8B0D1C
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 16:48:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 833D91F26510
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 14:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03D5715ECFA;
	Wed, 24 Apr 2024 14:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2J8Mrve"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D021815D5C7
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 14:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713970116; cv=none; b=lenCozVFVc5ZDBTMuGJlRsIw/n+HdCqWVsxfra5/CnWihwBuM7dTHDE2TTVTvP9uX0F4dpL5l+KbG1HoUzY0V0tMGVIlhhP+dKnKzdhKPmEY0iXWkgRZdiJXLfyq+rjYIwpyf5fOx8cdYtfZzYShoaEA6ibDj8MWWnVjnHnWhko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713970116; c=relaxed/simple;
	bh=MtcBXVBoT7WsAzim0Ux670NdL79KlExVL9cJiDbfnQ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OZjD9SWsqaO3TQwqVxMJMLr2Nv8YaWTXL21yRLd44lcDuUuDORUXfmZpOvcyfR4JiKUQZPnyDfPzjF+N13FLB0Sv2w0wgIh8VU9EgCiZ8KtHS5syaEAqubFtioRC6vUNfsQH/WikyWLFOLCR880eTzIveZ04WXBnYyoljdoJdIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2J8Mrve; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D410C113CD;
	Wed, 24 Apr 2024 14:48:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713970116;
	bh=MtcBXVBoT7WsAzim0Ux670NdL79KlExVL9cJiDbfnQ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f2J8MrveEpoVMmjQC1mQP7g4aeEj5b4LwQZPrzrkeDT1feMN5rpweBoEAov6iBmDR
	 Qt6NfkpQVRXlcCC1Cf+SJMTA7bVZ7ca5e7oCQPdGdNHgJbflUNRcaUfQpsjS2Mix90
	 1A7mtLNoiaWpAEQU2peZeS+3lxLn3mZRIqGBt748zTaZBJ3jD1rLJYW/ev1NppHncx
	 8B+aJchG4gHUrM3SlZqEUKnyEF8/khq9lgVXSs9xH4FIa0UAcBqY6Wj5AHfLYBqiGe
	 pvYnV2HI3tjWs+rqjviHSweY4NTnSsECIqtahhZ3X6BtFU1KZzkcpTC6TGAz089bk0
	 LA89AjznsB/Jw==
Date: Wed, 24 Apr 2024 15:48:31 +0100
From: Simon Horman <horms@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>, Alexander Zubkov <green@qrator.net>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net 2/9] mlxsw: spectrum_acl_tcam: Fix race during rehash
 delayed work
Message-ID: <20240424144831.GD42092@kernel.org>
References: <cover.1713797103.git.petrm@nvidia.com>
 <1ec1d54edf2bad0a369e6b4fa030aba64e1f124b.1713797103.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ec1d54edf2bad0a369e6b4fa030aba64e1f124b.1713797103.git.petrm@nvidia.com>

On Mon, Apr 22, 2024 at 05:25:55PM +0200, Petr Machata wrote:
> From: Ido Schimmel <idosch@nvidia.com>
> 
> The purpose of the rehash delayed work is to reduce the number of masks
> (eRPs) used by an ACL region as the eRP bank is a global and limited
> resource.
> 
> This is done in three steps:
> 
> 1. Creating a new set of masks and a new ACL region which will use the
>    new masks and to which the existing filters will be migrated to. The
>    new region is assigned to 'vregion->region' and the region from which
>    the filters are migrated from is assigned to 'vregion->region2'.
> 
> 2. Migrating all the filters from the old region to the new region.
> 
> 3. Destroying the old region and setting 'vregion->region2' to NULL.
> 
> Only the second steps is performed under the 'vregion->lock' mutex
> although its comments says that among other things it "Protects
> consistency of region, region2 pointers".
> 
> This is problematic as the first step can race with filter insertion
> from user space that uses 'vregion->region', but under the mutex.
> 
> Fix by holding the mutex across the entirety of the delayed work and not
> only during the second step.
> 
> Fixes: 2bffc5322fd8 ("mlxsw: spectrum_acl: Don't take mutex in mlxsw_sp_acl_tcam_vregion_rehash_work()")
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> Tested-by: Alexander Zubkov <green@qrator.net>
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


