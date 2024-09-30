Return-Path: <netdev+bounces-130434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD8398A7D0
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 16:53:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C3A286197
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 14:53:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1354D192D68;
	Mon, 30 Sep 2024 14:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TvuyuIfu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B5A19048F
	for <netdev@vger.kernel.org>; Mon, 30 Sep 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727707905; cv=none; b=gUjV6fWFqHeAL/3w0B3N9LGRPP+PyUTHllK7hX8XfTgutGT0CTRg7o0IB4HPlidWpJWkK4FXRAGuLu/3VAwb/qhfpwlWgvQgB1pNnI97F4eF5oMOj0XQBUnXqdBq6Puhxre4wYhrYh8Y4HGmvvoZuJGWYcff+aPNzQ8ghJfpRac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727707905; c=relaxed/simple;
	bh=LZ21acJUlmDDdoVxxT6yhtqKNPjH/hUR3in9MD3hqRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X1M3/LUxp6U+lNf8ow+no1NbgsB9jhrHOLOwHjHe/d8n2PsZUUYYgjDvF9Qrx3yNP8IVzMtTeedy1Ot9V+Ow3qg4RQ6ENQabBhXCfUVf+fdgtP/dHozRReljZiq4H7ejyHS/06z0wsOrULaviyy53oVcUkiN/hWwmTegxTvWBkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TvuyuIfu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42308C4CEC7;
	Mon, 30 Sep 2024 14:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727707904;
	bh=LZ21acJUlmDDdoVxxT6yhtqKNPjH/hUR3in9MD3hqRY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TvuyuIfuvpOehNOb3T8RpTBQDz6/Ti0x2fX/7+fSvH51jGhHa5VuSlI4jWnsu/LAm
	 6mgdrQN6Mio8noBQMclZPmPvOkiqZyhNoww/TzMcBX0PoXnVPdM7pPdQ3rZiqOGU7N
	 NIRjoIBkjtdPWAnuQrnLz3Swrp+hj1dq8d+l72KTU6Zs0UKdEWa6SB7GdC6gKkMSN4
	 MdOOtyVeWn11halzjPsjFBG7YHgsxxs9q6r9zp0befdiKOwEwITn5yjbn5xT2hoO9s
	 1G6QZoI91nrylsl7BOOiLdu5ouONh+Xk2t0/eBskWenqlJh4p0c3jKriExlHIb9FvB
	 ewTmZsBCsX2Tg==
Date: Mon, 30 Sep 2024 15:51:41 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	przemyslaw.kitszel@intel.com,
	Jacob Keller <jacob.e.keller@intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-net] ice: Fix increasing MSI-X on VF
Message-ID: <20240930145141.GA1310185@kernel.org>
References: <20240927151541.15704-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240927151541.15704-1-marcin.szycik@linux.intel.com>

On Fri, Sep 27, 2024 at 05:15:40PM +0200, Marcin Szycik wrote:
> Increasing MSI-X value on a VF leads to invalid memory operations. This
> is caused by not reallocating some arrays.
> 
> Reproducer:
>   modprobe ice
>   echo 0 > /sys/bus/pci/devices/$PF_PCI/sriov_drivers_autoprobe
>   echo 1 > /sys/bus/pci/devices/$PF_PCI/sriov_numvfs
>   echo 17 > /sys/bus/pci/devices/$VF0_PCI/sriov_vf_msix_count
> 
> Default MSI-X is 16, so 17 and above triggers this issue.
> 
> KASAN reports:
> 
>   BUG: KASAN: slab-out-of-bounds in ice_vsi_alloc_ring_stats+0x38d/0x4b0 [ice]
>   Read of size 8 at addr ffff8888b937d180 by task bash/28433
>   (...)
> 
>   Call Trace:
>    (...)
>    ? ice_vsi_alloc_ring_stats+0x38d/0x4b0 [ice]
>    kasan_report+0xed/0x120
>    ? ice_vsi_alloc_ring_stats+0x38d/0x4b0 [ice]
>    ice_vsi_alloc_ring_stats+0x38d/0x4b0 [ice]
>    ice_vsi_cfg_def+0x3360/0x4770 [ice]
>    ? mutex_unlock+0x83/0xd0
>    ? __pfx_ice_vsi_cfg_def+0x10/0x10 [ice]
>    ? __pfx_ice_remove_vsi_lkup_fltr+0x10/0x10 [ice]
>    ice_vsi_cfg+0x7f/0x3b0 [ice]
>    ice_vf_reconfig_vsi+0x114/0x210 [ice]
>    ice_sriov_set_msix_vec_count+0x3d0/0x960 [ice]
>    sriov_vf_msix_count_store+0x21c/0x300
>    (...)
> 
>   Allocated by task 28201:
>    (...)
>    ice_vsi_cfg_def+0x1c8e/0x4770 [ice]
>    ice_vsi_cfg+0x7f/0x3b0 [ice]
>    ice_vsi_setup+0x179/0xa30 [ice]
>    ice_sriov_configure+0xcaa/0x1520 [ice]
>    sriov_numvfs_store+0x212/0x390
>    (...)
> 
> To fix it, use ice_vsi_rebuild() instead of ice_vf_reconfig_vsi(). This
> causes the required arrays to be reallocated taking the new queue count
> into account (ice_vsi_realloc_stat_arrays()). Set req_txq and req_rxq
> before ice_vsi_rebuild(), so that realloc uses the newly set queue
> count.
> 
> Additionally, ice_vsi_rebuild() does not remove VSI filters
> (ice_fltr_remove_all()), so ice_vf_init_host_cfg() is no longer
> necessary.
> 
> Reported-by: Jacob Keller <jacob.e.keller@intel.com>
> Fixes: 2a2cb4c6c181 ("ice: replace ice_vf_recreate_vsi() with ice_vf_reconfig_vsi()")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


