Return-Path: <netdev+bounces-276041-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOIuOcMg1Wnr0wcAu9opvQ
	(envelope-from <netdev+bounces-276041-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:20:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9080C3B0D7E
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 17:20:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E9E0301FCD6
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 15:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4BA364E8E;
	Tue,  7 Apr 2026 15:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IiAmks13"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1294136495D;
	Tue,  7 Apr 2026 15:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575227; cv=none; b=WKjOoTfIWz9IUtltAfPJJ7fqSxQ7iilmceaL331+h2FtGWpZACkjd4ER78AvUf8MQLk4jStZho37KL6rNcMKP06bWvb4Bl3nMQgcmQH+wqV/uZlPFKE8ek8Y+cix2gbdgJC6yI3dSja4Wflvc/wvFnsMXnefYnx8NDodx/1njPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575227; c=relaxed/simple;
	bh=yC1TqO1IE6Cf2sou7vpezeLWVXSDs9FIvXQhm4VF3B8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jf3m+MAVJ0lK4w5Z/9WxQ5/7DScm11xL7iHlgOWrt1qtrA5Wq4qI6iBk+9vbwfl6Sl33RJYvbBZxsNJd/wdktPYeZLAZiqR3nDXjEoJK2jMKy44EjblLZCmQ2n6Cvaa/OZb7N/RJjqmkOXtLDv29lwoBrnwqKplSxtGaIDUzWYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IiAmks13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76F3C2BC9E;
	Tue,  7 Apr 2026 15:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775575226;
	bh=yC1TqO1IE6Cf2sou7vpezeLWVXSDs9FIvXQhm4VF3B8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IiAmks139gI4xiHXHlM5LmBjzOiooKJpBsw3auRH51WIvq0daA+A/akQ9WzJCwRr2
	 4Xju8kFyD+VWPFpziayoM8iMWXs+fJJfQrkeQ+nl5qyZoe7en1TQmbCmFeQhbUss+e
	 UUX4Nbcijl4b2bgnLB9apRR9VkU5q8fiulMKosVoUbt2sEJGz1HoesVd5JHeFJgLId
	 QmWwHYHqsqwhVnFNJL6+2TAWdZ0ynMzNFpiHgkWrJR1LyILuAwRIqiRIs1HvXXgbQc
	 ZMQ/FpHJI6lcGZB1aWJmKhDk6fMryjnse6QZghOmWLT2pRZ7rfxFsYYpFVhVtg2rtE
	 P2kXeqhfpr3RQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E753809A2A;
	Tue,  7 Apr 2026 15:20:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/tls: fix use-after-free in -EBUSY error path of
 tls_do_encryption
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177557520455.4033778.1596414160190743186.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 15:20:04 +0000
References: <20260403013617.2838875-1-ramdhan@starlabs.sg>
In-Reply-To: <20260403013617.2838875-1-ramdhan@starlabs.sg>
To: Muhammad Alifa Ramdhan <ramdhan@starlabs.sg>
Cc: netdev@vger.kernel.org, kuba@kernel.org, sd@queasysnail.net,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 john.fastabend@gmail.com, info@starlabs.sg, stable@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,queasysnail.net,davemloft.net,google.com,redhat.com,gmail.com,starlabs.sg];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-276041-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9080C3B0D7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri,  3 Apr 2026 09:36:17 +0800 you wrote:
> The -EBUSY handling in tls_do_encryption(), introduced by commit
> 859054147318 ("net: tls: handle backlogging of crypto requests"), has
> a use-after-free due to double cleanup of encrypt_pending and the
> scatterlist entry.
> 
> When crypto_aead_encrypt() returns -EBUSY, the request is enqueued to
> the cryptd backlog and the async callback tls_encrypt_done() will be
> invoked upon completion. That callback unconditionally restores the
> scatterlist entry (sge->offset, sge->length) and decrements
> ctx->encrypt_pending. However, if tls_encrypt_async_wait() returns an
> error, the synchronous error path in tls_do_encryption() performs the
> same cleanup again, double-decrementing encrypt_pending and
> double-restoring the scatterlist.
> 
> [...]

Here is the summary with links:
  - net/tls: fix use-after-free in -EBUSY error path of tls_do_encryption
    https://git.kernel.org/netdev/net/c/a9b8b18364ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



