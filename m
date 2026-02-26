Return-Path: <netdev+bounces-261102-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kObtCaeTn2k9cwQAu9opvQ
	(envelope-from <netdev+bounces-261102-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:28:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7390B19F673
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 971353004C61
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 00:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168191F7569;
	Thu, 26 Feb 2026 00:27:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qkLrxnBw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E0D3BB4A
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 00:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772065647; cv=none; b=Ei5sXQnbICvo7qquB/ma+lBSoBenIdGy/lm7OqzOQZ96+Nnvg5320Vh1e0zhC55bXkL7oQz0vcpxEaY/qFrIxraZJrQJadus+5Rkwf+4n6H3Dg6D6IsZbRRncpawJuA3bQotflNiQmkWlFWeHcZQH8FZOrktuCoWHrnRgXmBwpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772065647; c=relaxed/simple;
	bh=sVg/+8oGP0q8Fd7sGobugvZnXJY3Faobh5SDoOTT5pc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GW8lYoPR/Ju2ddeMmEf/RMhcSZRDwepxve+qhbR7PF5Dn8tLCuXkQ2iUKABZU/QukaUQDSBDy0nqefUlzz4Lr1+/b/JImIhBXC/0dLlp4scJP8yetynBkPNEDYvJ0AoOz6KB1eVSPt1PCvMLy9kAafHdtesnLZ+YH7nYf/qVhoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qkLrxnBw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A0BBC116D0;
	Thu, 26 Feb 2026 00:27:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772065646;
	bh=sVg/+8oGP0q8Fd7sGobugvZnXJY3Faobh5SDoOTT5pc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qkLrxnBwhGmX69GWS6y21avfaLIRwuPd8EMIfy2gXabRVN5uak2OsiH4tnY341aI0
	 4yPPsh+d6mLPfLD2+TF9Eq1dexgmyW5tBMmCjciEnRmlroH0fwmABAeCUkZ8vKjX/E
	 R7J3iPhu16dR0d+wLGWgeLzLsMmxcuolgjADgoE9NuMgdwC5txd9YrPzG2r1EejRRN
	 ob8TkHgGJL8hzLWczems5gbnygrMFHL7eMjhd6yChp+U3t0oZmhNyBRiJRfN03LKGR
	 iNpW4EQBoRQ3vlVLIrc+LmTH6uEcKlwlPyShQj3M+lpBoKcq/hq8D4n5SdZsssk/hf
	 JR73d4mw4w7Pg==
Date: Wed, 25 Feb 2026 16:27:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: fix .ndo_fix_features()
Message-ID: <20260225162725.551bc03c@kernel.org>
In-Reply-To: <aZ7Ofd7O0xUDh7YG@shell.armlinux.org.uk>
References: <E1vuU3X-0000000Ae9G-1Er8@rmk-PC.armlinux.org.uk>
	<20260224173037.7871e5ac@kernel.org>
	<aZ6xqig4zh_Un8R7@shell.armlinux.org.uk>
	<aZ7Ofd7O0xUDh7YG@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261102-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7390B19F673
X-Rspamd-Action: no action

On Wed, 25 Feb 2026 10:27:09 +0000 Russell King (Oracle) wrote:
> The options as I see it are:
> 1. scan the transmit queue configuration, if any have TBS enabled,
>    disable TSO support for the entire interface.
> 
> or
> 
> 2. rip out TSO support, making the code simpler, and thereby removing
>    the need to try and fix the problems here, and making this patch
>    unnecessary.

normally corner cases like this TSO + TBS thing are handled in
.ndo_features_check. The driver can selectively clear the TSO
feature for a single packet it sees heading down the stack
towards its TBS queue. The stack will then run GSO and feed 
it segments one by one.

FWIW Andrew's suggestion to do the GSO in the driver is very much
legit, but I agree that its orthogonal if you're trying to simply
fix brokenness.

