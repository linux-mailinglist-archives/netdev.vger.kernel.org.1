Return-Path: <netdev+bounces-289996-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2HR7CrfdDWqC4QUAu9opvQ
	(envelope-from <netdev+bounces-289996-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:13:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A10591A22
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 18:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7B2C830E0159
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 15:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFA4A3F5BC0;
	Wed, 20 May 2026 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Zy4qsVk2"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500583F54C7;
	Wed, 20 May 2026 15:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779290653; cv=none; b=adiHTF5qN6w6OI2ARwpQnIP95ewKhcpmQarGplxPyT3F0/VH6r8Zltnm4dgSHH0+22uD6s44HNbaVEbbufn7poMSOeAyqIaZ0v8lLnSq6hJKSVWOplodYpain8GJAT8pErBdBSBEm//ZUEPX4qUUwUEuoelHAKqHIpDQ8etISWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779290653; c=relaxed/simple;
	bh=+4TUUHSVoLge4jScH/ArRe91PO3BRFBmxSGsw7iHkyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i5ibn5rooyhG+c+el74Xq50qvZfm34yPiMMIkvpqW7hfjoWuH4jRI377UAHVslinhQKQci2deeJhScxlThvR8PazW0J2FSupvHWc8kYLFkE1a6RrOG3vvL5Gsqw+aFXOO+WXhuC//TUkTTZVbRRTY9pE3pIFOwOmKkZRmuPw8SQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Zy4qsVk2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kNMIfVK1t4JwfaOevWXD8LztlJ1NDF/MO/IaQ8lcPZc=; b=Zy4qsVk2VIEMXyiH3/0AgPbuHI
	imrSS+xEi3g3I8muamtJQPNS4ZyzploNR06neqgcgrMmWdqIYg2XD3fTQzJVwxjjqkH9WpftUKUBf
	7nIsN1zJrRIkh0soZxllX1rlIq1bwo8hbvr1LEeswq5t6/p93YFrEKT6IW0naIzUkRGg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPim7-003r0s-Jl; Wed, 20 May 2026 17:23:59 +0200
Date: Wed, 20 May 2026 17:23:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: dev.taqnialabs@gmail.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: mmc: Remove duplicate mmc_rx crc
Message-ID: <bd8efd40-e203-4cdc-af25-12b1e2727922@lunn.ch>
References: <20260520-xgmac-mmc_rx_crc-cleanup-v1-1-7133f529859f@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260520-xgmac-mmc_rx_crc-cleanup-v1-1-7133f529859f@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289996-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,foss.st.com,vger.kernel.org,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 44A10591A22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 02:25:12PM +0000, Abid Ali via B4 Relay wrote:
> From: Abid Ali <dev.taqnialabs@gmail.com>
> 
> Double read of mmc_rx_crc_error in XGMAC is removed.

The commit message should explain "Why?". I can read the code add see
what the patch does.

Why remove the double read? Why is this safe to do? This is hardware,
maybe it has latches values? Or clear on read? Maybe two reads are
required? So the Why? Is very important, more important than the code
change itself.

    Andrew

---
pw-bot: cr

