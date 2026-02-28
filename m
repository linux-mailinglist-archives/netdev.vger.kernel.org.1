Return-Path: <netdev+bounces-262035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kH4iC41HomkT1gQAu9opvQ
	(envelope-from <netdev+bounces-262035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:40:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 537081BFC43
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 02:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6979D303B63C
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC073054EF;
	Sat, 28 Feb 2026 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xv/ka/7A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC2B3043D2
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 01:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772242807; cv=none; b=RStjnhdKxs0J22+ge8Lj/k+fbnY7ussHXRN6T96DcVRRCRjK7mUIg35THhNwGepEPEvaNY71t09r6O+k+tQzk6KC8WXqZfgtddVxrGan0AsfIrMalu5jEQIOvhL+7VfzY8tGXsHDBF5f/6tB6qb6mgAPgLUQuYU6Kw2ZW44sZSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772242807; c=relaxed/simple;
	bh=pexQoI7Tkmnq6LPpw94cPrFy/IOpKjmGMxKaDuwJSfA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=lpyAB5Qsxh6PmYd8XlZST1tatbGkQVSTg4YwlS6AKBRBU3aRiK4amxyQ/yWuNvECtTZ1QaQagSTSqMZDzevvYKRuWMWBW/QWAEmeaxxQZY+Bnb7wrf0Ue9vcldp8RW3rORB+s6Sw1aFT/6DMTt8u1rHFW60UgIvBTUtItOBA9RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xv/ka/7A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4176BC116C6;
	Sat, 28 Feb 2026 01:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772242807;
	bh=pexQoI7Tkmnq6LPpw94cPrFy/IOpKjmGMxKaDuwJSfA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xv/ka/7AuaeyS7/79IYqFYlvZaJUucCEvAgk7irRPG6IK5Bme84qIr+YOfpcZfPVI
	 ff57FNebEXv2ZTApFBM+iONld9p2nD9Bwrf2zDMPB0uWO2/rGKHjVF6W/fHRYp7OHX
	 68l17bjIRUGhgtW6RfYF038ILf3a7k6lE3mO3q8IC691FhUK6g37+vPOjWTtGItTfX
	 lFlRbY2IYwtIG06FYLOSOQexoZMAogOLj/szm7SfnGMfiL07q4d+zXG0fiuUYEtPF0
	 LuuShP5yhhcUnjGZFMJQREQdlLBId9pVxOju5DxKHfsPFJbbhKCfioTi2fnwnYB5Ue
	 GiBrStXHhcNYQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02C0939EF96A;
	Sat, 28 Feb 2026 01:40:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] net: use try_cmpxchg() in lock_sock_nested()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177224281078.2834458.629658727119303611.git-patchwork-notify@kernel.org>
Date: Sat, 28 Feb 2026 01:40:10 +0000
References: <20260226021215.1764237-1-edumazet@google.com>
In-Reply-To: <20260226021215.1764237-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, netdev@vger.kernel.org, eric.dumazet@gmail.com
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-262035-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 537081BFC43
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Feb 2026 02:12:15 +0000 you wrote:
> Add a fast path in lock_sock_nested(), to avoid acquiring
> the socket spinlock only to set @owned to one:
> 
>         spin_lock_bh(&sk->sk_lock.slock);
>         if (unlikely(sock_owned_by_user_nocheck(sk)))
>                 __lock_sock(sk);
>         sk->sk_lock.owned = 1;
>         spin_unlock_bh(&sk->sk_lock.slock);
> 
> [...]

Here is the summary with links:
  - [v2,net-next] net: use try_cmpxchg() in lock_sock_nested()
    https://git.kernel.org/netdev/net-next/c/5151ec54f586

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



