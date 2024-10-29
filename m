Return-Path: <netdev+bounces-140044-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 181AF9B51D4
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 19:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36F711C22BEF
	for <lists+netdev@lfdr.de>; Tue, 29 Oct 2024 18:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED6C20495C;
	Tue, 29 Oct 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvJ5vIr3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB13420494B
	for <netdev@vger.kernel.org>; Tue, 29 Oct 2024 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730226630; cv=none; b=tXWsgG7cWaH45Z9abPPW+C0P5r0lPp1m742xyGGdiksdE6eid5hegJ0KqpKUirJ3g2UHbAK1f9OiBfoVoXEkVi9bB4aAe2EUCRiFeqsNk2MyuBgAClnKT1UNeFCwm/Xx7IDeHt1et9lYXDwDKYpKc/hKBKeE1bLiZHO1cbmo1ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730226630; c=relaxed/simple;
	bh=r3RRIWyk9FDuQOSj5prcufGeXDze3wL+L65GW9bRIzA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WJiV/qzdc0Fb4piWNU6PPHNuku5vaLDql0ojPLNdpgYIiJ1ttLoIJbTFficYM4R0a1ZHrIr1B7XeVgNvFNhWoi0agYji0c3rj7WxQ6SxdmvcXMLBYaq5t9IwdjeHTJYAz/VRmGkCSll0HU9u4n8s5NRoe0CuhHEY5c3sbBCR1rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvJ5vIr3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE4FC4CECD;
	Tue, 29 Oct 2024 18:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730226630;
	bh=r3RRIWyk9FDuQOSj5prcufGeXDze3wL+L65GW9bRIzA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WvJ5vIr31s9tD96XMcV2f/8kpGvJdfcoZIFydbzk996cW8zx/uaQS0jYgVsyPqfp3
	 XrjrkMQK9gWGCUuj4OEBrkg/pMyw3mYTD3yGqckzzgu/H0QjOPuf0KJBXYltj1rpcI
	 2n4Ui91ukxqOsHk0KJfr4Nv/s1POTcg5uLFAlAtwP+ztCFPN3YKEMELIrlOdqUiwFW
	 qn3e29vjDVyYeNEc4OZGQb/RFe6jdJBl5rkSjagWZxh8Ax+3BK4Lv4kFRt6gke4H6k
	 /ABz2914m5m1pwXms56rUIkXjVkvyBSQQ8mwMn0iscTvqzkxVcLXzEwNNp7HHzGLM7
	 e3IltVt7YTkZA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CB1380AC08;
	Tue, 29 Oct 2024 18:30:39 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: ip_tunnel: Fix suspicious RCU usage warning in
 ip_tunnel_init_flow()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173022663774.781637.16465187887007316030.git-patchwork-notify@kernel.org>
Date: Tue, 29 Oct 2024 18:30:37 +0000
References: <20241022063822.462057-1-idosch@nvidia.com>
In-Reply-To: <20241022063822.462057-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, dsahern@kernel.org, horms@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 22 Oct 2024 09:38:22 +0300 you wrote:
> There are code paths from which the function is called without holding
> the RCU read lock, resulting in a suspicious RCU usage warning [1].
> 
> Fix by using l3mdev_master_upper_ifindex_by_index() which will acquire
> the RCU read lock before calling
> l3mdev_master_upper_ifindex_by_index_rcu().
> 
> [...]

Here is the summary with links:
  - [net] ipv4: ip_tunnel: Fix suspicious RCU usage warning in ip_tunnel_init_flow()
    https://git.kernel.org/netdev/net/c/ad4a3ca6a8e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



