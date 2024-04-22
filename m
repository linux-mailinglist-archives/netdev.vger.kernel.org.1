Return-Path: <netdev+bounces-90019-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5DA8AC887
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 11:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 87EADB21677
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 09:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93ACD53E35;
	Mon, 22 Apr 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oeU8giNc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F599537F5
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713777027; cv=none; b=i+jqxx1ARYRuRJQUF/3AnyR/XbnKsyRpjKPhlt7dvyW0hl+XxViHzq5pqxRXdWNgmP0NePAfofngT4iHztpGBNmx4b1M96onBkfDvc69aqAZ3ECMNvMx6t56CyS94mc7C3zca5A/WOOd35f1qGxBrVZ6dMLFiOOh3n1WrikO9bU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713777027; c=relaxed/simple;
	bh=zXFS/l0TMeqHGaXUP9LsJ8qVG++Kc6o5zW4wZeGQyo8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cLgSlIQKwVMx/0s9HaKA7ufWc8LrQIGmbmEzGnGWRNEavozXTwQm70tTjN78VHMY8pLVpjz5uftW69EufxGROiRUGj74pC//RedR8X558fZKxrDPTQPZSNc7AwceBR0MykdQDPgtDls8k2fDvcut4SDuM0WajW/LFayO9LAfPco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oeU8giNc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4DCDC3277B;
	Mon, 22 Apr 2024 09:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713777027;
	bh=zXFS/l0TMeqHGaXUP9LsJ8qVG++Kc6o5zW4wZeGQyo8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oeU8giNcVj1DKnoZQ+d7BgCIzfBUN6Qqts9WVPybXh4KLxtNoXrSFfpVJ4U+YIvuK
	 d0wqABH4GzeM3BmHKJ7ks9H22UuVhzNkQ4J1mJmZqY3IoTznWN74Y9Cq+vWnu8wEXy
	 DbXaSmV17IbxblUSfhCKh/IM/2WhCZo/97GTc8k9/T/+OlEHK7WLlqYzLcjOlDwzUc
	 p1N+2LZZaJREQrniXbgHrY4ClEPPOLpnfwk6o18Mu3mF6rDJAYvBwDPf2IW/BPt8zj
	 b3P/gmrJw6DI9lqCYlyO5IdCl+D4wvlSwcMv2Xnpw+92qA1besklx+ii6ILsf5eEQ5
	 3XzOGh87yYOKg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CCFEAC43440;
	Mon, 22 Apr 2024 09:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] icmp: prevent possible NULL dereferences from
 icmp_build_probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171377702683.3149.2854361679328570094.git-patchwork-notify@kernel.org>
Date: Mon, 22 Apr 2024 09:10:26 +0000
References: <20240420070116.4023672-1-edumazet@google.com>
In-Reply-To: <20240420070116.4023672-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, dsahern@kernel.org, eric.dumazet@gmail.com,
 andreas.a.roeseler@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sat, 20 Apr 2024 07:01:16 +0000 you wrote:
> First problem is a double call to __in_dev_get_rcu(), because
> the second one could return NULL.
> 
> if (__in_dev_get_rcu(dev) && __in_dev_get_rcu(dev)->ifa_list)
> 
> Second problem is a read from dev->ip6_ptr with no NULL check:
> 
> [...]

Here is the summary with links:
  - [v2,net] icmp: prevent possible NULL dereferences from icmp_build_probe()
    https://git.kernel.org/netdev/net/c/c58e88d49097

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



