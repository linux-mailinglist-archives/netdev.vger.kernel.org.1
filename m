Return-Path: <netdev+bounces-222117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A497AB532F3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 14:59:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66A60A82092
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 12:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48765322552;
	Thu, 11 Sep 2025 12:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="X1g/1CXX"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8DC21C19D;
	Thu, 11 Sep 2025 12:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757595534; cv=none; b=p8cyc2MBGx1q7U+xnxEDZgMZpqc9E0s2akgFoY6R8hV4z1jNVPGB68fIhDxKRO2f3oiSdlWnkVpmhvnk/4/3bDGF0ScqwY0MbDbvuR1+njxTHaVwYwRjq7IRCzcjUHv+vj+UcN32WWqqsBtHMv6Iq5AfZKSjaj/VXVskL56p+2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757595534; c=relaxed/simple;
	bh=nmYYVIbGhfSt5FuYcdqJ09Omn9lv2kPfMExA7XXzj2Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oCPcDyb3esGAehB+9ZNT4JNTYS7NNcXZ4u4nYs6ktclO/F7fvOJ6PXP29EOIoOc1GtZJATUOR7dEV1RuI+tCqK5kmquKdPEs54bmGdl9cpzkA0abs/oEd+H4F+HN8opXo47uCnAVnEx+26L3MT9gQnREapSJO6LAtCt2ablHweU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=X1g/1CXX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ATy1erNAqx7XodyEyg2naN3bSvTOsedChjM0YoFoK/s=; b=X1g/1CXXg0lPrqoO8/jDEpTFPb
	XVZeY2Ho2KNj70F1q4hoTYH9UujuxVSGq17Kh1a6JHK+MEfKbZw+KlxJuvDWGMHJpZ6EcUnTuBUkn
	Zgsk3oxNOOZsBKjAC19TEBTW43SK82c6srlv1oD8bPfjHi2wyb9X+T1T903GfcPCoQ58=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uwgsi-0084vi-Fp; Thu, 11 Sep 2025 14:58:32 +0200
Date: Thu, 11 Sep 2025 14:58:32 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: yicongsrfy@163.com
Cc: linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
	hkallweit1@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, yicong@kylinos.cn
Subject: Re: [PATCH] net: phy: avoid config_init failure on unattached PHY
 during resume
Message-ID: <9393c232-06d8-464e-ac94-597eaeda2630@lunn.ch>
References: <aMFKvS-Dm0hhJVnO@shell.armlinux.org.uk>
 <20250911112525.3824360-1-yicongsrfy@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250911112525.3824360-1-yicongsrfy@163.com>

> Some PHY chips support two addresses, using address 0 as a broadcast address
> and address 1 as the hardware address. Both addresses respond to GMAC's MDIO
> read/write operations. As a result, during 'mdio_scan', both PHY addresses are
> detected, leading to the creation of two PHY device instances (for example,
> as in my previous email: xxxxmac_mii_bus-XXXX:00:00 and xxxxmac_mii_bus-XXXX:00:01).

I would say the PHY driver is broken, or at least, not correctly
handling the situation. When the scan finds the PHY at address 0, the
PHY driver is probed, and it should look at the strapping and decided,
if the strapping has put the PHY at address 0, or its the broadcast
address being used. If it is the broadcast address, turn off broadcast
address, and return -ENODEV. phylib should then not create a PHY at
address 0. The scan will continue and find the PHY at its correct
address. Your problem then goes away, and phylib has a correct
representation of the hardware.

The harder bit is backwards compatibility. Are there DT files which
make use of the broadcast address, and disabling it will break them?

We have seen patches disabling broadcast, but i don't remember for
which PHY.

	Andrew

