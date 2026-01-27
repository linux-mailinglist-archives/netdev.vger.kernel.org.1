Return-Path: <netdev+bounces-253896-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MAMGCLEeGnqtAEAu9opvQ
	(envelope-from <netdev+bounces-253896-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:56:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 02F4195376
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 14:56:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D8DA308F04E
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 13:50:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382C03491D5;
	Tue, 27 Jan 2026 13:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="d6spFCuW"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53142C0F75;
	Tue, 27 Jan 2026 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769521827; cv=none; b=ekpqZJQNOe2izBvaOjZ3dJtxqDEsjE007gESouPGKRQ3gm01jfmMr9w7EH6xRPEm+1bHnzO7XJYLYH7Jrs1+04e9q4RngzATugUL37aggxW0fvc11ns2gV7RWwfcNGqiPFBVn2Pcx1xLIOJ1XE1sXG/wqIwWUeJ2SCLUb7i7hNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769521827; c=relaxed/simple;
	bh=QRatMhJnRNyEA67EhLdS0NL/K+LI/ja+JygeQrfuyYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eGcQXgZQSeDBjqNJgibj9DHvkmTMgGtxLwaKflMUHkckbYib7UnSEXG9ngjf+LD7PllA6N5oa6oW5ezWadFyMVvEFonHi6FP+wkXvpoJccksoiG3attOmgmnT25J8hq+Z+o95Frp2xIJR6PNwFeg3zrA604C5jVznv4KVxp3/bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=d6spFCuW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=VxcWSdk87k0N5BVm27/BnYw/EywV/d+fGz43a/TzZdA=; b=d6spFCuWzBDRXW+2fq/oOurQMl
	pP1ygt+7RZVtd23KlozpXjgAWtUWj7WOX2poASVQ0CQTzcFwNldE4kCx8ZbNFgx+SercHK7Nug+LI
	3LpXk0pREYmoW2dBSFK5qrXPHa4juE87O6QjeYD5iB66ach8887KYgV7pWyd6l+dD8tM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vkjSQ-004xa8-Lt; Tue, 27 Jan 2026 14:50:14 +0100
Date: Tue, 27 Jan 2026 14:50:14 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Frank Wunderlich <frankwu@gmx.de>, Chad Monroe <chad@monroe.io>,
	Cezary Wilmanski <cezary.wilmanski@adtran.com>,
	Avinash Jayaraman <ajayaraman@maxlinear.com>,
	Bing tao Xu <bxu@maxlinear.com>, Liang Xu <lxu@maxlinear.com>,
	Juraj Povazanec <jpovazanec@maxlinear.com>,
	"Fanni (Fang-Yi) Chan" <fchan@maxlinear.com>,
	"Benny (Ying-Tsan) Weng" <yweng@maxlinear.com>,
	"Livia M. Rosu" <lrosu@maxlinear.com>,
	John Crispin <john@phrozen.org>
Subject: Re: [PATCH net-next v8 4/4] net: dsa: add basic initial driver for
 MxL862xx switches
Message-ID: <5e7c2f9c-bf49-4564-91b3-a639ef1c97d8@lunn.ch>
References: <cover.1769053079.git.daniel@makrotopia.org>
 <18c6a24eef8617abb5073569fee162f1aa1c06ea.1769053079.git.daniel@makrotopia.org>
 <c2e191c4-dec4-4e42-b108-353778d9bd18@redhat.com>
 <aXinOE7KIFIm5dUK@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXinOE7KIFIm5dUK@makrotopia.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253896-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,gmail.com,davemloft.net,google.com,kernel.org,armlinux.org.uk,vger.kernel.org,gmx.de,monroe.io,adtran.com,maxlinear.com,phrozen.org];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 02F4195376
X-Rspamd-Action: no action

> > > +	/* handle errors returned by the firmware as -EIO
> > > +	 * The firmware is based on Zephyr OS and uses the errors as
> > > +	 * defined in errno.h of Zephyr OS. See
> > > +	 * https://github.com/zephyrproject-rtos/zephyr/blob/v3.7.0/lib/libc/minimal/include/errno.h
> > > +	 */
> > > +	if ((s16)ret < 0) {
> > 
> > The cast is likely not needed above? if `ret` values < S16_MIN are
> > possible this will return such values to the caller without the IO err
> > printk.
> 
> Right, it should rather be
> 
> if (ret > S16_MAX && ret <= U16_MAX)
> 
> to really only catch the range of numbers which are negative 16-bit
> signed values represented as positive 32-bit signed values.
> 
> mxl862xx_reg_read() primarily returns a signed 32-bit integer, as it is
> basically just a wrapper around __mdiodev_c45_read(). Negative values of
> that 32-bit integer mean that the MDIO Clause-45 read has somehow
> failed, ie. it's the error the MDIO bus .read_c45() operation has
> returned.
> 
> In case __mdiodev_c45_read() succeeds it returns the 16-bit value of the
> register read. In this case, those 16-bit should be interpreted as a
> 16-bit signed integer here. A negative value denotes an error returned
> from the firmware running on the switch (see comment above the code).

Rather than these casts, maybe add a helper which takes the unsigned
u16 from the register and returns a signed Zepher error code?

int mxl862xx_to_zephyr_errno(u16 reg)

Just having a name like this makes it clearer what is going on.

     Andrew

