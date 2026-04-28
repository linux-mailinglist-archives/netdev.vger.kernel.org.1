Return-Path: <netdev+bounces-281888-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CKeTNQ7A8GkTYQEAu9opvQ
	(envelope-from <netdev+bounces-281888-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:11:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 330264869E0
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FC6C320F5C1
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 13:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4673D429823;
	Tue, 28 Apr 2026 13:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ARlIW5Uv"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB721217F27;
	Tue, 28 Apr 2026 13:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777383544; cv=none; b=kf1uXA4qHgAozAO6aCLVN3V08Z+6vupqLN718rl1xtLvAE6Okhcx2l05cauXrkpPxjssQ0Nvm9l/1XkMCLq5Vv0FcVh4jJ0veSGsyMpQaDXBgio6GoGCX/Lc+MLwx/TxvUOX2y1V8hGUrL6qMgRINJu7mr+kdMSIgC8svfD4NHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777383544; c=relaxed/simple;
	bh=rFPwSZS20EM5Gtg9/0HCSNe43DDm4D5C4hyaYLyb9aE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AgnmFqEnMLikbBhqKwXkVzZEBsQbhhrnVd58fVY4DanXN/Gv69nAC7HpoRX5uCALoIlfJwHsJW9KFWaQFGg7q+K5reH5wRMqTzeSRcTZGOiaWlasFqc3QTVG2g0cF4p++OHFRygv2OfyCCkc0WNAOoGdMHPxz2igextxXRWe03g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ARlIW5Uv; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=PmJVtR5X4I8K/CxBoVDUflVQyelM2k7k4fazHOZAGKg=; b=ARlIW5Uvi/GVduQbItZQGvbgxT
	Pkod3sORgzLrSeGrKwhCA8jSk5TfiZGTRYnbGMbMP/7CzubcRifFve3Gnbgi2Y+YOaD0y38JFrrjS
	UIXN6dgWfPReyLDevG1K5hGFFjb/ubYUUKpNDNX6f+sE8EPcX1wX8ccYxFezXjiWqmNE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHieJ-000LE6-Sn; Tue, 28 Apr 2026 15:38:51 +0200
Date: Tue, 28 Apr 2026 15:38:51 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Camelia Groza <camelia.groza@nxp.com>, thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: aquantia: use ADVERTISE_XNP for
 extended next page advertising
Message-ID: <ef5bf3ad-f71d-4590-a512-33d0eba31061@lunn.ch>
References: <20260428125827.238469-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428125827.238469-1-maxime.chevallier@bootlin.com>
X-Rspamd-Queue-Id: 330264869E0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281888-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,google.com,redhat.com,armlinux.org.uk,gmail.com,nxp.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email,lunn.ch:email,lunn.ch:dkim,lunn.ch:mid]

On Tue, Apr 28, 2026 at 02:58:27PM +0200, Maxime Chevallier wrote:
> When configuring the link parameters in forced mode for the AQR-105, the
> Extended Next Page bit gets advertised for Multi-Gigabit modes.
> 
> This is done through bit 12 of MDIO_AN_ADVERTISE in MDIO_MMD_AN. This
> contains a copy of the MII_ADVERTISE, for which 802.3 defines bit 12 as
> the Extended Next Page advertising. This bit used to be marked as
> reserved, but a proper define for it was added in :
> 
> commit e7a62edd34b1 ("net: phy: qcom: at803x: Use the correct bit to disable extended next page")
> 
> Let's use it instead of the ADVERTISE_RESV definition, making the code
> more self-documenting.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

