Return-Path: <netdev+bounces-277874-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iGJrJ53p22laIgkAu9opvQ
	(envelope-from <netdev+bounces-277874-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:51:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07BA83E584A
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 20:51:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 96A2D3004F77
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623303630B0;
	Sun, 12 Apr 2026 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CImnb3A4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE7B3002A0
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 18:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776019834; cv=none; b=Le+XU/ZKfUKEOENUCT3JtAF6ms9hoaXtEKXVkqIVzXhTlBiPza2Zw/1GGQvGbXaQdy22BBbAylSVM/XVEBW/HJiiknh/jhqJxCKpv540aruqrCl6Ko/TzED2p/xQ8B8JYMy9V9JjHthRkL0viHZmCQuflyhP8HVd66M113KVxQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776019834; c=relaxed/simple;
	bh=vW3TO8BFgYhaY6pnvCmZWVBwA6m8SDqUpUAW1353BtY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PWfTkwl8ZI1feXaxu4MTKhxAysvpOoYXVDGPtDTiJA+r681XxJb3m/R/WgFUe1EAYuSnvptRJbsi7wYeOsw2dgeKY7dUK/gCtN++owPC7L2LWwe6qC7VJFfjZfDdNSGyqDgdnhGtxx3Am+X2XsTgYE8r0uSVO69op62jr61D1TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CImnb3A4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2125BC19424;
	Sun, 12 Apr 2026 18:50:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776019834;
	bh=vW3TO8BFgYhaY6pnvCmZWVBwA6m8SDqUpUAW1353BtY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=CImnb3A4f+sdJN5luf63J8wsiLLBzs62ScVFE3HoLFKTGLC/8KDWjhU8r362zqa4x
	 NVId7kol9WJcE4Ks5YQa/WKEH/7VOz/5ummg4MNISDCgpZFUS8hax9rXb9erxk+nJf
	 Y7HR/C606/X5O8BgXgw5u9xiBBG3vlaP3eUakIkf9I3zgX2TIyrZvt9g1A60zkmb3U
	 jrC3gEWx7pg/Lt/8jnu4UwHmUatorEf9HfSU/RC4onvEzPRC18QSJf3hRZDfWVyL9I
	 02Ldt3GS9mGQqzzXp8ZejkL0SXp4HGzPH/Vxvv5CEoRDF5PFkbioGGBAGP9YcrU2Qg
	 eV/gGFI9S5Y/w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E0F3809A8C;
	Sun, 12 Apr 2026 18:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net_sched: fix skb memory leak in deferred qdisc
 drops
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601980655.3374222.12646638680165442754.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 18:50:06 +0000
References: <20260408100044.4530-1-fmancera@suse.de>
In-Reply-To: <20260408100044.4530-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, horms@kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 damilola@aterlo.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-277874-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 07BA83E584A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Apr 2026 12:00:44 +0200 you wrote:
> When the network stack cleans up the deferred list via qdisc_run_end(),
> it operates on the root qdisc. If the root qdisc do not implement the
> TCQ_F_DEQUEUE_DROPS flag the packets queue to free are never freed and
> gets stranded on the child's local to_free list.
> 
> Fix this by making qdisc_dequeue_drop() aware of the root qdisc. It
> fetches the root qdisc and check for the TCQ_F_DEQUEUE_DROPS flag. If
> the flag is present, the packet is appended directly to the root's
> to_free list. Otherwise, drop it directly as it was done before the
> optimization was implemented.
> 
> [...]

Here is the summary with links:
  - [net,v2] net_sched: fix skb memory leak in deferred qdisc drops
    https://git.kernel.org/netdev/net/c/a6bd339dbb35

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



