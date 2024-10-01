Return-Path: <netdev+bounces-130765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E9A98B6F0
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381461C21E7D
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 08:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D021D19AD48;
	Tue,  1 Oct 2024 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NdbGCxq6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3E1B7DA6A;
	Tue,  1 Oct 2024 08:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727771429; cv=none; b=RRFWYHinPK6kFlN6Surf5h1yv1cc4H9QJWlSzOKTd5fDogbibUdQb08jpMEIBCgaXHChZp0tuhkWwwlVpVmVaX9E5PnO4HiVRYt43ISzVOF5wesLkkl9bu0BS0CwGhdTVLpw7cH4yC0zmNfvYn99GdbfsiqZvsr60vqfGnoOrkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727771429; c=relaxed/simple;
	bh=U1cn4W4Rb4d430nKrNVrnwolhR6CuB41HSPn69aC1rA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EFYfHjK2uDaHqrAEFdk1Yxp82wIIQ1/ZwWmru+seNzRVy5qg5be97OEbL4pBoE472wR0JZ0U6BrrddtBF3uL9SirrY6XBr59F4MT1lXTLs9SH2fNa9kPUsmpa5z29t2lIYWzidwTF2T06S8vT05/rUWAmQ8SBByhPxNT7FCbreQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NdbGCxq6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26698C4CEC6;
	Tue,  1 Oct 2024 08:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727771429;
	bh=U1cn4W4Rb4d430nKrNVrnwolhR6CuB41HSPn69aC1rA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NdbGCxq6BDwTy91MelV2KIZ6bMQ86jorg723OubGifkLRhcA6yb7h0J3wk7PUwoVN
	 YMzqfJ+6jhtTbgGB2zDfb4RH0wxuEhH2Z3ffvGnh3LKnOERaS2ZHgwqiDnLaDeC0TR
	 199z+pfnnpiREtoUo5kEvys5KlkYeZc7KUkJpEyjUtjfURLz1Hzbfngf7F+9VcW0/J
	 A3gqHhekhmmZUTnf5cyVWyl4CTYquXzYn5IESNt5QkJMA+dx7nU1t4V475Wq7QivSf
	 oPQzN/LJ1g+vz6EH3qlfzLV1F9+JsPgVJt+2EC9ZtC5pvSmZsV/fNR+chTfUvIGSp4
	 eFLNTXjZDavxw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 715B6380DBF7;
	Tue,  1 Oct 2024 08:30:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: improve shutdown sequence
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172777143227.262609.16884253520903184719.git-patchwork-notify@kernel.org>
Date: Tue, 01 Oct 2024 08:30:32 +0000
References: <20240913203549.3081071-1-vladimir.oltean@nxp.com>
In-Reply-To: <20240913203549.3081071-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com,
 alexander.sverdlin@siemens.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 13 Sep 2024 23:35:49 +0300 you wrote:
> Alexander Sverdlin presents 2 problems during shutdown with the
> lan9303 driver. One is specific to lan9303 and the other just happens
> to reproduce there.
> 
> The first problem is that lan9303 is unique among DSA drivers in that it
> calls dev_get_drvdata() at "arbitrary runtime" (not probe, not shutdown,
> not remove):
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: improve shutdown sequence
    https://git.kernel.org/netdev/net/c/6c24a03a61a2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



