Return-Path: <netdev+bounces-135799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655A399F3BA
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 19:10:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3A49B21FE5
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 17:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 520111FAEE4;
	Tue, 15 Oct 2024 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hE/GYVbw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA901FAEE0
	for <netdev@vger.kernel.org>; Tue, 15 Oct 2024 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729012228; cv=none; b=mvG4A0caMG0makSc0iB7ccYStbfn4TkthIrFP/4eLKF7pEmQT/30u1F5fJ2GC4ImnWUm0xi6A6kD56r8F/gWNi/mYPt7pZo5KIVz6D3wyb/1islq6FzyRVx/Hh4h/DETI8rGcUewog2Ek0SoqMUh8KOJ7xVG443VG7O/2DXaHa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729012228; c=relaxed/simple;
	bh=D7UEmi5u0JkYThG8yMl4IdKUIE3hHDyz1imdNz+eXuE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Pc4x0wOJ6XHQdihXY5fSmEAUCpKChSkLThXdUwVJxNJIgazaxKZMI44HFWrKtE3zKaXLbfrrq3yM8J1UKlgRE2Np+XeveaCfIo20L6MJY5wtv+0Al7LDesmo/zp3BY/z9Y7zWqsf9EBfe8OZ7GKBL6phYwlpwsNtrT6dNEgL0Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hE/GYVbw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD7D8C4CED0;
	Tue, 15 Oct 2024 17:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729012227;
	bh=D7UEmi5u0JkYThG8yMl4IdKUIE3hHDyz1imdNz+eXuE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hE/GYVbwmEmwT041TZX03pRv9aEZS73rvpQ6pM+2J7WpL3vy83ejAVy65WpAcXX0O
	 YitkmdQv5CsXSQmnKABRoIodgRFYznVA3lZCG/Lve/AAo8VYNlXf/d05AaORaJdKb2
	 hBRnijipambJkyowmmtdkElaSnhh7Mzv0++4Z6VW+nfH1k2+ZRb4u0VS3QsK70Et1M
	 apwwnel9bcxLv+bngjlM8JKjZBizsaiM9yADSfynhpPa22Lx27EQi7WMXKxTJ3LfEQ
	 PUpgpv7sZvTDxeIDJq0I0o/hgxsyQ5NERC5+6GZaXhuMlF8Q6i3MspH4ggMKM1H690
	 DaVV9Ce53ntlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B6D3809A8A;
	Tue, 15 Oct 2024 17:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] macsec: don't increment counters for an unrelated SA
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172901223299.1230547.4174159354006479472.git-patchwork-notify@kernel.org>
Date: Tue, 15 Oct 2024 17:10:32 +0000
References: <f5ac92aaa5b89343232615f4c03f9f95042c6aa0.1728657709.git.sd@queasysnail.net>
In-Reply-To: <f5ac92aaa5b89343232615f4c03f9f95042c6aa0.1728657709.git.sd@queasysnail.net>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Clayton_Yager@selinc.com, pabeni@redhat.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 11 Oct 2024 17:16:37 +0200 you wrote:
> On RX, we shouldn't be incrementing the stats for an arbitrary SA in
> case the actual SA hasn't been set up. Those counters are intended to
> track packets for their respective AN when the SA isn't currently
> configured. Due to the way MACsec is implemented, we don't keep
> counters unless the SA is configured, so we can't track those packets,
> and those counters will remain at 0.
> 
> [...]

Here is the summary with links:
  - [net] macsec: don't increment counters for an unrelated SA
    https://git.kernel.org/netdev/net/c/cf58aefb1332

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



