Return-Path: <netdev+bounces-280599-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPmtIs6i6WnafwIAu9opvQ
	(envelope-from <netdev+bounces-280599-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:40:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D2A44CFF5
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A2C0309298C
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2916F37C106;
	Thu, 23 Apr 2026 04:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9mb1FV5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EAC361DB4
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 04:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918652; cv=none; b=hTMIsacmsdvc7kfeTe6m71Pt9bs6wTTd1TiIz9XhGPMijhXHlClIONQ+qKdXajhhxTKrRgjmRFO9kMXpjPLWV8VR3ycKZzpIRqYRC/PyZKUNQJQX5FbDhzh5oTR/LB10bd0biDN8F0iQlAIAIZ+zeJQKXSprLFbPl694Mr0UykY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918652; c=relaxed/simple;
	bh=K2sU+WiTmmmAC5xW5lFK7uA7gvxKHp55SFGfg4SCII4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OjKe7B6m3EHg7WZJSfyfyFKh7wibR1r6X/FBcnfgr0jtpjU+tMHRpCZYMCTmaoNvosxKsX3rIdaj9lLmnhGAmrVA7e1/PP3LgBMUoWdfRFaMgh7qzNU1JWlWbQV5mUSLxcxdV1DMsNsEtmoYWu1HXdeUiSA9X8GW4uMrAhApASw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9mb1FV5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCD54C2BCB5;
	Thu, 23 Apr 2026 04:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918651;
	bh=K2sU+WiTmmmAC5xW5lFK7uA7gvxKHp55SFGfg4SCII4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A9mb1FV5RpmkJd/8Q8ujaJIDDO5Gdr7twcgHNe7AAIVN9TrQOD4Uirm5JvszkGNuF
	 6fZRZQ762dgpR7WUbLnL+LaAE5JbUZbTx4uG9pP0PGhriDCBEI7HfbI/0dWu7Gx1X2
	 hynvS0TSUudpngUXEwBKI6jDJHlHJEeOkNe/nZbXWwOIvjLpJHhWAxQb9efuhvvknP
	 bRTcviIRVS0zSPRF/Id5AmvxeP9YhGtUonXeUg/FgSsOGnoJNf2gr5Ze0PhFUGDEva
	 R2+6/7xaqkMf1s9RokIFZb9tbdWh5EQNncz1Ishy3MKnOhKwseQQv2JybYJXUwDHbK
	 V4C1fZEm7KlBg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02B783809A86;
	Thu, 23 Apr 2026 04:30:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_pie: annotate data-races in
 pie_dump_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177691861379.4157517.12555693428946879231.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 04:30:13 +0000
References: <20260421142944.4009941-1-edumazet@google.com>
In-Reply-To: <20260421142944.4009941-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-280599-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E2D2A44CFF5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Apr 2026 14:29:44 +0000 you wrote:
> pie_dump_stats() only runs with RTNL held,
> reading fields that can be changed in qdisc fast path.
> 
> Add READ_ONCE()/WRITE_ONCE() annotations.
> 
> Alternative would be to acquire the qdisc spinlock, but our long-term
> goal is to make qdisc dump operations lockless as much as we can.
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_pie: annotate data-races in pie_dump_stats()
    https://git.kernel.org/netdev/net/c/5154561d9b11

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



