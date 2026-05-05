Return-Path: <netdev+bounces-284368-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id h/amKF3k+Wn2EwMAu9opvQ
	(envelope-from <netdev+bounces-284368-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:36:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5954CDA12
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 14:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2ADC33038E96
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 12:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369C4439005;
	Tue,  5 May 2026 12:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="zmuuHOqJ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A23943636A;
	Tue,  5 May 2026 12:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777984501; cv=none; b=fM5saTV8e4H8RUoK2c029jDIgFEQiM/bgiDxwYYgpyHefP5Di0tLTiNKx+OCpBjLu3LTD0WYPnXJYuMWy/GX/R/e/fWlo9jNIXdA6Kc1sbER4OBVTyG55zaUnE4RPqccF/a4qnmAYjLx6wHItXhv829Vj6+iv2FwlDiafIbnp7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777984501; c=relaxed/simple;
	bh=FIqJnJljKqv+1MFUciTtJ9wgNosYo1QCRT4gzLGzl4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=axs5ykPocip7xjWa0AAe3IUm2o+PYp3wq2xOnYJGXuIzGr7AvfkJi+rZTkRWT94/qwCA83MYKlIX1TBkQcywZa/4i2AuiZbMXi2vVDsubR3471A70NgY4O4QYrnC3dg3Pv4qTYGD5Voj5B35kkOJrhDHCHdOjHYVGRmRNMKmJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=zmuuHOqJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JE+SnCpimdgqLDyrM2AHnSbEeW5OuRi+WBSVLEqMCH0=; b=zmuuHOqJBim3BqIGj1nFxIMW1j
	C2NKzyRicwAGZK/6il3VHMrOXIAwCMs/m4ghYPN4MeWBvEnK+O6khwleqLC4Wthf7ExJbFPv1taKG
	i97iD6X5lPVS9q2kZ/Qf66lQYaM7IYtwphQS6IywwqDwcSDcrUHfFLZHWStR7mBCB3Bk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wKEzA-001SPr-OF; Tue, 05 May 2026 14:34:48 +0200
Date: Tue, 5 May 2026 14:34:48 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Luca Ellero <l.ellero@asem.it>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: dp83867: add MDI-X management
Message-ID: <9414fa96-05e1-4d7e-adca-4ccf3b96853b@lunn.ch>
References: <20260505122751.233764-1-l.ellero@asem.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260505122751.233764-1-l.ellero@asem.it>
X-Rspamd-Queue-Id: 2B5954CDA12
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284368-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,lunn.ch:dkim,lunn.ch:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Tue, May 05, 2026 at 02:27:30PM +0200, Luca Ellero wrote:
> ethtool on this phy device always reports "MDI-X: Unknown" and doesn't
> support forcing it to on or off.
> This patch adds support for reading/forcing MDI-X mode from ethtool
> properly.

This looks good to me. Please take a read on

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

The Subject line should indicate the tree.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

