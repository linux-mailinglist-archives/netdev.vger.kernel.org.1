Return-Path: <netdev+bounces-285101-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOt+E2/r+2llIQAAu9opvQ
	(envelope-from <netdev+bounces-285101-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 03:31:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04C554E1F3B
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 03:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A5015302306F
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 01:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AB0026F29C;
	Thu,  7 May 2026 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6XI1XEQ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1864A26B74A
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 01:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778117475; cv=none; b=acFl/+3jx1gDhhx2r94ZetxuZjEZ4UJ3HPW0h14oEfIa5Iy5uWcv1DXRmgCvhQ9PcMFZXaeZvnzl0wHaE4+Hma4bFw84QkWCglB3BCeZcIT3x1MVbLTzB20fjwKC33ajR+gwXv3U/v/pxmDhRd2IAiqJNgq2Aaraf1D7WfNMClI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778117475; c=relaxed/simple;
	bh=Fk2L2IGaN136P11NAApVrA7rAGlfBztANvE406Y8/tY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TsyByP8xdgarlqlP7vTZcdrMQAKHHSc9561ifyH4sTKd+3wB+5KPKGZvizCohS3A1I512Q4hsPQ58xaO04ennPQ/D1R948wPR4FDitwFa6f/pTcuc+F9ns2Vm2YZ6ypjtHYEinfARNtI3eCjjZ3VbBcx7St0NwU6wwQAjLxe1Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6XI1XEQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDE01C2BCB0;
	Thu,  7 May 2026 01:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778117475;
	bh=Fk2L2IGaN136P11NAApVrA7rAGlfBztANvE406Y8/tY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y6XI1XEQkboDuYFWQgW9MwtrttEEkWNlYOXw9HxaKzwQxONVxuV+x65GMn7ELNsdg
	 ffKCa5hNPqBJLl8n8XC+d50EjD2TxURyAtsZZ+7OqCaBVLC0yhuTIYNiP9u9jBd7Nt
	 UrK8oVpQFQBCGR2/SMX7ZTrqBUA6+4ftkGwuph/h4v3K4zDfNASupiulnLZWxCvRVJ
	 53SGYydniiiaERk3NySgQbqycYEAMVXWFyTffUNiAGiiTMrGPh+V5K2/ZzcmEboIMK
	 2RjyIswgfU5/58PAFCyy8FUY7oyuxCIZIIpDaOGZjpgXzX1pNIWyy14bzHJ6Mbz6lZ
	 AVcVs5FTHVAKg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DFA393089F;
	Thu,  7 May 2026 01:30:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tcp: tcp_child_process() related UAF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177811742454.3291094.16410058014129516825.git-patchwork-notify@kernel.org>
Date: Thu, 07 May 2026 01:30:24 +0000
References: <20260505153927.3435532-1-edumazet@google.com>
In-Reply-To: <20260505153927.3435532-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, melotti@google.com
X-Rspamd-Queue-Id: 04C554E1F3B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-285101-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 May 2026 15:39:27 +0000 you wrote:
> tcp_child_process( .. child ...) currently calls sock_put(child).
> 
> Unfortunately @child (named @nsk in callers) can be used after
> this point to send a RST packet.
> 
> To fix this UAF, I remove the sock_put() from tcp_child_process()
> and let the callers handle this after it is safe.
> 
> [...]

Here is the summary with links:
  - [net] tcp: tcp_child_process() related UAF
    https://git.kernel.org/netdev/net/c/c8f7244c8ccc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



