Return-Path: <netdev+bounces-154879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8E1A002E5
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 03:51:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2020D3A3C7F
	for <lists+netdev@lfdr.de>; Fri,  3 Jan 2025 02:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A3E2629C;
	Fri,  3 Jan 2025 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="frhSPyy/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF23BA47
	for <netdev@vger.kernel.org>; Fri,  3 Jan 2025 02:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735872621; cv=none; b=Cu5T7xwz/lDj/LMTMpC62BAu6WQdaeaLFaS0hnYGKgZWKVj17Hz/8XUTgWziCkNrm07wgtACgUItCFnV58oLsu6buoN/g2EOAMigKZpPM1JEmlCljErUIajLhOssoS9Fr91ZQlcBTG+/JcEbxZvh0RrRfE5xLRBH3KyJRGpEfXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735872621; c=relaxed/simple;
	bh=7qacAX/HQshVOabmiJ3eb5Xg/3kuVxm06jkO0y/U+m8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MhawEJir1yEL4cfxV6Nfjp1akXl6rUtB+6SOcgkAXhANqLJ8q5SqHqbud8NfCIEU6rbJBYUMezU5QK3GGD4yLwAAXW+auIgOzVZAVMXn4LeJ2hfpaGpWHw9yROSDmL2pyxH3BRBwGszBDpxGmdwvVQtpiul+HfQ9THxSlAysOT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=frhSPyy/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45928C4CED0;
	Fri,  3 Jan 2025 02:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735872621;
	bh=7qacAX/HQshVOabmiJ3eb5Xg/3kuVxm06jkO0y/U+m8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=frhSPyy/QGSIjfnRs8z4LGLWW8VOokgIZarUaBehddy1/E1LqUTCK4+Cxh5EnfTmu
	 giO//230my/smvoWHgquFnUrBa4wVHEr40Mjxp9sfZinWf1fiW5LDSti5m7DeqhV82
	 nWdbfwP+LGqbrlSnuRRBLz3gsXV78ZA909pP45ul2JgUNLYi4I9dnGu0TtBx8f9RgT
	 pasMl3gz36HlhIjrBtZ//JykHGw5q4RykkNOCtvr58VfMdxnBg+2UbWsQODlo+kXuf
	 znHpbGOnvrOV87T1vGaFMs+ayZU+6M2uymiRz5AU1WlSh+kT91EYhGA1CwUjh2bMCd
	 eLZ2urfLGNkxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC85380A964;
	Fri,  3 Jan 2025 02:50:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] af_packet: fix vlan_get_protocol_dgram() vs MSG_PEEK
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173587264160.2091902.7013337958906729988.git-patchwork-notify@kernel.org>
Date: Fri, 03 Jan 2025 02:50:41 +0000
References: <20241230161004.2681892-2-edumazet@google.com>
In-Reply-To: <20241230161004.2681892-2-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, horms@kernel.org, willemb@google.com,
 eric.dumazet@gmail.com,
 syzbot+74f70bb1cb968bf09e4f@syzkaller.appspotmail.com,
 chengen.du@canonical.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Dec 2024 16:10:04 +0000 you wrote:
> Blamed commit forgot MSG_PEEK case, allowing a crash [1] as found
> by syzbot.
> 
> Rework vlan_get_protocol_dgram() to not touch skb at all,
> so that it can be used from many cpus on the same skb.
> 
> Add a const qualifier to skb argument.
> 
> [...]

Here is the summary with links:
  - [net] af_packet: fix vlan_get_protocol_dgram() vs MSG_PEEK
    https://git.kernel.org/netdev/net/c/f91a5b808938

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



