Return-Path: <netdev+bounces-147503-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 958DB9D9E2F
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 21:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4873416299A
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:02:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5D41DDC27;
	Tue, 26 Nov 2024 20:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="YwDN2Z18"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1691D5AC6
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 20:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732651378; cv=none; b=o1X2k3fQxWTHft8Q0X7kNlHeSnTW4FcKPdRh8PkVvmsfQeNj9A3FCpAgldlZ0cjcf06J1QAW40gP+SqK0QHcUpq9DjKY/aARiVMesUX0IYP8YsILao7vfMG0NotMfC3h2ACzshN3y438tzwk7yAeUQqCdaNGEp3EBg+EvmGNRcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732651378; c=relaxed/simple;
	bh=CDkr7/uXyJiPfLKH6wvJbU5BRlZBg6bWgBztzsOLjcg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M3ZZ/9WZwo5rJu195z0bxgYao3TTwjmC1wgK6sCQGEurU4BC0Dp4URoB1wMsCejau0zRstsPwLuuATBcne8WCpYAbjHiIlgILLjaEsSFFE0RuWC0eegjmuQP0f7EYit/HreZ6HcurjP6NX4waQOrRvNs68mjLnrvqqsrDr6z800=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=YwDN2Z18; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=UoKlEXtB3EjxHAoJcJGRZSerDnh1PQkKqKumRA/zpG8=; b=YwDN2Z18k6aOPNYinbqdm6sTjE
	oUDLT6oVHw3lOnY4Dsh4fvBcGJ6RIx/wY0EMS8/nW1NIC0TK70N8vJHGjzjym0PFqIK7FVctV5ZcH
	Dx/t+LPf7GNz1kqHFkCQM/PA48J4dI0AKsGVxgD2BySaPs2dv5j/agR5YV5EK1uJ2Y+k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tG1li-00EYa2-C8; Tue, 26 Nov 2024 21:02:42 +0100
Date: Tue, 26 Nov 2024 21:02:42 +0100
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
Subject: Re: [PATCH RFC net-next 02/16] net: phylink: split cur_link_an_mode
 into requested and active
Message-ID: <d5ae164b-b167-4654-8c02-853b41fa71a2@lunn.ch>
References: <Z0WTpE8wkpjMiv_J@shell.armlinux.org.uk>
 <E1tFro1-005xPk-O5@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1tFro1-005xPk-O5@rmk-PC.armlinux.org.uk>

On Tue, Nov 26, 2024 at 09:24:25AM +0000, Russell King (Oracle) wrote:
> There is an interdependence between the current link_an_mode and
> pcs_neg_mode that some drivers rely upon to know whether inband or PHY
> mode will be used.
> 
> In order to support detection of PCS and PHY inband capabilities
> resulting in automatic selection of inband or PHY mode, we need to
> cater for this, and support changing the MAC link_an_mode. However, we
> end up with an inter-dependency between the current link_an_mode and
> pcs_neg_mode.
> 
> To solve this, split the current link_an_mode into the requested
> link_an_mode and active link_an_mode. The requested link_an_mode will
> always be passed to phylink_pcs_neg_mode(), and the active link_an_mode
> will be used for everything else, and only updated during
> phylink_major_config(). This will ensure that phylink_pcs_neg_mode()'s
> link_an_mode will not depend on the active link_an_mode that will,
> in a future patch, depend on pcs_neg_mode.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

