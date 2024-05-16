Return-Path: <netdev+bounces-96703-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E278C7343
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 10:51:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2119BB2257E
	for <lists+netdev@lfdr.de>; Thu, 16 May 2024 08:51:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F443142E9A;
	Thu, 16 May 2024 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxUsmz7F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ACFF142912
	for <netdev@vger.kernel.org>; Thu, 16 May 2024 08:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715849484; cv=none; b=NyoBcrmbilmEzR+bcflJkHb+I7b2/chn/6Tb602f4rbPItn5J7F37DzZUTecqnhFkX9LlE+qnM9M0Hc5ZrZEFlA+BlQSUA98hqGp0Vp/EfexcKGh8NN9hZCjexazv+T8KSLCaMrEOTqwm/pmyrvKSAf5p0NEVGcGYyYr6g5yT8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715849484; c=relaxed/simple;
	bh=I5XT4HQfyi/PAmbRApUltU4BvP++sYH39v7g9t/4tII=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IHaX9/9S+BhWBR4qp8Om7lMzyc+fxC4j3O70bqNrfosITCBtlAtBJzCQia/+GHksUhNOygaQDdfOxc24c2Yhr72RZ5gQkGOXAmIXyVvkyaGMvoD4Pzs0CIxp6m1eR+9tux6MOQ63uI/e1k8US3vrUVNhyge/0KPYABgTvzvfiT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxUsmz7F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAFFC32786;
	Thu, 16 May 2024 08:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715849484;
	bh=I5XT4HQfyi/PAmbRApUltU4BvP++sYH39v7g9t/4tII=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DxUsmz7FK+7WpvKJ9zX9pZcHYj9fzzbFyG0beyeCnBdvIFGE3KcZiegr/rG6otBwV
	 RrZenC5yfVcMu7IAg33D/xOM5ebHTTJlt/TLOFWvNJb9pE/NkPWKyjIrxdw/clMPtu
	 UFkA6MuryDIEpzIfbaCPxYSb7nU4kYUOCf+2yevR7Bmo3qrvlaWcXHLgUG3m/kDPO1
	 qBuYg82rgcK0WrE5rdid0fwKDVhVG1iXAgxR1ssK9NE1q5rhLBz/eOihq8kcj9uYCW
	 +m0TSxhambgZ9yjlIMwRyAzgkCT9TuXTaOCeOd9Vk6lqQLbRIhJmVrss1l4izBhYQL
	 d2T7fcLv8y5xw==
Date: Thu, 16 May 2024 09:51:19 +0100
From: Simon Horman <horms@kernel.org>
To: Thinh Tran <thinhtr@linux.ibm.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com,
	pmenzel@molgen.mpg.de, jesse.brandeburg@intel.com,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org, rob.thomas@ibm.com,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH iwl-net V4,2/2] i40e: Fully suspend and resume IO
 operations in EEH case
Message-ID: <20240516085119.GH179178@kernel.org>
References: <20240515210705.620-1-thinhtr@linux.ibm.com>
 <20240515210705.620-3-thinhtr@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240515210705.620-3-thinhtr@linux.ibm.com>

On Wed, May 15, 2024 at 04:07:05PM -0500, Thinh Tran wrote:
> When EEH events occurs, the callback functions in the i40e, which are
> managed by the EEH driver, will completely suspend and resume all IO
> operations.
> 
> - In the PCI error detected callback, replaced i40e_prep_for_reset()
>   with i40e_io_suspend(). The change is to fully suspend all I/O
>   operations
> - In the PCI error slot reset callback, replaced pci_enable_device_mem()
>   with pci_enable_device(). This change enables both I/O and memory of
>   the device.
> - In the PCI error resume callback, replaced i40e_handle_reset_warning()
>   with i40e_io_resume(). This change allows the system to resume I/O
>   operations
> 
> Fixes: a5f3d2c17b07 ("powerpc/pseries/pci: Add MSI domains")
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Robert Thomas <rob.thomas@ibm.com>
> Signed-off-by: Thinh Tran <thinhtr@linux.ibm.com>

Reviewed-by: Simon Horman <horms@kernel.org>

