Return-Path: <netdev+bounces-161763-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BA7A23C07
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 11:13:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE1FB7A3F3F
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 10:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE9031898F2;
	Fri, 31 Jan 2025 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p9rqr1k4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88A381CA81
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 10:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738318383; cv=none; b=DuzaD6oYD/buU2ykvrp/u3Y5g+tMz115IkaTij+kCSOUQJ3snIOb78iiUerAkOrjAwvEFoYZch/f1MYiG0hT2342NYtVYdY3rB31RceMZvsR5h+IYE+m2bR5w4ZTEAIhOphzKf976pw2Z22wLfM4ayzewMBSi9Q8Fzyfarwl4W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738318383; c=relaxed/simple;
	bh=0u1rzgXw3P/ydx0WeR0XXW0LRcwGvHxJ7+/T518MBMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdAjVS5iaGbyATWG6OT1klAX3w7RNFJf1tG6LSa+ulE97Djb8ttnt5FzAiCknCviS8zqaClMQmfz52LJzQpDEwLKQ/RC6b8LAtUd5bzwoSSvZGklclG3mjkMokJILDtg5SNHrLqDIsFwj3+qFN3r8+dLJZDZxESARZv3vIN/iCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p9rqr1k4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF540C4CED1;
	Fri, 31 Jan 2025 10:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738318382;
	bh=0u1rzgXw3P/ydx0WeR0XXW0LRcwGvHxJ7+/T518MBMo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p9rqr1k42iz0ok2s4TGNi8gKOGB8Evewn9G6hOTqtixsiUEDQhN1d0heN5oFnJoOT
	 kBClfSa0BEkg+5Z2tP3P4bInzDfugbNNbYDM5n1E51/RBEP/dqKJIAkrMvTb1ehmi4
	 jCZc0Do/j7vuUJ1g0nPxUsYWJywIxuhnt4/T+nRSxZUWU19tS+8MhG/3iK5/wc+ThW
	 E8ZoTLKrpyZsf0JQt3fKSaK+KjsrA5dZB6Jrq/M3l/XCbTf38b0Av3NFYwiOEOuJJD
	 RRFHSHaW4BapDgEamdyz8y4xG4j4SasxTiJUUw5ZwCQ2x3nkUoG0RjHyNTDMxZoUEo
	 N5ZIMHWmi13PA==
Date: Fri, 31 Jan 2025 10:12:59 +0000
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: Re: [PATCH iwl-net v1] ice: fix memory leak in aRFS after reset
Message-ID: <20250131101259.GG24105@kernel.org>
References: <20250123081539.1814685-1-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250123081539.1814685-1-grzegorz.nitka@intel.com>

On Thu, Jan 23, 2025 at 09:15:39AM +0100, Grzegorz Nitka wrote:
> Fix aRFS (accelerated Receive Flow Steering) structures memory leak by
> adding a checker to verify if aRFS memory is already allocated while
> configuring VSI. aRFS objects are allocated in two cases:
> - as part of VSI initialization (at probe), and
> - as part of reset handling
> 
> However, VSI reconfiguration executed during reset involves memory
> allocation one more time, without prior releasing already allocated
> resources. This led to the memory leak with the following signature:
> 
> [root@os-delivery ~]# cat /sys/kernel/debug/kmemleak
> unreferenced object 0xff3c1ca7252e6000 (size 8192):
>   comm "kworker/0:0", pid 8, jiffies 4296833052
>   hex dump (first 32 bytes):
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>   backtrace (crc 0):
>     [<ffffffff991ec485>] __kmalloc_cache_noprof+0x275/0x340
>     [<ffffffffc0a6e06a>] ice_init_arfs+0x3a/0xe0 [ice]
>     [<ffffffffc09f1027>] ice_vsi_cfg_def+0x607/0x850 [ice]
>     [<ffffffffc09f244b>] ice_vsi_setup+0x5b/0x130 [ice]
>     [<ffffffffc09c2131>] ice_init+0x1c1/0x460 [ice]
>     [<ffffffffc09c64af>] ice_probe+0x2af/0x520 [ice]
>     [<ffffffff994fbcd3>] local_pci_probe+0x43/0xa0
>     [<ffffffff98f07103>] work_for_cpu_fn+0x13/0x20
>     [<ffffffff98f0b6d9>] process_one_work+0x179/0x390
>     [<ffffffff98f0c1e9>] worker_thread+0x239/0x340
>     [<ffffffff98f14abc>] kthread+0xcc/0x100
>     [<ffffffff98e45a6d>] ret_from_fork+0x2d/0x50
>     [<ffffffff98e083ba>] ret_from_fork_asm+0x1a/0x30
>     ...
> 
> Fixes: 28bf26724fdb ("ice: Implement aRFS")
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


