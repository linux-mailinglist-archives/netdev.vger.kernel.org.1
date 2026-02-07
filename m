Return-Path: <netdev+bounces-257729-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IFIQGTnChmmiQgQAu9opvQ
	(envelope-from <netdev+bounces-257729-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:40:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CA311104EDC
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 05:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF6BD300B2B1
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 04:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7484B2DE717;
	Sat,  7 Feb 2026 04:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t+2R3Ms8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5269D2DC32A
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 04:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770439212; cv=none; b=GnFgwPyeAqo8x7YK0n+9h8I5qpQ9i4wdYeI8wsdDR+3AR964YFD1VU2F/cTCWgvMm1zSqqD9tZZLaznrAchxq5zRS4aXqWoOln2J8sYMFeddKbuRaIkMEvp/cb+Jp8T2VPCCHiUz0QJi5w8IwgpmwJmecuWAqYZkl8uMfM7YtS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770439212; c=relaxed/simple;
	bh=vY5etU/zuCCiUYiThgpRnxXwponYRVkwNjNz7CXd3Ks=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=eO3r4P9hDgPn4czz7X5CBQe2Q0GmyQa+4EQhsrQTZfiXxLcUjNtxQnALb3Gh26z+YnCoKreLn25wDAO70eK65kv/rj7A6NDMzpIVnQAN/3uEYPI6r+MGyOvHvj2T8KUpJrYpEYoSFGJIbIGFmDgd1MXoPsQk43BMq35itna2Kwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t+2R3Ms8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5EBC116D0;
	Sat,  7 Feb 2026 04:40:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770439212;
	bh=vY5etU/zuCCiUYiThgpRnxXwponYRVkwNjNz7CXd3Ks=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=t+2R3Ms8llDvp++kbxWlkctCWxvPB+O+w5SUOev8NT1OFsXPC3JyREfUMVXn654db
	 sB26k7tS2bGNVWjd//bymp/u+4nZnMPf62kIdqsDo+uEFiNfi7JW1UBsgS9peVzfCS
	 48wTfaZnPUig21ikrtjVRaT0KiVvTflJAGYIqJCH3DdCI5UYhzcgX9eIDQmFZPvFAj
	 9pTW7HXeUV38oLMUEs0CyD8hpOrMI2scY2pBp+7VcmPEz32bKJ+p1NpkDzTZg9Rm5L
	 V4nmPx3ADSFK2skcpYHeRYQbD/936nifetHLMHWbJOOVqqb8y7zseEoTFqj2ELouqI
	 bBG+9hIA3MbAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 47FD93809A1A;
	Sat,  7 Feb 2026 04:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] ipv6: do not use skb_header_pointer() in
 icmpv6_filter()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177043920907.1189128.5884688687525505560.git-patchwork-notify@kernel.org>
Date: Sat, 07 Feb 2026 04:40:09 +0000
References: <20260205211909.4115285-1-edumazet@google.com>
In-Reply-To: <20260205211909.4115285-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 dsahern@kernel.org, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-257729-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA311104EDC
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Feb 2026 21:19:09 +0000 you wrote:
> Prefer pskb_may_pull() to avoid a stack canary in raw6_local_deliver().
> 
> Note: skb->head can change, hence we reload ip6h pointer in
> ipv6_raw_deliver()
> 
> $ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-86 (-86)
> Function                                     old     new   delta
> raw6_local_deliver                           780     694     -86
> Total: Before=24889784, After=24889698, chg -0.00%
> 
> [...]

Here is the summary with links:
  - [net-next] ipv6: do not use skb_header_pointer() in icmpv6_filter()
    https://git.kernel.org/netdev/net-next/c/a14d93179045

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



