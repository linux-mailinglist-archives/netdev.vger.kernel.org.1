Return-Path: <netdev+bounces-154100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 502189FB418
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB85A7A0297
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F08C1C5F25;
	Mon, 23 Dec 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iEdMXmpR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371871C07F1
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734979234; cv=none; b=KRVWTQZt3hBapMmhcq1zxelgtbhQDzGBH9zxK58JGQG19ooC04OqpNrA7LBLCXH2UedkMMhkKZ5m2j9fKRLGCADed7MbGHdYUgV74GBiNwCvzNEJRFkvpBS7c/oSKhuBphl8nbeFCRzLF7xWAcRcwU2xYpbKtxuwCrbWPsU4/Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734979234; c=relaxed/simple;
	bh=kJlnRTZRD68XQh0/p4FiKS/nLhHKE/wcfEiETtKn/mM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MqPdE5RtMKpulZXDW7n2kh7I62rtAsUWMuD7yZwss8Vv62HntKdhGMePmvyO8v3KVqlNF87hVMyESCAxEl4ltwg26iC2TvFoZtJaBJ0Ns2X2d8SBBKrndVN84c/czLvEp4wuuFLSuk/N7bLn9wpbpyzD/972nyNSo8DlGpqS2+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iEdMXmpR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCCA4C4CEE6;
	Mon, 23 Dec 2024 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734979233;
	bh=kJlnRTZRD68XQh0/p4FiKS/nLhHKE/wcfEiETtKn/mM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iEdMXmpRYV/FGHhMBjt0fDu8zUj2Z5Af926Pbd4tJUafq4vUns4Sq48PykDDCDuv8
	 LI4/cskCG88vc5n3GZH7nO53BnyDmA21GgZVrvQwU+/uyiX33sOyZ9jH2pPz71sshQ
	 pCWnZzy7cNhFyOrY2O5L6iojrfPSPiQsBwzYwvmnscByrpZIHo52VL+/iZdU99o1+S
	 NqWpP216JJ7QlXroiZZJgbPKLs6akfTeyfRFiwMVh7MGr1eO/tJ7krvg5wQgDBwMbQ
	 8eZMt68/SXnSryPBppTDg63EDYBoeUv83hmTGEVqqTsT2zfIun0wjONjyV0Lob1VyM
	 fEMQ2BInmGfWA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 710923805DB2;
	Mon, 23 Dec 2024 18:40:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next,
 v2] netlink: correct nlmsg size for multicast notifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173497925226.3927205.12338609140853122005.git-patchwork-notify@kernel.org>
Date: Mon, 23 Dec 2024 18:40:52 +0000
References: <20241221100007.1910089-1-yuyanghuang@google.com>
In-Reply-To: <20241221100007.1910089-1-yuyanghuang@google.com>
To: Yuyang Huang <yuyanghuang@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, dsahern@kernel.org,
 roopa@cumulusnetworks.com, jiri@resnulli.us, stephen@networkplumber.org,
 jimictw@google.com, prohr@google.com, liuhangbin@gmail.com,
 nicolas.dichtel@6wind.com, andrew@lunn.ch, pruddy@vyatta.att-mail.com,
 netdev@vger.kernel.org, maze@google.com, lorenzo@google.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 21 Dec 2024 19:00:07 +0900 you wrote:
> Corrected the netlink message size calculation for multicast group
> join/leave notifications. The previous calculation did not account for
> the inclusion of both IPv4/IPv6 addresses and ifa_cacheinfo in the
> payload. This fix ensures that the allocated message size is
> sufficient to hold all necessary information.
> 
> This patch also includes the following improvements:
> * Uses GFP_KERNEL instead of GFP_ATOMIC when holding the RTNL mutex.
> * Uses nla_total_size(sizeof(struct in6_addr)) instead of
>   nla_total_size(16).
> * Removes unnecessary EXPORT_SYMBOL().
> 
> [...]

Here is the summary with links:
  - [net-next,v2] netlink: correct nlmsg size for multicast notifications
    https://git.kernel.org/netdev/net-next/c/aa4ad7c3f283

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



