Return-Path: <netdev+bounces-87817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6168A4B78
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 11:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0588F1F222D8
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 09:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5BF43FBA5;
	Mon, 15 Apr 2024 09:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a5j0Uoo5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A13FB9F
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713173432; cv=none; b=jyDOJ8jR7HOffKVErdKz89OitvMjNXkjO1aIgT3zuXNl3ULaQ8zs8tpPHwHqASZRyOUQbPG1CIxBov2fGj4Yq3EwDESp8oGOYwITXIPmtbbpdez2MpVkrfrgF19sP+i2K5a2C6v6yKRxXPgNM4aUYos2etiOM1uJxXByjR7YN4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713173432; c=relaxed/simple;
	bh=PzpGqe/QvKIrK3j+BqQeuvOavz/Ww1AXC/6TlRQ102g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DX5iDlB7RkvEErrQjsAtroXUEB+iyL6v/XGMywWeKgnHreiGd4E7D4eq71GiTcHnPh8h3JDjNMY3djfuRsEXMoJtrJA8+JInQmxO44GUlQRXljAXa+cYAwp0RFP61vT216bt5f5nDIXQCt0f2JSs8IE8+gWaLQWKuciqMy2WaTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a5j0Uoo5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 14B5BC32786;
	Mon, 15 Apr 2024 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713173431;
	bh=PzpGqe/QvKIrK3j+BqQeuvOavz/Ww1AXC/6TlRQ102g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a5j0Uoo5qGKq45oCkIj6G/UsFS9bH4zVo258pLyjnyC3zU7xF8GKdP5Kx7A5jH2vQ
	 RMbaMO+TkzWx18hrqYoe0dTn9LBcsipH4zxpBEPpZ4tUanX4lhN1t0XNFSeh52+8h2
	 SyQPa0h2LKiPBRBT9NMsdVVIXKTlXIg+5zqYlr7eUgiAVUabwUbVmtWHpjvnGBC55e
	 gWImeIUxxH5hfkH+nMHUOwdqRI55FDOG/TbHBw8GScrQTKMvJX1VaNXEy75qkI7stm
	 EiPe4QNXKNYxFez4swFNi2CzRU3oGUjgQ7mycFc0uiRNSsl8hrjkpijLE169mc+nKL
	 6XAC/9us8r86g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 06A2AC54BB1;
	Mon, 15 Apr 2024 09:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] inet: bring NLM_DONE out to a separate recv() again
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171317343002.4489.4564794308932455506.git-patchwork-notify@kernel.org>
Date: Mon, 15 Apr 2024 09:30:30 +0000
References: <20240411180202.399246-1-kuba@kernel.org>
In-Reply-To: <20240411180202.399246-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, sbrivio@redhat.com, i.maximets@ovn.org,
 dsahern@kernel.org, donald.hunter@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 11 Apr 2024 11:02:02 -0700 you wrote:
> Commit under Fixes optimized the number of recv() calls
> needed during RTM_GETROUTE dumps, but we got multiple
> reports of applications hanging on recv() calls.
> Applications expect that a route dump will be terminated
> with a recv() reading an individual NLM_DONE message.
> 
> Coalescing NLM_DONE is perfectly legal in netlink,
> but even tho reporters fixed the code in respective
> projects, chances are it will take time for those
> applications to get updated. So revert to old behavior
> (for now)?
> 
> [...]

Here is the summary with links:
  - [net] inet: bring NLM_DONE out to a separate recv() again
    https://git.kernel.org/netdev/net/c/460b0d33cf10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



