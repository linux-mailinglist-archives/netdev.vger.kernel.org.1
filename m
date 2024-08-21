Return-Path: <netdev+bounces-120392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0186C9591EE
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 02:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9821F235FB
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BC91758F;
	Wed, 21 Aug 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="krJzJmzF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A99637482;
	Wed, 21 Aug 2024 00:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724200832; cv=none; b=ntwX+xm3uzVBkJWa7T268Xx4vg2+oBTb3fCkfFCIKHFGIqZFZuiz6K3NrahlGwP2r3hKoy+1el20vR4J3zpwu6/65he9dxNDo3kAbaT/udSmorJTlhht6kBaK7U6JyqyKHNgUlvFH1nxZWR/qjsAQjlsMTqBELcXkfklzcnFkMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724200832; c=relaxed/simple;
	bh=Gjz1hlAA+B/3AVszMI2pyR5RCXsyw2opJkBuoUJlKSs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y2idfSMIW1xC5h2QX8wsIkXhqStBBMYsxJbCJv5lc5eRFHtJnPlBBysGBqf+/A+LJA4HrN+Y5IsaE4tUeCtDFDR+7uMunsYiAQ8KO0+HG4w61d8rh/Es7e/Z3y1N39jfEg/2R+qiyxmXlcKZhewPfkeWm4cRKLCWuvbLrknAoCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=krJzJmzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38BB6C4AF0B;
	Wed, 21 Aug 2024 00:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724200832;
	bh=Gjz1hlAA+B/3AVszMI2pyR5RCXsyw2opJkBuoUJlKSs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=krJzJmzFo2UrOxhMP8hu22I3Wu1UXWZMpfs+GHQU63l67hXZznIWJwQhKGfuGP9UD
	 bwl1KpRr8ft8K8TIG3ngS9LhDG0P60kdRn1OQHyQ00yerfYHk5XqMdnkOYy6Y1b5G/
	 2xa8aKlg9St8KIL6Vjll1aXFJdibWUiz4j3KIroGmZwLlfcimN1Rp8jhS7EPC3YGyM
	 ouCvFJ5DX73CSlb4WlEnqAgq4kW8JiMse92DzXuvIZ6ZqVHOwJf7Z30z5ns+hesSn+
	 C2NQvEx2ZzR3s28YOXmbATBsqmw5qxlFLFxUFMMczz4LLhoB90yZRAPqBAIXWigZLR
	 65SmTZegqW5ww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFB33804CB5;
	Wed, 21 Aug 2024 00:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] netem: fix return value if duplicate enqueue fails
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172420083178.1283142.17547445579493801272.git-patchwork-notify@kernel.org>
Date: Wed, 21 Aug 2024 00:40:31 +0000
References: <20240819175753.5151-1-stephen@networkplumber.org>
In-Reply-To: <20240819175753.5151-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, markovicbudimir@gmail.com, jhs@mojatatu.com,
 xiyou.wangcong@gmail.com, jiri@resnulli.us, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, lansheng@huawei.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 19 Aug 2024 10:56:45 -0700 you wrote:
> There is a bug in netem_enqueue() introduced by
> commit 5845f706388a ("net: netem: fix skb length BUG_ON in __skb_to_sgvec")
> that can lead to a use-after-free.
> 
> This commit made netem_enqueue() always return NET_XMIT_SUCCESS
> when a packet is duplicated, which can cause the parent qdisc's q.qlen to be
> mistakenly incremented. When this happens qlen_notify() may be skipped on the
> parent during destruction, leaving a dangling pointer for some classful qdiscs
> like DRR.
> 
> [...]

Here is the summary with links:
  - netem: fix return value if duplicate enqueue fails
    https://git.kernel.org/netdev/net/c/c07ff8592d57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



