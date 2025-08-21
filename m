Return-Path: <netdev+bounces-215450-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE58B2EB32
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 04:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D06895A85AD
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 02:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B48C2561B9;
	Thu, 21 Aug 2025 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SLG46SE2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53162255F3C;
	Thu, 21 Aug 2025 02:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755743406; cv=none; b=AxEBzS0ucG7Qr5bm9gSODvHsCrO5RWmSV1Y8xkYPOcDEz5P2PPPedwRWxQKr6XnkZlvgAdMM7kQdHDzGwy/NYp7TJ8XVrf3Ubehc1ZSXfgTi3KtZAZu/BHK6JwjtdgJJ1X5ucq+rHOy57k9EpfrrfmXrjzhzM4jShrqQnlgkTe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755743406; c=relaxed/simple;
	bh=vtxbRxJa9c4U1HtStAqXq2jJHGIiw9dYmM0a4sVQKy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pLQ1Za94VLaWLqnBSBQuKElH7f3qD6OaWriQleENL8MZCL92nK0vyA26hMzOg4ZnXwiqav6j7JcKG1US/gQTGNC2dd8qxB5UrKEVtiVC5Rj6ovu1Yq4R43Q00KpZSsKCKftuUBvbQsrdpIYzfGf0dLUoluFC4lMX3n7mFT3Gjpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SLG46SE2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF21CC19424;
	Thu, 21 Aug 2025 02:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755743406;
	bh=vtxbRxJa9c4U1HtStAqXq2jJHGIiw9dYmM0a4sVQKy8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SLG46SE2kZyN+Q2emboUI5XQCTIYTsF+PCltz5c1H912bo2uEFScD/qcgljOkc/ia
	 k6EIifIwxSvW1L7a0FK3jcmF4nLcFtZc81pTJfBnbhUDXmvikoIaRAZ8TX0OnJEtfh
	 7QbUzqzsa3YhlZNwSTxwEwQ5F3RRESr00xmJzhyo8AVnuZGdDQwoHBEPdoUQFlQjTT
	 CHxTTLaIM+SkGi5ihMXOSLv830iWfge4cpOTW3bH/MnHUBUCFvAK40haTpaTEZWE1U
	 3IRXV0n0blUQUyRiNNqo+FoTVAP8ndV6gX2yoY/GlezbKggG0DUjn3MGMLe/g1PwAq
	 aO1epDzBleL2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 94786383BF4E;
	Thu, 21 Aug 2025 02:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5] net: avoid one loop iteration in
 __skb_splice_bits
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175574341524.480425.3327622284691937497.git-patchwork-notify@kernel.org>
Date: Thu, 21 Aug 2025 02:30:15 +0000
References: <20250819021551.8361-1-hept.hept.hept@gmail.com>
In-Reply-To: <20250819021551.8361-1-hept.hept.hept@gmail.com>
To: Pengtao He <hept.hept.hept@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, willemb@google.com,
 almasrymina@google.com, kerneljasonxing@gmail.com, mhal@rbox.co,
 ebiggers@google.com, aleksander.lobakin@intel.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 19 Aug 2025 10:15:51 +0800 you wrote:
> If *len is equal to 0 at the beginning of __splice_segment
> it returns true directly. But when decreasing *len from
> a positive number to 0 in __splice_segment, it returns false.
> The __skb_splice_bits needs to call __splice_segment again.
> 
> Recheck *len if it changes, return true in time.
> Reduce unnecessary calls to __splice_segment.
> 
> [...]

Here is the summary with links:
  - [net-next,v5] net: avoid one loop iteration in __skb_splice_bits
    https://git.kernel.org/netdev/net-next/c/8f2c72f2252c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



