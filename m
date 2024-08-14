Return-Path: <netdev+bounces-118411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD18951820
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 12:00:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C2801F23998
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769961AD9CC;
	Wed, 14 Aug 2024 10:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iecq4IjG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D091AD9C9
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723629632; cv=none; b=epf8Y7FDN5GEF1u9oeK10WN9B5tfg2ThlvIVdiTwmpSZC7V4HLmbr1asltwYbNhFwyV05IG+oneskLhSfVmoDqJfXVgC4JsfqQni42vUE3zcgQZG5j6zcsU+Xc+FOP3Hh3inGR05SQXrMpfjo1pB3FGBWlZquSlyUVDp+WOgmkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723629632; c=relaxed/simple;
	bh=QyrJspdqvzoxIJch6P+NP3XsEwxSHGc6tpOgut8wPP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=e72geBRaspfj0TqZ03OTzLbqgyzlyegg0JvnnY816PSqLsrEqGXJKm8fNc0ARiSBjlf1wDgGrEAHdqdupC/BLb0Uq3zQvWQDsqVMNHcqoQ9qFNt1Ipj653B4wup+Xb+sVeb0BgI4DEhAXbEQkUfeJ7LBmefI4/mEzybBkIp4p6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iecq4IjG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49BBC4AF0F;
	Wed, 14 Aug 2024 10:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723629631;
	bh=QyrJspdqvzoxIJch6P+NP3XsEwxSHGc6tpOgut8wPP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Iecq4IjGae1onZG1aX+lkGhJemu7OtayRjO4BX2bWUG5qtqaphQl3ZdIeJp4BPU4O
	 6W6pkY8P6lhJ2kucmdqqD8v1GjTM+Sm4Tf+ehNYnj4qJe307/2AsEA9W4HIg9xq6CT
	 mwdjV0/bNKL940ljlh57Fc/bSBeiPRiz5VfLeTt8UrIlPxKW70xtMOd2oFZyrp7Trt
	 nrpfXr2skhx7XUkQ6HMGp80CE9KZAuEZ7uBwvFbdy00EitAe45uF6fZ7yjntJH2DBH
	 PL7pnI+FEUCknqxzk8n6NVBKafN8S1rrmB/52iB5+NFkTnRf5sCc7WXZaPtMhNoN07
	 Ny1JlZH4Frv2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B9638232A8;
	Wed, 14 Aug 2024 10:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: Update window clamping condition
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172362963101.2215114.17248244783521331478.git-patchwork-notify@kernel.org>
Date: Wed, 14 Aug 2024 10:00:31 +0000
References: <20240808230640.1384785-1-quic_subashab@quicinc.com>
In-Reply-To: <20240808230640.1384785-1-quic_subashab@quicinc.com>
To: Subash Abhinov Kasiviswanathan <quic_subashab@quicinc.com>
Cc: edumazet@google.com, soheil@google.com, ncardwell@google.com,
 yyd@google.com, ycheng@google.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, dsahern@kernel.org, pabeni@redhat.com,
 quic_stranche@quicinc.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu,  8 Aug 2024 16:06:40 -0700 you wrote:
> This patch is based on the discussions between Neal Cardwell and
> Eric Dumazet in the link
> https://lore.kernel.org/netdev/20240726204105.1466841-1-quic_subashab@quicinc.com/
> 
> It was correctly pointed out that tp->window_clamp would not be
> updated in cases where net.ipv4.tcp_moderate_rcvbuf=0 or if
> (copied <= tp->rcvq_space.space). While it is expected for most
> setups to leave the sysctl enabled, the latter condition may
> not end up hitting depending on the TCP receive queue size and
> the pattern of arriving data.
> 
> [...]

Here is the summary with links:
  - [net] tcp: Update window clamping condition
    https://git.kernel.org/netdev/net/c/a2cbb1603943

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



