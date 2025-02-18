Return-Path: <netdev+bounces-167358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B46DAA39E68
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:13:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A9EF188D09D
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 14:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EE5269D04;
	Tue, 18 Feb 2025 14:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NX1ZX9Jz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C70A269CEB;
	Tue, 18 Feb 2025 14:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739887966; cv=none; b=h3vsS0C9DTwAPyZxH12XNuhH+1Ed65z4UuqrX/jWgdDKw213Waq0erMQnMtQuyDFzyOkufVNdge4v6/9umlebWlv0bGT4MYyVxR8LSaGEurJEt6dY3MqNeNjHisEgr8hWen7vskCTHsKMufKED7BqDC5edHAmkoxH8GSVFEaz9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739887966; c=relaxed/simple;
	bh=TP1PCzrBaNeuiMu4ARgE5NHtG85QPvkKW3bW0yACSIY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hFX0QMBg/34Yc4X2HmiQqCr2DONIbQ+FUMZwT/uHsEUH1tDt6C1bopCaW5BapwVou8OToc0HfuxgzvkeLFz1L15lyfe17sT3R5J5RjPj/jtkQRFM9hT4Qsl8oH0cIDoxhU4YNP7mrtpMOorfPMAuhAP36m8z9pw0+SkvyVLzjuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NX1ZX9Jz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ez/Oje5z24vbP/hfwtZ8lCtF/vQsnWrYVjiXvxfTad8=; b=NX
	1ZX9JzL9T8hSP+FRlPS7nb1Zvi8KWjCt3Rp0RqyS1OBvgd9gogbKT+sPw1hoTf+XSOitOLPVG2gKQ
	2OW3h/ucomnB86f4JPcEMkbyPfy/MdHFoHrqQv0IebJD6PXnniLcieAyOk1sRd3dYW6i7XgAdSuY0
	ex9GN6YOui//ctY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkOKo-00FJl2-JZ; Tue, 18 Feb 2025 15:12:26 +0100
Date: Tue, 18 Feb 2025 15:12:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <marek.behun@nic.cz>
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Niklas =?iso-8859-1?Q?S=F6derlund?= <niklas.soderlund+renesas@ragnatech.se>,
	Gregor Herburger <gregor.herburger@ew.tq-group.com>,
	Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/3] net: phy: marvell-88q2xxx: align defines
Message-ID: <65fb511b-e1aa-4126-8195-ca575e008656@lunn.ch>
References: <20250214-marvell-88q2xxx-cleanup-v1-0-71d67c20f308@gmail.com>
 <20250214-marvell-88q2xxx-cleanup-v1-1-71d67c20f308@gmail.com>
 <rfcr7sva7vs5vzfncbtrxcaa7ddosnabxu5xhuqsdspbdxwfrg@scl4wgu3m32n>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <rfcr7sva7vs5vzfncbtrxcaa7ddosnabxu5xhuqsdspbdxwfrg@scl4wgu3m32n>

On Tue, Feb 18, 2025 at 12:54:29PM +0100, Marek Behún wrote:
> > +#define MDIO_MMD_AN_MV_STAT				32769
> 
> Why the hell are register addresses in this driver in decimal?

Maybe because 802.3 uses decimal? Take a look at Table 45–3—PMA/PMD
registers for example.

	Andrew

