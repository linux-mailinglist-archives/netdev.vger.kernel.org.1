Return-Path: <netdev+bounces-94943-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BF308C10BE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 16:00:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4657B282E32
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 14:00:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CE0615B543;
	Thu,  9 May 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HXl13fo4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7514C158A21;
	Thu,  9 May 2024 14:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715263228; cv=none; b=WkvQNL1UU+pk4688FSnP14FqyHeVEMBC758EFa2yILjWRH9iSj/h8OVuGUM25G+xW6MRb4KH5l27heUWSqkPpJzCg1keYQtiEjyld6rd6EEY6ugLBcOpRh1D0bc5yBiT791M6rQuKSN3doILAGYftz9rUMsXzo3yWfM/GSQiS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715263228; c=relaxed/simple;
	bh=Nrm46WmZGyIT35cwvy1Yk+kqTYBFw1zdT4d5rEEvf2w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t2f8E3tbVBEG60orO4GtFLG33a3XaUQjsSeUOoh/ZGhsx/6gmLSxQB1lDm26iReOR7zswXQ+/9qfhCDvDT512gpIvHdB6kmy8bR095v0DL5xZwrPVPQ4AXPSeQXG24911jNf2Wz3qCxSzLW3Ag9g1hovg08E4Lt3vdsmopPQNKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HXl13fo4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 08F57C32783;
	Thu,  9 May 2024 14:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715263228;
	bh=Nrm46WmZGyIT35cwvy1Yk+kqTYBFw1zdT4d5rEEvf2w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HXl13fo4VJoiARF43IiqWR7aDoOTz4RTR1WUcx2kpxZFPJBwlHbZuO1bD+p9XoSL6
	 ix0A5PaiWL8AwTXLn5Z+nT5HRCHLviA7mcOI0FxPruUirhhJQXbYXXb+24b5CuoU+v
	 i5RXANdz+yXgpni04JsFtI5kw2liebQL2M6ZjdysL74kF0caM7IBsygCe0H5Ag/roN
	 2rYpv23bviiQlAnik0CTgVZSs9vlDwFulzaVqyBQ5VxR91gderKOfR/pEX+7AGMl7F
	 780JVy4tgbJOQfqQvSpAb9YMMx75oRJZIFYaMeRxDZ4cTcnP/A1P8Go1Q8HWLfWgEc
	 0EgZ1WPq9rUdQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E537BE7C0E0;
	Thu,  9 May 2024 14:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCHv2] l2tp: Support several sockets with same IP/port quadruple
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171526322793.14863.3674169086267452877.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 14:00:27 +0000
References: <20240506215336.1470009-1-samuel.thibault@ens-lyon.org>
In-Reply-To: <20240506215336.1470009-1-samuel.thibault@ens-lyon.org>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: tparkin@katalix.com, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jchapman@katalix.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon,  6 May 2024 23:53:35 +0200 you wrote:
> Some l2tp providers will use 1701 as origin port and open several
> tunnels for the same origin and target. On the Linux side, this
> may mean opening several sockets, but then trafic will go to only
> one of them, losing the trafic for the tunnel of the other socket
> (or leaving it up to userland, consuming a lot of cpu%).
> 
> This can also happen when the l2tp provider uses a cluster, and
> load-balancing happens to migrate from one origin IP to another one,
> for which a socket was already established. Managing reassigning
> tunnels from one socket to another would be very hairy for userland.
> 
> [...]

Here is the summary with links:
  - [PATCHv2] l2tp: Support several sockets with same IP/port quadruple
    https://git.kernel.org/netdev/net-next/c/628bc3e5a1be

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



