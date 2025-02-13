Return-Path: <netdev+bounces-165968-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E36A33D0E
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:55:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E3F4162EA1
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13A521324D;
	Thu, 13 Feb 2025 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="epg7CZ1s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3162080D4
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 10:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739444129; cv=none; b=JYscA0vs5qX5Y8BP27HFAEwCwuRKyEKDnmDqUDewJ9MKXvBm+1uqhmFcu2a2YBTN/oj5L9yT2rZUvlz5Q4iJ802gzcYZSe3rACGJmDqEMrj4INuYIcqVV32mMMVg7LcSLqwNxN8JBYToq5Q+xpnb553qTj0DDOzhsPVS1vSVuBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739444129; c=relaxed/simple;
	bh=6VBoxXaCyubvpY/RxuiFUTB3h2ZWmYG5OjQhekDJns8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gHskkiM+Ux+BZhkbb5xu6Uiw2ZbkQlJDxfInQT7fJH3K79Sb89d6Hg5339Bk3F1DkNUh4b327LsfoZsSGKLOGCfBt5pHRG5H9KpqHhrnUk6e03iXvG55vMvoqBdBDY8zoApzYjpSmh0iewRHjJwO2rwyYBiZ7zBawxWDTOrXi2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epg7CZ1s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE900C4CEE2;
	Thu, 13 Feb 2025 10:55:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739444129;
	bh=6VBoxXaCyubvpY/RxuiFUTB3h2ZWmYG5OjQhekDJns8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=epg7CZ1sf9NcK+DmFPVrXBW9PWIaxkcIaoMPQWOYCVT0XSZuhNLYn3DpWNHmODj5Y
	 K6ESEyvf+OFkkKN5/sELTRPcvtIwqKBtWvYRQGDQHVzPbYb0w64s9leEPlfIUgQiwF
	 O2/xXtolDLWl3iJjAXak2JYiF/fFzMfqWNNk4wD3tr0YbkIOMrFvrJt4JInGtg9K11
	 v3HcWVgIfjhUr0bk7vaSnvM62uFgPk0OQNZeCETvIHKNg5khJgBF7XZ7qIcpex3FRn
	 fezGQNrGQUjsJ6jsCDnU4fpyzSkbV7XX70H/mLvShfysAKLwkKN7JkR4w3buk7BZp+
	 wXkEYH57j5VMA==
Date: Thu, 13 Feb 2025 10:55:25 +0000
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: Re: [PATCH iwl-net 1/2] ice: Fix deinitializing VF in error path
Message-ID: <20250213105525.GJ1615191@kernel.org>
References: <20250211174322.603652-1-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211174322.603652-1-marcin.szycik@linux.intel.com>

On Tue, Feb 11, 2025 at 06:43:21PM +0100, Marcin Szycik wrote:
> If ice_ena_vfs() fails after calling ice_create_vf_entries(), it frees
> all VFs without removing them from snapshot PF-VF mailbox list, leading
> to list corruption.
> 
> Reproducer:
>   devlink dev eswitch set $PF1_PCI mode switchdev
>   ip l s $PF1 up
>   ip l s $PF1 promisc on
>   sleep 1
>   echo 1 > /sys/class/net/$PF1/device/sriov_numvfs

Should the line above be "echo 0" to remove the VFs before creating VFs
below (I'm looking at sriov_numvfs_store())?

>   sleep 1
>   echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
> 
> Trace (minimized):
>   list_add corruption. next->prev should be prev (ffff8882e241c6f0), but was 0000000000000000. (next=ffff888455da1330).
>   kernel BUG at lib/list_debug.c:29!
>   RIP: 0010:__list_add_valid_or_report+0xa6/0x100
>    ice_mbx_init_vf_info+0xa7/0x180 [ice]
>    ice_initialize_vf_entry+0x1fa/0x250 [ice]
>    ice_sriov_configure+0x8d7/0x1520 [ice]
>    ? __percpu_ref_switch_mode+0x1b1/0x5d0
>    ? __pfx_ice_sriov_configure+0x10/0x10 [ice]
> 
> Sometimes a KASAN report can be seen instead with a similar stack trace:
>   BUG: KASAN: use-after-free in __list_add_valid_or_report+0xf1/0x100
> 
> VFs are added to this list in ice_mbx_init_vf_info(), but only removed
> in ice_free_vfs(). Move the removing to ice_free_vf_entries(), which is
> also being called in other places where VFs are being removed (including
> ice_free_vfs() itself).
> 
> Fixes: 8cd8a6b17d27 ("ice: move VF overflow message count into struct ice_mbx_vf_info")
> Reported-by: Sujai Buvaneswaran <sujai.buvaneswaran@intel.com>
> Closes: https://lore.kernel.org/intel-wired-lan/PH0PR11MB50138B635F2E5CEB7075325D961F2@PH0PR11MB5013.namprd11.prod.outlook.com
> Reviewed-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>

The comment above notwithstanding, I agree that this addresses the
bug you have described.

Reviewed-by: Simon Horman <horms@kernel.org>


