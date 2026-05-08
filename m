Return-Path: <netdev+bounces-285994-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLEoKqFf/mnCpwAAu9opvQ
	(envelope-from <netdev+bounces-285994-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:11:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EED64FC321
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 00:11:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CF973032F53
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 22:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7099D374187;
	Fri,  8 May 2026 22:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G9hdO4MN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFA136F40D;
	Fri,  8 May 2026 22:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778278263; cv=none; b=Dhs4KwfLIXOvy4vWaTmcRWlJzr5HPThyKr/IJ9db3s1RaN61E9HascUb10giWhXA0YXvv36a59mAo8gqjw+TyE+lS88QGax0IJRWqZ2tlasF5z9mMmnfv8HRmGEcsTrTMS4NlxcLLX51EiCW1wy9clNZ2KLP0LfqdSLSQ9PgAvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778278263; c=relaxed/simple;
	bh=+5k90Lj2G9/r7Attg359lqwNNNPjn11ZoP/8cDYrpok=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ZtPM2uY7tuxZDDqbe4BTDz42QvqPZtQmvy1qL1PGguDVLIES8Z+8w7OUwmsZkJLP2+WmOjfEDZWiZtqpwjUO/hoc4Etjg3UQdYESnaZS1dPtlx0bbrOkvxSrpcAXwdRNHfr2EnYS4rPzp1IxRek6cuyf7CK0506tN3JPzhUoBZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G9hdO4MN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4733C2BCB0;
	Fri,  8 May 2026 22:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778278262;
	bh=+5k90Lj2G9/r7Attg359lqwNNNPjn11ZoP/8cDYrpok=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=G9hdO4MNazM0RUlMMYFA+U34ggKpHQX3LF6Ze4vou305gCTqrXLqqZjHqzEh1q4Su
	 A0F0IAwHgmCxWzKOj6I5d2usM+zWtt7bcx+G4026PgsNLP/T5SfNOkTcLPvThy1IjG
	 wJH7vE75FsLb1Z5QDsNl0NqSNKZ4DvFhG2haHXXRf+vE2tKa2iaK/WEaLf0LE5027l
	 WRvnlwzh2KAhgHinC0GOsJ7kTBT3NxLRjOqsHf5aITqzMRP1LXuZpmhMRkUF45CSWx
	 Myh4EG6fepKhAIi/4tslsqBHCbDv3Rwu2Ns2HvcU5o9ppspV5VAjDPRwjf4uGEfCd5
	 wpVGAHsVYgp3Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDC438119CC;
	Fri,  8 May 2026 22:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: napi: Avoid gro timer misfiring at end of
 busypoll
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177827821099.868876.2078428236211095016.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:10:10 +0000
References: <20260506090808.820559-2-dtatulea@nvidia.com>
In-Reply-To: <20260506090808.820559-2-dtatulea@nvidia.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, bjorn@kernel.org, daniel@iogearbox.net,
 gal@nvidia.com, joe@dama.to, fdeweerdt@fastly.com, mkarsten@uwaterloo.ca,
 tariqt@nvidia.com, cratiu@nvidia.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 1EED64FC321
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285994-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 09:08:08 +0000 you wrote:
> When in irq deferral mode (defer-hard-irqs > 0), a short enough
> gro-flush timeout can trigger before NAPI_STATE_SCHED is cleared if the
> last poll in busy_poll_stop() takes too long. This can have the effect
> of leaving the queue stuck with interrupts disabled and no timer armed
> which results in a tx timeout if there is no subsequent busypoll cycle.
> 
> To prevent this, defer the gro-flush timer arm after the last poll.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: napi: Avoid gro timer misfiring at end of busypoll
    https://git.kernel.org/netdev/net/c/58e2330bd455

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



