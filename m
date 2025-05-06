Return-Path: <netdev+bounces-188278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F513AABED1
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 11:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DEF7D7B55E9
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 09:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DC5827AC5F;
	Tue,  6 May 2025 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vPJBd/Em"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39DE27AC4C
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 09:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746522590; cv=none; b=Sky3/NrU6ZVpD+YlyY1aX2Xoi+xFh3ZAAkJCxKRI9mtGPSS6hYRxDCXC4XdNka3UrDqcwvYDHdtf5b/zzPQ3Xj4dMIU7UHRHjAo0k2PR/KwDIVaYZNJFbG0gWdk3/xbuPp43M3pNEJ1OkDXR5K2nE4oCxpJ1AiGEgHMKK58mssc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746522590; c=relaxed/simple;
	bh=+uZ3ebpQd0uf+Fpva73iBBmKy0Szo3bRoNQUjWxUk+Y=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YN5Epal8k9CIvjKGnCBATX5x6cmMEov3MggHfxGOG9zM4NzGNv2PhstJlE1O1rCEt3hdus/JSqpOwZyNnOFLT4VBfcE6KgmHt3XTjPITU9OICYCMJTPBONHvA9jUQwNF1Mw9H7LHZzoBoqEzwrxvA0+EWzuHXTIm9AeGjVhrB/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vPJBd/Em; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48E8FC4CEE4;
	Tue,  6 May 2025 09:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746522590;
	bh=+uZ3ebpQd0uf+Fpva73iBBmKy0Szo3bRoNQUjWxUk+Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vPJBd/Emsvr1Dj3RqHh3W5EP7l9mRgVeRdcFc7/rktCg6/X70lCFJw+ytlOvcmL+g
	 eeKHodRag40GLlb9EZ1umR2RaS4plzmdH9SPleHEunANDwbK95U5rYEVgB6mylYRtu
	 sPIyvAi6/LPpx77LT/hgOqyydCGoul0Sli1wN109+v26svyLnbMqKHx9mo9Xx2HNGW
	 kic1iFEru41KC5U7ZV+VcaP39q0XCJTGAYyQAf771FwGBiCZmvsR6qxh9ZJE9E5S1Z
	 XDRLIey6Z09VDH++WNhxKyEw4adY3F5XFB+cjwUyGzcQ4wT49kCzg/Fwe9+J+yAtSq
	 XdYTrZyBiObnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADBE33822D64;
	Tue,  6 May 2025 09:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] eth: fbnic: fix `tx_dropped` counting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174652262949.1103429.1253292957019592008.git-patchwork-notify@kernel.org>
Date: Tue, 06 May 2025 09:10:29 +0000
References: <20250503020145.1868252-1-mohsin.bashr@gmail.com>
In-Reply-To: <20250503020145.1868252-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@fb.com, kuba@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, vadim.fedorenko@linux.dev,
 sdf@fomichev.me

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  2 May 2025 19:01:45 -0700 you wrote:
> Fix the tracking of rtnl_link_stats.tx_dropped. The counter
> `tmi.drop.frames` is being double counted whereas, the counter
> `tti.cm_drop.frames` is being skipped.
> 
> Fixes: f2957147ae7a ("eth: fbnic: add support for TTI HW stats")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mohsin Bashir <mohsin.bashr@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net-next] eth: fbnic: fix `tx_dropped` counting
    https://git.kernel.org/netdev/net-next/c/fbaeb7b0f0ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



