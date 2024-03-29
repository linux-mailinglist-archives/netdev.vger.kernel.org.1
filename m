Return-Path: <netdev+bounces-83423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D82538923DB
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 20:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D3F91F22F44
	for <lists+netdev@lfdr.de>; Fri, 29 Mar 2024 19:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949D013474E;
	Fri, 29 Mar 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A/hs1CwA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D89132815
	for <netdev@vger.kernel.org>; Fri, 29 Mar 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711739430; cv=none; b=WC1ahFQ5Mk4uUZXLZCuGlYX1UIik8GkcNxt5e131RdcweoDmk76rnnTwaXPoUEYuSMW3/1pH9UcqDxFTTTbLneiieAGTOrs+PkhCIMPRUbJ+QQcttOQe+CvogB2UNOMuAB3GpGsOvCw3/rnhfHkxPQDVpTXESwSsFxUSYhFM1GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711739430; c=relaxed/simple;
	bh=qQt4Igfy5nw1F2/y4wCd9heKUA1Ai9u+eSINdrng6+s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yzh2YwikkO6aEnbnQh/LKQ6ueHYuZP1Wg+3ASymYrtOXmVIJoRg9UfeIrdsZq+F3SUhMjLxf1GytAcs6waXBbjM9VZxGRRHiLGVDCA4y6hSLQK6cbt72sF65yExAdgODVtnvjBjWLanOoN50X86DnjWQV00yMkPLVPGeKkHbv9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A/hs1CwA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04032C433C7;
	Fri, 29 Mar 2024 19:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711739430;
	bh=qQt4Igfy5nw1F2/y4wCd9heKUA1Ai9u+eSINdrng6+s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A/hs1CwAgrohzUKJ4u4zUWdHBYTNUQdKIyEyT/uXRWNsgR8LqS4pmwnhRGRHpVp+r
	 yeKrq0rCeRfew0rkdR3RbfA2cNGQfeCUzEikMTpzF/zMrNgyJycFlygl/MYTvCtNTm
	 vI/mj6+WA5hZLlMEEKkZi0U2aAaqEhLRnuabif4TV+wpMkHOWYzlwgd9d7gEE3swp1
	 NfHmzeOr620sPHyKOyLWjB9Ei16ePS9S3sypdG/TpvVnH9EHvhtp9UsbL5uv7kwQ82
	 hJbobMtmWsoMHMwEo9P2uXadH+/EJkG2pxFlpG8VtXcVJxzxKbgsbJzHD237AorrMv
	 j/YYaFkuRhtcQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E77B4D2D0EE;
	Fri, 29 Mar 2024 19:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/rds: fix possible cp null dereference
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171173942994.5976.9675809107413748004.git-patchwork-notify@kernel.org>
Date: Fri, 29 Mar 2024 19:10:29 +0000
References: <20240326153132.55580-1-mngyadam@amazon.com>
In-Reply-To: <20240326153132.55580-1-mngyadam@amazon.com>
To: Mahmoud Adam <mngyadam@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, eadavis@qq.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 26 Mar 2024 16:31:33 +0100 you wrote:
> cp might be null, calling cp->cp_conn would produce null dereference
> 
> Fixes: c055fc00c07b ("net/rds: fix WARNING in rds_conn_connect_if_down")
> Cc: stable@vger.kernel.org # v4.19+
> Signed-off-by: Mahmoud Adam <mngyadam@amazon.com>
> ---
> This was found by our coverity bot, and only tested by building the kernel.
> also was reported here: https://lore.kernel.org/all/202403071132.37BBF46E@keescook/
> 
> [...]

Here is the summary with links:
  - net/rds: fix possible cp null dereference
    https://git.kernel.org/netdev/net/c/62fc3357e079

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



