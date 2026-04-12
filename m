Return-Path: <netdev+bounces-277882-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGafA33122lTJgkAu9opvQ
	(envelope-from <netdev+bounces-277882-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:41:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 625B23E5C18
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 21:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5109D300BDBB
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 19:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DFE37DEA1;
	Sun, 12 Apr 2026 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p2Iwo5Kf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BBDC37D136;
	Sun, 12 Apr 2026 19:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776022837; cv=none; b=lHUZ/PUezGsSlSPwYnGJAmJ+lCu0Z+nbemWVuRsQkezme5qK3SCfPeShemU4IP8MtTGydijoTTkGiexhTCza49z3lqW9ABA2ZeUlyHxU67baVon7O/iw+UiUWFjYw5VYL3ddHGx7Teb5+Cq4jEKzAtS8NSglpekKO6T51rgmKSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776022837; c=relaxed/simple;
	bh=Wfxiu58G1Npcaei5q4mL2q4FDDDTweNDXb9Ws0MaxZw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gYlT49HDBCHug6WU65VUQFq8RdbTfbdVH5eZQadvUxmNZYKXR4h83dbYpL7e/7nhcspXoqnRze+4rovcEy4G7VQPPV74GXA1xLpGXVkxK4hl57hhXCiKC5FdL+nF+nLUfNdsS0oASiXd4Jmg3u+ZFa1dmwpBUSVI3yjUuerXN8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=p2Iwo5Kf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19EA0C19424;
	Sun, 12 Apr 2026 19:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776022837;
	bh=Wfxiu58G1Npcaei5q4mL2q4FDDDTweNDXb9Ws0MaxZw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=p2Iwo5KfBC5Mm/2clsQieaKXBXMJYw6HtRGfGqygqajWYZxjQshZ2Nb3ti5uR6R1Z
	 LnXGFlBn0vTT5bE0VknEmvT5ONZujy7DRQguSiJVTajB+K2BKhG+e29QnVtftSU2nA
	 GqV6/JVbNqYGwcgFMVczdmxkKIIyWb4vwScnrESq/Ag5bjCXAwak7dMGvoNfR3fLw6
	 D8Dmg3qYrfTbmEo//+7J0Fk+AEHYaiG9EsHdxMcN5QzHiH3ImXRWtOTwO+ZpCZjqPb
	 FRV/HtaFs1aUUOlwJBMgELXTemUbBwPrb6L/QnLl/UYF5htcyYXhNF4M+QbDaHypZ+
	 cr+2JwBK+psyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DDF3809A8C;
	Sun, 12 Apr 2026 19:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/3] bpf: fix sock_ops rtt_min OOB read and related
 guard
 issues
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177602280940.3388150.4538633995700155316.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 19:40:09 +0000
References: <20260412030306.3469543-1-werner@verivus.com>
In-Reply-To: <20260412030306.3469543-1-werner@verivus.com>
To: Werner Kasselman <werner@verivus.ai>
Cc: martin.lau@linux.dev, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, john.fastabend@gmail.com, brakmo@fb.com,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-277882-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[linux.dev,kernel.org,iogearbox.net,gmail.com,fb.com,fomichev.me,google.com,davemloft.net,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 625B23E5C18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 12 Apr 2026 03:03:08 +0000 you wrote:
> Patch 3 fixes an out-of-bounds read in sock_ops_convert_ctx_access()
> for the rtt_min context field. It is the only tcp_sock-backed field
> that bypasses the is_locked_tcp_sock guard, so on request_sock-backed
> sock_ops callbacks the converted BPF load reads past the end of a
> tcp_request_sock.
> 
> Patches 1 and 2 are groundwork. Patch 1 fixes a pre-existing info
> leak in SOCK_OPS_GET_FIELD() and SOCK_OPS_GET_SK() where dst_reg is
> left holding the context pointer on the guard-failure branch when
> dst_reg == src_reg, instead of being zeroed. Patch 2 extracts
> SOCK_OPS_LOAD_TCP_SOCK_FIELD() from SOCK_OPS_GET_FIELD() so the
> rtt_min sub-field access in patch 3 can reuse it.
> 
> [...]

Here is the summary with links:
  - [v2,1/3] bpf: zero dst_reg on sock_ops field guard failure when dst == src
    https://git.kernel.org/netdev/net/c/10f86a2a5c91
  - [v2,2/3] bpf: extract SOCK_OPS_LOAD_TCP_SOCK_FIELD from SOCK_OPS_GET_FIELD
    (no matching commit)
  - [v2,3/3] bpf: guard sock_ops rtt_min against non-locked tcp_sock
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



