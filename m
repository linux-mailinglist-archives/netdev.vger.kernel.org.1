Return-Path: <netdev+bounces-293217-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOr5Ff3tGWr5zwgAu9opvQ
	(envelope-from <netdev+bounces-293217-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:50:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C85D8607FF6
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 21:50:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 744A5301913C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 19:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF0836AB44;
	Fri, 29 May 2026 19:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h5MkStyO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D53E23395E;
	Fri, 29 May 2026 19:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780084207; cv=none; b=HeE6iKkrhIlJLp/nJifDlvFjV5auqIf1IQQ4A3eb1uvGlRMfRl22/Ueo5J1+u01z821iXGIbAg1N17XJ9MPLfDwQSqxzGi99tQzRcaC+O43n1/2I17Zq1Dwc/u+5mdpHN8QjdbB3jGI0XvcITlgWt94APwbXqLX00iP45t1DADc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780084207; c=relaxed/simple;
	bh=lwOQz5npaazZqEfFJxwrqOkAfZqEhlhgMg4GjWctWjQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NigQFy8Xs0OJeUs1v170+eQr2qn9Vf9AfGq2Ocq/fOTsiL2+ezkL42WVf9XGpITvKPZbKDib/oVEOH3OQkY7Wk/lUPHQSY+9Bm1s7uCPj0n4SS3Pb4x8/LeFNoWgBvLqo4pqUqnIJHL76UQtfOyMnz44xUsPmJhJnS6SeKwfIRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h5MkStyO; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A54951F00893;
	Fri, 29 May 2026 19:50:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780084205;
	bh=cBb6tvuGqHb+omTr1WAM/3f3npyqxSGggbx+zNUsTyw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=h5MkStyOAbj2fTwilm0XQPzCmdQlWbX/lhU61aAWrCUbKQ4L3IVUEjsxyg7wz/nCt
	 htMgqxUeXIU0absYumYlzsG+k32yccv3ZJ302T/o0UeSJsDAZq3SQ/Al4+RuzsmioA
	 z3xzNe8jRzg/nbNeUZ0tFY9jNcLaHs6ipd0bd6wuvlNAKYHN+r7S6GYRZpvDHCMwf8
	 zTZldNnXxvn0smWh+DUrk6iOizTLTSwSE0bRBflr7n5tVCKKKsixtVKoQk9WMO7Jn2
	 pWlEVUfSVRlr751SI8RWhzTcfL0tmpwGWIOMxTgdEXgbNjWWBE46onVe5qfqpD5vwW
	 7OMl4ODr1/NzQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93C9839301A0;
	Fri, 29 May 2026 19:50:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] ipv6: fix possible infinite loop in
 rt6_fill_node()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178008420915.1939215.14035073478249401045.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 19:50:09 +0000
References: <20260527053133.180695-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260527053133.180695-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, dsahern@kernel.org, idosch@nvidia.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, omid.ehtemamhaghighi@menlosecurity.com,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-293217-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C85D8607FF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 13:31:30 +0800 you wrote:
> Sashiko reported this issue [1]. Apply the same fix as
> commit f8d8ce1b515a ("ipv6: fix possible infinite loop in fib6_info_uses_dev()").
> 
> Writers holding tb6_lock can list_del_rcu(&rt->fib6_siblings)
> without waiting for RCU readers; rt->fib6_siblings.next then still
> points into the old ring and this softirq-side walker never reaches
> &rt->fib6_siblings, causing a CPU stall. fib6_purge_rt() always
> WRITE_ONCE()s rt->fib6_nsiblings to 0 before list_del_rcu(), so an
> inside-loop check is a reliable detach signal.
> 
> [...]

Here is the summary with links:
  - [net,1/2] ipv6: fix possible infinite loop in rt6_fill_node()
    https://git.kernel.org/netdev/net/c/9f72412bcf60
  - [net,2/2] ipv6: fix possible infinite loop in fib6_select_path()
    https://git.kernel.org/netdev/net/c/9c7da87c2dc8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



