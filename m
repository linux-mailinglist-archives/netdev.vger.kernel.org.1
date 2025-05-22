Return-Path: <netdev+bounces-192635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E4CAC0981
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 12:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40EAA279B4
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BC5728851A;
	Thu, 22 May 2025 10:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZdemRg9j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3765C2857DC
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 10:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747908604; cv=none; b=V40JT4/+uFwvVYauOdgm+9sILxUcET12j6FlNQiUtZ1kS+DjIBcfK/3K3NTif0AQSHBX7IZ817z22T/K8hbhA/q+G1qpmbmKjBrgwHqkFyqvQcVVFPbUgglLf699xnW5dCb+rwUxdSu45TzQrpFiS0uamk87CcQFIs1bfnWozEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747908604; c=relaxed/simple;
	bh=GflxemNkzWyJL25XgSM1Yhvulj4yZDL1EKDuP4AXEiQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gGcdPakwBe6ShnPrscDsG+au0rL2C/pB+ZqFVP2VsyE6TbQ7rOOCozli7GJtAdA4ZXPlTmWJmw61G1xQoih0ygIrZ+CCJ4zxJbxM2+R+GA68Lc1dE9o+jOqnLbUIGLsk1q/8p+d7gdk1WooaRWXmgYxcDJ85z437wxNWkbLQp58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZdemRg9j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1A10C4CEE4;
	Thu, 22 May 2025 10:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747908603;
	bh=GflxemNkzWyJL25XgSM1Yhvulj4yZDL1EKDuP4AXEiQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ZdemRg9jpe8jCSO3P3zBm4QvXDxVmoqg8SWpgfyY6VlrSmBrymX4wQt+s+o8tdZfW
	 S2hRi2kKQOpBRWbn40ynLngrLiV9/viKuAQQfsfyYwc4LpgKR4A/g3SJUUcgwFKdt6
	 7Ka2UQ359TXR3q9/IYTviOUQJabPhZjgjZr68kVPDNY9k8H+H+IcftKcS1hkJVJN2w
	 HAWJhO1fTxURt/4vnzCqioT1cN6nt0CfxdHynGwxUaWIxUg9VZiExvUaNUPRa5gnP+
	 sHfn1ljjvdzQRkoz5y0zwMStgcbuuBA7cY8/JfZbJRT88cdx61OjacNigmI7mS52kl
	 iuKvVL89Zrm1Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E73380DBF2;
	Thu, 22 May 2025 10:10:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/5] espintcp: fix skb leaks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174790863926.2478261.6260242845041465584.git-patchwork-notify@kernel.org>
Date: Thu, 22 May 2025 10:10:39 +0000
References: <20250521054348.4057269-2-steffen.klassert@secunet.com>
In-Reply-To: <20250521054348.4057269-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Wed, 21 May 2025 07:43:44 +0200 you wrote:
> From: Sabrina Dubroca <sd@queasysnail.net>
> 
> A few error paths are missing a kfree_skb.
> 
> Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
> Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
> Reviewed-by: Simon Horman <horms@kernel.org>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> 
> [...]

Here is the summary with links:
  - [1/5] espintcp: fix skb leaks
    https://git.kernel.org/netdev/net/c/63c1f19a3be3
  - [2/5] espintcp: remove encap socket caching to avoid reference leak
    https://git.kernel.org/netdev/net/c/028363685bd0
  - [3/5] xfrm: Fix UDP GRO handling for some corner cases
    https://git.kernel.org/netdev/net/c/e3fd05777685
  - [4/5] xfrm: ipcomp: fix truesize computation on receive
    https://git.kernel.org/netdev/net/c/417fae2c4089
  - [5/5] xfrm: Sanitize marks before insert
    https://git.kernel.org/netdev/net/c/0b91fda3a1f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



