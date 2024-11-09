Return-Path: <netdev+bounces-143544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A289C2EEE
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 18:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB2581C20B94
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 17:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8231A0BC0;
	Sat,  9 Nov 2024 17:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seNj4UE5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631F81A0B00;
	Sat,  9 Nov 2024 17:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731174628; cv=none; b=q5ex2kGwUxQlnQMcuEZFo8LpJ+wDjO/hRGucCF2QNDm3Vmd7fUc3UEZSNKsFzRIf59EQ7x9dFeUcZyD2upmgMD5oCz94t0sM7E3RKJEtyLdZe7HGIdX39w6ixAki1wPfMDLKT8rSJf7zJw71Msg/fVNkhUsPzP+6DoLztogMfvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731174628; c=relaxed/simple;
	bh=vV5E0cS1FJnPUmsyDLVQuamirxHagfwojeQJUe/Ls9I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QCLgF3VqistOVHaTOQ/mN5kD0vAmHyq4Qrwzm/z2Uovo8mu+DNx3OaPwbK9U84aplUVKILRCFtTtlRbdV8/xz844W+MLBethIR7byHsnz1uamwT+P39OnbmloNy760ydpnMmxJjFaO+7q1P4jfAz3Llmeh1Dzz77GxYopxhZLfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seNj4UE5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D54CEC4CECE;
	Sat,  9 Nov 2024 17:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731174626;
	bh=vV5E0cS1FJnPUmsyDLVQuamirxHagfwojeQJUe/Ls9I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=seNj4UE5G4dMjbN1QB2w843UufzuLaHCRheyyzxOBTxFWqdbVE+WrYNPt7pLhKHIp
	 drpohlnEnDzI2LBKezljlJAiJ2V9gKq/Yhy686cWeTDOiX8Nr6XFJAoTIbxfnd8rAp
	 rxdYQTicZqp3QcHG2T/PLFiJDtaffevsABrs3AjAVQGHmdvUJVsMB9KZ9wUlr6WP0V
	 D7m/g6kTSosfG2560vVNNPg6z4bA9kLHrHVLbAU44WNr+d4EnmzxuUygODP90Pfe/K
	 N0aWLVozXZwSbOI0UkjI5ExfYMKWbTJeSDvaacsgec+tzknn1GlOutHMDiGgqzLceb
	 AlDaBmjKz9LQw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCAC3809A80;
	Sat,  9 Nov 2024 17:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent a
 dangling pointer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173117463650.2982634.15058723153321836911.git-patchwork-notify@kernel.org>
Date: Sat, 09 Nov 2024 17:50:36 +0000
References: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
In-Reply-To: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
To: Hyunwoo Kim <v4bel@theori.io>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, sgarzare@redhat.com, mst@redhat.com,
 jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, gregkh@linuxfoundation.org, imv4bel@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 6 Nov 2024 04:36:04 -0500 you wrote:
> When hvs is released, there is a possibility that vsk->trans may not
> be initialized to NULL, which could lead to a dangling pointer.
> This issue is resolved by initializing vsk->trans to NULL.
> 
> Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hyunwoo Kim <v4bel@theori.io>
> 
> [...]

Here is the summary with links:
  - [v2] hv_sock: Initializing vsk->trans to NULL to prevent a dangling pointer
    https://git.kernel.org/netdev/net-next/c/e629295bd60a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



