Return-Path: <netdev+bounces-301823-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GsGTFnuJPGq7pAgAu9opvQ
	(envelope-from <netdev+bounces-301823-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:50:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 465CA6C23A4
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 03:50:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=MdAStIHM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301823-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301823-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EFE3F3014279
	for <lists+netdev@lfdr.de>; Thu, 25 Jun 2026 01:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5FF384238;
	Thu, 25 Jun 2026 01:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDCBD38236C;
	Thu, 25 Jun 2026 01:50:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782352223; cv=none; b=QmmCAUI2kCFO+ncfgEpM6siVnXlSvvX5vNuFt5RFh2EaI+mVKX3Do3IyNHM8551Mfmej+lriCT1RWPKyQLcefPlkLaPS+A1wbxIvD4+B0jC0Tkw4Wfp9Jrzvf5H/IRug6+26Ct6TNrRbI0HlZwLoEoqZQ6xC8xKNnRAqpOZjOe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782352223; c=relaxed/simple;
	bh=3SSekSvY/kw3gqgvYAAHvbkrEmUCGyGNlJrnEptlnIU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fhxgJxLXfXKE4M62qEQbgmJnzOLFHwWSt1AgLmITvoJ+bS7YFPPOvFPMSZ5cQeVkrlHTuF6aRizilriRPUADAZbLAPmclC/GybIB/O7iKfvocJzw4BhZOU976u0FQ5tSowf8yVSJkpcQtyGGgPfm1VaJAXYrqCdNrcB2oLWxBkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdAStIHM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 990641F000E9;
	Thu, 25 Jun 2026 01:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782352222;
	bh=fLr5SBaZROw1uH9V+5+Th0+iftdyQ8kxpUCEzchCZbY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=MdAStIHMhmy3y12zampdtZNw4a7Gp+afOQhWGehx516Jedz5m9Fjhe6BDo5kHEYkK
	 +kbDqrVYTudTSMRDOXk/yMKX7vhf5kmAyxEwCpb5paM6pVvbMwWKS4S8Rbt+6XyYg3
	 Bvw+QpqHZJRJIE3hdMdGRM0gvTfIYFcQPN2q2ubj4GZBzgbSrWtIblL4KiIm7R7kD+
	 VW+yV8b++jn5ZZdKzhV4kF4q7flOM8+1b5P2Lxm1tSOmHLvmAwhyzGylfYXsFU7EOP
	 114N43SkeVUkc8IE3wP5xTK2DAU+zxDJliz8LXrmAjXFLQUnpVF1yw4hfgJ+Z9rNGd
	 KeIyH5K/Os/HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A2C3AAA6D1;
	Thu, 25 Jun 2026 01:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] octeontx2-af: npc: cn20k: Fix subbank free list
 indexing for search order
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178235221055.3075556.4312731991418835345.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 01:50:10 +0000
References: <20260619095100.1864440-1-rkannoth@marvell.com>
In-Reply-To: <20260619095100.1864440-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, sgoutham@marvell.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301823-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:rkannoth@marvell.com,m:kuba@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:sgoutham@marvell.com,m:andrew@lunn.ch,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 465CA6C23A4

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Jun 2026 15:21:00 +0530 you wrote:
> subbank_srch_order[i] is the physical subbank at search-order slot i,
> so each subbank's arr_idx must be i (its slot), not
> subbank_srch_order[sb->idx].  The old logic mis-keyed xa_sb_free
> and broke allocation traversal order.
> 
> Populate arr_idx and xa_sb_free in a single pass over the search
> order after subbank structs are initialized.
> 
> [...]

Here is the summary with links:
  - [net,v2] octeontx2-af: npc: cn20k: Fix subbank free list indexing for search order
    https://git.kernel.org/netdev/net/c/429ef02895db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



