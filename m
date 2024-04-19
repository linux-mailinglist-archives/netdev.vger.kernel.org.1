Return-Path: <netdev+bounces-89493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 09F988AA690
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 03:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCD0B1F21BDA
	for <lists+netdev@lfdr.de>; Fri, 19 Apr 2024 01:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A309B1362;
	Fri, 19 Apr 2024 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TMRaeJzz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D10910FA
	for <netdev@vger.kernel.org>; Fri, 19 Apr 2024 01:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713490629; cv=none; b=SV0q3vmwB/jdgOKLCoYH6PZoRes5UZ99FZkd5r76zXM8/fa9M2sBD1NkxfuH7JsdJRcx+ZfZph/jFgm7Y6cY5j8qj/++3FStiPuVNVSGLAg6TK/EhifWl22e3Y7TFuHEQPY7v934KjcWfCMoHAOdREXP1hCVnzy8FkGqfnMqz6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713490629; c=relaxed/simple;
	bh=rV9u+nh2Us7vMCFmty4P/wylu85odXWWSd5Mk0m2+fw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jsGsrivBJHUjFoWwFOo3ZW4WjmjpuZNMwETVMdhHBzNrQK/Unzz7EVwHK8yv7RWucKCObGv0sqt7ZfYkcu/T3E+7uQHMX4vevyaOdG+9afikfZzqItQ84q4irbCV0zyVea+Nnu+UHtSS2f6oSwfKvHHTBuGcERjLvrNb32Iyp3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TMRaeJzz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D871C113CC;
	Fri, 19 Apr 2024 01:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713490629;
	bh=rV9u+nh2Us7vMCFmty4P/wylu85odXWWSd5Mk0m2+fw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TMRaeJzzDZJzYeYSvkeFEKuEUgVEtJmLpsP0zjMDRJsbvUo1x7Y0d8AL8ipgbUBHY
	 cEBFc/I5igyTXdSOlwVUdwjyi4CC/avJQsjgJjikvozODUKFiWdjbm0ICYooPCPRLq
	 /O2VOHkRrJqF5ImAiGCHfaoEqkXEDz045ThbzLV/bidNta2Slg/i6Xk+0ZFLac+KB/
	 2g3bYUSE5yd5Jvr2054HJ8A4AnQtzkEpk5SFPnJUoy/lfTSkgL8WTghGprSw7jPyu8
	 Vmof8yNioCYUvVFcgNtpoVOabfQ7Q34k9RxvQNl7TqGMyWP6j+STVGYpzocCCxKDy7
	 lFeAR0BYt+WJQ==
Date: Thu, 18 Apr 2024 18:37:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
 <pabeni@redhat.com>, <ast@kernel.org>, <sdf@google.com>,
 <lorenzo@kernel.org>, <tariqt@nvidia.com>, <daniel@iogearbox.net>,
 <anthony.l.nguyen@intel.com>, <lucien.xin@gmail.com>, <hawk@kernel.org>,
 <sridhar.samudrala@intel.com>
Subject: Re: [net-next,RFC PATCH 0/5] Configuring NAPI instance for a queue
Message-ID: <20240418183706.049a17cb@kernel.org>
In-Reply-To: <acbe612f-faaa-4c70-802f-87504ee7c274@intel.com>
References: <171234737780.5075.5717254021446469741.stgit@anambiarhost.jf.intel.com>
	<20240409162153.5ac9845c@kernel.org>
	<94956064-9935-4ff3-8924-a99beb5adc07@intel.com>
	<20240411184740.782809eb@kernel.org>
	<acbe612f-faaa-4c70-802f-87504ee7c274@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 18 Apr 2024 14:23:03 -0700 Nambiar, Amritha wrote:
> >> I am not sure of this. ethtool shows pre-set defaults and current
> >> settings, but in this case, it is tricky :(  
> > 
> > Can you say more about the use case for moving the queues around?
> > If you just want to have fewer NAPI vectors and more queues, but
> > don't care about exact mapping - we could probably come up with
> > a simpler API, no? Are the queues stack queues or also AF_XDP?
> 
> I'll try to explain. The goal is to have fewer NAPI pollers. The number 
> of NAPI pollers is the same as the number of active NAPIs (kthread per 
> NAPI). It is possible to limit the number of pollers by mapping 
> multiples queues on an interrupt vector (fewer vectors, more queues) 
> implicitly in the driver. But, we are looking for a more granular 
> approach, in our case, the queues are grouped into 
> queue-groups/rss-contexts. We would like to reduce the number of pollers 
> within certain selected queue-groups/rss-contexts (not all the 
> queue-groups), hence need the configurability.
> This would benefit our hyper-threading use case, where a single physical 
> core can be used for both network and application processing. If the 
> NAPI to queue association is known, we can pin the NAPI thread to the 
> logical core and the application thread to the corresponding sibling 
> logical core.

Could you provide a more detailed example of a desired configuration? 
I'm not sure I'm getting the point.

What's the point of having multiple queues if they end up in the same
NAPI?

