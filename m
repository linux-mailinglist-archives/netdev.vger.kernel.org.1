Return-Path: <netdev+bounces-144681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4669C81A9
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 05:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D70D91F23F13
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 04:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 662AD1EBA19;
	Thu, 14 Nov 2024 04:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i9+DW6WR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 255511EBA11
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 04:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731556820; cv=none; b=HYep2yi9sSIlHUaMmfmejxr+F/qfkFmPSZKqGF2ORnxDQZuXykEBByuQ/UAdvLURWOc8+cJ7GIs3O4m4Wp36OGUq9LW0DNDWma9NMAbQpzsSQHUPJt1NDoA2gOGYkhMyKLx6ie77b55FUPOenD245gH5gloBsP0oz0hRBLWPJBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731556820; c=relaxed/simple;
	bh=jGwZPKaocPgmlhwUnYSs8zJK9VIwEBJselPmRLFLh9M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FRa46MUa0BTndMOq9MEBDVLG1kZEyYdly4AHaTtZymi+XkxK/G34N1522y0Swnf4X8IYMb8OQhFlJTomjUjU1E6UIRDsbWHZvys4eis3xs6GuVeU84zjEtUQhtP4it81Zf5aFhj/A/avrxX8gd6tZqHLQwRuBfGsNaVjXxrq40Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i9+DW6WR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D09C4CED4;
	Thu, 14 Nov 2024 04:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731556820;
	bh=jGwZPKaocPgmlhwUnYSs8zJK9VIwEBJselPmRLFLh9M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i9+DW6WR1IAJkO/DrIM50XTegeeauT4vpIAevTqw/Oi/lwQffwVY+1s+BtvWL6OcK
	 0iwwX2uvYDkGHb7JdU+hRg6EuSgRF+V3y2i680MQWwVE5cxzaBac3dhmyS32P0wmK6
	 TvcLSgWpg17EgH9Hb6AUz6JlxSKAADgqlZNmGLqJvTiRmBjPfk7i8qBmYdZl1LcJpC
	 NCMlTqSV9mYcBTPYl5T07OWxN4uU7/PpiNkuquzJL7mcNNhy94JVdhVmTSTbEq2JFU
	 f4zFQt8eb6VNk/ZsY8JNB2a/iWhfTs2Xsozef0Zjw2Sx0JAtO9b9QhcCuV1uyHM9jW
	 3Rq79Z99nKG+A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD8C3809A80;
	Thu, 14 Nov 2024 04:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: Make copy_safe_from_sockptr() match documentation
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173155683024.1476954.4874522617358555171.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 04:00:30 +0000
References: <20241111-sockptr-copy-ret-fix-v1-1-a520083a93fb@rbox.co>
In-Reply-To: <20241111-sockptr-copy-ret-fix-v1-1-a520083a93fb@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 11 Nov 2024 00:17:34 +0100 you wrote:
> copy_safe_from_sockptr()
>   return copy_from_sockptr()
>     return copy_from_sockptr_offset()
>       return copy_from_user()
> 
> copy_from_user() does not return an error on fault. Instead, it returns a
> number of bytes that were not copied. Have it handled.
> 
> [...]

Here is the summary with links:
  - [net] net: Make copy_safe_from_sockptr() match documentation
    https://git.kernel.org/netdev/net/c/eb94b7bb1010

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



