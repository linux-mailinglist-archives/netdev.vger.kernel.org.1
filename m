Return-Path: <netdev+bounces-68519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0754084711D
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 14:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEB941F233DF
	for <lists+netdev@lfdr.de>; Fri,  2 Feb 2024 13:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1933E46448;
	Fri,  2 Feb 2024 13:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="tqJ0tX0Y"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96D60442E
	for <netdev@vger.kernel.org>; Fri,  2 Feb 2024 13:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706880416; cv=none; b=oBOqDptzt7IVeqFR9xeRwqPS9o8MZTUvboXLy33+ivfKpLJHPFTRvKA5pnmtlETG2BtxbFCbevSOr1+FndumT3nA98QNnoTp1SNhm+3i1IdxRvs7exeRx5O/I4WWXdZ/ydudXoVPw/xm9bcIufU4tJMsEHG5oXsxWnWCxOWo65A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706880416; c=relaxed/simple;
	bh=E62WQRXIl1+rxJQsDV1sqBj/oEyOeEzlHdX7ah/RIk8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W7S99g6lbHy29qCia4WaIq17MsnSlaFVuxpwWXgmH4Qzetaw9EbgIdeelVjRdrNgIYtbk97Xxll/RmG760xTs2uEpXAU1p2YXyTFwOKgHRGKc5qlHnMIej2RJzNAuV3kQkDqRjquOeo9Ec8Of1i1V2m5YmxZ8aEpd8AcFy6NKuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=tqJ0tX0Y; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=LYOfqYi+pjd9zpDUl8vD6UDTlM7tRsnpmAHfIWI/6og=; b=tqJ0tX0Y0w+FYcgyMcqBnTuCe5
	43QFVmwxO4xa8nPgoos1nNI9oaxxgytUnvBZ/uLd1ilb/0EUo4bmDrp2ZCejOMn57k5EjKm5sI5ny
	/28mi50f3oY3IQif202dGf8y6+tzgc7ydtNe4CKcdA2s9IoZf+1Ni3hQ6XU5QmDPIVPU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rVtZ6-006mn1-In; Fri, 02 Feb 2024 14:26:44 +0100
Date: Fri, 2 Feb 2024 14:26:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	bcm-kernel-feedback-list@broadcom.com,
	Byungho An <bh74.an@samsung.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>,
	Doug Berger <opendmb@gmail.com>, Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
	Justin Chen <justin.chen@broadcom.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Vladimir Oltean <olteanv@gmail.com>, Wei Fang <wei.fang@nxp.com>
Subject: Re: [PATCH net-next 5/6] net: bcmasp: remove eee_enabled/eee_active
 in bcmasp_get_eee()
Message-ID: <9b080167-d102-4fb2-ac31-3d171a88fc8e@lunn.ch>
References: <Zby24IKSgzpvRDNF@shell.armlinux.org.uk>
 <E1rVpvx-002PeD-71@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1rVpvx-002PeD-71@rmk-PC.armlinux.org.uk>

On Fri, Feb 02, 2024 at 09:34:05AM +0000, Russell King (Oracle) wrote:
> bcmasp_get_eee() sets edata->eee_active and edata->eee_enabled from
> its own copy, and then calls phy_ethtool_get_eee() which in turn will
> call genphy_c45_ethtool_get_eee().
> 
> genphy_c45_ethtool_get_eee() will overwrite eee_enabled and eee_active
> with its own interpretation from the PHYs settings and negotiation
> result.
> 
> Therefore, setting these members in bcmasp_get_eee() is redundant, and
> can be removed. This also makes intf->eee.eee_active unnecessary, so
> remove this and use a local variable where appropriate.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

