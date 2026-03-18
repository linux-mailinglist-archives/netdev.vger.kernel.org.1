Return-Path: <netdev+bounces-268862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 1GcgFpsbumn5RgIAu9opvQ
	(envelope-from <netdev+bounces-268862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:27:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4B52B5781
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 04:27:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 78EF130360A1
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 03:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEB83321BF;
	Wed, 18 Mar 2026 03:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DXSflJNs"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A7221264;
	Wed, 18 Mar 2026 03:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773804440; cv=none; b=msjUQ8/8P1D5NDnq0jP9kuNvk3xJ0ViDnUadivwT0AFfrNEXjrruISk3KJhUDCDtqOeXNgk6iM5drUYQKf5pamcG+l6QrS7mqr6NF3a00gwl0YqD3Gc3lNNBS6Giyhn0W+ZV+1Nq9THhRhs0+FclenKJ6kDXByeA/DFxPlVP22M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773804440; c=relaxed/simple;
	bh=ROD3NFSVkWqgoO/ybbGGf/RRmJURirlhbsgU8LFOnbo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nawOmHakpt1yeqG6bwUFicddYbS8UlxK3pn5UxxP6iu4sTz97YwTFiz75s7lTGCjNNujLEIBziGNTjU5kKdrORMsTtlqx9fEusu7APdlrIuGfxgmEsVW+jtDbuoMPCvkvRNyXyAzVD0WQv14yaIijy2V6fAomtDOlFrdTI3HYNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DXSflJNs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3818FC4CEF7;
	Wed, 18 Mar 2026 03:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773804439;
	bh=ROD3NFSVkWqgoO/ybbGGf/RRmJURirlhbsgU8LFOnbo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=DXSflJNssMfvZKI0jNYIlF3G3Pi9Dld3v2U2jefE1t9afHcvl232I/eDDhWvwwIvU
	 A0bIKkEZhzVpip0sm9h1v/OpNI7R+sGkqOCBk3+lW8ghiFZcWA89ZL4qe2yhVM+/Mn
	 kvb/WarTxUsyA1661m6ekZQJnrkeR8LOslV/v8odHnjXqUO1syVLPKeDNijah/u8A2
	 R+eFT0IG19ckHA412urRZken25zSb8oKf8ayFTaQKgWnr+Bw8CtdJ7P0E8xiArKaMF
	 Lb9duwp2YahU8YfFdaUYW3JjTDcNC3I1pwaj3WwNHC4uCZeGxuRpCfPzBWDNGfI+56
	 4A1ff88u9AQNw==
Date: Tue, 17 Mar 2026 20:27:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sam Edwards <cfsworks@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Russell King <rmk+kernel@armlinux.org.uk>, Maxime
 Chevallier <maxime.chevallier@bootlin.com>, Ovidiu Panait
 <ovidiu.panait.rb@renesas.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 Baruch Siach <baruch@tkos.co.il>, Serge Semin <fancer.lancer@gmail.com>,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] stmmac crash/stall fixes when under memory pressure
Message-ID: <20260317202718.3a5433c4@kernel.org>
In-Reply-To: <20260316021009.262358-1-CFSworks@gmail.com>
References: <20260316021009.262358-1-CFSworks@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268862-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,armlinux.org.uk,bootlin.com,renesas.com,nxp.com,tkos.co.il,gmail.com,vger.kernel.org,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BA4B52B5781
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 15 Mar 2026 19:10:06 -0700 Sam Edwards wrote:
> This is a pair of bugfixes for the stmmac driver's receive pipeline. These
> issues occur when stmmac_rx_refill() does not (fully) succeed, which happens
> more frequently when free memory is low.
> 
> The first patch closes Bugzilla bug #221010, where stmmac_rx() can circle
> around to a still-dirty descriptor (with a NULL buffer pointer), mistake it for
> a filled descriptor (due to OWN=0), and attempt to dereference the buffer.
> 
> In testing that patch, I discovered a second issue: starvation of available RX
> buffers causes the NIC to stop sending interrupts; if the driver stops polling,
> it will wait indefinitely for an interrupt that will never come. (Note: the
> first patch makes this issue more prominent -- mostly because it lets the
> system survive long enough to exhibit it -- but doesn't *cause* it.) The second
> patch addresses that problem as well.
> 
> The first two patches are minimal and intended for stable. The third is a
> general cleanup that removes the `limit` clamp and *solves* the issue of the
> loop mistaking dirty entries for filled ones, rather than *avoiding* it.
> Because this final patch changes the range of stmmac_rx_dirty()'s possible
> return values, it's intended for -next, not stable.

Please (ask your LLM to) read
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html

You can't submit fixes and next changes in one go.

Please have a critical look at the commit messages.
They are very bloviated and not slop looking.
-- 
pw-bot: cr

