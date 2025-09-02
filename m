Return-Path: <netdev+bounces-219350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAD1B41084
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 01:02:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B803BB1E7
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DAB2C15A2;
	Tue,  2 Sep 2025 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDiqexji"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A01832882DC
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 23:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756854030; cv=none; b=LFRd1iFAQAuebCs9s7arUip5EZIlq60PgYFm/IoJdm/gfxnvf3KxGRqE6XDUkF+lTKljU57hrhNx1hoee0HphLFXsLFQTkfVC39r0yO0BHlIQ/eJn8Z88QgnRmgPxQVkBsGv0RfTyihGMC875tKLK4QjxYfltcvNkGw2Kwz7RSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756854030; c=relaxed/simple;
	bh=gtm7v3jQiV9V2Cz6/JuW9vQcmn+3FeF0HT/yA6Jw7d8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SaV2UhcDb7p5qPpakZPICwSPxhoQqKDM2Xs5NRdl9Ux02u00bNk5CcJZl3oRDzeFC4PQcG3bxDPVN0Cy34HY/DifthpkZsLoCW3xbFD63/da1sRU4ib49N7+aHu7f9e90cszDHaMlX8+lBSGb6jcdr/a+vA8XX8QqH3VTHiyPRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDiqexji; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D8DDC4CEFA;
	Tue,  2 Sep 2025 23:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756854030;
	bh=gtm7v3jQiV9V2Cz6/JuW9vQcmn+3FeF0HT/yA6Jw7d8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bDiqexjiLujhXpx6wJRPtLR6St7R625MioBX1KlRyrWp/Sfzh6I/XU79Tx3bOzqLf
	 R/dvWeYl776pqN/cR1ex92MmsBOeYHtkrATpO6uizxyKba2Cyql3fSjwl3c9z1ItmN
	 ap0rfnbg25+wBEDVd5ghmDDO96yOYlasOqDO9n/WGThS/XeLUfaT0WEra0f4XmssW4
	 /9ZWMcopWU6qVjt27ausENpGnev3NGNJfaIk8gH0XS6njrg8w+bCuv25hMisBhwWVI
	 doGEp8Jb4w3emO/ZI9R0wEV1YWsCZZoJzZvk+0AHnzfNH7CIuVyyx19WDgEHY0J4Dk
	 WYS6Zq+pnaRLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADD3C383BF64;
	Tue,  2 Sep 2025 23:00:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net_sched: add back BH safety to tcf_lock
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175685403524.461360.2064454499942884372.git-patchwork-notify@kernel.org>
Date: Tue, 02 Sep 2025 23:00:35 +0000
References: <20250901092608.2032473-1-edumazet@google.com>
In-Reply-To: <20250901092608.2032473-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Sep 2025 09:26:07 +0000 you wrote:
> Jamal reported that we had to use BH safety after all,
> because stats can be updated from BH handler.
> 
> Fixes: 3133d5c15cb5 ("net_sched: remove BH blocking in eight actions")
> Fixes: 53df77e78590 ("net_sched: act_skbmod: use RCU in tcf_skbmod_dump()")
> Fixes: e97ae742972f ("net_sched: act_tunnel_key: use RCU in tunnel_key_dump()")
> Fixes: 48b5e5dbdb23 ("net_sched: act_vlan: use RCU in tcf_vlan_dump()")
> Reported-by: Jamal Hadi Salim <jhs@mojatatu.com>
> Closes: https://lore.kernel.org/netdev/CAM0EoMmhq66EtVqDEuNik8MVFZqkgxFbMu=fJtbNoYD7YXg4bA@mail.gmail.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net_sched: add back BH safety to tcf_lock
    https://git.kernel.org/netdev/net-next/c/3016024d7514

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



