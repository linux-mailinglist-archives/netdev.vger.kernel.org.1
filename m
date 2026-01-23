Return-Path: <netdev+bounces-252876-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPkiAN6dc2lgxgAAu9opvQ
	(envelope-from <netdev+bounces-252876-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:12:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 758D1782EE
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 17:12:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8618030166CE
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 16:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377252D7D59;
	Fri, 23 Jan 2026 16:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PE+fRvek"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 749AA28B7DA;
	Fri, 23 Jan 2026 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769184709; cv=none; b=SQlK6zzC4n7pNy0qqUxynBEpnz5jLbFBW8GeS+3gZwqoRfwpwED4oNOa1BYLWb38RO7zbgXvJqMA374sHyp1f8ttVSEZUsm9aysoErb5kLrq0leKHJ87229oxV5243TA+fr5aCAiTk0FJ4+0IjMwiQ3zzsWbjKNapoarE/SRu4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769184709; c=relaxed/simple;
	bh=0z4+lbLVtB1Bl8VmUsNrMXf6ssJU5lPW4tWzM/A9ROw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J2XkVBnw8MBV3MWTw0QMJx0YnPhAQ8/qHci04F+EBmKO+YOgyeG5Ss9f7eaHw9KVLNz49Mg+sTUy6u0Yar8uaR+gjTTbKk3Vufu8eFO+AvI3SXkcSoix6bokJKSjUjCYq7dDungwHdADH4m2BXeVt3dOcI62kLcF8D5D5xXXy0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PE+fRvek; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=4pd/6d9fQ4GtIOJwLKKuGDzNxeSuaDvXw0J0JlQNkO8=; b=PE+fRvekgjI0orvie0jo/6gKZN
	my/EMe3HNwU4fPZZ83wUkD0E92hgseNYwffwoNoYr6/S+GfNd/xEheHJ/WUXpzYgYaujA3ESKwA/U
	LI59JF1qQEe4RAtF5qylFTlzk9tYy+djO9bg5DrU1zTe9b/PjPaD3WcE2DdvFUsIN7mI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vjJl0-004BmD-FD; Fri, 23 Jan 2026 17:11:34 +0100
Date: Fri, 23 Jan 2026 17:11:34 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	o.rempel@pengutronix.de,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: micrel: Add support for lan9645x
 internal phy
Message-ID: <6f80050b-558c-4be3-89a0-a242ee528ea9@lunn.ch>
References: <20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260123-phy_micrel_add_support_for_lan9645x_internal_phy-v1-1-8484b1a5a7fd@microchip.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252876-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,microchip.com,pengutronix.de,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.964];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 758D1782EE
X-Rspamd-Action: no action

> +static int lan9645x_config_intr(struct phy_device *phydev)
> +{
> +	int err;
> +
> +	/* enable / disable interrupts */
> +	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
> +		/* This is an internal PHY of lan9645x and is not possible to
> +		 * change the polarity of irq sources in the OIC (CPU_INTR)
> +		 * found in lan9645x. Therefore change the polarity of the
> +		 * interrupt in the PHY from being active low instead of active
> +		 * high.
> +		 */
> +		phy_write(phydev, LAN8804_CONTROL,
> +			  LAN8804_CONTROL_INTR_POLARITY);
> +
> +		/* By default interrupt buffer is open-drain in which case the
> +		 * interrupt can be active only low. Therefore change the
> +		 * interrupt buffer to be push-pull to be able to change
> +		 * interrupt polarity.
> +		 */

It is not stated here, but i assume that there are multiple of these
PHYs in the switch, and each PHY has its own independent connection to
the parent interrupt controller? There is no interrupt sharing going
on, which is common with discreet PHYs.

	Andrew

