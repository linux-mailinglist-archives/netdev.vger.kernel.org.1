Return-Path: <netdev+bounces-275819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oOKqBPVi1GlAtgcAu9opvQ
	(envelope-from <netdev+bounces-275819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:50:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A51083A8CE7
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 03:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EAC5D30055AE
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 01:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D297C1F63D9;
	Tue,  7 Apr 2026 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tRI4K8kq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD41913FEE;
	Tue,  7 Apr 2026 01:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775526640; cv=none; b=XuK9tT5DhVbpukMXKTwM20LEWAQNvVCGHjR+rOBv8YnSE9kULS4iGyTQ+mt7zibpWo7GzdsH2eIrBKCa6fGMQsdsUUpF+MOsOK/iBBWZrt2CScGd3pRb/eTiGve2i5IM8Jwh2On68rI2SRIwgqFm4MjK3e+nAjJNz2lGPAqoU6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775526640; c=relaxed/simple;
	bh=0obfm49yDlpcsgQJ7+WY11t9WRcyFFb3tzvnm91DD0E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ckD3/MAxw0ZPixR1u/7d6QGI1yF9o7OHQDw8b5RKriZHJd/+1cr83IcuLQSeMb2PHeMmTvQBtM3MM15VO3GXC9KTWiRfENj+zweronHxCGmOseyzk0BRFde2fK0SIuOYNTAjmTIjX/fk/Gxtyxr8tMNu6fCvymTfSUPS4PIQS8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tRI4K8kq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FD34C4CEF7;
	Tue,  7 Apr 2026 01:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775526640;
	bh=0obfm49yDlpcsgQJ7+WY11t9WRcyFFb3tzvnm91DD0E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tRI4K8kqGzf7DbS6znc1SF6rgSud2wS6iZLYnYZpwyEqtWL8wDUf8/eU7qUgxTzPP
	 7L3W+tRJwLFeJmL0DdE07cSBB6DUXsPyqB/qmGE8OwBKGPsAUnw9yiqP6ruK3eEBoN
	 AqdBJ7BsyszNaWM6Vjr968fTegQet58Wkje4oWV69tavh6V6w9QD+O+MlpLHBx8yPN
	 EbeTELELe67AHV0VLBAu6fy0Yp3G03tdM2H8R3mXwpQ6dwwuHSXa/kba9qBwVXJjLG
	 vBHtl98sETIwSClnh0qv8QH+lluCNm2gmZqsYRXvcWezBItcGrysUYTMxvG4jj0MHQ
	 h6uT42hPq/Ksg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E0D3809A28;
	Tue,  7 Apr 2026 01:50:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: skb: fix cross-cache free of KFENCE-allocated
 skb
 head
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552661855.3337768.4891297868574815867.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:50:18 +0000
References: <20260403014517.142550-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260403014517.142550-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, antonius@bluedragonsec.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kerneljasonxing@gmail.com, kuniyu@google.com, mhal@rbox.co,
 almasrymina@google.com, ebiggers@google.com, toke@redhat.com,
 alexanderduyck@fb.com, soheil@google.com, linux-kernel@vger.kernel.org,
 bpf@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,bluedragonsec.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,rbox.co,fb.com];
	TAGGED_FROM(0.00)[bounces-275819-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A51083A8CE7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  3 Apr 2026 09:45:12 +0800 you wrote:
> SKB_SMALL_HEAD_CACHE_SIZE is intentionally set to a non-power-of-2
> value (e.g. 704 on x86_64) to avoid collisions with generic kmalloc
> bucket sizes. This ensures that skb_kfree_head() can reliably use
> skb_end_offset to distinguish skb heads allocated from
> skb_small_head_cache vs. generic kmalloc caches.
> 
> However, when KFENCE is enabled, kfence_ksize() returns the exact
> requested allocation size instead of the slab bucket size. If a caller
> (e.g. bpf_test_init) allocates skb head data via kzalloc() and the
> requested size happens to equal SKB_SMALL_HEAD_CACHE_SIZE, then
> slab_build_skb() -> ksize() returns that exact value. After subtracting
> skb_shared_info overhead, skb_end_offset ends up matching
> SKB_SMALL_HEAD_HEADROOM, causing skb_kfree_head() to incorrectly free
> the object to skb_small_head_cache instead of back to the original
> kmalloc cache, resulting in a slab cross-cache free:
> 
> [...]

Here is the summary with links:
  - [net,v2] net: skb: fix cross-cache free of KFENCE-allocated skb head
    https://git.kernel.org/netdev/net/c/0f42e3f4fe2a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



