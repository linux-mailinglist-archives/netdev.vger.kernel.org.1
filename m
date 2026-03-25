Return-Path: <netdev+bounces-271396-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0Fr0F5ljw2mgqgQAu9opvQ
	(envelope-from <netdev+bounces-271396-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:24:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5750631FA1B
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 05:24:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F363A30A2E08
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E3D30AD10;
	Wed, 25 Mar 2026 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="onRitF7h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6E8230AD0A
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 04:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774411829; cv=none; b=OJv26xlHevsBLtxxVw4UXwOYzi2omY9tw4SsjXROIpT8RP4YOhHkjs3J85L92uPnVTC32OOIdlFqHTpUvBrUaZYHu+thULxrHcdOzXCaOmqPFHxuFYbhVjZWHCJ+ESMPTG+I4jwtv/Yvuzm0YZhuebqKrC/a6pqfk44KeBYXD4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774411829; c=relaxed/simple;
	bh=6wfxMxAxaYb09olhZ+8IgyiQ1UYLCEssHEOtqvXv4w4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FO83ObQRlhyNwLgL8e2KNFA/nTaNkoH0u87XVDR/jKG2hy+qcNt/9P81RITfc11LMn0O2p9DEVmMpNj2nuNOaRXBzrCkhsopU/xu/FK5D5NTOuDU5+QCEt5UFtkDWmOquZF0v3teu7dxqQO5/xWVir3igvkrMB0RCJSEXmsUtUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=onRitF7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77D2CC2BC9E;
	Wed, 25 Mar 2026 04:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774411829;
	bh=6wfxMxAxaYb09olhZ+8IgyiQ1UYLCEssHEOtqvXv4w4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=onRitF7hA0d3PKcQ+cLQ33Oe5SX6e6Xz5SJb6PT2QKTUR7oPPC6vcdc/UTS6MJ2uq
	 GuMaBD8kcxmPj/MatMR5MjLr/0eabX4/NbbMbaqePWVIrSJX8F3+iNDdMzpbzkoJgm
	 PpVUludY/5N+/1ZYNvLVTc82L8oI5ONJh0a0CqZxK4lE4I+mLRYJDY4T+hHw2/tXzU
	 /6DuUGfvYElTM7qVXSLlS48Bci3bT/bTzFkMeyXyv5dTCy+zIuQ3IJ4LSSimuHv8C7
	 O3AB8M3P/TOLQ51lj8xCh8blwXN6IexI0djcdcjXPWE4VsSsrk+mGKFQxUvJoZch+M
	 nTlgq2Z9vLT4w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC853808203;
	Wed, 25 Mar 2026 04:10:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v4 net-next] tcp: add cwnd_event_tx_start to
 tcp_congestion_ops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177441181678.1422230.8337669113316666806.git-patchwork-notify@kernel.org>
Date: Wed, 25 Mar 2026 04:10:16 +0000
References: <20260323234920.1097858-1-edumazet@google.com>
In-Reply-To: <20260323234920.1097858-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, martin.lau@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-271396-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5750631FA1B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Mar 2026 23:49:20 +0000 you wrote:
> (tcp_congestion_ops)->cwnd_event() is called very often, with
> @event oscillating between CA_EVENT_TX_START and other values.
> 
> This is not branch prediction friendly.
> 
> Provide a new cwnd_event_tx_start pointer dedicated for CA_EVENT_TX_START.
> 
> [...]

Here is the summary with links:
  - [v4,net-next] tcp: add cwnd_event_tx_start to tcp_congestion_ops
    https://git.kernel.org/netdev/net-next/c/d1e59a469737

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



