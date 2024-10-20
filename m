Return-Path: <netdev+bounces-137298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 711569A54F6
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 18:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B87EB223A5
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 16:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E792194ACA;
	Sun, 20 Oct 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axIGcRv3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751F0194A74
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 16:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729440628; cv=none; b=tsd3k9rfgDQSFY3TGoJ4KtHNjlERqlnDKagCQTAeNUyyCxar8u/1Bm/qkdq2HkXZ6ckvNmugCXgsSV4TV8k82G+ohrK9Z/YRZpOnniYGYtCYnvEMsV97xcG/o+95DzyacKlAliy+zYvO2vI1tc79L9gMw3E4v7ezwjCLThIJNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729440628; c=relaxed/simple;
	bh=LLHPSKzXJe6bXGsjFy0tBFRBcq/hsaunIx8Na1a0HfQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QFfsYpaHFfjI58vy9tBPRPGX57yJtCx8Zcaj1w+QfaYuUsGWdFpHLnSeQj7OQ71pwp559LFkSW4qtjNVcVS3P+hrbch85lf07jcSkMuP7pemiArOSM5SyWMZhU0fZcTDbvSRPuDsq6/8nqcm2cUYboW5gR5Hin8qym1/dRrvMIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axIGcRv3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16192C4CEC7;
	Sun, 20 Oct 2024 16:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729440628;
	bh=LLHPSKzXJe6bXGsjFy0tBFRBcq/hsaunIx8Na1a0HfQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=axIGcRv3a8z9SbOjE9ShifzsX1sQ23MZ+wBuv+AHPozMHzvNusBZWJr8PZcqmzdAp
	 219IsgvTXw7Wp5X5gZCKdKPOadlpULVXD6GnSgFAL+BGj3iKfq/WP4JMisF70ynZ5X
	 Ckrvomkps3nHdVFrGv7OGF0kk7ni2/a8hxC7pIGvWeB8jxVzRDcnwmyeOPgBozVgYj
	 LHiXD4HxSU/VORZdxISdyBvLab0+VFvZxC2Qf14YATM36G8KaaYugN0AQCkpK906Zc
	 av3QncZEkFwjt7KrsKF4ZdZh6NAsyToFn28A5dIs28QW3n5EkzdvaQImcAvy44oWNE
	 fRMztUaEraYCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B033805CC0;
	Sun, 20 Oct 2024 16:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] r8169: replace custom flag with disable_work()
 et al
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172944063373.3604255.14408906732157386454.git-patchwork-notify@kernel.org>
Date: Sun, 20 Oct 2024 16:10:33 +0000
References: <358ef0cd-2191-4793-9604-0e180a19f272@gmail.com>
In-Reply-To: <358ef0cd-2191-4793-9604-0e180a19f272@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, edumazet@google.com, netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Andrew Lunn <andrew@lunn.ch>:

On Wed, 16 Oct 2024 22:04:44 +0200 you wrote:
> This series removes RTNL lock from rtl_task(), what is a requirement
> for patch 2, where instead of a custom flag we use disable_work() et al
> to define when work is allowed to be scheduled.
> 
> Heiner Kallweit (2):
>   r8169: don't take RTNL lock in rtl_task()
>   r8169: replace custom flag with disable_work() et al
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] r8169: don't take RTNL lock in rtl_task()
    https://git.kernel.org/netdev/net-next/c/ac48430368c1
  - [net-next,2/2] r8169: replace custom flag with disable_work() et al
    https://git.kernel.org/netdev/net-next/c/e2015942e90a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



