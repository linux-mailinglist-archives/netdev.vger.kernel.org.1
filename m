Return-Path: <netdev+bounces-186425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4CCEA9F13C
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 14:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D9F217714E
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 12:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCA5269CFA;
	Mon, 28 Apr 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bEeG0qDT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862F7268FFF
	for <netdev@vger.kernel.org>; Mon, 28 Apr 2025 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745844266; cv=none; b=Ild9uWH1bI5ZiWPGjajxiEsWVIMsusGYmfq+E9yCeCbyCzS+ZItaSDwlScoVj9eeA03A4tenTvgC8m6uoLZ/RFgCPm3Wv+i0Qeac4JpXqu+SXKp1N934XLvg0I5vH+FaYSt+yovarV+J+bs/DD/50uRZ0FUwhfxvUWagibbxO5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745844266; c=relaxed/simple;
	bh=gf4bPSuQPO48PU6kXW3j85ZlD9gokzHqQcTu5mNH+Vs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q/09M1GtUUDO8zjq69wOBJqTVIrUqF2DDavXpL6pD/qRSjI21mv08QkvnYZCiMtbb2Ya4FOLBIv+OMaP9nvf/Jx++fp1XELswE7LNwrC9k587pHZC6ZYeYgaJnuoTrwOda/5B1YiO4bSPkq2sYOps0xYjiyasp2F+dtrWHc0V/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bEeG0qDT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D485AC4CEE4;
	Mon, 28 Apr 2025 12:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745844266;
	bh=gf4bPSuQPO48PU6kXW3j85ZlD9gokzHqQcTu5mNH+Vs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEeG0qDTG9MRDU7yK69hacuuSyU+E0pCKPkZvYjTHQICtLa7x5S0HYoa3Rjnzl09i
	 rmZTl77t1hit5WvRRSUIz9Th2LVO7R/10vfWIYL5qy8+cozb3N9/TmHvac9YmA7li2
	 pKe83ouhpJpg5are7Wl2iQuQ+M4fdoYSQdGNjfb3JvDEgoWiMnv0ITqNPzLFxS4zwJ
	 kBA7HsnGeUzQUbvDfAXRWln8YoO7xnjBCaeMclyQyseQSaJITSXW874tedbcW9KgBk
	 GsXpMRl79yRgc7lLPqu4gp1q5pUQGZbzn7GIr9/HG4Q6q0k/Njs9XV4OJtF1H8YE7U
	 RKLwLKe5pfh1Q==
Date: Mon, 28 Apr 2025 13:44:22 +0100
From: Simon Horman <horms@kernel.org>
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Ahmed Zaki <ahmed.zaki@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net] iavf: fix reset_task for early reset event
Message-ID: <20250428124422.GB3339421@horms.kernel.org>
References: <20250424135012.5138-2-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424135012.5138-2-marcin.szycik@linux.intel.com>

On Thu, Apr 24, 2025 at 03:50:13PM +0200, Marcin Szycik wrote:
> From: Ahmed Zaki <ahmed.zaki@intel.com>
> 
> If a reset event is received from the PF early in the init cycle, the
> state machine hangs for about 25 seconds.
> 
> Reproducer:
>   echo 1 > /sys/class/net/$PF0/device/sriov_numvfs
>   ip link set dev $PF0 vf 0 mac $NEW_MAC
> 
> The log shows:
>   [792.620416] ice 0000:5e:00.0: Enabling 1 VFs
>   [792.738812] iavf 0000:5e:01.0: enabling device (0000 -> 0002)
>   [792.744182] ice 0000:5e:00.0: Enabling 1 VFs with 17 vectors and 16 queues per VF
>   [792.839964] ice 0000:5e:00.0: Setting MAC 52:54:00:00:00:11 on VF 0. VF driver will be reinitialized
>   [813.389684] iavf 0000:5e:01.0: Failed to communicate with PF; waiting before retry
>   [818.635918] iavf 0000:5e:01.0: Hardware came out of reset. Attempting reinit.
>   [818.766273] iavf 0000:5e:01.0: Multiqueue Enabled: Queue pair count = 16
> 
> Fix it by scheduling the reset task and making the reset task capable of
> resetting early in the init cycle.
> 
> Fixes: ef8693eb90ae3 ("i40evf: refactor reset handling")
> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> Tested-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> ---
> This should be applied after "iavf: get rid of the crit lock"

Reviewed-by: Simon Horman <horms@kernel.org>


