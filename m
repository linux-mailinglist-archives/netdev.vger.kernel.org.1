Return-Path: <netdev+bounces-219139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C51ABB40138
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 14:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 554401B60C32
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43D92D543D;
	Tue,  2 Sep 2025 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rtxkkhEd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE172BE62E
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 12:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756817401; cv=none; b=q9Kk5iOEQDKfsWwg7/kNfptadPvMMdj+rB11aIIrEUPXDlZT5NIk8If+Wpv6mdE4lfE9chrzB2fWr7Z1PaAbka7ddBuiwSKvypDXDRGqdqJRWZjoo5ffjphpyYpO+7ll1XwGupLMT63fvu2ufTQkJEfJRKw9c33Qnf8LHfh9TPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756817401; c=relaxed/simple;
	bh=qDeYqcDPKcvCax6lhUbRnmkSU4I8D5mkIKcP52r7BVU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=cKkQvdY+LHcT+94xOYZMmx/1Z97WHN9KM8i2FVoAJUzQHl1K8kATZL+GVz8Vrt+6n7sC/q7w2orOK1ryZc7ypK9ECVuN1fDGtDWrEjRk16Y0Ns6egOkayuSCSBjRdXk+o77pcYugYRBYY4+0fhTm+/NlGMadHslF1sc2YjuIdAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rtxkkhEd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3D7C4CEF4;
	Tue,  2 Sep 2025 12:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756817401;
	bh=qDeYqcDPKcvCax6lhUbRnmkSU4I8D5mkIKcP52r7BVU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rtxkkhEdJt77eYZGZPvae+d4z+w17ODl8r/QQZeYa083RIkobFDNhoQiS+aDObDwa
	 fqyBfxKxNQIndjUmPg1MvuJI5ETM/z23kjiTG1JuPIneNO7ENRC4wUBFxntGnN48R8
	 /BSBMjr3k8/tV4BMCMgCkjdPs51tWvskEGY1M8pUDCuXvRJN/GKaGV1vXUuN4viI7Q
	 2u0rRCPcYTDm/fq63EkP5mIpP9Xky26sJhsXTZtYCPgcSwgmq9nvjn8aAOssc9PQ88
	 e+JkkZJkTO+kqw5iGdtY3BRERvxtAVewzUg8cVPIXrYyM5bxqB/5Yu08X1B+LMg+1m
	 EP/NlIXnouJKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE3A383BF75;
	Tue,  2 Sep 2025 12:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: mctp: mctp_fraq_queue should take ownership of
 passed skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175681740651.280373.15673435879962570237.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 12:50:06 +0000
References: <20250829-mctp-skb-unshare-v1-1-1c28fe10235a@codeconstruct.com.au>
In-Reply-To: 
 <20250829-mctp-skb-unshare-v1-1-1c28fe10235a@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>
Cc: matt@codeconstruct.com.au, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 29 Aug 2025 15:28:26 +0800 you wrote:
> As of commit f5d83cf0eeb9 ("net: mctp: unshare packets when
> reassembling"), we skb_unshare() in mctp_frag_queue(). The unshare may
> invalidate the original skb pointer, so we need to treat the skb as
> entirely owned by the fraq queue, even on failure.
> 
> Fixes: f5d83cf0eeb9 ("net: mctp: unshare packets when reassembling")
> Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
> 
> [...]

Here is the summary with links:
  - [net] net: mctp: mctp_fraq_queue should take ownership of passed skb
    https://git.kernel.org/netdev/net/c/773b27a8a2f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



