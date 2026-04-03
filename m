Return-Path: <netdev+bounces-275236-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0GxdBtk40GmP4wYAu9opvQ
	(envelope-from <netdev+bounces-275236-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:02:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE573989EE
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 00:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69293303A90F
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 22:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9435282F14;
	Fri,  3 Apr 2026 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k1usFlrT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D531A0BE0;
	Fri,  3 Apr 2026 22:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775253630; cv=none; b=CYciZHi4pBybLr4fkRzTxRYh/7a+HZGcvESh/pEZB6W8idnGXnCYKZdHkjQbqvzH9ts7xFsESwcPpBhkV3WczjAMe421EwY6jW8V+FeIeHBuIOrtEA72Z1B4b+jvQs7e0jGPTrZm1/RjZ9gsQ/0IfhYPHaALgnPEYJtH+Sm74gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775253630; c=relaxed/simple;
	bh=5G7a+STOIFLU11qszUPGIyzNKSIJstNDZ+WCrEGGScY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JzGxP990hPIqoE+vjDo1olox0q4GtkoGKYZ5fu5WeJWG6iWTCV7LSZx88ug2qtInT7gVRVNveqjEhw184pXLI4APCzwC84SMBhx30L/3slOyLJxQdj/mZF6gZdbTJHSkJXSjQqLVRl6YVWhQ/7KwBtsmDOFi5mEP/pYJfNSZUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k1usFlrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32846C4CEF7;
	Fri,  3 Apr 2026 22:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775253630;
	bh=5G7a+STOIFLU11qszUPGIyzNKSIJstNDZ+WCrEGGScY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=k1usFlrTZkQB4Bnor6tA3Ka3/eD6DLB7+zb0dRzsW0TIkj8hiWqSIMT755PUFVCw8
	 zvgeXnfdOV//iJBr3oMkSNZk7LPNAFwIxIt1K5zEB00gFbFbXbMlJTY/D27B3uOOjo
	 FoUTFdJ4ZVZlGJnUv2wTZd15b+ciXytqR3M7z/pMPxmJiNCDjHHSa4Om8ULBGHknHO
	 LLXC5o8GPAekphYruJVI26IMZ/xP20pc+moBdtFjRxm6EWC2Qs5Ty2AXdb93UKK3eh
	 EuXPWwRG+Xxn9PV647mFLwmAerxVwjDaNNBSkJkUAltQDKKAaz780jQNXDJbJ1yM4C
	 9kyO3/D7TxKgw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02CBD3809A14;
	Fri,  3 Apr 2026 22:00:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] bridge: guard local VLAN-0 FDB helpers against NULL
 vlan
 group
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525361154.1466030.16446326031182499464.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 22:00:11 +0000
References: <20260402140153.3925663-1-yzjaurora@gmail.com>
In-Reply-To: <20260402140153.3925663-1-yzjaurora@gmail.com>
To: Zijing Yin <yzjaurora@gmail.com>
Cc: netdev@vger.kernel.org, bridge@lists.linux.dev, razor@blackwall.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, nathan@kernel.org,
 nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com,
 petrm@nvidia.com, linux-kernel@vger.kernel.org, llvm@lists.linux.dev
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275236-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,blackwall.org,nvidia.com,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,lkml];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FE573989EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 07:01:53 -0700 you wrote:
> When CONFIG_BRIDGE_VLAN_FILTERING is not set, br_vlan_group() and
> nbp_vlan_group() return NULL (br_private.h stub definitions). The
> BR_BOOLOPT_FDB_LOCAL_VLAN_0 toggle code is compiled unconditionally and
> reaches br_fdb_delete_locals_per_vlan_port() and
> br_fdb_insert_locals_per_vlan_port(), where the NULL vlan group pointer
> is dereferenced via list_for_each_entry(v, &vg->vlan_list, vlist).
> 
> [...]

Here is the summary with links:
  - [net] bridge: guard local VLAN-0 FDB helpers against NULL vlan group
    https://git.kernel.org/netdev/net/c/1979645e1842

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



