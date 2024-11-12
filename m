Return-Path: <netdev+bounces-143939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 890DD9C4CB1
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 03:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8F5283248
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A50204F6C;
	Tue, 12 Nov 2024 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CAd2uApf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6A3433BE;
	Tue, 12 Nov 2024 02:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731379219; cv=none; b=DONPTLAnAY5IVJdUZekn0/EeTkNAc23nOFiOINFs4oSZIXWyGv3sR7PzW90lyYNkjn5GexDdrR71RS1ZpZ8rssjVGIE2TTq9c1c2zANhrPzCYskAlwMxDcG87xYaLQSix52CXR5gzaGJqdFPyukIfHVLLkyE8updsh2ajDazjcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731379219; c=relaxed/simple;
	bh=W4/sdurYMk6ijto4wRNLBNq/bTT/o7RXoziTz5dLhtY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SeMOJtZ692QZt24+Ab5b/KVvVq4NGHrLYgQERQsrXX43RbYJ8totqNi36ujNN26VYJ+7gCUmmrR961/oHknpdrCIlkj37IRe5jR7gQsHrEoY8pdvRMlnfl7PFkXqHnWpX3P/LN6pIvSs3B2DIjq1Ht/AVYcwhc45j8IJIqCUB7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CAd2uApf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD82CC4CECF;
	Tue, 12 Nov 2024 02:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731379218;
	bh=W4/sdurYMk6ijto4wRNLBNq/bTT/o7RXoziTz5dLhtY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CAd2uApfXdllcbZ62zl35FW0MuMP/nChBzxm+IsvEAWW2qRqsxcq3FmOpDp44ug6N
	 BDNujW0anT2k6nQJckxBmjWmvgMNZYmXpE9MMYpFShL0BX0dGHUnGNYA1QnNojgPiD
	 c4i8uvQTBmMGgFK/TT07Ns/X16S7ENXiHOg3/dvmsEfBqh4nkzwBbC5f5hL7KbzN6t
	 mIkgJmCKhVclwigRyjXXNHaruMYZuV2kY43L0mOmwDA/eqwz6ncgaY1WsAOWN6ABA5
	 kf/yY+c/beqGR72s/zGprrx07djPMypIjqboWko8a2Isofl0nUjnYT0CZcKuoDxgNQ
	 heTrC53FCOfQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B7A3809A80;
	Tue, 12 Nov 2024 02:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 1/2] net: fix SO_DEVMEM_DONTNEED looping too long
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173137922901.57225.8157709932343230683.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 02:40:29 +0000
References: <20241107210331.3044434-1-almasrymina@google.com>
In-Reply-To: <20241107210331.3044434-1-almasrymina@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, edumazet@google.com,
 willemb@google.com, davem@davemloft.net, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com, horms@kernel.org,
 corbet@lwn.net, yi1.lai@linux.intel.com, sdf@fomichev.me

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Nov 2024 21:03:30 +0000 you wrote:
> Exit early if we're freeing more than 1024 frags, to prevent
> looping too long.
> 
> Also minor code cleanups:
> - Flip checks to reduce indentation.
> - Use sizeof(*tokens) everywhere for consistentcy.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/2] net: fix SO_DEVMEM_DONTNEED looping too long
    https://git.kernel.org/netdev/net/c/f2685c00c322
  - [net,v2,2/2] net: clarify SO_DEVMEM_DONTNEED behavior in documentation
    https://git.kernel.org/netdev/net/c/102d1404c385

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



