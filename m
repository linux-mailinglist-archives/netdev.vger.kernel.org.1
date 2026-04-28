Return-Path: <netdev+bounces-281904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IwWL2fD8GloYQEAu9opvQ
	(envelope-from <netdev+bounces-281904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:25:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A765486E60
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:25:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E27531445E3
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 14:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAE4443C074;
	Tue, 28 Apr 2026 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m8szO9cS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9850B43C067;
	Tue, 28 Apr 2026 14:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777384849; cv=none; b=Cq/7XJGth8k2MqqQCXqXjVl/w3huDV2BXOVs0ZohSKitp7onhtSWrsuZ9RicegLVkUH5E+vxLuk8KIFA2EzD7imgO4TeC++7VjEZ2arKCGEaJso7ENvrahArrX7T6/y+3XbRoq+qVZopI8Op8kU0jgNbYQ29cvIGixl5UwdGT1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777384849; c=relaxed/simple;
	bh=NBziSZYoFZ+EdSB2M6EHEcyY7Cw7KRxUzRuq0FbasjE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jfcD5R1HLgbzLWj9ZNyv/tUZ9P7RpY+fkCxJ5bk2S8ZbbxGsNfJsq5QM7Ds8MSY9mP/TVeUR0RdoOaZZFbM2RUn4Gnjx73AA9T6z7wsrPHHAIFuUdxmCogpQfinr/qGVl9IOaUC7Oj+GP/MBMAdm/hD80u7TPTbBQc+AuFJV8Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m8szO9cS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F46CC2BCAF;
	Tue, 28 Apr 2026 14:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777384849;
	bh=NBziSZYoFZ+EdSB2M6EHEcyY7Cw7KRxUzRuq0FbasjE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=m8szO9cSeuruYB/0fjOohiKHDIP9Ni+07Ym84Mp6q9Wl81jaAty7JR2o0m6OxXkXE
	 VCLcS6mNIuQnOEeOOLW7GJjv9LMfeO9s97Qib4ms3gG6FLoA5IthErWHLzdOQxl7Jw
	 yH2iIp17kvcXVL1VxBK+COvQlFmlnUIGwQfhvrteHnLRH/tRBq9OO1OBrZa5ZvBkyX
	 ZTq9cvTmjtPZHHErFfqgseSjiD4vGVg74adAilrXMPgXtwrDR3Zk4+aIxt2qXbbuAq
	 MGA/OkeHaC9T4Q3d6hrHPgiAYYzweJubPOwCFc0WBb1YRTDJr4Do9rEYL5dJFTsFaI
	 ilyimWOcAELfw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 6CA1D393020A;
	Tue, 28 Apr 2026 14:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1] net: phy: dp83869: fix setting CLK_O_SEL field.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177738480633.924994.11428544442154534477.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 14:00:06 +0000
References: <20260425031339.3318-1-hs@nabladev.com>
In-Reply-To: <20260425031339.3318-1-hs@nabladev.com>
To: Heiko Schocher <hs@nabladev.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, linux-kernel@vger.kernel.org
X-Rspamd-Queue-Id: 1A765486E60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,gmail.com,kernel.org,redhat.com,armlinux.org.uk];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281904-lists,netdev=lfdr.de,netdevbpf];
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
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nabladev.com:email]

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 25 Apr 2026 05:13:39 +0200 you wrote:
> Table 7-121 in datasheet says we have to set register 0xc6
> to value 0x10 before CLK_O_SEL can be modified. No more infos
> about this field found in datasheet. With this fix, setting
> of CLK_O_SEL field in IO_MUX_CFG register worked through dts
> property "ti,clk-output-sel" on a DP83869HMRGZR.
> 
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
> 
> [...]

Here is the summary with links:
  - [v1] net: phy: dp83869: fix setting CLK_O_SEL field.
    https://git.kernel.org/netdev/net/c/46f74a3f7d57

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



