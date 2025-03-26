Return-Path: <netdev+bounces-177729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1B0A7171C
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06B8D3B0460
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 13:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3B21DED5F;
	Wed, 26 Mar 2025 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMUYdbxC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661161CB9EA;
	Wed, 26 Mar 2025 13:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742994594; cv=none; b=TJQzogcayyxUdOoh1dr6TGdkPBupNry7u6RDXlEkwt0l933xHArciTGnXPVGUT3AFkDEFw51S3RrysxcVXwFonF5hNQ0C6g2XFGpIKWFANs5nbUFdOtHVEiXD3o5mrRU2CSqPq6BxtMVijESeOOuCqrYD7oW7bS2Zp/bSFn/I4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742994594; c=relaxed/simple;
	bh=/CuSQAN5XtE3XMwAIx/e9yVUUn9SWfXEiOtAErZp3rI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YISSXnauykFSXzGaKT0o478bzUtlQdqsqY8U62SuASusluBtP1U2AOXIc2dPmDfT+gQuFn3UiLQGYvGAPYQwbkgRQ4VdJousUjZ82vhbcAc9KZBVzhI5JNBEn43f0mBCDYH0XqThOPMG7abXdFqXMobF/sD6kkJg1bZEVr+vSsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMUYdbxC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E376EC4CEE2;
	Wed, 26 Mar 2025 13:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742994593;
	bh=/CuSQAN5XtE3XMwAIx/e9yVUUn9SWfXEiOtAErZp3rI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GMUYdbxCXe9gU68uCK6/lbj6769d6nnoH6sgcu0R+miix6uCZFFWGmvlgFfI1cB38
	 3n4zDy0evXaQDUj9yV7IxPqqDPVpdZsW5K+5lWwA4htdAXqUTOshxG5OcFCI9xhoS2
	 UeN8VzJRWXSOqJ/AUc3jjlCb1sZACTywf93POSQD77487cN36qwrkMw89tiWevCz1w
	 49DD8GPdHjdXo8SEtkwetr2awYEt37XrlYChrNGqBf+90jonkkcDO+mVChLqYRpMO2
	 QAkrKaFyYXoyxXfZLLHOC/jzsuPtgAWxoJnPMQ1yrTWUMzCqgGs8dKKo0yGTycJegi
	 juKpldD8zyJdw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70DC83810901;
	Wed, 26 Mar 2025 13:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mctp: Fix incorrect tx flow invalidation condition in
 mctp-i2c
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174299463026.1310063.14750398423292359224.git-patchwork-notify@kernel.org>
Date: Wed, 26 Mar 2025 13:10:30 +0000
References: <20250325081008.3372960-1-Daniel-Hsu@quantatw.com>
In-Reply-To: <20250325081008.3372960-1-Daniel-Hsu@quantatw.com>
To: Daniel Hsu <d486250@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, Daniel-Hsu@quantatw.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 25 Mar 2025 16:10:08 +0800 you wrote:
> Previously, the condition for invalidating the tx flow in
> mctp_i2c_invalidate_tx_flow() checked if `rc` was nonzero.
> However, this could incorrectly trigger the invalidation
> even when `rc > 0` was returned as a success status.
> 
> This patch updates the condition to explicitly check for `rc < 0`,
> ensuring that only error cases trigger the invalidation.
> 
> [...]

Here is the summary with links:
  - mctp: Fix incorrect tx flow invalidation condition in mctp-i2c
    https://git.kernel.org/netdev/net/c/70facbf978ac

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



