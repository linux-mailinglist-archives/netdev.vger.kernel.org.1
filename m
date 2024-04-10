Return-Path: <netdev+bounces-86486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40AEF89EF32
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 11:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02FB1F21A49
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 09:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6142156C77;
	Wed, 10 Apr 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n1xPPM9A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04DD156976
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742628; cv=none; b=Q39Ny/H5M1g8lyDePv1G8VWCqKxf+VtvMUq+qsaORLVyNy7epIX/Ko+0G223xEndFI7xSjpyPE0F78XylPtBE+5bwBB417D2Tih3mGZYeiYXHV7XgCbcyin5wKur2qC3XMuHkGmpyGQUoaBoXAHStega/jnLHAMGncCCbU7qQgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742628; c=relaxed/simple;
	bh=YDnrSmiElwvSdoASS7BbBJGUrtvl4j9PjEpY/jxaMjw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RQeh3Q6Fg25LWJ0yz43KmTa2CaGImIqMJSk/4aPEMJKyz91WYZtqrIoRrw9p+Eq1QHNsYy00iUDNoScCk5V0AXo9kaZ27WBLSWIXflduWJc3h5Mcv7vRpGGLoiPcjwcqVAQIl4JsQ4ZKIAnTtr7nsgMS8x9gslZOGK+fmDItx3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n1xPPM9A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47313C43394;
	Wed, 10 Apr 2024 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712742628;
	bh=YDnrSmiElwvSdoASS7BbBJGUrtvl4j9PjEpY/jxaMjw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=n1xPPM9AbocwzbBI/dzyadkUQxKA6nv8ir9ftCD6AZyESPZL4kmmreR7eXLHinrRJ
	 inUmuuIUosNXtQvV2+a9irzkGwQJ2Cnqo2I17rN8SUUVKMi7vGZLc1g/TPwRm2wREx
	 yK+5QyYI8HT6QiUDDUQ8OEOe1tcIVkSWi6XOd5VJEJ992YZNTjb/43HgSJsQ/ejW5Q
	 uH4zS3qVmgpFx4a0dW9xqDsx+SuM81FTM0UDB00YwAUvLb9S0cjw0bTJZwA3pv4zu0
	 pZAspcJ2uio3C5246/4frWLfk91Q2NviG1fKWw86lM/BNNDOJYpVb+Ps3JfnulXf0R
	 4afbM4bmo83Zw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3DE22D60310;
	Wed, 10 Apr 2024 09:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] r8169: fix LED-related deadlock on module removal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171274262824.13361.13300515768136013023.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 09:50:28 +0000
References: <2695e9db-a5a0-4564-9812-a50b91fb1b46@gmail.com>
In-Reply-To: <2695e9db-a5a0-4564-9812-a50b91fb1b46@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: edumazet@google.com, pabeni@redhat.com, kuba@kernel.org,
 davem@davemloft.net, nic_swsd@realtek.com, lukas@wunner.de,
 netdev@vger.kernel.org, andrew@lunn.ch

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 8 Apr 2024 20:47:40 +0200 you wrote:
> Binding devm_led_classdev_register() to the netdev is problematic
> because on module removal we get a RTNL-related deadlock. Fix this
> by avoiding the device-managed LED functions.
> 
> Note: We can safely call led_classdev_unregister() for a LED even
> if registering it failed, because led_classdev_unregister() detects
> this and is a no-op in this case.
> 
> [...]

Here is the summary with links:
  - [v2,net] r8169: fix LED-related deadlock on module removal
    https://git.kernel.org/netdev/net/c/19fa4f2a85d7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



