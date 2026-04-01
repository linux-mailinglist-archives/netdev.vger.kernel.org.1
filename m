Return-Path: <netdev+bounces-273831-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNKsDrl+zGl/TQYAu9opvQ
	(envelope-from <netdev+bounces-273831-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:11:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 394DF373A76
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 04:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5567F3030B08
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 02:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C55483164A9;
	Wed,  1 Apr 2026 02:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rK8ywv1Q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2672313E1D;
	Wed,  1 Apr 2026 02:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775009424; cv=none; b=HLPWEujjqkQpDP20je4x7WTMI1niy1DgdrUKSADa8ROvb0byBMhHGWB/+KYJ6KwmHqwfFeAQcdZmJ2u8PCO+v6yk2p1RKbPbzlubEw4WNbuHy9rfydcTYO4iGkHlwkEqYZwEx58/sXYJXfS2A4jJkWpqhu4ZZLmTCrZpz5aCl6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775009424; c=relaxed/simple;
	bh=+Ksi1XCXIWGP3i90WnCVs3nm8z+EhgpN13aJj1UvCpQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IvOFp0a+TCkDqcap7yzD6DU3R8TK2DA0hWsbOnabukTTxRC5alTrPBblgZzc4kPon1/y9W9eVc1FEUGU5uwTllztp8Gh2cmASYHMDso0KlXXOdN94KbvrWjQrmFhyb1fMVJVTRilLeEmqw7cdS42kW2Ks5MSbiQ8isj8VSHw0Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rK8ywv1Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74CFBC2BCB2;
	Wed,  1 Apr 2026 02:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775009424;
	bh=+Ksi1XCXIWGP3i90WnCVs3nm8z+EhgpN13aJj1UvCpQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rK8ywv1Q3UujMUyo4H6i9g2oOC/Eee9O8MOanKPQg2LaQ3pixi2EhOO+1+ABJhE3n
	 0mCbMCCmhQRdxC6LrVD5za9CVZwfyhAUieehk+iBB2ca/vL7lonC5/S4LvolywW2dl
	 8H8aMqc22w/rDlqjMMdjK+LkHQmBH/BSFmAesgb22frQg9aJM1FklGeNm9KNPd5Ux1
	 C9UK4UDrJOe1q/sP888Jo9Dz0FoE9P2xR8dSq+CQaXBTb8+6VJq10VC8WW/1KvzOFJ
	 u6BszL3zc/PC14ftPZDTqGGw6MtdXj15L0cmLukiDsTeJDvrUJx9OptSTknO5T39c8
	 6BEqlY2UspFTg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D5C3808203;
	Wed,  1 Apr 2026 02:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/1] net: ipv6: flowlabel: defer exclusive option free
 until
 RCU teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177500940754.3032542.13943967235330405291.git-patchwork-notify@kernel.org>
Date: Wed, 01 Apr 2026 02:10:07 +0000
References: 
 <07351f0ec47bcee289576f39f9354f4a64add6e4.1774855883.git.zcliangcn@gmail.com>
In-Reply-To: 
 <07351f0ec47bcee289576f39f9354f4a64add6e4.1774855883.git.zcliangcn@gmail.com>
To: Yang Yang <n05ec@lzu.edu.cn>
Cc: security@kernel.org, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 afaerber@suse.de, mani@kernel.org, yoshfuji@linux-ipv6.org,
 yifanwucs@gmail.com, tomapufckgml@gmail.com, yuantan098@gmail.com,
 bird@lzu.edu.cn, enjou1224z@gmail.com, zcliangcn@gmail.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-actions@lists.infradead.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,suse.de,linux-ipv6.org,gmail.com,lzu.edu.cn,vger.kernel.org,lists.infradead.org];
	TAGGED_FROM(0.00)[bounces-273831-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[21];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 394DF373A76
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 30 Mar 2026 16:46:24 +0800 you wrote:
> From: Zhengchuan Liang <zcliangcn@gmail.com>
> 
> `ip6fl_seq_show()` walks the global flowlabel hash under the seq-file
> RCU read-side lock and prints `fl->opt->opt_nflen` when an option block
> is present.
> 
> Exclusive flowlabels currently free `fl->opt` as soon as `fl->users`
> drops to zero in `fl_release()`. However, the surrounding
> `struct ip6_flowlabel` remains visible in the global hash table until
> later garbage collection removes it and `fl_free_rcu()` finally tears it
> down.
> 
> [...]

Here is the summary with links:
  - [1/1] net: ipv6: flowlabel: defer exclusive option free until RCU teardown
    https://git.kernel.org/netdev/net/c/9ca562bb8e66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



