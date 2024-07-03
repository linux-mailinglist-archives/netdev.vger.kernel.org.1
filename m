Return-Path: <netdev+bounces-108896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 41AA79262E0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 16:08:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC63D1F25368
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 14:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5B417DA3E;
	Wed,  3 Jul 2024 14:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Mpid6Vv/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDDD717DA1F
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 14:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015643; cv=none; b=lRfz5El8Sbgcnr8DKtumqcopKcK7bGBxyEJwPA8I5qjN09kDT8KuKY5BbTAZB5Lx9Uyqp/ESGxCXbWntR20srb5hzIyifg07WniA8DdMGEvMjVEk91KSq83NgLPntfGdvqX8qryvsAIQ/fGQT6AtgmUaSkFfuZ3Kjey/piaOS0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015643; c=relaxed/simple;
	bh=lU4Q/1iQ7trScKtbODwF9NdENNomu9bUfBgDJn/4D4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDt6Sm9EA5jDBMCthfrskdzCNa8PRA1ZYUaCwUgCGh65NWoUlpsSFhTvlaGefMTKxu4AXDgssOVPho5dO1qvDXg+KIrh/T1koY4ubb2RTPmnQmb57+oc/DKZCChHm1FkESFJfDlVOWS+3q8SS+10/F47LUJxdrYNtFMRmw3U11U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Mpid6Vv/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=P0Rr+yS4hmxk/HxEasE5ZIIdo2vBH9AoXzHNr8O+yNA=; b=Mpid6Vv/k1ip5Z7a1GhqsniD/w
	DFaVm2xfz+aCMMjiC/VCCN5MEaK90BScgCxPy2z6OHgkAQaH37zWzdUWpxi0rqT/D2wnJzTYrRe/7
	yludWXR0MhBzTXM3d0rr1RrO7zEPxn5K8r9zsDzd7Hoc12onAk8HWzkvUDDvmeBctpAw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sP0dK-001jac-S8; Wed, 03 Jul 2024 16:06:54 +0200
Date: Wed, 3 Jul 2024 16:06:54 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Serge Semin <fancer.lancer@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	"Abhishek Chauhan (ABC)" <quic_abchauha@quicinc.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net] net: stmmac: dwmac4: fix PCS duplex mode decode
Message-ID: <c26867af-6f8c-412a-bdd4-5ac9cc6a721c@lunn.ch>
References: <E1sOz2O-00Gm9W-B7@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1sOz2O-00Gm9W-B7@rmk-PC.armlinux.org.uk>

On Wed, Jul 03, 2024 at 01:24:40PM +0100, Russell King (Oracle) wrote:
> dwmac4 was decoding the duplex mode from the GMAC_PHYIF_CONTROL_STATUS
> register incorrectly, using GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK (value 1)
> rather than GMAC_PHYIF_CTRLSTATUS_LNKMOD (bit 16). Fix this.

This appears to be the only use of
GMAC_PHYIF_CTRLSTATUS_LNKMOD_MASK. Maybe it should be removed after
this change?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

