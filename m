Return-Path: <netdev+bounces-17844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9787A753352
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 09:41:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D18B71C2157D
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FFDF7499;
	Fri, 14 Jul 2023 07:40:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 940B7746C
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 07:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 06CF1C433C7;
	Fri, 14 Jul 2023 07:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689320421;
	bh=zViWJNTHWrbHBwfi3RX0ddnfAUS+Uix1W7WMqjrfPZI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Zxkkrfx91nWV0zJDFJPtFB66J8uVx4ne1J8fFt7JkP5LUoRY0seLieteKaWvvvUIm
	 e6ZoC7HGsAB4dauV/Vyh0nBdBN+v9UHvz1tr2q80KqKRlvzEIq5VAOnE7j0Brg2PP3
	 sKzouVKV/wxOFbY7M0juMLrUm9CFcOAFlaLZGML5ZZAtRys4c2hevR7FhJRXQKIJp5
	 2fMfoLPyn1t3p9xK5vssUloheu568tyFCT7mSoSlOzuk3hKJ/uQXvzz1mCoLAjoeL0
	 S6AiN9YmS1xBtmZ95/1X2lZcxgs/CIy0BpCi4hysHMOrzEV8ZzysZp2+atbAuJBscv
	 E5ojiqmw+5KTA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D11B6E1B4D6;
	Fri, 14 Jul 2023 07:40:20 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] bridge: Add extack warning when enabling STP in netns.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <168932042084.7517.1979590687068900394.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jul 2023 07:40:20 +0000
References: <20230712154449.6093-1-kuniyu@amazon.com>
In-Reply-To: <20230712154449.6093-1-kuniyu@amazon.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ebiederm@xmission.com, kuni1840@gmail.com, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org, hcoin@quietfountain.com, idosch@idosch.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 12 Jul 2023 08:44:49 -0700 you wrote:
> When we create an L2 loop on a bridge in netns, we will see packets storm
> even if STP is enabled.
> 
>   # unshare -n
>   # ip link add br0 type bridge
>   # ip link add veth0 type veth peer name veth1
>   # ip link set veth0 master br0 up
>   # ip link set veth1 master br0 up
>   # ip link set br0 type bridge stp_state 1
>   # ip link set br0 up
>   # sleep 30
>   # ip -s link show br0
>   2: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>       link/ether b6:61:98:1c:1c:b5 brd ff:ff:ff:ff:ff:ff
>       RX: bytes  packets  errors  dropped missed  mcast
>       956553768  12861249 0       0       0       12861249  <-. Keep
>       TX: bytes  packets  errors  dropped carrier collsns     |  increasing
>       1027834    11951    0       0       0       0         <-'   rapidly
> 
> [...]

Here is the summary with links:
  - [v2,net] bridge: Add extack warning when enabling STP in netns.
    https://git.kernel.org/netdev/net/c/56a16035bb6e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



