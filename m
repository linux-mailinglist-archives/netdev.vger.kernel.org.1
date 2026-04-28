Return-Path: <netdev+bounces-281591-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK34HysX8GmNOQEAu9opvQ
	(envelope-from <netdev+bounces-281591-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 04:10:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5E0847C9FA
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 04:10:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C2C5F301DD92
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28C63126A0;
	Tue, 28 Apr 2026 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sZR/lscT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F23A2D5C8E
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777342248; cv=none; b=me7u8lx5bimvbn19uc0k0hb1xXt4x1Lg5a6JIKepmBdIpFvRYTyf0/pONFn1d1/FfunrA1wex9HCQp1LnR+GcRXq8PC6fqFrAiy0WCL5UNeotX+LUX3bXDJKVf1RAdUtYuO+Nyd3nONfwbwJPV8zfoTRxudkpsrUKFt/s5XiggY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777342248; c=relaxed/simple;
	bh=uIzkivd2l2govc4dHxtldlr86wpdnUk7bhkD+P3nNP4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rZ9FWyk4zDpEAe4znno6byhMZyXmWnp5mwFHhfPccpDRbkXtvjiXRN1eISHqG6tSW+N9S/Ax6AmkYkfLcDvBx+1AUdjU+2LTRap7z6ltGqFPWfLwsWvJHUfCM4izeoKIEYNhPMDRyoaznMvubd97fzg0YuEuY7Cq8VajLtNTfa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sZR/lscT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5249DC19425;
	Tue, 28 Apr 2026 02:10:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777342248;
	bh=uIzkivd2l2govc4dHxtldlr86wpdnUk7bhkD+P3nNP4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sZR/lscTP/zir2r9TZALlOM4WXsu3vnRDLok8f1IQAMhl0mSousgYZdJE+BCVDCpk
	 je3x59cDTllPEw6EA6AvamrLXCz6IpZRqzlP8dUeRynN3aRjlPyaLRcpWqEFDSJnkB
	 Y9Pnn0D981J4pk/Au0KqUkwnOR2/lzdWkkqcsMZGLlv2uzlT1TTCpo7khnJeNtuk5R
	 GhwmnQ5exCRLlbH0puh/nbgkmlF5hV2E8LIZHioe1E17Bzmsj5Lii+65PSAtGSaFC/
	 J4na05ufjoMJczkPnmfporSUgk+tqqYzHM0fQAaFezXixo7pHkysrPs5PlJ8kGxbgc
	 sP3zfT2NL0UTA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E4E392FFDF;
	Tue, 28 Apr 2026 02:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] neigh: let neigh_xmit take skb ownership
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177734220555.202398.4957273119112307109.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 02:10:05 +0000
References: <20260424145843.74055-1-fw@strlen.de>
In-Reply-To: <20260424145843.74055-1-fw@strlen.de>
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuniyu@google.com,
 idosch@nvidia.com
X-Rspamd-Queue-Id: E5E0847C9FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-281591-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 24 Apr 2026 16:58:38 +0200 you wrote:
> neigh_xmit always releases the skb, except when no neighbour table is
> found. But even the first added user of neigh_xmit (mpls) relied on
> neigh_xmit to release the skb (or queue it for tx).
> 
> sashiko reported:
>  If neigh_xmit() is called with an uninitialized neighbor table (for
>  example, NEIGH_ND_TABLE when IPv6 is disabled), it returns -EAFNOSUPPORT
>  and bypasses its internal out_kfree_skb error path.  Because the return
>  value of neigh_xmit() is ignored here, does this leak the SKB?
> 
> [...]

Here is the summary with links:
  - [net] neigh: let neigh_xmit take skb ownership
    https://git.kernel.org/netdev/net/c/4438113be604

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



