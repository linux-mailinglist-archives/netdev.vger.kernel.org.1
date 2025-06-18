Return-Path: <netdev+bounces-198862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27B62ADE0E2
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 04:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D60CE7AADEC
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 01:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64EAA19D065;
	Wed, 18 Jun 2025 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axtFYhcY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D80C19A288
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750212003; cv=none; b=ebMMQMuHDoCAkJeY/kPyZmg3XqW2OijsgGgPW07t1C0zBusx9m/vf/DJaW6GCO6Y1CtwyA1KuJFKkAkFRBYjRA8B5YVj5rZ7+M6e/GRcVi3P8mGwATIlCJDS8ko4tF0CVxRs14XCDPrVjaOobpwaUYoffHxdJ71iu8QLEk5hbVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750212003; c=relaxed/simple;
	bh=HQj4u+341AZDmXWpq42j6/1M5K+udoLjmPO5aCRKSIc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r60z3ZU8ctZrz0RhdhtihmVqU5U5aWz9ydUUwO9L1yTUPKg0LJFso8v5TR4fS+IqGs/3L1ATVqTZaiChp/4OPSgf6bnAZVwvXDoiVD7jhgxOnJG5KBpdBr0q0bWOxQPo+Oz0uADQ9ga/X/uZZGulaHTWnpgwU7K7NwVnSjnxvS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axtFYhcY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E30C4CEE3;
	Wed, 18 Jun 2025 02:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750212002;
	bh=HQj4u+341AZDmXWpq42j6/1M5K+udoLjmPO5aCRKSIc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=axtFYhcYypxqruLyNw+pIdumZmF2RPApmM3oKf7+AUMNTxrdN49SBTA9iriwtsp9Z
	 8tmbVNvk9kh6caVKxZTsCDkhEddLQj9wnC6tkeZYDYHSCxqUZABhacTz2g53Io/Cir
	 9+Ry9ef5M0yP967seOFzbvN8EfwKpJzHRmHKYQBr+RuXkP3ZzHyQZBUXuYQ0+zlDLx
	 P2AJFt2C6cyv2nKWqIQ/6IdT3IPaMetmPm41eQX/PzIqgsWrtf/CDU5G05JfJZ8Wxg
	 N4zycZulILqdDK3ui9J2HG/i8JmIt8WUjJ1Z+Lrkg+zPpml++zVZJAeLA0OQOviJ8Y
	 edcy+jaI49E2Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70D6738111DD;
	Wed, 18 Jun 2025 02:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net 0/2] atm: Fix uninit and mem accounting leak in
 vcc_sendmsg().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175021203125.3767386.1752981211365774302.git-patchwork-notify@kernel.org>
Date: Wed, 18 Jun 2025 02:00:31 +0000
References: <20250616182147.963333-1-kuni1840@gmail.com>
In-Reply-To: <20250616182147.963333-1-kuni1840@gmail.com>
To: Kuniyuki Iwashima <kuni1840@gmail.com>
Cc: 3chas3@gmail.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, linux-atm-general@lists.sourceforge.net

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Jun 2025 11:21:13 -0700 you wrote:
> From: Kuniyuki Iwashima <kuniyu@google.com>
> 
> Patch 1 fixes uninit issue reported by KMSAN, and patch 2 fixes
> another issue found by Simon Horman during review for v1 patch.
> 
> 
> Changes:
>   v2:
>     * Add patch 2
>     * Patch 1: reuse "done:" label
> 
> [...]

Here is the summary with links:
  - [v2,net,1/2] atm: atmtcp: Free invalid length skb in atmtcp_c_send().
    https://git.kernel.org/netdev/net/c/2f370ae1fb63
  - [v2,net,2/2] atm: Revert atm_account_tx() if copy_from_iter_full() fails.
    https://git.kernel.org/netdev/net/c/7851263998d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



