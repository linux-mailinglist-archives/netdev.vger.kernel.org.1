Return-Path: <netdev+bounces-56655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A48A80FC02
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 01:10:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9E61282317
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 00:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624F8656;
	Wed, 13 Dec 2023 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGpnE5Cz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4721338A
	for <netdev@vger.kernel.org>; Wed, 13 Dec 2023 00:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id BDBF8C433C9;
	Wed, 13 Dec 2023 00:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702426224;
	bh=3HQCyzp/ISRXDxpD+F0b8ckLt+/aQz4QN+hbwfbEpuw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PGpnE5CzHtwd3Js90wLuHCkUTQtIF1SwC4e181vTzlSyhAq/oKXiJC++ZL2wjnecN
	 a9r2n2vsXe75wsk9ZDIERJYSFTp3jaBOgSecuUpbmnJPKxYCaDTWrghBVOSsuVRVbW
	 fkfksR4VmN++zYGcJJ1RGQj5lmpTYs5hlcHfMVb7sMdF1c08e0693BqEtBtBY3gtOX
	 kQOLCXtQZCPbsuk2Q23XofLrAlg2cwYs/nxFoK0Rk0Wg53/ndbcKbiTUUgTjqCxpiK
	 xo435znwkWFIPUvRJuYJwrF8TYaDTeD8e+646l7laQbkCW7xz+kxcIRWoQEqVygeLf
	 EfEIXcHGlPq3A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A41EDDD4F01;
	Wed, 13 Dec 2023 00:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: Remove acked SYN flag from packet in the transmit
 queue correctly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170242622466.31821.12456336467310002508.git-patchwork-notify@kernel.org>
Date: Wed, 13 Dec 2023 00:10:24 +0000
References: <20231210020200.1539875-1-dongchenchen2@huawei.com>
In-Reply-To: <20231210020200.1539875-1-dongchenchen2@huawei.com>
To: Dong Chenchen <dongchenchen2@huawei.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, ncardwell@google.com,
 yuehaibing@huawei.com, weiyongjun1@huawei.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 10 Dec 2023 10:02:00 +0800 you wrote:
> syzkaller report:
> 
>  kernel BUG at net/core/skbuff.c:3452!
>  invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
>  CPU: 0 PID: 0 Comm: swapper/0 Not tainted 6.7.0-rc4-00009-gbee0e7762ad2-dirty #135
>  RIP: 0010:skb_copy_and_csum_bits (net/core/skbuff.c:3452)
>  Call Trace:
>  icmp_glue_bits (net/ipv4/icmp.c:357)
>  __ip_append_data.isra.0 (net/ipv4/ip_output.c:1165)
>  ip_append_data (net/ipv4/ip_output.c:1362 net/ipv4/ip_output.c:1341)
>  icmp_push_reply (net/ipv4/icmp.c:370)
>  __icmp_send (./include/net/route.h:252 net/ipv4/icmp.c:772)
>  ip_fragment.constprop.0 (./include/linux/skbuff.h:1234 net/ipv4/ip_output.c:592 net/ipv4/ip_output.c:577)
>  __ip_finish_output (net/ipv4/ip_output.c:311 net/ipv4/ip_output.c:295)
>  ip_output (net/ipv4/ip_output.c:427)
>  __ip_queue_xmit (net/ipv4/ip_output.c:535)
>  __tcp_transmit_skb (net/ipv4/tcp_output.c:1462)
>  __tcp_retransmit_skb (net/ipv4/tcp_output.c:3387)
>  tcp_retransmit_skb (net/ipv4/tcp_output.c:3404)
>  tcp_retransmit_timer (net/ipv4/tcp_timer.c:604)
>  tcp_write_timer (./include/linux/spinlock.h:391 net/ipv4/tcp_timer.c:716)
> 
> [...]

Here is the summary with links:
  - [net] net: Remove acked SYN flag from packet in the transmit queue correctly
    https://git.kernel.org/netdev/net/c/f99cd56230f5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



