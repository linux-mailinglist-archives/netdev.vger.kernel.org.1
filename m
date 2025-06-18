Return-Path: <netdev+bounces-198923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33346ADE547
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 10:10:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12013B74BA
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 08:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA0D427F014;
	Wed, 18 Jun 2025 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP6+O5VU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5B1427F012
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 08:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750234200; cv=none; b=nfUAHg99qI2QZxqJzFJ0dGUwJYtw9eimZjEsRq5TSnjWMulTRcx2CAfj02Qi2XFCdX6vj4Hpo1HGelJQ/agocnseqEvvwegmBSw+ikaACG6hPg+1YqCdUWk/U5dlfbk/EKKPorSu/vAq/HrkSm6Wl641JCf+S8Ae5/hRCloiTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750234200; c=relaxed/simple;
	bh=ZfIwrY9Hb1mHJRKufm2Ypapw8xBYSLjDabrgcOQdfe8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Adh9bnMxg4y7QGF29YyOROnt7Anm4Cmdr4JH3ncYTQU8mFJC2ajEFjdcUCitdP6uQSmIp/y7ow5vLtyQeb98ZQ5fki048NIGru1A6e5cRlfIQUNmtO82tvqwUyj6JJdZxSLxNKTSD0QG1hj0In5fxjAOf5xM9PrhsXAZXOrhUpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP6+O5VU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50829C4CEEF;
	Wed, 18 Jun 2025 08:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750234200;
	bh=ZfIwrY9Hb1mHJRKufm2Ypapw8xBYSLjDabrgcOQdfe8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eP6+O5VUIgfzC3BvjkjXPfHWSQ3cw3qXMreQK/rxMhOD78WRC5NITwqkj41I79UHF
	 1OdGdiqPGl9qwLOCvLNGLdSuEagYGgT3CV+8diHLz7l1ApY5I1I3QQWOvYv8CYd8J4
	 O8Le4DwGDrXVGiVbsQCSRIOT26zhgl34oQLsGxhx2LUclMCUm/+NxtPto63d05eh25
	 cHdttAqniOVn0yFTEdcCObDyiGh7PEvwFHbu+vmHP6mPl1l6O7+PQHAqRH+3DkZpYH
	 dPOOtKbjtHRZCbcBnTUAT9XRPu0+GF+blRp6mLUosx0W5Y5NteaGH8+50QrdghFhWW
	 8H2Cpl1yHXiKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB03039FEB77;
	Wed, 18 Jun 2025 08:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: fix tcp_packet_delayed() for
 tcp_is_non_sack_preventing_reopen() behavior
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175023422875.9868.14455979401295730109.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 08:10:28 +0000
References: <20250613193056.1585351-1-ncardwell.sw@gmail.com>
In-Reply-To: <20250613193056.1585351-1-ncardwell.sw@gmail.com>
To: Neal Cardwell <ncardwell.sw@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
 netdev@vger.kernel.org, ncardwell@google.com, netdev@lists.ewheeler.net,
 ycheng@google.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 13 Jun 2025 15:30:56 -0400 you wrote:
> From: Neal Cardwell <ncardwell@google.com>
> 
> After the following commit from 2024:
> 
> commit e37ab7373696 ("tcp: fix to allow timestamp undo if no retransmits were sent")
> 
> ...there was buggy behavior where TCP connections without SACK support
> could easily see erroneous undo events at the end of fast recovery or
> RTO recovery episodes. The erroneous undo events could cause those
> connections to suffer repeated loss recovery episodes and high
> retransmit rates.
> 
> [...]

Here is the summary with links:
  - [net] tcp: fix tcp_packet_delayed() for tcp_is_non_sack_preventing_reopen() behavior
    https://git.kernel.org/netdev/net/c/d0fa59897e04

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



