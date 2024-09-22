Return-Path: <netdev+bounces-129204-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B653297E2F6
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 21:01:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB68C1C20CDC
	for <lists+netdev@lfdr.de>; Sun, 22 Sep 2024 19:01:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62FF6BFB0;
	Sun, 22 Sep 2024 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l5c0vS5C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB3B4CB2B;
	Sun, 22 Sep 2024 19:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727031631; cv=none; b=YsLeTtg/ANiP3OIclyg3xq9Bb5GttLebI24zvDW9Sy5ZPLMhB2wghGun2L7kViJ01eWjXDzh6aomjX3iVA/Bcs5cPW0uEvHU0tt2qqletXPqTYqB/k6coQ64XW2E7LLAutetVcnGkjUQAdUvHVPL3BtT3EeXRr4LuRLGWRWgCeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727031631; c=relaxed/simple;
	bh=tTAlP3U+9em8Bh0m0Xx+hjJT5l4ydb2Sk6UP0BV6ODc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=h3FtFx1G5LBo4N914befUljE5pXHwtZ7DpZT+v7ltw9qnMgJMH0o8lO+VwSHPhnQ0pdHcPPKx2s2R8gGagSbAKvHlH4Hy5smKL91PnsNaQRxWPj8yy9eDD+pH5+IY92fuvYX7AkPe+QbQX2JigeStmklihFL5e7LTL61g1RmCoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l5c0vS5C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A680C4CEC3;
	Sun, 22 Sep 2024 19:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727031631;
	bh=tTAlP3U+9em8Bh0m0Xx+hjJT5l4ydb2Sk6UP0BV6ODc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l5c0vS5CRHbygONPKv+/LaTnGss4fgbfM0XqxraXE1lDMCdqLm0+AaLFHsSLSX1rW
	 6FIV8nNCGm4b1d4XrTZP1KdRD/sev8jkd2HHjQIxDO9XUYEoKI0Bg8JAnhgoM1lHR5
	 MQ1TUQ9nfCkKGy0dPH5Fmn1Ftpmujo7FumYtVm84rZJYSEAjpLA4ofe0wBQfpmVQTl
	 zvNl47RR9vL+YP1WvkRQtSHksCCxDBqq6ZT2c2M7Q1EGbxy2TOVkT+SrTucdMAIHKk
	 BW5Drz6i//aB9J7A20QHXnBUaMDP7rdDam1TxGumtJLbbDQkCOeTJZrGPleBIWnefj
	 0n2z9RY1Sz5+g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADF083806655;
	Sun, 22 Sep 2024 19:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: sparx5: Fix invalid timestamps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172703163324.2820125.8298775667316413589.git-patchwork-notify@kernel.org>
Date: Sun, 22 Sep 2024 19:00:33 +0000
References: <20240917051829.7235-1-aakash.menon@protempis.com>
In-Reply-To: <20240917051829.7235-1-aakash.menon@protempis.com>
To: Aakash Menon <aakash.r.menon@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, lars.povlsen@microchip.com, Steen.Hegelund@microchip.com,
 daniel.machon@microchip.com, UNGLinuxDriver@microchip.com,
 aakash.menon@protempis.com, horms@kernel.org, horatiu.vultur@microchip.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 16 Sep 2024 22:18:29 -0700 you wrote:
> Bit 270-271 are occasionally unexpectedly set by the hardware. This issue
> was observed with 10G SFPs causing huge time errors (> 30ms) in PTP. Only
> 30 bits are needed for the nanosecond part of the timestamp, clear 2 most
> significant bits before extracting timestamp from the internal frame
> header.
> 
> Fixes: 70dfe25cd866 ("net: sparx5: Update extraction/injection for timestamping")
> Signed-off-by: Aakash Menon <aakash.menon@protempis.com>
> 
> [...]

Here is the summary with links:
  - [net,v2] net: sparx5: Fix invalid timestamps
    https://git.kernel.org/netdev/net-next/c/151ac45348af

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



