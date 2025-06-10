Return-Path: <netdev+bounces-196383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E705CAD46E3
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 920B33A5009
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C53F28A1DD;
	Tue, 10 Jun 2025 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uXuZ/iaq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0617A286D62
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 23:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598755; cv=none; b=mZ5TZ9HlQPRXq7B358P/AZEyZu7VMy0Y/epNs4CORHykoYVe+4pHqxqaVUxdqSUb8KYE54Y4dMhahcbUq+cQJ4gWAT1xtc1KvLwclAfP8zRVjOr1rCgeg0fOfOfmMPn5eQ2biXzHIN95QtpPXRv77OHkGyXzqVlO9MXL8H51v7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598755; c=relaxed/simple;
	bh=dQqvqy5jM4Kw/KaMrb/822UamyamkcS4EuAXGDR2s30=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ktS2dbtdNST8QTHKI6ieArxw/eBkGfVi89Fcfkvuk3//i7ROXZJtO0kvPq4HxVwIJ79eEnYpBCSoVQE22eKp7ZC/Q9Byx9yMMfBAnIjzGqlw/RgOBldMgxJShYhQ5ZsW4FMxZm2UoLbdGl5pCFbBzXp6svLHsuvOPwpDQowFFA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uXuZ/iaq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE290C4CEF0;
	Tue, 10 Jun 2025 23:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749598754;
	bh=dQqvqy5jM4Kw/KaMrb/822UamyamkcS4EuAXGDR2s30=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uXuZ/iaqvzSQf967Gq7LRdiKcCQJYVJj5wSapn6tPZXPHzj8fIXx6n99cB8GUULkI
	 4yVmUczIEjibvRWZU2jvodK0eR2d/K+cJzV9BuU4R2vurqpPZmRzLTNnt7+e0ZJi9H
	 WG21bVtGIEmHzK/PiW6bxhfe1gp+VEY/7/tMmjI8EJUFKE+DTjc6q8HsvSld8sUoOd
	 k9TLUl/5W7gtDAKJe492nwViKl/CS8lOATE71WEL/4CNuL+x+2h2D1la+RcVRGOCFA
	 o7p6BHylhiMjQ/LmIN1DbfFDVcJlfaz098TayVMRT2ZA3yy2uMOQHdISlvcu+wIVBo
	 BeewI7tsL57jw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D3038111E3;
	Tue, 10 Jun 2025 23:39:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net-next PATCH] octeontx2-pf: Avoid typecasts by simplifying
 otx2_atomic64_add macro
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959878522.2630805.9404523510094095917.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 23:39:45 +0000
References: <1749484421-3607-1-git-send-email-sbhatta@marvell.com>
In-Reply-To: <1749484421-3607-1-git-send-email-sbhatta@marvell.com>
To: Subbaraya Sundeep <sbhatta@marvell.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 sgoutham@marvell.com, gakula@marvell.com, hkelam@marvell.com,
 bbhushan2@marvell.com, lcherian@marvell.com, jerinj@marvell.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 9 Jun 2025 21:23:41 +0530 you wrote:
> Just because otx2_atomic64_add is using u64 pointer as argument
> all callers has to typecast __iomem void pointers which inturn
> causing sparse warnings. Fix those by changing otx2_atomic64_add
> argument to void pointer.
> 
> Signed-off-by: Subbaraya Sundeep <sbhatta@marvell.com>
> 
> [...]

Here is the summary with links:
  - [net-next] octeontx2-pf: Avoid typecasts by simplifying otx2_atomic64_add macro
    https://git.kernel.org/netdev/net-next/c/c4246f4cce05

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



