Return-Path: <netdev+bounces-248167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0141ED04F8F
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 18:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B894F314A09B
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 16:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42492D1F4E;
	Thu,  8 Jan 2026 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fQItvUjM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DB127510B
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767890010; cv=none; b=R+MHorKi8fbrFgo2kDEJoNG0LcnCToKVQ/tEBd7YcDrezZbMIvSxCeGl2Hm09fAXA9d1ceBLYkLv8ZEEdDLdDTVEgpE/TyqOtiYATJ7N4ORza1WMDcBE6qHDeoTO4fqx38MIU99xiDzBRUpKVdoTyDs7QE6yx/wOiUboS5QZe7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767890010; c=relaxed/simple;
	bh=Nc+yhtPCN5VLSFyoNAfFR+SU3c4k2d2Xh2QHSqc0ASk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IA2DykjXRvWtmpncZUP55wkO4YjfuJdQvI4JNU5GUCOP1fn7lImSVva5gAxg4GsRyXfV5saWivvBe5tB7EUhRa51+3sXs6XT6t8okcernxb/mjIKDQiSuXD29dcIBACOEulGDjm+itM5vwdnFuBpJc09UW40sJjJPwffoey/KQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fQItvUjM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44BE4C116C6;
	Thu,  8 Jan 2026 16:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767890010;
	bh=Nc+yhtPCN5VLSFyoNAfFR+SU3c4k2d2Xh2QHSqc0ASk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fQItvUjMWvtsDOAwYYuJLNncz+xnGuERsWKaWwZpK0l2gMMkCvKdNKeMMjSgresvm
	 aifcVfCjicfxTvZggKcZ74PDNUg91nQskZCskDFd1/35Hk+Tc8r01H/6DFIQqhVvde
	 HSmdIqQsdMIr/75zVOoR5Apteo7oKjabXujeusg/aaotcpGArj7e+JO7W1NvGEO/eb
	 BSLMvf1QdRGVfqWvPl8j2PTyfxooaEQYaeuf1fDRcUgEthqjDnq5Aqj0CfegZlKkHR
	 9hyN0D/DgXIEM8v9xcLRa0cE31bSBVUCDoBbyWZJXDR2O7WhFadtUAxy/7MuLNE4mQ
	 K443q7G9sy9KA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F2A453A54A35;
	Thu,  8 Jan 2026 16:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] net/sched: sch_qfq: Fix NULL deref when
 deactivating
 inactive aggregate in qfq_reset
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176788980679.3708662.5422186545294413281.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 16:30:06 +0000
References: <20260106034100.1780779-1-xmei5@asu.edu>
In-Reply-To: <20260106034100.1780779-1-xmei5@asu.edu>
To: Xiang Mei <xmei5@asu.edu>
Cc: security@kernel.org, netdev@vger.kernel.org, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Jan 2026 20:41:00 -0700 you wrote:
> `qfq_class->leaf_qdisc->q.qlen > 0` does not imply that the class
> itself is active.
> 
> Two qfq_class objects may point to the same leaf_qdisc. This happens
> when:
> 
> 1. one QFQ qdisc is attached to the dev as the root qdisc, and
> 
> [...]

Here is the summary with links:
  - [net,v3] net/sched: sch_qfq: Fix NULL deref when deactivating inactive aggregate in qfq_reset
    https://git.kernel.org/netdev/net/c/c1d73b148023

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



