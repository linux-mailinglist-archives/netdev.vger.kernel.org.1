Return-Path: <netdev+bounces-173155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A66BBA5783C
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 05:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D49D11734D9
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 04:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18E6915687D;
	Sat,  8 Mar 2025 04:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+0o7tKJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34362CAB;
	Sat,  8 Mar 2025 04:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741407003; cv=none; b=YIlz3qJScUjUxUJqLjElD/g5zDkHxWARVcJHfB0pg5Bt7IFEeqMYNTLj30ZnFgzPlTP3EOqfUMmuZtvZ45tom+W7TUFO3OjlAKABfxKRl3BS8iw+Ar1Cu+nMUBbcAqbjxx0t3GCjKNczkOrKtoKcc4TtlvSyM5TZYtsycg8S1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741407003; c=relaxed/simple;
	bh=fRP8SZLkJrLqavgzqVtzfiFeKnhkJ6/7/snyOvPYj5g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=I1a77TM3FODHWPJUiQjTtwcwkYh10pwSAlye08dHRmcOmEvA4F2Fe5Zo7ikXK2wjbEEleThf8mJs5ZmbG9T7Hv6ji7VPxeVY3RnFR+72p5Kgs1nnYXwN5fD4m9ds8RBAfXDAGjDJI3asQSVf2J/bVwmEuCdyBx8aWbMyhEqShf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+0o7tKJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DD7C4CEE0;
	Sat,  8 Mar 2025 04:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741407002;
	bh=fRP8SZLkJrLqavgzqVtzfiFeKnhkJ6/7/snyOvPYj5g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I+0o7tKJxismgEEZ77JdvHUHtLxXFLWRbGCjYhdwE+rvme2UjMYJOQWNSGE3xmHFk
	 6aGM7mae219HPWQ6rP9U2fjm7JDbE900BQirg7qOI4Lvni8HgMAMSV+C5s/9TVlhe6
	 hqxmi94piZwOJiqYhOjq1OoScUGHxQTS4bUzyTPVLZruwbxCYyTVYwH/iWV3hllfcM
	 YYUT6tlp+/aps/VM53C2epSygS6dg7fFniyZP6GTk8PGMqXYeezQwyM4IWlHtQ/UXB
	 PatdyGWIHue46n0l9M5ylSIBlJO6itBYWD+FZ5JdYkIACYLW3/rqBSvwT6b9SBeaos
	 PYuukHZT+YvjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34129380CFFB;
	Sat,  8 Mar 2025 04:10:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] netpoll: hold rcu read lock in __netpoll_send_skb()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174140703601.2576884.2534454406231476474.git-patchwork-notify@kernel.org>
Date: Sat, 08 Mar 2025 04:10:36 +0000
References: <20250306-netpoll_rcu_v2-v2-1-bc4f5c51742a@debian.org>
In-Reply-To: <20250306-netpoll_rcu_v2-v2-1-bc4f5c51742a@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, amwang@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 06 Mar 2025 05:16:18 -0800 you wrote:
> The function __netpoll_send_skb() is being invoked without holding the
> RCU read lock. This oversight triggers a warning message when
> CONFIG_PROVE_RCU_LIST is enabled:
> 
> 	net/core/netpoll.c:330 suspicious rcu_dereference_check() usage!
> 
> 	 netpoll_send_skb
> 	 netpoll_send_udp
> 	 write_ext_msg
> 	 console_flush_all
> 	 console_unlock
> 	 vprintk_emit
> 
> [...]

Here is the summary with links:
  - [net,v2] netpoll: hold rcu read lock in __netpoll_send_skb()
    https://git.kernel.org/netdev/net/c/505ead7ab77f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



