Return-Path: <netdev+bounces-108039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2186C91DA8A
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 528F61C21C1E
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44EBE126F1E;
	Mon,  1 Jul 2024 08:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cvnt6Mhs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2108E7BAF7
	for <netdev@vger.kernel.org>; Mon,  1 Jul 2024 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823830; cv=none; b=tSIomvzSNG881ikyyVAZ1bsYWykMF/q1wt0Eu16tJJU0ip701eRAzbWJsJT6J8JqkMpgNr57bri5TYKH353F3+96W9NnR47bzRhnADn1U4iQUgRKQzbTKBuCktLwF+jsbeqzE4fJyjL1X4dMvMIkTcN8sXtzSrMBVECauVBGxG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823830; c=relaxed/simple;
	bh=eB6TzftuTLnMJ4I+T60FkoY58H9AlmCNvan60JSjFwo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WiraJYXTN7W27eVpCcW9qpvD5rAHbJYayTYP0fxddKJTMxLLGZTkTbbKh7MvVkxmWdPfLIe4en8t9W8vJ0iUxPDAAuwZMHDh2WGTQctdjzdDFtYH4ix+uM7EY99dNozgYAo9fmeO/3Ke9zdZzvcWXA4rWEEGsjUCOxeM/23XnUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cvnt6Mhs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AFACEC32786;
	Mon,  1 Jul 2024 08:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719823829;
	bh=eB6TzftuTLnMJ4I+T60FkoY58H9AlmCNvan60JSjFwo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cvnt6Mhsq4+A1llg+f51vFVcKvi5auVLPm2eitAsFXtLpIRegxMuc82UYQciWl6sm
	 I+MFFYpiUeBYEnWRjgOlQAqsZbMwD2SGhTxjIsgHnMMpDm/9q5Ba4rnNjeH5fbri4q
	 FXjJ987plMa5AZzSlBhs6gbVKMlISvRIx0+w5fKTL7P+I5i8YF1RVNScNnXr7QD7zL
	 BPADgUolmKzhN1AszdyPlb0lAuqEjj9OH4CW4V1zLjwfw0lFN5f5EptZWfFtDUDdzT
	 4QOJTEtAqKr4m6OooXb9oX6oB3Tv7dFgEQJNPc6ImQejakYfDOAEEeGRInXRWU8RnA
	 ajUEzHUgSycLg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9F0F6DE8DE5;
	Mon,  1 Jul 2024 08:50:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] tcp_metrics: validate source addr length
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171982382964.18736.17683337245328823286.git-patchwork-notify@kernel.org>
Date: Mon, 01 Jul 2024 08:50:29 +0000
References: <20240627212500.3142590-1-kuba@kernel.org>
In-Reply-To: <20240627212500.3142590-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, dsahern@kernel.org, christoph.paasch@uclouvain.be

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 27 Jun 2024 14:25:00 -0700 you wrote:
> I don't see anything checking that TCP_METRICS_ATTR_SADDR_IPV4
> is at least 4 bytes long, and the policy doesn't have an entry
> for this attribute at all (neither does it for IPv6 but v6 is
> manually validated).
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Fixes: 3e7013ddf55a ("tcp: metrics: Allow selective get/del of tcp-metrics based on src IP")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net,v2] tcp_metrics: validate source addr length
    https://git.kernel.org/netdev/net/c/66be40e622e1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



