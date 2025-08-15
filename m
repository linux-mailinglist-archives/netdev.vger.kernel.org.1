Return-Path: <netdev+bounces-214176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F26A1B286B0
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 21:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B403DB6633F
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 19:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B876E2C21D7;
	Fri, 15 Aug 2025 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ng2wUKvI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 911462C1798;
	Fri, 15 Aug 2025 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755287407; cv=none; b=Xp3er1W73oz02E6R9i1fOZvhHceFN4sjj8Jd7tJkuWImQ7Hp21WN1wgYbGOapvzHEXBIkbm7VmyWcELIXnmijXWnZc4OgCZ/snChilnTxi72YnO7AzIgZVKqoPry5FYfLPP98iVLA/eWEvbldLHTTAjAJfNQwjCRqlOc0OB4E+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755287407; c=relaxed/simple;
	bh=ad2i4iurqGuCF+I3o7cRV8IpdB69BXentAymQHoUIOY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=P4WhQRwM3u3shxS3oi+Ap/bTJypIlAF50ZIoTE/o7dFfi/H5deV5V3pf4ZFO8x3hX8YJAW89P3dKWpE2uy+e4uJv8YD8J/B5THtIfFInl8w9uC7kdmOqtGfJi+Li0+O3nSbGg1VcvvFjIiwI7cAOSebUqc3Pk29pZ7GooOg+0AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ng2wUKvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F74C4CEF1;
	Fri, 15 Aug 2025 19:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755287407;
	bh=ad2i4iurqGuCF+I3o7cRV8IpdB69BXentAymQHoUIOY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ng2wUKvIL+HuBeKqztsX/as6ihcv05EUSkv+oqobFzjUcOgaGvYUlNE495/tKcaUe
	 azF/TtoV0twiJtdcqwcpf3+0RjuLtuPhd+MLLbQzD6n5XWqvVUUtQO36IXb4V6a1BI
	 R8tAszM8x59bwu3HHnqifDyOq+Jgpc+atXFvgb/kCh4pSXS7pcL7503vNtTdLpiNCf
	 qY6xIycUNKH+PdzDrHZMDB+DD9F6WKHlY6nMhpbNnSIp1Bpp0PlLKWMljAXqvigUjl
	 bJdEN9csWMY6gGOTo6HxU9r3hs0p9ZeC0iTqVrWVrNcNx7Z45GVfLW29iJZeQxkmi+
	 xjWFHw2CdJwSw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE02D39D0C3D;
	Fri, 15 Aug 2025 19:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Space: Replace memset(0) + strscpy() with
 strscpy_pad()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175528741824.1253623.4919609679119905065.git-patchwork-notify@kernel.org>
Date: Fri, 15 Aug 2025 19:50:18 +0000
References: <20250814180514.251000-2-thorsten.blum@linux.dev>
In-Reply-To: <20250814180514.251000-2-thorsten.blum@linux.dev>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Aug 2025 20:05:14 +0200 you wrote:
> Replace memset(0) followed by strscpy() with strscpy_pad() to improve
> netdev_boot_setup_add(). This avoids zeroing the memory before copying
> the string and ensures the destination buffer is only written to once,
> simplifying the code and improving efficiency.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> 
> [...]

Here is the summary with links:
  - [net-next] net: Space: Replace memset(0) + strscpy() with strscpy_pad()
    https://git.kernel.org/netdev/net-next/c/815957293639

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



