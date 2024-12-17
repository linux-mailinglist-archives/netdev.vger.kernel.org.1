Return-Path: <netdev+bounces-152583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 279679F4AEF
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 13:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21BC47A114B
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 12:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E566C1F3D29;
	Tue, 17 Dec 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+G5htaS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06061F3D23
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734438613; cv=none; b=hUlELBbPLue1KW4kZ+KyVPEfoI6WjhUnD5RFbVtQe7h1YMC/XW/ZmdQOIVrkZHGx8qCIckbzPZuYaKpZ/XA2oNlk5CXV+OXqt5x/8lMq5xgs3VYKsezKfkeWuTGpJv9Fyq5Uz11PysiR2M4frjoWXXgSYHmVRfmTdT4Te5zLZHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734438613; c=relaxed/simple;
	bh=4epFv5DCpZzw1lyNPS3NkIVaYVUV4Z0k6YfUc59jAKE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QgvJz3vGurVm/z/XnQG9cZjNDjHYCMuKG6Sj2pTq/d0q2PWvaKMzzLxXQghiJmlQ6By2jHsQQxks7eI0YIU85k439RxnqkCdPfgQBmTtx4ajg5xW0G4LW78e5ZSHbgncsk57RO+cr+ScUabo9m5z18X6GZRLhakm1XuM6qPslqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+G5htaS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6ABC4CED3;
	Tue, 17 Dec 2024 12:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734438613;
	bh=4epFv5DCpZzw1lyNPS3NkIVaYVUV4Z0k6YfUc59jAKE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=I+G5htaS5BGu8VuEvbc7hG50EzgKeV1YrNx0YeWNEW09FVsuO9QrF3x+5mO0fgFya
	 s5Nmvm04yOBET+Kw/pQcqDMAe7q20eKwtudYPETFe/NEoXqL3Q3zg+Ho7Lku61Y3E1
	 w5PlzJRcYWL0TMOkiY9PS6rnM+SsbbwBAYTvLuuifQW+zeHKpObIeu6+cJGr7OKZU+
	 keyUgh6stC270CVdd4/dC6CA3bfGs9F89hsh9qOzi4IR3IA8fgdJlL5mFPXA9VtlLP
	 dADsZRbxuqUrWGLLqMy3HlQGCZ7PLTb/81pvGakEJtU4zeHWJd7wdRtxq4aKEXq6I8
	 CEEzsZwQN5mSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D673806656;
	Tue, 17 Dec 2024 12:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: ethernet: bgmac-platform: fix an OF node reference
 leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173443863027.879235.10318697045394886922.git-patchwork-notify@kernel.org>
Date: Tue, 17 Dec 2024 12:30:30 +0000
References: <20241214014912.2810315-1-joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20241214014912.2810315-1-joe@pf.is.s.u-tokyo.ac.jp>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: rafal@milecki.pl, bcm-kernel-feedback-list@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 14 Dec 2024 10:49:12 +0900 you wrote:
> The OF node obtained by of_parse_phandle() is not freed. Call
> of_node_put() to balance the refcount.
> 
> This bug was found by an experimental static analysis tool that I am
> developing.
> 
> Fixes: 1676aba5ef7e ("net: ethernet: bgmac: device tree phy enablement")
> Signed-off-by: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
> 
> [...]

Here is the summary with links:
  - [v2] net: ethernet: bgmac-platform: fix an OF node reference leak
    https://git.kernel.org/netdev/net/c/0cb2c504d79e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



