Return-Path: <netdev+bounces-272888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMynGDwcyWnpugUAu9opvQ
	(envelope-from <netdev+bounces-272888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:34:04 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D1C351EDE
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 14:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7322301C17F
	for <lists+netdev@lfdr.de>; Sun, 29 Mar 2026 12:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1715836BCC3;
	Sun, 29 Mar 2026 12:32:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD33B36214D;
	Sun, 29 Mar 2026 12:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774787570; cv=none; b=XH3nwAo7MF4CWN5in+J8vSFSISwNYrmoPIXQ1FSK2qg3hhQ4H1ol3z4sQ2r5KFBeKNYhzIX+C/zI3d8Bc+nkdkou/3u8yNHTvVal1NetwXjXdFcmtuJD2A2ItlKCQtka4HiTjh2Zj3PPuTOYeidrV7aVW7fxUXiSs8NWIPu/4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774787570; c=relaxed/simple;
	bh=KdRpglc4rYbUge1GsbYtBnFLM9nn+7hGXCgcit3Uwjg=;
	h=Date:From:To:cc:Subject:Message-ID:MIME-Version:Content-Type; b=qCZFrmPOrVICQ1DGGywJ2PyjMnb/CSumpitxY+rhZSkh7vh/jtEvQFKQerMgreGF20ZjgeKoFyOZsAHTHwI78MTDsz2hj5VHwrc9a+CUHSeTCCVsHmjZOw4ijsaLEOECM03Vi5NGluY3FzcBTgoRL7aXzZaOG2Ceutbqo//bJN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id 41EBE92009E; Sun, 29 Mar 2026 14:32:47 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id 3BAF892009B;
	Sun, 29 Mar 2026 13:32:47 +0100 (BST)
Date: Sun, 29 Mar 2026 13:32:47 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
    "David S. Miller" <davem@davemloft.net>, 
    Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
    Paolo Abeni <pabeni@redhat.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] declance: Improve DMA error reporting
Message-ID: <alpine.DEB.2.21.2603291259140.60268@angie.orcam.me.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272888-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[orcam.me.uk];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.269];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[macro@orcam.me.uk,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,angie.orcam.me.uk:mid]
X-Rspamd-Queue-Id: E2D1C351EDE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

 Inspired by a recent discussion[1] I have come up with this pair of 
small improvements to DMA error reporting with declance.  Please apply.

References:

[1] Sebastian Andrzej Siewior, "declance: Remove IRQF_ONESHOT",
    <https://lore.kernel.org/r/20260127135334.qUEaYP9G@linutronix.de/>

  Maciej

