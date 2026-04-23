Return-Path: <netdev+bounces-280589-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YJISN9KU6WkreAIAu9opvQ
	(envelope-from <netdev+bounces-280589-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:41:06 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F4044C921
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 05:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23D713032F79
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 03:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEDA3CD8AA;
	Thu, 23 Apr 2026 03:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXpx8YRn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C961E3CCFDC
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 03:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776915647; cv=none; b=bbqm7XuxFdw1FdfhaHg8jyUCYcAiJLSASJht5qaMi0+uGzcIlMva8HmS28mRbYLVSlr1k6ZLjo3aBcwBmzhRLUJnin2e1HfGeXRM4Gc66FoMv9m+Jbv+VOybS/woUhAthrgXPETO3Kik8Cc+Guiufa2IWzYV5deNV7dsO0HqiZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776915647; c=relaxed/simple;
	bh=Omw5IeUsvRaR9WseVnr31ahZNnOyW3EvKSafP+v3C10=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aEL5UXCbTQP4iutMV36qCggFxKApUG0ibWrHFB2WKg0D7NHv0Fqcch9FgFyyQYxtGE5PgYEfzO+aFdPF5S1/c4CY1VCjNMaQ7FNQHBjXlXBh6QabmaY/Y0TbuMRB9xLmx6hF9hdJFKpPkQogLDO2wyM5FFaOsIymRqlZEmNHIr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXpx8YRn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D337C2BCB2;
	Thu, 23 Apr 2026 03:40:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776915647;
	bh=Omw5IeUsvRaR9WseVnr31ahZNnOyW3EvKSafP+v3C10=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kXpx8YRn1ySCmgjt+S/E2dz5E8MmZ7E5cW4TSPxkL/cdYlQ0QbHmbAa3MeY1BFet2
	 jeawvy6wpcnzZA3KC3j6FZFjNaaljjjGkiKB5JOtkguIbsTXcYWo8tzSm/eH7KD5aA
	 EUdOUbl5fn4041YGHaHrvNYnIU5LDVDZRcVbr67oBlS8wMYiphZ0AzoysFf5z/DonO
	 Zo4+HXbtRBLy/FE4tLJgSlxmGKlcJRgkttJy4sLVQR7VO4AJcEX1uCglTm//symMpb
	 nWTZQZRLVW6+L19M5K1ICdA6Epon97hzv7x1LRvJiqOqMPMKDn+iFCGTwC6UCJrKwt
	 kUSN3o5d3QZFQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D603809A86;
	Thu, 23 Apr 2026 03:40:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/packet: fix TOCTOU race on mmap'd vnet_hdr in
 tpacket_snd()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177691560954.4145271.18164483820935848818.git-patchwork-notify@kernel.org>
Date: Thu, 23 Apr 2026 03:40:09 +0000
References: <20260418112006.78823-1-patzilla007@gmail.com>
In-Reply-To: <20260418112006.78823-1-patzilla007@gmail.com>
To: Bingquan Chen <patzilla007@gmail.com>
Cc: willemdebruijn.kernel@gmail.com, gregkh@linuxfoundation.org,
 stephen@networkplumber.org, security@kernel.org, davem@davemloft.net,
 kuba@kernel.org, edumazet@google.com, netdev@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,linuxfoundation.org,networkplumber.org,kernel.org,davemloft.net,google.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-280589-lists,netdev=lfdr.de,netdevbpf];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 52F4044C921
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 18 Apr 2026 19:20:06 +0800 you wrote:
> In tpacket_snd(), when PACKET_VNET_HDR is enabled, vnet_hdr points
> directly into the mmap'd TX ring buffer shared with userspace. The
> kernel validates the header via __packet_snd_vnet_parse() but then
> re-reads all fields later in virtio_net_hdr_to_skb(). A concurrent
> userspace thread can modify the vnet_hdr fields between validation
> and use, bypassing all safety checks.
> 
> [...]

Here is the summary with links:
  - [net] net/packet: fix TOCTOU race on mmap'd vnet_hdr in tpacket_snd()
    https://git.kernel.org/netdev/net/c/2c054e17d9d4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



