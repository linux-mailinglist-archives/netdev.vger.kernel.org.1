Return-Path: <netdev+bounces-104543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0F9390D29C
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 15:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D45531C22681
	for <lists+netdev@lfdr.de>; Tue, 18 Jun 2024 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E19551AD4A9;
	Tue, 18 Jun 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aO/SZ1Zp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE04912D74D
	for <netdev@vger.kernel.org>; Tue, 18 Jun 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718716828; cv=none; b=ux+SpHXzhCUq0X//JDAzksaAwAwO+bbrXBmL0KHZSHpmpe+sNX0uNsB1KPSTTJiXwbRDyDbsN1lD5gdlh+OIu4lAhwJIZPs1m7YiIoMUULWH8Xc448Vy+2yxlRqmvEhz2CMMoDbpX22NgT27dtXEvQ20K4HLxicqwPfKihkjylc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718716828; c=relaxed/simple;
	bh=ix1yml5sQSDyNuoShPBSFbawnyAlXL7OvacSeQJyRBs=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fVZeZoBkGREbM4RspgGPkVuQht2ku/c9syPnqVEScAOV2euuVc8AAX+gNLTc3IEpM4V1B0ETdtAvlbu8P4SXFubpawlZi1RKyn1o9/csbvCKaSmsrHi0KrYWtTpRV3W97D1sW8nSCjF8GV9sI64sKwO/rgV8kOYS25vYiEUdRFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aO/SZ1Zp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 80C38C4AF49;
	Tue, 18 Jun 2024 13:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718716828;
	bh=ix1yml5sQSDyNuoShPBSFbawnyAlXL7OvacSeQJyRBs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aO/SZ1ZpY8lSja8gyGC36evh3LrYXlxbc/74sB/ESf80ZQb8aJR4uCloBdx9W3Ek4
	 JJyTpMG2MGS99HGnvv+hlFIVk2KK9pCMs4FCFifZPjEqrv7hVZvXF3TE3I2npgDUa5
	 GoXhXxHS6vHh96t/2AkEaw/RXDOUiVR5w1m2wIlQNdT/CPFq5E1l8PnR34w6dvxOkp
	 KP6BsqRYVZ4jBQg+vw4ovJ8LYOXVNdxyipgPi1YAqHdI/HQTHwGbWGbuWiW3ddZ6jj
	 ZpSno+IIwWh4JtIX6WD6+J2p2MXzTrsAYvVJq6y6Z+fvKLMxpOMtyhu/oS0VktiQkI
	 ydAdnjw2gDbkg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 70546C43619;
	Tue, 18 Jun 2024 13:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tipc: force a dst refcount before doing decryption
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171871682845.4510.4691473810061988623.git-patchwork-notify@kernel.org>
Date: Tue, 18 Jun 2024 13:20:28 +0000
References: <fbe3195fad6997a4eec62d9bf076b2ad03ac336b.1718476040.git.lucien.xin@gmail.com>
In-Reply-To: <fbe3195fad6997a4eec62d9bf076b2ad03ac336b.1718476040.git.lucien.xin@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
 davem@davemloft.net, kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
 jmaloy@redhat.com, ying.xue@windriver.com, tung.q.nguyen@dektech.com.au,
 tuong.t.lien@dektech.com.au

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 15 Jun 2024 14:27:20 -0400 you wrote:
> As it says in commit 3bc07321ccc2 ("xfrm: Force a dst refcount before
> entering the xfrm type handlers"):
> 
> "Crypto requests might return asynchronous. In this case we leave the
>  rcu protected region, so force a refcount on the skb's destination
>  entry before we enter the xfrm type input/output handlers."
> 
> [...]

Here is the summary with links:
  - [net] tipc: force a dst refcount before doing decryption
    https://git.kernel.org/netdev/net/c/2ebe8f840c74

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



