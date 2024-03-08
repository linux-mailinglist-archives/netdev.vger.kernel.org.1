Return-Path: <netdev+bounces-78849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08672876C55
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 22:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A2031C216E7
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 21:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EF105FB87;
	Fri,  8 Mar 2024 21:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cmPMrqD9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE225F848
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 21:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709932836; cv=none; b=FYUE6t8ktatVz2+9Pd5gshfh4JTxnUQ3hgnHIuJ/oIwAJ8hQENF9uBLIpRBQL9S/O/DTHDd1Ed3LCFJKcMAWVviPIbvI/o52odmMBShXrXnZ4sVQTCpC11BlyLodW20lkflt+lkJEgJG9FNUP4UShVdw3mhQXXPngBZ14K4HJyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709932836; c=relaxed/simple;
	bh=IFBsjYfaX09iVzj3pob0+jxcFw5/MKeuMqXUeo2zOQo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FXRjCtgKZAyzggoOFTcBF/fIs8g+UWmDU/raoyrQPsAcjdRuWQummzRR8Pk7TSToRDPuLE7bo/TFn/nGos17fVXSYpyEQtdDZqOLa75qmqJKqoZv8pBq5DwWgEbcaewCGURzM7J7TyFmYLg8OUIOqfyHEHMfZAmNFjQm4iTOccE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cmPMrqD9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 972EBC43399;
	Fri,  8 Mar 2024 21:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709932835;
	bh=IFBsjYfaX09iVzj3pob0+jxcFw5/MKeuMqXUeo2zOQo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cmPMrqD9Ywul6F75VyRvgzSfoSTRGD/udPfBvZurr6dTOyaJJSSmtC+exGSkj9C/6
	 gpBsaPcVo9Wi+GJpK2BxngqcA2m7OeBUBx33daY2Nmz0W2ZdX4/GDWpyMmODHTR/QT
	 8HiAtFhFQ7rwR3W8cUDwWe9YV5Cz8vdaRxFfwJ4/8w4gYqyXlE3uiOLHWqA3dK2HmV
	 PpHN2GH6gN4wZpr5Y2wtB+uz7ZqW0h+PEdOzOknPbQ/HbAeRUv7lPfxMMv6bn9rZvS
	 UkJft8nt2nq1Y68+IEEDE2++5FqaWnCSMXzUBX7iOgOUpBkDT8AJzfslplCYinWAAU
	 0UfjIpupDc+2g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78E94D84BBF;
	Fri,  8 Mar 2024 21:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv4: raw: check sk->sk_rcvbuf earlier
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170993283549.29743.17146187918109006314.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 21:20:35 +0000
References: <20240307163020.2524409-1-edumazet@google.com>
In-Reply-To: <20240307163020.2524409-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  7 Mar 2024 16:30:20 +0000 you wrote:
> There is no point cloning an skb and having to free the clone
> if the receive queue of the raw socket is full.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/ipv4/raw.c | 7 +++++++
>  1 file changed, 7 insertions(+)

Here is the summary with links:
  - [net-next] ipv4: raw: check sk->sk_rcvbuf earlier
    https://git.kernel.org/netdev/net-next/c/d721812aa875

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



