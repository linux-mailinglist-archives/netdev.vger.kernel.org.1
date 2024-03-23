Return-Path: <netdev+bounces-81359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93137887651
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 02:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3567E1F22D89
	for <lists+netdev@lfdr.de>; Sat, 23 Mar 2024 01:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659F1A59;
	Sat, 23 Mar 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LaGo48FI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A8DAA41;
	Sat, 23 Mar 2024 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711156229; cv=none; b=Z3CeGJ53pTVVXx4GkZ6pIJuu7TeTTSS6bYeJGvOtf+Z/ucJBdGShB9ZkuFuwaQttQL0HmbQHoozibIiPfjDROIjCudxkpjY7FTew18OA8wTLBTk5mBTIZLGZqMDZ6NEKthRrJVs9jNnl0yNmDx8Cv13SOyTY0L4OOLIYoaOOvDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711156229; c=relaxed/simple;
	bh=50PefJZSTcgeBQSLtNejEsHNZTUKJEsfoi+Slynip1s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dcuVsenUffllVozlgvuDrOMqfM33RNp9zrDQQ/6zQWjeXmd6vaUrXcJk+LcHQmXdxpojHClAoccR3EB9JqRrTrVBV1/eIwbyrg5fY/BFKmcqE8vj3sGWvl+VLXHHkYejRHFz6DzOvxOZTyfdNMm2Ey7VHmPoEuqmrfVLj/0qc+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LaGo48FI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F25E9C433A6;
	Sat, 23 Mar 2024 01:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711156229;
	bh=50PefJZSTcgeBQSLtNejEsHNZTUKJEsfoi+Slynip1s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LaGo48FI+kZrqJRK7zdXjDZ4odEa8O8XbG+uVJh9a0nAx3UHYwMEWPMNCtm3DjQFW
	 rUiP2yCJGglLP7ytKBsLkXgq0G88FX11c/TAr3js79RQ+bEliDawl0SA4Md3cwFZH8
	 u+5Yb0opuoDFYPZNajR26Pck7kw9HIqoIELO/6pZ7TwdOrnlwuzobOkDe6QLAsMcPs
	 WpvHMNtvWBUUQHjqThzBbOXGze+di5AJ1Yn0uMf0QgrgugKEXD//5ho0QW1P72QNUx
	 +YwsafULuNo9voeWMupcBI4Xj0Nm7PN1GsqCItUrcWoqWOpVrZ0/X8DWEDvjsUp48L
	 mQehKflQdv6uQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E128AD8BCE4;
	Sat, 23 Mar 2024 01:10:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] nexthop: fix uninitialized variable in
 nla_put_nh_group_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171115622891.16003.9139794414566350599.git-patchwork-notify@kernel.org>
Date: Sat, 23 Mar 2024 01:10:28 +0000
References: <f08ac289-d57f-4a1a-830f-cf9a0563cb9c@moroto.mountain>
In-Reply-To: <f08ac289-d57f-4a1a-830f-cf9a0563cb9c@moroto.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: idosch@nvidia.com, dsahern@kernel.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, petrm@nvidia.com,
 keescook@chromium.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 Mar 2024 17:42:18 +0300 you wrote:
> The "*hw_stats_used" value needs to be set on the success paths to prevent
> an uninitialized variable bug in the caller, nla_put_nh_group_stats().
> 
> Fixes: 5072ae00aea4 ("net: nexthop: Expose nexthop group HW stats to user space")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
> v2: Set the variable in nh_grp_hw_stats_update() instead of
>     nla_put_nh_group_stats().
> 
> [...]

Here is the summary with links:
  - [v2,net] nexthop: fix uninitialized variable in nla_put_nh_group_stats()
    https://git.kernel.org/netdev/net/c/9145e2249ed6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



