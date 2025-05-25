Return-Path: <netdev+bounces-193262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DE5AC3511
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 16:10:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB69E3B441D
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 14:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7171B1F4615;
	Sun, 25 May 2025 14:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L9FM+gtE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFFD28EA
	for <netdev@vger.kernel.org>; Sun, 25 May 2025 14:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748182207; cv=none; b=OfDjnz+ALXDOIWkNqBo6rJDVLB387MB7eJvhLN9OVR5JIODfz1sEAjMnbqduhQNBYfBj4GHTObD6f++72BGxuTDkg6ETpCuQY6yXA/NWgprwY3KnI+P2Pn45pbmWDi8X+0t3kHvwZ/OkMQJ0lB3YKjYdzBcBG1X+X5ssR0khShA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748182207; c=relaxed/simple;
	bh=wJw5egudjTiradViVs5KQyjsM8BRKu/gLtJMEl/+Mk8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ibpadj3lkuvQXdVaatxFzOOmsUfU2xsJnxxsaGE62hxVJkZneboqexLUV3z3PZk6CnJy86zSebPY97x9hWaC9PBKvNqOgsoRZL+ZW0FEqJVHisF79PEjSTF702zjWecT18WukkBOZIzlJoEqcOmEGYy7bQWMxBrW9f3D9deMwhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L9FM+gtE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0AD8C4CEEA;
	Sun, 25 May 2025 14:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748182206;
	bh=wJw5egudjTiradViVs5KQyjsM8BRKu/gLtJMEl/+Mk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=L9FM+gtE7M9EZf9tdjo4gGrXUXpb1jzf6nWHGN1iaRIkIWQHkRp6wtSpEWiTNa/ku
	 Wx+RrtfkH2MnBK2fLZPjDmBmXAQkRSh2njcDazaqQQj4iOp3QRRBHwRUT3kunxsABk
	 U458V02j3LLpkIJSqol5Kd9+TUf1PGL71D6QzfDzmVrmhM7oCGuD6XoQdfFpk7aWRy
	 hZX9U7qr7q7dXJf0emXebXXHbc+GNDiIgSKBEj9eGiAnGVljnj/XJjjizXEYi/3RHy
	 3LCDLHsoXaQ7CDAp15f8wCacunR+k/EZjyWmBIAKf+1dxq7KF2UxEm1RtXOUmcXCLi
	 xwAvo2gBRpM/Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD7D380AAFA;
	Sun, 25 May 2025 14:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: dlink: Correct endian treatment of t_SROM
 data
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174818224150.4147910.15661609084978446612.git-patchwork-notify@kernel.org>
Date: Sun, 25 May 2025 14:10:41 +0000
References: <20250520-dlink-endian-v1-1-63e420c7b935@kernel.org>
In-Reply-To: <20250520-dlink-endian-v1-1-63e420c7b935@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 20 May 2025 15:25:41 +0100 you wrote:
> As it's name suggests, parse_eeprom() parses EEPROM data.
> 
> This is done by reading data, 16 bits at a time as follows:
> 
>   for (i = 0; i < 128; i++)
>     ((__le16 *) sromdata)[i] = cpu_to_le16(read_eeprom(np, i));
> 
> [...]

Here is the summary with links:
  - [net-next] net: dlink: Correct endian treatment of t_SROM data
    https://git.kernel.org/netdev/net-next/c/b3456571cea1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



