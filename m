Return-Path: <netdev+bounces-143181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8CE9C159D
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 05:50:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25CD01F2273C
	for <lists+netdev@lfdr.de>; Fri,  8 Nov 2024 04:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC0D1CBEA7;
	Fri,  8 Nov 2024 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B18O8r0j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF7D1CBE9D
	for <netdev@vger.kernel.org>; Fri,  8 Nov 2024 04:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731041428; cv=none; b=j+UlJJu2xfK3Fn7EfRRAq2lmuHNAdKa1gmSrTEUmuhyI0hfuDe/W0RlVGY6ybYafDsKk/rotjBY16hfJYM0o/ylWzZL1aQo6AhX2epOaRB97Kd+NWlxSJn1qUDzGNtV30plNcoeCl/GfEn9h5BiiHA84LN39AaPuO0Hi3Y/X1yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731041428; c=relaxed/simple;
	bh=Y900hd9IC1URH1MJtGbbAOslXNuj8f5sBr17FDjeI2o=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nHuXuz+uneAf0oIkt7E/pLkKFOa69XhUYs5p6/XfQuD7GKByDZDopyenqtvFwL51f4t131z84Bw/JlJFMWvUtIZsVxtikWxVr+88JxcUmy3FFEntMKoaSQNpbcYW2pkOW53GkCTrfUKGcDckEeHcIAw1wNRd9U8YoptKGSvE/wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B18O8r0j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDDE9C4CECE;
	Fri,  8 Nov 2024 04:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731041425;
	bh=Y900hd9IC1URH1MJtGbbAOslXNuj8f5sBr17FDjeI2o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B18O8r0jD1sJos/teWzD7q++7Fe+WCx5ZNDSsIY9Llf7ZakprrpUnTQuMb7zTF3A6
	 aeXeRP1qsqQ6IsUUHpHtTfpv9OGYNaenfJc49ilIBBt6JDS7z/f7Q22BnKJ/Ma6/w3
	 lUQLadoVoI//yZuHdXIseOVj6oTh9TWrKQ4PcuD68hP0Op9RPv0ZqhSk+I8AV+gcRC
	 FGmmZ4kkyI9Vs0Xr3uv/7s+ndr9eXFc25/jTeD3Yev6irNXJbYPpg2x56o1Hm0Py3E
	 pgStK/5WxjBKmP898cxTKboAMiHk8MpKHs5yt/gDEQA7UovhUqx15pvz5vyP2OuOkA
	 LqMZ3fhiv5C2g==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EF73809A80;
	Fri,  8 Nov 2024 04:50:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next V2] bonding: add ESP offload features when slaves
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173104143499.2196790.16079354425243982948.git-patchwork-notify@kernel.org>
Date: Fri, 08 Nov 2024 04:50:34 +0000
References: <20241105192721.584822-1-tariqt@nvidia.com>
In-Reply-To: <20241105192721.584822-1-tariqt@nvidia.com>
To: Tariq Toukan <tariqt@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, jv@jvosburgh.net,
 andy@greyhouse.net, netdev@vger.kernel.org, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, jianbol@nvidia.com, borisp@nvidia.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 5 Nov 2024 21:27:21 +0200 you wrote:
> From: Jianbo Liu <jianbol@nvidia.com>
> 
> Add NETIF_F_GSO_ESP bit to bond's gso_partial_features if all slaves
> support it, such that ESP segmentation is handled by hardware if possible.
> 
> Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
> Reviewed-by: Boris Pismenny <borisp@nvidia.com>
> Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [net-next,V2] bonding: add ESP offload features when slaves support
    https://git.kernel.org/netdev/net-next/c/4861333b4217

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



