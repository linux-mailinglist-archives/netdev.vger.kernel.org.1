Return-Path: <netdev+bounces-278197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKJKDYFY3WkFcQkAu9opvQ
	(envelope-from <netdev+bounces-278197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:56:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 805A53F3505
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 22:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E63530B7EFC
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 20:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4DA37E306;
	Mon, 13 Apr 2026 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESXWXt2D"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9213542E5
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 20:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776113420; cv=none; b=EdDC5Voo0/vs+X7aHCYSH04hEBqCRfJ7WaFZtzIIE+yS/zFdddIqkjKVRm69Q/bW5Wx+rR/45ltmOKzG4jYZQhn1ccVOMQ+vtF/swt2pC53YijNIrekwc/7e3ej80NhGvmI+I3MvU6LvSeQEfdxx5iogsgEQcSrQ5L8vaV6s+uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776113420; c=relaxed/simple;
	bh=z5ggFBTCYXZ4iQPoi4R7C2G+I1mDqrCkwTxUWC2hdKc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bCqHhVUp3b3c5lycozR1KMyxwvVvDf1cGmohnJZ5WuePALHBOkFCfg8ClvJgJnkQgdJumJepquiYOMoGK3tPgZ+1RAwDzYuCJ0F+QAZQf/OMCQBVEwjIGcHPdma+9dhUQFdirbZoVLC+W/+K7mUu613G3yi1r4s0pr84NQMUys0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESXWXt2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95926C2BCAF;
	Mon, 13 Apr 2026 20:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776113420;
	bh=z5ggFBTCYXZ4iQPoi4R7C2G+I1mDqrCkwTxUWC2hdKc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ESXWXt2DCvlxBlS7DZFuJv6w9UMrL4eE5LY548srRAAVL4+tOUroVEm7DEP0ExrgZ
	 acDFtv/Xo/9kU1VNXyqRF4YSya1rtvAnYin/psxase9mwTnDBn/GlmFhYlpRqOGtEr
	 +QLv+mUlypfngz6t+344btCEjXgGEV2JjqtVJyq5aOQaW2qxC3zU6dxcUxUX3Ouib0
	 rST9qZKgnReNi1aCQIUK2sLSj2i6je8te6XykaDgjpMnTWM0+zw/w9j5HOhjZiYa6y
	 dQS/AUAm2WL3Ab/jvMMXvzUPHJUTzVX5MQ2LmHMrc7QmsEuJsWFNCk8MX96Utz8ofa
	 EWSduCx8bT47A==
Date: Mon, 13 Apr 2026 13:50:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org, Paolo
 Abeni <pabeni@redhat.com>, Sam Edwards <cfsworks@gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: enable RPS and RBU interrupts
Message-ID: <20260413135018.59fbd3a1@kernel.org>
In-Reply-To: <ad06yiZZbLC9k3jY@shell.armlinux.org.uk>
References: <E1wBBaR-0000000GZHR-1dbM@rmk-PC.armlinux.org.uk>
	<20260413110222.49fc3759@kernel.org>
	<ad06yiZZbLC9k3jY@shell.armlinux.org.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,foss.st.com,davemloft.net,google.com,lists.infradead.org,st-md-mailman.stormreply.com,vger.kernel.org,redhat.com,gmail.com];
	TAGGED_FROM(0.00)[bounces-278197-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 805A53F3505
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 13 Apr 2026 19:49:46 +0100 Russell King (Oracle) wrote:
> > Firing interrupts when Rx fill ring runs dry (which IIUC this patches
> > dies?) is not a good idea.  
> 
> Well, I'm thinking that at least on some platforms, such as the Jetson
> Xavier NX, unless a different solution can be found, we need the RBU
> interrupt to fire off a reset of the stmmac IP when this happens to
> reduce the PAUSE frame flood on the network.
> 
> If we can't do that, then I think stmmac on these platforms needs to be
> marked with CONFIG_BROKEN because right now there doesn't seem to be any
> other viable solution.
> 
> My intention with this patch is merely to start collecting the already
> existing statistics so other users can start seeing whether they are
> hitting the same or similar problem. If we're not prepared to do that,
> then we should delete the useless statistics from ethtool -S, but I
> suspect they're now part of the UAPI, even though without this patch
> they will remain stedfastly stuck at zero.

Understood, thanks for the extra context. And the statistic we are
talking about is rx_buf_unav_irq ?

