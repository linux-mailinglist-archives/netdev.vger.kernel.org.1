Return-Path: <netdev+bounces-248194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AF5FBD05505
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 19:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DA7DC3027A5C
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 17:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E58F91EBFE0;
	Thu,  8 Jan 2026 17:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MM+kDKFE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C9D39FCE
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767892411; cv=none; b=V3vuprhVVQy8BkWVf3T2EyJ7sUWBdlRY4dWCJ9bzvfTWxYzR7zmxS5GwY26MB9qFzugcem3KLdkZ6jDe9u9i08NmP+gIXN7xtXN0HjPPmTWW/Z/1enOuNwGmy27qGB26m840exWo3kzxZLhd5sa0TqQ9P8AQvozbdQPG+uJKxl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767892411; c=relaxed/simple;
	bh=l697RBEdSZV/w0td/5h210bNy1V3TxHKTXFpSbNjmqc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GnPB1lLKtYn3L444vOutoXnEm2Blp7Ds3t9npX8uU4EmObK8fxda23mGI+DiGbGM8AwzbaoVhvgEqbChQFSypGbF8EnGcl1akSK3ZJxfW/IcV91HrdM0xfmguDQPEVg3OJh5PNJs5Bv85jVyDcRfi1D9zuK4y3u7RnvFNuOhVTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MM+kDKFE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C13E4C116C6;
	Thu,  8 Jan 2026 17:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767892409;
	bh=l697RBEdSZV/w0td/5h210bNy1V3TxHKTXFpSbNjmqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MM+kDKFEmrm+m8ttxFRgJAPwzzLxaMxRScYZSiJ/CMpDSnhzD4XSivz0A3HD0Zx8R
	 wGdso1Ld/mmg7Yt7NmCwzyCMfABemaHD6rh5epoLmfm+41iJjw0mHouaP5/b5b+I3o
	 FY5s7Q1HaKY7nj1xMJJGYaKVNOn4yYhTZ4Z6EmaZW7mmwCWuwdk3wXdm38Z7J3D+AU
	 r9DDt3WK5MxT8vdKvrWaj+HXsq4IUiFPUpBZJLTHWE02fqI7aExtm1BHjDiIezaku5
	 U39W+uHp791oziJJ4IeFf8KNCbfIxTA1jw87LZOQEwJIVGRfLxLaracM5gfaG6YnQ1
	 5y7EhMw9ZtmQg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7A9F63AA940D;
	Thu,  8 Jan 2026 17:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] arp: do not assume dev_hard_header() does not change
 skb->head
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176789220629.3725372.8467809928340237942.git-patchwork-notify@kernel.org>
Date: Thu, 08 Jan 2026 17:10:06 +0000
References: <20260107212250.384552-1-edumazet@google.com>
In-Reply-To: <20260107212250.384552-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+58b44a770a1585795351@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  7 Jan 2026 21:22:50 +0000 you wrote:
> arp_create() is the only dev_hard_header() caller
> making assumption about skb->head being unchanged.
> 
> A recent commit broke this assumption.
> 
> Initialize @arp pointer after dev_hard_header() call.
> 
> [...]

Here is the summary with links:
  - [net] arp: do not assume dev_hard_header() does not change skb->head
    https://git.kernel.org/netdev/net/c/c92510f5e3f8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



