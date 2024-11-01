Return-Path: <netdev+bounces-140879-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D07E9B88B3
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F0DC1C21D85
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E63755896;
	Fri,  1 Nov 2024 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRaAHE4R"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794703F9CC
	for <netdev@vger.kernel.org>; Fri,  1 Nov 2024 01:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730425224; cv=none; b=Kwa2ASMvxmxjhMbFp3+i9vN3R3HsFVlxSdYkWeOvSrmcXeTpG7obhKzCnqYYrNvvx6q7LT/ikbepMOEvXZ33u5jPMn/ZQJhwleOMWRF6AGiYuNUmwN2xzwZih8uQDKRNGq6u8n92eLKZpCNPVVoEdfo4Maa5q3CtajDyoSC06yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730425224; c=relaxed/simple;
	bh=ioeJdYCa+/n34L0YCTIWGg+C9GFh7WHowgKWKXNIy/M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qb+bmtxJ4XDEkaYJZGFQff0wDR352L9JKSfuGO28+dSntNNV358p7XoUMmLfxzqEuGYTnh2TVc8HQGEr7LCwvSkbernad26XoS9Bsvby2jjxLao1lRcZ98AlpK7nvTVXxJ1d4iHxhLpsRxwaq/kXVSc2Q88CaG8o5ze31ekpAw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRaAHE4R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A49C4CEC3;
	Fri,  1 Nov 2024 01:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730425224;
	bh=ioeJdYCa+/n34L0YCTIWGg+C9GFh7WHowgKWKXNIy/M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XRaAHE4R2nt5Mcc4Y3HLV9JZleSK130H5USoVTz4i5AdD6tdZVLR7Qp7xzpt1K4vU
	 IsufGYj4LwvMicftuQyv+IIWi+8O5Ve7aZn6rF7OiUJIWYhctGtOhasbCH3SxGwWdF
	 gy57GVGfvQRG8wo5ezvGEaWzgLeOUsDz4Hk6kQS5R7hlq0KYh1h1XVAXBCkEHYXOJK
	 1GhXYJ164Rg5oV+ctT+/xMlvRNUxkEz7Btz94dP2lCFTTeLnyO7eE5ny/MeA92FaT3
	 RMRvpXJB+nRoOmNPdjPe2rljE2T1LfWqMMK31k2L7OZRzVRyTeYyLpN2l5Br+MzmYh
	 MsCgiM6ne9W2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CA0380AC02;
	Fri,  1 Nov 2024 01:40:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: only release congestion control if it has been
 initialized
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173042523201.2147711.1857098885103384242.git-patchwork-notify@kernel.org>
Date: Fri, 01 Nov 2024 01:40:32 +0000
References: <1729845944-6003-1-git-send-email-yangpc@wangsu.com>
In-Reply-To: <1729845944-6003-1-git-send-email-yangpc@wangsu.com>
To: Pengcheng Yang <yangpc@wangsu.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Oct 2024 16:45:44 +0800 you wrote:
> Currently, when cleaning up congestion control, we always call the
> release regardless of whether it has been initialized. There is no
> need to release when closing TCP_LISTEN and TCP_CLOSE (close
> immediately after socket()).
> 
> In this case, tcp_cdg calls kfree(NULL) in release without causing
> an exception, but for some customized ca, this could lead to
> unexpected exceptions. We need to ensure that init and release are
> called in pairs.
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: only release congestion control if it has been initialized
    https://git.kernel.org/netdev/net-next/c/cf44bd08cdee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



