Return-Path: <netdev+bounces-290892-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJr7CfKREGoAZwYAu9opvQ
	(envelope-from <netdev+bounces-290892-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:27:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 77F3F5B82BB
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 19:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7E0D23057D57
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 17:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAFD360ECD;
	Fri, 22 May 2026 17:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kZOa7L12"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F535B63F;
	Fri, 22 May 2026 17:19:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779470398; cv=none; b=KsUhX6V1OyfXlCTKIrumWCTs1WBpEbDcVCV3Mb+MGRRV7eWuvFF0lyiSRzKw3MVSfLfCGZhQsidmk+HGXXzxLtNzFcUzSIAtfbhKJiQxSZGNcSRv80S8HiKTXLH/w09rZVE7YZTaJioFF4LxRxdHwxvhS289bMg70hAUFN7IISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779470398; c=relaxed/simple;
	bh=5OA+vT49mjtAFzIXptdSoMPcxW1vFJ6HYcB8DMaFQXI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U0tJfy2bKQ26ip3Lb2+hyPDcdUTGfhgwMSMCjAlKo+X0ghYsDRji/egM0GeOehJtY4PgAjSQHMYLOXg7yIBeYIT7lXYxN6Q6qhv0YOhGmL+vbRplQHtz56iw/wAoiCcpDiZhUmOFovBD2ayYq+SJtSYEHitb4obeDuL9XNOfuW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kZOa7L12; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733F31F000E9;
	Fri, 22 May 2026 17:19:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779470397;
	bh=+EP8dSEiN8U3udBdj+m9vIBRmPRfFt6bMNxmRITIJ6o=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kZOa7L12DmjVu+uxpR4vMMdM8wUl/38QHxQW2QjKBdN4FVml1L9uSO2xqNqlHWnAj
	 nT8XHFEQG3HSXx4jWyUnYdh5npwKC2vnklG4NhrAqUk5Mr2ZTQSOdXo1Zm/qgi56/0
	 f0mGKMoMSQOgrcK6VUGdWHqZV5cksjW8EI92Iqty3IcJhyK3sR8+bmjPMLzsM9vioU
	 HxOucHddRz7ZHOeYdIOwr0xj4e/j8ZhHmq+RIp2QttFJDxFAXzNggsg7X8aDUYKp1m
	 NDURDSXOXh19nZhtCtwr0V2OJ8rlTSlrt7J73VYqBNcjdqnhptPG6E3Nzb2TO9xPDh
	 hdkgj8QoDvJBQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A4C3930FAE;
	Fri, 22 May 2026 17:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tun: free page on build_skb failure in tun_xdp_one()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177947040640.1299893.17002941312025919549.git-patchwork-notify@kernel.org>
Date: Fri, 22 May 2026 17:20:06 +0000
References: <20260521163312.1479805-2-bestswngs@gmail.com>
In-Reply-To: <20260521163312.1479805-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 dongli.zhang@oracle.com, xmei5@asu.edu, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,redhat.com,kernel.org,google.com,oracle.com,asu.edu];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-290892-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 77F3F5B82BB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 09:33:13 -0700 you wrote:
> When build_skb() fails in tun_xdp_one(), the function sets ret to
> -ENOMEM and jumps to the out label, which returns without freeing the
> page that vhost_net_build_xdp() allocated for the frame. As with the
> short-frame rejection path, tun_sendmsg() discards the per-buffer error
> and still returns total_len, so vhost_tx_batch() takes the success path
> and never frees the page. Each build_skb() failure in a batch leaks one
> page-frag chunk.
> 
> [...]

Here is the summary with links:
  - [net] tun: free page on build_skb failure in tun_xdp_one()
    https://git.kernel.org/netdev/net/c/aa8963fdce66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



