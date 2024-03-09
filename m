Return-Path: <netdev+bounces-78910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0972F876F30
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 05:44:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B153F1F217C3
	for <lists+netdev@lfdr.de>; Sat,  9 Mar 2024 04:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041C81DFFE;
	Sat,  9 Mar 2024 04:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fshozts7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43311DDF1
	for <netdev@vger.kernel.org>; Sat,  9 Mar 2024 04:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709959472; cv=none; b=a1bwEUsqzO6ODz7pEgdzo23j9MiBgBThtvYUAdEN1E6F8MUoI7DlB6Z3IAIS4I9vwzSiwtH6F1rMfsxQZJC5y3Z/sxM/VBZd0DVraBd1zD5NzXIx1s2E898omrhOvznVfQyMFLCa2OaC6gRs20P7fwoRzRXMvaclMIP98jt3z34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709959472; c=relaxed/simple;
	bh=0l6Dm4MB0w88u3WqwaQnn0uKHuAXQj0U46zspSqYQAE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kI/HssO4xTofDg8Q47jbXqQwIvyu/m1byunXOBjIDkTXh2x7hs8HyK9WAsrf1zfwioUhTy8fzLKvLmLRxOHoYUhjBAAPdGwY7uxOc8IztTRIAWLaQztGldnB+TB9lS1JpGOwbPQLWgkbNO6U2P3ZNkLaGJUqpjB+OBo3EK0A82A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fshozts7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23B99C433C7;
	Sat,  9 Mar 2024 04:44:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709959472;
	bh=0l6Dm4MB0w88u3WqwaQnn0uKHuAXQj0U46zspSqYQAE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fshozts7o44OZsQY6fHGjFq+HwefosBvxZJNa+zR//2ENMayx5FaBmMZLnRWY2sNM
	 NVf2wyA54vP3PK7s9uL7qRRA7TKODJO8t99EOmMxIvyso8/30qZH9fIDOX0HWgVHwV
	 D//qqVl4AitF3s8jo2KNMzRamV5g0hr/h0TBPVEBZMboHqyXACZZ2Jmvnn7Fe8jkPl
	 YUrgku4yVG5jifi0entAm1jJa/faEINjLo/UcJgX0n+9YVcl2MML9HNVE/cT278pYb
	 3l7T1lOLKrMBzlXI6OA5UxrrHH3ncU/n8peXYquRVao84ocKBb81O9OaxFnFK4aLAf
	 121HZ5VDc146Q==
Date: Fri, 8 Mar 2024 20:44:31 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: William Tu <witu@nvidia.com>
Cc: <netdev@vger.kernel.org>, <jiri@nvidia.com>, <bodong@nvidia.com>,
 <tariqt@nvidia.com>, <yossiku@nvidia.com>
Subject: Re: [PATCH RFC v3 net-next 1/2] devlink: Add shared memory pool
 eswitch attribute
Message-ID: <20240308204431.36e56066@kernel.org>
In-Reply-To: <20240306231253.8100-1-witu@nvidia.com>
References: <20240306231253.8100-1-witu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Mar 2024 01:12:52 +0200 William Tu wrote:
> When using switchdev mode, the representor ports handles the slow path
> traffic, the traffic that can't be offloaded will be redirected to the
> representor port for processing. Memory consumption of the representor
> port's rx buffer can grow to several GB when scaling to 1k VFs reps.
> For example, in mlx5 driver, each RQ, with a typical 1K descriptors,
> consumes 3MB of DMA memory for packet buffer in WQEs, and with four
> channels, it consumes 4 * 3MB * 1024 = 12GB of memory. And since rep
> ports are for slow path traffic, most of these rx DMA memory are idle.
> 
> Add spool_size configuration, allowing multiple representor ports
> to share a rx memory buffer pool. When enabled, individual representor
> doesn't need to allocate its dedicated rx buffer, but just pointing
> its rq to the memory pool. This could make the memory being better
> utilized. The spool_size represents the number of bytes of the memory
> pool. Users can adjust it based on how many reps, total system
> memory, or performance expectation.

We may need to wordsmith the docs once present but in general, FWIW:
Acked-by: Jakub Kicinski <kuba@kernel.org>

