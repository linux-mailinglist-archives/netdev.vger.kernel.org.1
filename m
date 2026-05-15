Return-Path: <netdev+bounces-288135-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0DfHHFBwBmp9jwIAu9opvQ
	(envelope-from <netdev+bounces-288135-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:01:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B2E5483F2
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 03:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A130330045A5
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 01:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08614340A57;
	Fri, 15 May 2026 01:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7/MO6pM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA462318EE1
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 01:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778806860; cv=none; b=px7kDWOHpZUR30P5UeLAQEFeAmAVcqGLY/oqkodFCKhtxgUoLTJ8mfLfsHj2oVWFXR/4XQbK6NNiXBEQDBf1XgICMe+3H5YHLfiGG6dEAvJ4L0ewcVCh/aK5uJvQZ39+hew1T04OKGfmGZWvSC8Jfyu/Zuc8yGHR3WTmufv/2rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778806860; c=relaxed/simple;
	bh=948U29XZRbu+3EAj5majYTcVnJ9Ilgv3324VueONyyA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rErVE0yDnw+TnUIFSNy78Z3vN3w5+UHieOuN955i36LdzAJbZfSHblUJE/25CpGvFWafi/XkmyV5Iea3pkleO7OAadNbts+C3C3vflV2mVHHj0t2YLmix0z+VyqvpgLtrvR7nVFZUS+XKIRzn/zOUWeR3VmTfWnQKHykeIF1hN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7/MO6pM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7929CC2BCB3;
	Fri, 15 May 2026 01:01:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778806860;
	bh=948U29XZRbu+3EAj5majYTcVnJ9Ilgv3324VueONyyA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=O7/MO6pMm9M01jE3h71J3keUfwq55Ti8fg80BX30X7MqCUh+sD92lp5UEZVmcnBXh
	 wH6E0gvNVHnBj0kYSKOIb7GiEmIMTc2g8FJka3QPBsje4tR1lWfFewLa5nIPuD8sKV
	 11YgP85ycN2nI4Phrg5f9cGaj1ew2WAGWvku+p9NlqMM3DxmBzLJ059HuccP+jtTN4
	 +pUxmJNrp3eFTgsh4v5yX6Z3+e+UaG+hYQoQ7xu5bPNhTcaI+Sb4AkJv7wThdOuN04
	 PUVCxQdxPc9z/TyYUReFRn+i85VAHIN8aXDKpj9GrRJ/WEC3qYj0byBoEmJQ4iWXn5
	 2NvM10bhT5l9w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDC939E4DB5;
	Fri, 15 May 2026 01:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: skbuff: preserve shared-frag marker during
 coalescing
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177880680505.144258.11032558972341805059.git-patchwork-notify@kernel.org>
Date: Fri, 15 May 2026 01:00:05 +0000
References: <20260513041635.1289541-1-vakzz@zellic.io>
In-Reply-To: <20260513041635.1289541-1-vakzz@zellic.io>
To: William Bowling <vakzz@zellic.io>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com,
 herbert@gondor.apana.org.au, dsahern@kernel.org
X-Rspamd-Queue-Id: E5B2E5483F2
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
	TAGGED_FROM(0.00)[bounces-288135-lists,netdev=lfdr.de,netdevbpf];
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
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 May 2026 04:16:35 +0000 you wrote:
> skb_try_coalesce() can attach paged frags from @from to @to.  If @from
> has SKBFL_SHARED_FRAG set, the resulting @to skb can contain the same
> externally-owned or page-cache-backed frags, but the shared-frag marker
> is currently lost.
> 
> That breaks the invariant relied on by later in-place writers.  In
> particular, ESP input checks skb_has_shared_frag() before deciding
> whether an uncloned nonlinear skb can skip skb_cow_data().  If TCP
> receive coalescing has moved shared frags into an unmarked skb, ESP can
> see skb_has_shared_frag() as false and decrypt in place over page-cache
> backed frags.
> 
> [...]

Here is the summary with links:
  - [net] net: skbuff: preserve shared-frag marker during coalescing
    https://git.kernel.org/netdev/net/c/f84eca581739

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



