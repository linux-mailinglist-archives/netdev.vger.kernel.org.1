Return-Path: <netdev+bounces-138678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 134009AE841
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 16:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44C361C21736
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266521E571A;
	Thu, 24 Oct 2024 14:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UX7tGNCp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B051D9A72
	for <netdev@vger.kernel.org>; Thu, 24 Oct 2024 14:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729779034; cv=none; b=INcPVa9OEg0ajChxKH0bugJSvtsnmN+j6jwl01+31BVrHjJLkzOFZFhbkzjLAoE+rGuB8Ll2AgMvnNtfuEMqkTUqIy+xghOvmnWp1yRhgvxvCKdok/DgyUlEs+eQ7pCQCg6vPGxizOHfS14XLQBEznJ8Jl5mCVVbrFCPFv46sRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729779034; c=relaxed/simple;
	bh=oTiSbdW9t2wbHJIAVe7e9J2CwdSmtdmDbiSLafFCb60=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZUcqrWlvjNeb8Sik7muRmDUOuCccLURHH33kKZwFUB+pD/6yOC/E/FHTZyimaddxETSwSxYPEfcP/vYS8foxqU0918R/CcpnRhmhV9TyLXT9LOcubgs7gOGfxoylljKAVdaFlC+8bWqyskVj3ASPlTcIhQYaTevdUB649irjMK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UX7tGNCp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7BCC4CEC7;
	Thu, 24 Oct 2024 14:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729779033;
	bh=oTiSbdW9t2wbHJIAVe7e9J2CwdSmtdmDbiSLafFCb60=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UX7tGNCpPoHejOnSoEfnTc0nFaq8WPzHefdX+sIhn2UKGDbsmxaATVTadGtp/5JIP
	 3NOBpftKwJPSQfMYWtpcrjxe6OmU/zx+iwRAFCyWYc7NhoO85G9oW+IqlysU1t4bzg
	 IL+osXLKfJ0z3BOUt6jJAsj9Zm6kizH0lQfeaxmsvXZEe960l3rQOP0ij1XGRDLXWS
	 lkBR1RsT2tbvOoej6QN9TYTOx4SUXW1VqehTP4SwD65PvUAtusl+0/bErIjiBqV9Yc
	 pFT3wJfhv1lAMkjrwe3aa/a00TP0FqBpejYeiKogoTAK6l3MCj6bq9f45+IP/116yS
	 YMBVSdcfpjT+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB176380DBDC;
	Thu, 24 Oct 2024 14:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next 0/9] phonet: Convert all doit() and dumpit() to
 RCU.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172977903980.2249854.11365353002595095728.git-patchwork-notify@kernel.org>
Date: Thu, 24 Oct 2024 14:10:39 +0000
References: <20241017183140.43028-1-kuniyu@amazon.com>
In-Reply-To: <20241017183140.43028-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, courmisch@gmail.com, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 17 Oct 2024 11:31:31 -0700 you wrote:
> addr_doit() and route_doit() access only phonet_device_list(dev_net(dev))
> and phonet_pernet(dev_net(dev))->routes, respectively.
> 
> Each per-netns struct has its dedicated mutex, and RTNL also protects
> the structs.  __dev_change_net_namespace() has synchronize_net(), so
> we have two options to convert addr_doit() and route_doit().
> 
> [...]

Here is the summary with links:
  - [v1,net-next,1/9] phonet: Pass ifindex to fill_addr().
    https://git.kernel.org/netdev/net-next/c/08a9572be368
  - [v1,net-next,2/9] phonet: Pass net and ifindex to phonet_address_notify().
    https://git.kernel.org/netdev/net-next/c/68ed5c38b512
  - [v1,net-next,3/9] phonet: Convert phonet_device_list.lock to spinlock_t.
    https://git.kernel.org/netdev/net-next/c/42f5fe1dc4ba
  - [v1,net-next,4/9] phonet: Don't hold RTNL for addr_doit().
    https://git.kernel.org/netdev/net-next/c/8786e98dd0eb
  - [v1,net-next,5/9] phonet: Don't hold RTNL for getaddr_dumpit().
    https://git.kernel.org/netdev/net-next/c/b7d2fc9ad7fe
  - [v1,net-next,6/9] phonet: Pass ifindex to fill_route().
    https://git.kernel.org/netdev/net-next/c/302fc6bbcba4
  - [v1,net-next,7/9] phonet: Pass net and ifindex to rtm_phonet_notify().
    https://git.kernel.org/netdev/net-next/c/de51ad08b117
  - [v1,net-next,8/9] phonet: Convert phonet_routes.lock to spinlock_t.
    https://git.kernel.org/netdev/net-next/c/3deec3b4afb4
  - [v1,net-next,9/9] phonet: Don't hold RTNL for route_doit().
    https://git.kernel.org/netdev/net-next/c/17a1ac0018ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



