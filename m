Return-Path: <netdev+bounces-180981-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFE42A8357C
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 03:13:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEBBE4A1A17
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 01:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E00515B135;
	Thu, 10 Apr 2025 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NwAP90cf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A32C15624D
	for <netdev@vger.kernel.org>; Thu, 10 Apr 2025 01:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247396; cv=none; b=IK80r2A/qKD80yFs0WF6VNq/DQ6S1pziUc854WG1WH/h8ylO6AfVcJ619u52H2WjRak4lPPyGed9bWJA6cK5cmT3beYW6ar8ydLyOakMfvch/p2pJW9C2cMam7laXukqD7Wh8TzrLQxoDuQ4AFQQPyMGZkenZzKoPI+SY0p6NXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247396; c=relaxed/simple;
	bh=AIhxsgYzA8frCXAXcpIffJXaO1xiz8OGOYwlH480Q2U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Jzs7SZd7YTQwY6lTyr78hVIf8DhLWMhfWq/GTw+Z5/OVs+V0z67b+B5PgSHGGeUiOzngUQYGpCAR1SGkME3fXU4C9S963sTH5bHZVvlJCM6GI48nw2UX/mqRVbgGA2FbiZsnaolGF+ifMSM9H4lrqu+wTCMMna6NrjeS1NYG1H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NwAP90cf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD46C4CEE2;
	Thu, 10 Apr 2025 01:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744247396;
	bh=AIhxsgYzA8frCXAXcpIffJXaO1xiz8OGOYwlH480Q2U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NwAP90cftId/7QW2A2QzKAzr45hBwFfF5bHNk4j02oIu3nWpLiUrO0RK+q4veyQA+
	 zPTrcDVQyKwJkALJIqhZiuQeFiJ5V/RnFvR5GI1Sh4UrhOSyINo51riEuJKTcEPfIV
	 pwxURZ3nsZDidWm/Qgba82e+ox1Ve7E3JzFLDYpn0KVS4moSgPE7s+OeS0/WvfTXkp
	 zG1hhB/QWwSYD6RLONP+LOchncPm68Wp1i6//6voEAkI90oN1OFAnwnxd2sN1HQgOC
	 /AaYQ9p+ZzLOGiQZQfe3fIAB51eP1U1bCihAomwFg9edkGGLBOdzfGOr0y307C2i6L
	 YIdYU/fscliYA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB93B38111DC;
	Thu, 10 Apr 2025 01:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: Align behavior across nexthops during path
 selection
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174424743350.3099560.5239251532172965635.git-patchwork-notify@kernel.org>
Date: Thu, 10 Apr 2025 01:10:33 +0000
References: <20250408084316.243559-1-idosch@nvidia.com>
In-Reply-To: <20250408084316.243559-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, horms@kernel.org,
 willemdebruijn.kernel@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 8 Apr 2025 11:43:16 +0300 you wrote:
> A nexthop is only chosen when the calculated multipath hash falls in the
> nexthop's hash region (i.e., the hash is smaller than the nexthop's hash
> threshold) and when the nexthop is assigned a non-negative score by
> rt6_score_route().
> 
> Commit 4d0ab3a6885e ("ipv6: Start path selection from the first
> nexthop") introduced an unintentional difference between the first
> nexthop and the rest when the score is negative.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: Align behavior across nexthops during path selection
    https://git.kernel.org/netdev/net/c/6933cd471486

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



