Return-Path: <netdev+bounces-272526-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPYvO0V0xmlFKgUAu9opvQ
	(envelope-from <netdev+bounces-272526-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:12:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54A0E344055
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 13:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A034A3091D14
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76483396D0F;
	Fri, 27 Mar 2026 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJt3XoGT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D50D3939B0;
	Fri, 27 Mar 2026 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774613427; cv=none; b=WaqzZM8NzvkyKfxv4m+Kca86LQLd4C9VgFrOkXVeHG5SVTolOfjRFduHRbgVxEKp3V3uxhAMesHPnq60xPzQejUUWjjq7xtTWwsfcjdbLmsEpFIVZapBS97Fo6myWGErUYeM5QMGN7S/ZkpCjPm9+gaUps887Uvs0siCJ3TUe1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774613427; c=relaxed/simple;
	bh=pMs5dZVT53XBNv541SjXVYVhabzYxR29APQx46EUiRc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=up5pNyVMmtXtNhQcAikOHG26aHlQg7+7vmuVOcIK0MHgu4sQ1+tEhaDVQsbDzyVvwF7elKb5Prq21N/I86vWOyqc5IWLP0gra3cReXwryX7lJV7RY5DrAILxddWmjoUqES5L87+9SeKLdUj9TDYSAM5nUSdIIDgZuYPWUcqd8jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJt3XoGT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6086C19423;
	Fri, 27 Mar 2026 12:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774613426;
	bh=pMs5dZVT53XBNv541SjXVYVhabzYxR29APQx46EUiRc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MJt3XoGTcxZj96VtwaJ/HnCqwm0fwWcW3/OvtUFYl79NfoTd9CYB32vYYA9kz5+IQ
	 zY15FWgh2YcxQ7muDPDa9psmsPaDVriGUioifgTXAJCKs5W1HzqZGSotTQAlwLaui4
	 g/EuEtT/Rk8xCQqGQ6HwkBj3GpPp1YAymxILO/Tt4EMUdGM5q7MhKTKQgArdjy0sXd
	 cisRhptFBDT857NyyU+EvjELlmw8k4eXJOme73dNZWoSeM7Nm6Zp+S2In5HA0w94PZ
	 QVgjYnCDDLhmL4HLKaLFTCYDsB9RAm5l5a2pbp06CgPs5vfVjWkl0I59decK1W9clC
	 ot9zNPNDfHYZQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDF8393022E;
	Fri, 27 Mar 2026 12:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] tg3: Fix race for querying speed/duplex
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177461341278.3453543.13029114256008044212.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 12:10:12 +0000
References: <20260325112054.108988-1-tbogendoerfer@suse.de>
In-Reply-To: <20260325112054.108988-1-tbogendoerfer@suse.de>
To: Thomas Bogendoerfer <tbogendoerfer@suse.de>
Cc: pavan.chebbi@broadcom.com, mchan@broadcom.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 nsujir@broadcom.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272526-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,suse.de:email,davemloft.net:email]
X-Rspamd-Queue-Id: 54A0E344055
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed, 25 Mar 2026 12:20:53 +0100 you wrote:
> When driver signals carrier up via netif_carrier_on() its internal
> link_up state isn't updated immediately. This leads to inconsistent
> speed/duplex in /proc/net/bonding/bondX where the speed and duplex
> is shown as unknown while ethtool shows correct values. Fix this by
> using netif_carrier_ok() for link checking in get_ksettings function.
> 
> Fixes: 84421b99cedc ("tg3: Update link_up flag for phylib devices")
> Signed-off-by: Thomas Bogendoerfer <tbogendoerfer@suse.de>
> 
> [...]

Here is the summary with links:
  - [net] tg3: Fix race for querying speed/duplex
    https://git.kernel.org/netdev/net/c/bb417456c781

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



