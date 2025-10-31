Return-Path: <netdev+bounces-234781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8DFC27338
	for <lists+netdev@lfdr.de>; Sat, 01 Nov 2025 00:40:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1ECE425754
	for <lists+netdev@lfdr.de>; Fri, 31 Oct 2025 23:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A398232C92B;
	Fri, 31 Oct 2025 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXpX2rk/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF4A28C035;
	Fri, 31 Oct 2025 23:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761954032; cv=none; b=EP2wsfb1r8zMsLnzihZepAb8Vu5nQzUJ944Ues6DTyXEIj5tVgpphW6pTBfxAVXM/i2QHBYC9o6NaPwBlSB6FJErfVS38E6TIVR0ML2UZH/EU/tOVxz5I09otZbNLzJm+AvwJypAM3lnXESQByxmBnsefmQYTT+HFhZG74v5Olk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761954032; c=relaxed/simple;
	bh=iRtSZ7zL0H9H5g7iOI85zP3EeIrUjPJgSfsG3lDnm3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KE2Xl0tQ+dM6DXh6JlwR/bLI3fLF7mcQlovcbzvscHwbjc3JGYZYTyx9ulbUZHo5vNnAVcwGrBbctiokQenNanOPnF8Biqky2OMhdbZPOAcRYqW6ChShuTcu7G/9Gy3juOlldLy1nKtrEhAiwbTU8ZbDQtwcLnFBmpqQZVGQhLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXpX2rk/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A67C4CEE7;
	Fri, 31 Oct 2025 23:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761954032;
	bh=iRtSZ7zL0H9H5g7iOI85zP3EeIrUjPJgSfsG3lDnm3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nXpX2rk/c24VABCUCjJBksjoYgl41xVyrZvR9kpdbEd3fq1SH0mXhnfXsJHCDiRZ9
	 5aIvTF+RwSAc1O3W86419Xs2WjLMspvSolwVpYhff2WVe816WSBDPYuAlADzvIxebc
	 y+3jF1MkEk/unOLCRMglhVQHy7Je63zbIKBFyD0qgdTS0RLUPtQgzxcN5/SufaiJqN
	 cETNzXjsqSn+4gIOTUa4/TD77miE6EKhvcL4stz3ABFrv4yXfsA5rlYI7DAaPOceDP
	 KZEBsFVPmzVBPHC7wHUaE7kuKSQ229wuP9ASYfatwbB5zjRRpvas6t0/zIj3ghHlsj
	 a4/fVqXoUAGCw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33DAF3809A00;
	Fri, 31 Oct 2025 23:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ptp: Allow exposing cycles only for clocks with
 free-running counter
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176195400801.668400.2169789432642664862.git-patchwork-notify@kernel.org>
Date: Fri, 31 Oct 2025 23:40:08 +0000
References: <20251029083813.2276997-1-cjubran@nvidia.com>
In-Reply-To: <20251029083813.2276997-1-cjubran@nvidia.com>
To: Carolina Jubran <cjubran@nvidia.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, dtatulea@nvidia.com,
 tariqt@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 29 Oct 2025 10:38:13 +0200 you wrote:
> The PTP core falls back to gettimex64 and getcrosststamp when
> getcycles64 or getcyclesx64 are not implemented. This causes the CYCLES
> ioctls to retrieve PHC real time instead of free-running cycles.
> 
> Reject PTP_SYS_OFFSET_{PRECISE,EXTENDED}_CYCLES for clocks without
> free-running counter support since the result would represent PHC real
> time and system time rather than cycles and system time.
> 
> [...]

Here is the summary with links:
  - [net] ptp: Allow exposing cycles only for clocks with free-running counter
    https://git.kernel.org/netdev/net/c/5a89b27afd3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



