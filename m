Return-Path: <netdev+bounces-155176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEEDA015BB
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 17:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10C471626AB
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 16:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF101A29A;
	Sat,  4 Jan 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W73Y7aAD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DA51FAA;
	Sat,  4 Jan 2025 16:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736007612; cv=none; b=Baw7Ses/64Y5LQCMN4rIcblCDlS1i33gfOwQMkHW9/nGJWKeI3dp8/+qn8HhIezbFbvmA4ZcDpJYVaXpMI3JjIZFHE+U+Mi+1OPOGaG+t/MxnzCnP2/bsUMqGcj9lGZwbh6zfihBzii6E4FXE+jif1COddQzA3smsev3vLzX6zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736007612; c=relaxed/simple;
	bh=IMLzQxrmwWImyfzM6JugO7DdO0/LShkNXtQ0aGS0y7E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=l4ppbpHXtrjY4FwjZdISY3UDdaFqfjrpbm+SGUhnB2pG/X+dmStz37BwySCxjD+VFHwmVct37ChxVHvQvJsVON8x4Ex8oEio6xFmRERmz+YUFiChRg1QycggdVuEtF8/m3SDG+qxqXYlVhTv7/isoGxE/27AyITDXxqo6ZfNrYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W73Y7aAD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41086C4CED1;
	Sat,  4 Jan 2025 16:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736007612;
	bh=IMLzQxrmwWImyfzM6JugO7DdO0/LShkNXtQ0aGS0y7E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W73Y7aAD79qPig2HCaa+1mvT62l5HxzSSA1uF1XqS19tUeeFR47mAnuVWWw8C1CoS
	 pVt/FtH6uEkF6dLCIpX/yD7if6hJhkR2r0GgYxcHVwBZpqNo6TXfnECpPPNolR8PXI
	 2ylRHtGZm9ZoqMLpH4sBaBJ7ssDrIrkZbMDC2RTm0OH6RQpm3mZ3uHfG1UwnGj4SSS
	 zrE88YZ9IcoHyVZmMKMcrikHJJyvuI9UPr8PijdZsul/11hoaG5JeXhFRqCSlFZj9w
	 EgTz8lgc4MzDuelZXaxdDCuIYKAhp23CY3idmz18stNgvSsfLeDGjS81SCtz5H/Ugs
	 CUgZWDau76lJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3485B380A96F;
	Sat,  4 Jan 2025 16:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: 802: LLC+SNAP OID:PID lookup on start of skb data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173600763303.2464594.17318802416653468706.git-patchwork-notify@kernel.org>
Date: Sat, 04 Jan 2025 16:20:33 +0000
References: <20250103012303.746521-1-antonio.pastor@gmail.com>
In-Reply-To: <20250103012303.746521-1-antonio.pastor@gmail.com>
To: Antonio Pastor <antonio.pastor@gmail.com>
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, kuba@kernel.org, davem@davemloft.net,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Jan 2025 20:23:00 -0500 you wrote:
> 802.2+LLC+SNAP frames received by napi_complete_done() with GRO and DSA
> have skb->transport_header set two bytes short, or pointing 2 bytes
> before network_header & skb->data. This was an issue as snap_rcv()
> expected offset to point to SNAP header (OID:PID), causing packet to
> be dropped.
> 
> A fix at llc_fixup_skb() (a024e377efed) resets transport_header for any
> LLC consumers that may care about it, and stops SNAP packets from being
> dropped, but doesn't fix the problem which is that LLC and SNAP should
> not use transport_header offset.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: 802: LLC+SNAP OID:PID lookup on start of skb data
    https://git.kernel.org/netdev/net/c/1e9b0e1c550c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



