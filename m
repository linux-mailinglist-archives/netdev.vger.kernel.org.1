Return-Path: <netdev+bounces-161240-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1A7A2028B
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 01:20:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AC951884069
	for <lists+netdev@lfdr.de>; Tue, 28 Jan 2025 00:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CB801FA4;
	Tue, 28 Jan 2025 00:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k3Oi2/pb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37AD023BB
	for <netdev@vger.kernel.org>; Tue, 28 Jan 2025 00:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738023607; cv=none; b=XckbVFZV+HhqP3/1NvxSEcMKJJs0HOwBgLxDLFtvF9ImeA5pJTItwyO6VUdiGcRIbwZMxKxWuD7YGqTocmeqjPsp19xh8qiRxEW2RGv5w9mIIassQrNZwCXfrd78GGMDPMDA9UOX3QTUVG6ZeDnQl+tJxPB4dPJrmn9hYMPjBzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738023607; c=relaxed/simple;
	bh=9tXlFeDf1WNttyldfHd1br1hIl+zHnyrhYpHwzoNih4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KymHx2fyFclCFwyPDH8MEre6eUHo3EcMlGShG++lzcZyZJWCtmZ+TvV1eUnPXy3xEVJskaG4BLuEyaviJZJunMnTeD+jiwetP++pVABFOHlx+A4y5WavwytZ2AkYEg9bG2ytbyNC4sCJ7advBZLR3jaX9XwQo0ea4g/JDBFl2CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k3Oi2/pb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BBEBC4CED2;
	Tue, 28 Jan 2025 00:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738023606;
	bh=9tXlFeDf1WNttyldfHd1br1hIl+zHnyrhYpHwzoNih4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k3Oi2/pbtDLw4g1QB8t92DJDOX7bsrA/v7AtIivgg3H3/wekfWvacE/wXXiUaJk1t
	 7VUdvL2kofllbIG+ui5mwyij0lawXjXZWFLgDNGsaAOBgQ0QgLFu4OJH3VD4KIJRsF
	 13Wn3H4vkL0TI81ojATzpCfizZr6d/scR1NyQJBHqX+CfFjAgqlvikil5SUwI3deos
	 4XwmFoyzoAm9aAPrKa4XNTKf+PlTYS0nqvXtFWpJf9JOgkN/sKpDpLjOrHdo5XtpcF
	 cf8KlNsRXHJb1UnFcIQ5varPz/dOlwtC0fqbL98puEq6bQAYc/rCz9OeGU7npy3k+5
	 x70AjGF6jSxTQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CE6380AA63;
	Tue, 28 Jan 2025 00:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/5] xfrm: replay: Fix the update of replay_esn->oseq_hi for
 GSO
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173802363226.3270482.10141084426152181904.git-patchwork-notify@kernel.org>
Date: Tue, 28 Jan 2025 00:20:32 +0000
References: <20250127060757.3946314-2-steffen.klassert@secunet.com>
In-Reply-To: <20250127060757.3946314-2-steffen.klassert@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: davem@davemloft.net, kuba@kernel.org, herbert@gondor.apana.org.au,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Steffen Klassert <steffen.klassert@secunet.com>:

On Mon, 27 Jan 2025 07:07:53 +0100 you wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> When skb needs GSO and wrap around happens, if xo->seq.low (seqno of
> the first skb segment) is before the last seq number but oseq (seqno
> of the last segment) is after it, xo->seq.low is still bigger than
> replay_esn->oseq while oseq is smaller than it, so the update of
> replay_esn->oseq_hi is missed for this case wrap around because of
> the change in the cited commit.
> 
> [...]

Here is the summary with links:
  - [1/5] xfrm: replay: Fix the update of replay_esn->oseq_hi for GSO
    https://git.kernel.org/netdev/net/c/c05c5e5aa163
  - [2/5] xfrm: state: fix out-of-bounds read during lookup
    https://git.kernel.org/netdev/net/c/e952837f3ddb
  - [3/5] xfrm: delete intermediate secpath entry in packet offload mode
    https://git.kernel.org/netdev/net/c/600258d555f0
  - [4/5] xfrm: Fix the usage of skb->sk
    https://git.kernel.org/netdev/net/c/1620c88887b1
  - [5/5] xfrm: Don't disable preemption while looking up cache state.
    https://git.kernel.org/netdev/net/c/6c9b7db96db6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



