Return-Path: <netdev+bounces-54710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC141807F11
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 04:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D93ED1C20C3C
	for <lists+netdev@lfdr.de>; Thu,  7 Dec 2023 03:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01FCA1C3C;
	Thu,  7 Dec 2023 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mstGj+0O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85A31877
	for <netdev@vger.kernel.org>; Thu,  7 Dec 2023 03:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E0D6C433C9;
	Thu,  7 Dec 2023 03:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701918624;
	bh=CdppV2jV3L8b53sEFvwEX9zSA9gDGSSoKz3gB8BIqR0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=mstGj+0O67EeNP4tioQA/0JeONbZBJI1VdTkwhtnufcGwAjOPwT+9UlBsSkCKyRCC
	 Rk5bVyMcTZi39bUwsTLBS97Xkpw4/Z/t7ctFHMuacq0yqOkOw5HtzeplBFx8JVDtoT
	 ZG6Tf2fZKjjw3V/qR+53FY2XYUoj0FSOt/x1VdACYzAcimaW3nvfBFfdHX8W6gGmWi
	 J1m6JTvy3R4Sn7rwtKKziRmEJyS245dE5jDqu7RsYQPUiaow6HQAiHLE5gYm9lVe6I
	 Ho0fBR3dCxKGfw2GNkKvMgZXxqAdaInTdDOOqy7+PXFctPusZVVKCqGXjxkQZxKuKL
	 jOeV5rnddc9hg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 23A26C395DC;
	Thu,  7 Dec 2023 03:10:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: do not accept ACK of bytes we never sent
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170191862414.7525.5415234550799392597.git-patchwork-notify@kernel.org>
Date: Thu, 07 Dec 2023 03:10:24 +0000
References: <20231205161841.2702925-1-edumazet@google.com>
In-Reply-To: <20231205161841.2702925-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, ycheng@google.com, soheil@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, yepeng.pan@cispa.de,
 rossow@cispa.de

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Dec 2023 16:18:41 +0000 you wrote:
> This patch is based on a detailed report and ideas from Yepeng Pan
> and Christian Rossow.
> 
> ACK seq validation is currently following RFC 5961 5.2 guidelines:
> 
>    The ACK value is considered acceptable only if
>    it is in the range of ((SND.UNA - MAX.SND.WND) <= SEG.ACK <=
>    SND.NXT).  All incoming segments whose ACK value doesn't satisfy the
>    above condition MUST be discarded and an ACK sent back.  It needs to
>    be noted that RFC 793 on page 72 (fifth check) says: "If the ACK is a
>    duplicate (SEG.ACK < SND.UNA), it can be ignored.  If the ACK
>    acknowledges something not yet sent (SEG.ACK > SND.NXT) then send an
>    ACK, drop the segment, and return".  The "ignored" above implies that
>    the processing of the incoming data segment continues, which means
>    the ACK value is treated as acceptable.  This mitigation makes the
>    ACK check more stringent since any ACK < SND.UNA wouldn't be
>    accepted, instead only ACKs that are in the range ((SND.UNA -
>    MAX.SND.WND) <= SEG.ACK <= SND.NXT) get through.
> 
> [...]

Here is the summary with links:
  - [net] tcp: do not accept ACK of bytes we never sent
    https://git.kernel.org/netdev/net/c/3d501dd326fb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



