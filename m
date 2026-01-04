Return-Path: <netdev+bounces-246794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBC0CF1305
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 19:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EEE6B300BEC1
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 18:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77F32E091B;
	Sun,  4 Jan 2026 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ehqn6cPE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B382C2E03F0
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 18:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767551165; cv=none; b=T2f3im6u/+3RncQtgK4N8LpXbVaMdr3i03T7ZxsHwg953fadRwsN4EOLUU2YIFOruYnXS5SDpwmI7gS/xnHHdxzp06pdol6Xybrxybemen463Zp+rk/6Hq9VpAxt3l4llpxeQMJ3k7DUA06fjcaxIvuy9qufP9+Y/BY7CzKBCEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767551165; c=relaxed/simple;
	bh=3OcYIADWS6OLb71Ww/hx37jTbqZQ9/7EFd/t12hB2ec=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BBAL6hMcX6hebwMFr3Fyir5A3lG4SFofMLIZWG+r9ojkV+0/vTjA1HvuTtFQfkzucgn3weWvmLS9zmY3VdA7ztOkZ1o9lT3Pfo9DtcWOWah9g1vODzFTMsF6pzV/Pf/k5n3o9evkquu6/AZXsOo06DqSePKaNYOA2EPjIVS7kuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehqn6cPE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963F2C4CEF7;
	Sun,  4 Jan 2026 18:26:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767551165;
	bh=3OcYIADWS6OLb71Ww/hx37jTbqZQ9/7EFd/t12hB2ec=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ehqn6cPEm8G8Jf+myBw+Uk+vgfLTGUGENJim1LEsUHRKsvugqz/AEw6o8Lz4Xm7ij
	 QNz4Xo8tT9cTlf6GsvmiklgECcmlSuTzMGyL+AHOFZG5t0J7e3INzumtKfVnzkFRXa
	 mkweCA1TbKRZGzMhehR8q9PFSG/dQrMaRZPyaENm2NYhSBbC3Z3fbXVHUm4H9BODqa
	 aGvwzCn3ktjWQZ4EmEMVm1nuqRoJA8A7cNxc1xgebbzFjr60pJM5drzKTF4HjtFdDP
	 mAPWvxi9ZIxumjXAhEntOyFI9CmxJnah+KX3HX0HmXA0+ri+K//6Vc8BFkYHJm078k
	 NzCELwaiFKgFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B5800380AA4F;
	Sun,  4 Jan 2026 18:22:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bridge: fix C-VLAN preservation in 802.1ad
 vlan_tunnel
 egress
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176755096427.142863.8710171882718555642.git-patchwork-notify@kernel.org>
Date: Sun, 04 Jan 2026 18:22:44 +0000
References: <20251228020057.2788865-1-knecht.alexandre@gmail.com>
In-Reply-To: <20251228020057.2788865-1-knecht.alexandre@gmail.com>
To: Alexandre Knecht <knecht.alexandre@gmail.com>
Cc: netdev@vger.kernel.org, roopa@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 28 Dec 2025 03:00:57 +0100 you wrote:
> When using an 802.1ad bridge with vlan_tunnel, the C-VLAN tag is
> incorrectly stripped from frames during egress processing.
> 
> br_handle_egress_vlan_tunnel() uses skb_vlan_pop() to remove the S-VLAN
> from hwaccel before VXLAN encapsulation. However, skb_vlan_pop() also
> moves any "next" VLAN from the payload into hwaccel:
> 
> [...]

Here is the summary with links:
  - [net] bridge: fix C-VLAN preservation in 802.1ad vlan_tunnel egress
    https://git.kernel.org/netdev/net/c/3128df6be147

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



