Return-Path: <netdev+bounces-239376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA01C67448
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 05:33:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ADA4B4EF47D
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E182BEC42;
	Tue, 18 Nov 2025 04:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD6rhF20"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92F772BE7DD
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 04:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763440262; cv=none; b=Dbc/Bn8HHT4oRVGYRorcJZTQh6PYIG7YxPMD/i9R5mERD5CcKc8Fb/u3CW5Cg9SDx2t/RFwqizu4B+JXvCTxunfdEsLrTxeEadNtgNPm0IBa58aMSpMa4z/ZZl1ELuotU3GLmUUW5NmfMJ9bqCK4PPLnFUUKUsbcTgFrifiaw+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763440262; c=relaxed/simple;
	bh=gSR02izGzZEgAi1ttXeXHkgZqxcAEA+PgziV8fN8PqY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=b1A9KVUFBT0/rDHxMrp6uYKh/eLpwzHQGWDl7VZ7s5GnYvvZKV8qNlqLXy/8/s91GWdvJ57LYWNVLYXGxMvO40iTlr/VY5FY9xTBXUjErfuiEsIPzVbj95KZpdy+CxKdkDUqnBgktOEV9Bf9ASL7hgpb7O7ISOn11WQiULutDkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD6rhF20; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EDAEC4AF0B;
	Tue, 18 Nov 2025 04:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763440262;
	bh=gSR02izGzZEgAi1ttXeXHkgZqxcAEA+PgziV8fN8PqY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=PD6rhF20C+zd+/wRroRlhNn1fhBelUAgaSqLCzeAqg/KlTvMlcGwjyFtrVXvHNUal
	 bT5Ga+x/yVzhKkwsWLc8Vpk4T2C7HQXblYw74WNYy1JqVtgOZwgh3165Bw1he3FSRj
	 oQurLb6pVgAEP5lsSq67g8uxytUo+nL9g9JKCgdgW6ZsUximSOttNgJFboVVuy5wWb
	 PRzk4Bpg0uYZcsItbPgVszHnD9BugPh/hXIy1oxbzrO0/qGGfvjGd1NcgQqf7PnFlX
	 y7I/0pqnf+r5sqhDOxr6GBi1HfP6t7qBCZ+SvodAYWrivL0l85Bdu+m+QgAegJBW8d
	 +SAZ3CT7pk8yg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D813809A1D;
	Tue, 18 Nov 2025 04:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] r8169: bail out from probe if fiber mode is
 detected
 on RTL8127AF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176344022825.3968687.15840201429091336711.git-patchwork-notify@kernel.org>
Date: Tue, 18 Nov 2025 04:30:28 +0000
References: <fab6605a-54e2-4f54-b194-11c2b9caaaa9@gmail.com>
In-Reply-To: <fab6605a-54e2-4f54-b194-11c2b9caaaa9@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 edumazet@google.com, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, daniel@makrotopia.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 13 Nov 2025 22:09:08 +0100 you wrote:
> It was reported that on a card with RTL8127AF (SFP + DAC) link-up isn't
> detected. Realtek hides the SFP behind the internal PHY, which isn't
> behaving fully compliance with clause 22 any longer in fiber mode.
> Due to not having access to chip documentation there isn't much I can
> do for now. Instead of silently failing to detect link-up in fiber mode,
> inform the user that fiber mode isn't support and bail out.
> 
> [...]

Here is the summary with links:
  - [net-next] r8169: bail out from probe if fiber mode is detected on RTL8127AF
    https://git.kernel.org/netdev/net-next/c/28c0074fd4b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



