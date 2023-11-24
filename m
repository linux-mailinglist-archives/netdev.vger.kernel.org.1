Return-Path: <netdev+bounces-50894-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6F3E7F77D2
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 16:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 12FFE1C20AC2
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 15:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC0B2E844;
	Fri, 24 Nov 2023 15:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxISh+zE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4B286B9
	for <netdev@vger.kernel.org>; Fri, 24 Nov 2023 15:30:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7688CC433C9;
	Fri, 24 Nov 2023 15:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700839825;
	bh=cbwdVHA3tce48hmvMtRfKMfWKvBD9tBz0MPlGE286kw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bxISh+zEClsH27eBg+n5GulkLu/2KNI+SjQzMKfOIv4tiQ1dZytuMxmZ+6RYLG6F8
	 xZAY4mEHC65BKxsr/Rvoehxwj3xRJdd07GteOecnqp9df6pjdeuNbuLlCwoCxAjxSP
	 F4p+WDT2YYE1nTK2Fpdo38kDSfNkeV4db9vXTWOULEXN4Sto39LbN0ZTtXys0tHKEM
	 7D+jFA3aLL3U+N1rjClyAON54NbjfpdJNW6CMq3s5HjytBFOO2tSQ8SYjMQmeepE/d
	 ECkty3Hq3x7J8te5Gf/ubugZLk/kFAxLFhkqaIVuCkkinhlSMTCAhNM+y0FkrUvKGP
	 Q2UtBrlUoXopw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63754C395FD;
	Fri, 24 Nov 2023 15:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net,v3] ipv4: igmp: fix refcnt uaf issue when receiving igmp
 query packet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170083982540.9628.4546899811301303734.git-patchwork-notify@kernel.org>
Date: Fri, 24 Nov 2023 15:30:25 +0000
References: <20231123071314.3332069-1-shaozhengchao@huawei.com>
In-Reply-To: <20231123071314.3332069-1-shaozhengchao@huawei.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 weiyongjun1@huawei.com, yuehaibing@huawei.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 23 Nov 2023 15:13:14 +0800 you wrote:
> When I perform the following test operations:
> 1.ip link add br0 type bridge
> 2.brctl addif br0 eth0
> 3.ip addr add 239.0.0.1/32 dev eth0
> 4.ip addr add 239.0.0.1/32 dev br0
> 5.ip addr add 224.0.0.1/32 dev br0
> 6.while ((1))
>     do
>         ifconfig br0 up
>         ifconfig br0 down
>     done
> 7.send IGMPv2 query packets to port eth0 continuously. For example,
> ./mausezahn ethX -c 0 "01 00 5e 00 00 01 00 72 19 88 aa 02 08 00 45 00 00
> 1c 00 01 00 00 01 02 0e 7f c0 a8 0a b7 e0 00 00 01 11 64 ee 9b 00 00 00 00"
> 
> [...]

Here is the summary with links:
  - [net,v3] ipv4: igmp: fix refcnt uaf issue when receiving igmp query packet
    https://git.kernel.org/netdev/net/c/e2b706c69190

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



