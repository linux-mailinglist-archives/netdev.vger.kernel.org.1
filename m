Return-Path: <netdev+bounces-158742-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97D3BA131C5
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 04:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EA03A1A39
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 03:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618021422D8;
	Thu, 16 Jan 2025 03:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="md5hpGY5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91E4A01
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736998227; cv=none; b=Q8c6bm4gEuJpjn9SvXOEm4bEG4G8enUqkdOY8vAioeWiekH8/I3Vo37x5BXmygKQMq7cjmMss19IlYTvohJR8u/zdFaceMVyjJRrEukGGejWLyEIuDoS3XkY+r+SOLlBHd6lO5h5j0SHgydH/PaLXMgm/E28yQ9w7ina0C/eSDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736998227; c=relaxed/simple;
	bh=IHxRdULekdmgm1574RmE9F4/iZR38MD6SfZd+iMoHVc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MRyhO1R34JF9eBUIJJnZlt6/p2agG/uCJJLkOvccHr1CmNz5Bds+Ynl5vLcx0bsbiCSU5kbDpXFBvkFRkhfTz/JQiQdt6u5n/rmhejQrRUxU0IM+kL5zYklSXe9EQHxiFEkBie8JbQBUPbcg8rpeSweGCJ8CGbcId7EancICz/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=md5hpGY5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC696C4CED1;
	Thu, 16 Jan 2025 03:30:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736998226;
	bh=IHxRdULekdmgm1574RmE9F4/iZR38MD6SfZd+iMoHVc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=md5hpGY58FtvLlUDJE/C+mHuL96M+LQiJVuk/aU1jMEJCcdmlbswKfC+VSLjye9kq
	 LqKPRRwZZEGqcCAEXXWPVBQEit84IeYDBuaQbURcSVRxtvYO7EpbILQxzxQeHmWkI+
	 iI7zkRs9Oud4Ah3OM28GqnMN/xp4WBzzCIGF84vZBB6kFUs03SlnUQ6FSoSX7seu86
	 2QP5IFzTnx5BqVSPb4GCApT8ijt6H+k68szlevzeFXqkOoLaqbxHf8CznvDCNHBsmh
	 lCMsWd8LLwUueJV8OKKGi8QH5AXFGOTNM8sJMt3tslPnUSnT/h+iJY+0HBGbtNkUGo
	 PLRZAVAaijOAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAC18380AA5F;
	Thu, 16 Jan 2025 03:30:50 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 00/11] net: use netdev->lock to protect NAPI
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173699824954.995574.4787633907849052839.git-patchwork-notify@kernel.org>
Date: Thu, 16 Jan 2025 03:30:49 +0000
References: <20250115035319.559603-1-kuba@kernel.org>
In-Reply-To: <20250115035319.559603-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 jdamato@fastly.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Jan 2025 19:53:08 -0800 you wrote:
> We recently added a lock member to struct net_device, with a vague
> plan to start using it to protect netdev-local state, removing
> the need to take rtnl_lock for new configuration APIs.
> 
> Lay some groundwork and use this lock for protecting NAPI APIs.
> 
> v2:
>  - reorder patches 2 and 3
>  - add missing READ_ONCE()
>  - fix up the kdoc to please Sphinx / htmldocs
>  - use napi_disabled_locked() in via-velocity
>  - update the comment on dev_isalive()
> v1: https://lore.kernel.org/20250114035118.110297-1-kuba@kernel.org
> 
> [...]

Here is the summary with links:
  - [net-next,v2,01/11] net: add netdev_lock() / netdev_unlock() helpers
    (no matching commit)
  - [net-next,v2,02/11] net: make netdev_lock() protect netdev->reg_state
    https://git.kernel.org/netdev/net-next/c/5fda3f35349b
  - [net-next,v2,03/11] net: add helpers for lookup and walking netdevs under netdev_lock()
    (no matching commit)
  - [net-next,v2,04/11] net: add netdev->up protected by netdev_lock()
    (no matching commit)
  - [net-next,v2,05/11] net: protect netdev->napi_list with netdev_lock()
    (no matching commit)
  - [net-next,v2,06/11] net: protect NAPI enablement with netdev_lock()
    (no matching commit)
  - [net-next,v2,07/11] net: make netdev netlink ops hold netdev_lock()
    (no matching commit)
  - [net-next,v2,08/11] net: protect threaded status of NAPI with netdev_lock()
    https://git.kernel.org/netdev/net-next/c/1bb86cf8f44b
  - [net-next,v2,09/11] net: protect napi->irq with netdev_lock()
    https://git.kernel.org/netdev/net-next/c/53ed30800d3f
  - [net-next,v2,10/11] net: protect NAPI config fields with netdev_lock()
    https://git.kernel.org/netdev/net-next/c/e7ed2ba757bf
  - [net-next,v2,11/11] netdev-genl: remove rtnl_lock protection from NAPI ops
    https://git.kernel.org/netdev/net-next/c/062e78917222

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



