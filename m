Return-Path: <netdev+bounces-281583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLk3OJ4S8GnXOAEAu9opvQ
	(envelope-from <netdev+bounces-281583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:51:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E15A47C870
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 03:51:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D8256303C4D7
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 01:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70E82DD5E2;
	Tue, 28 Apr 2026 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMidOyBR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C34892DB7BD;
	Tue, 28 Apr 2026 01:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777341055; cv=none; b=gpwK3qCjATCeN0obDEnmUmNQHpb14bPwso2IHqFwQUcR6aGEWtndwlJh9a8lgTutxb0jQ5zp193joz4/2Jzj2RKXBLMIX19Y9Pl+SgemcsDPnDPIYF7QoXLwHvgumIPepeQLqjv7mSp011Suv4sMkYFUOHehlU8W2Tp/1NvyZDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777341055; c=relaxed/simple;
	bh=blhnT1OhgZfmkBn7i5SypMFOmLdooHT0yasHfhzVmL0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=O9LNfKYVF4KWkuX8erqfV0s/aLfzgzKKt+ouYBb0AgZ3nq8pCVPhBy3+7eG+DJFpRWy5JgAvVpD38BN/L+0SK+xomhvw63eWLgCO87qYE+tEhJEjgHkRLlJHlWyzl3qmooyo1bZEF11nI9KO7LcGLhg28i3qL+0Z6xpSQWWcgKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMidOyBR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84E21C19425;
	Tue, 28 Apr 2026 01:50:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777341055;
	bh=blhnT1OhgZfmkBn7i5SypMFOmLdooHT0yasHfhzVmL0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eMidOyBRA1zd0r021PRvVAP62k8XR+0zGeFcvzMhPdoFkm730HryHtgSkCMJmDkZD
	 s2XoB2FzkUdYgfSpTJ4Ek3BeLSZ/G7TpXYVF2n75rNLDCDSvjivNcAB2h1xW4HPG07
	 aW7hii4IVM3hCNxYSPzcQiexyLiWvwFOzhVkscmM7489KDFyED5UdopuWJwbSlKBhy
	 eHg2j/ogESuuma1VgUvpRZECVw7C1d43zLZcCjl4pWmRwmnVlbmjEjwUhuk6VlXpbx
	 DfipXe9YrCfehzKIP8tNLj0gss6Cts7jQPLEcb2IsakwY5UvmcbOftNDS9U0OUQz/8
	 uozrwBBPBb2Ew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E09392FFDF;
	Tue, 28 Apr 2026 01:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v5 0/2] net/sched: taprio: fix NULL pointer
 dereference in
 class dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177734101277.196918.11456842228580431598.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 01:50:12 +0000
References: <20260422161958.2517539-2-bestswngs@gmail.com>
In-Reply-To: <20260422161958.2517539-2-bestswngs@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: vinicius.gomes@intel.com, jhs@mojatatu.com, jiri@resnulli.us,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, vladimir.oltean@nxp.com, shuah@kernel.org, xmei5@asu.edu,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org
X-Rspamd-Queue-Id: 8E15A47C870
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281583-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Apr 2026 00:19:57 +0800 you wrote:
> Fix a NULL pointer dereference in taprio_dump_class() reachable by an
> unprivileged local user on kernels with unprivileged user namespaces
> enabled and CONFIG_NET_SCH_TAPRIO=y. The bug allows a local DoS via a
> crafted sequence of taprio child-qdisc graft, delete, and class dump.
> 
> Patch 1/2 is the fix: replace NULL entries in q->qdiscs[] with the
> global &noop_qdisc singleton so that control-plane dump paths, as well
> as the existing NULL guards in the data-plane enqueue/dequeue paths,
> cannot deref a NULL child qdisc.
> 
> [...]

Here is the summary with links:
  - [net,v5,1/2] net/sched: taprio: fix NULL pointer dereference in class dump
    https://git.kernel.org/netdev/net/c/3d07ca5c0fae
  - [net,v5,2/2] selftests/tc-testing: add taprio test for class dump after child delete
    https://git.kernel.org/netdev/net/c/a469feed399d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



