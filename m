Return-Path: <netdev+bounces-284631-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EHwB1+O+mkaPwMAu9opvQ
	(envelope-from <netdev+bounces-284631-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:42:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC164D4FCE
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52B203050F66
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 00:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A412257423;
	Wed,  6 May 2026 00:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MGiLDpXw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9BB1DDC35
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 00:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778028067; cv=none; b=F9LOkgDmHAC0/nNZ7ttRnrLG9nU+bRerm50IgSLN7rqZIhoCKbi3+AlGytWpW22JNmEJHYaD7oFhxrjJTAtJeWpGsjieZoLAMGq7t+qVrxvQ8+/8uKmplr7zzoZVnGDjJQa8Fz+6ByW8/TIK0DT+gigBIaLfp35M0dBLYeflIIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778028067; c=relaxed/simple;
	bh=QFFeQHVwcNUKylrahhe7X/qXekc64+KmjPldkyM946w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=q1UFBlrHGF1w+ttr0pa4jXJqHd5IX30hCyXO8XtPt6hdhUMv4/7D4XPN8flm107HwWwJo4PNAS3YHYCk5BfoqYiWpG+VSY8ePkRFuD/EjbpnZ9wybOVK9P60lzwFZJCfA6l4InEPZ1USSgQVeMxn/WbEVS+z82noQ98aQoxqIQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MGiLDpXw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C3DBC2BCB4;
	Wed,  6 May 2026 00:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778028066;
	bh=QFFeQHVwcNUKylrahhe7X/qXekc64+KmjPldkyM946w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MGiLDpXwG/hHOTGFbMLw5FIfBlNjF+p+yTf10lMiV4JuOFkAZ8Nvar8uM9II1e/3H
	 ALW3lFrPA2T7Axh0N1VwBOD0fIdHElxZxGNqYIxr0ft9jcHt/wyKeOeuL8s4aSiF14
	 8G4UbV+J9doOjibwXSEydvmjAFm7L6pYkn0lVmRHvI2QMLU5L2bGRuV3Y356PBjCFH
	 lMx1DK3hquPECKOd9fYA37p3omra8mz+6vXfygRtksox0hRrnwc7VLLuR694cyK4kS
	 cEhVhw5ePrqH615CnpXiZJufyYs82D1+RgFi11r9tNf9Z+0HNderzRhZMBEB5vnZhM
	 JL5BDzZyHZvlw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DD43930780;
	Wed,  6 May 2026 00:40:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ipv6: Fix null-ptr-deref in fib6_mtu().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177802801654.2324972.14096419110855519437.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 00:40:16 +0000
References: <20260504064316.3820775-1-kuniyu@google.com>
In-Reply-To: <20260504064316.3820775-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+01f005f9c6387ca6f6dd@syzkaller.appspotmail.com
X-Rspamd-Queue-Id: 7BC164D4FCE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com,vger.kernel.org,syzkaller.appspotmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-284631-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,01f005f9c6387ca6f6dd];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  4 May 2026 06:43:13 +0000 you wrote:
> syzbot reported null-ptr-deref in fib6_mtu(). [0]
> 
> When res->f6i->fib6_pmtu is 0 in fib6_mtu(), it fetches MTU from
> __in6_dev_get(nh->fib_nh_dev)->cnf.mtu6.
> 
> However, __in6_dev_get() could return NULL when the device is
> being unregistered.
> 
> [...]

Here is the summary with links:
  - [v1,net] ipv6: Fix null-ptr-deref in fib6_mtu().
    https://git.kernel.org/netdev/net/c/5ad509c1fdad

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



