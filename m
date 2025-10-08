Return-Path: <netdev+bounces-228209-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id BA411BC4C30
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 14:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A90444F1A2D
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 12:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE803222581;
	Wed,  8 Oct 2025 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LpqB4cHE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A3F12116F6
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759926067; cv=none; b=LEn3+xTurf12wh/80q4LG9kJp8fs+yAS+8wOg4bTwePC0CtykFb+BAtZJt+srkplf/ur4eUezh2E/9a4g8Ump3CfH2XIWr6aZhDhXkaDx7xj5Mc1Tj3SZm8nwRWIS5uhEfvKLUJKWfNdDUrmpnTvkgJhRyrTrYoOmw6/WSNWhlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759926067; c=relaxed/simple;
	bh=FX5RNl1lzqNqGngAP/VMyHZqqJPFd4CjDybomC/qQD0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+vt/5aC4hve4qX8ZAjaY53kxZQHcUE7Vx2JKteH7bmFea9pLC6cF6XXBzSNSdHM2n/skJUJexWzd7VjsMaZtUByZpxj2CWNgnldS6ugrFPr7OUHwLt8IcLrrLAMcK0YVDbpIjOXzaru3nT2vdJ1vH/nN0IsN40KpbT+AwGDojo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LpqB4cHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9A9FC4CEF4;
	Wed,  8 Oct 2025 12:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759926065;
	bh=FX5RNl1lzqNqGngAP/VMyHZqqJPFd4CjDybomC/qQD0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LpqB4cHEzV3WxfqGZ7LfwhovKKvl94dtsby+Cm4kBdfmiXSDnfVM0F9jasnZT3kai
	 7CbGvnoa7VdnCy590RYRz0I7xONNBPVtSYL2lWFuNoDGUxd8xvlEaLNEBcqrZCgmmG
	 /xb2x1evyunFYDmlDj5ihkuQAvx1wHq5HHZCF8BR7G9BIYVUItmB+EBywNW3ysbR4F
	 G31jIvx04EGk7YIM+wtQ4K5EeIofHex/CNJkSkVmXTimRGgw4zz1GvTI7FGW/D666D
	 3Hkq7MW/98DzzvT9+mUFpvADQ1kIR67U4VXzYPPWkB7yQWYfGy/YScg0vuNJ7McEhd
	 dxr37tvjsmE0g==
Date: Wed, 8 Oct 2025 13:21:01 +0100
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Dan Nowlin <dan.nowlin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] ice: fix usage of logical PF id
Message-ID: <20251008122101.GQ3060232@horms.kernel.org>
References: <20251008102853.1058695-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251008102853.1058695-1-grzegorz.nitka@intel.com>

On Wed, Oct 08, 2025 at 12:28:53PM +0200, Grzegorz Nitka wrote:
> In some devices, the function numbers used are non-contiguous. For
> example, here is such configuration for E825 device:
> 
> root@/home/root# lspci -v | grep Eth
> 0a:00.0 Ethernet controller: Intel Corporation Ethernet Connection
> E825-C for backplane (rev 04)
> 0a:00.1 Ethernet controller: Intel Corporation Ethernet Connection
> E825-C for backplane (rev 04)
> 0a:00.4 Ethernet controller: Intel Corporation Ethernet Connection
> E825-C 10GbE (rev 04)
> 0a:00.5 Ethernet controller: Intel Corporation Ethernet Connection
> E825-C 10GbE (rev 04)
> 
> When distributing RSS and FDIR masks, which are global resources across
> the active devices, it is required to have a contiguous PF id, which can
> be described as a logical PF id. In the case above, function 0 would
> have a logical PF id of 0, function 1 would have a logical PF id
> of 1, and functions 4 and 5 would have a logical PF ids 2 and 3
> respectively.
> Using logical PF id can properly describe which slice of resources can
> be used by a particular PF.
> 
> The 'function id' to 'logical id' mapping has been introduced with the
> commit 015307754a19 ("ice: Support VF queue rate limit and quanta size
> configuration"). However, the usage of 'logical_pf_id' field was
> unintentionally skipped for profile mask configuration.
> Fix it by using 'logical_pf_id' instead of 'pf_id' value when configuring
> masks.
> 
> Without that patch, wrong indexes, i.e. out of range for given PF, can
> be used while configuring resources masks, which might lead to memory
> corruption and undefined driver behavior.
> The call trace below is one of the examples of such error:
> 
> [  +0.000008] WARNING: CPU: 39 PID: 3830 at drivers/base/devres.c:1095
> devm_kfree+0x70/0xa0
> [  +0.000002] RIP: 0010:devm_kfree+0x70/0xa0
> [  +0.000001] Call Trace:
> [  +0.000002]  <TASK>
> [  +0.000002]  ice_free_hw_tbls+0x183/0x710 [ice]
> [  +0.000106]  ice_deinit_hw+0x67/0x90 [ice]
> [  +0.000091]  ice_deinit+0x20d/0x2f0 [ice]
> [  +0.000076]  ice_remove+0x1fa/0x6a0 [ice]
> [  +0.000075]  pci_device_remove+0xa7/0x1d0
> [  +0.000010]  device_release_driver_internal+0x365/0x530
> [  +0.000006]  driver_detach+0xbb/0x170
> [  +0.000003]  bus_remove_driver+0x117/0x290
> [  +0.000007]  pci_unregister_driver+0x26/0x250
> 
> Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size configuration")
> Suggested-by: Dan Nowlin <dan.nowlin@intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


