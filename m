Return-Path: <netdev+bounces-289891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Ge2G6GYDWrMzwUAu9opvQ
	(envelope-from <netdev+bounces-289891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:18:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E34C858C3C1
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 13:18:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id F17183020139
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 11:18:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E283939D3;
	Wed, 20 May 2026 11:18:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB40532B99F;
	Wed, 20 May 2026 11:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779275935; cv=none; b=lDb16mdidCu75xot6LhTCnjNht6PNGjYX4SoesiIu6KDqujI8invNjHx64qYBPG1hyD1YuB/ZC+PtaFooSkr0pTRSDq/PeSbCgEhj73zzrFCdPqbJZyV2fXLpsr39Fsr+CGeK5skbIcg7NFuQ7Y6bm5KUUVGdQOyX1rTC8X2BRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779275935; c=relaxed/simple;
	bh=NsQIu3gfs8SIQBf/LMYuZhVBwHZNGeQTOmrrOhUBlfI=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=OeyjPLmAeiXYI2pDgLzMknGcGcY354YDTp1qyD7mzL4xKW6JRhXiiwyjdgFbp08Lyv39ItRS0FI5nbrGRKnTSKkdDz32z+Hl3X32JKQ9qfXaGP8ZEFyn6lm6/3aOBn1E2gb6XBMI3YMoUrzUJj4iXVFbSm7zjY0E5431BopNaCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id C555B92009C; Wed, 20 May 2026 13:18:44 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id C163A92009B;
	Wed, 20 May 2026 12:18:44 +0100 (BST)
Date: Wed, 20 May 2026 12:18:44 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 0/5] ethernet: 3c509: Bring driver back and make some
 fixes
Message-ID: <alpine.DEB.2.21.2605201115010.1450@angie.orcam.me.uk>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289891-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DMARC_NA(0.00)[orcam.me.uk];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,angie.orcam.me.uk:mid]
X-Rspamd-Queue-Id: E34C858C3C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

 As per the previous discussions[1][2] this patch series brings the 3c509 
driver back.  Picking up net rather than net-next as I consider it a fix 
to accidental removal and so that any downstream users do not suffer from 
disruption when using released kernels.

 In the course of making the coding style changes requested I have come 
across an actual bug in transceiver type selection code, where the old 
setting is not masked out before ORing in the new one, causing no change 
to be actually made in a requested transition from BNC to AUI.  I guess 
this code must have been executed exceedingly rarely, as it's always been 
wrong ever since it was added in 2.5.42 back in 2002.

 Therefore I find it not worth backporting to stable branches, however for 
the sake of appropriateness, in case someone downstream does want to have 
the fix, I chose to apply it second in the series, right after the actual 
revert and before code clean-ups.

 The remaining patches of the series should be obvious; see the respective 
commit descriptions for details.

 Please apply.

References:

[1] "drivers: net: 3com: 3c509: Remove this driver", 
    <https://lore.kernel.org/r/alpine.DEB.2.21.2604240004280.28583@angie.orcam.me.uk/>.

[2] "MAINTAINERS: Add self for the 3c509 network driver", 
    <https://lore.kernel.org/r/alpine.DEB.2.21.2604271056460.28583@angie.orcam.me.uk/>.

  Maciej

