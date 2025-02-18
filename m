Return-Path: <netdev+bounces-167311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84049A39BAB
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 13:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68F6216798C
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 12:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33CE72417E8;
	Tue, 18 Feb 2025 12:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BzFtN0KG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBCD2417EA
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 12:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739880004; cv=none; b=YB3R/maSPlyLpqfZvQ3vovpjCzqwX6UCOwBJ/Md3dSBBLcei1UNVJCXidpbyfsASbea7rKJyVhopoll6uCVW8XTwcmYphzFx925cVD4CJ7rsCJfBrg03D2zqWDUvTsFCrfEy2Li9JlbBGXADm70k73TYv+4BcLZINVsRkveE28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739880004; c=relaxed/simple;
	bh=FYpmzwhW6eS3TLiHqzuXK709wP7NNOETBleFZ14cFNk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BpS3Hh1ZlYKJSUPm1+rmEHjVQchnuvB3dDxusSdrroWM7QaBAtbZQYKVopWlXs7AVgPHZgP6GadS+lnY5x9HXVGtA7R/GiFH2kR/UWDdlVQ+ghBVWjo4gUQxe+ECbTcfgERRUvpwsiMcJc2aPWqQcaK8O9raGiYNQpwRabb04OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BzFtN0KG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB5FBC4CEE2;
	Tue, 18 Feb 2025 12:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739880003;
	bh=FYpmzwhW6eS3TLiHqzuXK709wP7NNOETBleFZ14cFNk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BzFtN0KGuGcLaZToRm6ttCM27PXRiO2LSZovmRYghyKsmBr/D89UX5QMxV3tiwJr7
	 LUNdMSYtZL8Ya2QYt3AsSRwabYGy565hr1Y3Dx2CDn2aghdPVETLdIueByFdP3u66U
	 6cy6TxtZIfwkb1kGhwEAX2X9FxAnCRlnx8kIgRXsOubYuxISViNhvn/DVxxOyLgLRz
	 puNg0HvC/bbIhWxW2lHNZ84DsFEgquz35Mb0vP37T/3vXbcWQEfW9ccj52wljTtIli
	 ZT4+OrnsiRg7HeO1KMNEDCeN++tzVLi14Qw//1NAgGipgWDhkFwn7rHJ4+Gke1YOht
	 pRyOmQjJkxL5Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3529B380AA7E;
	Tue, 18 Feb 2025 12:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] page_pool: avoid infinite loop to schedule
 delayed worker
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173988003404.4060768.8778974121302997728.git-patchwork-notify@kernel.org>
Date: Tue, 18 Feb 2025 12:00:34 +0000
References: <20250214064250.85987-1-kerneljasonxing@gmail.com>
In-Reply-To: <20250214064250.85987-1-kerneljasonxing@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, hawk@kernel.org,
 ilias.apalodimas@linaro.org, almasrymina@google.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 14 Feb 2025 14:42:50 +0800 you wrote:
> We noticed the kworker in page_pool_release_retry() was waken
> up repeatedly and infinitely in production because of the
> buggy driver causing the inflight less than 0 and warning
> us in page_pool_inflight()[1].
> 
> Since the inflight value goes negative, it means we should
> not expect the whole page_pool to get back to work normally.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] page_pool: avoid infinite loop to schedule delayed worker
    https://git.kernel.org/netdev/net-next/c/43130d02baa1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



