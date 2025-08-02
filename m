Return-Path: <netdev+bounces-211430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52C09B189CC
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 02:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB4805A250C
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 00:14:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E783572600;
	Sat,  2 Aug 2025 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWQT0F8D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AEF8462
	for <netdev@vger.kernel.org>; Sat,  2 Aug 2025 00:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754093640; cv=none; b=cc8hyjL3eQwELq/8oKAji57YIfxqK+9XUbITYaElNlcLhDW2E9EsGTuVk5DOSzFmCbyipIiv4QTmMnCma0F00V4iV688ssf3lqE28H8+XIZyZd6o298/oGjwtxvde0FX9xGkHnsrTiM6dipQrWDyoP8aHBuhCXOLYYWn32Hiazs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754093640; c=relaxed/simple;
	bh=75dxUvwP9/+iE/3p6MG/G4IjbNW+embV3cKW5mInJLo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ij1AyI1oX9NG0fVyDlVfemtsLyRdIxjoOXylq1UtyiBMmeDz2NNFd8Vh+H6MnAL7nPsLzzQ00v9bHjgmR8RzFmIfL8a108SDfJzcqx3sJL2pqLu9WjpPxus5onP0AqwshScgnv26MGDBBZbDe+XlukrT0XKSa1pOuqnT80u+sGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWQT0F8D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49383C4CEEB;
	Sat,  2 Aug 2025 00:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754093640;
	bh=75dxUvwP9/+iE/3p6MG/G4IjbNW+embV3cKW5mInJLo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mWQT0F8DVQzyr2zYCh/FQmKyRBLsG4ijVvRISUtpJDEoNh6E1H/Z6wgr5oQjuEJr5
	 ZF4OK8tTEfHc+JU612aMuP0BD5AtNjkldRaxDFHG4euKixxDswCBILbAvv7T0LM5Kn
	 JXrZSQ//54cW7ZMfGE3ymH6k+Iddr3UYYSc/yYjttjAnfjzSw74bhIwoHzCyxsIvrB
	 p+VB3mxsLimWMW3VUvdSuaA7Zs1Hha6g/1w1PomQSW+sk3mPo05YC10xtKgyd2Iy/E
	 IcX5aTRLzhx8wiXU+AkxIwFK5qxonxXuA2EEqv+Ln41iuctUDm2ZsZLVXJO2aYtw/m
	 rCrJQzr0d99FQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCBC383BF56;
	Sat,  2 Aug 2025 00:14:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv6: reject malicious packets in ipv6_gso_segment()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175409365524.4093813.15382360985962016435.git-patchwork-notify@kernel.org>
Date: Sat, 02 Aug 2025 00:14:15 +0000
References: <20250730131738.3385939-1-edumazet@google.com>
In-Reply-To: <20250730131738.3385939-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 willemb@google.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, syzbot+af43e647fd835acc02df@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Jul 2025 13:17:38 +0000 you wrote:
> syzbot was able to craft a packet with very long IPv6 extension headers
> leading to an overflow of skb->transport_header.
> 
> This 16bit field has a limited range.
> 
> Add skb_reset_transport_header_careful() helper and use it
> from ipv6_gso_segment()
> 
> [...]

Here is the summary with links:
  - [net] ipv6: reject malicious packets in ipv6_gso_segment()
    https://git.kernel.org/netdev/net/c/d45cf1e7d718

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



