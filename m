Return-Path: <netdev+bounces-221309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA08BB501BA
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A863C1883C94
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B5422F0689;
	Tue,  9 Sep 2025 15:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCOGLnGE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB702265614
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 15:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432606; cv=none; b=NPzIVWv8NdejAOEhBn0570OuYsxYbD9Lc+VReCNOV601qOo+JuBqBNs1evvwbgLYAM5LRaSMsOuAU1tAGIbSx+Eoiag6JWFSQdWwZrXH2oDmegGeri8AZ4+unTP7glVPBrNPRMV2q+Dp0nhWbeYp+TGkJlZuxxxLz534hvCTez8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432606; c=relaxed/simple;
	bh=fXPPeMKvaera8ovcQMSzAU21wcQMEHgyCpGtqBdp7ns=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YjGZF0oIAOObN1mMBI8LB4YTAOaZ3UUGjyFfn+LjENXi/CzmS6Nh1xohhC/Q0hg8GZK7V/6mrzCwZOAvYf4xbhKmOSUjeQy2S3T2TyeZJT2OzHw7TbT5C8cOt9wu9QZFw7N2EYoBu+65EM1TuBiMUUC0yesMDZy+tVUZ7B5pBxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCOGLnGE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83E31C4CEF4;
	Tue,  9 Sep 2025 15:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757432606;
	bh=fXPPeMKvaera8ovcQMSzAU21wcQMEHgyCpGtqBdp7ns=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jCOGLnGEHJlkyBkZ6wrIP/V/7aKmBgZNTwOW6FSeonuymDyU6eVPAbYXN9I7Qd6TS
	 t55LhinALYD98T095qog81yGVNg7hWBsr8Sra+29AmZ6QFXIrxX+zukmhFE37wKASl
	 UW7p927qyEgOfQ/uCrXSzZQ0cnVsu533wGCiVorxYq4tspLWZnCNbxVPcNG5GV2Rsy
	 q+wrz+maRoFoiJ4RFzFG16C7dw721XpagreDsJwy+HwMh6DY3gyt+KtS/HOrXht3op
	 K0CogCuvPkWUogRs8bKG4xMBilSEmfsXOGbrun4OCTEpdbO0yPyAWpZYnTLx+Gb61L
	 wiAQj/CRNHV0w==
Date: Tue, 9 Sep 2025 16:43:23 +0100
From: Simon Horman <horms@kernel.org>
To: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, anthony.l.nguyen@intel.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH iwl-net v2 2/2] ixgbe: destroy aci.lock later within
 ixgbe_remove path
Message-ID: <20250909154323.GB20205@horms.kernel.org>
References: <20250908112629.1938159-1-jedrzej.jagielski@intel.com>
 <20250908112629.1938159-3-jedrzej.jagielski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250908112629.1938159-3-jedrzej.jagielski@intel.com>

On Mon, Sep 08, 2025 at 01:26:29PM +0200, Jedrzej Jagielski wrote:
> There's another issue with aci.lock and previous patch uncovers it.
> aci.lock is being destroyed during removing ixgbe while some of the
> ixgbe closing routines are still ongoing. These routines use Admin
> Command Interface which require taking aci.lock which has been already
> destroyed what leads to call trace.
> 
> [  +0.000004] DEBUG_LOCKS_WARN_ON(lock->magic != lock)
> [  +0.000007] WARNING: CPU: 12 PID: 10277 at kernel/locking/mutex.c:155 mutex_lock+0x5f/0x70
> [  +0.000002] Call Trace:
> [  +0.000003]  <TASK>
> [  +0.000006]  ixgbe_aci_send_cmd+0xc8/0x220 [ixgbe]
> [  +0.000049]  ? try_to_wake_up+0x29d/0x5d0
> [  +0.000009]  ixgbe_disable_rx_e610+0xc4/0x110 [ixgbe]
> [  +0.000032]  ixgbe_disable_rx+0x3d/0x200 [ixgbe]
> [  +0.000027]  ixgbe_down+0x102/0x3b0 [ixgbe]
> [  +0.000031]  ixgbe_close_suspend+0x28/0x90 [ixgbe]
> [  +0.000028]  ixgbe_close+0xfb/0x100 [ixgbe]
> [  +0.000025]  __dev_close_many+0xae/0x220
> [  +0.000005]  dev_close_many+0xc2/0x1a0
> [  +0.000004]  ? kernfs_should_drain_open_files+0x2a/0x40
> [  +0.000005]  unregister_netdevice_many_notify+0x204/0xb00
> [  +0.000006]  ? __kernfs_remove.part.0+0x109/0x210
> [  +0.000006]  ? kobj_kset_leave+0x4b/0x70
> [  +0.000008]  unregister_netdevice_queue+0xf6/0x130
> [  +0.000006]  unregister_netdev+0x1c/0x40
> [  +0.000005]  ixgbe_remove+0x216/0x290 [ixgbe]
> [  +0.000021]  pci_device_remove+0x42/0xb0
> [  +0.000007]  device_release_driver_internal+0x19c/0x200
> [  +0.000008]  driver_detach+0x48/0x90
> [  +0.000003]  bus_remove_driver+0x6d/0xf0
> [  +0.000006]  pci_unregister_driver+0x2e/0xb0
> [  +0.000005]  ixgbe_exit_module+0x1c/0xc80 [ixgbe]
> 
> Same as for the previous commit, the issue has been highlighted by the
> commit 337369f8ce9e ("locking/mutex: Add MUTEX_WARN_ON() into fast path").
> 
> Move destroying aci.lock to the end of ixgbe_remove(), as this
> simply fixes the issue.
> 
> Fixes: 4600cdf9f5ac ("ixgbe: Enable link management in E610 device")
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


