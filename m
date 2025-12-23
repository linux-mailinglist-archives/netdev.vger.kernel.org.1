Return-Path: <netdev+bounces-245917-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 059BFCDAC8D
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 23:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 05C5C30080DE
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 22:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A840302CDE;
	Tue, 23 Dec 2025 22:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="y7P6A3zZ"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7411B262808;
	Tue, 23 Dec 2025 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766530787; cv=none; b=qPCSIHuHCO7XGyc7Sn9e5HqsApSYd09j6TkQk3mR/ho9zkkB9iEVoWftsszcKPfjW8Q+SBFR5KM9Fe1W7Y+g3ZJSt/IvbLc3Q8EmuHUFZO6QMsCZ6XULt2RcvQx9OnUvEWMg8FgOpxjUI0MNhX63jDtsLA6vdVd+pAmCRX7iNNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766530787; c=relaxed/simple;
	bh=x/0e9HqzdLYWlrRXK1r05P+Hb30BwsjFFpedhV+GYPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oKLneCTZhFWY57FmFr3vsprIFB3rsavkW93wRclBZkXbno4cmyrWBPGmn6UMTcz5APvifEzLZImZkNFo/seVbiWhghcCDxcI6DWgkak60Nru63lGREU+gx5Omk5QWPBgljX+AUORnqVlc5d1nX9GxCdZzt/dlL1e4ApYQZxxYH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=y7P6A3zZ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pzmCuw6HZHnsaz9Kf1VN3S6ms2vDR2Salg0HgYyF8H4=; b=y7P6A3zZsAQ7w5v9FS7Sao4VmE
	MS6n7GWsI7kQjvwJWlBqLyStYRV+uUFFUh7OaMLfiC86WfFcnvHO+kRh1EQH3bHFcPCLZ0Gr+i3Ii
	vRbcuMCJxFIZGSQRfqNVtxJbrA7CnKjsPWeUYVUrWZmylW3ipkFsv5x6eHu0dzx878VA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vYBLl-000Lo8-H4; Tue, 23 Dec 2025 23:59:29 +0100
Date: Tue, 23 Dec 2025 23:59:29 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Francesco Dolcini <francesco@dolcini.it>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] net: fec: Add stop mode support on i.MX8DX/i.MX8QP
Message-ID: <af853183-5f77-47f0-905e-fd959f9b57a6@lunn.ch>
References: <20251223163328.139734-1-francesco@dolcini.it>
 <20251223163629.GA138465@francesco-nb>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251223163629.GA138465@francesco-nb>

On Tue, Dec 23, 2025 at 05:36:29PM +0100, Francesco Dolcini wrote:
> On Tue, Dec 23, 2025 at 05:33:27PM +0100, Francesco Dolcini wrote:
> > From: Francesco Dolcini <francesco.dolcini@toradex.com>
> > 
> > Add additional machines that requires communication to the SC firmware
> > to set the GPR bit required for stop mode support.
> > 
> > NXP i.MX8DX (fsl,imx8dx) is a low end version of i.MX8QXP (fsl,imx8qxp),
> > while NXP i.MX8QP (fsl,imx8qp) is a low end version of i.MX8QM
> > (fsl,imx8qp).
> > 
> > Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Whoops. I missed the destination branch, this is for net-next, sorry.

Please repost next year when net-next reopens.

Thanks
	Andrew

