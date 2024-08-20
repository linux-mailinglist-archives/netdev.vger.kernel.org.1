Return-Path: <netdev+bounces-120352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38F9795907B
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 00:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B0FD1C20F5E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 22:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A325B15FA75;
	Tue, 20 Aug 2024 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGlCPsuE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760CE3A8D2;
	Tue, 20 Aug 2024 22:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724193030; cv=none; b=CwY22HmSP0eeVtgu21oF5YCz17sSckii1O9ZLsOXm3PBHdW9ubarmE453W/iv79frVhs4qsdyNpIwNz0ZWdiaE2cmQXSex4nuC6zOe/15LmIoN1b7WiFr87+K8RrXpumR7AEWHRU6pkJkau9/UB1fmyr8lqALE/7+UGRvXhSlrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724193030; c=relaxed/simple;
	bh=QIvy4TO9GSD5doYUaryT1LCKdL1T8Hc0PAdoyn5yFrc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y1SSdeuKcWKMnkh9IhzgBjiMjnHihtIXV1T/xCOOxaA9aslQuwyqjbbT36OnJ1UgDhyhpdt+C0dDhhjDun2OqJ/M41WP6omqlgwbrO2Kk5OTAz1EbdmC4B+f0pXxoHzWeXirHbKYAIzTCwchvfRYewrTf04QimVR1nvUviBYqHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGlCPsuE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB510C4AF0B;
	Tue, 20 Aug 2024 22:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724193029;
	bh=QIvy4TO9GSD5doYUaryT1LCKdL1T8Hc0PAdoyn5yFrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UGlCPsuEk3q1g7Z/NPG0kgWw6vFChi2HcUSKu4hBcV5gYOaAvfAZBNhp6BvaeltpN
	 Ie768J42dqWFdE2b1J80g5SSKUxEYKoP1g8DdmcYdpNpohgGFjobaW1PDip7YOFSZQ
	 RBlLl/7Wt8BQCHauK7HlIC7kaHTm9ete55GmGB+1P+A4PD/OIFtpFQWxzaCNM6h95b
	 fUtEJIpgsC+Mi6UJEN6WrUBBuAUqV2ZMblTzoPa7mc9mcdLepTg0YqDkTT0Meyv+cR
	 yOoCcUW5CwAN9I7184i+GPQHZpS2xTtUVoN+QMWnVof3kHA8Cyic0uyAk1TFDqDFHV
	 oeOTr9LUOEugQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342A53804CAE;
	Tue, 20 Aug 2024 22:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] dpaa2-switch: Fix error checking in
 dpaa2_switch_seed_bp()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172419302902.1256151.15717439778691554579.git-patchwork-notify@kernel.org>
Date: Tue, 20 Aug 2024 22:30:29 +0000
References: <eec27f30-b43f-42b6-b8ee-04a6f83423b6@stanley.mountain>
In-Reply-To: <eec27f30-b43f-42b6-b8ee-04a6f83423b6@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: ioana.ciornei@nxp.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 17 Aug 2024 09:52:46 +0300 you wrote:
> The dpaa2_switch_add_bufs() function returns the number of bufs that it
> was able to add.  It returns BUFS_PER_CMD (7) for complete success or a
> smaller number if there are not enough pages available.  However, the
> error checking is looking at the total number of bufs instead of the
> number which were added on this iteration.  Thus the error checking
> only works correctly for the first iteration through the loop and
> subsequent iterations are always counted as a success.
> 
> [...]

Here is the summary with links:
  - [net] dpaa2-switch: Fix error checking in dpaa2_switch_seed_bp()
    https://git.kernel.org/netdev/net/c/c50e7475961c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



