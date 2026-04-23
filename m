Return-Path: <netdev+bounces-280600-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id BRUOM5Kg6WnBfgIAu9opvQ
	(envelope-from <netdev+bounces-280600-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:31:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3888D44CF57
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 06:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F73D302E863
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D77437E2FC;
	Thu, 23 Apr 2026 04:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WWV+vn6a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B68C37700B
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 04:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776918653; cv=none; b=WDTB/QL5SdNb1Aj27b+Anm0HKyWXEOgDHch00y9u+6NRxpLLP1FTa/co3mxSJ8J23PNP9QV2ynMzOlm/4P64TPF3e6ARqx9eT8vOvoYksewk1hDWS37yeLKvLiLp4c4C5bdU5r1+Fk4GSaT2DAuYcAAnr63FdL1jwi1I07r2UAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776918653; c=relaxed/simple;
	bh=BDrMUFs5nr1qeG2hIpkJTReHi0lb43W4ihbJodZoCrU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SJ1JnjYb8+eeyCZV1HY6YwRRr8LAck3dX/h9T+piA8pb9N3FvePfRSneVjEqSQ46UYhrkF09jRsdA+O5CNfeZlEE7zWY0N4hm+J/Vx5PbQY2GxyHQa57dX2qgrzKr67aGZ2XtOBIpr3drnSGdmTyMFs1ehxDRm+LL0iD8TByQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WWV+vn6a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F590C2BCB5;
	Thu, 23 Apr 2026 04:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776918653;
	bh=BDrMUFs5nr1qeG2hIpkJTReHi0lb43W4ihbJodZoCrU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WWV+vn6aufqLhF2uJikDDINIxBqVDv8jXJahw500k2CqGnhPhLSWsOR3YGOFp9bzf
	 SlgToJTqP0u1uK6zIXM/0G+r1GTJUvuhvmLC5wSxOW5Msz+PETvEOzlgioJYUV8cAd
	 0VwZTLrgDo2fFuQs0vwoomIrJXpSF/axBOmPHt6t8NoiEbECEYjramdidap19x4p9N
	 KK+GQz4abPwVLunWuUpa8KGEYyY/uG8DRgWY1ubVChpeNdAc4GfKIpJ4MBmO2uZUXN
	 xGH/v2v9suRz6yaBsmsTaGD5KfWoGeD6Pm09bSgYcBH97Az3zikUGRimhIN8qY4jEr
	 3JjQbtgsXIDlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC273809A86;
	Thu, 23 Apr 2026 04:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_fq_codel: remove data-races from
 fq_codel_dump_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177691861504.4157517.8823364910707992916.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 04:30:15 +0000
References: <20260421142509.3967231-1-edumazet@google.com>
In-Reply-To: <20260421142509.3967231-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-280600-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mojatatu.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3888D44CF57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Apr 2026 14:25:09 +0000 you wrote:
> fq_codel_dump_stats() acquires the qdisc spinlock a bit too late.
> 
> Move this acquisition before we fill st.qdisc_stats with live data.
> 
> Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
> 
> [...]

Here is the summary with links:
  - [net] net/sched: sch_fq_codel: remove data-races from fq_codel_dump_stats()
    https://git.kernel.org/netdev/net/c/bbfaa73ea687

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



