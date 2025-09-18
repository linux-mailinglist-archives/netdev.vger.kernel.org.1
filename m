Return-Path: <netdev+bounces-224402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6EEB8452D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 13:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461963A332D
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FD62FB603;
	Thu, 18 Sep 2025 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cJxSA9r+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 441042DA757
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 11:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758194408; cv=none; b=BdYDuN9/wSkDA92NgZ054Mx9maxHsdFlymkBe2qBHsuci474lSLqcB5gBcCFUwJbgvZZJxLHWVNRAdSiOmxmH1Orolnwp/OJpoflzEjw0sqZ+ZM1CJP6Otlmc4fjwrOEWBC5nqWqouxZDKDlCajf+jKKYBmMPh1Lniug693b3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758194408; c=relaxed/simple;
	bh=wL+c4hrXvKLYqnXA2CsotcCJ42ZVwc/7GfNrJ0b8Wc4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=f4MZjYFjWQlD4zGLxg5IVGZRYuilzp5dNsokiHol+lF4mpT+EqiYU9iBmXkxrUAPpAwOuVVloRLwBHY/jI8znBbRVvLyLlGIapZ/pnJttfe1c9OvpE7aVoRJJPccwPWr+gWpKw3V8yEgI8r5Hw3YZ/F5igh8qwcGbGNhrk6sbRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cJxSA9r+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1534C4CEE7;
	Thu, 18 Sep 2025 11:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758194407;
	bh=wL+c4hrXvKLYqnXA2CsotcCJ42ZVwc/7GfNrJ0b8Wc4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cJxSA9r++P9nadjI5FuFjxQR0pSbKaR8b1RfN+swfWqpyJFmC1Cfcvmj5nMqQd+Ud
	 1Ur2cuVRKuxvZiqT3l3ABMuoFTjF9wJxmlFU/Zg/Jk51Ji/j809Mb1rC/uGrV0zu97
	 MSuPIhB0WP8EKdqSIld6alLoy1tb7VYomwen1nFanY7qJuKkk4AIUgMMay9xdjMJle
	 CUWI1Qiwp2WGPhj5XJBw/OwjjYiRZDheErylqok5o+6dVq/5d/vK3k40p00HFzAw8z
	 jJtKi386NOf2S4RyFo3bEIqouud48Zmg/LnYucN7Bk2XLrYi0uNvPJniiCL3jKpvsq
	 eDviGOjtyBWpg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DDD39D0C28;
	Thu, 18 Sep 2025 11:20:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] tls: make sure to abort the stream if headers are
 bogus
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175819440801.2374281.1523877619241690586.git-patchwork-notify@kernel.org>
Date: Thu, 18 Sep 2025 11:20:08 +0000
References: <20250917002814.1743558-1-kuba@kernel.org>
In-Reply-To: <20250917002814.1743558-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, lee@kernel.org,
 sd@queasysnail.net

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 16 Sep 2025 17:28:13 -0700 you wrote:
> Normally we wait for the socket to buffer up the whole record
> before we service it. If the socket has a tiny buffer, however,
> we read out the data sooner, to prevent connection stalls.
> Make sure that we abort the connection when we find out late
> that the record is actually invalid. Retrying the parsing is
> fine in itself but since we copy some more data each time
> before we parse we can overflow the allocated skb space.
> 
> [...]

Here is the summary with links:
  - [net,1/2] tls: make sure to abort the stream if headers are bogus
    https://git.kernel.org/netdev/net/c/0aeb54ac4cd5
  - [net,2/2] selftests: tls: test skb copy under mem pressure and OOB
    https://git.kernel.org/netdev/net/c/4c05c7ed880f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



