Return-Path: <netdev+bounces-267280-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPNLMW17s2lmXAAAu9opvQ
	(envelope-from <netdev+bounces-267280-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:50:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A84327CE99
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 03:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3392D3039DF6
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 02:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F035533D6EF;
	Fri, 13 Mar 2026 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M5KnEP0X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE4E347BDB
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 02:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773370213; cv=none; b=AVs+LZb6W4j0Nb0VfZpz+v2vxnLO2z1qWNSXRKrKU6f5Tizp+83PDEh4czXvftSbUjH5k+bRoDi7/NwV8+PQA5UXq0GZU16gJ2TC8M/z5plVJzaqdhF/wIKd+u8BmcHDh0BdUs6khA2swzkziGsbmmTZIAtxUPUGSQI0kN+zqRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773370213; c=relaxed/simple;
	bh=ig7uL39F+0uhwydgkIfh24j8dKZV7BeHLDA890UnTIw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UFOeQkmpQToIQZFppiXphGaScOhdo8MI/b2AGPzmiKRPYSxvu2VU9N3+Y1CMqdmbBHr7EZPpq3Rqa3wRejlEDJbeewiHYrPZdOdhGDj43QVQ/BDqKreFI3K6pqasGipO6ZddEsIZviWuvzlSqfP6gG8mr/HJE34/R8+3iKlWBko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M5KnEP0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E5A9C4CEF7;
	Fri, 13 Mar 2026 02:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773370213;
	bh=ig7uL39F+0uhwydgkIfh24j8dKZV7BeHLDA890UnTIw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=M5KnEP0XFGuD7oRwqDuNxtkVJzARqJownulckJhJTdJZrSkPmY0jFRTnZ5cKBRotF
	 S/2W6xURZfAlpokDuat4ZJJoP81vw/U6fJ+Lr+yb6JWaXcigkRfZurvgFLSVbK37v6
	 tOQoy4foZsPSsHVXLSKewF1aVJfl6DXtif/ucjM02IEgtW7SngdLtJBioUSra1pYsg
	 ruuWJIxPXVuUFrOWJ30Bj9tIFE5sHErrE+MhWaWFsYVjD9aO2uzXMW0+o54rTvCIP2
	 vN2dK0kKfc1VEm12vUuur2DoYk81cbpkLiekJjY30y+6P7WaXkqTutsMUcl7Da0mFK
	 lNoP2Epu1KoeQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0483808200;
	Fri, 13 Mar 2026 02:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] ip_tunnel: adapt iptunnel_xmit_stats() to
 NETDEV_PCPU_STAT_DSTATS
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177337020855.648356.3323890825391849448.git-patchwork-notify@kernel.org>
Date: Fri, 13 Mar 2026 02:50:08 +0000
References: <20260311123110.1471930-1-edumazet@google.com>
In-Reply-To: <20260311123110.1471930-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com, gnault@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-267280-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3A84327CE99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 11 Mar 2026 12:31:10 +0000 you wrote:
> Blamed commits forgot that vxlan/geneve use udp_tunnel[6]_xmit_skb() which
> call iptunnel_xmit_stats().
> 
> iptunnel_xmit_stats() was assuming tunnels were only using
> NETDEV_PCPU_STAT_TSTATS.
> 
> @syncp offset in pcpu_sw_netstats and pcpu_dstats is different.
> 
> [...]

Here is the summary with links:
  - [net] ip_tunnel: adapt iptunnel_xmit_stats() to NETDEV_PCPU_STAT_DSTATS
    https://git.kernel.org/netdev/net/c/8431c602f551

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



