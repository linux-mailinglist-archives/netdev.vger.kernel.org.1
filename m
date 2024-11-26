Return-Path: <netdev+bounces-147519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 585879D9EC2
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 22:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DBB4CB24FAC
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CB4E1DE880;
	Tue, 26 Nov 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="RCptV+VE"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A371DD0D4
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 21:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732655953; cv=none; b=esMmI7v3fzfsz6ciZrs9ztiOhdPe0J65ms5Zg+FbysqY3MgtCmvhNfs9Ht4btOBcbfWlcHsWIVcF43zM/tTzwGobKo5V1cinn+67oIuBpyMkqVWDcrS2DJXEX0crtA+VeehC8RGSJqK9NR+PkjL3KHTwDnwDXiM1pZYu1uu8DBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732655953; c=relaxed/simple;
	bh=sQVv3AMgEyMHjDTEIL7WBGpS1s4mPO7+xJOBooKWuhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gwjO6fy7KcD3ys+Zm9YNax1HgjibEqFaH5kxK0ceckE9KEpEObjsTXWcRYUi+r6rRGePF3A+kQU0mY9pK4I3d899KAJtBguWRO7BVfiwLU5KYmveVilNn3NDocWWf7ue7pSynjACUoKuLOZIKveYNwr039z/MgfPZv3EuOK5Su8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=RCptV+VE; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=tcl4MNMZwnljfA1EBKJpg0e8T/uMkHnaIji3KIQZjZs=; b=RCptV+VEeg8w8GKOmmNrDBrRuB
	MK5xZZEaDiUCcfp/TPKMi8n0UXIJRGz+DTKw+KNN/aU2yxU7Fdsh0Crl7C4UV7lb6TbFYAnHIaqox
	AriCFpezQDX46IeSYaahPUNOhQCk+YjIbQef8/8OEDQcr8jSpH5PTad/Hg+c33mAzS0s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tG2xU-00EZI5-Oh; Tue, 26 Nov 2024 22:18:56 +0100
Date: Tue, 26 Nov 2024 22:18:56 +0100
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
Subject: Re: [PATCH RFC net-next 15/16] net: phylink: add negotiation of
 in-band capabilities
Message-ID: <e8a11b23-3918-458f-8888-4ca32058968a@lunn.ch>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
 <E1tFrp6-005xR2-6W@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tFrp6-005xR2-6W@rmk-PC.armlinux.org.uk>

> +		if (pcs_ib_caps && pcs_ib_caps != LINK_INBAND_DISABLE) {
> +			/* PCS supports reporting in-band capabilities, and
> +			 * supports more than disable mode.
> +			 */
> +			if (pcs_ib_caps & LINK_INBAND_DISABLE)
> +				neg_mode = PHYLINK_PCS_NEG_OUTBAND;
> +			else if (pcs_ib_caps & LINK_INBAND_ENABLE)
> +				pcs_ib_only = true;
> +		}
> +
> +		if (phy_ib_caps && phy_ib_caps != LINK_INBAND_DISABLE) {
> +			/* PHY supports in-band capabilities, and supports
> +			 * more than disable mode.
> +			 */
> +			if (phy_ib_caps & LINK_INBAND_DISABLE)
> +				pl->phy_ib_mode = LINK_INBAND_DISABLE;
> +			else if (phy_ib_caps & LINK_INBAND_BYPASS)
> +				pl->phy_ib_mode = LINK_INBAND_BYPASS;
> +			else if (phy_ib_caps & LINK_INBAND_ENABLE)
> +				phy_ib_only = true;

Looking at the different handling between PCS and PHY, i asked myself,
does PCS BYPASS exist? If it is invalid, i don't see a check if the
PCS is reporting it and should we be issuing a warning?

    Andrew

