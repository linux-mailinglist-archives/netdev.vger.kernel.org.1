Return-Path: <netdev+bounces-270698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qJmoGm+UwWnuTwQAu9opvQ
	(envelope-from <netdev+bounces-270698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:28:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 05F682FC432
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 20:28:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 79560302051F
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 19:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBEEA3B38A6;
	Mon, 23 Mar 2026 19:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="6cI4xuOI"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A6D435AC05;
	Mon, 23 Mar 2026 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774294117; cv=none; b=hHqst1eKF7ZM5p+iHW+QD9DfgF7/UCZWzuYpeC/4LQWLIrWR+1m9lf2cO1X5tlafGKLykevNCLAA491i84cXpRI53xRXhr9qOf2t9dsFDFAT0HbIJqD8jJau8xFWBp9uIF5FQ+bGnCYh0r2MtT8NhSQIO4e8hQaUbTHSfWMNiwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774294117; c=relaxed/simple;
	bh=Ci0lpEAXhQrjT+SJOFGP4O6K+VhnHeLPcwu1jg/Q34s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j0GcHAV8L2TfEJn2U1NLUXAUNOe3BMVn8HHtx0JAtI0J4LjEpLfksKXl2wFAjexUNWtuEwS5ZzAoNIHZ8hXy3O51RleMUb1QHQx6y6GzN8na/511KRPEVYBtztElp9wYLD8FWIx0+GdnVmGT1X1uixmeUEeyMRHYOZ4sfNAXyiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=6cI4xuOI; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NxDIkUSIumVldn+n7EQNKIUzQfsPZ57UHSTxR5zwLJg=; b=6cI4xuOIkwuEQcqdrL3EASHvdM
	tEjyNbkWN3rDh332dAvFoLpUB+7Ikl/hG5uFzo9bnElD2wbEft2gG0fjzVjGp5VGCs+/boC+QZq+6
	N4mN1VKdQFHJQJJkiHDEjtaIxYxt73XYOwX/H0K8p+KuPVxJvwn4Vs05aCKx/KAcw5u8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w4kwq-00Cz8M-3g; Mon, 23 Mar 2026 20:28:24 +0100
Date: Mon, 23 Mar 2026 20:28:24 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Joris Vaisvila <joey@tinyisr.com>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
	horms@kernel.org, pabeni@redhat.com, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, olteanv@gmail.com,
	devicetree@vger.kernel.org, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Subject: Re: [RFC v3 4/4] net: dsa: initial support for MT7628 embedded switch
Message-ID: <d28b29bf-47bc-4bc7-8f1d-4e26c9e6843c@lunn.ch>
References: <20260321194340.2140783-1-joey@tinyisr.com>
 <20260321194340.2140783-5-joey@tinyisr.com>
 <ab8IHwC4RfHG5wvv@makrotopia.org>
 <acFwjuPFiO0QFoJ-@archlinux>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acFwjuPFiO0QFoJ-@archlinux>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270698-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[makrotopia.org,vger.kernel.org,kernel.org,redhat.com,google.com,davemloft.net,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 05F682FC432
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> > @DSA maintainers: correct me if I'm wrong and, for which ever reason,
> > using the .phy_read/.phy_write ops is discouraged in new drivers, even
> > for dead-simple hardware like that one.
> 
> Regarding .phy_read/.phy_write, I was advised against using them in new
> drivers in v1 of this RFC. I'm happy to rework this, but would
> appreciate clarification from the DSA maintainers on the preferred
> direction for hardware like this.

Yes, it is better to call of_mdiobus_register() in the DSA driver.
.phy_read/.phy_write are historic.

     Andrew

