Return-Path: <netdev+bounces-171907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B02A4F441
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 03:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 743073ABAFC
	for <lists+netdev@lfdr.de>; Wed,  5 Mar 2025 02:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6B8715A843;
	Wed,  5 Mar 2025 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nIOhX/9V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B21C615854F
	for <netdev@vger.kernel.org>; Wed,  5 Mar 2025 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741140002; cv=none; b=qeQFWPFskhl6bOh1PFb5WtGgX5oFGcHNc7RCtfboCRlGsQSGBTUnAlmGVQLvjKc3hUV4FLTyJF+IaOrKFWCiV/oUs/B6PYXgca/96X4YLJfG7GBuLH7E3VBKQWjK2znX/gPoFqOptfHabj2YJ5MBx1tUglbB5DJ3H9IAWujZ8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741140002; c=relaxed/simple;
	bh=i4gSdFpdpy/2JB4+F9P/FRGyKXXmwKhk0UyiddYQW/A=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KSNlZzs8x6Oj/IM+DJdxNUY1qgVGQ+cYdRu0fw8vUbw0pLIbHelCmtr6E5NqhBQTYo0uc2OJV8ASP5FpNYnB6MAgnrFCnnmApZf3Lsmx1TgikzPME6CN9W/LGNQKar6aWnQcA+OixFX4OC8zf9xkjkmwYoUpv8DSDHpTR0LXHd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nIOhX/9V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D39C4CEEA;
	Wed,  5 Mar 2025 02:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741140002;
	bh=i4gSdFpdpy/2JB4+F9P/FRGyKXXmwKhk0UyiddYQW/A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=nIOhX/9V3NS/POfNSZPnL7YijkyVzAiVKM2WbPe8/qXCIw2xE7pYyVsVOfF3X9BEB
	 oHf5hNsH92XeYID/q98J1I+/6XfqfrJ3p3/iosZDOd6Mk1l4fCmK0EGCyteWLN3SD/
	 yRwZbmKy1BNMnmWq5ksQv56Mls3w3IEMT/Obf2EFt4q4aZe+GNNYzAzsQgk6pdnuAS
	 63GnIJP+bqZPZh9CF+uSD1Xjmdz0HketZ9wiEmALr8cTUgOjrnGJlG155QtysMM2TM
	 XWhlckgmzMy7YqXbO6GHW8DuQP9WN9UVxdOqkl39eye5G4q/NM2+SzLxy2Sd8xd+ez
	 pGcSqEy3H/MjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAFBA380CFEB;
	Wed,  5 Mar 2025 02:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] tcp: scale connect() under pressure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174114003473.368364.10864738728714771230.git-patchwork-notify@kernel.org>
Date: Wed, 05 Mar 2025 02:00:34 +0000
References: <20250302124237.3913746-1-edumazet@google.com>
In-Reply-To: <20250302124237.3913746-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, kuniyu@amazon.com, kerneljasonxing@gmail.com,
 horms@kernel.org, netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun,  2 Mar 2025 12:42:33 +0000 you wrote:
> Adoption of bhash2 in linux-6.1 made some operations almost twice
> more expensive, because of additional locks.
> 
> This series adds RCU in __inet_hash_connect() to help the
> case where many attempts need to be made before finding
> an available 4-tuple.
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] tcp: use RCU in __inet{6}_check_established()
    https://git.kernel.org/netdev/net-next/c/ae9d5b19b322
  - [net-next,2/4] tcp: optimize inet_use_bhash2_on_bind()
    https://git.kernel.org/netdev/net-next/c/ca79d80b0b9f
  - [net-next,3/4] tcp: add RCU management to inet_bind_bucket
    https://git.kernel.org/netdev/net-next/c/d186f405fdf4
  - [net-next,4/4] tcp: use RCU lookup in __inet_hash_connect()
    https://git.kernel.org/netdev/net-next/c/86c2bc293b81

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



