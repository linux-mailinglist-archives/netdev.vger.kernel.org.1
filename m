Return-Path: <netdev+bounces-281565-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDLNK3oE8GlmNQEAu9opvQ
	(envelope-from <netdev+bounces-281565-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:51:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B147C3C7
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:51:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D8CF53007239
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 318AC218ADD;
	Tue, 28 Apr 2026 00:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D7Xm5TpN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F45B1BD9C9
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777337460; cv=none; b=HH9a/t3rnNTXToTCfi8KHHIdgN4kqP1HRbowpKMqtlkdGWuhv1X8nANa3h5c5gUapHSJumNCMOtQ3Y+Xez0KvUIK23T68zbPLZ1rAlEquWvecLYkOEV7bUgpZoBcUt3Bup7gRYqEKxA1Iv31BkAan9K+lDMRRdfqLGyFPguLF/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777337460; c=relaxed/simple;
	bh=lsFxvBdCYWNnGXrj0HAtYyc953fGogg+wwOtIHFtFYI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MV7kK6jtJoLPpeZcht3mCdd6YStTQU2I4dc6KRbebvjS3Y1CVBQcq+AC10qI9iOWoU9KzzXdr8KX/oK/HiLANKBMhWApd/lqT4wyUcvHQR0k1BRIpimhIb2USrFhiB0zr0N4C0RxLvw+uEvDNDoEUt+MmMLo5MurwpZMjbd/e0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D7Xm5TpN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0CB8C2BCB4;
	Tue, 28 Apr 2026 00:50:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777337459;
	bh=lsFxvBdCYWNnGXrj0HAtYyc953fGogg+wwOtIHFtFYI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=D7Xm5TpNGXEpgaK4waMPxUfDpk5sKKjQkmp71nO1Q+F/BsHOCs5OabkDeH1avHQdJ
	 sl4OJiT80mB5UCRaKv0ZGg3j34dNZnmEhZ/96DfiMDl511wNEycRYy6T8GZ1tLqkre
	 QBjcrvO0BYxFDXwbTIvgvyfMAWhmacVelgKBEnTxe5hn35JEjbHFFiZz0vGUChC6nd
	 KLRMfWtJaT9C04MZ8OlRGkgkXrqjvQVC8vNYZD2LKRIh+QH4eoniR9NhJ8Nia1caps
	 RaUwkjboiGBm/vs1/+/rU+rLT+pAs8uVY4XIxZURMgnJ1v4+AADBGuGG2uaaOHWt/9
	 thCVlr8bUeXGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FD4438119DB;
	Tue, 28 Apr 2026 00:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: airoha: Do not wake all netdev TX queues in
 airoha_qdma_wake_netdev_txqs()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733741679.177472.12823234814515081752.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 00:50:16 +0000
References: 
 <20260421-airoha-wake_netdev_txqs-optmization-v1-1-e0be95115d53@kernel.org>
In-Reply-To: 
 <20260421-airoha-wake_netdev_txqs-optmization-v1-1-e0be95115d53@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
X-Rspamd-Queue-Id: A07B147C3C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281565-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 21 Apr 2026 10:53:33 +0200 you wrote:
> Do not wake every netdev TX queue across all ports sharing the QDMA
> running netif_tx_wake_all_queues routine in airoha_qdma_wake_netdev_txqs()
> but only the ones that are mapped the specific QDMA stopped hw TX queue.
> This patch can potentially avoid waking already stopped netdev TX queues
> that are mapped to a different QDMA hw TX queue.
> Introduce airoha_qdma_get_txq utility routine.
> 
> [...]

Here is the summary with links:
  - [net] net: airoha: Do not wake all netdev TX queues in airoha_qdma_wake_netdev_txqs()
    https://git.kernel.org/netdev/net/c/e070aac63b42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



