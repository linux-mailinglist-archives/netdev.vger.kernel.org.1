Return-Path: <netdev+bounces-138199-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 028939AC93C
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 13:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6BD62828ED
	for <lists+netdev@lfdr.de>; Wed, 23 Oct 2024 11:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43AE41AB51B;
	Wed, 23 Oct 2024 11:40:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="faAQHqMy"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F89D1AB517
	for <netdev@vger.kernel.org>; Wed, 23 Oct 2024 11:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683625; cv=none; b=i1axWupAdlMFaLiWre0Svy5Ri68BxV++W9Je4nEQIAUl5h0Og9MSsX1/WsDuh4IYhOkHLoJWr3XV/uPnHgSCMdgCqFY5TW5+dWT31t3AC2ukrJP5DaCzsfRI5SxtWgcb9jx2swNCm8pc+bS9MGSJugVhnnH1N3r26THnBFVUyAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683625; c=relaxed/simple;
	bh=4HVfTkyYITbqSXazdHRNGm63X030Eg55Fh2JGE+/2Us=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=uBLMXmH7KCozRwUs8lejPv/WJkxq7YK4x+6I3ecq67vS8lluGIum4Uo7I7owxC4OrRL5VoZxz76KDwLdF0VGZd0KA1AEdOhj4x+TcXx4tkC8/MmHr1K0fCSyYfOJSZuBzqrjOOgEY+V0tMZJIHV8Lrkpr8DjQ+QGsR9C/WbKu4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=faAQHqMy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CFE1C4CEC6;
	Wed, 23 Oct 2024 11:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729683624;
	bh=4HVfTkyYITbqSXazdHRNGm63X030Eg55Fh2JGE+/2Us=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=faAQHqMy905OCUbJcJJslWOGqxzMun1GAXnXhLTVEzvFhC0W6Q4nStCkFg4oYPezk
	 zYyZJTZTTgTW8gg/+drPGRCQbsenrW20VswmTdfgXo588c+vtFyXIdqKzpzblwHbiv
	 fn0ZLowcC7R+UqGEy35UkbgirHw3RXi7AX4wpehIYZ+69mnsmq9wNgkbwq2fA3Elzv
	 1EKLmk0anzWLrTnekPJ8qxYomG7phuMMhROP/EpukR2tfYOpxboRPPtrMEMAa3FxIP
	 65DSOGrcDb7KFE/WHmRNF0d7aK/IT98hQhKHXMLcbkyDikNrthg6vfEUbwQRXkjlfS
	 635FFt4UL3RFA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33AE33809A8A;
	Wed, 23 Oct 2024 11:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: netdev_tx_sent_queue() small optimization
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172968363074.1572492.6926126616050672797.git-patchwork-notify@kernel.org>
Date: Wed, 23 Oct 2024 11:40:30 +0000
References: <20241018052310.2612084-1-edumazet@google.com>
In-Reply-To: <20241018052310.2612084-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Oct 2024 05:23:10 +0000 you wrote:
> Change smp_mb() imediately following a set_bit()
> with smp_mb__after_atomic().
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  include/linux/netdevice.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Here is the summary with links:
  - [net-next] net: netdev_tx_sent_queue() small optimization
    https://git.kernel.org/netdev/net-next/c/7cfc1b1fa867

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



