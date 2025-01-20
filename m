Return-Path: <netdev+bounces-159762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E67D9A16C40
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 13:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C2FF168FD1
	for <lists+netdev@lfdr.de>; Mon, 20 Jan 2025 12:20:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 723191E0DE6;
	Mon, 20 Jan 2025 12:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIJFB1X2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFE71993A3
	for <netdev@vger.kernel.org>; Mon, 20 Jan 2025 12:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737375606; cv=none; b=TAN7jm5QCdqSD8TqRaw2rB9x3Pty1/A0luEYKRJxaj0PCTeai61A9qns++C1GjzallWZfmDDbxSrZwjOcbwdK9EOuhhftMRVs54tdwGLhxWRBUDHzRZe37YAu+j5Mx/C+wf/ZRv7+25UaCcfRdIZB+2tWMlGRIJWhkdCRntk8Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737375606; c=relaxed/simple;
	bh=Q4nD0ta40Va38T+23Phk5AZWw6veuhkkRVHUVjD+ZX8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VoSqJqxzs60l91TVCFyKKO4xR8nYKz7uxaKGqRVECOSG1dy77fsjv7UCLauVIaVV4NN06PGwzUg1U4hv9QMaU+2ZnerxkDz0+fzVaymUzFfn6iJPHX+DcmrCqIWz9gxcsh0yEnZJcyqB6IWFSzsLeeS7n+VUZ4EimD8EGtQpVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIJFB1X2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4BE1C4CEDD;
	Mon, 20 Jan 2025 12:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737375605;
	bh=Q4nD0ta40Va38T+23Phk5AZWw6veuhkkRVHUVjD+ZX8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZIJFB1X2ZgJcrJnSUtd4tLv1UPqO3YAJAoL5okG0d2NsdzGQuB0KwmQdxDbAIyDaz
	 d1CjKr/iJoZ3xO8Rv1jlljJuCjQ27UDEldMGaMRaimZVd7Yl15aEYakrApyPh+S0No
	 4ILLI5q1WlYuhu59xR5ZdcsqhY3a+H7/yT+P4v+Y7hkKMxcxZ95C58ttR+6FDS3UeX
	 KHTKJNH3Wa1bcOtoiyoo0w9sUg1NcUjUeSKK47cfxLUfwju1KSUoOYkpHFSmaLm4fM
	 lplERejF/p8C8NimANZ1nqvlCJTbpkb6LvVls7RJG6WJo3BVwiQexirrJd5CV+51Lc
	 OpFRERZu9nxGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADAA380AA62;
	Mon, 20 Jan 2025 12:20:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: phylink: always do a major config when
 attaching a SFP PHY
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173737562974.3509344.14427802136820578133.git-patchwork-notify@kernel.org>
Date: Mon, 20 Jan 2025 12:20:29 +0000
References: <E1tYhxp-001FHf-Ac@rmk-PC.armlinux.org.uk>
In-Reply-To: <E1tYhxp-001FHf-Ac@rmk-PC.armlinux.org.uk>
To: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 17 Jan 2025 08:44:25 +0000 you wrote:
> Background: https://lore.kernel.org/r/20250107123615.161095-1-ericwouds@gmail.com
> 
> Since adding negotiation of in-band capabilities, it is no longer
> sufficient to just look at the MLO_AN_xxx mode and PHY interface to
> decide whether to do a major configuration, since the result now
> depends on the capabilities of the attaching PHY.
> 
> [...]

Here is the summary with links:
  - [net-next] net: phylink: always do a major config when attaching a SFP PHY
    https://git.kernel.org/netdev/net-next/c/af10e092b77a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



