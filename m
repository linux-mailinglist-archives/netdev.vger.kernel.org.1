Return-Path: <netdev+bounces-202547-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA89AEE410
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583B31700DC
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87F21291C2D;
	Mon, 30 Jun 2025 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGb3MrIZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62048291C13
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299792; cv=none; b=nWUs0QaA1ffnpKLhtwe57c+MuVmEXvB5pbwbyLkeGMFJrFHnE9cr7AZzIb4BrCcCf2vz5FsHC+XjIQkq/NGT/Zk/gjQupRnEyP/XRsDwPI6akmnCQsHJnMTtpEowS3k4sc4w+v7NInXsucVySBPcOSj8gUleRyzMNehihjcVwtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299792; c=relaxed/simple;
	bh=pc4FZR4pMcpVb/oJYYvDD+Pfg2QUYLjVbcD+Lg6nGDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lYiDj0IoiP2SGSvDArPwd4zh8gMrb9mkYemEL6oe5/oOp5Xh72OgIh+7aX0DKX0cYBiRRf8lmhg8YLoK9fG31gjpz6mn61ZEva3lx2kBw5WxudhQ6Vinzz/a/ErDl8KfViLz8QdK4B4MdZwaepG2Dp7+Xv86yhoB7h7XEk0iFxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGb3MrIZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5D20C4CEE3;
	Mon, 30 Jun 2025 16:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751299791;
	bh=pc4FZR4pMcpVb/oJYYvDD+Pfg2QUYLjVbcD+Lg6nGDc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QGb3MrIZumSWhPlXD33dI/2L88GpfFHYMdbol+YA6TabBvf6uslpIpRNHxVLuIj/W
	 VeQMkWBxCHxa7gvBx8K4d3zCJZLmO+y19o7poz4XYNf3QdLs6fgEVtXGgBWVnv6KQB
	 Eoa5L3jcfHSaCczvS6xrwOsnQsrQQQz/XqbRwtnReVVQm0KyBuqCEF7eBnseUvvgVn
	 659WRPIR4z5MOkKPLedhkKhhUHAmUccELo98XoxMSaudcX0CAsTWIaCYMNFxdc2+hb
	 rXppeA3cyUqkokGItgC8c1fLam/sbPHnG1+VuHtm4bdvEpPjDPxsDncboytR6m9h1z
	 o9im1lF/KefDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DC5383BA00;
	Mon, 30 Jun 2025 16:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/3] net: ethtool: consistently take rss_lock for
 all
 rxfh ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175129981674.3437924.14438964185215804029.git-patchwork-notify@kernel.org>
Date: Mon, 30 Jun 2025 16:10:16 +0000
References: <20250626202848.104457-1-kuba@kernel.org>
In-Reply-To: <20250626202848.104457-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ecree.xilinx@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Jun 2025 13:28:45 -0700 you wrote:
> I'd like to bring RXFH and RXFHINDIR ioctls under a single set of
> Netlink ops. It appears that while core takes the ethtool->rss_lock
> around some of the RXFHINDIR ops, drivers (sfc) take it internally
> for the RXFH.
> 
> Consistently take the lock around all ops and accesses to the XArray
> within the core. This should hopefully make the rss_lock a lot less
> confusing.
> 
> [...]

Here is the summary with links:
  - [net-next,1/3] net: ethtool: take rss_lock for all rxfh changes
    https://git.kernel.org/netdev/net-next/c/5ec353dbff4f
  - [net-next,2/3] net: ethtool: move rxfh_fields callbacks under the rss_lock
    https://git.kernel.org/netdev/net-next/c/739d18cce105
  - [net-next,3/3] net: ethtool: move get_rxfh callback under the rss_lock
    https://git.kernel.org/netdev/net-next/c/040cef30b5e6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



