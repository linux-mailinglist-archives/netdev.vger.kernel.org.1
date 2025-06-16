Return-Path: <netdev+bounces-198206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF12EADB95C
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 21:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B54C63AFBD2
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 19:12:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 626A8288C3C;
	Mon, 16 Jun 2025 19:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pp5MIYzy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0AA2868A5
	for <netdev@vger.kernel.org>; Mon, 16 Jun 2025 19:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750101165; cv=none; b=d2wfTEpJXKaPL8o9jE02/4SzGSLGIjPbtrL3nRsmxzDpa0tLFC3INywfwfLr6ZpA+qwufiweaDU75MARxHXP6dXU9QvRgFGaulZ4o/Nuyd4jK3neF0tyArAMvAANsMwqsxtBoKRqxaPpIsJ4AMuGgl++OtNfepyMCbx4EkjSqbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750101165; c=relaxed/simple;
	bh=qVJC0Jq5poFM3IBhFjuHL+kZQBVPM3oCduYAggCip+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=stTVRKREtuIRMxCa/oidmwSZeQ7g4GRDgQ6huI6mDghJGt0T0Lj5Brbv4Qrz+y0gW9hWH6UFi5stUZEaZUSjBHmKjW+EHWLKzUjofT1vixJ7SZHvSdT1M4dU3jtT+X/4oemanoRPKhD8VNDRoEaBPpAHqMSgIG8EDJG1M0+qZeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pp5MIYzy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A741C4CEEA;
	Mon, 16 Jun 2025 19:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750101164;
	bh=qVJC0Jq5poFM3IBhFjuHL+kZQBVPM3oCduYAggCip+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pp5MIYzyAJc1jvP6rGC+ozGOdEWsK81CRpRE0pvrgMo4gtsYAUdkWBFisrAQdxVDk
	 ebHtq+OHl/DZ8tAUHG1K7hjSQg9sCNR5mnPxjQNyRbF8oAx/829qzWOoetCNMzmlsZ
	 EIygLJbSrCbgv/SlaNEqCIToUPKrfzEwHO9FtbTdpEdUp1a4oLXK/E/s77SNTFC+8u
	 nAukyDgxIQT82XvB/2jUIWl/6VmfU7vK4q5XhXY9zTFJO8YWuVCHocBhOPRbDN1Lwj
	 amLNlvNbna4LgUEoufL4n5FSYZW4u0nd09rmHmEEpZsJYcSUSa4ILPUvlP2wI59/X/
	 mD1bBm+hvX4zQ==
Date: Mon, 16 Jun 2025 20:12:41 +0100
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v1] ixgbe: initialize aci.lock before it's used
Message-ID: <20250616191241.GA5000@horms.kernel.org>
References: <20250616133636.1304288-1-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250616133636.1304288-1-jedrzej.jagielski@intel.com>

On Mon, Jun 16, 2025 at 03:36:36PM +0200, Jedrzej Jagielski wrote:
> Currently aci.lock is initialized too late. A bunch of ACI callbacks
> using the lock are called prior it's initialized.
> 
> Commit 337369f8ce9e ("locking/mutex: Add MUTEX_WARN_ON() into fast path")
> highlights that issue what results in call trace.
> 
> [    4.092899] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> [    4.092910] WARNING: CPU: 0 PID: 578 at kernel/locking/mutex.c:154 mutex_lock+0x6d/0x80
> [    4.098757] Call Trace:
> [    4.098847]  <TASK>
> [    4.098922]  ixgbe_aci_send_cmd+0x8c/0x1e0 [ixgbe]
> [    4.099108]  ? hrtimer_try_to_cancel+0x18/0x110
> [    4.099277]  ixgbe_aci_get_fw_ver+0x52/0xa0 [ixgbe]
> [    4.099460]  ixgbe_check_fw_error+0x1fc/0x2f0 [ixgbe]
> [    4.099650]  ? usleep_range_state+0x69/0xd0
> [    4.099811]  ? usleep_range_state+0x8c/0xd0
> [    4.099964]  ixgbe_probe+0x3b0/0x12d0 [ixgbe]
> [    4.100132]  local_pci_probe+0x43/0xa0
> [    4.100267]  work_for_cpu_fn+0x13/0x20
> [    4.101647]  </TASK>
> 
> Move aci.lock mutex initialization to ixgbe_sw_init() before any ACI
> command is sent. Along with that move also related SWFW semaphore in
> order to reduce size of ixgbe_probe() and that way all locks are
> initialized in ixgbe_sw_init().
> 
> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Fixes: 4600cdf9f5ac ("ixgbe: Enable link management in E610 device")
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


