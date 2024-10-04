Return-Path: <netdev+bounces-132304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275EE991307
	for <lists+netdev@lfdr.de>; Sat,  5 Oct 2024 01:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 947C8B23381
	for <lists+netdev@lfdr.de>; Fri,  4 Oct 2024 23:31:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB680156661;
	Fri,  4 Oct 2024 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WGjKZw+W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F2A15623A;
	Fri,  4 Oct 2024 23:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728084632; cv=none; b=QwV5RBfsGWbnJcBcfYTmuJupg+52rhvvuM1OxVtIBg0nuE0gQ4Ca9YR5JVCFdHNwpmT2iA80RbJOfdjaTl0EaLfSQblwQCQGZtMn9kxTkvYCqW8y+N18GEwag++PAWb8zpHEipNSwqjQQcxgLNC57hihBo38EO3hM/SVQA8n5qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728084632; c=relaxed/simple;
	bh=cMmzOkynVhYEku1FqQWgBDLEh4O326NIL3M8tR9qYz4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Odrx2k0XgSjGC+bQe8SRbcohxQL5aRs2EMmYagN0+TOwOEnaMBMh6eIymud18xylVT498derxgO5lnlhLth2zEUIKi23dl+9UEfPsnKQ9r73TicLpGxnvTvZ+aKHyEGCft7OXmdYDydGboK2X4rMS7VAsPXMc8poIGdClhTejKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WGjKZw+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C267C4CEC6;
	Fri,  4 Oct 2024 23:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728084632;
	bh=cMmzOkynVhYEku1FqQWgBDLEh4O326NIL3M8tR9qYz4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WGjKZw+WL917dM2Suw/f4HPn8JpZSuvwnVWW8Xx4iEwHZ8ZxEAaZMr+5raTVVd/9k
	 XzLsWD5/FsL0jV1w5M7OEUfad5xf9u96jTKzUMB79wXzPfpo1J8PQBwLLYYji8fPNG
	 SCg4D37PtTMyhxMFl12DTmqagE5UyScNjm6W/pvZEpLMELtG7p2+kAQJstiLPdTplY
	 Q+Vj91ypKOSfey75lkqF5jBwP696yZ3AF8fcMDXjNZf0RqlYWAyYJDL82i6BmYnCSx
	 n9he0uP9Dis89Z77bci2ByqkRH2Ovdg+bi5fVWe5GfI+Lj2Yn7wmkL7oGVm4pfLrwN
	 qlWu161BPV7Aw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3438E39F76FF;
	Fri,  4 Oct 2024 23:30:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: dsa: bcm_sf2: fix crossbar port bitwidth logic
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172808463599.2774988.2302606586871365264.git-patchwork-notify@kernel.org>
Date: Fri, 04 Oct 2024 23:30:35 +0000
References: <20241003212301.1339647-1-CFSworks@gmail.com>
In-Reply-To: <20241003212301.1339647-1-CFSworks@gmail.com>
To: Sam Edwards <cfsworks@gmail.com>
Cc: florian.fainelli@broadcom.com, rafal@milecki.pl, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 CFSworks@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Oct 2024 14:23:01 -0700 you wrote:
> The SF2 crossbar register is a packed bitfield, giving the index of the
> external port selected for each of the internal ports. On BCM4908 (the
> only currently-supported switch family with a crossbar), there are 2
> internal ports and 3 external ports, so there are 2 bits per internal
> port.
> 
> The driver currently conflates the "bits per port" and "number of ports"
> concepts, lumping both into the `num_crossbar_int_ports` field. Since it
> is currently only possible for either of these counts to have a value of
> 2, there is no behavioral error resulting from this situation for now.
> 
> [...]

Here is the summary with links:
  - net: dsa: bcm_sf2: fix crossbar port bitwidth logic
    https://git.kernel.org/netdev/net-next/c/41378cfdc47f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



