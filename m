Return-Path: <netdev+bounces-179200-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD49A7B1F6
	for <lists+netdev@lfdr.de>; Fri,  4 Apr 2025 00:20:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5AF81788EC
	for <lists+netdev@lfdr.de>; Thu,  3 Apr 2025 22:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35EDE161320;
	Thu,  3 Apr 2025 22:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tP7VcZTX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAD51B041E
	for <netdev@vger.kernel.org>; Thu,  3 Apr 2025 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743718797; cv=none; b=lYCD/wp6YW1dEHXNAZ4pXwNdZpUp6zeyPf/rq/9U80coOHByB8BD1B4HN1IOcmNOWqj3CaFDVOabAfTwHkyUPEK3NIBQKD0a/pg49mHGP72qz6QKosOw6trFT1vWlXojgwOGRzyjA7nzMOJBz0SCxjkqYuyuuMbBwBGEZq/Ftg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743718797; c=relaxed/simple;
	bh=QR5pgGMEpQS2CQxNurDMn1z8FfHf2/L2O+GfAK33Hno=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RKaPGQwfAMJ+c1JRzXHWb1/oAUxho+4gXtFSpAMhUQlM4go1NBfKQaZqWls3VzQu3o4PsZXlIF6WL+1yjJJct4hcXTaKFQJhTcjm/IUSUmnXGSAQNqEPm7u4UY6NdJ5vacWA0kf5EiAlRDGfXAT+nIBPhj+IGDsUbSi8xNPqf/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tP7VcZTX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 807D8C4CEEB;
	Thu,  3 Apr 2025 22:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743718796;
	bh=QR5pgGMEpQS2CQxNurDMn1z8FfHf2/L2O+GfAK33Hno=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tP7VcZTXmBgRV++xaNuqXuHAtryGvpP3KdfdKii0NpNaIGl02ErMk5LmpzDVUNLc+
	 6fN5kRQQeb7YGv7PySdDl+Tk5cO7C0FsX87aMTenGiqWruXqDCLxr2Znj0M1oAvXoA
	 Y4okXDkHUNl0N2/cJ+y0sEw4VUdqDkT2vSH6Y02qv+4qOA4geQrgnJrXmrxlgZI8TW
	 NnGfeqdYtwlJ9YnrjZeEbIkQih0mIS28yfE4I6EuKlRSuA9vlAq36dm+JmBNsDCT6T
	 DkxfVpcA+LUQ6DRqTA3wHleu+x2Sv1w7sjhPux+xIyVUezw41USQZFHRrURovdBR1j
	 9a8T+BnfSAY5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE60D380664C;
	Thu,  3 Apr 2025 22:20:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] eth: bnxt: fix deadlock in the mgmt_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174371883349.2702664.15781720542984639119.git-patchwork-notify@kernel.org>
Date: Thu, 03 Apr 2025 22:20:33 +0000
References: <20250402133123.840173-1-ap420073@gmail.com>
In-Reply-To: <20250402133123.840173-1-ap420073@gmail.com>
To: Taehee Yoo <ap420073@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, horms@kernel.org,
 michael.chan@broadcom.com, pavan.chebbi@broadcom.com, netdev@vger.kernel.org,
 romieu@fr.zoreil.com, kuniyu@amazon.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  2 Apr 2025 13:31:23 +0000 you wrote:
> When queue is being reset, callbacks of mgmt_ops are called by
> netdev_nl_bind_rx_doit().
> The netdev_nl_bind_rx_doit() first acquires netdev_lock() and then calls
> callbacks.
> So, mgmt_ops callbacks should not acquire netdev_lock() internaly.
> 
> The bnxt_queue_{start | stop}() calls napi_{enable | disable}() but they
> internally acquire netdev_lock().
> So, deadlock occurs.
> 
> [...]

Here is the summary with links:
  - [net] eth: bnxt: fix deadlock in the mgmt_ops
    https://git.kernel.org/netdev/net/c/e4546c6498c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



