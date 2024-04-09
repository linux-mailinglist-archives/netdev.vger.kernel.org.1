Return-Path: <netdev+bounces-86086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B89FC89D7C2
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 13:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 729D728401A
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 11:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C108129A9A;
	Tue,  9 Apr 2024 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQFIYBmD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A49128829
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712661628; cv=none; b=QVo0AxXkpUMGDmnvWvOIvauo3xyKZV1FVYDDafOwuGyqyDpewa/0ujugqSiLgM3gp3G7lRBqGPvzcVrECoqO6UX4TBEfRn2R0zr4V2E6TdA1UJiTKHPZ9E1mWkA0+a5dJ6uRVbTBg8mr/bnqO3ztJggyG+F5r155RX/K/kAFaKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712661628; c=relaxed/simple;
	bh=jCrEblhvYVCR+yVLdMATawG53FdXiL8b1M6CzvS6J2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gYu4Rl2RLVd1FpNNstlYdlEVzEY94oHkkbKlh45IATUa7L+7ZAC0lNZa176ZT+6aOSLzYNR8JgmnKI0LG99nNv4mJnJGNwNoOTu4jOCEutel2ijsqj+NJWxoB+mrzsoQ+CiCXSqdwJ9M1cMjkxhdyRezL1bJGO5CQvZa5sL0aZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQFIYBmD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id BFB9AC433B2;
	Tue,  9 Apr 2024 11:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712661627;
	bh=jCrEblhvYVCR+yVLdMATawG53FdXiL8b1M6CzvS6J2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RQFIYBmD7MBtx1bn6EbsSKan9mHvudIZFSikSo1WmCWr3hbV++8TxcbHLcc8lRGM2
	 4Xmq1U4XxYNVc0wL3LcXtfn//AQGc4RJt2FScjoImJQy8wIXT5ripkJkjqSbggdp2R
	 Urnk3oRYELksPEpSEN6ikOAIwz8RW3iCs/+8C47bKWwlJMYtAkT5/+fJI2sq+tssTz
	 EtzUuH6r/GDCTh6shvseHajPejTuHeY2LgTtzh2frtSHApJcy9nF7Cq4/rsxrAvYPY
	 OIEae3oP+EgUppCcWr55P8b3iPH4x6oOWnPH9kv1dTyb9YgUFaLUpGgkxRNrKoxDM0
	 wG6daNMM4elww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B6B97D60310;
	Tue,  9 Apr 2024 11:20:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] tcp: fix ISN selection in TIMEWAIT -> SYN_RECV
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171266162774.18559.17691626397583691711.git-patchwork-notify@kernel.org>
Date: Tue, 09 Apr 2024 11:20:27 +0000
References: <20240407093322.3172088-1-edumazet@google.com>
In-Reply-To: <20240407093322.3172088-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sun,  7 Apr 2024 09:33:20 +0000 you wrote:
> TCP can transform a TIMEWAIT socket into a SYN_RECV one from
> a SYN packet, and the ISN of the SYNACK packet is normally
> generated using TIMEWAIT tw_snd_nxt.
> 
> This SYN packet also bypasses normal checks against listen queue
> being full or not.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] tcp: propagate tcp_tw_isn via an extra parameter to ->route_req()
    https://git.kernel.org/netdev/net-next/c/b9e810405880
  - [net-next,2/2] tcp: replace TCP_SKB_CB(skb)->tcp_tw_isn with a per-cpu field
    https://git.kernel.org/netdev/net-next/c/41eecbd712b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



