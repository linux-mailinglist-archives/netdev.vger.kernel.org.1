Return-Path: <netdev+bounces-252296-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAplHUcQcmksawAAu9opvQ
	(envelope-from <netdev+bounces-252296-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:55:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E776644F
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:55:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3F6828E5EA1
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 11:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7738243E9D7;
	Thu, 22 Jan 2026 11:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUdmVpmE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4588F3A6401;
	Thu, 22 Jan 2026 11:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769080809; cv=none; b=HLBpQ37tBKCL87+bVCgeClyfnJ6zR8Mo91fYdQVI7W/+w8ori+S6GMBNv4+Z35AWh5asiBTHPbI6CH3L097PuGrDSOO2L3FY94pi58vXQJqtf5ceM5ofw0EGRaxru90Xp4pbX9ZZgAJp/Jv6fQRQImZs0Fhl9PGvLtXRNthVlYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769080809; c=relaxed/simple;
	bh=aGvsNSgadRqrmWhuMeia08DAg2TIMJ407pjgAveWIi4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R/ySIAlpbkBqk0s4AmFsZz3Pci0bCP38hNiiLppn3s7qAobUMdgIJPvkYGb9/nrgooq1v/PtN9UxmMnBNBmsCkEcrRmPnyKYUGCls/uqABoDylVOvdGcCOz9M2WMvj+okByyzKXI5Wd0JrAJYq+n1AOdYQjM1d3GQB3hTFtpqMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUdmVpmE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0C64C116D0;
	Thu, 22 Jan 2026 11:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769080808;
	bh=aGvsNSgadRqrmWhuMeia08DAg2TIMJ407pjgAveWIi4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OUdmVpmEY4JBpqUIcohMnmnKQbhd3r7Ds4EsOpejYa4IiykOjrWRRCjiZXSpMenGh
	 xYIa9fz15+kNHAbMRx2M9bUDPsage7iQrN10I6d/ck7+XtXJRTTa75QAAebQVyT49G
	 3lBLZTYNhLosT/qqaFqNHWcIgrTIdi9uDx210Rk9s2eAp3wjZ6oijaz/SIsF7eTlkJ
	 B1ZmNYO9kSXAGtFhJuBsZjLYJzbSXPmv7i8kThw/ZdsJqlihJsdF4l/fzKhur7wQ7f
	 zm2Yz0dudsKG7tnG9gRDZij0zRJYSwLerOqhUJAzjRX3NU0CoI4+xPiTVpYZBICWVo
	 FtbkZ+98cKx6w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BBDB3808200;
	Thu, 22 Jan 2026 11:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] cipso: harden use of skb_cow() in
 cipso_v4_skbuff_setattr()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176908080535.1676098.17318230708318631891.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 11:20:05 +0000
References: <20260120155738.982771-1-whrosenb@asu.edu>
In-Reply-To: <20260120155738.982771-1-whrosenb@asu.edu>
To: Will Rosenberg <whrosenb@asu.edu>
Cc: paul@paul-moore.com, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-security-module@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252296-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: E1E776644F
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 20 Jan 2026 08:57:38 -0700 you wrote:
> If skb_cow() is passed a headroom <= -NET_SKB_PAD, it will trigger a
> BUG. As a result, use cases should avoid calling with a headroom that
> is negative to prevent triggering this issue.
> 
> This is the same code pattern fixed in Commit 58fc7342b529 ("ipv6:
> BUG() in pskb_expand_head() as part of calipso_skbuff_setattr()").
> 
> [...]

Here is the summary with links:
  - cipso: harden use of skb_cow() in cipso_v4_skbuff_setattr()
    https://git.kernel.org/netdev/net-next/c/40cb4cb77ea2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



