Return-Path: <netdev+bounces-167554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7715AA3ACF4
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 01:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51DF01733FE
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 00:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4414C6D;
	Wed, 19 Feb 2025 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8Njok14"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B66E04690
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739923815; cv=none; b=sl4X9veb152btdUZxs2Yv6VYfZRwKTeQdES93LNiRDnTgHy3KifA3ELVpMNd1kCbI7rv1swbaFbYKpdneXVUHqwL1HhTb1SHuhEWABUGaKsBXsVrWf5jdx3tUoD24REC4fcacsOr0asKcPGeauo2ev0FKXLNnn0S6P3XubLyoyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739923815; c=relaxed/simple;
	bh=YwRHAPyqrsXrJLl99Rtqk+Wm/8rNf0I57yfZKvDZNbc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PfjIEooHilcX9zIIz+dAS2TqGeogD0R8cfG6T2a2jqRh+T3xp7UbEIz8KDzTNDJdyDjdrL+7lCR7kbWK5HlXGo+Eq+T0Xoe5xbyrZspITV5eFH6k4cyAby0PwHItZaDFlC6QZpx+xKVcT/rDKSoDBCFmielMSrgsPqRuGFIu0FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8Njok14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 149FDC4CEE2;
	Wed, 19 Feb 2025 00:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739923815;
	bh=YwRHAPyqrsXrJLl99Rtqk+Wm/8rNf0I57yfZKvDZNbc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C8Njok14tDNwHxPCt65INLhQfg737VGrbP7OFShDl4/8AoRQmr2sK0tYCC1SPNssv
	 +tNqjrziD+nB+UzP8ULwZ9mEZDIDVkJi5J8cVKPFrU4X12bDuUN4CaqZhlB+hfqH6q
	 22pIbYxM0ej14ZIEvt7yTIom35Tqq9AvgW1C5jaq5DnAllkpqa1aCoQa7CY2Gv4Qcb
	 5JqO7yky7L0PQUGtIWc2YG8TL9pbg8rV9TM/Mv11mulpfeX5wXQLLmdbbsWxFZQY1x
	 P6Z5WLdLZe2AzW11UQmRrq4vafa47PeTlLlXW5EMFlxII4eM1dyQsNdMzl55l8OEVe
	 fXvktDqRLGYhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE4B8380AAE9;
	Wed, 19 Feb 2025 00:10:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: adjust rcvq_space after updating scaling ratio
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173992384549.72368.8058032840496083519.git-patchwork-notify@kernel.org>
Date: Wed, 19 Feb 2025 00:10:45 +0000
References: <20250217232905.3162187-1-kuba@kernel.org>
In-Reply-To: <20250217232905.3162187-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, netdev@vger.kernel.org, davem@davemloft.net,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 ncardwell@google.com, kuniyu@amazon.com, hli@netflix.com,
 quic_stranche@quicinc.com, quic_subashab@quicinc.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 17 Feb 2025 15:29:05 -0800 you wrote:
> Since commit under Fixes we set the window clamp in accordance
> to newly measured rcvbuf scaling_ratio. If the scaling_ratio
> decreased significantly we may put ourselves in a situation
> where windows become smaller than rcvq_space, preventing
> tcp_rcv_space_adjust() from increasing rcvbuf.
> 
> The significant decrease of scaling_ratio is far more likely
> since commit 697a6c8cec03 ("tcp: increase the default TCP scaling ratio"),
> which increased the "default" scaling ratio from ~30% to 50%.
> 
> [...]

Here is the summary with links:
  - [net] tcp: adjust rcvq_space after updating scaling ratio
    https://git.kernel.org/netdev/net/c/f5da7c45188e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



