Return-Path: <netdev+bounces-267282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIsKKXh7s2lmXAAAu9opvQ
	(envelope-from <netdev+bounces-267282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:50:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A51D27CEA7
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:50:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E4363039014
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDB134C134;
	Fri, 13 Mar 2026 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCl0JxQ+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACEB33F59F;
	Fri, 13 Mar 2026 02:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773370216; cv=none; b=eKTYadbG35LvOZQ07GZJlUBcff81LHxvuQGvvCnEywfTgtLppmGOetcDwnYiVQaWVSqfk22/WuvZFlnz+b+c0/KRzgILftH5LXzSi5hrTC0//8GkIwZG7srs1pLhPs6IKweDiIvjojC4i/qO/0wEZOwto0um61G1c0xsPZDpVCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773370216; c=relaxed/simple;
	bh=e65kAdIFOcbb8MuZxCWL1JyYCNYsS2lM4Aqb/x4SyAE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Gq3HOgyMi9EBKROoqRiSRnly8Ncka/WF49PDNNDtChRba2nrOCv8Fs/W6jArXk1LGIrscDfU6ZWORkRF5tcEGwdnGoPQEl3jujj0lX0yebXeeKxbrlnJTs0d7hX9+eOCrtd9Z9HWGw25A2l2l56aJ0mDxvXHn+Qch834jWUEFog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCl0JxQ+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB7BC4CEF7;
	Fri, 13 Mar 2026 02:50:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773370215;
	bh=e65kAdIFOcbb8MuZxCWL1JyYCNYsS2lM4Aqb/x4SyAE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pCl0JxQ+fuNy+2/VHmsbdCEk3RNwxrtUp804J5+DCxzZiNdV0rQzXtvY/yufaFCpf
	 8/wwvFZzgDlOgCt4zqKYa1X3CXJGvG5yo7iURQpLcCJGWsCwWp6StPz9enf/97+kRh
	 zD72vYP1cslsF5uugY07tkHVO04lLG6AhvJCdJvFJ6Rn6x5xtqVHG4bqprwwCztAP4
	 vesOdVpsv9ukMDA/9ox+m6mWcwnxZu8GkaY9Pe5hf4ki0YSfn3GcR8M9aDPpjUzK1x
	 9JSCaism0C46ls3J9Mp6HE5fiQ1/lUSQNFDHAjTbSen4jpv/CfWpbk8fR7QeORy1Mm
	 PszL3wIyH7V2A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEB13808200;
	Fri, 13 Mar 2026 02:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net/rose: fix NULL pointer dereference in
 rose_transmit_link on reconnect
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177337021104.648356.14927018220992811291.git-patchwork-notify@kernel.org>
Date: Fri, 13 Mar 2026 02:50:11 +0000
References: <20260311070611.76913-1-jiayuan.chen@linux.dev>
In-Reply-To: <20260311070611.76913-1-jiayuan.chen@linux.dev>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, jiayuan.chen@shopee.com,
 syzbot+d00f90e0af54102fb271@syzkaller.appspotmail.com, edumazet@google.com,
 davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kees@kernel.org, takamitz@amazon.co.jp, tglx@kernel.org, stanksal@purdue.edu,
 mingo@kernel.org, linux-hams@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267282-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[16];
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
	TAGGED_RCPT(0.00)[netdev,d00f90e0af54102fb271];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4A51D27CEA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 15:06:02 +0800 you wrote:
> From: Jiayuan Chen <jiayuan.chen@shopee.com>
> 
> syzkaller reported a bug [1], and the reproducer is available at [2].
> 
> ROSE sockets use four sk->sk_state values: TCP_CLOSE, TCP_LISTEN,
> TCP_SYN_SENT, and TCP_ESTABLISHED. rose_connect() already rejects
> calls for TCP_ESTABLISHED (-EISCONN) and TCP_CLOSE with SS_CONNECTING
> (-ECONNREFUSED), but lacks a check for TCP_SYN_SENT.
> 
> [...]

Here is the summary with links:
  - [net,v2] net/rose: fix NULL pointer dereference in rose_transmit_link on reconnect
    https://git.kernel.org/netdev/net/c/e1f0a18c9564

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



