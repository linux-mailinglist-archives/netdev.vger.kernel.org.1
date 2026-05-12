Return-Path: <netdev+bounces-286902-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPKmEliBAmpDtwEAu9opvQ
	(envelope-from <netdev+bounces-286902-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:24:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D7B51834A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 03:24:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3241E303749B
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 01:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78F4259CB2;
	Tue, 12 May 2026 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m7ggUw8t"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4CF4253B58
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 01:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778548825; cv=none; b=K00V+YfV4Ron3qQ5tDB2xbHdmC2LPDnTzIRXJqbx+zPyibnE4Y0LO9VhN68/c1CTKT+vYG3TPM7pwiXJId6m05iSw2KSCC16ovTLp5dQsKh5SlycRfj7oy1SV0oxlPOZ9589h+Duup0msj23S82CD+3KH3yA3G2ScpY1/0PqMj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778548825; c=relaxed/simple;
	bh=zrTOB7Ajk8FLNHB3+mfBCcvDyXiKX7X+bSHYzT5wv8U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=chL2ZAchglrpuiP92IvQVrtR6ycZ9WTjotmd2qFyqX6xEzZgtNvicAdxYGa13AXI7rw38fuGn6C90Xz7L89s9wst8J+FwY/nXB2oECJ/vcFZaqoFGKsK+Zj4wHEa+ug+LaC5Xyj64noQ7/yXFqjmSe1rmlYOM43EgOaIW/nQvVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m7ggUw8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DFCCC2BCB0;
	Tue, 12 May 2026 01:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778548825;
	bh=zrTOB7Ajk8FLNHB3+mfBCcvDyXiKX7X+bSHYzT5wv8U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m7ggUw8t4bh8EuuyeHbMB/l5jzhMbMzDZ4KCSVZnZro5X7/a9KPJ1yRNuFM52wak/
	 pvZ7DKDKQE9NXket3TGi/oxzAJlJM2O79v0BBpUm5P8qZlMfXY3gurXi8GJFil9rcR
	 yQWlgIbhsbwb2P8nUGze9lTQw+Cd/xOIiEh3G8ymYn2nLrP8VjLjb6VNOiL3U6hAzZ
	 I8YO2RzdzCqfvQISs2mdoePI281Q/+dGG1nHhoA9clIVBoDoF7Uoc5+G4Sq7Xc3qfW
	 D9PFS/hYcp7s1ojc5orlWjXrlhSTHj3uRzV7Tye8jTJtGrczcEWVeIj2hySVbxWZm2
	 cGq4l9NQIrahA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CAB39308E4;
	Tue, 12 May 2026 01:19:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] tcp: Fix out-of-bounds access for twsk in
 tcp_ao_established_key().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177854877154.2528168.10390585844173110753.git-patchwork-notify@kernel.org>
Date: Tue, 12 May 2026 01:19:31 +0000
References: <20260508120853.4098365-1-kuniyu@google.com>
In-Reply-To: <20260508120853.4098365-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, 0x7f454c46@gmail.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org, melotti@google.com
X-Rspamd-Queue-Id: C3D7B51834A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286902-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  8 May 2026 12:08:46 +0000 you wrote:
> lockdep_sock_is_held() was added in tcp_ao_established_key()
> by the cited commit.
> 
> It can be called from tcp_v[46]_timewait_ack() with twsk.
> 
> Since it does not have sk->sk_lock, the lockdep annotation
> results in out-of-bound access.
> 
> [...]

Here is the summary with links:
  - [v2,net] tcp: Fix out-of-bounds access for twsk in tcp_ao_established_key().
    https://git.kernel.org/netdev/net/c/03cb001ef87b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



