Return-Path: <netdev+bounces-229005-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37CCFBD6ECE
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 03:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA56D408E9D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3884F288505;
	Tue, 14 Oct 2025 01:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OdmLy205"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1028B23C50A;
	Tue, 14 Oct 2025 01:10:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760404252; cv=none; b=AFejbj4gHyWv0x90G5QYG7Ku5BB7cj3kWxx+ULus1XFT1qgRr8s1T/AcEh1Lbc7GRntRId7gCuFOkXNqUYpIcHdE8KT09/C02VZAk2Mp6hd6zD/4072ChtyEKmHnRpZGybuYRQvi/+XbkLPceD7CtuRs8JPcofsZrw8a+NtgSJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760404252; c=relaxed/simple;
	bh=sVcHh+JZ71uI9+zxI0tjwmWqm3nVpXD0V5/SpmxdXDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cvY6l5XF3gJrepFCIKz0HHsxOIrnxRqD5mBM6uxEufV7R9EE14vyOfdia4gGLaR/X165DKIsCoKEIvFPdkYMgd6ZrItWVmhziYZ/nrn1vuQgHSLIYMyMiwthKYKFOVXC2v1tNgSmhBjx/S0O+VJqpSrSouO1WBhzyPaa/jzPtxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OdmLy205; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFCBC113D0;
	Tue, 14 Oct 2025 01:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760404251;
	bh=sVcHh+JZ71uI9+zxI0tjwmWqm3nVpXD0V5/SpmxdXDc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OdmLy205mVHLQB7bRsX4a0xLVgEHLvAQfKaDs4YVykZaQqGcWQyjXZzFCA6IgVn25
	 cddceicfqam6JZNvIgPLxxXGKlveQyzHLxL48x1H1j3imiWYHPwAQFi6odyFWgQtZm
	 j79A3bl7hDixgS/wPMu+jn2Kh8w7M+XXclD42Nh3lTKqYTMhoanOfUZlxbwQOP/G9W
	 KYyFJlrKBpBspkApSPWRXxjvuM661+gDeEVlHS7JZ2c1VQZDgLOlMXRR8bktkrwDEg
	 T50P3Yk/03tP5LiiHTrMX6/s1S8I4ggypot0C9Df+/wREqmMFyaVjIKM70Ml5gHttg
	 PshP+KWUIMYxA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E11380A962;
	Tue, 14 Oct 2025 01:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net/ip6_tunnel: Prevent perpetual tunnel growth
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176040423700.3390136.16945162559318522251.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 01:10:37 +0000
References: <20251009-ip6_tunnel-headroom-v2-1-8e4dbd8f7e35@arista.com>
In-Reply-To: <20251009-ip6_tunnel-headroom-v2-1-8e4dbd8f7e35@arista.com>
To: Dmitry Safonov <dima@arista.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, tom@herbertland.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 0x7f454c46@gmail.com,
 fw@strlen.de, fruggeri05@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 09 Oct 2025 16:02:19 +0100 you wrote:
> From: Dmitry Safonov <dima@arista.com>
> 
> Similarly to ipv4 tunnel, ipv6 version updates dev->needed_headroom, too.
> While ipv4 tunnel headroom adjustment growth was limited in
> commit 5ae1e9922bbd ("net: ip_tunnel: prevent perpetual headroom growth"),
> ipv6 tunnel yet increases the headroom without any ceiling.
> 
> [...]

Here is the summary with links:
  - [v2] net/ip6_tunnel: Prevent perpetual tunnel growth
    https://git.kernel.org/netdev/net/c/21f4d45eba0b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



