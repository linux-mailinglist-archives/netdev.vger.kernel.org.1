Return-Path: <netdev+bounces-46314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C787E329C
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 02:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DF7FB20A96
	for <lists+netdev@lfdr.de>; Tue,  7 Nov 2023 01:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8688817F4;
	Tue,  7 Nov 2023 01:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7fSQafE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0241FA6
	for <netdev@vger.kernel.org>; Tue,  7 Nov 2023 01:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E9A97C433C9;
	Tue,  7 Nov 2023 01:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699320626;
	bh=9zdXdq10cSrmMgMXyciW+Tv7zg9+W74gMlWjBVf/2l8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i7fSQafEflDIBbXn47zL1KjEvlX2SnKW/jcmsZttHVfCHImQ1F8FgOceEQ0l3Fzjo
	 uuHhy6LTHNRkKoo0P74Nc0+83HS2PGq/0reLQzARnPTebghY8+3BqgruXGXyZSMV+Y
	 W5RvM04S3DluGhpxMczTOsAO7SpFmM9AaTiAypSG1Is51h53x+szCpZUpoAVQwkWXx
	 ecx5bZZl+O6N6zFYlhDuWW9oWym2PQ3IltepLhznP32jc3l7ZON+45UtZtgUp9j//g
	 E+uaQWi+MEYfpayXoAGXLkRQc0Tyf32k4y27iwDJEpRMaM26AK7DXnTaIe3OKxZmy+
	 apO/mnE6TkQVQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C652FC00446;
	Tue,  7 Nov 2023 01:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] idpf: fix potential use-after-free in idpf_tso()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <169932062580.409.286762519826902863.git-patchwork-notify@kernel.org>
Date: Tue, 07 Nov 2023 01:30:25 +0000
References: <20231103200451.514047-1-edumazet@google.com>
In-Reply-To: <20231103200451.514047-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, joshua.a.hay@intel.com,
 alan.brady@intel.com, madhu.chittim@intel.com, phani.r.burra@intel.com,
 sridhar.samudrala@intel.com, willemb@google.com, pavan.kumar.linga@intel.com,
 anthony.l.nguyen@intel.com, bcf@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Nov 2023 20:04:51 +0000 you wrote:
> skb_cow_head() can change skb->head (and thus skb_shinfo(skb))
> 
> We must not cache skb_shinfo(skb) before skb_cow_head().
> 
> Fixes: 6818c4d5b3c2 ("idpf: add splitq start_xmit")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Joshua Hay <joshua.a.hay@intel.com>
> Cc: Alan Brady <alan.brady@intel.com>
> Cc: Madhu Chittim <madhu.chittim@intel.com>
> Cc: Phani Burra <phani.r.burra@intel.com>
> Cc: Sridhar Samudrala <sridhar.samudrala@intel.com>
> Cc: Willem de Bruijn <willemb@google.com>
> Cc: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
> Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> Cc: Bailey Forrest <bcf@google.com>
> 
> [...]

Here is the summary with links:
  - [net] idpf: fix potential use-after-free in idpf_tso()
    https://git.kernel.org/netdev/net/c/115c0f4d5857

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



