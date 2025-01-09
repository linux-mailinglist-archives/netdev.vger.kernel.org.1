Return-Path: <netdev+bounces-156655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD9D0A0743B
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 12:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5341886E16
	for <lists+netdev@lfdr.de>; Thu,  9 Jan 2025 11:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E908A215F55;
	Thu,  9 Jan 2025 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="czjLaIjZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF04F1714D7;
	Thu,  9 Jan 2025 11:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736421010; cv=none; b=EAz6zGvOzqh1+C1JD/PcwgPCVhYDjqEYKibFE/s/HUxrjImcKUIJRi4nP3NOg/r/4//gMRiHHOXagkamUA2W7WTvouIRQ6pH2GnmNAxsxO2sZSRdOpSAdBgeSJ7AgcZu2l7+SC0b2p0Ln+Gm7nkTjtwORaQAYEx3YwMiKjTT7vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736421010; c=relaxed/simple;
	bh=TBEVsOoPldXZwQh7tAdbmVwyDSgmW78wARuRAkczgPY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=K0FYui7na6gZy2Cw4IR9xYxKVlAN9ZtSbyQHTdbBFlf1fdqqIPTG2SvVwJYOdJy/bjJJ3HK+vKo/xuKd7q71Qq3DZAn785umAEcrUXcfVv1tuoRLzjucswwm0pLVYk/zJ4L1PS9/6D/R/GmlDqDsKpwfA59tEUf14t/3KemkPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=czjLaIjZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B5DFC4CED2;
	Thu,  9 Jan 2025 11:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736421010;
	bh=TBEVsOoPldXZwQh7tAdbmVwyDSgmW78wARuRAkczgPY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=czjLaIjZpYJ5M5V3cVXXIFF60YpZ83Mz0YXkF5cHVpLSNHzW+FwgjT4cdJ1TGLMio
	 dOixNqfv00kSf5ABcwlsOGNS5Nz7kzkvXS0anfiAlG1Qf0GKbwQPFEoZLPoHh0k/wU
	 XBpFeSt9id8Xa9kDn0YBaIvBxWd8OLZTfT4GQ77TQQsLCc3zoQGgsc6G+kyJocPboi
	 tvmZhXpTnb0Z0O5AFQ3EOm7VKB/nZC4UaCXNiSsU+Ue3FSTlmZiERBMivi4ia/A81G
	 RMsuuikLxas+C0wuOn3lABzqm5Ih9RCQ6I1IGKH2ScsZ9NITyke6FYoeDZ7o+Bwi1P
	 4mb3ALf3h71bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CD83805DB2;
	Thu,  9 Jan 2025 11:10:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] mctp i3c: fix MCTP I3C driver multi-thread issue
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173642103231.1282460.4168413665645922160.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 11:10:32 +0000
References: <20250107031529.3296094-1-Leo-Yang@quantatw.com>
In-Reply-To: <20250107031529.3296094-1-Leo-Yang@quantatw.com>
To: Leo Yang <leo.yang.sy0@gmail.com>
Cc: jk@codeconstruct.com.au, matt@codeconstruct.com.au, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Leo-Yang@quantatw.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  7 Jan 2025 11:15:30 +0800 you wrote:
> We found a timeout problem with the pldm command on our system.  The
> reason is that the MCTP-I3C driver has a race condition when receiving
> multiple-packet messages in multi-thread, resulting in a wrong packet
> order problem.
> 
> We identified this problem by adding a debug message to the
> mctp_i3c_read function.
> 
> [...]

Here is the summary with links:
  - [net,v2] mctp i3c: fix MCTP I3C driver multi-thread issue
    https://git.kernel.org/netdev/net/c/2d2d4f60ed26

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



