Return-Path: <netdev+bounces-263193-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIqtNx3apmnHWgAAu9opvQ
	(envelope-from <netdev+bounces-263193-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:54:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF6F1EFC41
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 13:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F77A305E989
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 12:50:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E92F35E920;
	Tue,  3 Mar 2026 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UlG20It9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BDD334D4FE;
	Tue,  3 Mar 2026 12:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772542204; cv=none; b=p+AY5mStBXrD00uqvxsqpZ3SSfVUxtE3gxG2hekHPM8AZxxuIKIuRwPrmTyZt2Nk9whKWkT5etsvQJS1V+jtZ0YiiOwxzAjBKczNg5r43oEnoUZpysHa2NK53kDjRRWltx+TDzmjgGrvWt/bcOYyu5NVYBrxZy+2URwLRObcR2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772542204; c=relaxed/simple;
	bh=cv0FMygEWiud8J9zDv1le+ZFi9CZ+VP7NQcvikUsftY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=R5NatzIX4bfzZDq/qw5Y/IDKGZRzJSmkfrA+uqUStWcrqDK+cKIbgJBD/gRAf3iGgjJvhc5T2/6/8RyOLtNVgZrKovBydR84pVkPBOy515NnBtrcOyFxb+aZdKMGtHsNx/srVYQ9k45roaXlIBFjBNcRv/yzRcU9zinToMEo8Uk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UlG20It9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DACB4C116C6;
	Tue,  3 Mar 2026 12:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772542203;
	bh=cv0FMygEWiud8J9zDv1le+ZFi9CZ+VP7NQcvikUsftY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UlG20It95k/cbvXuFxzV611cMZVzrBenA7oKdI7hkSrwCEQkhoAGUVn/3blVBGLli
	 y9FKeLOI44MRG+13rQQ7fDmL+sgXPwStfSMGTWo0ULcLI579jPHY0mEsGnFQxs9LJi
	 Cr67iDQnBLPDytkkn4bn5BKNHZn5JCNJDHA5bq3+y9jVCj9ZmoRPsBWm5p8SRmeNPo
	 w0kkS3IttKjtvZGxRW28nF+CMZ59thfX8sXRGTH7PT8F/xKRI3eUTP9bmnZdIw1JEV
	 HTAMVlIR0jWEiezGsQkUpWgrGC9ysS6ptLFjyqaVbeKbNPebuaLt8wA8urgrflNFFS
	 kwkn9JAZgeQIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CEAE380A97C;
	Tue,  3 Mar 2026 12:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: Fix rcu_tasks stall in threaded busypoll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177254220530.856851.6609682429987870648.git-patchwork-notify@kernel.org>
Date: Tue, 03 Mar 2026 12:50:05 +0000
References: <20260227221937.1060857-1-zhuyifei@google.com>
In-Reply-To: <20260227221937.1060857-1-zhuyifei@google.com>
To: YiFei Zhu <zhuyifei@google.com>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, skhawaja@google.com, netdev@vger.kernel.org,
 almasrymina@google.com, willemb@google.com, joe@dama.to,
 stable@vger.kernel.org
X-Rspamd-Queue-Id: 4CF6F1EFC41
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-263193-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 27 Feb 2026 22:19:37 +0000 you wrote:
> I was debugging a NIC driver when I noticed that when I enable
> threaded busypoll, bpftrace hangs when starting up. dmesg showed:
> 
>   rcu_tasks_wait_gp: rcu_tasks grace period number 85 (since boot) is 10658 jiffies old.
>   rcu_tasks_wait_gp: rcu_tasks grace period number 85 (since boot) is 40793 jiffies old.
>   rcu_tasks_wait_gp: rcu_tasks grace period number 85 (since boot) is 131273 jiffies old.
>   rcu_tasks_wait_gp: rcu_tasks grace period number 85 (since boot) is 402058 jiffies old.
>   INFO: rcu_tasks detected stalls on tasks:
>   00000000769f52cd: .N nvcsw: 2/2 holdout: 1 idle_cpu: -1/64
>   task:napi/eth2-8265  state:R  running task     stack:0     pid:48300 tgid:48300 ppid:2      task_flags:0x208040 flags:0x00004000
>   Call Trace:
>    <TASK>
>    ? napi_threaded_poll_loop+0x27c/0x2c0
>    ? __pfx_napi_threaded_poll+0x10/0x10
>    ? napi_threaded_poll+0x26/0x80
>    ? kthread+0xfa/0x240
>    ? __pfx_kthread+0x10/0x10
>    ? ret_from_fork+0x31/0x50
>    ? __pfx_kthread+0x10/0x10
>    ? ret_from_fork_asm+0x1a/0x30
>    </TASK>
> 
> [...]

Here is the summary with links:
  - [net] net: Fix rcu_tasks stall in threaded busypoll
    https://git.kernel.org/netdev/net/c/1a86a1f7d889

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



