Return-Path: <netdev+bounces-196389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2608BAD4700
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:50:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AAF21799A5
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448C128BA88;
	Tue, 10 Jun 2025 23:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfakQMrQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA7E1E835D
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749599423; cv=none; b=jC4Jbt0yPv0coRCRXEtzgx92evWd4dE7BjDn2AGmcFdmO1HxbfvNnHQNbNZcbyLTUt1SXCBrhXhiNJfw7hQ3Nd5By5JJI2e1Pxo7cKVbw6IqKpwaLA4q6DpY3wu9uq6dMZ4sC8weD6/2zVW43YCUVGzvk4+l1MSXsZqBhkL7c88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749599423; c=relaxed/simple;
	bh=CvMF38Tlu4zhx9a0kQENoBgJi4cnIWNCbcSjTH1etLs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZEIt1nUwq33vJe1Q9dWnU+Fu3+aCW1SS95JzKWZf+VWS07+Mw4xSyY4hKcferqrt0ucA2jUXkQ6DOM7EvPv+SCx/Cl8epUbfTl96wh95d8M/As0x0Tf6EyC0BtJFBvF5E3Bj0LZz8xC+WF3O9EfFLNQN4wfRCCLOrtqnRIFIO4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfakQMrQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9ABCAC4CEF4;
	Tue, 10 Jun 2025 23:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749599422;
	bh=CvMF38Tlu4zhx9a0kQENoBgJi4cnIWNCbcSjTH1etLs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GfakQMrQKumkiaI4oit6o0/DJZE+cg+s9apRYswvDkU3bwsvsLS97o3g+5WnjRLAZ
	 2fhfra7UeNQ/G1n0MI06EetQZ8lDVW9kQZGXioxQRCeewltyMrDZ/cXWN2LygeduWo
	 CBxAH/VNpIZYNc+/e1oo8JQWATF9wB72t4ULNhG5oMrMyhp+DUY8W77rC+Ith4EBzc
	 U/cjocmqZR/S/MN96qH+LpfBN/zHDA08b6PzVpJ8y8iOur1Cd+49IszlgxLLAvg4t+
	 fp5easwvI6TcWLjH5LVikMwPdTZw0HbT6h4xTVCahgIGhqxaFrWpaBRMrH86oG0+5E
	 l6bpClbab8Zwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B0138111E3;
	Tue, 10 Jun 2025 23:50:54 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] fec: fix possible NULL dereference in fec_mode_walk()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959945273.2737769.3505767070007602688.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 23:50:52 +0000
References: <20250518131818.972039-1-ant.v.moryakov@gmail.com>
In-Reply-To: <20250518131818.972039-1-ant.v.moryakov@gmail.com>
To: Anton Moryakov <ant.v.moryakov@gmail.com>
Cc: mkubecek@suse.cz, netdev@vger.kernel.org

Hello:

This patch was applied to ethtool/ethtool.git (master)
by Michal Kubecek <mkubecek@suse.cz>:

On Sun, 18 May 2025 16:18:18 +0300 you wrote:
> From: AntonMoryakov <ant.v.moryakov@gmail.com>
> 
> Static analyzer (Svace) reported a possible null pointer dereference
> in fec_mode_walk(), where the 'name' pointer is passed to print_string()
> without checking for NULL.
> 
> Although some callers check the return value of get_string(), others
> (e.g., walk_bitset()) do not. This patch adds an early NULL check
> to avoid dereferencing a null pointer.
> 
> [...]

Here is the summary with links:
  - fec: fix possible NULL dereference in fec_mode_walk()
    https://git.kernel.org/pub/scm/network/ethtool/ethtool.git/commit/?id=33fffbbdc12d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



