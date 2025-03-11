Return-Path: <netdev+bounces-173877-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04553A5C149
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 13:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5DE418823EC
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 12:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B360257429;
	Tue, 11 Mar 2025 12:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zzem8BBi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B13256C9F;
	Tue, 11 Mar 2025 12:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741696200; cv=none; b=pFA7E1xz7YTXKW6bpxkQsFNaxppC6xGH1q8KulYuZGYBP29kM7bKVjPeltkQvz42hqR1Zv9C2mmLUfkA7EGD30TpJErqDNzUIEVIae+dIpVd7xf6sOMXvK3fxDt+nFpybjXEE11KRlw5hCoPDGXCC2aG5kmY0mNiCf5f/4Pgjag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741696200; c=relaxed/simple;
	bh=Ee7hHWfkm+xKwxzJg+z202o5UCLFsa7BvdJMo8G5fJM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Qd2YEDBaKguq7HwAXdxHxXK8qffcOBKWrHD+oZY+78ve8TTEIOPrMGE1Qp7jjl1sqg07PR5n+foZSvSMj5z9Ncvl4kunwQi6MKn4NsWg03FM3wCZz7FvtayeLv6qMGwIsIe7xOdR9xjg72xZePUsCWkeX67i0/BPTlWDbA6+ypk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zzem8BBi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EB9C4CEE9;
	Tue, 11 Mar 2025 12:29:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741696199;
	bh=Ee7hHWfkm+xKwxzJg+z202o5UCLFsa7BvdJMo8G5fJM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zzem8BBiqi0M+lknQama8DJfeiQ1bsN2ZoyOsNJEAhP2O2lEIUTXs71fmju0mkzQD
	 zvGaSjtOhi3kWkKm6sdzgp8RQXQKTQF0uKWGk1fGr51qtqwI7fb4EOWItU3PlIPKEP
	 h1IgM8u5pKVeWpCWelzs+gUibctKf8pHNs/MajWzXUrsUfCVp/+dyvBhgfC4p3H4To
	 8O3AX2jxN+z+TVMuZVO+5DgC2N+KmQH16bMokNHgHtV/8LwndLAbFgT9Y7bLdzh9Mo
	 XyHGcoOHZKimeTyREN3iWbhnlaORP50frnooMxtYe8G3TTUKnoprZEBefXHkDx7B6m
	 Zbroc6uluPy5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADF1380AC1C;
	Tue, 11 Mar 2025 12:30:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rtase: Fix improper release of ring list entries in
 rtase_sw_reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174169623350.66274.14221491464491416712.git-patchwork-notify@kernel.org>
Date: Tue, 11 Mar 2025 12:30:33 +0000
References: <20250306070510.18129-1-justinlai0215@realtek.com>
In-Reply-To: <20250306070510.18129-1-justinlai0215@realtek.com>
To: Justin Lai <justinlai0215@realtek.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, horms@kernel.org, pkshih@realtek.com,
 larry.chiu@realtek.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 6 Mar 2025 15:05:10 +0800 you wrote:
> Since rtase_init_ring, which is called within rtase_sw_reset, adds ring
> entries already present in the ring list back into the list, it causes
> the ring list to form a cycle. This results in list_for_each_entry_safe
> failing to find an endpoint during traversal, leading to an error.
> Therefore, it is necessary to remove the previously added ring_list nodes
> before calling rtase_init_ring.
> 
> [...]

Here is the summary with links:
  - [net] rtase: Fix improper release of ring list entries in rtase_sw_reset
    https://git.kernel.org/netdev/net/c/415f135ace7f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



