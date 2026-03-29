Return-Path: <netdev+bounces-272961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SIEnAGRqyWnqxwUAu9opvQ
	(envelope-from <netdev+bounces-272961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:07:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6DD353890
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 20:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1232F300399A
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 18:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315593859FA;
	Sun, 29 Mar 2026 18:07:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEA2F288B1;
	Sun, 29 Mar 2026 18:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774807648; cv=none; b=Y4eX2OB08AFADcHuo+GhD5dQ/rCOBEATUf4bT63J/tpf31JxAipE6r0dM5ET1sZZmXPqAwC3H33rXWyr03MrAKCp9xequnut3LgiBms6NdlOt5P+UZTeP9UvVQmJX9JfS7aDKZDsysgKwo3Hz9/Y+06C8hqtISKgn2nb2g9l2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774807648; c=relaxed/simple;
	bh=snyxFHIFoAzNkBHuCvSI8VBoNUXqNfnWI6qNvOvG09g=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=JcoYny0gfBYsRiHZj0OmKWvbO3SeujL2cDyj5Dg+n8YErVFEILI1Txv7wih5ck3vL3dMNzRnLr5m1rvwBy7vj27XWs2mrXED5nBIL0I+DNI8XU2bas6w63MJd+PsVsX19kUGkENEAg3zwg24QlShLQ8nNJZE9v3LaF+CDJFT8f4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 7E14892009C; Sun, 29 Mar 2026 20:07:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 7792392009B;
	Sun, 29 Mar 2026 19:07:18 +0100 (BST)
Date: Sun, 29 Mar 2026 19:07:18 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/2] declance: Improve DMA error reporting
Message-ID: <alpine.DEB.2.21.2603291835550.60268@angie.orcam.me.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272961-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DMARC_NA(0.00)[orcam.me.uk];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.664];
	RCPT_COUNT_SEVEN(0.00)[7];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E6DD353890
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

 D'oh, this v2 fixes a silly thinko in the commit description of 2/2.

 Inspired by a recent discussion[1] I have come up with this pair of 
small improvements to DMA error reporting with declance.  Please apply.

References:

[1] Sebastian Andrzej Siewior, "declance: Remove IRQF_ONESHOT",
    <https://lore.kernel.org/r/20260127135334.qUEaYP9G@linutronix.de/>

  Maciej

