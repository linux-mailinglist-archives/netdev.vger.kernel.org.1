Return-Path: <netdev+bounces-147502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9AB9D9E2E
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:01:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E07951605A5
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 386FD1DE3A3;
	Tue, 26 Nov 2024 20:01:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="b+wSD1yU"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C931D5AC6
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 20:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732651294; cv=none; b=A8/oCd66FsAb6LPLagibqv6BFKHiTWFT8jb5o8I0iC/d5zEjdnabyMtoBOxKX+og79NGjqIG1sJ0szxgFS6zJsj4wimj9+H8+7Ib9T8VqxqqetsB//UKwRAklRraSV7QtRjVaWY/P1IJByDigzzcfidXkdox2SF1Fb6QyUKpo6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732651294; c=relaxed/simple;
	bh=j+HYr5dP2xiuFxq5EsKBaYRMrnHz27Lo/mUtGmpCMgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GpMjDKuypN39a0wPv2iuAvtFdGyA3393CwKBj5xb7UhFqVSnThqhCxmfIsFHlroCOdnhvblWU5JQESE6ns3ILjetRUjHz0cFoNLyG91+whb6fGwcrxMuv/nqZL/OwZ7dZAHYJH/Wb7T9VEvNJdTjIQ5mkMFt63KpkfL521uYSXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=b+wSD1yU; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=zzmuQQKxyTgx9LMpYPrh3p1tSF7mzJ4FGaCyi5J1O2E=; b=b+wSD1yUVZO2M7+N3jComz28RJ
	wsGEgCkqXXhnRKMzL1bOegHzG46lNuLnZCUZNer+7Wujp4VPqyY5B7sHoo4xt+YYT9U4fXsIJw5mJ
	yyFHF0axxcJS3Uqa1ltcjBJHdJaSuhmPW2TguBK9ibq0qd3Ws+NIGgkMerS2GQ46dWnA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tG1kA-00EYYP-Tu; Tue, 26 Nov 2024 21:01:06 +0100
Date: Tue, 26 Nov 2024 21:01:06 +0100
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
Subject: Re: [PATCH RFC net-next 01/16] net: phylink: pass phylink and pcs
 into phylink_pcs_neg_mode()
Message-ID: <630a8c53-55c0-49c9-a53f-ce6478641a11@lunn.ch>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
 <E1tFrnw-005xPe-KN@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tFrnw-005xPe-KN@rmk-PC.armlinux.org.uk>

On Tue, Nov 26, 2024 at 09:24:20AM +0000, Russell King (Oracle) wrote:
> Move the call to phylink_pcs_neg_mode() in phylink_major_config() after
> we have selected the appropriate PCS to allow the PCS to be passed in.
> 
> Add struct phylink and struct phylink_pcs pointers to
> phylink_pcs_neg_mode() and pass in the appropriate structures. Set
> pl->pcs_neg_mode before returning, and remove the return value.
> 
> This will allow the capabilities of the PCS and any PHY to be used when
> deciding which pcs_neg_mode should be used.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

