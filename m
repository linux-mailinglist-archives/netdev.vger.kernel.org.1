Return-Path: <netdev+bounces-152661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4AF9F517E
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:00:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7B9188B309
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 17:00:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655E21F76D9;
	Tue, 17 Dec 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rPV7wsNl"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D21371F758C;
	Tue, 17 Dec 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734454821; cv=none; b=ffr2pRXAoE344I1GgQqvxzKRkOBfEKgOjQs2KIQ0B7sAm69srvHiGEsj+t4Jd6xFftGxLXLtpWK6EFpugLTea97tFCdxsLUPevlZ8d5TMG+WTjl3DlMMNsy+RtF5tlcgJxHaBl/hdcOLe9FiAx+gnQFCa8RRlPKdQcNN0nR8ld8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734454821; c=relaxed/simple;
	bh=WyDyY4aQYqqYQYZFNrphMfbOh5pcveta+Hso/X//v6Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iaWZLBgihbMn4SiOre+gNjwa1lE3fyK6AQEDtwoN9g0JY70KZc1MM6p7JztxMg/MTs0LjoIscnKz0SZjJZ1egfS1dcNtMtgygNNbapGpOtVkBe0mWCNEEIWX+ptGgQEqvuua6vtAbSEHBlsiNlqPfGygl69rqmQKrkUbNqBLN7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rPV7wsNl; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=2kdd/C+u6elSrmTw/BdSPP4bZgQQ9P20+IyYEvz+Zyo=; b=rP
	V7wsNlNeqgeOt+Ao4hBRcTnlYyFLys3fuy2sSL07SuODDlTRXipKtd8Lvf+/7+P/nqbc9tGFV/G6J
	hXWQlr1HAfzjw5BGBrkGmk/eZcYZ559Q816huzwU+VO+PXTIT8U+05v4HuMG+yiw8/HN1CsIvihUt
	05lM1wJsSxq1lMU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tNavK-0010v1-SE; Tue, 17 Dec 2024 17:59:54 +0100
Date: Tue, 17 Dec 2024 17:59:54 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	TRINH THAI Florent <florent.trinh-thai@cs-soprasteria.com>,
	CASAUBON Jean Michel <jean-michel.casaubon@cs-soprasteria.com>
Subject: Re: [PATCH net] net: sysfs: Fix deadlock situation in sysfs accesses
Message-ID: <c63033ff-ff47-4008-b7d3-f07d016496fa@lunn.ch>
References: <d416a14ec38c7ba463341b83a7a9ec6ccc435246.1734419614.git.christophe.leroy@csgroup.eu>
 <c0a07217-df63-4b5d-b1a5-13b386b0d7d7@lunn.ch>
 <c1d52a7d-b6b2-4150-99c7-a67b2a127a18@csgroup.eu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c1d52a7d-b6b2-4150-99c7-a67b2a127a18@csgroup.eu>

On Tue, Dec 17, 2024 at 05:18:40PM +0100, Christophe Leroy wrote:
> 
> 
> Le 17/12/2024 à 16:30, Andrew Lunn a écrit :
> > On Tue, Dec 17, 2024 at 08:18:25AM +0100, Christophe Leroy wrote:
> > > The following problem is encountered on kernel built with
> > > CONFIG_PREEMPT. An snmp daemon running with normal priority is
> > > regularly calling ioctl(SIOCGMIIPHY).
> > 
> > Why is an SNMP daemon using that IOCTL? What MAC driver is this? Is it
> > using phylib? For phylib, that IOCTL is supposed to be for debug only,
> > and is a bit of a foot gun. So i would not recommend it.
> > 
> 
> That's the well-known Net-SNMP package.
> 
> See for instance https://github.com/net-snmp/net-snmp/blob/master/agent/mibgroup/if-mib/data_access/interface_linux.c#L954

That is pretty broken:

It assumes the PHY is using C22. Many PHYs now a days are C45.

It assumes the PHY only supports up to 1G, were as many PHYs now a
days are > 1G.

It assumes the PHY is not an automotive PHY which has its registers in
a different place.

Reading the BMSR can change the BMSR, so phylib is going to get
confused and miss linkup/linkdown events.

There is no locking going on, so the PHY might be on a different page,
e.g. to read the temperature sensors, blink the LEDs, etc. The SNMP
daemon has no way to detect this, so it will be applying BMSR, BMCR,
etc meaning to registers which are in fact not BMSR, BMCR, etc.

This code needs throwing away and replacing with netlink sockets,
which is a lot more abstract API, PHY independent, speed independent,
media independent etc. That would also solve your deadlock.

	Andrew

