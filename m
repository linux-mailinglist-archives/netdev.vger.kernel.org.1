Return-Path: <netdev+bounces-257718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPU1Kaq9hmkzQgQAu9opvQ
	(envelope-from <netdev+bounces-257718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:20:58 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC34104E14
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9A92A303B95E
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 04:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929FB2DA775;
	Sat,  7 Feb 2026 04:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQ7q9UqC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701012D9EE2;
	Sat,  7 Feb 2026 04:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770438026; cv=none; b=RM+vbOPY9k81WBhTMkNyzfGGhSRyw4qesReMQOAIplou6bOnUd0pRxCK/PH+VnotGGULlh76w6/vvfWQNHL94GtOySwzt1+0z5hvHb0Ixa5OOeMnh6HPVGV0l6GddWYMbzXxz0BPpSnUzr5HD4G6nYp/B7/vK7rX2FZMZu/CUk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770438026; c=relaxed/simple;
	bh=wKCUKQlj1WOS70ZAzFEcOR2NiardB24Lh4LjcZON7jg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a/ZbKbtLcWmJ7ByS1G5SGXYhOo0qOuXsQs9O6ofN0aiihbtnFxI1fZh71SmVOyzJcqJyX3k4BwQxLEQGaOND1dlRJKW84KifC1YBjcHBzadd9yHcOIPWWv754SveAFUZVhBWZB+c1Y0URWduQ0Qt/usllHESZmRbX7wWvNzGLHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQ7q9UqC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0739DC116D0;
	Sat,  7 Feb 2026 04:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770438026;
	bh=wKCUKQlj1WOS70ZAzFEcOR2NiardB24Lh4LjcZON7jg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GQ7q9UqC3ke2TrvnuzGJCsS3ZdYFm2tc6JjbXsppNuUrG2bBqJh5VZMcz0Uzp2Zlc
	 3kSCcuUkduUYhPOPz/K+53jgi/UOupsEQFvSgG5E8XMO0+xY6WP/7hpsEUsiGmOvV7
	 DbugHAZpF8kR+2+b0k2hpnggBjf4MU/CK/3/S6hpaMvVFbwUkPjxDjwNPaRY6plRlE
	 GNslmxPdIAHmnsg+VAHhEGh70ln2Hyq8K8KNC+ub7hTfTl+XFJq5lLyfzcd5Mdx+L4
	 LvVWnEyeewiBLbKuJpUTmCHiuSyPLmKPLm8bKZ4K1LoiClXwGjuvogRlRgDQH42sMV
	 xgL85AoTA2IKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 483983809A1A;
	Sat,  7 Feb 2026 04:20:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6] netns: optimize netns cleaning by batching unhash_nsid
 calls
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177043802282.1183264.13017146634925007603.git-patchwork-notify@kernel.org>
Date: Sat, 07 Feb 2026 04:20:22 +0000
References: <20260204074854.3506916-1-realwujing@gmail.com>
In-Reply-To: <20260204074854.3506916-1-realwujing@gmail.com>
To: Qiliang Yuan <realwujing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, brauner@kernel.org, kuniyu@google.com, jack@suse.cz,
 jlayton@kernel.org, yuanql9@chinatelecom.cn, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257718-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FC34104E14
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Feb 2026 02:48:42 -0500 you wrote:
> Currently, unhash_nsid() scans the entire system for each netns being
> killed, leading to O(M_dying_net * N_alive_net * N_id) complexity, as
> __peernet2id() also performs a linear search in the IDR.
> 
> Optimize this to O(N_alive_net * N_id) by batching unhash operations. Move
> unhash_nsid() out of the per-netns loop in cleanup_net() to perform a
> single-pass traversal over survivor namespaces.
> 
> [...]

Here is the summary with links:
  - [v6] netns: optimize netns cleaning by batching unhash_nsid calls
    https://git.kernel.org/netdev/net-next/c/7acee67a6bce

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



