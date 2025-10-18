Return-Path: <netdev+bounces-230633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB54BEC117
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 02:01:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C205189713C
	for <lists+netdev@lfdr.de>; Sat, 18 Oct 2025 00:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E88314D00;
	Sat, 18 Oct 2025 00:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R92QS/qi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B4A31355F
	for <netdev@vger.kernel.org>; Sat, 18 Oct 2025 00:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760745641; cv=none; b=QmEWx29Ya9ueXIYzEt3f9pno4SGAiExfnqtQpd1PfBn2GJ/v5iTdW5PsL9bmUTTChVcQR3T7T6OiZWcoaNFNnEMZPZsyrSJbM0H2NwDiKftdMTZ0a2vCdc9qV4qDWYWKJcgh7+rCaZW26Fh7oGLbzZi2FRvSROE6gSyU1+KHImY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760745641; c=relaxed/simple;
	bh=l1EmHOZc02jeaixE1d/XV8c7ezZ6rmS0jX7hj/Gn/GE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jG9ZnjYFd5xwu46d08fzcEsMF3Ba9wK0W17uG276iMwaByQByMHEbDuIzNvaFXmBwbsmCatWknu25PhIbPru2cfejYm44SH3GH9IFqvrpNHLGvBsIvu6Xm0zpDOviomMabt4kwmVD8s8JpQwbWnjcmojff8xlLlxNrl2Zdf7otU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R92QS/qi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35FEC116C6;
	Sat, 18 Oct 2025 00:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760745640;
	bh=l1EmHOZc02jeaixE1d/XV8c7ezZ6rmS0jX7hj/Gn/GE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=R92QS/qiNPCaYDpF+2NnNCZ6dcsb3yvRE7yz4oVth47nWCJBQfHvj0aznAt719/EV
	 /FoeD/R4ruco2JQ9I91q4H8TqOnFOWgpQrrIK/SQL3td3HbcORYhOy5TU/0pZ2vWut
	 KDlFmeB4C1gEWk3ZP91yp2Q/3i2f2LeafPo1/9Mal4cunuOE5opm/xqj28GGzpVvpT
	 UkVLHWWZUJCrSD+PMQmH+7cJbHv85c0aECvhI+NIMS+uGFmEVJAB+JXmdwR8xa7bN5
	 voVtK3ZQQKtPrOkhfEcwK9rAlV0A5PmhcqEl3qmkO35F+tzYUbQlNiKGJ90000LKdt
	 yNFmNgpiRD5kw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE9639EFA61;
	Sat, 18 Oct 2025 00:00:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESUBMIT net-next] r8169: reconfigure rx unconditionally
 before chip reset when resuming
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176074562431.2830883.4987568665374178537.git-patchwork-notify@kernel.org>
Date: Sat, 18 Oct 2025 00:00:24 +0000
References: <a5c2e2d2-226f-4896-b8f6-45e2d91f0e24@gmail.com>
In-Reply-To: <a5c2e2d2-226f-4896-b8f6-45e2d91f0e24@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 16 Oct 2025 21:25:28 +0200 you wrote:
> There's a good chance that more chip versions suffer from the same
> hw issue. So let's reconfigure rx unconditionally before the chip reset
> when resuming. This shouldn't have any side effect on unaffected chip
> versions.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [RESUBMIT,net-next] r8169: reconfigure rx unconditionally before chip reset when resuming
    https://git.kernel.org/netdev/net-next/c/3dc2a17efc5f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



