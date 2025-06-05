Return-Path: <netdev+bounces-195287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC073ACF2EF
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 17:22:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08463AB909
	for <lists+netdev@lfdr.de>; Thu,  5 Jun 2025 15:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84FDC1DED56;
	Thu,  5 Jun 2025 15:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VTJBuBIU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E6CD1DDC23
	for <netdev@vger.kernel.org>; Thu,  5 Jun 2025 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749136810; cv=none; b=FoEovNhv7zl7wOLJGkJcirRT4MQt+3vbvnTdzYxiTnsnXiQQFh63/RR6OlIgtDSwxAb0fUNXHTOeTXzRAekcLcin+JuV8WsOJe3Pzz/lvY7i5bga1wI95u1tHvXf1Q/XE0GEpPQS+8xUg95jjMgDzoBHV+H0hA2ZyHqKk8xuOL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749136810; c=relaxed/simple;
	bh=3wFjecaLGRuI+1C1SxrlnhNbcwHN1NlDe3GmwOUqSTk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rrzgkXINMDuGcxDBSF/+DwAz8f4Z4ZWQO1EGmrRwCnNee4PJNIaMfrjAImY+Tc/RRnLfY+X2tIvFM2yRsFLbV/wbEg9F96gkThpQMXrlnUJN6IUcFyiB0fd5hpwlpjMnpkL3nXPYRPH1ovqFugF1meSbdNsLTjPbE/HdT2Eneww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VTJBuBIU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C49C3C4CEE7;
	Thu,  5 Jun 2025 15:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749136808;
	bh=3wFjecaLGRuI+1C1SxrlnhNbcwHN1NlDe3GmwOUqSTk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=VTJBuBIU6G39kqShvrCl8VLm22gZFb7xOVF5NEOEx50sFkjFNNn5Lwmcp2RqPPSha
	 uwotmfeX8hT/JuT6x230uRsdk79AR/SMSTlwQRSt9IWbDs1HThJATVUtdDCU2mcHzb
	 LsHGYYlFp2iIXGM5ntOfbURQIbeYKbDpYbNoO/iS+M/7orNq2zFE50xP9JBtdnsgmX
	 shjcrypAVnnqgLC+uSmrUY1enxRkHbTiIuGEwLm/aqJ98fnyNgj+LBbNXZKUO+BQf4
	 7+25Mi9uFTnMPFh8ckiH+3zcke8RAqrCm0d3yhwSmQlcdxAwgxGRVmog0wVywE0X1l
	 ITme9W2HBuhnQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB0FA38111D8;
	Thu,  5 Jun 2025 15:20:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] seg6: Fix validation of nexthop addresses
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174913684049.3113343.11057638430818941104.git-patchwork-notify@kernel.org>
Date: Thu, 05 Jun 2025 15:20:40 +0000
References: <20250604113252.371528-1-idosch@nvidia.com>
In-Reply-To: <20250604113252.371528-1-idosch@nvidia.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrea.mayer@uniroma2.it,
 dsahern@kernel.org, horms@kernel.org, david.lebrun@uclouvain.be,
 petrm@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 4 Jun 2025 14:32:52 +0300 you wrote:
> The kernel currently validates that the length of the provided nexthop
> address does not exceed the specified length. This can lead to the
> kernel reading uninitialized memory if user space provided a shorter
> length than the specified one.
> 
> Fix by validating that the provided length exactly matches the specified
> one.
> 
> [...]

Here is the summary with links:
  - [net] seg6: Fix validation of nexthop addresses
    https://git.kernel.org/netdev/net/c/7632fedb266d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



