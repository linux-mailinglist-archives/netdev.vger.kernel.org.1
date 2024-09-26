Return-Path: <netdev+bounces-129895-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C244986F0F
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 10:40:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7B01C21D76
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 08:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0053F192586;
	Thu, 26 Sep 2024 08:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JILST6sV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6FF01D5ACF;
	Thu, 26 Sep 2024 08:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727340026; cv=none; b=DrI7WOq3vYBbP9cv6jdbF/8SWqg9oe1Nanms7NwuZ6p4iD0/pSM5iERg6VvEisTDgy72yIwShKaaR407oTjh2njEm3ICPQR7RJwgSBzm1XogDb2lTB3PdsogrtjwDN94ZNF2T/Cf9n9Sj/M3q2qlYulxFowVkX8SSiO8nvvjQbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727340026; c=relaxed/simple;
	bh=8fKuojIqG7VsB8xtQHySZBizhSj5QA4EWJvut5NY8fA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VkKa3fXlCuG5FWVll/GI2wSwlGzvhXMAPaYM5spZyTHpWjhB2zoXngtdfJeS33DcjHO5e59Esgrc6Xd8HgsBCICEBEWYpX1dnlLleSSihUknfB1ZCleBC5bkMS2i8fr1e7q3vJXOhLuYR+SsCUdctAHCdegf2HYjx+1PjiDq22k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JILST6sV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BC47C4CEC5;
	Thu, 26 Sep 2024 08:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727340026;
	bh=8fKuojIqG7VsB8xtQHySZBizhSj5QA4EWJvut5NY8fA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JILST6sVkdOuIRAEHc/WZHD5Df9Vsyg1nqVO9WXehZ1AtvTLhapHbfqPweJbG7k6G
	 wcMQvvzoBgvIc4phCfEa7QbdE7Diyy3xTzfSjkTdzjWetL89RKkYGS0XU4Dhyk0SLY
	 0HOUZ8m1TQ66UZky9As9yApaCGfhHnNBbgAMsSy1oZ9cAIha35E7Qjlym+vFLKFcw9
	 AOPDoc/PcyJC7uc7O6AW+60vyovlC62Bg4C1rmI1nnu+Xuk9v/DHn4hqaZwtx4bDHd
	 YZmUrueTVqkHVtw4/gUBEMIv2MfIJQCIrvuigh3vag5PWKklfb/WReIZGJgX06FDSc
	 nNKFv+e5Xe4Uw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF9E380DBF5;
	Thu, 26 Sep 2024 08:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [RESEND PATCH v3] virtio_net: Fix mismatched buf address when
 unmapping for small packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172734002882.1169779.6595635289409412002.git-patchwork-notify@kernel.org>
Date: Thu, 26 Sep 2024 08:40:28 +0000
References: <20240919081351.51772-1-liwenbo.martin@bytedance.com>
In-Reply-To: <20240919081351.51772-1-liwenbo.martin@bytedance.com>
To: Wenbo Li <liwenbo.martin@bytedance.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, virtualization@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 cenjiahui@bytedance.com, fangying.tommy@bytedance.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Sep 2024 16:13:51 +0800 you wrote:
> Currently, the virtio-net driver will perform a pre-dma-mapping for
> small or mergeable RX buffer. But for small packets, a mismatched address
> without VIRTNET_RX_PAD and xdp_headroom is used for unmapping.
> 
> That will result in unsynchronized buffers when SWIOTLB is enabled, for
> example, when running as a TDX guest.
> 
> [...]

Here is the summary with links:
  - [RESEND,v3] virtio_net: Fix mismatched buf address when unmapping for small packets
    https://git.kernel.org/netdev/net/c/c11a49d58ad2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



