Return-Path: <netdev+bounces-203525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 326A0AF6476
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 23:59:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D3021C41AC0
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 22:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 237092405FD;
	Wed,  2 Jul 2025 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6mNoRiW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2C3F19D8A7
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 21:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751493583; cv=none; b=GsKJifbIm2vkXifCFzXptAAyUgVCNEyO2oVg/EzzUwFBLqMrXm7aoncPP4WwMvp6Nvb+ZnzCCrTGr+d4Fg4kpNqphemuJSd5nMWPThKRPnaNEr6bLldmcFXvbzLWc0IXxghTkCOrjcySNfefEPKXXSX98VMcER67hijnRPaUd+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751493583; c=relaxed/simple;
	bh=PP8RWDdrv0mFV6LINUbYKCjSvNc21Sn8FCIqNxCPmsA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pOQu0rkeoAmLHjHemcne/BDv1Xik1a7zfLX2NepO5YEB/XZdB8L3iB59Rq3HxQL5B0SxIi0fhFn9ZzZlNaDwBP8+HjIGTd9jcbZAAEn8TJMQi2L4YOCZy5m9FHmYNAvMlM6XD2Un9kXcPPYimt/ZXepIT7SruhqHh/+5BPo9vSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6mNoRiW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C23BC4CEF0;
	Wed,  2 Jul 2025 21:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751493582;
	bh=PP8RWDdrv0mFV6LINUbYKCjSvNc21Sn8FCIqNxCPmsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a6mNoRiW9INFXRxxnzhcVOimAaKVMESCTwER3poylBGd/qBZROd+r7kn5DIEXlnv5
	 ctUX2qSDVUJiySf6geGdOypq4E7jd339lHGi9Ah3L0YTxIC80XX2ru5+k70UwHGcqX
	 yWEzokc6P1mDgQ5dab2o/sGXNvntPIvging+qfyYhpcWomnh+lOVvPxWNN/bIqY4ps
	 ANZbUW7MVoYg+vexgIhO4jAXDxIq46R44OEWLH6xnyE1tYSJI2x5R0DbsxEc0FQvqO
	 VAe/uea5cQuOOlNwO/dtIZ2XWcip1+KMRl4aaA6sbgWcRmRFWxwFn6Txv1SMKK6mHV
	 Wy9NM1DM86LpA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34E14383B274;
	Wed,  2 Jul 2025 22:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: ipv4: fix stat increase when udp early demux
 drops the packet
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175149360701.877904.3077339158270008781.git-patchwork-notify@kernel.org>
Date: Wed, 02 Jul 2025 22:00:07 +0000
References: <20250701074935.144134-1-atenart@kernel.org>
In-Reply-To: <20250701074935.144134-1-atenart@kernel.org>
To: Antoine Tenart <atenart@kernel.org>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, menglong8.dong@gmail.com,
 sd@queasysnail.net

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  1 Jul 2025 09:49:34 +0200 you wrote:
> udp_v4_early_demux now returns drop reasons as it either returns 0 or
> ip_mc_validate_source, which returns itself a drop reason. However its
> use was not converted in ip_rcv_finish_core and the drop reason is
> ignored, leading to potentially skipping increasing LINUX_MIB_IPRPFILTER
> if the drop reason is SKB_DROP_REASON_IP_RPFILTER.
> 
> This is a fix and we're not converting udp_v4_early_demux to explicitly
> return a drop reason to ease backports; this can be done as a follow-up.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ipv4: fix stat increase when udp early demux drops the packet
    https://git.kernel.org/netdev/net/c/c2a2ff6b4db5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



