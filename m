Return-Path: <netdev+bounces-101370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D9B658FE4E8
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 13:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CEA2872E1
	for <lists+netdev@lfdr.de>; Thu,  6 Jun 2024 11:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DDD4195387;
	Thu,  6 Jun 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h3TURBjD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BAC17E443
	for <netdev@vger.kernel.org>; Thu,  6 Jun 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717672233; cv=none; b=bskQh8IUqhOJTc4O1nD0ucPH2TG4UDgKkdMxGdcFM3K9t7SEMQRrwpJY22qrBtpo7IamwN7bdm/+aeLC1kbKRhw9rLpGtg1vz499XuY5oAbY0zR3f0+EWJ9GEi7yMk/PcLi1/pcfCxYS3h+8xV19vVBiZDgz8wyDWGin1h/Gyx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717672233; c=relaxed/simple;
	bh=+CoipO2dUcbMipv0/BnjaPSkbMcV6Sq+V++Wo+2NuMQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fAno/sK1l1lXnp6pm7O803ADL0y1xwcveVsvS93RvIP5SsmCvzjZ6VOP1rjzrbSb5tMi0gAVUnujCkI/1uH0cE704sHpVLeWqF27RTTUG6atfHdzdEP6OR+bgME2EttfwCXsfVHQKcArZJFPfCqfJuhwO2pD7ineUqUSZeXgA6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h3TURBjD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DDA52C4AF08;
	Thu,  6 Jun 2024 11:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717672232;
	bh=+CoipO2dUcbMipv0/BnjaPSkbMcV6Sq+V++Wo+2NuMQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h3TURBjDtBDZVOLnYl48/9AJyMCu3ttNXDT5FH/8igZvnU7badVy2skGaHkk7MWra
	 UY9R6c6HFv+ag1bozN9lnV+ufmNVVrGbpz+zp0pfGIt6rIHuNz/8/yWmEjrx6TV3vg
	 pDQ4zuVaGWhNatJgOspMwAgHVep3HbA1rktzE++yC+ngtorlA/xxl+0j5Wsmjw/Auk
	 6K33dFQ/A89RJ/kF97hDv7TDB3KpWqCE5qX/7HDWcOfkpsFGa71CIbYLqxjUH9/l5E
	 i6eHmw8MXL3RoRb3beLMcuoSdHA7Q1b9OhxRc/hpQQ/Wpvmk1emGM5Nj46ra2yqagr
	 WKt1HJK1SB4/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C5F56D20380;
	Thu,  6 Jun 2024 11:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: fix possible race in __fib6_drop_pcpu_from()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171767223280.26965.5049199339143094356.git-patchwork-notify@kernel.org>
Date: Thu, 06 Jun 2024 11:10:32 +0000
References: <20240604193549.981839-1-edumazet@google.com>
In-Reply-To: <20240604193549.981839-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com,
 kafai@fb.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  4 Jun 2024 19:35:49 +0000 you wrote:
> syzbot found a race in __fib6_drop_pcpu_from() [1]
> 
> If compiler reads more than once (*ppcpu_rt),
> second read could read NULL, if another cpu clears
> the value in rt6_get_pcpu_route().
> 
> Add a READ_ONCE() to prevent this race.
> 
> [...]

Here is the summary with links:
  - [net] ipv6: fix possible race in __fib6_drop_pcpu_from()
    https://git.kernel.org/netdev/net/c/b01e1c030770

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



