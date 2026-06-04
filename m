Return-Path: <netdev+bounces-295318-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ueN3E/OiIWquKQEAu9opvQ
	(envelope-from <netdev+bounces-295318-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:08:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2B7641B44
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 18:08:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=L0E0ofpZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295318-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295318-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30CAF30C7876
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 16:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6083D7A14;
	Thu,  4 Jun 2026 16:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95491391E55;
	Thu,  4 Jun 2026 16:00:25 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588826; cv=none; b=G6FnxM9AjUuVRA0O1GKUJoUUOmlvQh4thGBP8q8ZLV/eNIrmZzOcGevH8AKROkLRPX1fiZdWcIC7hCkj5YQc5MkEQv90czIUtUzKvWPfiRURGAlSXuv0IcdM0Kw46ViQUVHQNvwONnpPXWWnD6D+k4sIdUZ5JrdcQ3Mpw2mK+X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588826; c=relaxed/simple;
	bh=5Mvt7hsQjRW93hgJ2c6P2ez+LL0PROIEiH8o8Uf0Jy8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BcP7j9HrLWzWRcE8DpWNzvdsizsjNGRunqJvwlLhNZmhOEdDqil0CtIZQpflCEBFX9GLWNz180Q+AWcWclSr5G+vxqNvndDavo8tQfCpWtbXRx7rrolTCThZdg1sXh0AJsGpyG26oGfsIBVKjNjHQrGvsaSODBAdk6Qk0eQrijs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0E0ofpZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D6B1F00893;
	Thu,  4 Jun 2026 16:00:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780588825;
	bh=qcXclboO2qIaa57rWCQiVOhNuR14QDL4omKf50SB4Fk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=L0E0ofpZatU10ebiQTM1jeIsnlshMqcAfu5c2f8N06WHwFvzBVE+Yv5HS5bDlHv60
	 bCYxBumVs6yCxloOQrkkyKl/xtP/hYsPvnG9tyuMoRI+ib2WlVXmJwOIgORXKOAdfq
	 cYqHJFJBJArkkIq4B24V47yIZ9LtX4rSuClEx1ElM9TM9KCITEAa5mpiATgk1vtCAC
	 A/dIE2e7dR0wkVV/iwrHBOD9GGJub91Bm7huoGWJDT4ouMbN8GsczKxsRJ1trzm2Mq
	 mBnt0tenrWoSlqEkoB+yPdYpCr2pZ40ntYrgQDOnyXEjq9U/JkyjX682bGI0aHJsi9
	 xmN4gJy1buHmg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 569CB39309B7;
	Thu,  4 Jun 2026 16:00:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/3] vxlan: vnifilter: fix VNI add/update
 notifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178058882614.2493857.5621998893656016843.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 16:00:26 +0000
References: <20260602185138.253265-1-aroulin@nvidia.com>
In-Reply-To: <20260602185138.253265-1-aroulin@nvidia.com>
To: Andy Roulin <aroulin@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 roopa@nvidia.com, petrm@nvidia.com, idosch@nvidia.com, chirag@nvidia.com,
 shuah@kernel.org, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295318-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:aroulin@nvidia.com,m:netdev@vger.kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:roopa@nvidia.com,m:petrm@nvidia.com,m:idosch@nvidia.com,m:chirag@nvidia.com,m:shuah@kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CE2B7641B44

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  2 Jun 2026 11:51:35 -0700 you wrote:
> When a vxlan device has vnifilter enabled, userspace observers
> (e.g., bridge monitor vni) miss VNI add events and see spurious
> notifications on no-op VNI re-adds.
> 
> Patch 1 fixes the missing notification on VNI add: vxlan_vni_add()
> guarded the notification on a 'changed' flag that vxlan_vni_update_group()
> only sets when a multicast group or remote is supplied, so VNIs added
> without a group (e.g., L3 VXLAN) were silently created.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/3] vxlan: vnifilter: send notification on VNI add
    https://git.kernel.org/netdev/net/c/aa6ca1c5c338
  - [net,v2,2/3] vxlan: vnifilter: fix spurious notification on VNI update
    https://git.kernel.org/netdev/net/c/84683b5b60c7
  - [net,v2,3/3] selftests: net: add vxlan vnifilter notification test
    https://git.kernel.org/netdev/net/c/8df1c84e7272

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



