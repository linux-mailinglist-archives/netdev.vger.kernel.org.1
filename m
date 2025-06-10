Return-Path: <netdev+bounces-196380-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AADAD46DE
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 01:38:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95583188A39A
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 23:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 913EE26462A;
	Tue, 10 Jun 2025 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jxKsWitF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FFF21D5AF;
	Tue, 10 Jun 2025 23:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749598728; cv=none; b=ilKttZpO7p0Zwqz3lc39phB03l2nJSykA++1Wc2U7XhRfc313DPod8HPPPbMmARgHj5DlWu2zLJTj21G4NH81O36aMLyoIYiCfyiUpxT0dBruXCjDDNXhCKs9pB2cuEMnq93VxYv1UzFQpsXxqBrLMl5KgfPNJNfaX/Oo+fVJ3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749598728; c=relaxed/simple;
	bh=Xv1COulxj/H3qzlfMkLWXzCvl+xGKRo2/ag+ly6hFNA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SZPrpnw/XL8rb/f2LgvKOneOU8+vOU/AO3mUp+y/T86qligYl0/pNLsXJZ99IgnDiZMJr3n9UlIEpxu5+UMTjSS7JIMeRIhUztlPpLcBOLJvsig2RvOpcmxM5NX8l3pK3bc8dpktSBwMr8e0OkXvc5IEiL592yzJi7eonj2MEWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jxKsWitF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF66BC4CEED;
	Tue, 10 Jun 2025 23:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749598727;
	bh=Xv1COulxj/H3qzlfMkLWXzCvl+xGKRo2/ag+ly6hFNA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jxKsWitF+g1w2FKzbhRDs7BiQ30A8Un9lgGe/92hSwzFpxsdRfTPXxC103XJT91R5
	 S3zcEy4f/z7pf495cCuPoQe6KhWaLb+bv1GtE6vAHfuKjopRlZhhX+l9m+CjFzZoo/
	 7oUw93Ej/jP+aShF8Rzu4BU5JLny8sF+8dQU4R6TXukvt7C32LvqSMZ2YstmR1ZrM5
	 QsiFXYftmXyaaxKVu1X8xJhqptQq/mTdE379V4u4ty1XHEbHzVMyhfSd01oW5K4lRo
	 rvktR6DRKpc80rsyTWAYF2RI76UBouxbFdoESu4EG8A1bf4ofT0uNoN9eEnbv6Zezx
	 MnarqkIUbPsnw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CDA38111E3;
	Tue, 10 Jun 2025 23:39:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: Fix TOCTOU issue in sk_is_readable()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174959875824.2630805.6484746062998707951.git-patchwork-notify@kernel.org>
Date: Tue, 10 Jun 2025 23:39:18 +0000
References: <20250609-skisreadable-toctou-v1-1-d0dfb2d62c37@rbox.co>
In-Reply-To: <20250609-skisreadable-toctou-v1-1-d0dfb2d62c37@rbox.co>
To: Michal Luczaj <mhal@rbox.co>
Cc: edumazet@google.com, kuniyu@amazon.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 daniel@iogearbox.net, john.fastabend@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jakub@cloudflare.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 09 Jun 2025 19:08:03 +0200 you wrote:
> sk->sk_prot->sock_is_readable is a valid function pointer when sk resides
> in a sockmap. After the last sk_psock_put() (which usually happens when
> socket is removed from sockmap), sk->sk_prot gets restored and
> sk->sk_prot->sock_is_readable becomes NULL.
> 
> This makes sk_is_readable() racy, if the value of sk->sk_prot is reloaded
> after the initial check. Which in turn may lead to a null pointer
> dereference.
> 
> [...]

Here is the summary with links:
  - [net] net: Fix TOCTOU issue in sk_is_readable()
    https://git.kernel.org/netdev/net/c/2660a544fdc0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



