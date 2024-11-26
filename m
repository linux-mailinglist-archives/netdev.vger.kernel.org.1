Return-Path: <netdev+bounces-147504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE6A9D9E30
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DE2D6162A54
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869171DE2BD;
	Tue, 26 Nov 2024 20:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TYvIAx4k"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F37B51DA631
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 20:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732651451; cv=none; b=Xl4RRVoXMdnRdzjFzJiyX1RANfs2kjllFZRmSvUKsiurnZracFY7xxd5Qndo8RFUd4B9FSH29fvnS6IqYzdbpAvOGJ3XsECft10I6asTj2wb+8F6L3mOSboHQinVvR8cW2CrmQg5xBfNWfkv4uH5yd0Sr+LveS5nSgsewZJQtRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732651451; c=relaxed/simple;
	bh=E9XLmCPaOrfhFEXB/5LM+oXcSp0uGfadtcx4WxoQxZc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvZ3saDOaTh98fX4ss4y9RHksF6vCqjJ9NCqFU+esoxO+dXeGB6G7niKxUghNHNvq+RtVLvBKPk0rJ6N3lgW2gQPz64Ya4wMHDuJLUkFrlZ4QM/QD1SlrzDhRaJE9FdBTu9SbF4HytDwbBofyLb8ygQMAEV1BgrxyhNKSbEKl6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=TYvIAx4k; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=33QDMFboHobZ24rZyPzwWuD3zmhdfJExkR2aCZrd/kg=; b=TYvIAx4ktZN68zyY+q/kYpc6IA
	8lR6iHbVCJptq6VYdOBw8f8gMEapM/DblaiZM2dGOpLUim8G+0NWNEyPypZd1hZnmYDeXU6Gr0WDk
	0zWHdaMt7g58ImsIRpeto1E8EhovN+vmEQAF2F1605rE2kRJB5JCzTHMehQSwHHFKPUw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tG1ml-00EYbj-7n; Tue, 26 Nov 2024 21:03:47 +0100
Date: Tue, 26 Nov 2024 21:03:47 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexander Couzens <lynxis@fe80.eu>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH RFC net-next 03/16] net: phylink: add debug for
 phylink_major_config()
Message-ID: <963a0532-d05e-41ff-bc44-cf2df075f4b8@lunn.ch>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
 <E1tFro6-005xPq-S1@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tFro6-005xPq-S1@rmk-PC.armlinux.org.uk>

On Tue, Nov 26, 2024 at 09:24:30AM +0000, Russell King (Oracle) wrote:
> Now that we have a more complexity in phylink_major_config(), augment
> the debugging so we can see what's going on there.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

