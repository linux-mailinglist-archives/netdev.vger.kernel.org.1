Return-Path: <netdev+bounces-239772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B8FC6C513
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 03:01:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 596932B967
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 02:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915BE2744F;
	Wed, 19 Nov 2025 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AMP0te8w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BA233FFD
	for <netdev@vger.kernel.org>; Wed, 19 Nov 2025 02:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763517658; cv=none; b=b/21+41Dy1C8oD76Rppb1SfpvUJK+hlwzXCrSmUfzVSvFpsQrLcs9KBg+f/VV5hmhlDMbb/sot1260Pcb2fVfXhwiRaL8aZQIh08ZxA45VYNHFfMVXeZtTZVdvCbT91l+8MsrWykgjo5una+uQ0XpVpaO3+T72J8yYO9mz8Q3k8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763517658; c=relaxed/simple;
	bh=HDtpRbLQyUbCmFsvHuoAZUQESiDVzhTbWIFVyTxD7Ds=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZvHLpE31mk4i4hLbqMeoyljFL7NZrknXC3ULdf0hDzrjRvjhRyWn8OuI3o2LMOukSHemCgjPD7yPelMTPxjSMQkJezU3hck3iSNHi6qM3/CSNk/BLjROTPPIt4ZZGNubHGAR6x6hFAho/xd39woBJPT8d2qllU9Gby7ldJpqJds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AMP0te8w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E84DC2BCB3;
	Wed, 19 Nov 2025 02:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763517657;
	bh=HDtpRbLQyUbCmFsvHuoAZUQESiDVzhTbWIFVyTxD7Ds=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=AMP0te8wLoLcichwXDMv6yPRKNIsH8+J4L1aK9SnRnBk0LowCrGYLrSJzYYugxEw1
	 iGWtBBNDf2+CdGSr0MGArF+HWS3plfySdKXVB3lcECBtiU0CRZ/FpVlWVFkQnNb5Fr
	 eBoeuEx8wCWQjNvyAoNSGURCeAXEWXChgoKt7/JgN8a7Bv8f8zjMVW/wx3MW5wvLAA
	 Ou+pCcyYymVFv7qwNgDYevRCGTmCourJLX8SBvft2/7gpnrhUM3ffYeY5FGMukLda6
	 0rw6Nwg1peZLPhTsHsLB4Ag1621leFca6l9IlqWpWbPMlpkaoqe0SM4kPtb8SzbmRI
	 GKZ6WdvYuOcnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34212380A94B;
	Wed, 19 Nov 2025 02:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 01/12] xfrm: Refactor xfrm_input lock to reduce contention
 with RSS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176351762276.179988.15923196543192487658.git-patchwork-notify@kernel.org>
Date: Wed, 19 Nov 2025 02:00:22 +0000
References: <20251118092610.2223552-2-steffen.klassert@secunet.com>
In-Reply-To: <20251118092610.2223552-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Tue, 18 Nov 2025 10:25:38 +0100 you wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> With newer NICs like mlx5 supporting RSS for IPsec crypto offload,
> packets for a single Security Association (SA) are scattered across
> multiple CPU cores for parallel processing. The xfrm_state spinlock
> (x->lock) is held for each packet during xfrm processing.
> 
> [...]

Here is the summary with links:
  - [01/12] xfrm: Refactor xfrm_input lock to reduce contention with RSS
    https://git.kernel.org/netdev/net-next/c/10a118619439
  - [02/12] xfrm: Skip redundant replay recheck for the hardware offload path
    https://git.kernel.org/netdev/net-next/c/b427c0c3bc40
  - [03/12] pfkey: Deprecate pfkey
    https://git.kernel.org/netdev/net-next/c/6b3b6e59c4f8
  - [04/12] Documentation: xfrm_device: Wrap iproute2 snippets in literal code block
    https://git.kernel.org/netdev/net-next/c/68ec5df1d894
  - [05/12] Documentation: xfrm_device: Use numbered list for offloading steps
    https://git.kernel.org/netdev/net-next/c/340e2a738665
  - [06/12] Documentation: xfrm_device: Separate hardware offload sublists
    https://git.kernel.org/netdev/net-next/c/840188d276a3
  - [07/12] Documentation: xfrm_sync: Properly reindent list text
    https://git.kernel.org/netdev/net-next/c/a397b259c173
  - [08/12] Documentation: xfrm_sync: Trim excess section heading characters
    https://git.kernel.org/netdev/net-next/c/01ad7831fbb2
  - [09/12] Documentation: xfrm_sysctl: Trim trailing colon in section heading
    https://git.kernel.org/netdev/net-next/c/c08b786b8295
  - [10/12] Documentation: xfrm_sync: Number the fifth section
    https://git.kernel.org/netdev/net-next/c/7276e7ae569b
  - [11/12] net: Move XFRM documentation into its own subdirectory
    https://git.kernel.org/netdev/net-next/c/03e23b18c720
  - [12/12] MAINTAINERS: Add entry for XFRM documentation
    https://git.kernel.org/netdev/net-next/c/939ba8c5b81c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



