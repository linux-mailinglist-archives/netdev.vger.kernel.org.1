Return-Path: <netdev+bounces-125718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D178496E5A8
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 00:10:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 905A22857FF
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 22:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256881B2EFA;
	Thu,  5 Sep 2024 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MxuI5SET"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F731B2EE4
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 22:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725574235; cv=none; b=uUVVZ/wfBXaCcxFeBlUGS1ctRyIRO3o1a0l+uOGp/X9ImdaFAxZh0NjBUwCXf6eQ4TloqQzW/gB30GAzly5bMRPP1ahQqYCVc3d4FICngXVDafN08s5HNi5y0PKxFIl2dBNGXk5I87Y7deoUy9yifjVRNz13mFee7syLz+ZOhmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725574235; c=relaxed/simple;
	bh=SUL0Gc98YzDgdteoW0NN7GjaxZBFIxQANo+ds9lA3kQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NWVH8hrQb44hJ8kol5JE82CPHe28REvNZaUY0ccCCTwpn4qUHX6ukoZCAUPL+Skke7tiqUDjFg3JUynyIp3mfkYEWeexZIfu36Mhvt/R1pUPW4fKvQlJ5gGY6ic3d02D66aXFHk/yfW1VsrrXsKhYUP57vfbs1FeER2SsagtUL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MxuI5SET; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2C04C4CECA;
	Thu,  5 Sep 2024 22:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725574234;
	bh=SUL0Gc98YzDgdteoW0NN7GjaxZBFIxQANo+ds9lA3kQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MxuI5SETTZMy7AYYYJ8E+qiFzoP87hSPgLb0J23wNhLoiOcuIVF4S5/eJ0LfM9TM5
	 lrv/o01xhqyc4FOUht7GdPZSHe1mwFMu0oISWA8G6yx/YkzRbQS9zeiFSwvUtjNwjR
	 2Tvrinst+lP1If26H8bCr3G62JZVhoMOnboLwZMw0kk+rq5EGlcP+3umRDi5zftEvf
	 SHv8oCJl/SGjR+a4FL0WUezOs+Iqkrf0RMArHTrrRtK/oJEn6nWrIj59HNDxS1TDb9
	 lE3OB992IZIUsDBlrtN+luTn6LCBuHSIZtUsiFbrOVxxh60WJAafoh4iBwaB36BG4x
	 Y2DjYvxnh9+cg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EACA53806654;
	Thu,  5 Sep 2024 22:10:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ila: call nf_unregister_net_hooks() sooner
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172557423565.1859883.14249460392371074106.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 22:10:35 +0000
References: <20240904144418.1162839-1-edumazet@google.com>
In-Reply-To: <20240904144418.1162839-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, syzkaller@googlegroups.com,
 tom@herbertland.com, fw@strlen.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Sep 2024 14:44:18 +0000 you wrote:
> syzbot found an use-after-free Read in ila_nf_input [1]
> 
> Issue here is that ila_xlat_exit_net() frees the rhashtable,
> then call nf_unregister_net_hooks().
> 
> It should be done in the reverse way, with a synchronize_rcu().
> 
> [...]

Here is the summary with links:
  - [net] ila: call nf_unregister_net_hooks() sooner
    https://git.kernel.org/netdev/net/c/031ae72825ce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



