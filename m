Return-Path: <netdev+bounces-274338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qGN0OXDczWmliQYAu9opvQ
	(envelope-from <netdev+bounces-274338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:03:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3C0382EBF
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 788D8305542E
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 03:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DC7B352C51;
	Thu,  2 Apr 2026 03:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C9iYTT4r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B41333F5BD
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 03:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775098827; cv=none; b=U183z3mhlxwTdk5jDXKgN1g62oBpg4HQQ52zIXtiZCnGmVALwRIiDhVM3SjZ2nzcrXm60B6X4unbjpR7ob59FqCQBYj8Wx7GuFLPdSHDrzCT/8TtcH6s4Ir0Bpeh8+rilbtgGhHXCMuWUFfDIJ1AGBRO+c08m51F7rxG1pgassI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775098827; c=relaxed/simple;
	bh=/4lOMunxi9ShGwn4euLA0Eur+izGkkrnm06TTE9GlhU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PVN7ieJUiWL70h8w06THG+lJn/wmtX7b7bfRfVIXdb/LSkZQwmHKpZ0qyfzu8Rk6BDK5ZX1KNvh7XPK8gIRyeZlkjZ2W3LTejnQ/LqXExosPF39ADtl06lGzhTaQq0FuD3gO5Okyhcs3v75yYRUaSa5E59Hepwvk8AC4RduNj+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C9iYTT4r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22FDC4CEF7;
	Thu,  2 Apr 2026 03:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775098826;
	bh=/4lOMunxi9ShGwn4euLA0Eur+izGkkrnm06TTE9GlhU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=C9iYTT4rpcf572uGkYLNpi0ArYVYKCSPM00MO65ZoOefo7xZ2dKrWnx2nUT1mN5Va
	 g14HtHSvtq89eu2Ddk81xs9E5Vtvg4VIHXaEVC39Z+IEO3FZGvkWRmia1BGnLk/nXF
	 GFZ9iYcXzzvU1XLKAPvgGLGqfQGGYIOSgsVKYNSbvz6hOKWKvYisJYSOiM3umMJaaQ
	 gSobegxIOLxZXvkMXYk6l8f4xokRpomceUg+kt8yK+oWsvqfmWHLHGqS4P2iRpmz1R
	 y6fB2PPvighLCEFqhD48y/2jchcBxbqyBVYKT+YbdlfvMNUPyqWxw8qADNZSERlACp
	 /XBegIJPtpHkA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE123808203;
	Thu,  2 Apr 2026 03:00:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH RESEND net v2 1/1] net/sched: sch_netem: fix out-of-bounds
 access in packet corruption
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177509880929.3966658.1444595257739812877.git-patchwork-notify@kernel.org>
Date: Thu, 02 Apr 2026 03:00:09 +0000
References: 
 <45435c0935df877853a81e6d06205ac738ec65fa.1774941614.git.kanolyc@gmail.com>
In-Reply-To: 
 <45435c0935df877853a81e6d06205ac738ec65fa.1774941614.git.kanolyc@gmail.com>
To: Yucheng Lu <kanolyc@gmail.com>
Cc: security@kernel.org, stephen@networkplumber.org, netdev@vger.kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, Jason@zx2c4.com,
 kees@kernel.org, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 tanyuan98@outlook.com, bird@lzu.edu.cn, z1652074432@gmail.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,networkplumber.org,vger.kernel.org,mojatatu.com,resnulli.us,davemloft.net,zx2c4.com,gmail.com,outlook.com,lzu.edu.cn];
	TAGGED_FROM(0.00)[bounces-274338-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4E3C0382EBF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 31 Mar 2026 16:00:21 +0800 you wrote:
> In netem_enqueue(), the packet corruption logic uses
> get_random_u32_below(skb_headlen(skb)) to select an index for
> modifying skb->data. When an AF_PACKET TX_RING sends fully non-linear
> packets over an IPIP tunnel, skb_headlen(skb) evaluates to 0.
> 
> Passing 0 to get_random_u32_below() takes the variable-ceil slow path
> which returns an unconstrained 32-bit random integer. Using this
> unconstrained value as an offset into skb->data results in an
> out-of-bounds memory access.
> 
> [...]

Here is the summary with links:
  - [RESEND,net,v2,1/1] net/sched: sch_netem: fix out-of-bounds access in packet corruption
    https://git.kernel.org/netdev/net/c/d64cb81dcbd5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



