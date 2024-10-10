Return-Path: <netdev+bounces-134144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7385099828B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 11:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 163B01F22830
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 09:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698D41BC066;
	Thu, 10 Oct 2024 09:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGugQCpA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458AE19258C
	for <netdev@vger.kernel.org>; Thu, 10 Oct 2024 09:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728553227; cv=none; b=a88SigRCZ/JsJJ+T+50S9Y7gH0SSoF8QPXbjmW3qyUHi0yq6ZTLPYNMAf8fUIaPoyXJZskLCUgNRX073Syxb/bLjdcKusfDOk/pl5+acy6ijyDWmn7wDWOiYhEiDi0ptXbhtQaP3OXlpXa7kA+6LzVfvQV+ROf+13xQipyUGZ/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728553227; c=relaxed/simple;
	bh=fwKPT8G9cI/6zlxNWF9/+LXZ50IaO52ekouiR3McYAg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CWimaVAWfEkXc7DClFrVetIm0uHAQU1ggJHADikdu1PtCxsWK7WBvZCZxY/1npG9+HROmsNssnrr3zAFpnJm+O3W9y4KX3jBDxxJsSURx251t/KLzeWVxqaXlqbXcWosiupKwbNh+7mF38niwMzC11ExLovZwZbT1Ki1kiPzypo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGugQCpA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3563C4CEC5;
	Thu, 10 Oct 2024 09:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728553226;
	bh=fwKPT8G9cI/6zlxNWF9/+LXZ50IaO52ekouiR3McYAg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UGugQCpA9Uih2ln46k7HEZz3Uc4G7equ4lPzKBoFw/BCiMI9+QdootvEGJUMKzc4q
	 UxeDCOzSByfK2KeW7w6kr1aJf1V6N0IjNvAq5UPLKkz+lo87O2utwp//bUuz8/Mprz
	 sjIp55gZQxdBUYGANmpNMcVU+VfF+IkDYDb6T65g4vtrCNpVfPBJPj68zWIeqShVj7
	 ZR9VyFm5O+Fy9PeevzoTpO0kTdy06THejp9eslBL1TQA3+IRYGjQYiFNpN1im4EynN
	 634N6I9jxmcP0ecU4RWbSloyqAdOwuQB1uVg/qfUpLGV3UiT+YVwOc7Glkv18+Vsz6
	 QbK6lPSa2iUvQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E873803263;
	Thu, 10 Oct 2024 09:40:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: do not delay dst_entries_add() in dst_release()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172855323128.1952428.15843257578656374607.git-patchwork-notify@kernel.org>
Date: Thu, 10 Oct 2024 09:40:31 +0000
References: <20241008143110.1064899-1-edumazet@google.com>
In-Reply-To: <20241008143110.1064899-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, naresh.kamboju@linaro.org,
 lkft@linaro.org, lucien.xin@gmail.com, steffen.klassert@secunet.com

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue,  8 Oct 2024 14:31:10 +0000 you wrote:
> dst_entries_add() uses per-cpu data that might be freed at netns
> dismantle from ip6_route_net_exit() calling dst_entries_destroy()
> 
> Before ip6_route_net_exit() can be called, we release all
> the dsts associated with this netns, via calls to dst_release(),
> which waits an rcu grace period before calling dst_destroy()
> 
> [...]

Here is the summary with links:
  - [net] net: do not delay dst_entries_add() in dst_release()
    https://git.kernel.org/netdev/net/c/ac888d58869b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



