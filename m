Return-Path: <netdev+bounces-134330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A3C998CE2
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 18:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DEBB281D37
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 16:10:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610481CEAA4;
	Thu, 10 Oct 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dfN+QSAN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEC81CDFD9
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 16:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728576633; cv=none; b=kb4htNfiDl1uZB2FhMCT+snkjby1iNOqxM4q22RO+8cJpWcQG9wWcRsQqM640OEsEf1LUtlH4ONaOHhXrPa4GRxOllhCT5M5o+cU2YfptS8SetX/9INSDfXqDBquTI5pnzYucfqEwb5cXHESZjadNbQ20p1v1IF6nhFyKZamDGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728576633; c=relaxed/simple;
	bh=xxwapPCcwd6tWb0wqVYiG3DQ/Zw+Ru+3pHII4nDQ16k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ekVNvZnmF5ursrpLwi6Qg9K84bQyUizP/MOk5n+GIPvCk+4rcfoV1IlVcmBwmJCsc2vGYkPbQ9RkNM5eTQ7ZTl2siJXnVic3N1M88PEqR1Cz1wfj6cdTWt2PHXqb57GDAdre95nMBzr0Q5O7IWrjZpB5Kxd8gr5AfTBUFA87sZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dfN+QSAN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 107BCC4CECC;
	Thu, 10 Oct 2024 16:10:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728576633;
	bh=xxwapPCcwd6tWb0wqVYiG3DQ/Zw+Ru+3pHII4nDQ16k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=dfN+QSANQyjRlc0DHmz/YIdj42R1MOhQA0j7PoK7kVt+Jc1wmvHwcfTRzIbhqVd9u
	 vN5XcsaRgOeIEPuPVln0n09Fb47UcM0fVAbTmjejI1VIROenbk3hF049Tr1nGWlZ+c
	 LM9nTbajmciukdQmCO7vEZMFYxLVWyc4RuUNyrUPte+59QuSrOD92soiVEKORINlB6
	 KzEMSsc8Sc6FVhe+yL2R1F+NgSt0ueGWSCGkcVQPFz89lGMI4O8Qthl3+sz6gYi/Pm
	 kl2g0BrwcwXPZDBT32gZz1rJEcCxNrJNno3KoWCpLRF3VQkLaYmWm+Wu+CBRiVphd1
	 hqYRHU/PHOXjw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id AE3003803263;
	Thu, 10 Oct 2024 16:10:38 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] slip: make slhc_remember() more robust against malicious
 packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172857663724.2081951.14767839968783756089.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 16:10:37 +0000
References: <20241009091132.2136321-1-edumazet@google.com>
In-Reply-To: <20241009091132.2136321-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com,
 syzbot+2ada1bc857496353be5a@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  9 Oct 2024 09:11:32 +0000 you wrote:
> syzbot found that slhc_remember() was missing checks against
> malicious packets [1].
> 
> slhc_remember() only checked the size of the packet was at least 20,
> which is not good enough.
> 
> We need to make sure the packet includes the IPv4 and TCP header
> that are supposed to be carried.
> 
> [...]

Here is the summary with links:
  - [net] slip: make slhc_remember() more robust against malicious packets
    https://git.kernel.org/netdev/net/c/7d3fce8cbe3a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



