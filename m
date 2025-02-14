Return-Path: <netdev+bounces-166547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04DFCA36645
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 20:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C86D0171E6B
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 19:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 562E91990B7;
	Fri, 14 Feb 2025 19:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gBitGIlO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3089119644B
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 19:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739562011; cv=none; b=npJthMxxLorK708GMVVGi8ov/yv9+nfF2GmfSDxiBhUcsSxIGnzR6keVhp4Hlm7Ddg8Nd76aVL6WlCuB16zY8VhggxTOBQAxDSrEGdWZLhzvAuG6ATKU94CkRVzJSBtkgtMPO8vBIvUOQonlneL81LPCqrFu2Jl1wGbTZ4FVKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739562011; c=relaxed/simple;
	bh=HJs+4hensq83gR4ChmFoyMV/mUq+VAeO02qwJAD5gIw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MNK5wfc7N1+IzRlF1ZV6ZiaUebu1QLKMDtapwKgtFUOCU9mlxc2B2xFQOOuREs+Jev6G1HtYZo4JYZqDpnfoVH5ThqYU8SD9Yeu/4jebETtCXnmNtLPR+NWay6niLrt5LgtdMUpfkAKd8WnMzHKbIDh3LoLA33MI3PWqbKxCkfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gBitGIlO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FC30C4CED1;
	Fri, 14 Feb 2025 19:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739562009;
	bh=HJs+4hensq83gR4ChmFoyMV/mUq+VAeO02qwJAD5gIw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gBitGIlOVwLGOgl9yiB8Pgmk4rdzh1q9KSnTCs8L56rbVO3qnkAitX0yiMeKj00Oo
	 3E0MvzUrc//ZiKw5bhZg0yWt2P6N8semB2CHmoAhQLqZO2u25PGoieJSnOhJ277a0v
	 qSe+KwXzYEvUv3X3A1XajT5FH/nE8/nYYH0MtfwW0FzLmeeOG+BpuTTU0pOCyD7f13
	 ZhMdKpG3k60ZN9NwYyxhoSQVXq1g2MxTSE4S9Gr/f+EFGhBTB6/L1bd2tuXJTuliRz
	 RirO2UxNsd0qyDui57Qe2gD7FwPYPWWadC6MiBQFjrOJt3lfnrOQKkezmHZYPAHNwQ
	 w8w0oyDT3FWcw==
Date: Fri, 14 Feb 2025 11:40:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Intel Wired LAN <intel-wired-lan@lists.osuosl.org>, netdev
 <netdev@vger.kernel.org>, Anthony Nguyen <anthony.l.nguyen@intel.com>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v2] iavf: fix circular lock dependency with
 netdev_lock
Message-ID: <20250214114008.4975ccb4@kernel.org>
In-Reply-To: <20250213-jk-iavf-abba-lock-crash-v2-1-033d7bf298f8@intel.com>
References: <20250213-jk-iavf-abba-lock-crash-v2-1-033d7bf298f8@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Feb 2025 16:30:59 -0800 Jacob Keller wrote:
> Analyzing the places where we take crit_lock in the driver there are two
> sources:
> 
> a) several of the work queue tasks including adminq_task, watchdog_task,
> reset_task, and the finish_config task.
> 
> b) various callbacks which ultimately stem back to .ndo operations or
> ethtool operations.
> 
> The latter cannot be triggered until after the netdevice registration is
> completed successfully.
> 
> The iAVF driver uses alloc_ordered_workqueue, which is an unbound workqueue
> that has a max limit of 1, and thus guarantees that only a single work item
> on the queue is executing at any given time, so none of the other work
> threads could be executing due to the ordered workqueue guarantees.
> 
> The iavf_finish_config() function also does not do anything else after
> register_netdevice, unless it fails. It seems unlikely that the driver
> private crit_lock is protecting anything that register_netdevice() itself
> touches.
> 
> Thus, to fix this ABBA lock violation, lets simply release the
> adapter->crit_lock as well as netdev_lock prior to calling
> register_netdevice(). We do still keep holding the RTNL lock as required by
> the function. If we do fail to register the netdevice, then we re-acquire
> the adapter critical lock to finish the transition back to
> __IAVF_INIT_CONFIG_ADAPTER.
> 
> This ensures every call where both netdev_lock and the adapter->crit_lock
> are acquired under the same ordering.

Thanks a lot for figuring this out, much appreciated!

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

