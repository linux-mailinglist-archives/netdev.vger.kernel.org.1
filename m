Return-Path: <netdev+bounces-302370-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id w8/cIY9UQGpfewkAu9opvQ
	(envelope-from <netdev+bounces-302370-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:54:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A2576D2C9B
	for <lists+netdev@lfdr.de>; Sun, 28 Jun 2026 00:54:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=O5JSPTbn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302370-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-302370-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A798300B13E
	for <lists+netdev@lfdr.de>; Sat, 27 Jun 2026 22:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC4E345CBF;
	Sat, 27 Jun 2026 22:50:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B6E3382C3;
	Sat, 27 Jun 2026 22:50:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782600659; cv=none; b=czPDfsMT92ICMndk8oTqJSQI5D/v4gqeDwLi2bNy9qsl5bOAadYYsSQxK0TFLU5DfNusiXjgT3rGw/G2qXUmRTEZNlUsx5hUjPcfsN7Vsxr128/LHL3qdp9+Jy1xBTVKSyQfQChLLJUBRbJeo+qji+fsmXhcdG9hpPL0eaxkaLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782600659; c=relaxed/simple;
	bh=7pN58KAjqRzxmECDQFd/BlH0XKgQyoUo0/7Qd2x9vK8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D+a+BJeQ1FcAA90yGVdbaZ1KFGO5V/lzrid/hzGNceYcvjyQTQ577Ace4d2H/czaxLJJng3FcIk3U1nwiKMnRShtP4RQoEsEJjyT3MynsbWU/gCNv7bMGk++YDn5syKxch1HNEmnHMhb8J3QqWnk9o0dsmdA3J5KlRseX5RquCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5JSPTbn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB72D1F00A3A;
	Sat, 27 Jun 2026 22:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782600647;
	bh=Wx5JmIrHjn2nOrnRlXE/MNwWt4FjR4DXRdY4uRTqoKs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=O5JSPTbnCXwnh7e6QnKmiG8/OMyBwflxQybl7dJONOKiOdMxbtijfMrR2hloC9LdB
	 mN5bsHQ1h5oy5BKOyhf25vJNO3dVaIfBJZNegocKWa+mMBSBCiHwrKLeRL/4lWRcli
	 1bT7Llbhr1SZOQ2O3WfvP7CS4qtkl3khS2EXTMqLxDkmNBxyciCrXZVLyVAx7aNJcl
	 mNEQDD3141PAJclL+3vetGcCJnjxWVwqBkimDCw/KEuiaduPCLzbJLsYumDTFZEw27
	 ns+Ele1D3G+qFfNZYYcOWrrrCKM1KMeEhUJLh3xw9rUjwZm1gZz7r+7r0VXitfo28y
	 i+vPJPvVm2REw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09773938452;
	Sat, 27 Jun 2026 22:50:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: Update Marvell octeontx2 driver
 maintainers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178260063332.1451849.10661256898846524415.git-patchwork-notify@kernel.org>
Date: Sat, 27 Jun 2026 22:50:33 +0000
References: <20260626044819.3004811-1-rkannoth@marvell.com>
In-Reply-To: <20260626044819.3004811-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-302370-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sgoutham@marvell.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,marvell.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8A2576D2C9B

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 26 Jun 2026 10:18:19 +0530 you wrote:
> Update the maintainer entries for the Marvell OcteonTX (RVU) drivers to
> reflect recent organizational changes.
> 
> Signed-off-by: Ratheesh Kannoth <rkannoth@marvell.com>
> ---
>  MAINTAINERS | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Here is the summary with links:
  - [net] MAINTAINERS: Update Marvell octeontx2 driver maintainers
    https://git.kernel.org/netdev/net/c/56114690ff3c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



