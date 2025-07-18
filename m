Return-Path: <netdev+bounces-208066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FDEAB0997D
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 04:00:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D89CC3BF5E4
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 01:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D001922C4;
	Fri, 18 Jul 2025 02:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6Hp2NN0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A27191F89;
	Fri, 18 Jul 2025 02:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752804002; cv=none; b=LMf0Ezh+hvFCVnFsULrEgWoaFsm6LxPGZE/ArweHA/cfuql2Ld425hC6zDE8Zcz0TUb3uEZJhvpuspYOUVqA7AFXWH3guhmwnYJ5qqT8GTcs2bMGbzaa9/AsUQAMgXB//VNBuAMoaYs/Kab1yCnV6Fl2ivUYS/jFnLQPIwXYcL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752804002; c=relaxed/simple;
	bh=SetBbtHXbVjZbmiyk0fpeigIcr80OzEqkRC6pQfTTTo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HvjTdFlcphGBDzHAnCd08QuMKDzipjKWvEZzShPzcukgOqZrODuq+PrT9tgLId0qGhXPmyXbKdCV2hSnJosjCNl0oS+ayPXPJR+4N7kn7FcYsYYo3p+SYSgIKxuA3KByto60ZrNppbzlmiUlwS8cA5wcLtDO2Vm+9DiXLEwHzy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6Hp2NN0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53251C4CEE3;
	Fri, 18 Jul 2025 02:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752804002;
	bh=SetBbtHXbVjZbmiyk0fpeigIcr80OzEqkRC6pQfTTTo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=H6Hp2NN0qSoS08Ezwyaaae0ALZyNHDflwHoRDeC3FJ4y1AIl5BV5CmV0stAEB9hgd
	 nejk0vs+I0lriY3Ou2g9fgTHO15C68fXP6YW5vzaBHne8xH2rb9EFdJaAnpTmTYQVr
	 1B9H9+YJkQcYTRNLbkTZUu/R5l89NllR4wHOho112EvSr+Hnf5Cmwp+1XvuYGualhn
	 y4o8ZJlhKAS38T7LLZS7Lmjo6GEml6n1fv8UAFZ+omT3s/dy6NMcx1hK3lzEiPk51V
	 REZT2929lolW4QtgNUgfFjvlGc5Yn+ub8xdXUvVf2p6QzMugj9vWgnr1T5OYRC1d1F
	 euZUy2fhJYsEw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D1E383BA3C;
	Fri, 18 Jul 2025 02:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ethernet: mtk_wed: Fix NULL vs IS_ERR() bug
 in
 mtk_wed_get_memory_region()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175280402175.2141855.8758462175684517580.git-patchwork-notify@kernel.org>
Date: Fri, 18 Jul 2025 02:00:21 +0000
References: <87c10dbd-df86-4971-b4f5-40ba02c076fb@sabinyo.mountain>
In-Reply-To: <87c10dbd-df86-4971-b4f5-40ba02c076fb@sabinyo.mountain>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: robh@kernel.org, nbd@nbd.name, sean.wang@mediatek.com, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, kernel-janitors@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Jul 2025 18:01:19 -0500 you wrote:
> We recently changed this from using devm_ioremap() to using
> devm_ioremap_resource() and unfortunately the former returns NULL while
> the latter returns error pointers.  The check for errors needs to be
> updated as well.
> 
> Fixes: e27dba1951ce ("net: Use of_reserved_mem_region_to_resource{_byname}() for "memory-region"")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> 
> [...]

Here is the summary with links:
  - [net-next] net: ethernet: mtk_wed: Fix NULL vs IS_ERR() bug in mtk_wed_get_memory_region()
    https://git.kernel.org/netdev/net-next/c/c2fe3b2a7c71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



