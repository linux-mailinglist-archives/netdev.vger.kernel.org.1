Return-Path: <netdev+bounces-258824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Rs2JNSZ9kmlXuQEAu9opvQ
	(envelope-from <netdev+bounces-258824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 03:12:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CE11409C0
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 03:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 875AA300C033
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 02:12:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAEFD20C00C;
	Mon, 16 Feb 2026 02:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SCjpYqaJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446E4E571;
	Mon, 16 Feb 2026 02:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771207971; cv=none; b=SQjNQkuRJ+jztxdizaFkaweWXdSAjf8zskh5HNCciOMCbvH2mwncXF/gxWLw3hwsEKvf3djKyOMFonqwHVWyEA076hkHtGUNEw5zauBjMtDirPYuVwrbZyax4oCb58Dm2X9zBvTFX4xA5trG8qUDNFRBeAwDGoGRTtcE4MwHllk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771207971; c=relaxed/simple;
	bh=JVyOjiKDxj4AxvfQtjM6xwEl1PHNHhheyDMP5EbFgvY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SxyZwy5LJeU6ey1xRCf9/mf56l4I90N4ZGs5wYeyHmi8ivB5i2v2fj/eOBoaHjoXr+4S1vQDNOoSip9htRccvSa5Dxo9EYGhaksYuu2KovdEbayjcKfvPvqeZFxug7N7ULSyf/HJHovAGwFbNUqe/EJc4Xzfax9hfXJmUz0Dnsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SCjpYqaJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Ukro7hJtOfv1NqHJaq4r1jaAFzhTSGSseOjznHRYQxk=; b=SCjpYqaJggapgp5bsoSLkXWQiC
	qJjxK0s2DDMwda0jKvOZDq3JtWnQr8WoaAmjNjyTZjbADPVZ7ENchrmnfpoGAT9nlCD0eWn3jq607
	f+ddiJhLe6cNwDq9zCsFpMgvS8N+8/WgRWVkN9ZYi2zYVOwRplKT9z1ddA8hNNsRVv2A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vro6F-007Rda-AM; Mon, 16 Feb 2026 03:12:35 +0100
Date: Mon, 16 Feb 2026 03:12:35 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Tiernan Hubble <thubble@thubble.ca>
Cc: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Lorenz Brun <lorenz@brun.one>, Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: atlantic: fix reading SFP module info on some
 AQC100 cards
Message-ID: <40885b5e-5cd2-4243-be0a-9dc8d9e7b781@lunn.ch>
References: <20260215212609.193815-1-thubble@thubble.ca>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260215212609.193815-1-thubble@thubble.ca>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258824-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 28CE11409C0
X-Rspamd-Action: no action

> +	/* Wait FW to report back */
> +	err = readx_poll_timeout_atomic(aq_fw2x_state_get, self, low_status,
> +					orig_low_status != (low_status &
> +					BIT(CAPS_LO_SMBUS_READ)),
> +					10U, 100000U);
> +	if (err)
> +		return -EIO;

Please don't replace the error code readx_poll_timeout_atomic()
returns with something else.

	Andrew

