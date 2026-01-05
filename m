Return-Path: <netdev+bounces-247120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B30F1CF4D2A
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 17:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71E8E311B7D6
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 16:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D325E2DC323;
	Mon,  5 Jan 2026 16:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="S6mU7XCG"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDDD1EB5F8;
	Mon,  5 Jan 2026 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767630533; cv=none; b=GX9CmSEVcU6zx8pl+kWSjbmLM24+0Twz1jXo9c+hKVore1ohbUrFr50K0x5LO4fAfYnw/LQpn+15R1UfngLFwpP0L+m71IK4UvTzd9fZsSOruy/a86UgFal4JoVwoJtkOrmzGnesmWO8OPt30S1TSS36qoZjTGSY7FZkFtfVEM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767630533; c=relaxed/simple;
	bh=oUHrA/xngwq59f14jmeScpmhWxKK+/nkR9LPgNiJI5U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFxHUfre2YsSegNkVFDhjxm1ysNc6PKYm6ZWtgWnPRdi/Ln0ICmQqAQuHWCqHJ/PqYqLCA7MCuhLARQ2pD6TQwkGEzZHZmXujOEn5he0La7d6P0A3oBmDobd/e82ATI+TSSpigbVqra9tecQCmWwS/zsLfXCbtTGdG7PCXaRkHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=S6mU7XCG; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EsXPymrb5GF7oMNYXaPOd1Clmu0xOExsd+sseF3Ky9c=; b=S6mU7XCGbpDuG+CTkVpiIxL7TJ
	4NjSFhvNU4qVzTdijXHEZWRo024dH6IW9nhlhB7ArovhziMQQEvlDuDrjTFNZp+4oTmAESmhxwIpO
	mIZiQcOmx01g2adJgbAWdqwFIXfCB+gHEa3V5uomFjZ9I38RbdHNop06sjQUsH6DeRw1OpxKnWGcf
	3Z0SrrId+Ca7IIZatr/962GMtyym8l6RZGLPps+AIIPf0gVP54p5N8q22iQCOeXdyArZpTaPK2fp9
	S40mvWvkf9TWQjcnlpS4obFGZeX78vWg+SAFSqX3doGsastRB64/gx2GbjNTInVwEpREprgTSsVJo
	e9bo/mvg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38410)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vcnRk-0000000085k-3OIz;
	Mon, 05 Jan 2026 16:28:44 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vcnRj-000000007zQ-0tQO;
	Mon, 05 Jan 2026 16:28:43 +0000
Date: Mon, 5 Jan 2026 16:28:43 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jonas Jelonek <jelonek.jonas@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Bj=F8rn?= Mork <bjorn@mork.no>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: Re: [PATCH v3] net: sfp: add SMBus I2C block support
Message-ID: <aVvmu1YtiO9cXUw0@shell.armlinux.org.uk>
References: <20260105161242.578487-1-jelonek.jonas@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260105161242.578487-1-jelonek.jonas@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 05, 2026 at 04:12:42PM +0000, Jonas Jelonek wrote:
> base-commit: c303e8b86d9dbd6868f5216272973292f7f3b7f1
> prerequisite-patch-id: ae039dad1e17867fce9182b6b36ac3b1926b254a

This seems to be almost useless information. While base-commit exists
in the net-next tree, commit ae039dad1e17867fce9182b6b36ac3b1926b254a
doesn't exist in either net-next nor net trees.

My guess is you applied Maxime's patch locally, and that is the
commit ID of that patch.

Given that Maxime's patch is targetting the net tree (because it's
a fix), and your patch is new development, so is for net-next, you
either need to:
- wait until Maxime's patch has been merged, and then the net tree
  has been merged into net-next.
or:
- resend without Maxime's patch.

In either case, please read https://docs.kernel.org/process/maintainer-netdev.html
In particular, the salient points are:
- no resends in under 24 hours (see point 1.6.7)
- specify the tree that your patch is targetting in the subject line
  (see point 1.6.1) E.g. [PATCH net-next v...] net: blah blah

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

