Return-Path: <netdev+bounces-207912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C369B08FE7
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 16:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 795F51C43B15
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 14:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE09C2FA620;
	Thu, 17 Jul 2025 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZwcY1CzA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963112F94BB;
	Thu, 17 Jul 2025 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752763811; cv=none; b=avTCUk1jYM0OO1boLNHpPeQwuVn/95cgscKxD1mhIO0v4kUVd8lDdx4IZoyqZiqwhlZXDqEkNVorA261tC/SIAkjL+lKoTo20nB/Yqop416z32sDEfwo4Vvhz6tf2tVhpWkYNIB2xA5DkUoGzD2jSqMe9MMyYHNR6KyIXcXLgNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752763811; c=relaxed/simple;
	bh=mIgncsRmQiPT7wJ6VbqzaJZYzg6DVLSBFP2f1woV0Ys=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ErQ5AAvaIKekNmQ67dctF0bCFcUwdl0TggH3B//aNeeZzgpGVM4AG/yREmkwfSbUdH9LZXXfbXVRI4R4Q+8MghwnR3YbiEpHEuIhzxRz2E2v6CPg1b0X8K0kESWth25jK46LBrfV90u9PSvhamYKhUcZKkkFwbG/ihOyLmT0U30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZwcY1CzA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E12C4CEE3;
	Thu, 17 Jul 2025 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752763811;
	bh=mIgncsRmQiPT7wJ6VbqzaJZYzg6DVLSBFP2f1woV0Ys=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZwcY1CzAOwKu5adgJxP56GIG6f4LpRYZ/yiyPZ3/g1gmaQP2NuzLBRqN/CxklVZKb
	 gULC3/rq5pnq61WhLUEWBakXZ4Jp8m3Eq6dVumJJAVFwDIz9UJcm1DGHYnuja+JHeY
	 b6QseCt9R+mjIDnpsyhFYotSzlvRlqgz4f1oZXkOzFdnRIPVTsAWuvOuUF08gS4Qei
	 0J+8RWGPGmGQPExDT6PSw60zbkC5xWokv33j5Nwm55rLrRINa5w6FkLx1Vv6zmzpYP
	 DCF5SDUlmNkAXRG1czddebhnpTDYOiQnwIEtbMB+ER4tywnsGNllakd358XtjM7wp/
	 P4smLzX38Cjmw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70C93383BF47;
	Thu, 17 Jul 2025 14:50:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3] virtio-net: fix recursived rtnl_lock() during
 probe()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175276383099.1959085.14014268800421819820.git-patchwork-notify@kernel.org>
Date: Thu, 17 Jul 2025 14:50:30 +0000
References: <20250716115717.1472430-1-zuozhijie@bytedance.com>
In-Reply-To: <20250716115717.1472430-1-zuozhijie@bytedance.com>
To: Zigit Zo <zuozhijie@bytedance.com>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 andrew+netdev@lunn.ch, edumazet@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 16 Jul 2025 19:57:17 +0800 you wrote:
> The deadlock appears in a stack trace like:
> 
>   virtnet_probe()
>     rtnl_lock()
>     virtio_config_changed_work()
>       netdev_notify_peers()
>         rtnl_lock()
> 
> [...]

Here is the summary with links:
  - [net,v3] virtio-net: fix recursived rtnl_lock() during probe()
    https://git.kernel.org/netdev/net/c/be5dcaed694e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



