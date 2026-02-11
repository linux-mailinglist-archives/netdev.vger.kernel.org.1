Return-Path: <netdev+bounces-258293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 7ZqCNU2OjGlQrAAAu9opvQ
	(envelope-from <netdev+bounces-258293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 15:12:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 299DD125178
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 15:12:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8157E3012EB6
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 14:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DFB29E0E6;
	Wed, 11 Feb 2026 14:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="U1AdP3Ur"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8C2126C03;
	Wed, 11 Feb 2026 14:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770819145; cv=none; b=Upv78FS0zwfBeEa28LxonOgqnY4NJ6XywKfRRqh7Cic0rSQc63jnZ7ottBojDVra1tpCyj5M856j36/jTQHVCSBY3elbq6KJG7qjxk06fkqSzXjMvGtaQzsnlMig30JoQwy4CWxji/x2qJWdo/eaUlqRfnKQ7HdNOKe392iPGCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770819145; c=relaxed/simple;
	bh=ezqhSbXsxkapCn+1ACZBHkr27iYrEy2u9EZUwTDFmVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UDId/ZZ0Mrm+gg/VrRwRBvWwSLzA2oOSJQqivFcpvuShz3DaKLK69Ecj32/KsZfqqpis/wk2kjSUySwWXOrddhj2VBoF388aKc7TDrlGTEu1QDGw8XMlzs3tRG4OGT9/2COimS3lQPL+XjLo2JWRUMesa6R4sjFIjUaFleI47GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=U1AdP3Ur; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=uADoTJuRubYSDrIcN4J3LNammK/ucVUqRmyhE30HwG8=; b=U1AdP3Ur9E1b/1kN1K7ni8FWRu
	V7hFrsZbiqc+jboEouqnzxGLaylnXBRcjOwFPGsL70X752XTxEGhbIivEHJYAmtyiTO07eHPqVYIY
	qQdnWMcEg3IRBtWEveRL6uzAZQI06KcE8mhRbnE1wlLTKP9JmN1+L/jXaQ6zdZ7EZbMA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vqAwz-007002-JT; Wed, 11 Feb 2026 15:12:17 +0100
Date: Wed, 11 Feb 2026 15:12:17 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Meghana Malladi <m-malladi@ti.com>
Cc: pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, linux@armlinux.org.uk, hkallweit1@gmail.com,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Roger Quadros <rogerq@kernel.org>, danishanwar@ti.com
Subject: Re: [PATCH net] net: phy: dp83869: Set auto mdix bit for forced
 100Base-Tx mode
Message-ID: <0a9d0ec8-09c4-4029-8449-8c8f08c6dca0@lunn.ch>
References: <20260211131033.2525617-1-m-malladi@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260211131033.2525617-1-m-malladi@ti.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258293-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,kernel.org,google.com,davemloft.net,armlinux.org.uk,gmail.com,vger.kernel.org,ti.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:mid,lunn.ch:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 299DD125178
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 06:40:32PM +0530, Meghana Malladi wrote:
> When using DP83869 in force 100Base-Tx mode, the PHY is required
> to have robust Auto-MDIX feature enabled from register 1Eh.
> Refer to 7.4.1.2 100BASE-TX section in the TRM [1] for more details.

What are the results of not enabling this? How would somebody know
they need this patch?

Is this a bug fix? Should this be back ported to stable?

> +static void dp83869_link_change_notify(struct phy_device *phydev)
> +{
> +	int cfg4;
> +
> +	/* When using DP83869 in force 100Base-Tx mode, the PHY is required
> +	 * to have robust Auto-MDIX feature enabled
> +	 */
> +	if (phydev->autoneg == AUTONEG_DISABLE &&
> +	    phydev->speed == SPEED_100 &&
> +	    phydev->duplex == DUPLEX_FULL) {

So forced 100Mbs half duplex does not require robust robust Auto-MDIX?

What about when you change the configuration out of forced 100 Full?
Shouldn't the configuration be returned to how the user wants
auto-MDIX configured? Should you disable robust Auto-MDIX so that
"unreliable Auto-MDIX" is used?

	    Andrew


