Return-Path: <netdev+bounces-57198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CBC812558
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E82A21F21A91
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 610EB81E;
	Thu, 14 Dec 2023 02:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rFDA+nr7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38773393;
	Thu, 14 Dec 2023 02:40:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id D069DC433C9;
	Thu, 14 Dec 2023 02:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702521625;
	bh=rSEkVppOSVp3U7mpXX0xxO5F5GbcJeH95BX98axL9zM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rFDA+nr79uUVmdYCblim2LQ5fbwT3XnRdXogE8AvDQnm+k7OrvRkH2Rbe29VGWpae
	 Y/9axyvLUG+ghDePPq10noq6MhY55hyvTq4uE+wI+D9NEMP1yLo/en9vXxMPtGb4lQ
	 0Z2xMyhCTuZ3IBBImjLe8fw4fXsfvfHwPiZY0JFfTpgP4a1eOaHXnivjT1fUstzfV8
	 PeDvs30MfTA1hhvXeQJvsc+UBA/T3FxBxDKZ+fD7gJzW+PQu0sfJ2WACmuQ1CryHZY
	 8OavsAeJLQNUONK1tRLNMPe6twMtApLgzT/EkNiN4amkyO5kVLbcJOQLq8mrcT4p/C
	 kjJJCC9BE4mDQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B43C6C4314C;
	Thu, 14 Dec 2023 02:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cxgb3: Avoid potential string truncation in desc
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170252162573.2494.15854060448020289393.git-patchwork-notify@kernel.org>
Date: Thu, 14 Dec 2023 02:40:25 +0000
References: <20231212220954.work.219-kees@kernel.org>
In-Reply-To: <20231212220954.work.219-kees@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: rajur@chelsio.com, lkp@intel.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 12 Dec 2023 14:09:57 -0800 you wrote:
> Builds with W=1 were warning about potential string truncations:
> 
> drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c: In function 'cxgb_up':
> drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:394:38: warning: '%d' directive output may be truncated writing between 1 and 11 bytes into a region of size between 5 and 20 [-Wformat-truncation=]
>   394 |                                  "%s-%d", d->name, pi->first_qset + i);
>       |                                      ^~
> In function 'name_msix_vecs',
>     inlined from 'cxgb_up' at drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:1264:3: drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:394:34: note: directive argument in the range [-2147483641, 509]
>   394 |                                  "%s-%d", d->name, pi->first_qset + i);
>       |                                  ^~~~~~~
> drivers/net/ethernet/chelsio/cxgb3/cxgb3_main.c:393:25: note: 'snprintf' output between 3 and 28 bytes into a destination of size 21
>   393 |                         snprintf(adap->msix_info[msi_idx].desc, n,
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   394 |                                  "%s-%d", d->name, pi->first_qset + i);
>       |                                  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - cxgb3: Avoid potential string truncation in desc
    https://git.kernel.org/netdev/net-next/c/bc044ae9d64b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



