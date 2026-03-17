Return-Path: <netdev+bounces-268398-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLExCzW/uGn0igEAu9opvQ
	(envelope-from <netdev+bounces-268398-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:40:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 466F62A2DF4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 03:40:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id A13E83015EFA
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 02:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1EF834DB71;
	Tue, 17 Mar 2026 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lkB9uM+m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B03AF3491F1
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 02:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773715215; cv=none; b=SZIzRMdt8bptw+ZiP9x3EKRlrxRsfXGBAF9R1k+IboWF+/blqjcxXhdropHeC3ioHcy3oVmORuRcWHGjDvNfP3lS2aaaqV3LsHQNwcBmQdMbOlbcUeU183ztL820wb046zipuRI96a93bie+5Ypix52PZmJK7h/6X39JcF3Pyvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773715215; c=relaxed/simple;
	bh=6dI9pxBT6qss0xW2pQw/ZGsc/a+uuwMu6xMEUNWSXus=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kK5h1PObhnvgKNvbqP4s7RkO/ghfKnvQw5OJkrY7nLbRLGuU1jrFIe6HN0i9guoC2y9G/bwVoPQ82nU9JRRdhinzkF/ertyNCFh8Nj6Rc8lyAQx7dfELrh5ZSypMKgBgBlc3JIxDOzkuizOuG9hbWwtQIi1olup3mzwrpqMe62E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lkB9uM+m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE91C2BC9E;
	Tue, 17 Mar 2026 02:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773715215;
	bh=6dI9pxBT6qss0xW2pQw/ZGsc/a+uuwMu6xMEUNWSXus=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lkB9uM+m7h4YwZqRo1Du3amus4lVyWwWsXv0Cmh1PqfE9ayBEs+xMH7gGk4R2+7NR
	 MjnZwVDwH7mKOY6a/6CBDAnJ3wK1OirjK/68bqXGXQNgf/7qIAcGsu1g07PgeHafJq
	 1V4tE48Koe2F7LHcF6z3+CipiTiH8HNwqJUIrAOcEN7cuxZwG0ssftiyX2OKOxbfWX
	 gXypKTuITIN+JfUlGS5FJ3n/vn9nQUaotsUejbW8/HRLJAhaaL8yyfuUGqgaiSe46Z
	 4KXBVK5a3oXThaC3eesdefPZ52UlA7x+JfLOi5QcOIhhpsCuggtNCb+G94m72CKjug
	 ewXrETVRgo5eA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FEC23808200;
	Tue, 17 Mar 2026 02:40:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] tcp: improve inet6_ehashfn() entropy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177371520803.3399897.17363061976477726162.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 02:40:08 +0000
References: <20260313120346.3378811-1-edumazet@google.com>
In-Reply-To: <20260313120346.3378811-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, netdev@vger.kernel.org,
 eric.dumazet@gmail.com
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
	TAGGED_FROM(0.00)[bounces-268398-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 466F62A2DF4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 13 Mar 2026 12:03:46 +0000 you wrote:
> Instead of only using the 32 low order bits of the local address,
> use all of them.
> 
> Xor net_hash_mix(net) with the 32 high order bits of the local address
> so that we can use __jhash_mix() three times.
> 
> If we were hashing 4 extra bytes, we would need one __jhash_final()
> which is a bit expensive.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] tcp: improve inet6_ehashfn() entropy
    https://git.kernel.org/netdev/net-next/c/854587e69ef3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



