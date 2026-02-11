Return-Path: <netdev+bounces-258273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OC1bA6VxjGn6oAAAu9opvQ
	(envelope-from <netdev+bounces-258273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:10:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B198412419A
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 13:10:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 00CF030059AA
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 12:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CFE32E745;
	Wed, 11 Feb 2026 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cd1Z1fD2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FB2315D5B
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770811810; cv=none; b=aBU1RYvgCU7db1Rfb/cNnGE+G1U8nEb+VNs7amo5kRYXlegg4dmWKasTVGsRhz6FDZ8mmXUQlB//lrK9FcmqBCZXtl/leMhHwguvHnvvUzCiReW4b/zo3lmQCNF39p2ezdNACyNLo8IFePmZQjD52NcyU7wQJVBZdfvZF9Bb2Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770811810; c=relaxed/simple;
	bh=Av8+X3JjK21kCvCK1JiIl1odIiTzoxX4sKQ3R7cFedY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MZ9F/5QF2E8fyFqve0mPGjaV8VkKXNSM0IdWm3hlkbG9E8zPF1aH84qvFTEIU0K292Ah3/sr8zxkw8KUQIfHsuBjFJ8wsQ5ar1EZP8nB1ZRVxITNz2lk6qSya1qq2sUf1bnj5BEvnB0XOsJq1XbSawfapUvdThrK7xbzAbGmEKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cd1Z1fD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D120C4CEF7;
	Wed, 11 Feb 2026 12:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770811810;
	bh=Av8+X3JjK21kCvCK1JiIl1odIiTzoxX4sKQ3R7cFedY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=cd1Z1fD22uP2RAYrwfoV/SlOaic96yHijI6hRRu4/yq4DGVoewJnssdduiETic+5r
	 BjVt2cHRzpMTosuGfIKJ+Z8gigNp3fj7PGwe8GgDPJgCfa26Ham2dZZmTPXrR9yvCT
	 XIcHQvWjK9ZXTfe6KHtExY4YcdPw71CvYZpRknwGEjQVKS64EnKRYMyiLu/vAIcuZc
	 m09s3Y0/woY41FqmXEIwq0VzeSruMfvMAqJibrydi5wmTkurkRwnD+NHvrhx9bqH5/
	 BxSH81Fo14tXY7vYJMnhhHxlLEoo+s3SMfwjRBgmLsK0RRVdN4ob9he7Kp8NT3Zly0
	 J3BhmQQ69ByUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 47FFC39E9615;
	Wed, 11 Feb 2026 12:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] af_unix: Fix memleak of newsk in
 unix_stream_connect().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177081180508.147733.2873421321562093141.git-patchwork-notify@kernel.org>
Date: Wed, 11 Feb 2026 12:10:05 +0000
References: <20260207232236.2557549-1-kuniyu@google.com>
In-Reply-To: <20260207232236.2557549-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, brauner@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-258273-lists,netdev=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: B198412419A
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  7 Feb 2026 23:22:34 +0000 you wrote:
> When prepare_peercred() fails in unix_stream_connect(),
> unix_release_sock() is not called for newsk, and the memory
> is leaked.
> 
> Let's move prepare_peercred() before unix_create1().
> 
> Fixes: fd0a109a0f6b ("net, pidfs: prepare for handing out pidfds for reaped sk->sk_peer_pid")
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> 
> [...]

Here is the summary with links:
  - [v1,net] af_unix: Fix memleak of newsk in unix_stream_connect().
    https://git.kernel.org/netdev/net/c/6884028cd7f2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



