Return-Path: <netdev+bounces-290866-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAgKMeF5EGrdXwYAu9opvQ
	(envelope-from <netdev+bounces-290866-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:44:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C16505B7160
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C6D230F7E31
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 15:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E541F46AF10;
	Fri, 22 May 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E+cZLxwp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93C046AEFE;
	Fri, 22 May 2026 14:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779461999; cv=none; b=KHogveeCRrSYoE6+02uXlvg4LsGEa8k+3GHquBABZem9G0p/T0EGox2KIPMDKkxf0YRTrVLwF6XKtmoM45JI3664lO5rUDR5VQwpAj3X+7RVOQnBHpnni6W8Rt0Wgfmc/cbJppLgW2l/bv7yZqHrpUc9JeD70BxbtPvNeA2eFEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779461999; c=relaxed/simple;
	bh=S0hQdHZhBeBFQW3kcj8icaw57sEmU3onRVHSHv1OavU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gkjAhRcLsnLd+AmruGLjLeKD9bdFzjzJlvvMMA8mMEeR8gLc8iJmw+sXc6w1MVIv471frT9F40paBk1adcR9n9934vPogCqr7GpIvDoeGqI4Z0ETyptYMz0FS14++knEZycnLNoEEILuw8zY9MU8YLHEs/vmxsGe7nwKqy6/i/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E+cZLxwp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61A4E1F000E9;
	Fri, 22 May 2026 14:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779461998;
	bh=uYuIgDF7ZLsLphlySvM47YKI+qrwb+yitye1fIxzAO4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=E+cZLxwpSwsgaAgrEPcNYBfxa7AWqkDEGmdlRS82TD1oue/ig0OdaIkPprCdyolRg
	 xlsfsv2EGGVb/J7Mz1Y9xMBrim0NP4U4yoUWWeOJfnsPyH12sU7JgRjWEOP3/tw0/o
	 S1WP7CpHTKpGrdXAeP2lH4cRLfxfzbdNXy3s6VQuyaBD7UGKdHh+kK2YLq01qhStGk
	 h5F+FaeWEdO59HbggkC4q4lEfw7n3N7uz1rNjrCaYI/40P45kS0oLS3IXpFpVq0A7j
	 3a1AURXRGLXXC38maCQyt2Z+4BZnH5/ZPxJUPDTaMiZ2rr+BFV72nb941bxakB53G9
	 roL449zxbUP4Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0B0D392E9B5;
	Fri, 22 May 2026 15:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tun: free page on short-frame rejection in
 tun_xdp_one()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177946200752.1252088.3077671165200798159.git-patchwork-notify@kernel.org>
Date: Fri, 22 May 2026 15:00:07 +0000
References: <20260520160020.375349-2-bestswngs@gmail.com>
In-Reply-To: <20260520160020.375349-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 dongli.zhang@oracle.com, xmei5@asu.edu, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,kernel.org,google.com,oracle.com,asu.edu];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290866-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C16505B7160
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 20 May 2026 09:00:21 -0700 you wrote:
> tun_xdp_one() returns -EINVAL on a frame shorter than ETH_HLEN without
> freeing the page that vhost_net_build_xdp() allocated for it.
> tun_sendmsg() discards that -EINVAL and still returns total_len, so
> vhost_tx_batch() takes the success path and never frees the page; each
> short frame in a batch leaks one page-frag chunk.
> 
> A local process that can open /dev/net/tun and /dev/vhost-net can hit
> this path: it attaches a tun/tap device as the vhost-net backend and
> feeds TX descriptors whose length minus the virtio-net header is below
> ETH_HLEN. Each kick leaks the page-frag chunks for that batch, and a
> tight submission loop exhausts host memory and triggers an OOM panic.
> Free the page before returning -EINVAL, matching the XDP-program error
> path in the same function.
> 
> [...]

Here is the summary with links:
  - [net] tun: free page on short-frame rejection in tun_xdp_one()
    https://git.kernel.org/netdev/net/c/f4feb1e20058

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



