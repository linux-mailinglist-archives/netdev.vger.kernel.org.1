Return-Path: <netdev+bounces-189946-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4523AAB4905
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6112D19E4A5C
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA8D19A2A3;
	Tue, 13 May 2025 01:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxrP//VN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AB7199FA4;
	Tue, 13 May 2025 01:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747101593; cv=none; b=sUNsJq80ecpnMyvKDceZmcn4f8tsPu7n5vQxbwYh0jglP/0qdYjPWoPJGdNe2Q2fvGDmD0r1xbgn9cTI5i1/SiOigZo1jaYl6C398oU9gtvyXby7A6p79IbV5CH7178eI3eC/izgM/XmyYqdiHYfv+a5oWeMUMveqFyvE1aaPQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747101593; c=relaxed/simple;
	bh=IKLpfsU3SJDDrR5HzQvIF9znc20nnNryMt0h6KUIJPs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gM4QFjSupnmPZJJKd2iQku9Cxpulxab6UwGA538Tjvz1BQ0YZkB2O+U2X3oDmkcNjkuOuVd0PLLXoRkf/llM1PWOm9UT8gWM9IkjlV8+MXLuvyyXZPH4AdxH0mm+CXJkp+2RUnhjFBfk5pQEgP4Vnhvrc9XsULGhWWmaZZqI1AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxrP//VN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80F22C4CEEE;
	Tue, 13 May 2025 01:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747101592;
	bh=IKLpfsU3SJDDrR5HzQvIF9znc20nnNryMt0h6KUIJPs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jxrP//VNpHmJrmH0XMTU3V7CXEqoAGhga/FaxxvdsFba2FP/C2NM3qg/JL6L+vaeE
	 ddvm8c/GC0YMOdsECV4cuqYDpF8+fcTw1YZKFPotZq9uo8Nif7qAPo4stH+MyPQEeL
	 xWWE94dsFKg6oYWi2YP74EedvPseSBT5Z5NTbBVvw105xtM6c+vUyyKuBesH4bo3qY
	 xAfY0bDX4+mk+hd1PUJywuB1VoyFMjd7Dxw151sf7SDiwfMtQEd9FrT/j7EU1rVD6I
	 XR9MQ2UYgJ6zlu9sOCsc9fQ4EmMD6GLhWVCDh8y1qtu7ESdlUvIH4YWSr/N7P1rX2e
	 u8DZWcnZBW27Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C5239D60BB;
	Tue, 13 May 2025 02:00:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dsa: sja1105: discard incoming frames in
 BR_STATE_LISTENING
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174710162999.1142511.7206720882789706953.git-patchwork-notify@kernel.org>
Date: Tue, 13 May 2025 02:00:29 +0000
References: <20250509113816.2221992-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250509113816.2221992-1-vladimir.oltean@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  9 May 2025 14:38:16 +0300 you wrote:
> It has been reported that when under a bridge with stp_state=1, the logs
> get spammed with this message:
> 
> [  251.734607] fsl_dpaa2_eth dpni.5 eth0: Couldn't decode source port
> 
> Further debugging shows the following info associated with packets:
> source_port=-1, switch_id=-1, vid=-1, vbid=1
> 
> [...]

Here is the summary with links:
  - [net] net: dsa: sja1105: discard incoming frames in BR_STATE_LISTENING
    https://git.kernel.org/netdev/net/c/498625a8ab2c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



