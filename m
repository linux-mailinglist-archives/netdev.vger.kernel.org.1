Return-Path: <netdev+bounces-222458-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B056B54532
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 10:24:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2513A7AFE
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 08:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE67E20ADD6;
	Fri, 12 Sep 2025 08:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="X1jx//a4"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C52732D6E60
	for <netdev@vger.kernel.org>; Fri, 12 Sep 2025 08:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757665472; cv=none; b=SL85amjuWoRyHFglK0tIxx8XAdHl3oAcN4sLBN7fCwDYGprLoxApZnfy5VlwvrI5TT4VApyxUK1q/yxZZbO48W7KiwH66K1rJcHHKnu9zNtOLQWiEAezAehyJYZPBXFCH7m0qv697ZL5DpBrePoR6+SRjHuok8aCPDEn1ghvLIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757665472; c=relaxed/simple;
	bh=G3Sdp/ZVwYcMs1IT4JQ3HT2T9kk5odDlxHHxV4fba8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LoPhiKbtQX2Dk9Y5cTFUL+L3JrrSJZoXYFrWpxhuf9K/tljmswV/1OKqKXQUFHC4Zj496ZEKl4kTZjZP7Igwg91wZwUGHpVMVB9dxeeE7LZRsXMdjY1/BJCZnFQPAGpv7uh698CSNKfNYYgeGJpaL7yfJnOHPjl4YyV7HHzcLNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=X1jx//a4; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=K9ICwrst558XFzsKtusIKbwO8AGpP60Ecok/wMJnGPo=; b=X1jx//a4gY1BcJfsyO40Ahb/yx
	Q4jqC0BAgEQ8TXXz4ubIFzSUzJYF+BtY0tPrJTl+ftwBRgSmisFab/c/Ox9P2qPSQA7K44MzKUS/Y
	/h8axe61pFbZXUsrVmdzA0ggiiA7HidDcDMEV2jH9JbIuCuaJeGyrgnLifXkVzUkcsFyegGjNwz6M
	JAehnhVZL8NX2iWkbWtSC8a2pI+N5N7KB2xfw6OPt4FdeYIPzQLdaK/Lt4gyVFLgkiMvwrPzS3ZZX
	s5Hb/AaJPLXn5rK4aKFj0MS7CbA9mm+qloEZJt3AP7GWYJ5VxOzM3mQWN5U6qPme0hxzyDU5dgKKU
	aATzbA6Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:47896)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uwz4x-0000000049u-0pla;
	Fri, 12 Sep 2025 09:24:23 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uwz4u-000000003Mr-0vje;
	Fri, 12 Sep 2025 09:24:20 +0100
Date: Fri, 12 Sep 2025 09:24:20 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v2] net: mvneta: add support for hardware
 timestamps
Message-ID: <aMPYtPj1fpstcbgt@shell.armlinux.org.uk>
References: <E1uwKHe-00000004glk-3nkJ@rmk-PC.armlinux.org.uk>
 <20250911185506.6ee85d94@kernel.org>
 <20250911185841.0863ffc0@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911185841.0863ffc0@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Sep 11, 2025 at 06:58:41PM -0700, Jakub Kicinski wrote:
> On Thu, 11 Sep 2025 18:55:06 -0700 Jakub Kicinski wrote:
> > On Wed, 10 Sep 2025 13:50:46 +0100 Russell King wrote:
> > > Subject: [PATCH net-next v2] net: mvneta: add support for hardware timestamps
> > > Date: Wed, 10 Sep 2025 13:50:46 +0100
> > > Sender: Russell King <rmk@armlinux.org.uk>
> > > 
> > > Add support for hardware timestamps in (e.g.) the PHY by calling  
> > 
> > These are _software_ timestamps.. (in the subject as well)
> > 
> > Fixed when applying.
> 
> Let me take that back, you may actually mean HW because of the PHY
> handling detour. Maybe call out both software and PHY (hardware)?

I do mean PHY based hardware timestamps, because that is exactly why
I'm making the change (for my Marvell PHY PTP core.) The software
timestamping is a side effect.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

