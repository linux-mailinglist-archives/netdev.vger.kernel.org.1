Return-Path: <netdev+bounces-266437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNryIgzbsGmHnwIAu9opvQ
	(envelope-from <netdev+bounces-266437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:01:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B9625B3C4
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EFF2303A279
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 857D6371055;
	Wed, 11 Mar 2026 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eozGORkq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C4336F419;
	Wed, 11 Mar 2026 03:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773198032; cv=none; b=N1t91uDXdu1rIl7zUYCWITFQcq7nJmFjpyJC/g/urmoXoosPiTL8H0S1+qwCSVJG/x03Uqw1YMtGQK3xUaliws+cKd7i2IBvdLMjUyJX4ifhbF21qCBU8bjFVtczZ6kMrKD9E+HD0jdmqreuzqekaxGbI/utEw0Ju2qYV0Ew8jM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773198032; c=relaxed/simple;
	bh=QCZX6uCYWQS9Cudgh83g257TDd0OEilB3a65roZsYDQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qbcV2ld+ZO0wKRg9ZuCpAl6ZuviKAhusCJRsklzVco8q8PvIRyeUcwn/6DLEW3lOm6L0EZ8F3SqWMzc/6Wyu+OgSKnrNSqYz0BvXz9y1ZWhiRxAiUwYAz5dJzpDy/ZL8MpWR+2P4lzJy4RT+lM8fXjVYfTWfnHehHnG21J7c8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eozGORkq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCEFC2BCAF;
	Wed, 11 Mar 2026 03:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773198032;
	bh=QCZX6uCYWQS9Cudgh83g257TDd0OEilB3a65roZsYDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eozGORkqI6yNlGUJM+Ts7oUi02aMfsP0Bg4ZJy5jAP/1I2kUMP2pmoyS6IwwcksMd
	 UOTxoQPZkkOzsPIW1WB6BMQWuBCTyuu5XTYfAzM86bWvoNqcFrJK8PxPaivSsuc0Pa
	 u7ZzxOYt8NVRF+n1ksHutPlLu5AuywCygBt+1px2T4yR/uR8LBtYVsMNg3N3mPbM0R
	 iaclxiUXBpY+ygEjpGUKOEtJyMj8qQHqi/j1KfswAcYdcD9LnsPweHx/kKyxIRRwB5
	 oKBTO7kxv8TGH43LSbRC9msp34LbEi3Q97p2U12KrnCHOVXNhmDU9Qm6Iznyv0TzG3
	 LlpNu5iPOFSYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F673808200;
	Wed, 11 Mar 2026 03:00:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: sched: cls_u32: Avoid memcpy()
 false-positive warning in u32_init_knode()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177319802854.3019253.7099854699383492435.git-patchwork-notify@kernel.org>
Date: Wed, 11 Mar 2026 03:00:28 +0000
References: <20260309123917.402183-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260309123917.402183-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, horms@kernel.org, gustavoars@kernel.org,
 jiayuan.chen@shopee.com,
 syzbot+d5ace703ed883df56e42@syzkaller.appspotmail.com, jhs@mojatatu.com,
 jiri@resnulli.us, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, kees@kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
X-Rspamd-Queue-Id: 92B9625B3C4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266437-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,d5ace703ed883df56e42];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Mar 2026 20:39:16 +0800 you wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> Syzbot reported a warning in u32_init_knode() [1].
> 
> Similar to commit 7cba18332e36 ("net: sched: cls_u32: Avoid memcpy()
> false-positive warning") which addressed the same issue in u32_change(),
> use unsafe_memcpy() in u32_init_knode() to work around the compiler's
> inability to see into composite flexible array structs.
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: sched: cls_u32: Avoid memcpy() false-positive warning in u32_init_knode()
    https://git.kernel.org/netdev/net-next/c/34bd3c6b0bd3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



