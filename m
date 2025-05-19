Return-Path: <netdev+bounces-191578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D74ABC405
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 18:14:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C649188BDD2
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 16:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ABD1288C01;
	Mon, 19 May 2025 16:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qXeDQVaf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA26A288C00
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 16:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747670753; cv=none; b=tyZ4MxSXcRYH6TRS+s9ksfTZL+k/RIQr2k84itoFFiSMIp2jT8npM9j6HCUExagD2qPBAg9egCtWiHrxbP0yCwMv7AMUiS7Hg/7RAYV/EExfF9i/eCY2IlQ3UlTMIVgNZwpPZyKCBPxwusvCkwOMiTwK+xZnz84PSa9RAHhvzqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747670753; c=relaxed/simple;
	bh=Rm3KTeILiUDBIswH6YVbkOFEww5Wgl0ZpJZ/oj5TAEs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aoQ5FmUfDwy9oUJOJUtLmwZwkd+PaJ6L9+Bcj1T0+ykWR3ZwJaDFWAo20bESFDvDNaWDeOmWfbclw7B4qMVP3ADF4Ohdf7xmWofBgYgi4OBRiFjvRWCAs0PyJdtx7v2maRLtPZhlJi/cagTryj0qUgQKBc7tKKGZQm6x8mC0m2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qXeDQVaf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B02C4CEE4;
	Mon, 19 May 2025 16:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747670752;
	bh=Rm3KTeILiUDBIswH6YVbkOFEww5Wgl0ZpJZ/oj5TAEs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qXeDQVafH+3dQwLmPUalQfD9ZIoGeTiNff0Mr8MRV9cdM1cdXQkPEm9qhiEhdkApb
	 BeeR7MPOhYoyQUnhcCxg8VIt+9tiBizsvfVCF/wx8mREUiQWFIntsKEUBaueT81G05
	 jsdo5I7zAWX7aLuSYx9MbAZ2eEodiT0tw8je3ZVrvd+bYPjf89DOvYVXa/id1HhExM
	 riK77jcZf6zAz8me1BfLXxmfdXa19Ed4sXuixvTvpoQpMT7gBjuPu7nCF7nqRMS1CW
	 sMI2CnNmE3ue4WTW7U553HiV4Vg6CC5QxVPX4GU7/tCk3b9PiDu0HleAFr9yBO28yy
	 4IawXJFKSWuGQ==
Date: Mon, 19 May 2025 17:05:49 +0100
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: fix eswitch code memory leak in reset
 scenario
Message-ID: <20250519160549.GK365796@horms.kernel.org>
References: <20250516130907.3503623-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516130907.3503623-1-grzegorz.nitka@intel.com>

On Fri, May 16, 2025 at 03:09:07PM +0200, Grzegorz Nitka wrote:
> Add simple eswitch mode checker in attaching VF procedure and allocate
> required port representor memory structures only in switchdev mode.
> The reset flows triggers VF (if present) detach/attach procedure.
> It might involve VF port representor(s) re-creation if the device is
> configured is switchdev mode (not legacy one).
> The memory was blindly allocated in current implementation,
> regardless of the mode and not freed if in legacy mode.
> 
> Kmemeleak trace:
> unreferenced object (percpu) 0x7e3bce5b888458 (size 40):
>   comm "bash", pid 1784, jiffies 4295743894
>   hex dump (first 32 bytes on cpu 45):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 0):
>     pcpu_alloc_noprof+0x4c4/0x7c0
>     ice_repr_create+0x66/0x130 [ice]
>     ice_repr_create_vf+0x22/0x70 [ice]
>     ice_eswitch_attach_vf+0x1b/0xa0 [ice]
>     ice_reset_all_vfs+0x1dd/0x2f0 [ice]
>     ice_pci_err_resume+0x3b/0xb0 [ice]
>     pci_reset_function+0x8f/0x120
>     reset_store+0x56/0xa0
>     kernfs_fop_write_iter+0x120/0x1b0
>     vfs_write+0x31c/0x430
>     ksys_write+0x61/0xd0
>     do_syscall_64+0x5b/0x180
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Testing hints (ethX is PF netdev):
> - create at least one VF
>     echo 1 > /sys/class/net/ethX/device/sriov_numvfs
> - trigger the reset
>     echo 1 > /sys/class/net/ethX/device/reset
> 
> Fixes: 415db8399d06 ("ice: make representor code generic")
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> 
> v1->v2: rebase, adding netdev mailing list

Reviewed-by: Simon Horman <horms@kernel.org>


