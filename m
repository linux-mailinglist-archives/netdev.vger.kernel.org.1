Return-Path: <netdev+bounces-143910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A7A99C4B9B
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 02:20:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC1601F23B25
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 01:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FD582010E3;
	Tue, 12 Nov 2024 01:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZC0UYRQb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C5FB4C91
	for <netdev@vger.kernel.org>; Tue, 12 Nov 2024 01:20:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731374419; cv=none; b=lFCL7gzWDNs1gnSkw10Gjk2xyjBUl0R+BkvaB7Ubl9cIqFkp1tjrK8Wf1p4bivYx3Mh5Z9c+5hWcL4RkH0+EN/KzqlUeVx0rsU6KXikwH+it/+FMwU1x/8Ws9SwKSV3/sQCUFcIYj0UfMGEjZ7JA6E+gLiLUL+wpHlt7Nu8Ph3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731374419; c=relaxed/simple;
	bh=5jj6mO0Hyq7w8CUBMiK/29PvDpB8uC5sQZV8JPjfdvk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nQNioY63fWuouVOttNWAy+5LK+1xJR7KT3UmCKjpUCTj57zv6FxZJQFlr4gHDb8GxoFI7apCYjiy7XDSOrAKs4USZffFsZOoAnGZe6rQT0UJJN2x5ZAbIBOhXeTw3PNC5Pcz2Q+DstxmrjCJ1FggKsE6zyRbPYkZlcPsiLRx3x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZC0UYRQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A57AEC4CECF;
	Tue, 12 Nov 2024 01:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731374417;
	bh=5jj6mO0Hyq7w8CUBMiK/29PvDpB8uC5sQZV8JPjfdvk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZC0UYRQbhxtK5ffQ5yR/gUFzEGYa1OqczBnQ0FzHD+g+JCvd4dcKitafv+podkDy8
	 Mdxw+w+cXXQkfiBRelWpuKf51FCk4C06TECJWvY+pE22SvYokvN3LtqP9ZRQgim3bZ
	 8HpqeJpb7svPfJ58bDss4131XMT5A+pkrRJMFxjR7YleAMIO+20ULbAP0Ldt/LMs03
	 cA4/rseVvYQqgSKYcZGXqg0TuNKym+eMiUINxPlCsCm0pDUafXA/LnWJ/tUqN3aN5c
	 TPsaRB5WGsnqWlCJLC584Go7TPAruSEV+WYmOVIiWTzf8W1pxppIner0rfenYEQU3i
	 tiTNMoyhdkunA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAE0D3809A80;
	Tue, 12 Nov 2024 01:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: use helper r8169_mod_reg8_cond to simplify
 rtl_jumbo_config
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173137442769.38162.3352010004945064208.git-patchwork-notify@kernel.org>
Date: Tue, 12 Nov 2024 01:20:27 +0000
References: <3df1d484-a02e-46e7-8f75-db5b428e422e@gmail.com>
In-Reply-To: <3df1d484-a02e-46e7-8f75-db5b428e422e@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 9 Nov 2024 23:12:12 +0100 you wrote:
> Use recently added helper r8169_mod_reg8_cond() to simplify jumbo
> mode configuration.
> 
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> ---
>  drivers/net/ethernet/realtek/r8169_main.c | 77 ++++-------------------
>  1 file changed, 11 insertions(+), 66 deletions(-)

Here is the summary with links:
  - [net-next] r8169: use helper r8169_mod_reg8_cond to simplify rtl_jumbo_config
    https://git.kernel.org/netdev/net-next/c/7a3bcd39ae1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



