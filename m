Return-Path: <netdev+bounces-158504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91076A123C2
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 13:32:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEEEA1889507
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD60C1DFEF;
	Wed, 15 Jan 2025 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="UcFb77Ae"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCB12475D9
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 12:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736944334; cv=none; b=GIQx9kX+1nlwL9qMpF8GxaF2oyxJ71dtHZcktm13ONr998DmuJ3lZhzsAn3HuYkqisyKEN+bQdfafxugs8L8FwxcU/yoyoYVlF7kWlGmgeamrR84E1bPIPMWdbTEhWBfggoxx7BNpRlPIPw3GRTh5V1S2n02t2al+WKOcd7QB/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736944334; c=relaxed/simple;
	bh=GycCbtKdKNGhlj9JRWUf7ifNuLN7M1lKMVdfGyhsOzU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjml6n0YMjqny/HpFj+JjfSjNiwI8Hym6qHF2tTV3kFASO+0UAbK61uaQqoc6d78TrbnWpZjKYPFug0Op07Vr9Dgwi8usd+7QusnpKphtm61jZlw8HZmrIAJtIGa3Sv/ICumKL/ZKfB9R/pMXkzDpdJ6b9da0hu9fE8bMuwRRHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=UcFb77Ae; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lBejSM1tNrbwGto9QaNo5+mc0Fs7U+0WzpR9pSG/hPw=; b=UcFb77Aeyx6kmULkLkBk1z4/xY
	sU9YhFEPud410z4Lxx+wcFJEDR5xElcEhCZRG88EmexM8Z+sVCRAGWowbDsxxRtuAVjSTEWkhwl+w
	3ugD5eZvoG0DiUnjSdiWRRcsQAO8cTvf7amYM9engdytYsjJxcMouFdxPycYfhVBx0Bfc3XPBL65x
	8b4HffJMBFh+4kMFUfDP0t6hvzrhMjRki2DX1rd/vFngNY6To0P/yghINerxqW3IYBWm6lnbKEe2L
	e1/rvqZgVc1AZ2U7K2lTMLNFD7s4HoCAXSOnjbOWhuEQ2/acZv9VG+zvqjYKo1E3vXE0yI0ksX4Id
	fCp3gaRQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52486)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tY2Yv-0001AU-0c;
	Wed, 15 Jan 2025 12:31:57 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tY2Ys-00069C-1u;
	Wed, 15 Jan 2025 12:31:54 +0000
Date: Wed, 15 Jan 2025 12:31:54 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
	David Miller <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew@lunn.ch>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 03/10] ethtool: allow ethtool op set_eee to
 set an NL extack message
Message-ID: <Z4equilzNzBv5wUa@shell.armlinux.org.uk>
References: <5e36223a-ee52-4dff-93d5-84dbf49187b5@gmail.com>
 <e3165b27-b627-41dd-be8f-51ab848010eb@gmail.com>
 <20250114150043.222e1eb5@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250114150043.222e1eb5@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Jan 14, 2025 at 03:00:43PM -0800, Jakub Kicinski wrote:
> On Sun, 12 Jan 2025 14:28:22 +0100 Heiner Kallweit wrote:
> > diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> > index f711bfd75..8ee047747 100644
> > --- a/include/linux/ethtool.h
> > +++ b/include/linux/ethtool.h
> > @@ -270,6 +270,7 @@ struct ethtool_keee {
> >  	__ETHTOOL_DECLARE_LINK_MODE_MASK(supported);
> >  	__ETHTOOL_DECLARE_LINK_MODE_MASK(advertised);
> >  	__ETHTOOL_DECLARE_LINK_MODE_MASK(lp_advertised);
> > +	struct netlink_ext_ack *extack;
> >  	u32	tx_lpi_timer;
> >  	bool	tx_lpi_enabled;
> >  	bool	eee_active;
> 
> :S I don't think we have a precedent for passing extack inside 
> the paramter struct. I see 25 .set_eee callbacks, not crazy many.
> Could you plumb this thru as a separate argument, please?

I was going to wait for this before reworking the phylink based EEE
support, but as it looks like this is going to be a while before it's
merged, I'll rework my series based on this not being merged and
post it non-RFC this afternoon.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

