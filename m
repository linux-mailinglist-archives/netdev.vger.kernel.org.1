Return-Path: <netdev+bounces-135798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E121D99F3B8
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914CE1F23C17
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A0B1F9EA8;
	Tue, 15 Oct 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="agQXY3yB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F591F8F17;
	Tue, 15 Oct 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012226; cv=none; b=oFMeswViohkmGPp8pW3dkXmd+GyznabrFsZ/G9HhadWJJSsqg2xvQxVN8yBbeOz2CmZa2JHeCZRAc+94OxGHwM/h4auwLlSEbaCT7nZVPF1EglyCVXoktOkhZQULNl3uq27YhVeYfYnL0YK114KESOI5cfvq3x5coNxsStXBBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012226; c=relaxed/simple;
	bh=SeocKlWpY9uJKoRjT7puY8a93bGWzTdbQ1UEs7shokY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VFku1tOARwbnwVUkDPG8Qej1H1g1ZBLJLggJ42yjAoVRfZ9slBjYWTcEHnik8WvTidWokRkt7wZDs1OzFlUS17SRxS08V3naP0oU+8OXI2tgEssK073hb6xFRwc6WoBEa5MX+hpLDkD73s7qiadaWOnhIn0YcvJ78KYJWWdc3q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=agQXY3yB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85932C4CEC6;
	Tue, 15 Oct 2024 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729012226;
	bh=SeocKlWpY9uJKoRjT7puY8a93bGWzTdbQ1UEs7shokY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=agQXY3yBM3ocbFS7wOBlyYnRe60ctpgexxuHNA1QArqGwUFQ4xc6VFZsejBNxuwKd
	 61PTTp1BxW44kljp931K5BAk911hZwv0VACsFXmSQgmWubNRSBy1ZAWKDA6HsKKUMJ
	 bQIddrqX3t4g5jWFE2gB7EvWI1IhXzxPbFV3x4uaa54vYi1P1vna9H31ukaWjOuBtR
	 dTx6T1BoIZO/uH+eBX/gqNjZVImmkwtAlOc3WCs3Z4PJa7t07Ui5celsM8PZXUs8rX
	 HwIB29qAefAk0cwjEfPAMazz1lz9ucoh/b3Zru1qmxNTpWZuP1HcWJJ0g/1Ztme/h2
	 H4Q5IMx0regLA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB5EF3809A8A;
	Tue, 15 Oct 2024 17:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] net: ethernet: aeroflex: fix potential memory leak in
 greth_start_xmit_gbit()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901223148.1230547.8385233189191215729.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 17:10:31 +0000
References: <20241012110434.49265-1-wanghai38@huawei.com>
In-Reply-To: <20241012110434.49265-1-wanghai38@huawei.com>
To: Wang Hai <wanghai38@huawei.com>
Cc: andreas@gaisler.com, gerhard@engleder-embedded.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 zhangxiaoxu5@huawei.com, kristoffer@gaisler.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 12 Oct 2024 19:04:34 +0800 you wrote:
> The greth_start_xmit_gbit() returns NETDEV_TX_OK without freeing skb
> in case of skb->len being too long, add dev_kfree_skb() to fix it.
> 
> Fixes: d4c41139df6e ("net: Add Aeroflex Gaisler 10/100/1G Ethernet MAC driver")
> Signed-off-by: Wang Hai <wanghai38@huawei.com>
> ---
> v1->v2: Using dev_kfree_skb() in error handling.
>  drivers/net/ethernet/aeroflex/greth.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [v2,net] net: ethernet: aeroflex: fix potential memory leak in greth_start_xmit_gbit()
    https://git.kernel.org/netdev/net/c/cf57b5d7a2aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



