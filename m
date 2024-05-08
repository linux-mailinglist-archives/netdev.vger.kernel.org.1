Return-Path: <netdev+bounces-94478-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F238BF9A3
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 11:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 474971F24301
	for <lists+netdev@lfdr.de>; Wed,  8 May 2024 09:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3178762DE;
	Wed,  8 May 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cTuwdHI0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66977581A;
	Wed,  8 May 2024 09:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715161229; cv=none; b=W9I5etdV9y8E+r+jz94gUhkS9154IU1ky1tA70OQ2YLgoz0GyUAGCQk5KU3lM7LaefJSaIdCSBQdIEWek5c1i6/MOin1pSLZszrMog9jjc8wG/OqMulwzovlBPO0DGhvrheeeGxAVCPW4ByzBL5J/XYks0dWZwUaKI5f+goxOK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715161229; c=relaxed/simple;
	bh=XyCutnzQ3i618e+75rtDEoLQys3pHpoSb4bsdFYd1IY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Wa7rPeVJb0uGpm2ko1ng9EtO7FKfuWilQmbBT9Fh0gNT8E8fJ/CFkS1MBf/8esQFqPTPbRUhAfEGxb/gdeFfNdm6V+i8hjbMVZxCzTeLWNkHxpiES28lCoGdouGAc1gPqWzCAuI1a0G15cACEoT9WGKetHNfK6BhV/La/BOnc1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cTuwdHI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BA83C4AF18;
	Wed,  8 May 2024 09:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715161229;
	bh=XyCutnzQ3i618e+75rtDEoLQys3pHpoSb4bsdFYd1IY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cTuwdHI0s1XkVG28wfDeVuGEI/VsvYg1GkFjSFs7vr+II0ATg1x17ae98mEeStJw6
	 srzkp3GqwkDctO7X1/TCKTKjFWEAwEb9r8155CZf4Kam3gdngjNm7dYBccxMbIocTp
	 lhTt3UXSYsXLPOTQnyPj6KXAf2KHRDurrHvM2pH4RbDOwug4GK8T2WA+0jBx0nP2TJ
	 3rdglA/GWbPpKArgcNk748lN7QdC4dVrsZA1pjpx8zwpIxWX2F1wPYVE9SauXayadB
	 FU1CFtT+MXDXr3qRODti5k/fd286BOHkJbYoKcXRPuQLdbMpLtD7CPQQutFeVLnmRe
	 rrVnCM1LVzg/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3EF13C3275D;
	Wed,  8 May 2024 09:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: bridge: fix corrupted ethernet header on
 multicast-to-unicast
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171516122925.8124.11827972831667240154.git-patchwork-notify@kernel.org>
Date: Wed, 08 May 2024 09:40:29 +0000
References: <20240505184239.15002-1-nbd@nbd.name>
In-Reply-To: <20240505184239.15002-1-nbd@nbd.name>
To: Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, roopa@nvidia.com, razor@blackwall.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 bridge@lists.linux.dev, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Sun,  5 May 2024 20:42:38 +0200 you wrote:
> The change from skb_copy to pskb_copy unfortunately changed the data
> copying to omit the ethernet header, since it was pulled before reaching
> this point. Fix this by calling __skb_push/pull around pskb_copy.
> 
> Fixes: 59c878cbcdd8 ("net: bridge: fix multicast-to-unicast with fraglist GSO")
> Signed-off-by: Felix Fietkau <nbd@nbd.name>
> 
> [...]

Here is the summary with links:
  - [net] net: bridge: fix corrupted ethernet header on multicast-to-unicast
    https://git.kernel.org/netdev/net/c/86b29d830ad6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



