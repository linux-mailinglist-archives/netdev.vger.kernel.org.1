Return-Path: <netdev+bounces-84230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFDCF8961EB
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 03:20:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A914928443B
	for <lists+netdev@lfdr.de>; Wed,  3 Apr 2024 01:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E0C111190;
	Wed,  3 Apr 2024 01:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGw64nFY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE95D6FC6
	for <netdev@vger.kernel.org>; Wed,  3 Apr 2024 01:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712107230; cv=none; b=Wt23JPRXYnduXOLsCSnyIyTKZDtOiOQZsqaw426V2yv8OpExt8Stq7pFlVt5wTD25Qg+/4ycAt+5nYCu8fZ9qw8Kq602ehvPN6rX8O/NLiibfQBgHFhqW5eoCPKfcDpGU9VtIKEGNi+WkIIg3/4jc6VHMN/foAclav7Qm7hK0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712107230; c=relaxed/simple;
	bh=pmL07TVaZWxRXmRlLuD8rqgKCT8Qi0PrSrY07y5S8Kg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m7R4EyzEnUtWKW2bkusBF/b/o79m5nwy68yq42OXnljeUCcw+u6lajplYqPcF5ArlI/Gaa8PsT79YtapW3NZkNwRm/UTum9S2MflalOkfPPY8lcATjQ48xbmMxFsdMiZwhTrsVxC29jtKnXD03VF3MY6eK7ktSSaK6hyR7vL9/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fGw64nFY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7EA3EC433C7;
	Wed,  3 Apr 2024 01:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712107229;
	bh=pmL07TVaZWxRXmRlLuD8rqgKCT8Qi0PrSrY07y5S8Kg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fGw64nFY3wgi6qF5y7NEZpL3pw9zEFG4CKut8Or/fVC/Vhu6UHJu9jPOTnFn8kRvM
	 RINoGyRdpDAPsI/3a8E9PQ3RFMHxJhVTXfkUjWayu87wWbpHjwgxs9c29kDfO+4sBl
	 L0MGPbrqC6Y4qZAoEhbskQYoziqGt7iT1/MY6W+I0/5LYyy1HC3EHSG2wMGHS9BOd5
	 SZFpxq9ygqtM/5KKjjstgcPcd4DqnWFdTcxIvGP5XNDaIIJtBdgB4JA4Ntlmenkozf
	 JZ/0VGhvuXR9ZNJWR+tZ0jiAYqEVDmiWo2VD1vePfPlp+IILAt9Fkvll3wHmaVqJXG
	 P81baBC++j/0Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6D76FC4314C;
	Wed,  3 Apr 2024 01:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] r8169: fix issue caused by buggy BIOS on certain boards
 with RTL8168d
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171210722944.2838.6358852291043028405.git-patchwork-notify@kernel.org>
Date: Wed, 03 Apr 2024 01:20:29 +0000
References: <64f2055e-98b8-45ec-8568-665e3d54d4e6@gmail.com>
In-Reply-To: <64f2055e-98b8-45ec-8568-665e3d54d4e6@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>
Cc: nic_swsd@realtek.com, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 30 Mar 2024 12:49:02 +0100 you wrote:
> On some boards with this chip version the BIOS is buggy and misses
> to reset the PHY page selector. This results in the PHY ID read
> accessing registers on a different page, returning a more or
> less random value. Fix this by resetting the page selector first.
> 
> Fixes: f1e911d5d0df ("r8169: add basic phylib support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] r8169: fix issue caused by buggy BIOS on certain boards with RTL8168d
    https://git.kernel.org/netdev/net/c/5d872c9f46bd

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



