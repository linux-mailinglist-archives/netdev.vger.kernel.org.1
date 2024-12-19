Return-Path: <netdev+bounces-153321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 210CD9F79FC
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 12:00:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1B316B829
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 11:00:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7F25223E99;
	Thu, 19 Dec 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z35wsy0B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93950223E88
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 11:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734606014; cv=none; b=ZbMzxTjPQBewcDeRCxNLlU/p+P+OwA8Kj3ti+JgXMvgBQZKBipFrkll4AtfRSFQcdBI+YULRsZHR/jaX5tl/qgiGcSt/J7ZIgDQ1inJ8EdHY2vi5JkXwsqUK8c4Su9NQ1BdJseWdQ5HO2hkvwGuGo2gM3qPmPzmdu2otchtdKwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734606014; c=relaxed/simple;
	bh=QsbpBM2rtbYlWBsgiYHVjF2kEa8O+BytHvOt7OzjH34=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PNZwca9ahaI5UQlJR1HXelsbOzcrbGUbBihyReQq/KqFgLLytGbdsWFZcLHceBl7Ygp1VfQQkcqcw/Qx62VGVByOT1oE5vdJ0yofXK6LXdNEdb/sCHn6gf+N7cf8kxwARvIPRqbdkFtHS3f3sqcn4Djmbc3AVJxTpjM85+c6J2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z35wsy0B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29BCDC4CECE;
	Thu, 19 Dec 2024 11:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734606014;
	bh=QsbpBM2rtbYlWBsgiYHVjF2kEa8O+BytHvOt7OzjH34=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Z35wsy0BMXBRZkn2rX6a7INP6JZi959+5M80I8BZgYUgYXIktTduTYvI02pJQzr1G
	 H5FI6/1qhMyIfj3goZN/rm5V5MkE5tBKzX20oAfBrRHK4Nvfs8TMcIHRe3uZExetc8
	 6P4bJxhbD6C6F+/NoxNC4XD8x+ikiOyn7RPFhjwJSnOu4orfV1m1zYNevCyg6r6/Mt
	 XLvxsv4+j+DGKx4iARNpw47nutTcmcgtLogIi0bRdvngMeA1czKW9tTs1KR7iG/EJ/
	 6vnFuUw4cwstMiCovU2h3q6brF6/sazkNvHBqRUu+Gx1fMLoGCNfneZp3CBbvmumSU
	 PW2NseZXeGViQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE033806656;
	Thu, 19 Dec 2024 11:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4] net: mdiobus: fix an OF node reference leak
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173460603149.2216621.5598290342169480270.git-patchwork-notify@kernel.org>
Date: Thu, 19 Dec 2024 11:00:31 +0000
References: <20241218035106.1436405-1-joe@pf.is.s.u-tokyo.ac.jp>
In-Reply-To: <20241218035106.1436405-1-joe@pf.is.s.u-tokyo.ac.jp>
To: Joe Hattori <joe@pf.is.s.u-tokyo.ac.jp>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 18 Dec 2024 12:51:06 +0900 you wrote:
> fwnode_find_mii_timestamper() calls of_parse_phandle_with_fixed_args()
> but does not decrement the refcount of the obtained OF node. Add an
> of_node_put() call before returning from the function.
> 
> This bug was detected by an experimental static analysis tool that I am
> developing.
> 
> [...]

Here is the summary with links:
  - [v4] net: mdiobus: fix an OF node reference leak
    https://git.kernel.org/netdev/net/c/572af9f28466

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



