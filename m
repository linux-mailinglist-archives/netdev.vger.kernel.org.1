Return-Path: <netdev+bounces-146092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 964769D1EE6
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 04:40:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4008DB214F7
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35486146D65;
	Tue, 19 Nov 2024 03:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FySXWtQp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C11A2CAB;
	Tue, 19 Nov 2024 03:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731987621; cv=none; b=tk1Or9Jned52k5YugLaoIzPeF+I5j0klZ616H/3wnTFyH4c9nG/XAGjEMu3UM/mLbcdcCeG5NPe7akqFSjAkdQA5Jv1fJjl5sznSu0UhHBLAXnzKfZk9nfOxL5aOceQrsLOrl5xHl1+VFZ8EUkuws43qqAcxuFadpCjvD4pbN0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731987621; c=relaxed/simple;
	bh=OEFb97np7hNKq0LOocbLK5JMn71iIx0bCehdMjZatf8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=T1NnJJFHT0JfEI9PjsIcH2NEk322IZJjdgwQnI8NSRMShpTrQfu/0cQu+5cXv/9looOiWaD4XCjFpdfNwOO152MyZsRm+4K9Iw9YmAH8Rg9+4h/TFmmOptl7s7allF8dEM7ZnbDWDFYx/SLdVLzTSMsrCF2FNdm2TUeT04VCtag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FySXWtQp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87533C4CECF;
	Tue, 19 Nov 2024 03:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731987619;
	bh=OEFb97np7hNKq0LOocbLK5JMn71iIx0bCehdMjZatf8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FySXWtQp6SiYNierl/oP+VqxsgWY0aOtaR9o7Jg+LQOjnH2hQyXu/f9TkRSMFrqNy
	 p53P07eGZxLsGKdYnVATAfx/ngfFbIQV7a4MYqGwh8PWg6xjXCC4S1a/jvBNHUHvWs
	 n+plb1sxXmLPQKtawTevd9J1e2Jk+1bO1Tz3XNjA6Ri8SSvY9XQ+f1Tg3q1YXobFru
	 nRsUnmBFo+NbCsEKSsaKjqmdT3rAv6SjkFBlT2PhQcgHqeqF4B8FXW115IEjggPU6R
	 +7keqy28XiSeT9qHJvR8seSq0U3ZXojiR5LVCCYha0FoDINolkmHY1K4I03Xg2h6ov
	 98X/YDgm2T5fQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 341DE3809A80;
	Tue, 19 Nov 2024 03:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] netpoll: Use RCU primitives for npinfo pointer
 access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173198763100.93658.15150293129668090015.git-patchwork-notify@kernel.org>
Date: Tue, 19 Nov 2024 03:40:31 +0000
References: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
In-Reply-To: <20241118-netpoll_rcu-v1-0-a1888dcb4a02@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, herbert@gondor.apana.org.au,
 stephen@networkplumber.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, paulmck@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Nov 2024 03:15:16 -0800 you wrote:
> The net_device->npinfo pointer is marked with __rcu, indicating it requires
> proper RCU access primitives:
> 
>   struct net_device {
> 	...
> 	struct netpoll_info __rcu *npinfo;
> 	...
>   };
> 
> [...]

Here is the summary with links:
  - [net,1/2] netpoll: Use rcu_access_pointer() in __netpoll_setup
    https://git.kernel.org/netdev/net/c/c69c5e10adb9
  - [net,2/2] netpoll: Use rcu_access_pointer() in netpoll_poll_lock
    https://git.kernel.org/netdev/net/c/a57d5a72f8de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



