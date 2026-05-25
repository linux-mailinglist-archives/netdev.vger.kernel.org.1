Return-Path: <netdev+bounces-291477-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMf9Bie9FGp1PwcAu9opvQ
	(envelope-from <netdev+bounces-291477-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 23:20:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0FE5CEDAC
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 23:20:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A63530071C4
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:20:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833033998AF;
	Mon, 25 May 2026 21:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GroZkdTX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64688380FFB;
	Mon, 25 May 2026 21:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779744006; cv=none; b=AOl9CHZ195naCtQAAAk1TB8aeELh2pMI59yH6vOPichy8fECEyP0w9AfFF5QJ7bnv75xQuc+JnNXfIwGQ4Us9fTB71PDn0+UIk7fIpTiPLMn2Sx4aSq7FIVDQ3ateVKz94wR54aH9iqnpcmvjXQ6rohfSOqxa/TS0vuJFhxI/tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779744006; c=relaxed/simple;
	bh=CL0xoIhbrnvE/u8dX7oF5lI0HV7nSqUuK+GhV4t5ojk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bC+22dCf6E0UwMa8za5ZCmtu3cLL0Jc/i8tPFY9tttO1MOWNWrqAptv87YrCkXwD3h0z5XHb8mzjnNlnCzrOkVHW1no9nw9LJBF57mZXMhCBdbRkABej5Knlw0kyL12ZRVsU/B7fYSMvXsiisgC/kVUStFn4stg06rYzGA3us1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GroZkdTX; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 488DD1F00A3A;
	Mon, 25 May 2026 21:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779744005;
	bh=CyKtoOC7IsGIcUSRMwnu75jDP8u+4hZzRfx3RonCIUA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=GroZkdTX9elX5y/JMOrKqiJgPXdFQhtut4QQQrs8fh1nyT/Kb5E+256WwNU5geO1n
	 n4U3GMWmiSCR/1L1P4JM/Jw+e66a2NVFRVRLzl5WlYnLILWBu3n8G4qCRKsmrd0uPs
	 30WmwLVz80r87X5JIox7W7vll6QeOgUGdXfpnIsJrikUimUXAuqHRn5Nd1rmV5qU4z
	 SP6VGWNYUbG6+lm5OC5Owdtl6D38li6RuiI3S1RsxgIxVC5DPK1syGgIZRhIB7TiLg
	 4IhtJm4TidZWxe4Ozbu2VD8ouWUseSySA2qXBpL3PmW0liOxYSa/ysraY5nHIJwZoi
	 /j6hn3CM7MQrA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1996F380AA76;
	Mon, 25 May 2026 21:20:13 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: ibm: emac: Use napi_gro_receive() for Rx packets
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177974401164.3119043.10280506460095261853.git-patchwork-notify@kernel.org>
Date: Mon, 25 May 2026 21:20:11 +0000
References: <20260521215908.257118-1-rosenp@gmail.com>
In-Reply-To: <20260521215908.257118-1-rosenp@gmail.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291477-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7A0FE5CEDAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 14:59:08 -0700 you wrote:
> emac_poll_rx() already runs in NAPI context and TAH-equipped EMACs set
> CHECKSUM_UNNECESSARY on verified frames, which lets GRO coalesce TCP
> segments without a software checksum on the merge path. Replace the
> per-poll rx_list batched with netif_receive_skb_list() with direct
> napi_gro_receive() calls so the stack can merge segments into super-skbs
> and skip a full traversal per packet -- a meaningful win on the slow
> 4xx-class CPUs this driver targets.
> 
> [...]

Here is the summary with links:
  - net: ibm: emac: Use napi_gro_receive() for Rx packets
    https://git.kernel.org/netdev/net-next/c/da91508bdd1d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



