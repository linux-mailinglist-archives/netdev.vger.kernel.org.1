Return-Path: <netdev+bounces-124202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6DD9687E3
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:50:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5D81EB21D6B
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6558019C555;
	Mon,  2 Sep 2024 12:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p+J4ej3n"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D60B2570;
	Mon,  2 Sep 2024 12:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725281427; cv=none; b=Ardz5khKj7xVSsTsq/5dUQY0TJJpMFvkKhUGeotJHjBrmwD6i99V+YYHPOda+7tA8i8kQFayMFLaD2gTgnDpSv4NHfeXLnFVv4cJsxGHcpt0gZtsJvvS1dm36yGk7qMKMynHHKmWJtmGz1ei/feBP7gwEyMDOSHwWftvlJ84Bmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725281427; c=relaxed/simple;
	bh=gSSyow/y/SlSqbX4VOuxPJjKb9gx+BXqg2I1lVC/NNA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NZ0J7bisd4fDjdR20tohqJ3+gP8zYbXHkIn67V+2iPCRO+VZWLpP1DipcDJxgwzpFMlTI7X/Eb4Jgccy48OMHTbLNZlBxJr4huyPoepLyLcSab8cLo9MVWobPJaSbc+tPirmYL3q9Jo6t7tfPUXjXBAJzwTQSYuy7f5/VhYEMjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p+J4ej3n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D53DC4CEC2;
	Mon,  2 Sep 2024 12:50:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725281426;
	bh=gSSyow/y/SlSqbX4VOuxPJjKb9gx+BXqg2I1lVC/NNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p+J4ej3nbbuZ6OvlbrZXXA1GuBPG1BIrKoCjvtj+j/Z+8iZ237JM1yYcJX1Rg/nnH
	 4CxCC4i/Zf2GausECeNH6J92rzJfGQV6PAxaKkTY6E/NCRoM1NsOnHoqcolo6Vc4GA
	 l18mQLtLoh4XAHz6BYd9Vosq23g9dM+c3x+fKAXyioQiwro6gfhEFrYj2bMqNWDE91
	 PIKZME1xIrvbBUIqWPCGcT21mtJXIekMXHmQB6dlKEDciuPpPiheM29ObgASOuNov3
	 moioFZzo1OnSLh1/5me5qvdCPp4HuMxZQjrPDd9TD0yRa6WKPwKNJIFmpRxEEzzkvP
	 zb1/qZ8Sn5DMw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E223805D82;
	Mon,  2 Sep 2024 12:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] igc: Unlock on error in igc_io_resume()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172528142727.3879101.4427744206513284824.git-patchwork-notify@kernel.org>
Date: Mon, 02 Sep 2024 12:50:27 +0000
References: <64a982d3-a2f5-4ef7-ad75-61f6bb1fae24@stanley.mountain>
In-Reply-To: <64a982d3-a2f5-4ef7-ad75-61f6bb1fae24@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: sasha.neftin@intel.com, anthony.l.nguyen@intel.com,
 przemyslaw.kitszel@intel.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Aug 2024 22:22:45 +0300 you wrote:
> Call rtnl_unlock() on this error path, before returning.
> 
> Fixes: bc23aa949aeb ("igc: Add pcie error handler support")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/net/ethernet/intel/igc/igc_main.c | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - [net] igc: Unlock on error in igc_io_resume()
    https://git.kernel.org/netdev/net/c/ef4a99a0164e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



