Return-Path: <netdev+bounces-96351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 518328C5613
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 14:40:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08B6B1F21B64
	for <lists+netdev@lfdr.de>; Tue, 14 May 2024 12:40:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87E2C6E60F;
	Tue, 14 May 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmamt7X6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C2756DCE3;
	Tue, 14 May 2024 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690429; cv=none; b=cGCzgqFs86e5MlAN/20QVGAcxVSugLfe12+oRxj9rWe/TraQMlsqb9A1emXVqS65fPHSBAjtVNKqXboX4l1Kq1GM+2b7PZD1omFcYYw7lu70WRyIbevNrJKxHs73aBVU5lLhAwZAo/033qp3yMSCCtKiUOGvPDOWYAgI7gACZz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690429; c=relaxed/simple;
	bh=T9Ltzm8KKpY7+v7syaJKnm9A1DzbhS7LgReD1pOSZ6k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EMULd9yUuX08hV1yJ/jl4Cw7chwtGraTHuXCE+p8lOdWHmGG8Q8nH3F0UfyeMX1yeI3hAabwm9/Q/AniGbfor0fJyx2Wb1JU56nqUIKnA5RTYC00IfI5YxUXH+ieeDQ5ZRB+cYR84XackfOpJj/Fxnzdf5IkL3bK6Dh9/Ifgc00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmamt7X6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFFF8C32781;
	Tue, 14 May 2024 12:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715690428;
	bh=T9Ltzm8KKpY7+v7syaJKnm9A1DzbhS7LgReD1pOSZ6k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rmamt7X6n5jefVglSoMHsi8NJVDg+DY3c1AV1ZBR0oOZ//kuUulkxnz9eoBVh1x/H
	 e0eArBlPoxFE8Fmu/jKZN4P0n+g3lHuUHtLm2i1bAjkO1wAd54HWchztmKoYXOgl3z
	 f/wQlfDal8zYkgaWWNXOxcFDGdypGXENX71JL+Go/VPB6lKqj5SPztYSuQcBsG6vTE
	 /1vixt5YTiMHewUGPyzF+RQRYlBgfYyo66HhHxSkoCIkjRFXoW/H/3uxMk30aCJi77
	 5EegKpd7LoZVriZj6MjVC99bMoqTuwoVyCrtgGeufq4hAP7csLXUKXpcQozGyAtNHg
	 KFPklutMOld/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B843CC43339;
	Tue, 14 May 2024 12:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: micrel: Fix receiving the timestamp in the frame for
 lan8841
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171569042875.21890.7113805948748540771.git-patchwork-notify@kernel.org>
Date: Tue, 14 May 2024 12:40:28 +0000
References: <20240513192157.3917664-1-horatiu.vultur@microchip.com>
In-Reply-To: <20240513192157.3917664-1-horatiu.vultur@microchip.com>
To: Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 13 May 2024 21:21:57 +0200 you wrote:
> The blamed commit started to use the ptp workqueue to get the second
> part of the timestamp. And when the port was set down, then this
> workqueue is stopped. But if the config option NETWORK_PHY_TIMESTAMPING
> is not enabled, then the ptp_clock is not initialized so then it would
> crash when it would try to access the delayed work.
> So then basically by setting up and then down the port, it would crash.
> The fix consists in checking if the ptp_clock is initialized and only
> then cancel the delayed work.
> 
> [...]

Here is the summary with links:
  - [net] net: micrel: Fix receiving the timestamp in the frame for lan8841
    https://git.kernel.org/netdev/net/c/aea27a92a41d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



