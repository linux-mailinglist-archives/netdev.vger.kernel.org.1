Return-Path: <netdev+bounces-211433-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 66CFFB189EA
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 02:29:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5640C4E037E
	for <lists+netdev@lfdr.de>; Sat,  2 Aug 2025 00:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414D718B12;
	Sat,  2 Aug 2025 00:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKiK/08z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D2551863E
	for <netdev@vger.kernel.org>; Sat,  2 Aug 2025 00:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754094594; cv=none; b=MfWTkpgBL1E9E/ZI8250xs1MSjjwN6Fq529LIMrqZHvNQDYE/rb1lu08+wJPrJYjphNbKqylwaIGJP28gCrfEkY2m863pe4JLMkwr4y4p+gmv7/PUhuDgmkfGRQSgFAgvFXhPT+T0rVilMzlaoDlSh+JdSH3+1Hksd/LmDKTEgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754094594; c=relaxed/simple;
	bh=fyIr+XcF5FRn+OGNBTwxxIEjam6ZlXp45VY8TwxGr2k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=vDos1WFjIxQSMBL7VH2szlxwzWoN3XjF/Wr01a/IX3IA2ouqMaw1rWo3gvHtXIzwRQbUI8WkbAsPPJiEAjBbJqf7QeFK4vKxtzyO+e8TZeVcuHHzYha2hDzCWUN8+i4bws0W7bytT0ZbGVCQkCAWfTf7vo7+rQhyPfgsE0+eD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKiK/08z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B45EEC4CEEB;
	Sat,  2 Aug 2025 00:29:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754094593;
	bh=fyIr+XcF5FRn+OGNBTwxxIEjam6ZlXp45VY8TwxGr2k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TKiK/08zm/Wrz6HpPEeBT8nZrYPEsYddrskrKpNB4kqE3YdZLauJ2n47qbKK8oLKZ
	 0MZVU8fqcsXOF18/Thz4lHrmKTxuo/Jsg7HydX5DOL53KSY3AhrltEQrVNQbLjh5Lx
	 g6Qw9liKAQ/YbFaiHjKkQVtk1KNsCUa1v2DMLUEqSiujm6+f6NgLAlSTiF5dVBeaXm
	 DM8EpsI9vlyquT88kXFLCkA4ILsQMHQF8Q0pMyXr2u99Ndbc+ECO5CT4dD8A3NlDHW
	 kPHfioh93crcuPV4QRHFowPubGpQnO8oWG9CaVByUV3B0axP13E3PO2wBgMPtU0doD
	 7KUBq9917hJJQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33BF5383BF56;
	Sat,  2 Aug 2025 00:30:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3] net: Add locking to protect skb->dev access in
 ip_output
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175409460901.4171186.6246045058515205139.git-patchwork-notify@kernel.org>
Date: Sat, 02 Aug 2025 00:30:09 +0000
References: <20250730105118.GA26100@hu-sharathv-hyd.qualcomm.com>
In-Reply-To: <20250730105118.GA26100@hu-sharathv-hyd.qualcomm.com>
To: Sharath Chandra Vurukala <quic_sharathv@quicinc.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 quic_kapandey@quicinc.com, quic_subashab@quicinc.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 30 Jul 2025 16:21:18 +0530 you wrote:
> In ip_output() skb->dev is updated from the skb_dst(skb)->dev
> this can become invalid when the interface is unregistered and freed,
> 
> Introduced new skb_dst_dev_rcu() function to be used instead of
> skb_dst_dev() within rcu_locks in ip_output.This will ensure that
> all the skb's associated with the dev being deregistered will
> be transnmitted out first, before freeing the dev.
> 
> [...]

Here is the summary with links:
  - [v3] net: Add locking to protect skb->dev access in ip_output
    https://git.kernel.org/netdev/net/c/1dbf1d590d10

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



