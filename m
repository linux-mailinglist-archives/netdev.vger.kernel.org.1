Return-Path: <netdev+bounces-199550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 546A7AE0ABC
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:41:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC7153B63F9
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CFA28BAAE;
	Thu, 19 Jun 2025 15:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rN+er3uH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E281F28BAA2
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 15:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750347596; cv=none; b=BFkbyk+r27JAgjtL4+WonhQyRqPrqzJSs6OrAmD4ZAsr6nOUlbU+15LpBoswG8+62r0vReuaT2ebyr0US074x4X2OCiUyMaatRCbsYS9pTy7QvLNwXraOA/5StmG5MY10VHvnR9jfWZ86F48gcQagl+Si7T9BVhHiYyXCVbAnLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750347596; c=relaxed/simple;
	bh=9NIr982SPehPHm5UZKu1HsS0cw66KpT9Whi9I7Daedg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G8B1b101ZITiU07w5+LzADrttOS70/O5Flf3pfztQjh4eDJLSHPDeiX4KxYy1dqq/Q0/bpz388wWNv/0xyUGXL857ZOKCKtccE+/Vn1bDK36LZjus6QoFzgwnJ1AVGDg3kOYkco/7JW2Qj9QJe1j3il9MGouw3CGGd5cVnpCL1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rN+er3uH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65311C4CEEA;
	Thu, 19 Jun 2025 15:39:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750347595;
	bh=9NIr982SPehPHm5UZKu1HsS0cw66KpT9Whi9I7Daedg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rN+er3uH/K5wKYqrl60uKWF/yPYDREVI2Ufgh/VL9iCN8zRl9Iz/20Wdq/aagcDEy
	 CffqNygL++tXXOevQvuhHjUVeMKrgsI0kPrR0wudFtyALYOkULWCr9K51XuuhfvFiG
	 VtHzRK4ZoJsEpFW6kTurfpWC88S9fewaMAw13fp4XByN7ZYN4xEvl1YyJEplYIketm
	 L37Ti7QT/wKf04pzDCAR9oZKpWBZJSHneQfBOVZiBKkDLHUbkPUrMuAv1dQupRj9rp
	 +6r81NOhJYHr0hoENtHmKjr3PYRt9vrW220Ia9HWF9yhTC4vKBkPzKKlY8b17gv3X7
	 imURBaXjEGXkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADB9B38111DD;
	Thu, 19 Jun 2025 15:40:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tools: ynl: fix mixing ops and notifications on one
 socket
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175034762324.906129.14974313774441183886.git-patchwork-notify@kernel.org>
Date: Thu, 19 Jun 2025 15:40:23 +0000
References: <20250618171746.1201403-1-kuba@kernel.org>
In-Reply-To: <20250618171746.1201403-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, arkadiusz.kubalewski@intel.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 18 Jun 2025 10:17:46 -0700 you wrote:
> The multi message support loosened the connection between the request
> and response handling, as we can now submit multiple requests before
> we start processing responses. Passing the attr set to NlMsgs decoding
> no longer makes sense (if it ever did), attr set may differ message
> by messsage. Isolate the part of decoding responsible for attr-set
> specific interpretation and call it once we identified the correct op.
> 
> [...]

Here is the summary with links:
  - [net] tools: ynl: fix mixing ops and notifications on one socket
    https://git.kernel.org/netdev/net/c/9738280aae59

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



