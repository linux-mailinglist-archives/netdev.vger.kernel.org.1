Return-Path: <netdev+bounces-270845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLxHDaHxwWkgYAQAu9opvQ
	(envelope-from <netdev+bounces-270845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:06:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CEB300ECD
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 03:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41981301531D
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 02:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9D130100D;
	Tue, 24 Mar 2026 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHt7Q1pq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4970012E1DC
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774317626; cv=none; b=s5WmYxvy40LbdBNBYv18IA5a+o5JOewYP0yOGdilblJqv4EjBCSWX9ZIHK/dTcaP94sjs9LP6W9+I5d3HPj/lrmgZQBYs6lWNbsVhy7EOaoKkhZdJvboHyxKEpi5Qj7pt//Xlj9qtmtrd0V+HHqpbuxZvOkKCp7yGNB91S5ateM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774317626; c=relaxed/simple;
	bh=k7FDPLFeCJPeTBWKM4Ky0XB8ZEYFUvmuo5g9y0FWhdU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s+jG9OI6KZAdde6fWxJAXunQ0S+W4h0Uv5EbS+2L5zCHGTudI4M97+XFxGhQDTmC3wLB4wcMr4phTMLTZz5ECvFcuCRGYvBHbwvUA0sZQCY3HaC/A41e0aR7rVplWzpmZTpdJ6Px1gKumep8CLGyEkrynlLRpQyfvztgYh6j/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHt7Q1pq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D320BC4CEF7;
	Tue, 24 Mar 2026 02:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774317625;
	bh=k7FDPLFeCJPeTBWKM4Ky0XB8ZEYFUvmuo5g9y0FWhdU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CHt7Q1pqbEXwzwILhRqMMFAO25qMAFPNXkavJKDxTfjz3PYQ9q2I/gUMMOOb3Ph/n
	 hqCfOScD06mJad7pBzw4TMwr9OYX8IXujckDKaAvZWJmcpZb8V3mPSLJfvI+JCRNCy
	 VuFoFvs5KeWLAFXhOg26oWOnY8tAyR5NBx9BoU1eUmSjfhtMzDrmWFtdbiEztIy5OK
	 PL/ylP6rDKTtZgNAXz1JtmeWLUhdd+3qhOnu/RlVSidmLwiKQrEwG0dud68HbKCF1T
	 NWUn0ozqmWampB4HsGn7pHCecOBZFCKETVKFBbhpUAd9a4ccqms8xrF7pJJ66Tzx2F
	 d2et/G8qY+QAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD8A3808200;
	Tue, 24 Mar 2026 02:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] udp: Fix wildcard bind conflict check when using
 hash2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177431761378.416781.8516935452069450224.git-patchwork-notify@kernel.org>
Date: Tue, 24 Mar 2026 02:00:13 +0000
References: <20260319181817.1901357-1-martin.lau@linux.dev>
In-Reply-To: <20260319181817.1901357-1-martin.lau@linux.dev>
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, kuniyu@google.com, oandrew@meta.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-270845-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 31CEB300ECD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Mar 2026 11:18:17 -0700 you wrote:
> From: Martin KaFai Lau <martin.lau@kernel.org>
> 
> When binding a udp_sock to a local address and port, UDP uses
> two hashes (udptable->hash and udptable->hash2) for collision
> detection. The current code switches to "hash2" when
> hslot->count > 10.
> 
> [...]

Here is the summary with links:
  - [net] udp: Fix wildcard bind conflict check when using hash2
    https://git.kernel.org/netdev/net/c/e537dd15d0d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



