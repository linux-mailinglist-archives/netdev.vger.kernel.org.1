Return-Path: <netdev+bounces-229009-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7542BD6ED1
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 03:12:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F11618865C3
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE8A255E40;
	Tue, 14 Oct 2025 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLhNqZOm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87CE32C15A5
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 01:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760404257; cv=none; b=G+I8nxHQPbs6u8CcJwWjhITs+TnkR1IIOi+mXSnT7AynHtJwjeJ+IoL8Svv+nUUgU7eS8TKdeFbtAutfRZ9QrZDSNq7SAW9SEkwLrWQJ9FhIF8FXMX2L1XJidDxKAXoOvcmOpEZmBwUqR3Oqn469YdBQJIVenkRsc6cxas2wyBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760404257; c=relaxed/simple;
	bh=XjkgFOqO7s9yK31v4i1ty3HQRoJIho85UfOG1J2ejW0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z9POGnuKf87iZcgVdul+oSK3jTLtHKOnV3ZQXI+YB07C37tpBM6VIg7AwvADvNqh68mnehWoBa1HgEL3EeKRSvh5gDCFqO0XHIzgenRu8kFTaxm9IcSwwKhv8k4Ick5rLqLNb6/qS3PnlZPmSOfTq6V6l88a/dnmRsbx/Loq1T0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLhNqZOm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A6AFC4CEE7;
	Tue, 14 Oct 2025 01:10:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760404257;
	bh=XjkgFOqO7s9yK31v4i1ty3HQRoJIho85UfOG1J2ejW0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=vLhNqZOmhhiT/vtpJ8C86AMoJg7Ao0/Jsuqid9ZsfsfaeZzK2GkQLW5W5e31kt7ns
	 /6+eZcXPvPNuzovK9Y5sBIhne3IxHZ8UHN4qdXduma25zOKKcXh9fneKNTqecexHpH
	 vPe0XLoTg+e+VX2dNRj2mJNsEEdzX23lamBHlH9h/umGXeCnxWCZPoEFgfhiLkllBu
	 SpBYNIzNSRsrHn/FxSQExcqCiaJosJOnQ25TlfOkNaPP5QG/6HCd3zGcyCh8N6+/d4
	 T7yICCsJulip/bWxEPjX4DBVppi+l90+JExklNiwHZR/8AT5JhF9E8b6hd/16mIwSc
	 rG+2fRFHNsJdQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EADED380A962;
	Tue, 14 Oct 2025 01:10:43 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] r8169: fix packet truncation after S4 resume on
 RTL8168H/RTL8111H
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176040424249.3390136.15198389734605387490.git-patchwork-notify@kernel.org>
Date: Tue, 14 Oct 2025 01:10:42 +0000
References: <20251009122549.3955845-1-lilinmao@kylinos.cn>
In-Reply-To: <20251009122549.3955845-1-lilinmao@kylinos.cn>
To: Linmao Li <lilinmao@kylinos.cn>
Cc: netdev@vger.kernel.org, jacob.e.keller@intel.com, pabeni@redhat.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  9 Oct 2025 20:25:49 +0800 you wrote:
> After resume from S4 (hibernate), RTL8168H/RTL8111H truncates incoming
> packets. Packet captures show messages like "IP truncated-ip - 146 bytes
> missing!".
> 
> The issue is caused by RxConfig not being properly re-initialized after
> resume. Re-initializing the RxConfig register before the chip
> re-initialization sequence avoids the truncation and restores correct
> packet reception.
> 
> [...]

Here is the summary with links:
  - [net,v2] r8169: fix packet truncation after S4 resume on RTL8168H/RTL8111H
    https://git.kernel.org/netdev/net/c/70f92ab97042

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



