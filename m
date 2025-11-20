Return-Path: <netdev+bounces-240376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 84DB9C73F9A
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:33:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 076D14E3B58
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:32:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72CA9336EC6;
	Thu, 20 Nov 2025 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Qun9URXZ"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50DC335577;
	Thu, 20 Nov 2025 12:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763641972; cv=none; b=bLfaO3RWH6e5dt3/WVzJZrBd2gZAUIceNK5R6et/wKscSifcqn4KUvYLkjeYLN7J4qQewVLcG9uTf1JwnDsMUyeyC/uw8Uy1cYtogi9nbGvqQvfD0ScwNLcRzjT7upUIbHKkvBxoWUhOFoNn+FvHA9/L5LCSAH7wkt4YNMVSGhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763641972; c=relaxed/simple;
	bh=vd54oodelnJJ35MRaeJ8BgvpBBFpBgRofS/ZMLNUSkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RUyyZWih0ZZjk70vvdN88OCmujYcqwax2UdWewDHv1nIvmpfcX4mrPISJ2GWWhTKgp/fb3T8R0b6BsuIv58O3MbTvug8tkb57LebhykuxY9sn85QpTwEeQaveTh6akKwOXIcaFlwSgnJ/logyawcAjHkKF0+tuf5Y7xmArzD/lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Qun9URXZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ddCkFmqfNO0QIKiQtpYM6PNRU6hkZxXZNyioptho42M=; b=Qun9URXZEhALZEqSNRvjg4q2uR
	KYvu/Tg23aIoP2Pkj71TkJkgdZcIB3uUJXeGnbqlIv96QkeHJ3Tfx6V1alSko+pe/Iy3D6sMXb0Fl
	B+2ns3MDaunA3mBFBWg9omtW79cvpWPhxIhDMlHIoRALMviaPd9MbKPdy60XKwsY3DjRZbDiaKotq
	wC+5nI325+97iYonHeI7+hx2NO8EYa8wcvqt8zE+SfHx2i2Y5Dy8gPjd/+sAfuSFMJHKdhGvuZylO
	jPbD/B5r4GejTDB3zqtCbz2QfurSZEHL0aKUUrLeWrSrwOTY14/Rk5fXgBvhIcEDPprAmE5ri1NcQ
	L0mYNU4g==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:38356)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vM3q5-000000006Dq-2ibL;
	Thu, 20 Nov 2025 12:32:41 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vM3q1-000000004Nb-48ve;
	Thu, 20 Nov 2025 12:32:38 +0000
Date: Thu, 20 Nov 2025 12:32:37 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, Serge Semin <fancer.lancer@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 14/15] net: dsa: sja1105: replace mdiobus-pcs
 with xpcs-plat driver
Message-ID: <aR8KZZa63ygR-e1N@shell.armlinux.org.uk>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118190530.580267-1-vladimir.oltean@nxp.com>
 <20251118190530.580267-15-vladimir.oltean@nxp.com>
 <20251118164130.4e107c93@kernel.org>
 <20251118164130.4e107c93@kernel.org>
 <20251119095942.bu64kg6whi4gtnwe@skbuf>
 <aR2cf91qdcKMy5PB@smile.fi.intel.com>
 <20251119112522.dcfrh6x6msnw4cmi@skbuf>
 <20251119081112.3bcaf923@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119081112.3bcaf923@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Nov 19, 2025 at 08:11:12AM -0800, Jakub Kicinski wrote:
> On Wed, 19 Nov 2025 13:25:22 +0200 Vladimir Oltean wrote:
> > I think it's due to the fact that the "contest" checks are fundamentally
> > so slow, that they can't be run on individual patch sets, and are run on
> > batches of patch sets merged into a single branch (of which there seem
> > to be 8 per day).
> 
> Correct, looking at the logs AFAICT coccicheck takes 25min on a
> relatively beefy machine, and we only run it on path that were actually
> modified by pending changes. We get 100+ patches a day, and 40+ series,
> and coccicheck fails relatively rarely. So on the NIPA side it's not
> worth it.

On "contest" I find when looking at patchwork, it's just best to ignore
the result that NIPA posts for that, because more often than not it
reports "fail" when there's nothing wrong.

For example, the qcom-ethqos patches - v1 passed contest, and this
morning I submitted v2. The only change was removing the double space
in patch 2. What I see in v2 is that _all_ the patches failed contest,
even those that are unchanged and previously passed. This makes
contest unreliable and IMHO misleading - and as such I hate it.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

