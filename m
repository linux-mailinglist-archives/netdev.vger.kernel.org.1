Return-Path: <netdev+bounces-110995-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C9DBC92F361
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 03:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0152A1C219FA
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 01:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 486EC6FD0;
	Fri, 12 Jul 2024 01:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jtP5j/j5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0904A3D;
	Fri, 12 Jul 2024 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720747232; cv=none; b=S0YSw996CqRxhPeCW2gk/LVAuv8th2xxtMsAMynnMyvs8L/bNDDSURUavh9Gv1YfDk0h46NTfkP+J6sZjMqrWrZlgR9c95q87s5R+PmWIHhD46g1RE2p9U5Pl8KTRAGbR4VVVuBP6kVtOCClOMYGfT6/kcqxtxOut1oFWMSpEhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720747232; c=relaxed/simple;
	bh=YYEVwX5fFwqXSybfJsHPpFva9pFyBW1Ezfs7IMC1A7Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=B5Pmw/FsGIxW2EyHUlIDq8ggy+4EP98Tfgcg5h6IvJZ6rZjaQMCv/8ObiyDYIFq8K/OHTjAWY2Hu+wkeL2bWxOvJq3GwUYDWuii/nROK1iS3BK4GLEM7SMPW1YW4JKj5KzGaEr3RQVTYBVdWoU+ZKvJPEH/dR5mbEPfTJwwwQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jtP5j/j5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 94EEAC4AF09;
	Fri, 12 Jul 2024 01:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720747231;
	bh=YYEVwX5fFwqXSybfJsHPpFva9pFyBW1Ezfs7IMC1A7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jtP5j/j5rHkrIwOBZQXwfOXh7rkG9eHyu1+QVmksG4BaIVuIiXSK6OMJppMDR6vD+
	 sORNubHCUYf/dtqyvrKl9UMUfghEPBOylvg98b42LwCt3PNiCZfewUMmMJmQJ7XsBO
	 Np7weUhHQxzLKKN1WZM1ScGOFBTg+JoDWKS4wyTHksGRdF9xyZkU8yVOzItc8smxz2
	 7ExMNEtSVW/MvHARt4preL12RnibGD6kf+LGupGm+ObQ98BuPxC1ztJX86V7K07n1q
	 wyXAyI92YYuq72QiZiY7wlJSPpvmM3CZlrO9Nh5OQ1TNpywmhwkKObhwARyGMX1lPl
	 NT4ixUv/z08BQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 88E6AC433E9;
	Fri, 12 Jul 2024 01:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: psample: fix flag being set in wrong skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172074723155.25041.14359118298478567151.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 01:20:31 +0000
References: <20240710171004.2164034-1-amorenoz@redhat.com>
In-Reply-To: <20240710171004.2164034-1-amorenoz@redhat.com>
To: =?utf-8?q?Adri=C3=A1n_Moreno_=3Camorenoz=40redhat=2Ecom=3E?=@codeaurora.org
Cc: netdev@vger.kernel.org, echaudro@redhat.com, yotam.gi@gmail.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 aconole@redhat.com, idosch@nvidia.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jul 2024 19:10:04 +0200 you wrote:
> A typo makes PSAMPLE_ATTR_SAMPLE_RATE netlink flag be added to the wrong
> sk_buff.
> 
> Fix the error and make the input sk_buff pointer "const" so that it
> doesn't happen again.
> 
> Acked-by: Eelco Chaudron <echaudro@redhat.com>
> Fixes: 7b1b2b60c63f ("net: psample: allow using rate as probability")
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: psample: fix flag being set in wrong skb
    https://git.kernel.org/netdev/net-next/c/8341eee81c79

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



