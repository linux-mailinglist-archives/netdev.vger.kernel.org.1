Return-Path: <netdev+bounces-117632-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF4094EA42
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 11:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBE491C2101A
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 09:50:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB9216DEC8;
	Mon, 12 Aug 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba4LgL+t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C801C3E;
	Mon, 12 Aug 2024 09:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723456228; cv=none; b=PdWm9pzkGP3h/OJA2lfSVj5mufG5AZUQ8k5Dtry9awnLeyi2IEICh+yMkEfG1fIiOx4U1MFYXkrLWeQetuoI5B8Q2B7hr340Sv+caA2qyU/6nbHqvyBPAhQDVAffCfNd0NOd/0ZAnvFFeE6SVZyFt6h742uxHM8cZKg+5Hi+mxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723456228; c=relaxed/simple;
	bh=XxL4Vsi9LNGKGjsvn7yLL4KNrNrqR+iEtSc/LMIdbk8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YRUre1LyT+aHQVmJvglQI34/zN5y43YNDxiAlqIOeUWeV7c11JbfAWDX3rf9wIq3QsSjCFtszvlxUjs25AfZdqxwc3Co8mEpPJZ0XFisBqQ0r61NEda+CLEYq13lv11qoCzKIV1KhFwKMShpa8a4pq5hcokskUXlVpKWztYPfjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba4LgL+t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00CE3C32782;
	Mon, 12 Aug 2024 09:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723456228;
	bh=XxL4Vsi9LNGKGjsvn7yLL4KNrNrqR+iEtSc/LMIdbk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ba4LgL+tHP5MA3I2pfEj4nV0QOhioxZpLeSm1OR3lFD16i6dHhXDuaocIwpkIrQA2
	 IhT25NIQkpWlO/Xw1DnNiqsIKbg20rfWlmuTFhmqLO1Z5laIXlWaz2gz1b/GwuS7Xc
	 nf3XdRZQku6f4ZL9mIMFtYtOcKQW3Le4Ta3lxfx+qWldAhOPB4+QQMWU3jjHIOwjn0
	 EhXRGvpBNJqpLPi5glgJe5hXjyy2OO4vj2EESMBFnjMP2G2TICB5wYYjda/vv0bfQl
	 jWsnwjJm1D/2+tczGg6Iyni7jUUNAkBf9/exKnqpDJziBXmfv3NM3sfJeCuSFnxUD+
	 gEDnt41BfI41w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C07382332D;
	Mon, 12 Aug 2024 09:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-XXX] atm: idt77252: prevent use after free in dequeue_rx()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172345622703.970779.5557015728917315109.git-patchwork-notify@kernel.org>
Date: Mon, 12 Aug 2024 09:50:27 +0000
References: <cd0308ff-fda4-405f-9854-6a3a75680da2@stanley.mountain>
In-Reply-To: <cd0308ff-fda4-405f-9854-6a3a75680da2@stanley.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 9 Aug 2024 15:28:19 +0300 you wrote:
> We can't dereference "skb" after calling vcc->push() because the skb
> is released.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  drivers/atm/idt77252.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net-XXX] atm: idt77252: prevent use after free in dequeue_rx()
    https://git.kernel.org/netdev/net/c/a9a18e8f770c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



