Return-Path: <netdev+bounces-241378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 91794C833C3
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:30:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4CBC74E3029
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95C03145B16;
	Tue, 25 Nov 2025 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QKOOSggi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA113B2A0
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 03:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764041445; cv=none; b=t4xPexHHHCq6w372p7Kb4pFjA5h3zvVcF0MVVnFX5/nR+sVhmzKmQL5LSkyQmrx3JChWQaF+0NXd3/WThc8PGLIfHRmcknUgIsqiQwnzSYmyJEjlupa060MwfLsaJb7gKgJ92kV2g090iSDSS8yjXwwlv3JcdD1k/ldz+HXkHu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764041445; c=relaxed/simple;
	bh=Hb9qcQEvsFkWMcf71mkDzO9+31f3zEiOXoEdUdGpepE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ok7mThJPg5205GPh8tcYMpGt9+zGqOKf8VgxRAfTGWPL/znl2vxIH1oJ25NAAWuh4HWYtgCnSu7eZq/aKx+N7mK0tHMNVbbBGw/lBKSbgAEFPSzYOB8m4qcbAhWEew7XkDZaETdfjdVJSlUIwQR+Ckt3g3eAHyJvG93Ho0h0vso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QKOOSggi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6193C4CEF1;
	Tue, 25 Nov 2025 03:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764041444;
	bh=Hb9qcQEvsFkWMcf71mkDzO9+31f3zEiOXoEdUdGpepE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=QKOOSggi2F4/Vd9YPL5CD5c2cPoqwoHNrzJlsp6FqGYg02jJliwJ3GzNTHeqAhsIN
	 O8FMCG9Rh58Wv5nNPwuPgEDzim2zKoVVcuncylbKZ/xHBeCF3QLs/G2LLAvrCDQ8ng
	 zPtay4z1/xmlpb0gBy2pUZcVCGlu/OO7y6ARfBgB5TdsRBsljzXvuxHDx7yFqq8nIR
	 pY0BvtyUWsEL06yUqAD1JdAr9zPRE9Oq6GGBP9k15Jw3vHqwqdyswJ5NrigISwU85E
	 tZ5JJrM0v0kN4b8ITWePHjBVU2EVdqZgOMCIuM8EtJc6zgbOSpsXka1YO6Le888CDw
	 WhG+H9qzQhgcw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB1413A8A3CA;
	Tue, 25 Nov 2025 03:30:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: optimize eth_type_trans() vs
 CONFIG_STACKPROTECTOR_STRONG=y
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176404140776.172437.10107001254735892374.git-patchwork-notify@kernel.org>
Date: Tue, 25 Nov 2025 03:30:07 +0000
References: <20251121061725.206675-1-edumazet@google.com>
In-Reply-To: <20251121061725.206675-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, willemb@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 21 Nov 2025 06:17:25 +0000 you wrote:
> Some platforms exhibit very high costs with CONFIG_STACKPROTECTOR_STRONG=y
> when a function needs to pass the address of a local variable to external
> functions.
> 
> eth_type_trans() (and its callers) is showing this anomaly on AMD EPYC 7B12
> platforms (and maybe others).
> 
> [...]

Here is the summary with links:
  - [net-next] net: optimize eth_type_trans() vs CONFIG_STACKPROTECTOR_STRONG=y
    https://git.kernel.org/netdev/net-next/c/ec1e48e97feb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



