Return-Path: <netdev+bounces-304036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sh49KhQqRmqaKwsAu9opvQ
	(envelope-from <netdev+bounces-304036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:06:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F786F50EE
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:06:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=erLP9qVF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304036-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304036-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 63CA13055607
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 08:41:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2C2366553;
	Thu,  2 Jul 2026 08:41:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A463546E4
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 08:40:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782981661; cv=none; b=awNVfVXjEzrvrxe4QvrWTVrw/GCt7lo12ycC25TOukUkCb1zca2KFOREaYgPsSytbSBqdYFG/lrz27Aoacb+mZChv0nv0/N7wL9QZ0oLF6dIPLs0TKPNGaqh5m9l3ZkFFMAQ9BaDx27VnbCcVtASnPcnGvFpGGZSnDTSYOzzO84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782981661; c=relaxed/simple;
	bh=xz5pggjjq1veE9NlAkCV8Chw4rKP1Msm9Fqu54kxLfE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mzVBP4h3SfSLQFsbnmVbrhJ8AaWKRTegFK+L4W1ZC/F3Amqtb1tWGjRAUpYgx2IRDcOlXtTikmXQaVYgP0SigKnEDztf/lNro1vKeW8zktE7XwOkNukgdqZnxkhR6nL63SgKjgoQzpP4WWTV/O9I7ayIc4MFoxm/wTTvamXiR14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erLP9qVF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D390B1F00A3A;
	Thu,  2 Jul 2026 08:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782981659;
	bh=rlECEzGVBnRQcX1PJHlOlcimtBsMPxut6cTFhxNIhiU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=erLP9qVFeoBKHxbL5S7+0GXPVVPi5R49WQM/bQe7BGucsZeYJHSIwc775V9xTS0R+
	 7XJBgRHKLvByjqT5507N6HqkIjNazNm7Kvf2DUIjuuW0uHWVvmi8o6xOw4Ms6r2i9A
	 JkipjPf2QxfmpN7YZExKSQ0MPYVL46OG/WvkQdKxsI3E9a68Sk4SxwB/e3vlxREcPy
	 3bQK3G/E4e/bzUADxS+xEiZNO/v9evCWmajFbbunWQjVyboDAizqr9LMZE1fE/zdPD
	 dnBh6a9eZGWsvNAThX8HmB0pS3DMLgEtGZ00O7KyZn524+suXM4pqtDLqAI8T0RVSj
	 1FXzKgKN0QEGg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1983C3926664;
	Thu,  2 Jul 2026 08:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/15] batman-adv: create hardif only for netdevs
 that are part of a mesh
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298164263.1523446.6187059831704914179.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 08:40:42 +0000
References: <20260630140623.88431-2-sw@simonwunderlich.de>
In-Reply-To: <20260630140623.88431-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, neocturne@universe-factory.net,
 sven@narfation.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304036-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:sw@simonwunderlich.de,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:neocturne@universe-factory.net,m:sven@narfation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[narfation.org:email,universe-factory.net:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21F786F50EE

Hello:

This series was applied to netdev/net-next.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Tue, 30 Jun 2026 16:06:09 +0200 you wrote:
> From: Nora Schiffer <neocturne@universe-factory.net>
> 
> batman-adv is using netdev notifiers to create a hard_iface struct for
> every Ethernet-like netdev in the system. These hardifs are tracked in a
> global linked list, which results in a few performance issues:
> 
> Lookups in this list are O(n) in the total number of netdevs. As a
> hardif is looked up when a netdev is removed, this also takes O(n) in
> the number of netdevs, and removing n netdevs may take O(n^2). This
> slowdown will always happen when the batman-adv module is loaded, no
> mesh needs to be active.
> 
> [...]

Here is the summary with links:
  - [net-next,01/15] batman-adv: create hardif only for netdevs that are part of a mesh
    https://git.kernel.org/netdev/net-next/c/fcba102e0e4a
  - [net-next,02/15] batman-adv: remove global hardif list
    https://git.kernel.org/netdev/net-next/c/49e9de6e124f
  - [net-next,03/15] batman-adv: make hard_iface->mesh_iface immutable
    https://git.kernel.org/netdev/net-next/c/f846e779532e
  - [net-next,04/15] batman-adv: remove BATADV_IF_NOT_IN_USE hardif state
    https://git.kernel.org/netdev/net-next/c/48ea7b6b7b94
  - [net-next,05/15] batman-adv: move hardif generation counter into batadv_priv
    https://git.kernel.org/netdev/net-next/c/cbda6a6cf2a5
  - [net-next,06/15] batman-adv: drop unneeded goto and initialization from batadv_hardif_disable_interface()
    https://git.kernel.org/netdev/net-next/c/2b429dbc50b4
  - [net-next,07/15] batman-adv: drop NULL check for immutable hardif->mesh_iface
    https://git.kernel.org/netdev/net-next/c/b58c36b804f4
  - [net-next,08/15] Revert "batman-adv: v: stop OGMv2 on disabled interface"
    https://git.kernel.org/netdev/net-next/c/5fa5f64fc018
  - [net-next,09/15] batman-adv: iv: drop migration check for batadv_hard_iface
    https://git.kernel.org/netdev/net-next/c/ba2d97e8736e
  - [net-next,10/15] batman-adv: tvlv: extract tvlv header iterator
    https://git.kernel.org/netdev/net-next/c/278e5890704c
  - [net-next,11/15] batman-adv: tp_meter: simplify unordered ack calculation
    https://git.kernel.org/netdev/net-next/c/71b7987ec001
  - [net-next,12/15] batman-adv: tp_meter: combine adjacent/overlapping unacked entries
    https://git.kernel.org/netdev/net-next/c/936a1c10cece
  - [net-next,13/15] batman-adv: tp_meter: keep unacked list for receivers
    https://git.kernel.org/netdev/net-next/c/3bbb8b94217a
  - [net-next,14/15] batman-adv: tp_meter: adjust name of receiver lock
    https://git.kernel.org/netdev/net-next/c/6cd45ef4dfa5
  - [net-next,15/15] batman-adv: tp_meter: delay allocation of unacked entry
    https://git.kernel.org/netdev/net-next/c/247691642fd4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



