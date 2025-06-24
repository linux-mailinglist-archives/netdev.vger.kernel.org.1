Return-Path: <netdev+bounces-200879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B27B4AE7356
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 01:39:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 305ED17EFEE
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 23:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D7C25B1F6;
	Tue, 24 Jun 2025 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l6W5sMul"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626152236F8
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 23:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750808380; cv=none; b=nrl20SG3827rKZkJfXe8T2VQo1aM/micC+FYu44/bZdgrTOby5+ey9JVjdsgpHj0crBHNZAK7xQSPthdX7WPvfl1+6sO8NU6u0E6QUlwxxErw0Ezg74XmpZTgj2R1SCBoLpMaq+tiK37JrHj1CuBDbwrJdiAjMdTHRNHbHqhkYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750808380; c=relaxed/simple;
	bh=MFZMiGo/3iqVsEo+ZGSv+PxaCWL4PrsylIXDsKSJqec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=A135eI1ugnFKZa9u3R0Q/yofO4NR5k8x+YGWtZK6fwi6rOffAOfIrA1ClZyW8xmWzEjvqkjRrnX9d7xXLEEQm8UDtN4ny5jR89AeXOl9BU7UH+OwDAwX145DbGRnMdzPoc0yDQgOOjX++xI0J7aL9P9NyNaIvq7gtH17dUwFdLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l6W5sMul; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DCCC4CEE3;
	Tue, 24 Jun 2025 23:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750808380;
	bh=MFZMiGo/3iqVsEo+ZGSv+PxaCWL4PrsylIXDsKSJqec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l6W5sMulEkJR2eWUiR/+k1Hi8iMvyODAHdmZhK/pbUz/iAIMYYwus/TY8tQ7FRmXi
	 ecERsU2qvkX5jK/1g95i5XSEcif0rf7DhRTxnX0WsKr/1gBv2/136fND0SGWSs/fSs
	 kClqw4nfygqwmDlSQkw7V6KnV+CLR329nfhDaW0gY5EgGw6jGb2K6M0oLjXM/KS3iG
	 muyHkr3402ir5GrS7rmgUquOMaTszdHTmZlxkA/D7UrBYSQ96EZxxFnafILQu5qKqp
	 pWg9lSoWq4wbIztYgNTcLIQyMgVKLpXQ7vvMubSt2IcqWXLFWWWFR3bngaGvjgI+Hi
	 0ZvX+o1YWi/rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BE839FEB73;
	Tue, 24 Jun 2025 23:40:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] udp_tunnel: fix deadlock in
 udp_tunnel_nic_set_port_priv()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175080840700.4073187.3769214206246182032.git-patchwork-notify@kernel.org>
Date: Tue, 24 Jun 2025 23:40:07 +0000
References: 
 <95a827621ec78c12d1564ec3209e549774f9657d.1750675978.git.pabeni@redhat.com>
In-Reply-To: 
 <95a827621ec78c12d1564ec3209e549774f9657d.1750675978.git.pabeni@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, sdf@fomichev.me

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Jun 2025 12:53:55 +0200 you wrote:
> While configuring a vxlan tunnel in a system with a i40e NIC driver, I
> observe the following deadlock:
> 
>  WARNING: possible recursive locking detected
>  6.16.0-rc2.net-next-6.16_92d87230d899+ #13 Tainted: G            E
>  --------------------------------------------
>  kworker/u256:4/1125 is trying to acquire lock:
>  ffff88921ab9c8c8 (&utn->lock){+.+.}-{4:4}, at: i40e_udp_tunnel_set_port (/home/pabeni/net-next/include/net/udp_tunnel.h:343 /home/pabeni/net-next/drivers/net/ethernet/intel/i40e/i40e_main.c:13013) i40e
> 
> [...]

Here is the summary with links:
  - [net-next] udp_tunnel: fix deadlock in udp_tunnel_nic_set_port_priv()
    https://git.kernel.org/netdev/net-next/c/c9e78afa688a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



