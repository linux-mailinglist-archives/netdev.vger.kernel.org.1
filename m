Return-Path: <netdev+bounces-288316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YLT8FkAhB2rnrgIAu9opvQ
	(envelope-from <netdev+bounces-288316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:36:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBBC550862
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:35:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95FAB300EF4C
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 13:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38ABE3955ED;
	Fri, 15 May 2026 13:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AkCu/XWH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1B83019A6;
	Fri, 15 May 2026 13:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778851767; cv=none; b=q+PyyXt7q9F0v7ueP2atx9Vw6SYj5q/f9Q+VIyZu8TaUsu1SE/5NrkntwMPj2TciXrzZbmP8j2zdiUagX4VY8ms//xSKGWtMhUH5SvQEWC2dn56O0NMY3xKt2lOCx77kTxTe+jNLOkO8DeLZv/9c2Wh9at/4Y+37hmnNTIooX+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778851767; c=relaxed/simple;
	bh=XIUgiWErOr8Vgk+y+Djnn3wMq7GgS7oG4jwouTtkGGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLG4Ntc37HRQzYAgIPzhmHQpglx9AV1z6PF05mP7sF94IisjNTyhUsqoZRPonqLvlfLtqKXoiWFc337X2ZKLvSzNlVXf0wNcKmkAnUnp5FUewe6jpsdV1hxqvwGJpLoLSrOZjgaP1zBwV022KEhxX3taCzFUPzgkVmzH8iqMLp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AkCu/XWH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aBYz4Ap8D7toDhBxqXBip9hFqvrUEc4VGJT4db9Mgss=; b=AkCu/XWHFHY0/dceDYHjBvEK03
	v1IfdSHaqZ2v4IDmQ6Bjjx4FWwcu/OuYcEOEe+PR3NxZFiT++a+tgxlnD4HF6DD42ahMul+j1FXBt
	KubdNa+6mFkwknEpFRxkkRFNudoRnyUgKek27twxon793VD+/SEEuFYAs4QR2bIb+mTI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wNsbN-0034HQ-5p; Fri, 15 May 2026 15:29:17 +0200
Date: Fri, 15 May 2026 15:29:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Robert Marko <robert.marko@sartura.hr>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	luka.perkov@sartura.hr
Subject: Re: [PATCH net-next] net: phy: micrel: use dev_err_probe()
Message-ID: <710a3749-ff96-4378-b026-abaa5b4af817@lunn.ch>
References: <20260515120608.706361-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260515120608.706361-1-robert.marko@sartura.hr>
X-Rspamd-Queue-Id: 9FBBC550862
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,sartura.hr];
	TAGGED_FROM(0.00)[bounces-288316-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sartura.hr:email]
X-Rspamd-Action: no action

On Fri, May 15, 2026 at 02:05:40PM +0200, Robert Marko wrote:
> Currently, during probe defferal the driver will print multiple times:
> mscc-miim e20101a8.mdio: Cannot register MDIO bus (-517)
> 
> So, lets silence that by using the dev_err_probe() for printing the probe
> error as it handles probe defferal.
> 
> Signed-off-by: Robert Marko <robert.marko@sartura.hr>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

