Return-Path: <netdev+bounces-166093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00427A34794
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 16:36:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79E517A2682
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 15:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C223E203711;
	Thu, 13 Feb 2025 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="htRqOzQH"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07857202F93;
	Thu, 13 Feb 2025 15:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460919; cv=none; b=LcbUdO8N1HPq9suLEJo86gN602nP2YRaQsvzQZAYvNFlAzHOfBrLg5LR7nm64Vutb/TGZb5xVsRhXQYQCLhyAnjbBIPmhUQwXeru2H2/NSPTFxCAo27HTFrrvC46ZCeBfeidZAf5tloaSmOp2FA7wRx+MpSHntP4vvKOA7rDX5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460919; c=relaxed/simple;
	bh=KIzQ6vooyU6QmwLx00RHWtl6/ppL9caxsWCQFHdtPas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfKo5SRMujYwUhWZT4hq+5YURs3NeMPLvVjOqL+NJg0iEO0foz9/vUGIV6H+XwLzuhI5UiHl8pVLbjl9cDsMEzTYkL4dP0L93Z01+tLocMypFO3Eueg8awelB5NmjANeiveCZJJnrzEGeVwE5gUnHS4ZQiHbviptEaV72J6Bjyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=htRqOzQH; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P9KCq207AYFiKquz58kkroM53MgkDG0PAHpKTjgiJoU=; b=htRqOzQHvtSCd7OSdJjBfJQwM+
	kU1/R0KuL0nmL6BhJ6EOWiRmsFxRZ8Ptt13b8iomO4q7VywBTYXh1goom0LH5I9UZLuBTCOb4gtFd
	NyC2+5mreJmgWNVU+YsR5uX/SRIrKj3bm2pD19BHnjVw1YykjnOhLtML/wAq5i+GUANM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tibEv-00DmDc-Mc; Thu, 13 Feb 2025 16:34:57 +0100
Date: Thu, 13 Feb 2025 16:34:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: SkyLake Huang =?utf-8?B?KOm7g+WVn+a+pCk=?= <SkyLake.Huang@mediatek.com>,
	"dqfext@gmail.com" <dqfext@gmail.com>,
	Steven Liu =?utf-8?B?KOWKieS6uuixqik=?= <steven.liu@mediatek.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"edumazet@google.com" <edumazet@google.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"horms@kernel.org" <horms@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"matthias.bgg@gmail.com" <matthias.bgg@gmail.com>
Subject: Re: [PATCH net-next 1/3] net: phy: mediatek: Add token ring access
 helper functions in mtk-phy-lib
Message-ID: <81234e04-f37c-4b10-81e6-d8508c9fb487@lunn.ch>
References: <20250116012159.3816135-1-SkyLake.Huang@mediatek.com>
 <20250116012159.3816135-2-SkyLake.Huang@mediatek.com>
 <5546788b-606e-489b-bb1a-2a965e8b2874@lunn.ch>
 <385ba7224bbcc5ad9549b1dfb60ace63e80f2691.camel@mediatek.com>
 <64b70b2d-b9b6-4925-b3f6-f570ddb70e95@lunn.ch>
 <Z633GUUhyxinwWiP@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z633GUUhyxinwWiP@makrotopia.org>

> > > Those registers with Mrvl* prefix were originally designed for
> > > connection with certain Marvell devices. It's our DSP parameters.
> > 
> > Will this code work with real Marvell devices? Is this PHY actually
> > licensed from Marvell?
> 
> >From what I understood the tuning of those parameters is required
> to connect to a Marvell PHY link partner on the other end.

If so, the naming is bad. I assume you need the same settings for
Microchip, Atheros, Broadcom, etc. These settings just tune the
hardware to be standards conforming?

	Andrew


