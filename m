Return-Path: <netdev+bounces-158653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5C6A12DBA
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 22:31:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AD253A4EFE
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 21:30:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 046CC1DC9B3;
	Wed, 15 Jan 2025 21:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="br44vxiJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2EC1D5CDD;
	Wed, 15 Jan 2025 21:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736976627; cv=none; b=iJr9rH4Q1JCiR/r7dY7Xtwxtc9W5jJ3gcAVI1Qft5BvFY+1Iglj0unsM1ouXN0IGETKclDU3ODNTsoDZnqYhyTjGqLXlklh61tYmGD2pUgqbDrq45tb3TxAQ3GSpPQ47aUjdg7uJaragbHsTB8fSxrea65tce+Sb5ccN09x7Klk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736976627; c=relaxed/simple;
	bh=Vg0WsGDlVMWpbnBJAKu2ClFQGHk9B7e8AqXTWLEtsbc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Xq25iYbmnakECM4HMkMw7HMXHOBmM3vjCmV3FJg4Dq4D0eqrTPpUJXAd/Zm59v2D4QtVC+PYxQ6aUPx1n+S5u5uMYU+cHSdcg2P8rzKBpeUkKsoZjm3b+CZw2Wdbgfg4yUztpZCZcpb2jhU3tDr7XLLI+o0glLOFvbxKaWtbbzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=br44vxiJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A56BC4CED1;
	Wed, 15 Jan 2025 21:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736976627;
	bh=Vg0WsGDlVMWpbnBJAKu2ClFQGHk9B7e8AqXTWLEtsbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=br44vxiJZ3dlWUgxMrumrlYDkRYGtDYBz4WQRfi9HIFkO0M63V/GvT5ADYFb7uoHR
	 HX7I9TrHhu9V920aaV4N6wVe9grVpVKkMIb2r4iTebK2xJiOzcxFyFdtZFu1taUHQB
	 L/u+WVUgHYH2+Mxv4Bst03NM0T0z9QLDQjEgDrvf/R8RjtQeQBb1L1aKlJ48tLeJLd
	 savvLGBY2NyeawL650ZlCxX+7LYDaLWxeVspVWmn6WdxOrOR2wy9LXk7/7MRaG8ZDs
	 H3IVLqeDENMBozIVaqe2P6jihs1YmRjN6AH+S9GyxVx7vvWtDXgT8O9aSQCcvsl1yT
	 ZYK7ifH0JdTTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DB0380AA5F;
	Wed, 15 Jan 2025 21:30:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mptcp: fix for setting remote ipv4mapped address
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173697665009.885620.754430137964950343.git-patchwork-notify@kernel.org>
Date: Wed, 15 Jan 2025 21:30:50 +0000
References: <20250114-net-next-mptcp-fix-remote-addr-v1-1-debcd84ea86f@kernel.org>
In-Reply-To: <20250114-net-next-mptcp-fix-remote-addr-v1-1-debcd84ea86f@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jan 2025 19:06:22 +0100 you wrote:
> From: Geliang Tang <tanggeliang@kylinos.cn>
> 
> Commit 1c670b39cec7 ("mptcp: change local addr type of subflow_destroy")
> introduced a bug in mptcp_pm_nl_subflow_destroy_doit().
> 
> ipv6_addr_set_v4mapped() should be called to set the remote ipv4 address
> 'addr_r.addr.s_addr' to the remote ipv6 address 'addr_r.addr6', not
> 'addr_l.addr.addr6', which is the local ipv6 address.
> 
> [...]

Here is the summary with links:
  - [net-next] mptcp: fix for setting remote ipv4mapped address
    https://git.kernel.org/netdev/net-next/c/0e6f1c77ba80

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



