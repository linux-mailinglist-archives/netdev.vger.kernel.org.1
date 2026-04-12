Return-Path: <netdev+bounces-277872-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIv8Aejn22laIgkAu9opvQ
	(envelope-from <netdev+bounces-277872-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:43:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D8543E5791
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 73D00300F9D0
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1C136A035;
	Sun, 12 Apr 2026 18:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivHIPA+k"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE1CA5A;
	Sun, 12 Apr 2026 18:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019250; cv=none; b=HsNHKJDzK6vaH8wog6IeLwVLB2pKrgkbYeFkLSrMw2rFqWErCsMTt6cL4hMshJxg8JzYN2zqjKUUipGNJRCacm0uwwc3Yww0Rj7eUoHhmZehPF0cLpaFn01kD1JeDMgW2/vx/3scrKfJUVXyfEhySQpc/8WwFEISiu0J4oDadvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019250; c=relaxed/simple;
	bh=8WWySsScl9MiL4rJ02PKou/vdr3Zoy2gOehGrUzdoJ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Dyos59vEloQ5kVEVpNfuweiYXtruReaS6osG5EBzornXtgJEEPLmwFSOtph/9muJLMGiEFsBdymnkO7ma41JC0R4ymYeaQD1ZA1k4amTmZQAUwnq/BRNhKKRuiLqujQXKTFbkiCKUKzf35OcrXw/dfuaXvXg25Tg7sUnozbuvJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivHIPA+k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA9EFC19424;
	Sun, 12 Apr 2026 18:40:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776019249;
	bh=8WWySsScl9MiL4rJ02PKou/vdr3Zoy2gOehGrUzdoJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ivHIPA+k/wAuk7jQXAtJiyJPXHE0e1sbz/ccvurJIbL9vcnkAjugihP260VvYBRkH
	 xFoxIaOwrfDYfKBlbEyl9FnugI2tzGc7+c6PyWvU5+mGfPMkZo88BdzxicaATtEtR5
	 GIx5UkTZe9NxxR2dTb2HvM7CTmE4CgsMM+8hA8wK0DRJjc4pifhGjHWksAxGg2u+wP
	 SvCOIQJ01xJOJ2fUeG36fZz/DHwMPIO0U/c6Q/y53X1m6jby/KK/Tv4uBaycCifIxI
	 1kaZ6RyQrfTlEE1b6lJ4eJLRByjAz4P8oeG87Q4YPKN8HUcQ5HhGGC72g2oFEETU4E
	 xpQ+OEyGp7prw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDE33809A8C;
	Sun, 12 Apr 2026 18:40:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2 0/5] ynl/ethtool/netlink: fix nla_len overflow
 for large string sets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601922203.3370691.7398703435218885148.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:40:22 +0000
References: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
In-Reply-To: <20260408-b4-ynl_ethtool-v2-0-7623a5e8f70b@gmail.com>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: donald.hunter@gmail.com, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org, andrew@lunn.ch,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com,lunn.ch,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-277872-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ethtool.py:url]
X-Rspamd-Queue-Id: 5D8543E5791
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 08 Apr 2026 15:08:48 +0800 you wrote:
> This series addresses a silent data corruption issue triggered when ynl
> retrieves string sets from NICs with a large number of statistics entries
> (e.g. mlx5_core with thousands of ETH_SS_STATS strings).
> 
> The root cause is that struct nlattr.nla_len is a __u16 (max 65535
> bytes). When a NIC exports enough statistics strings, the
> ETHTOOL_A_STRINGSET_STRINGS nest built by strset_fill_set() exceeds
> this limit. nla_nest_end() silently truncates the length on assignment,
> producing a corrupted netlink message.
> 
> [...]

Here is the summary with links:
  - [net-next,v2,1/5] tools: ynl: move ethtool.py to selftest
    https://git.kernel.org/netdev/net-next/c/22ef8a263c17
  - [net-next,v2,2/5] tools: ynl: ethtool: use doit instead of dumpit for per-device GET
    https://git.kernel.org/netdev/net-next/c/1c43d471a513
  - [net-next,v2,3/5] tools: ynl: ethtool: add --dbg-small-recv option
    https://git.kernel.org/netdev/net-next/c/594ba4477164
  - [net-next,v2,4/5] netlink: add a nla_nest_end_safe() helper
    https://git.kernel.org/netdev/net-next/c/1346586a9ac9
  - [net-next,v2,5/5] ethtool: strset: check nla_len overflow
    https://git.kernel.org/netdev/net-next/c/b2fb1a336383

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



