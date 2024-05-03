Return-Path: <netdev+bounces-93394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B76E08BB7F2
	for <lists+netdev@lfdr.de>; Sat,  4 May 2024 01:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5EFDB20CA6
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 23:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB55682492;
	Fri,  3 May 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kV/db/XG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6AAD2D05E
	for <netdev@vger.kernel.org>; Fri,  3 May 2024 23:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714777829; cv=none; b=gcx5KUgzIT59z5vG0zMH2C2Re/+qaRi4shtxuJ1WjFzlX0Ia3Sb8pL9zFbyteWG9P+Hg3OIUm73EW7rvN2D75BYhltWIjrEP3ZlAx6BhShZUBRkMgkPXAmSHr2I6NRwHMDj9vvwktzINxAFCj58ZNKNzYK6q/YsitySWCW2Vnwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714777829; c=relaxed/simple;
	bh=1Oy8SnQLHCrrGdoYy3MgeSpzQvAg7dy7nOh7fWQDRNY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oiWaAbqpOeXNhIwlQq3X0koZRspYoFgTwsMOClkDzWkUt5ZICYYW4FhugrwvQXlmLKI0WgZu8TgXx1jk0T1KZ1YCDKs6mfkcFSRoYya7+HXhHWrUTt2bulfyLzl5XEMXWlYSos8VXDjoQ84XBjwDuGWD8XZH6XftYAEsyc199t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kV/db/XG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7711DC4AF14;
	Fri,  3 May 2024 23:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714777829;
	bh=1Oy8SnQLHCrrGdoYy3MgeSpzQvAg7dy7nOh7fWQDRNY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kV/db/XGjs4AFiiOjleE3luAsnYw0HD7w5yMiVegmEG6tu+ofoKch/sJsLDdLLB0n
	 1tDWC0UBn0brygQQpVqyKFd/yqDIW27PrsbaUCvj5Xn60vYQWOHevQ2GqULCrAYp51
	 pT3mQ8NAoS2xpfwuNqDknywOLZuzA5xjgHAbDQvmBAByTpHXLBB+aRgHRjZ3hDovNV
	 M09YxevOj50VvM0kt+Vxi36AVnOKReHbBlKiV0WxlJYue4Q5ga2GdPPLhX6OBuVTqH
	 qdPYdWBUFE5P8UKsP4UaPijBAEha1UFFx/2bIs8JPW3zwv5fEmyyAT1DMsVnDmP3GX
	 jNrrW6HR5ghLA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6753BC433A2;
	Fri,  3 May 2024 23:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/3] xfrm: fix possible derferencing in error path
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171477782942.11856.15047078135224405347.git-patchwork-notify@kernel.org>
Date: Fri, 03 May 2024 23:10:29 +0000
References: <20240502084838.2269355-2-steffen.klassert@secunet.com>
In-Reply-To: <20240502084838.2269355-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Thu, 2 May 2024 10:48:36 +0200 you wrote:
> From: Antony Antony <antony.antony@secunet.com>
> 
> Fix derferencing pointer when xfrm_policy_lookup_bytype returns an
>  error.
> 
> Fixes: 63b21caba17e ("xfrm: introduce forwarding of ICMP Error messages")
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Closes: https://lore.kernel.org/kernel-janitors/f6ef0d0d-96de-4e01-9dc3-c1b3a6338653@moroto.mountain/
> Signed-off-by: Antony Antony <antony.antony@secunet.com>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> [...]

Here is the summary with links:
  - [1/3] xfrm: fix possible derferencing in error path
    https://git.kernel.org/netdev/net/c/8b06a24bb625
  - [2/3] xfrm: Preserve vlan tags for transport mode software GRO
    https://git.kernel.org/netdev/net/c/58fbfecab965
  - [3/3] xfrm: Correct spelling mistake in xfrm.h comment
    https://git.kernel.org/netdev/net/c/b6d2e438e16c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



