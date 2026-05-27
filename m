Return-Path: <netdev+bounces-292037-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iEnpK11JFmqUkQcAu9opvQ
	(envelope-from <netdev+bounces-292037-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:31:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A40985DE3D6
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 03:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C8D903002F5D
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 01:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47C1B31714F;
	Wed, 27 May 2026 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGFlEFmL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12A4305698
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 01:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779845414; cv=none; b=b+Aj9HOpzQukLLvksDY6gYIsP4oprayRd7JQQemNodD0WCSFTodYyfnXC80PI91mFOE86QKnzLxvv7t6Xbswim/Wj/gmSH3GbSbS7S1NaxWp2OlCdSUjmFPvqYVNMuASp6ajjfFvVe2+9CnKbujYhY+LNqyUd13JmhS2k8+7/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779845414; c=relaxed/simple;
	bh=N5eNtkNTQzRb7p+jtKIBtvOTEH3TqBpZIJybblIP2EY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bJWP3eRnHdLvlPQtO7jyYDS8zAMIRmsMMhoZajBpjUTML3QfWkN4VLM2Ck2U9R+rk1OFWH3XaFY2YJe4QLV3GK0lmcWobaMnYcLR5pVCLAt/nyJy/WmjOalqgTgMwca9wA1dlrL9lahUt/8yjIQXQU0lVUkTwl4EOQz15FVz/7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGFlEFmL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 673381F000E9;
	Wed, 27 May 2026 01:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779845412;
	bh=DMN+vY0rWS4BwsDUt8R7zj5eFv1UmhMfbCWzdhk8PQI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UGFlEFmL6MbLy2IHJ40xAx0EGzezEfZes6h2RVIPJOzoRRs5/lvRGcq+7S8wgIKQs
	 2wGTQmEuE/nLBIoV9H/jo1SlHatGoeieQudr/e3kXpTd1ED9ci+R1sXPhrWB4dmnrY
	 CZAptBsJPwPOC30rcMeLGz06lWOiSIydnngpSCAdrROGuFqyiP2pGZwof49TogUYBs
	 2VeYnBa5YnIbddgEOaTqI5xd/4yujKAY1N7OZwVixc1LpIKzu1Rik/RiKs7e5s9qz/
	 aHnwiAUdQ2IyxNK7m9a6q+B/3HxS53gzUNWUvFHAZQqQ+LZABu1C1BvJ9zptFgAkZo
	 dG5C4xYTtw3Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569A0380CEED;
	Wed, 27 May 2026 01:30:19 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tunnels: load network headers after skb_cow() in
 iptunnel_pmtud_build_icmp[v6]()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177984541789.4041297.15578320493887338050.git-patchwork-notify@kernel.org>
Date: Wed, 27 May 2026 01:30:17 +0000
References: <20260525201335.2361845-1-edumazet@google.com>
In-Reply-To: <20260525201335.2361845-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 idosch@nvidia.com, dsahern@kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, sbrivio@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,nvidia.com,vger.kernel.org,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-292037-lists,netdev=lfdr.de,netdevbpf];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A40985DE3D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 25 May 2026 20:13:35 +0000 you wrote:
> Sashiko found that iptunnel_pmtud_build_icmp() and
> iptunnel_pmtud_build_icmpv6() were caching ip_hdr() and ipv6_hdr()
> before an skb_cow() call which can reallocate skb->head.
> 
> Fix this possible UAF by initializing the local variables
> after the skb_cow() call.
> 
> [...]

Here is the summary with links:
  - [net] tunnels: load network headers after skb_cow() in iptunnel_pmtud_build_icmp[v6]()
    https://git.kernel.org/netdev/net/c/b4bc94353050

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



