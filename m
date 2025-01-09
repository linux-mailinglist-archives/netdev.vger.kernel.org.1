Return-Path: <netdev+bounces-156868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3953CA08161
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 21:30:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6763A7E7A
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 20:30:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AA71FECB4;
	Thu,  9 Jan 2025 20:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ROrEyRrl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 509F11FCFDF
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 20:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736454614; cv=none; b=VXquuj/WVJkLcgXxB00TLn10oHIHhlRCJW3d2Nm+cEj+tXjlVR3le01dNbnBvAaL+4vshovOWfUm+FvppXi5IcRxvdY7c4M86Qw/Tk2q4q57KPkCZ6CtqUPQ5LzoreG5yUVjiGnAdAgiDw1AL6MD0516ljU1pl6FErecABfOUnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736454614; c=relaxed/simple;
	bh=FZdBK+1vpoMkAlA/mBRJrKXu+wqxuYTqwioI4nQU9h0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=m3zPt40l8xBSDjXq85+D4s8V9v2cVEAN4/Hg+zQhN5TZTbCGwXy2g3GKgd6dRPijyPGUsWR0VPnCTcSc9MArXHriTzYBQsF727IXcnDaL0WLNRxpGwd9oXrjGTumIQ4kZ/XtAONhJvKqNm8wbHqSGz+p39hTkIUiVzYc6lX0hRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ROrEyRrl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0315C4CED2;
	Thu,  9 Jan 2025 20:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736454613;
	bh=FZdBK+1vpoMkAlA/mBRJrKXu+wqxuYTqwioI4nQU9h0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ROrEyRrlDttljOvs8grpX6HKtm29pdbHQC9C/AnAbe/1DAk3i5Q4xycnAwf+StKea
	 iDescvNbw3ui1Yc+9BiXhdVuQhGWfUU6Wh673FSvQptbtB3drgTnQb2v1BaX5BDoP3
	 RR25wU5BgAoNVuq5YU54Lst2hkkTkpjwOoJCVK0+8re2DGWD3rDx4e3YsJON3Cc/Xi
	 OAdKfgjdS6GgfDqv6w0sG7NDHTv0hqvjabChkgJX6V+7BeLWHdqzYPq8FU3OVTCUhZ
	 YsuOt111zB+ILev5kP5K6VShzL4vSfIyCClD9DSmQpOdvngrSza9JRWi4eUhR09eUy
	 qR7yeQDCbPpHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE286380A97F;
	Thu,  9 Jan 2025 20:30:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/3] enic: Set link speed only after link up
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173645463550.1501437.6990217324562459979.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 20:30:35 +0000
References: <20250107214159.18807-1-johndale@cisco.com>
In-Reply-To: <20250107214159.18807-1-johndale@cisco.com>
To: John Daley <johndale@cisco.com>
Cc: benve@cisco.com, satishkh@cisco.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  7 Jan 2025 13:41:56 -0800 you wrote:
> This is a scaled down patch set that only contains the independent
> link speed fixes which was part of the patch set titled:
>     enic: Use Page Pool API for receiving packets
> 
> Signed-off-by: John Daley <johndale@cisco.com>
> 
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/3] enic: Move RX coalescing set function
    https://git.kernel.org/netdev/net-next/c/af2ccc6908f7
  - [net-next,v2,2/3] enic: Obtain the Link speed only after the link comes up
    https://git.kernel.org/netdev/net-next/c/238d77d110f7
  - [net-next,v2,3/3] enic: Fix typo in comment in table indexed by link speed
    https://git.kernel.org/netdev/net-next/c/8e0644e5398b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



