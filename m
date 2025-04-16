Return-Path: <netdev+bounces-183059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFD0A8ACB9
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 02:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDF647A57F2
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 00:29:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBBBD1C1AAA;
	Wed, 16 Apr 2025 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCU2W+nt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9362749625;
	Wed, 16 Apr 2025 00:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744763436; cv=none; b=I97+bxVkRmPCVrymgXAuzPIq0O/lbXo5bFLcWRHzt9Lu4G2qrKgpuxIY7p5m83ToC5A/3cv/w/yR4GF7daAo0l1EZmJkay8ZIMuqwpYWiT/+tK5DS9PFYqt0PtoZ0pCE95SYhqRNBQB3hJ4ueokSZSJCQjzJdTFqF9HbV6S1D0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744763436; c=relaxed/simple;
	bh=HqbwgLIfaLib+zE68ylzsDmzkvhDwM7JktzYJzIXCe8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cgpVYq9ztSPbZu07yE88WroswHdC5ECiDvZBQxtXS0igQ1Ip9GHEmV8p+xORMavQz3Bo1PTCKoY3ipno75s6qvZGaRLxWYQucjmajMmO4/ynPkTbSXiOsRMO6dYwoc3gX6sj934bugD/eOpvi99R33RKneAWbxwB6hdTjWbEk7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCU2W+nt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B969C4CEE7;
	Wed, 16 Apr 2025 00:30:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744763436;
	bh=HqbwgLIfaLib+zE68ylzsDmzkvhDwM7JktzYJzIXCe8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pCU2W+ntWRR36EFd/aYtv+vEyjenaDr0w6ABxsnFYoSnfLec/UhxqCGtcrOiQL7FB
	 /1H8v8iKWsW+P0fS+jURRrka4tYZn30fhD8wvEcqh+S13bqAZTn5EgDS+KSe6hrLmA
	 sPTdKjwaxdtO27lV8rKtEi62EwEiESFbG9oN9vO6L4U2Q73JVsYQthkoJgUxWYZxj4
	 wCrH+QZRGWJiHC35/RthVQEDLdvXjMd0vzfqToKxAL4M2+Sn3z/o3bogGMXkYIZSeV
	 xJ5z3tylsw2rcxe2BEy8gSGJSgnIkwBUzmkNyI+7fYzWoQyESSw9GW1pMLcIUFleVJ
	 fZKz6VWxCSL4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C733822D55;
	Wed, 16 Apr 2025 00:31:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: fix port_np reference
 counting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174476347401.2827197.2655407911692251822.git-patchwork-notify@kernel.org>
Date: Wed, 16 Apr 2025 00:31:14 +0000
References: <20250414083942.4015060-1-mwalle@kernel.org>
In-Reply-To: <20250414083942.4015060-1-mwalle@kernel.org>
To: Michael Walle <mwalle@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, grygorii.strashko@ti.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 14 Apr 2025 10:39:42 +0200 you wrote:
> A reference to the device tree node is stored in a private struct, thus
> the reference count has to be incremented. Also, decrement the count on
> device removal and in the error path.
> 
> Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
> Signed-off-by: Michael Walle <mwalle@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net] net: ethernet: ti: am65-cpsw: fix port_np reference counting
    https://git.kernel.org/netdev/net/c/903d2b9f9efc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



