Return-Path: <netdev+bounces-296767-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IGBOMDRHJ2oeuQIAu9opvQ
	(envelope-from <netdev+bounces-296767-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:50:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F10E65B151
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:50:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="EBQEJL+/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296767-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296767-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E32D63016524
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 288683A0E8A;
	Mon,  8 Jun 2026 22:50:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E4AF3B2FCA
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 22:50:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780959026; cv=none; b=Kzqf7R9rqtNO/kQXtP34fi6ghjWcAkilgjch5/WGJvWGOo8rNA49PUV/Zyl5ZO4kx/4TrEqXwk2x3qVJ17ZwSH+ITw8MoTmaIiEwQelhvcRi82dlmY2qwUcgQCO4VbfB2J0lwTEoUM7dn3riFAaxU/sIwNdUvH8OzaRHJhPJSO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780959026; c=relaxed/simple;
	bh=T5i7bXpQ46WKU0ZAPmP6/Zv0sldXYauUPHbTq/jvNH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g5Gj7FTHKWrGDBtccOGxZW1XQq/+xSN2Dz+Kozh7ZeaPGba/WQCp9IQkpw4RxMdA8Xs8laGdavOYofvxSu23iPQ3clkSPZZz4DRO9wT7Z3qkzKh759yA48ETPuwg5XDdc03OSLd1dOuytQLMTQ1FDrQnH64tdJnIVbeySg8Dl60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBQEJL+/; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F7F71F00893;
	Mon,  8 Jun 2026 22:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780959024;
	bh=CPTRs0V+7zqr6gSzloTr0HtLD32F3BoDoQnWfccf2T0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EBQEJL+/JJ3L+gsqFtArAS22gzpurELFW1X1tm+gk3C0KdzMnXlg5wDE1ceIpQM41
	 cgh4+9xAKfZNnFL+sGpBlPBLjr+EvyDmAB5mrmvRKev1RHvdPgYuWnNvtpZyXTfZX6
	 4GfRtPHPBqj+tppEYiB/cksUKj4dVqrTgLsZi4kZXKF3h7ERXpNj4AE5yDB/ClkE6Y
	 HGD4KUIj8YVWHdwSYx2GtF+B6hy3SoxP8V0qwUtEWiC5c1LU2cyHcAW4fhWuKJ6Xzn
	 axY8HoTTOyY9WmAXtQjectsDkmhhJYTtCkxgZEDXKX1yayWpbQrtGGTBACjnu03kVb
	 BERBAAGWR2WNw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939BF3812FD9;
	Mon,  8 Jun 2026 22:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 01/11] batman-adv: tp_meter: initialize
 last_recv_time during init
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178095902313.1702157.1003156200575946314.git-patchwork-notify@kernel.org>
Date: Mon, 08 Jun 2026 22:50:23 +0000
References: <20260605072005.490368-2-sw@simonwunderlich.de>
In-Reply-To: <20260605072005.490368-2-sw@simonwunderlich.de>
To: Simon Wunderlich <sw@simonwunderlich.de>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 b.a.t.m.a.n@lists.open-mesh.org, sven@narfation.org, stable@kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-296767-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sw@simonwunderlich.de,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:b.a.t.m.a.n@lists.open-mesh.org,m:sven@narfation.org,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F10E65B151

Hello:

This series was applied to netdev/net-next.git (main)
by Sven Eckelmann <sven@narfation.org>:

On Fri,  5 Jun 2026 09:19:55 +0200 you wrote:
> From: Sven Eckelmann <sven@narfation.org>
> 
> The last_recv_time is the most important indicator for a receiver session
> to figure out whether a session timed out or not. But this information was
> only initialized after the session was added to the tp_receiver_list and
> after the timer was started.
> 
> [...]

Here is the summary with links:
  - [net-next,01/11] batman-adv: tp_meter: initialize last_recv_time during init
    https://git.kernel.org/netdev/net-next/c/811cb00fa8cd
  - [net-next,02/11] batman-adv: convert cancellation of work items to disable helper
    https://git.kernel.org/netdev/net-next/c/e9dc4072c549
  - [net-next,03/11] batman-adv: drop duplicated wifi_flags assignments
    https://git.kernel.org/netdev/net-next/c/b2e44a67ef4f
  - [net-next,04/11] batman-adv: use GFP_KERNEL allocations for the wifi detection cache
    https://git.kernel.org/netdev/net-next/c/ed497f64a617
  - [net-next,05/11] batman-adv: document cleanup of batadv_wifi_net_devices entries
    https://git.kernel.org/netdev/net-next/c/bb9e48e32d31
  - [net-next,06/11] batman-adv: correct batadv_wifi_* kernel-doc
    https://git.kernel.org/netdev/net-next/c/0e8c38fe9f50
  - [net-next,07/11] batman-adv: tp_meter: update stale kernel-doc after refactoring
    https://git.kernel.org/netdev/net-next/c/0c0f658d9abd
  - [net-next,08/11] batman-adv: bla: update stale kernel-doc
    https://git.kernel.org/netdev/net-next/c/219b4c46db7f
  - [net-next,09/11] batman-adv: uapi: keep kernel-doc in struct member order
    https://git.kernel.org/netdev/net-next/c/f3ff3eb0d6a4
  - [net-next,10/11] batman-adv: fix batadv_v_ogm_packet_recv error handling kernel-doc
    https://git.kernel.org/netdev/net-next/c/7b915cd40bb2
  - [net-next,11/11] batman-adv: fix kernel-doc typos and grammar errors
    https://git.kernel.org/netdev/net-next/c/1e2fa2b10c23

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



