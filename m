Return-Path: <netdev+bounces-252325-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMPVNwodcmnrbwAAu9opvQ
	(envelope-from <netdev+bounces-252325-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:50:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5483466D96
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D72A9253A3
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 12:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67E793A4AAE;
	Thu, 22 Jan 2026 12:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FWA5iGo/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D6F30276A;
	Thu, 22 Jan 2026 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769083810; cv=none; b=NbvKxujWvjo83fDF8QvhBiqnvLys90iwNHwp5ZxTEoz+D1DPs95t0ySDveilqCwdG17CtAYeED33pJOHV/Lrk5BCbZ4QqQOVsutg7BIrwhnibRtXwLv53Rzuh8fMiGP8j0NUUyg2PBi30BCmU4yOm5uGod5f7E8Nmj+HJ8KTbJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769083810; c=relaxed/simple;
	bh=Svh98JjSR+oScYkKa8d8E4X5WQidJC3leo3ei//g1hY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=D1SMjp2sgXNGPk59d8p64Bjd1eg+PHSC9egCxK/zHYT2GheQoIdtiL2FF32HW4wJJWjyyoDMRJAhyp/MD88cstl762YKwJu4pn6cmCV1379g1b2362jYROTO/0W8mHVTAbzYFJEtrGSH00LxKV2R8cz1I5vlyuQaUA+UP+EJoT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FWA5iGo/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A6FC116C6;
	Thu, 22 Jan 2026 12:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769083810;
	bh=Svh98JjSR+oScYkKa8d8E4X5WQidJC3leo3ei//g1hY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FWA5iGo/zjdlJLYHH2+68+VFt9vN/sBsdRTn20+2TL9sDZaIVb7eSO4TyMiwmEVMe
	 6LHJQS1kvO0sLkpJtodlGDDJHMrgfknaM8uzSaUObRaYNNDWmZP7RJ0jo1np21kzls
	 HStzODPZ/QUv+Al+TLdMlN7ZowZWtboHtpmmARVYicEL5k/u+l2FumOqDpz4GEs3kQ
	 COK7TuAiFGQM2j63atqZPWd8gl56vj9W5RZQYM/hRu4Oikg6eIrjxF9L9OBLgI/iMK
	 IZ1DD9HXliXWEjrN4h7jfzBDKPEU8hNLhhNOfYQJcSwmTxvZ/PmNsRDuDdsdqluYkO
	 v19jlb4AjI9aA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11A843808200;
	Thu, 22 Jan 2026 12:10:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: ifb: use u64_stats_t with u64_stats_sync
 properly
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176908380660.1694846.6150290678158927014.git-patchwork-notify@kernel.org>
Date: Thu, 22 Jan 2026 12:10:06 +0000
References: <20260121082348.2388314-1-mmyangfl@gmail.com>
In-Reply-To: <20260121082348.2388314-1-mmyangfl@gmail.com>
To: Yangfl <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252325-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 5483466D96
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 21 Jan 2026 16:23:44 +0800 you wrote:
> On 64bit arches, struct u64_stats_sync is empty and provides no help
> against load/store tearing. Convert to u64_stats_t to ensure atomic
> operations.
> 
> Signed-off-by: David Yang <mmyangfl@gmail.com>
> ---
>  drivers/net/ifb.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)

Here is the summary with links:
  - [net-next] net: ifb: use u64_stats_t with u64_stats_sync properly
    https://git.kernel.org/netdev/net-next/c/cbe38d2e52cf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



