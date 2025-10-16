Return-Path: <netdev+bounces-229826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A78BE116E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 02:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86712188F73F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 00:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C638248B;
	Thu, 16 Oct 2025 00:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m1DrVzHs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE031C69D;
	Thu, 16 Oct 2025 00:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760574024; cv=none; b=Q46x3UFTyTAHpbLnQHPE+ztYDXs8vyaplJMu8HXJ9kcJ9aAxoPs1Y4c9GLksXS5beI7IntcBfbkm+o+lIxa2pfcgvDriKpPomGNpLZHv6Re2zQP6lDEg1kzMlXYXCis4maYLafT2SIYiiR9PpnFxy2gR9OeygABkxvhBEZmbycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760574024; c=relaxed/simple;
	bh=ffKG/r/eP/i1nc0BLUEf8wgmRODVquOoyNlywh8R4w8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d3pLFmtkDXLJuiAU6+arkqsolJ+xkW0biE1kvkQ9PQty8YbTnF3zNFCAGeC/j5SlTmww4GFXMCE+yoRqMFg0JIlGFsGOE0+F6zumrGzRui3dXql4JgywnDQdpAZ7n3wLnN3ERfGtpAlgBEuT21Excvv03hdLSWgq79vtBTSOyPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m1DrVzHs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C97EC4CEF8;
	Thu, 16 Oct 2025 00:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760574024;
	bh=ffKG/r/eP/i1nc0BLUEf8wgmRODVquOoyNlywh8R4w8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m1DrVzHsAiJiYOT6ErV+qScXAd+hnWAaJZN8feL+Q4R7wZft0DARqsxafz/tNmhrs
	 nlplMeBlGs4NSr7iOSvXVuLpwWLD5gmHUy9+0Py/1UlrxZnJOxrBAkbtFGLFA9m8IU
	 yI342PIm5bQZh3cPjV/2srihi4SVctz8qLFU9ot8Sc9rD3NtsJLM5CVY4Mw9pP2cYw
	 B7aV6Aq6zQPwrRvzLJEZRW7UqY2OTUYHOCo2iNP+LQfc7JOdlU79x92SZ8sc2IWxqq
	 Qa8aW82HSPvu3JjcNK0j8bUUE+WH9uj8Ax8R1qmc9fpxppL/kURXO3w3dm89fv+8hR
	 r09ZUcvNPzXYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33B18380DBE9;
	Thu, 16 Oct 2025 00:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tg3: prevent use of uninitialized remote_adv and
 local_adv variables
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176057400874.1105273.4960000044847943358.git-patchwork-notify@kernel.org>
Date: Thu, 16 Oct 2025 00:20:08 +0000
References: <20251014164736.5890-1-bigalex934@gmail.com>
In-Reply-To: <20251014164736.5890-1-bigalex934@gmail.com>
To: Alexey Simakov <bigalex934@gmail.com>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 nsujir@broadcom.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org, alsp705@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 14 Oct 2025 19:47:38 +0300 you wrote:
> Some execution paths that jump to the fiber_setup_done label
> could leave the remote_adv and local_adv variables uninitialized
> and then use it.
> 
> Initialize this variables at the point of definition to avoid this.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> [...]

Here is the summary with links:
  - [net,v2] tg3: prevent use of uninitialized remote_adv and local_adv variables
    https://git.kernel.org/netdev/net/c/0c3f2e62815a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



