Return-Path: <netdev+bounces-172682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE250A55AFC
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 00:40:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B583B3F28
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 23:40:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABB0C27F4C6;
	Thu,  6 Mar 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkwaRcsC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF5827F4C0;
	Thu,  6 Mar 2025 23:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741304406; cv=none; b=MRZfbDHIb1To7BYIa/Ett7wrnly/kmvn4IaWyArKHINeG43h0KtMW4L0/ApkgDVH+qJ3b39dvaHhBfJaX4gBssurYuwgAPpQ8mXRbCoCwvKSTzNTqA5p+mTwBT5u6OGXJ90FSNtO62fK7H2p2NKFwCtl86fLbtOZzhebdlQhbFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741304406; c=relaxed/simple;
	bh=W+oqHt95+2TtTv6AjpAQ30OPLNFmFUSbnwvRFo1Hios=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o/7g+M9N70Sl1R1ykr8LTfo+EABKIDZdjCMF42DKJ+/jWRgL/tfAcZFhNIRvfhR1eAdHkpvjdFC7cYBa/JFUx8L5KItMGeO2nHDvvwo8OjEU7wEeiRuzgeO9jRgL2lvwhQeSf/wkHbhuAf2wPEmUriWN3K+Vq3e1pL6YlQynUQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkwaRcsC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7298C4CEEA;
	Thu,  6 Mar 2025 23:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741304405;
	bh=W+oqHt95+2TtTv6AjpAQ30OPLNFmFUSbnwvRFo1Hios=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GkwaRcsC6wpBseXbhgyEheU0UCvy7K5b5AsiuA89fyy9FK6BoSSbNTbdiacSPjpbe
	 0QtiLZLp60jaka5DF3caXVu2pzIW2KEsS4FEiOQsuIQXSUzhYau6gfDY4rqxhYcF/d
	 3UliTyTmxaBdBF0r471n0RcL7hUAWUtv30RqAFXmG/+VfpNkYup+Gr1t5LUTBA9tWG
	 vuqOvBExXYJbWTJzKp9LbTeJx2NtXEHpi6YCFw4B1DxskiEvkwrGTC713TJjcDEa4s
	 LmQRn4/VDJCXKfQdVkhM2xohkR7cGMgLNK6gF4vgn6GdXgg5qP0ElLvjZ1DDBiMLwl
	 GiOk5BcxfJJZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7110A380CFF6;
	Thu,  6 Mar 2025 23:40:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tcp: clamp window like before the cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174130443900.1819102.16980549477458193974.git-patchwork-notify@kernel.org>
Date: Thu, 06 Mar 2025 23:40:39 +0000
References: <20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org>
In-Reply-To: <20250305-net-next-fix-tcp-win-clamp-v1-1-12afb705d34e@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, edumazet@google.com, ncardwell@google.com,
 kuniyu@amazon.com, davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 05 Mar 2025 15:49:48 +0100 you wrote:
> A recent cleanup changed the behaviour of tcp_set_window_clamp(). This
> looks unintentional, and affects MPTCP selftests, e.g. some tests
> re-establishing a connection after a disconnect are now unstable.
> 
> Before the cleanup, this operation was done:
> 
>   new_rcv_ssthresh = min(tp->rcv_wnd, new_window_clamp);
>   tp->rcv_ssthresh = max(new_rcv_ssthresh, tp->rcv_ssthresh);
> 
> [...]

Here is the summary with links:
  - [net-next] tcp: clamp window like before the cleanup
    https://git.kernel.org/netdev/net-next/c/8e0e8bef4841

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



