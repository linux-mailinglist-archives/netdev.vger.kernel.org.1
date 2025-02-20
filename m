Return-Path: <netdev+bounces-167974-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 34010A3CFC0
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 04:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 138AC168A48
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 03:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A05D1DA62E;
	Thu, 20 Feb 2025 03:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E0nCZmJu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2522613A3ED
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 03:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740020401; cv=none; b=huR2PNU0drVyUHlmvpzpCey46QEVm6hyFMj96fNEXg5Eh7P8aK4yLT9kE0/SiAjGgw4lmjPnVjV1j1sneTj9HDU53yu2DEMKJJo9OvPz0RXMV5y0pLhT7Z2KMPz67eGc0v7jzdjA4BMI+SJkoWAISCzGGKHON+mjWyl+qZJD070=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740020401; c=relaxed/simple;
	bh=YWD44Y8ICkL/p+Fh9VYGcrTlXo+2BWHZM9ErYQsh/To=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oUm6o0YaibnBtu/ouNazmYPjw32G0um4MlyqsDOC7gl8KhIFyqWYQt2XpnDHnO5mzZKzsJA1pl83i7Jvmtbinf5WIQaBqGeqAhC2rnfnxH6iFNwNRN58sLD4NlYuoqFtShCAeTCCuUf0wvjJPIie7tHI8e1o+HozZWtAXtePfGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E0nCZmJu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D2DAC4CED1;
	Thu, 20 Feb 2025 03:00:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740020400;
	bh=YWD44Y8ICkL/p+Fh9VYGcrTlXo+2BWHZM9ErYQsh/To=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=E0nCZmJu+qtt+kgFr8qdm8lzBH7pof5eRSo/7rSmVewC3SUVeYd621oP+kyddy5ZZ
	 wWWymHJpYnfaaYBGE25k+uOusOluF44KKTojkDpbToVaHIvc3PKOKlZvtwn4uWvqea
	 oTUGOorey/87BTfyLFSXr+5j0d3jrxPl49DZARBen4K3GBTCM5idAcUuY6RocOgiXV
	 iGQCcJqtJWp3XRnL36cU7DGhdVCfucyOhdfIBD2xnBeSvciiNMG6BuDYU2iNNYQv3d
	 zr/QxTQDNijaZoTCQlLJ3Oh00u+gsmqaFKahzJYxWmKcR1aQ+IJ5qdEXHKNR2Ywe5t
	 naLvoh3cjOyeg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 71B75380AAEC;
	Thu, 20 Feb 2025 03:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net 0/2] gtp/geneve: Suppress list_del() splat during
 ->exit_batch_rtnl().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174002043126.823548.4793378703065809862.git-patchwork-notify@kernel.org>
Date: Thu, 20 Feb 2025 03:00:31 +0000
References: <20250217203705.40342-1-kuniyu@amazon.com>
In-Reply-To: <20250217203705.40342-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, spender@grsecurity.net,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Feb 2025 12:37:03 -0800 you wrote:
> The common pattern in tunnel device's ->exit_batch_rtnl() is iterating
> two netdev lists for each netns: (i) for_each_netdev() to clean up
> devices in the netns, and (ii) the device type specific list to clean
> up devices in other netns.
> 
> 	list_for_each_entry(net, net_list, exit_list) {
> 		for_each_netdev_safe(net, dev, next) {
> 			/* (i)  call unregister_netdevice_queue(dev, list) */
> 		}
> 
> [...]

Here is the summary with links:
  - [v1,net,1/2] gtp: Suppress list corruption splat in gtp_net_exit_batch_rtnl().
    https://git.kernel.org/netdev/net/c/4ccacf86491d
  - [v1,net,2/2] geneve: Suppress list corruption splat in geneve_destroy_tunnels().
    https://git.kernel.org/netdev/net/c/62fab6eef61f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



