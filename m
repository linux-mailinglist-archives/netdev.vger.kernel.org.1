Return-Path: <netdev+bounces-179208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5905BA7B220
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 00:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA5D57A3E5A
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 22:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A88C518DB29;
	Thu,  3 Apr 2025 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D/+YNXsc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EC32E62BA
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 22:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743720596; cv=none; b=EP1RpY6V91YIfmi8DReCj5JiIo9DyWNhPOZebNMBmn++WqMAjo5QVd5dnO5DCnJGujUyLsKTCFCO+qP4fXZM5ziP/g5KRW+mOMSSO6b5o/X5ODql0AoPZiu/CIJxU1J4uzrPYOeDh633q9DMjaAEKPfGIUz4SxtZQpVjCCWQLPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743720596; c=relaxed/simple;
	bh=sQWeYNF3NbI8bDYoXRa9NVLEFFi8aMWkfhbqREvAAA8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cqsg529RPubKzwpegcYRRKFN4YqaNNM2pLNeHDe4KQZ2cr+XBh/W0RjhIFmFTTFNj2WVkgYjbR0m37SwKBngEsdN/s2uE6saO5LCmkrtaaYKEd8WPpRAgQ6PIDUMzSDIwLBmWN1YdVovMD1/YSiTg3r1QFG1Xz1jYGBVy8yT18U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D/+YNXsc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03EC8C4CEE3;
	Thu,  3 Apr 2025 22:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743720596;
	bh=sQWeYNF3NbI8bDYoXRa9NVLEFFi8aMWkfhbqREvAAA8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D/+YNXscqJcXYQLjIwaJR3U6ZtupslAQTE+yhkdZtvaYCnXeO4LqgLNQ3Cm7kZb/O
	 hSKZg/h67KTnAQ+ukyYvqQZE74mOpjSGL0p90WQhNEddXaRNHl2+Fn4PUkepjqKetX
	 ZQ37xItklF58NvCpKxohdKWouTSBA7R9QJFRg2yv8V4jBLvshy8D0LT4I+vWt0c+HV
	 LpJ7uNmrkRKrBWHI0slz9ufmSgO8fGHnVV9W5sAvcCyKlxkNhi/izKpzRiFPCYaEvd
	 YZ7EeuaqXYlsZxtm8O4vp2crlvEPFdft/FX9M0/eWQ8OjAl4OSk8BQaqQ9B55bzoFu
	 G2LlWR7PNhuJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D80380664C;
	Thu,  3 Apr 2025 22:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 00/11] net: hold instance lock during
 NETDEV_UP/REGISTER
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174372063301.2709734.14320566471718210495.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 22:50:33 +0000
References: <20250401163452.622454-1-sdf@fomichev.me>
In-Reply-To: <20250401163452.622454-1-sdf@fomichev.me>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Apr 2025 09:34:41 -0700 you wrote:
> Solving the issue reported by Cosmin in [0] requires consistent
> lock during NETDEV_UP/REGISTER notifiers. This series
> addresses that (along with some other fixes in net/ipv4/devinet.c
> and net/ipv6/addrconf.c) and appends the patches from Jakub
> that were conditional on consistent locking in NETDEV_UNREGISTER.
> 
> 0: https://lore.kernel.org/netdev/700fa36b94cbd57cfea2622029b087643c80cbc9.camel@nvidia.com/
> 
> [...]

Here is the summary with links:
  - [net,v5,01/11] net: switch to netif_disable_lro in inetdev_init
    https://git.kernel.org/netdev/net/c/d2ccd0560d96
  - [net,v5,02/11] net: hold instance lock during NETDEV_REGISTER/UP
    https://git.kernel.org/netdev/net/c/4c975fd70002
  - [net,v5,03/11] net: use netif_disable_lro in ipv6_add_dev
    https://git.kernel.org/netdev/net/c/8965c160b8f7
  - [net,v5,04/11] net: rename rtnl_net_debug to lock_debug
    https://git.kernel.org/netdev/net/c/b912d599d3d8
  - [net,v5,05/11] netdevsim: add dummy device notifiers
    https://git.kernel.org/netdev/net/c/1901066aab76
  - [net,v5,06/11] net: dummy: request ops lock
    https://git.kernel.org/netdev/net/c/dbfc99495d96
  - [net,v5,07/11] docs: net: document netdev notifier expectations
    https://git.kernel.org/netdev/net/c/ee705fa21fdc
  - [net,v5,08/11] selftests: net: use netdevsim in netns test
    https://git.kernel.org/netdev/net/c/56c8a23f8a0f
  - [net,v5,09/11] net: designate XSK pool pointers in queues as "ops protected"
    (no matching commit)
  - [net,v5,10/11] netdev: add "ops compat locking" helpers
    (no matching commit)
  - [net,v5,11/11] netdev: don't hold rtnl_lock over nl queue info get when possible
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



