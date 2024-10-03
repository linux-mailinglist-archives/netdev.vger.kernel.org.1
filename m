Return-Path: <netdev+bounces-131511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 024C698EB78
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 10:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFAED288326
	for <lists+netdev@lfdr.de>; Thu,  3 Oct 2024 08:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 867821487D5;
	Thu,  3 Oct 2024 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oU9NPam8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BCC145A1C;
	Thu,  3 Oct 2024 08:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727943627; cv=none; b=Q1/QkGCm4MK5bkGbuzWqho+LoLuMOa9f/iPRSoKauTr+KADgBmW6Gt7Lwi4sOYKAutcRyfq2NuXx/AUkTsR4WETZRUAMsUM/j8Fy0nIIVDARAOZogcfbPOOh/4op9pSf37V+3uScxK3iKckO//k6FsU29xjoXIXL1zkFC+Us7fA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727943627; c=relaxed/simple;
	bh=ua5+prbncqjBsBlr7ebTNI1hu9HbTi1T7/7egQUKUoc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G4NJIv3fUheAyFmLTr4dNZBaiq8zb9vLlGWH1tZp6aS9c1AT7JgjApy5g9hmwbi5ra1l+q9olNppBUARS/39mWkBxWY7DrEB4vJnSTPwT5CHIjs1S5X+ngTnKjGKRHWImlFghzqKdjLsDJjX+JH3ResmPJ9qgj1XFnWNx4MNmgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oU9NPam8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE226C4CECC;
	Thu,  3 Oct 2024 08:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727943626;
	bh=ua5+prbncqjBsBlr7ebTNI1hu9HbTi1T7/7egQUKUoc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oU9NPam83sg1f0oXQaxW3VfJ9poS9f5P/9rRT3V2lKYb3YPGSoiTt4EgkUyuYBJaT
	 xO9kCDWW+2onaCs2cA7ciq/qnuq24rD32TvnafUtC4Sk8ZeSExiNa3MuD2Ra6Q9O8s
	 +L4CWzWsS6pK997u3xdy0IUyJYq9Dsvha9MtClpu9sotgOCI9us3HJGNto30EsADDC
	 R/bn/WQoSZMWc9a0NqwA7clWlOixSE0/EbajixygqXBSqi8Wru87TGN5ITJATqD0jz
	 iP8TWlN3U27YLk4dzWhcn87FwX+INgJIq9Ex26/0fmllaFBn35rzHy6GG/LSPV6npO
	 PqcX/kvgFK7tQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 72E07380DBCA;
	Thu,  3 Oct 2024 08:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net/ncsi: Disable the ncsi work before freeing the
 associated structure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172794363029.1778782.7004564502718970835.git-patchwork-notify@kernel.org>
Date: Thu, 03 Oct 2024 08:20:30 +0000
References: <20240925155523.1017097-1-eajames@linux.ibm.com>
In-Reply-To: <20240925155523.1017097-1-eajames@linux.ibm.com>
To: Eddie James <eajames@linux.ibm.com>
Cc: sam@mendozajonas.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, gwshan@linux.vnet.ibm.com,
 joel@jms.id.au, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 25 Sep 2024 10:55:23 -0500 you wrote:
> The work function can run after the ncsi device is freed, resulting
> in use-after-free bugs or kernel panic.
> 
> Fixes: 2d283bdd079c ("net/ncsi: Resource management")
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
> Changes since v1:
>  - Use disable_work_sync instead of cancel_work_sync
> 
> [...]

Here is the summary with links:
  - [v2] net/ncsi: Disable the ncsi work before freeing the associated structure
    https://git.kernel.org/netdev/net/c/a0ffa68c70b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



