Return-Path: <netdev+bounces-156934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089D3A0852E
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 03:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE3561661E4
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 02:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950A31E1C37;
	Fri, 10 Jan 2025 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llYriMYF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7136E1E1A3B
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 02:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736475012; cv=none; b=VabdVQ9uULxhTmpTUmfmTWp4PRlj437I/nqy2cT33Z/Pe0UTbu8rKU4LXMzt3dmWsLcSzf4w1NKvcVD7eIsC05MVOqdUCZk6Y02Z5248xtFDtju/TD4m8dCiZqEY/aeSVc7Pc5uV0vuirmzj7mJkvD8xQjJTHDv9XwyFYptyGJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736475012; c=relaxed/simple;
	bh=mGgZ3O3FpAo4aK2pvb/OrSHlcRbe3wDu2F3zKUWE4pg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WzXsqZ4rE4flL9z2GR2ESUpJtNu+m85BNiuGuRYCCqwPgTcTbtL2LqKX4VPvX9C9bHUjJ5xyZJHbOIwkUp1m7DoBYdtbKeIm1Qqz+UPFRDHyqgfoLpdDok7ZOWnBLnRIIJmuSQ8xxBtJ/AroOULCQgjOQIGvVGvgmNDgSOfxAzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llYriMYF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF408C4CED6;
	Fri, 10 Jan 2025 02:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736475012;
	bh=mGgZ3O3FpAo4aK2pvb/OrSHlcRbe3wDu2F3zKUWE4pg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=llYriMYFb9+mZEMOME5PicltSD7Hq4nSkWmHVnfmlhrKN5VLj1cGzypVgjQgFpq7X
	 cDVbhzoKeXAoObnxlDqs/07gjPa1DFEvR/DbqzqIjmOKQyRescNrL8vYlXGARUJJTk
	 gUUEyQdc71o8EcqLIuIYUwfY+aoioaxIri7kVcCvkhCH186v/ySlQFWyAxTZFVbuU/
	 2gy4YOvQ6CFE7eFjnaotz5Pm+dMME4xwRIm3yMYQk0o7BkL5poMa71CMZlotEsFhnP
	 c8+gjbM5qKW0s4o1P73Tvt9A3MDno3gglV0uvbsIBf1hAjqxFPHv05pKXjDzFSSdRS
	 rmzT5508lK85w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB163380A97F;
	Fri, 10 Jan 2025 02:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ipv4: route: fix drop reason being overridden in
 ip_route_input_slow
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173647503349.1577336.15772137245517453680.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jan 2025 02:10:33 +0000
References: <20250108165725.404564-1-atenart@kernel.org>
In-Reply-To: <20250108165725.404564-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, sd@queasysnail.net,
 menglong8.dong@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Jan 2025 17:57:15 +0100 you wrote:
> When jumping to 'martian_destination' a drop reason is always set but
> that label falls-through the 'e_nobufs' one, overriding the value.
> 
> The behavior was introduced by the mentioned commit. The logic went
> from,
> 
> 	goto martian_destination;
> 	...
>   martian_destination:
> 	...
>   e_inval:
> 	err = -EINVAL;
> 	goto out;
>   e_nobufs:
> 	err = -ENOBUFS;
> 	goto out;
> 
> [...]

Here is the summary with links:
  - [net] ipv4: route: fix drop reason being overridden in ip_route_input_slow
    https://git.kernel.org/netdev/net/c/8c7a6efc017e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



