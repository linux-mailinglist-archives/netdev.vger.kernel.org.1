Return-Path: <netdev+bounces-176424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C28A6A3AC
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 11:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 960AA8A5CAE
	for <lists+netdev@lfdr.de>; Thu, 20 Mar 2025 10:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BF7A220685;
	Thu, 20 Mar 2025 10:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ry4ORvi1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 034274A1D
	for <netdev@vger.kernel.org>; Thu, 20 Mar 2025 10:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742466601; cv=none; b=sL9vKNrGQaZC1PXpPd6q1f3F1Ro0iCYNSowlsjEEXpYvs6INKj5phKmzxuoa2WOa5hFo6PzeLE/ZyBqWDOGBHb89vppzyvgxQb/DW6aCTqsB2oVMCDiVZKR8mhR0sPdITXOWZN/xMqbJwiA67Oq3p/jfCyd3qK1BR+6m1369jwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742466601; c=relaxed/simple;
	bh=a3w9EX4HlqR135m9SnbAFiUDBZFt+AWeEL63L+tceTU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rllj+i/FWXjMdSeKzOdjSjuDDmT+csPM18KlEFLDP1ySk2/+iy+Dt/2mmAS1qFvWObelUqGz5mF1y7uA8DfswhJLaBLkAIMousNJv1dhAJwfH+wGpeA9eQHgq1iIQoQEP24o+f59scnCdbeRji6fHiVQBItMz9v94EGRcLe0W8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ry4ORvi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE0DC4CEDD;
	Thu, 20 Mar 2025 10:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742466600;
	bh=a3w9EX4HlqR135m9SnbAFiUDBZFt+AWeEL63L+tceTU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Ry4ORvi17LOEKQo5N67G4poOkg242vHoS9Qshd4/GipN8TjvlvGa4KUdI4B/s3Fs7
	 x3ADzySk3bvXwFb9+WsHgDQdcy7Huc46HvCwIv3WDQ9muhNnXKpc/N4/eShAXF6o4w
	 vAh4P8Lq7lBiKOcLYRYRzZK5NEkNXRcGcAPqguC/uFaSgcqV0A0GQCSjxD26bZZgWW
	 ttypppUxmx6QWo22RhocUvcRKw6ozZMNW8N1MnJrbez8TCliPN16XtVLb1IJS5Q1Me
	 McKg2TIuoDtFZkKCEZstcIHdQy4HygiixPIPlanWub1UNZm1OdSzGoPEp9m5Ih4fgZ
	 /SrL+oZcMriNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E573806654;
	Thu, 20 Mar 2025 10:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] net: fix lwtunnel reentry loops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174246663627.1712233.13855309884970574366.git-patchwork-notify@kernel.org>
Date: Thu, 20 Mar 2025 10:30:36 +0000
References: <20250314120048.12569-1-justin.iurman@uliege.be>
In-Reply-To: <20250314120048.12569-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Mar 2025 13:00:45 +0100 you wrote:
> v2:
> - removed some patches from the -v1 series
> - added a patch that was initially sent separately
> - code style for the selftest (thanks Paolo)
> v1:
> - https://lore.kernel.org/all/20250311141238.19862-1-justin.iurman@uliege.be/
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] net: lwtunnel: fix recursion loops
    https://git.kernel.org/netdev/net/c/986ffb3a57c5
  - [net,v2,2/3] net: ipv6: ioam6: fix lwtunnel_output() loop
    https://git.kernel.org/netdev/net/c/3e7a60b368ea
  - [net,v2,3/3] selftests: net: test for lwtunnel dst ref loops
    https://git.kernel.org/netdev/net/c/3ed61b8938c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



