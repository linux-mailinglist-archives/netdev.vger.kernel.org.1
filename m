Return-Path: <netdev+bounces-258718-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wUSyLOinkGkncAEAu9opvQ
	(envelope-from <netdev+bounces-258718-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 17:50:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A58E13C87B
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 17:50:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 82C29301DBB0
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 16:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6761627FD45;
	Sat, 14 Feb 2026 16:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="iR84meSN"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA5926E6F8;
	Sat, 14 Feb 2026 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771087844; cv=none; b=JV4yVQvYHDK7jyt4Ga2ZPK1anG0LyYVNMzxjzCdZBdxnh2fNgNZuTimc5u2e2CKm6cvYC9z1AT7blE49CP37MdP4oo1FGj3prKAnC+wCN80cN6CqCNngW4j1de/k/U5aC4K1nG2H+4MRh7S4EDx5Nhr51qqLyo6t2c+8TH5cyAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771087844; c=relaxed/simple;
	bh=15VTPZlha75z0tYBYJ9alPlMAZL8JeNK4TyWnrGRytw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=trh/OdFF44TErB5g82PYpJFuBdNTPtv7mhCYwGR61lnxYxskRrZzKVfoADC5PilLaN6SpJDd1y78t26VlmNR301sROrUxdfUYq6axs/gpkMWT5lqcSkD82pWTF+ci2kZlA2CcRl+XhZP6SUmih503Knk3/cHkmm22vj9PTo9Qqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=iR84meSN; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AdQmimkreI2fOku3XSzkbPRZvQQzrArN0v3aCPxtx3k=; b=iR84meSNht+TkYCVlwqmXETciF
	ZFMuyeIByHHqtkmTgQuXDIUDCfabwRldeeDIlos1o0bFb5xHQKkGSsP78FyFrq9KogtXUqg5oqcz3
	iO/aEaz3AANPgMBy90jxVWed+POpL2XrDJqNWTQI16fK32M5plQ2c5Mtcuzpg8c9m4cg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vrIqV-007KBa-3v; Sat, 14 Feb 2026 17:50:15 +0100
Date: Sat, 14 Feb 2026 17:50:15 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Yao Zi <me@ziyao.cc>, Heiko Stuebner <heiko@sntech.de>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: Re: Problematic understanding of phy-mode in Rockchip DWMAC driver
Message-ID: <f1e047e1-3f1c-4562-ab43-af2fe358fe04@lunn.ch>
References: <aY9s5PXP4zZ7R6fa@pie>
 <aY9xsslT56D9LGLe@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aY9xsslT56D9LGLe@shell.armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258718-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[ziyao.cc,sntech.de,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,lists.infradead.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:mid,lunn.ch:dkim]
X-Rspamd-Queue-Id: 3A58E13C87B
X-Rspamd-Action: no action

On Fri, Feb 13, 2026 at 06:47:14PM +0000, Russell King (Oracle) wrote:
> On Fri, Feb 13, 2026 at 06:26:44PM +0000, Yao Zi wrote:
> > Hi folks,
> > 
> > I was looking through the RGMII delay setup logic found in
> > rk_gmac_powerup() of dwmac-rk.c, and found its behavior is strange,
> 
> dwmac-rk is very broken and is unfixable thanks to Rockchip not
> understanding the RGMII interface modes used by the kernel.
> 
> It is what it is, we can't change it without causing regressions.
> Please do not try to fix it.

Rockchip have recently started adding support for a new version, and
appear to of listened to what we have been saying. So it could be the
next generation of chips get this correct.

Aspeed are in a similar position, and might also get their next
generation correct.

But as Russell pointed out, we have to be very careful with any
potential changes to this code. Despite it being wrong, boards
work. We cannot fix it and cause regressions.

     Andrew

