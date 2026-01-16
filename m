Return-Path: <netdev+bounces-250424-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2918CD2B083
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 04:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CEBE8308E985
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 03:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBD4D342534;
	Fri, 16 Jan 2026 03:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sX+CVuSa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67182857FC;
	Fri, 16 Jan 2026 03:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768535630; cv=none; b=dvG4KM76nAqbK4Pe2MREf1uFtkRPpWd7wnle3id+ZgW00AFMH+dBAS96y8PlEOXAKPewOdIVABT0Ni1k7FRx1JVpoJGkt0kGNp+L2gzKaf7mQjaaol8p5xKjkQpuSLQNFpqMADUZFZRmhuuN2Uy1lZem8Dyng8ZR2jxn4hTxR8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768535630; c=relaxed/simple;
	bh=n9HfYfDKSIL1G1wKC7BWOhpGCpE/VtqAkip4v0R/drc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WVORdpnLi6WNkvqv633yxsiAY6/l+OraP9Ss1SJowesbNWH0/rzfQdvpeaFkiuLXcHSUYKRNGjV27d8sq/UDIM0GxabPD4I+OPt2ey8xZG/Xd+OLVQ51cmY8naM1DcOQyVUCOe0Bthco1tx/I6UuZ+JxQbLfXmS55MgqnDovOJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sX+CVuSa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 550B4C16AAE;
	Fri, 16 Jan 2026 03:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768535626;
	bh=n9HfYfDKSIL1G1wKC7BWOhpGCpE/VtqAkip4v0R/drc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sX+CVuSa06qONu6y1krcT3EZEH9s9b6kHdH6fLbJZcZUF6e5BPT8jOic5lcN6Yu2j
	 hG9c3DEjSTTsicuRO4LGkXL3I7O5REBs1bmKcvmMLYiJ5LnAPLGA70EcZ/P6MnubKG
	 01rjCPhS6u150qkT3r3b70cXynxx87cBjr2bkt0CH9prsauJT5AlwfPB9GBTW/J3y5
	 SBRySamJXxNxyM6c3r5cNzYvY6KHHr15XPAmCCmMb95y1UtVJzoSvLsJXP3m0CuR3d
	 wfdvADfIIzInMbNG+nOa/6p2dUhMctHBlkwTF+pdCPsLW23Jo/feqLvev5vyEPxfWR
	 71rqiZg8+IckA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 78969380AA4C;
	Fri, 16 Jan 2026 03:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] usbnet: fix crash due to missing BQL accounting after
 resume
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176853541802.73880.8707530298339054626.git-patchwork-notify@kernel.org>
Date: Fri, 16 Jan 2026 03:50:18 +0000
References: <20260113075139.6735-1-simon.schippers@tu-dortmund.de>
In-Reply-To: <20260113075139.6735-1-simon.schippers@tu-dortmund.de>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: oneukum@suse.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, dnlplm@gmail.com,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, yung-chuan.liao@linux.intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 13 Jan 2026 08:51:38 +0100 you wrote:
> In commit 7ff14c52049e ("usbnet: Add support for Byte Queue Limits
> (BQL)"), it was missed that usbnet_resume() may enqueue SKBs using
> __skb_queue_tail() without reporting them to BQL. As a result, the next
> call to netdev_completed_queue() triggers a BUG_ON() in dql_completed(),
> since the SKBs queued during resume were never accounted for.
> 
> This patch fixes the issue by adding a corresponding netdev_sent_queue()
> call in usbnet_resume() when SKBs are queued after suspend. Because
> dev->txq.lock is held at this point, no concurrent calls to
> netdev_sent_queue() from usbnet_start_xmit() can occur.
> 
> [...]

Here is the summary with links:
  - [net] usbnet: fix crash due to missing BQL accounting after resume
    https://git.kernel.org/netdev/net/c/c4efd7a770c5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



