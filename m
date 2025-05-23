Return-Path: <netdev+bounces-193117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BF0CAC28EB
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 19:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9A471C016A9
	for <lists+netdev@lfdr.de>; Fri, 23 May 2025 17:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4298C2367A3;
	Fri, 23 May 2025 17:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="DLFG+kKs"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F4D19BBC;
	Fri, 23 May 2025 17:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748021953; cv=none; b=Xg/iO6FwgnH2khiZGL+ou7eT/C45NdiguikxCnjGUalWl63sV7RF2LsgiIxYpfZA+/5Mg3+sZ6UyNUYNnCPmZ2bhexEhiLM5UnapzkQQ3pUBjj4R7Wt033c7EaYOswAeKoMHXcj39rSjvHeHfX9YKMZzgVYnvkimBrFkEOMAEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748021953; c=relaxed/simple;
	bh=wflgra3Cmb0wcTnceU/m9h2aoY0FARVn2Ve64rDV2W4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ApNp/2uAG5CSwcVJGYRgDZ4yDE6UmHrOdqCVY5vRKm61svltzRxeISkKSJf2rRbQf75h53r/SGFUTSx8tsGBI7j4AZPpML+ql26EQvBiCjEiI4Nf8Clhl6mFO3VGup1TOwsYLkpAbGmnSnbKGLlUf/UEFpKtbWzTlh5nCTdcvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=DLFG+kKs; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TJ5kN5D3O2c/bHHOqnIIHBtiVmyBFfKXEhmaEmd1YKE=; b=DLFG+kKs89vr7rBBugTGjew0aW
	HaifC3CToyB845WXIN9GSvaOW7nnW90dFJWs+2dJB3ypOZL/s+KTJ2/OnqSb8NdV0nww5/UHLbX4Y
	qN3qsRO6+7fhENqcXzCnnD0Wm7U2l6vPnpcvXcQULdS7t+i44u0GWQlE16VFWZK2vby/qowcU0YBY
	OKPrQthMYnZ0NQuymbeu5FClQaejSBnGqejvDGfu0gJDiXQML3jgG12ApmBgap6lCQvnAScIxD9x/
	16vXqMy138Zyk7r8ekU9LfX+6z9K92BWcBQgcbRnbFTP2TkeMSQoQlRWul/q58C2p1XvEw/L+TUVg
	zICFnF1w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:57202)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uIWMK-0003nE-1P;
	Fri, 23 May 2025 18:39:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uIWMJ-00062s-0V;
	Fri, 23 May 2025 18:39:03 +0100
Date: Fri, 23 May 2025 18:39:02 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Yajun Deng <yajun.deng@linux.dev>, hkallweit1@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Synchronize c45_ids to phy_id
Message-ID: <aDCytj5c4Mn69Y1D@shell.armlinux.org.uk>
References: <20250522131918.31454-1-yajun.deng@linux.dev>
 <831a5923-5946-457e-8ff6-e92c8a0818fd@lunn.ch>
 <5d16e7c3201df22074019574d947dab1b5934b87@linux.dev>
 <098e1f6a-1e0f-4819-98d7-146a28110043@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <098e1f6a-1e0f-4819-98d7-146a28110043@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, May 23, 2025 at 03:03:43PM +0200, Andrew Lunn wrote:
> 
> > > The second point has already been made by Russell, there are lots of
> > > 
> > > different C45 IDs, and phylib will try to find a driver based on any
> > > 
> > > of them.
> > 
> > I noticed that. I tested the BCM89890, 88X3310 and 88Q2110 PHY devices,
> > and the ID is always the same in different MMDs.
> 
> Try a Marvel 10G PHY. They have different IDs. It has been speculated
> Marvell licensed part of the PHY from a different vendor, and you see
> the vendors OUI in some locations.

The 88X3310 was listed, but incorrectly as always having the same ID in
each MMD. This is false as stated previously.

Maybe Marvell have updated the 88x3310 to use the same ID throughout
in a later revision, but it certainly is not true with the versions
I have seen.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

