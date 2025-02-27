Return-Path: <netdev+bounces-170077-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1796CA47343
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:00:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA1016B9C2
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 03:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D10187FEC;
	Thu, 27 Feb 2025 03:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oTRndnK/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23964187858
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740625206; cv=none; b=m4xfzhhchppXbSFJEPQOWqzYg+s6iqts0XiVq7tDiV7TndfxaJtQo63MkBoOncYUYAcwxmkvsyjf1Ck60C4k0e4KxknK+IaVHnxu2y4e3z38qLNHDN2SU2YyARqHIGOeOmfAoYB85+OxukV8/RMmsLP4cwIuaS8wsKivDzf70nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740625206; c=relaxed/simple;
	bh=FeEUK4aoSyO8Z1CWfr2FXTPSv8KqDzg8jhjzPSgK+Ks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=E7Hb1Rbm+62u7n6RGMOgGn4wA1dVAbI/hugefACR2nncUvx9Xp8iRFrvhozhuyq4zDaqwss7OXbhmYK3uzElVftD6qQpmrTkMjuZK806muCk2Bg1fBN36ZETtdFamgqLR3YnuBnZZgrpkAGH6Q8BWO5zaN0HpgvMIk6imSBC8Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oTRndnK/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88ECFC4CED6;
	Thu, 27 Feb 2025 03:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740625204;
	bh=FeEUK4aoSyO8Z1CWfr2FXTPSv8KqDzg8jhjzPSgK+Ks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oTRndnK/p2MZu9FJ1igOqIKE+En6m6jJ+qhTegjYC7M4N2vpUgWnvHXQqM1KykRa0
	 j4k9eYvZsBKGi6Chb0zpgm010bIn4b/P7BRhYxm9dT9PcCtHGrF1Y/U22hr4tRV24j
	 U64Pj9Nri5jcDxJuFP9XEAJomZYTEXY8QIcJ9Z+gVem7LBwG9kRo4OLcnmbbE+uZW2
	 PZPzBrrn7NlO23DJ0/qDGJSsqj9pzw5XgaHaL7KnK43tny2mSL90LyJmD2ToX964OG
	 26a/4XEy/NkFgqaB8/+tec4iW9BkfN8XVheoV0L3sRLcmIn16aCupj51HWvLzsZLhh
	 V8ON15vTGH70g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADCBB380CFE6;
	Thu, 27 Feb 2025 03:00:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] tcp: be less liberal in TSEcr received while in
 SYN_RECV state
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174062523624.949564.171648574751933546.git-patchwork-notify@kernel.org>
Date: Thu, 27 Feb 2025 03:00:36 +0000
References: <20250225171048.3105061-1-edumazet@google.com>
In-Reply-To: <20250225171048.3105061-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@amazon.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, yonghaoz1994@gmail.com,
 matttbe@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 25 Feb 2025 17:10:48 +0000 you wrote:
> Yong-Hao Zou mentioned that linux was not strict as other OS in 3WHS,
> for flows using TCP TS option (RFC 7323)
> 
> As hinted by an old comment in tcp_check_req(),
> we can check the TSEcr value in the incoming packet corresponds
> to one of the SYNACK TSval values we have sent.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] tcp: be less liberal in TSEcr received while in SYN_RECV state
    https://git.kernel.org/netdev/net-next/c/3ba075278c11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



