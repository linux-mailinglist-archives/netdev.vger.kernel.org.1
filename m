Return-Path: <netdev+bounces-291909-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QLRaGjz0FWpCgAcAu9opvQ
	(envelope-from <netdev+bounces-291909-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:27:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09EF65DBFAB
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 21:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 44CE7301424B
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F295E372EF1;
	Tue, 26 May 2026 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hW2lLrdU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B32C13D503
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 19:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779823672; cv=none; b=FbCa58J61fB5klHFy37Mih5jjb9119O6nZzsAmGjzrCpqBZBQCkqtnUoEgzy64beIube8kNgGf9YHxWNdoVv/STMoI+qAHVrlWUrxOyEkHZ7ulvxcjPhdqr19fOzVGctBaZUKzXGztyqWrdnS6EJYRMtrFSegskpDv3vJXSG1DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779823672; c=relaxed/simple;
	bh=o8ORo6sJ1fPhEVSNyUrL0oxCdecfR5IDBsK5tzfyPhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgKkTdwlGxXpy2HPr0r0ZnRulS6lTO6cCKqpHr4fjDVJKwY14SzwgumovCWSrtXdcZa8L1rJqpTMmAR+xNCD0ZhZOeIoGZ/DVl+gNZFlT1lCWHTHyDngh/8dZzHdy5brtzNXTKR3QvWL9B1+12ouJOk+HG2V5BhvERdtfw2ZtVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hW2lLrdU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jZkUpXo9DyNeZR9ojfq2twwAnnPFbl2L59aGFu5SGQE=; b=hW2lLrdUsFdC0hWzClA447JKMx
	UZJHfLb5wGSx53mPmqnzm4+g4zs5y0RqOPs68dpww5BqxUzCbV5Bj24iwZiImaLo3enX4LQ8VUJ7D
	KEKKdBsLD5Rr076NFVb3C+y0Mrph3kSW7cUN1E4YDeHgRafSADdbgK87K7+BnYxvfaY4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wRxR7-004dbS-1W; Tue, 26 May 2026 21:27:33 +0200
Date: Tue, 26 May 2026 21:27:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, chris.packham@alliedtelesis.co.nz,
	daniel@makrotopia.org
Subject: Re: [PATCH net-next 1/5] net: mdio: realtek-rtl9300: provide generic
 command runner
Message-ID: <4c270a3b-c12a-4f3a-82ae-1c6a35a89aeb@lunn.ch>
References: <20260526174344.1186832-1-markus.stockhausen@gmx.de>
 <20260526174344.1186832-2-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526174344.1186832-2-markus.stockhausen@gmx.de>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291909-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,alliedtelesis.co.nz,makrotopia.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 09EF65DBFAB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +static struct otto_emdio_priv *otto_emdio_bus_to_priv(struct mii_bus *bus)
> +{
> +	return ((struct otto_emdio_chan *)bus->priv)->priv;

Assuming priv is a void *, you should not need the cast.  You might
however need an intermediary variable.

> +	scoped_guard(mutex, &priv->lock)
> +		ret = (*priv->info->write_c45)(bus, port, dev_addr, regnum, value);

The (* ) should not be needed.

	Andrew

