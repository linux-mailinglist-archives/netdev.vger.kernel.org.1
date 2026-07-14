Return-Path: <netdev+bounces-307613-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ByjfDj2/VmofAwEAu9opvQ
	(envelope-from <netdev+bounces-307613-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:59:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 786537594E5
	for <lists+netdev@lfdr.de>; Wed, 15 Jul 2026 00:59:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=lunn.ch header.s=20171124 header.b=DDDXwBD0;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307613-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307613-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=lunn.ch;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4992B3019828
	for <lists+netdev@lfdr.de>; Tue, 14 Jul 2026 22:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CCF423EAE;
	Tue, 14 Jul 2026 22:59:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784603F4845;
	Tue, 14 Jul 2026 22:59:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784069946; cv=none; b=G2dYkjqz0KyowDqxFCHoUngGNjDRVqO0GypFLzd4G/CnOyPmG8hS4yKQ3haWIYMR8czweyL4IcQlTr11z9cwxSB+HRL9kHPrKUts3Id4dRrEmzi33kG8peJ6SAsfEnHaeBRwC9TewlIh2Oqfr70aBzunGc64fTQnhH5281wXbNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784069946; c=relaxed/simple;
	bh=ObZoVd2SwZYresup1lwKlWSID/z/WIjFQF4i38oTNeU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KC7sGg3cG14JzE8QQ4f3i+70xVDf5sTxoO94ihRdQxa8GIJBROA6TlMSyFxUguRYZfNdGgOiy94h0QSvOiQNarXz01BTY25hXfkTNBya1EP2l2q4gCi8Q7Hi2VFX4ye3k7GNBhE2AS1KGofuyDJT1nMB6iVIJ4FZrvdFzO0GTlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=DDDXwBD0; arc=none smtp.client-ip=156.67.10.101
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dDha+UlnDaRCdEuunWk1hNBn1iZPMTj7RkzDoOo3PI4=; b=DDDXwBD0J557i+mXqxjGNHaUyF
	JUJH14Jlh1CtG8a46tTlslzRJvkiW1kDORhTz7gekeT9ItYNGUhFLZup/uCEKmYRi6V04LkU2cxzb
	c2es6Tkycr5GEuOlrt/W2uTk2QwaIvlI0fWRf+GcW4OZHvC47q+QaLMT//rXR2OD3MUQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wjm5S-00CGQz-SU; Wed, 15 Jul 2026 00:58:50 +0200
Date: Wed, 15 Jul 2026 00:58:50 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 02/12] ax88179_178a: Add HW support for
 AX179A-based chips
Message-ID: <1f858852-8e8e-4cff-bbdc-eb6751f44ca5@lunn.ch>
References: <20260708-ax88179a-v2-0-0800fedb2e16@birger-koblitz.de>
 <20260708-ax88179a-v2-2-0800fedb2e16@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708-ax88179a-v2-2-0800fedb2e16@birger-koblitz.de>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307613-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mail@birger-koblitz.de,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lunn.ch:from_mime,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 786537594E5

> +	/* Initialize MII structure */
> +	dev->mii.dev = dev->net;
> +	dev->mii.mdio_read = ax88179_mdio_read;
> +	dev->mii.mdio_write = ax88179_mdio_write;
> +	dev->mii.phy_id_mask = 0xff;
> +	dev->mii.reg_num_mask = 0xff;
> +	dev->mii.phy_id = 0x03;
> +	if (!ax179_data->is_ax88772d)
> +		dev->mii.supports_gmii = 1;

O.K, so you are keeping going.

I still think mii has to die, and you need to swap to phylink.

It is a bit ugly, but there is a way around the PHYs having a totally
different API, despite the same ID register values.

Some generation of Marvel Ethernet switches set the OUI part of the
PHY ID register, but left the product part as 0. They even documented
this was intentional. We worked around it by trapping reads to
registers 2 and 3, and filling in the missing information, using an ID
from the marvel range which was not in use. We could then make the
Marvell PHY driver do the right thing.

You can do the same here. Intercept the reads to registers 2 and 3,
and return a different ID. You can then extend the PHY driver.

    Andrew

