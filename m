Return-Path: <netdev+bounces-278987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLx2HlK44GmIlAAAu9opvQ
	(envelope-from <netdev+bounces-278987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:22:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8B240CDCA
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 12:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B67F3049977
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 10:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25CAF39E17C;
	Thu, 16 Apr 2026 10:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TYaseN5b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020A839D6E6
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334837; cv=none; b=IC6f/5+5J1lxUe3rtH4YwU7tz82YX9iBTwYUCna25cDlVeXhi2MkLfphKDcbeG4+21dACh9CNzPIZWUA83S9BNMXFVK+AGxiMLav3iakElwAuY7txoZbariXbErg+Wy5C1XvlMxuolzJBK/gkk582jRsC8byMOoA/cKJIjaVrIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334837; c=relaxed/simple;
	bh=3fkZP5+gmMNBxSRR06WR7MiCqP0W09tOeUHiU+dKsw4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ViBvkjbPWZIeV5HeHo77EGvPYpPffnuXjaOvQE8mh86impwnPYV8nQc6IXNOwpXYG7/aWZ09/Nyt3oIBu2yTQzheeDMTlwR6WB2Huhy3Gukk7KdPfuGfU7y9Uvw+PmGW88GuV68k+xAbo2n38jmsAMcs8sJY6hV1huzS7SFlJCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TYaseN5b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84468C2BCB0;
	Thu, 16 Apr 2026 10:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776334836;
	bh=3fkZP5+gmMNBxSRR06WR7MiCqP0W09tOeUHiU+dKsw4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TYaseN5b2LnPkVHLe7Kc/wPb6Y1TiTLmSP54WryKnHynr1mvHMZJXlOSttopiI5gN
	 cmCeDFq3qsY/lzPaVSMUadk15ZP9XNmjVSrIlWcimX+Y4cHnghL1nab4GkqwYNGCjg
	 uqAyv+4VUg8H9Yj6O9GYqWmKTB4QczGecvOwXFgH2oTQy2AryklX587gIhJZpTgHoP
	 +uBPtmHoEG8A50iet4+8qVXLNmaGrjyWMYyC9kzM1uBU6DVZYttzI1w+w8aoubBUqx
	 N54UBIs061k3QsPiSIn5J8Gbxz2ZQDw+jAyjO16pybewu3lVQ16ULwBOQThC4fpJJv
	 H6Lf7q5vB5zHw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE70380A97D;
	Thu, 16 Apr 2026 10:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] macvlan: fix macvlan_get_size() not reserving space for
 IFLA_MACVLAN_BC_CUTOFF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177633480530.2723350.2222193902436957628.git-patchwork-notify@kernel.org>
Date: Thu, 16 Apr 2026 10:20:05 +0000
References: <20260413085349.73977-1-phx0fer@gmail.com>
In-Reply-To: <20260413085349.73977-1-phx0fer@gmail.com>
To: Dudu Lu <phx0fer@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278987-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DC8B240CDCA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 13 Apr 2026 16:53:49 +0800 you wrote:
> macvlan_get_size() does not account for IFLA_MACVLAN_BC_CUTOFF, but
> macvlan_fill_info() conditionally includes it when port->bc_cutoff != 1.
> This causes nla_put_s32() to fail with -EMSGSIZE when the netlink skb
> runs out of space, triggering a WARN_ON in rtnetlink and preventing the
> interface from being dumped.
> 
> The bug can be reproduced with:
> 
> [...]

Here is the summary with links:
  - macvlan: fix macvlan_get_size() not reserving space for IFLA_MACVLAN_BC_CUTOFF
    https://git.kernel.org/netdev/net/c/fa92a77b0ed4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



