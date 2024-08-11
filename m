Return-Path: <netdev+bounces-117504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EC1194E236
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 18:13:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22EA71F214CA
	for <lists+netdev@lfdr.de>; Sun, 11 Aug 2024 16:13:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5C641537C8;
	Sun, 11 Aug 2024 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VbBcCSR7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04591537C1;
	Sun, 11 Aug 2024 16:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723392773; cv=none; b=GRz2kC0Gkh6/YNArfRMO/s0iMCoxgHiSvBSMyiGBCnzg6h1wk4ZNYtv/MobA8ILxGm1YburKTFlfCujguaL8CiK3VLxP3HQJgHoeZ1tYhXog2rTizbIccvPpq0khBWMtkAZWo5eRVvf1WS5V1tSA7e8a8vOXITLu5qQD7M5H7Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723392773; c=relaxed/simple;
	bh=a1yavlMnKfaDPotHDRtJo4N06L9Y99avbyuMHoWQ1Xw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IStZPG3+gft++hwFXYR+u2OI7biRkY0TWiqNTAZmgRm6VIlpvR/b46zlVAfx7/8k3Sz6FOpZsBQG4q47Zr7x4eWtLPaMB09p39LE966fCYv4eTCydWfQvKSb7/yYaMm1RRfpSt1R9w6cpyhYKkuLKJemdH+DEEgyovhLZ8jBE9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VbBcCSR7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAACC4AF0F;
	Sun, 11 Aug 2024 16:12:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723392773;
	bh=a1yavlMnKfaDPotHDRtJo4N06L9Y99avbyuMHoWQ1Xw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VbBcCSR7Gct2omkANH/yNsgUuC/laI1XdERVzg521zZBEMfuYdGXnhVrPVAkwDocL
	 XIS3DwFb2L8iD18DiyPEID8uv9go49jmkWb51iaqvVsul5vhRwiT8uYYO8HaYD0vNt
	 KIZO9KMpn94VTAdTNshCHBDg2/vsVHOjjIAOBDgsVAfgENiMdXK3cu2dMZakrGOjaC
	 +J4y+cMy4TxysFpweZiisyS+srgjCs+/Ryb2CDUMjkC+tF9fEIdIgCjQctGktDfIVW
	 GZI2mOJJDV5/wo96gsxQREZgmavML00YqHMJJ0fyu8ro8et+VinqQkY566WvTs2Wgl
	 tDutVqbysCxLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE0D53823358;
	Sun, 11 Aug 2024 16:12:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH PARTIAL RESEND 0/2] net: mvpp2: rework child node/port
 removal handling
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172339277224.219113.856744133717562309.git-patchwork-notify@kernel.org>
Date: Sun, 11 Aug 2024 16:12:52 +0000
References: <20240808-mvpp2_child_nodes-v1-0-19f854dd669d@gmail.com>
In-Reply-To: <20240808-mvpp2_child_nodes-v1-0-19f854dd669d@gmail.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: marcin.s.wojtas@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Jonathan.Cameron@huawei.com

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 08 Aug 2024 11:47:31 +0200 you wrote:
> These two patches used to be part of another series [1] that did not
> apply to the networking tree without conflicts. This is therefore just a
> partial resend with no code modifications, just rebased onto net/main.
> 
> Link: https://lore.kernel.org/all/20240806181026.5fe7f777@kernel.org/ [1]
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> 
> [...]

Here is the summary with links:
  - [PARTIAL,RESEND,1/2] net: mvpp2: use port_count to remove ports
    https://git.kernel.org/netdev/net-next/c/e81d00a6b3b7
  - [PARTIAL,RESEND,2/2] net: mvpp2: use device_for_each_child_node() to access device child nodes
    https://git.kernel.org/netdev/net-next/c/a7b32744475c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



