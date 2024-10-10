Return-Path: <netdev+bounces-134013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C21997AB5
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 04:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B990B2299A
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 02:50:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3A5188A08;
	Thu, 10 Oct 2024 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="syMuSenJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01CB118859F;
	Thu, 10 Oct 2024 02:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728528629; cv=none; b=XUSbqqrfgTrzWMxnt+5K3wCjIENcovcDx0opWhJ/Cakna+PEU1PMe4e/33asrSAvgkIqkTA6nhj2RqNtLtQqEhbHPKBm82DyOl1sp5GnsyWWNr7VBy0RP3XT5jmVZsPSJO05VoEX7zbHxcyk1rxI77hhS7BhVaYswkoKevKSeXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728528629; c=relaxed/simple;
	bh=dsiG9yzcxDRBxahAQygg7kbncHL+3AbxCf6NCjUcJU0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YKotVvUmBTdIx0R4AMx/ZPQuZLCKMznP/bBhZO5qjq4QHgOc6lTYwM3MSBGJBAsyUiiFbojg0P2YxWxQc4NXeDfbP7hN54KWmB0LQPgNqahVbR+uzdTF39OAy9ZNSbU2V2UAb7zQ0/v2Os8FZGUHg25Kjhvg2O3SEwqLz8uxBTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=syMuSenJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C5D0C4CEC3;
	Thu, 10 Oct 2024 02:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728528628;
	bh=dsiG9yzcxDRBxahAQygg7kbncHL+3AbxCf6NCjUcJU0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=syMuSenJcVPW2gJcw88UN+FXJ1wDVydR+PiUTJmo39R5krCUs3lEto6n1xOmnNHeH
	 Mnve3kDDPidr3F3x1tlrsdXc1ewlDEb6PcHj2jGUE4G7oLlu/GH4QsgzoLo0+icL3e
	 0Xu7zpCRnOiUIU6960dZy8SJCpawcABBsE8rBcIjmgyeXFYlD1catW6LNphAJex5Sz
	 ANFCUNJ1ahKm4BpJB27hKozk3QT37UldOTxBCkGwpbwVivUxi5h0xWN+SZE3Y21v+Z
	 9U8RHWii99UROF4nlSQToACbwjD8M8Fk4UenCPgY6VFLJY8qpFvw3EYAWNDzd2HUXH
	 PnFOE82T3Jw6A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BCE3806644;
	Thu, 10 Oct 2024 02:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: refuse cross-chip mirroring operations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172852863274.1545809.959338960766757826.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 02:50:32 +0000
References: <20241008094320.3340980-1-vladimir.oltean@nxp.com>
In-Reply-To: <20241008094320.3340980-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew@lunn.ch, f.fainelli@gmail.com,
 jiri@resnulli.us, tobias@waldekranz.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Oct 2024 12:43:20 +0300 you wrote:
> In case of a tc mirred action from one switch to another, the behavior
> is not correct. We simply tell the source switch driver to program a
> mirroring entry towards mirror->to_local_port = to_dp->index, but it is
> not even guaranteed that the to_dp belongs to the same switch as dp.
> 
> For proper cross-chip support, we would need to go through the
> cross-chip notifier layer in switch.c, program the entry on cascade
> ports, and introduce new, explicit API for cross-chip mirroring, given
> that intermediary switches should have introspection into the DSA tags
> passed through the cascade port (and not just program a port mirror on
> the entire cascade port). None of that exists today.
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: refuse cross-chip mirroring operations
    https://git.kernel.org/netdev/net/c/8c924369cb56

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



