Return-Path: <netdev+bounces-237416-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D0BAC4B2CF
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 03:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DAE218818F7
	for <lists+netdev@lfdr.de>; Tue, 11 Nov 2025 02:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F39346A0C;
	Tue, 11 Nov 2025 02:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5ZIcIsy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4CE346FB0
	for <netdev@vger.kernel.org>; Tue, 11 Nov 2025 02:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827046; cv=none; b=jrsCZuwOGvdB7C1I1JRddIJfLb1+DQ4lN0o8IBQsSjGAO9aBP/kTRLyYPxZW4rWUt26e5fU8Ym40QdZLVpZpFf+A23l9061Hj18AybVAkZK6nNxXkyNoAcaOs2uOr7XvgQ7fYSxd7Eb5dDR7az60UFahHvpnBbJLnPJeEwUy8+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827046; c=relaxed/simple;
	bh=U3Ja5ES1D5EBP9e+28kMHLJhR0ZR4ly9zioTm7hHRLQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jKqbwc84bf7Dvbo6woHn8BCg2lLY1VHNdSYmIpvaIgQnOx+UZrUVoOuXSXrQXqGVIp1q4HnYP5G8A7jQL1EugGO6+XogqfN/bdUHMZoy0oiUGArH+/FfV2iv7jnATYhoaVJrlCCX43WqrrD8RqXvNHj9F9Tln6NFGJuMGPSj30k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5ZIcIsy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8919EC19425;
	Tue, 11 Nov 2025 02:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762827046;
	bh=U3Ja5ES1D5EBP9e+28kMHLJhR0ZR4ly9zioTm7hHRLQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=b5ZIcIsyaz55ZK0tkI38uqxiYuZ6DxNtPYsA6bjCT2dPQNIALmvHBS3piN44UctwU
	 pHrZYit+3UlXt95Fydg4LkqYW40r/PS7xcskDc783NAVsQO/kMk3yJN8mzoT4JMDZT
	 dyMCZyI1wOR4LpZkhnM0M4LNzYzK9eTYcW31jr8ov4rdhmXGxziDCKjdWa8f+u+gAE
	 8KcD0J/I+UoeCyPMlSh3Hj1/70+uLw6ltb80UHIDxKnXXpUbA+WDr0UIHEnLqQdHmy
	 CtDaCWzba/wxrrNaHU9WMUKWKYAsxuhSHoahl0YsDPr3rzj3QefK/0diQNnNrMN4VK
	 47x9xUHSG8i/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C54380CFD7;
	Tue, 11 Nov 2025 02:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bonding: fix mii_status when slave is down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176282701674.2852248.18073773842117907078.git-patchwork-notify@kernel.org>
Date: Tue, 11 Nov 2025 02:10:16 +0000
References: <20251106180252.3974772-1-nicolas.dichtel@6wind.com>
In-Reply-To: <20251106180252.3974772-1-nicolas.dichtel@6wind.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, jv@jvosburgh.net, andrew+netdev@lunn.ch,
 sdf@fomichev.me, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  6 Nov 2025 19:02:52 +0100 you wrote:
> netif_carrier_ok() doesn't check if the slave is up. Before the below
> commit, netif_running() was also checked.
> 
> Fixes: 23a6037ce76c ("bonding: Remove support for use_carrier")
> Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
> ---
>  drivers/net/bonding/bond_main.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [net] bonding: fix mii_status when slave is down
    https://git.kernel.org/netdev/net/c/2554559aba88

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



