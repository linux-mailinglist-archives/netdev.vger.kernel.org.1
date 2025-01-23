Return-Path: <netdev+bounces-160606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F77DA1A7DD
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 17:31:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D29BF16699A
	for <lists+netdev@lfdr.de>; Thu, 23 Jan 2025 16:31:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476A220F98F;
	Thu, 23 Jan 2025 16:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="FY0aipgK"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86BD86F06B;
	Thu, 23 Jan 2025 16:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737649891; cv=none; b=BQkQ9bdUksOQH5UbyDACXKbQzkt73wCi2iJwuojY20dTyit0HWPZo7x7rFXI82gM/1KN4iSWCHZLUvM3u+XeYQlRav4gCbJCoHoZme6YNdGnnaDMGwLPsh12VHMM3h4GGLp8aCNzjDUn4mh30rocID3za7XVUzBkMFTzFWPopBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737649891; c=relaxed/simple;
	bh=D15n46f1Q3wlESWusCwvBFwrdpQH/omyDrFSqaWDm0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LknWkcjuPX6GIIy3v3y1+ceJDsl7Itk85YczH0vMaI06OSgU8FNYxaQJtsYOKlwpNh1i5Z+u4GioHcrHNVKU9jGWHV+BR5IsfMVwlwa/La9aikJ2ThHi+PEMWChYq5Upe61Y4nz6soNW5qrwN6d5TG0nJahW2QElGx458FwHDQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=FY0aipgK; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=aJA4g42En+uawhKwJGlWNJO+UAjw8o7TK6oQsEIEysw=; b=FY0aipgKoz6hdW9JmVzyeCWzs2
	JDQrGtiEjokG0h0MAqwdRltMqbjsiTBI9wAkNypiJnZx5SQ4PLQ/UHEKu7hrmiKPTF1Nx2l0vbbo2
	iYXBhJQ7arITeTtpl/QqVDfCYBOv9F6FGKYwwUelCHzRL7koyrGsN5ZKQgLjfx8dOS7XZdLlodnZq
	jRSUtSD3YiFO9hranwGYWMSxO3k8lx9yy+8x/ejZZ4Wv2H4X4C9TRx90lydy/m5OvQxZftaplUsIl
	wyne/41MJBGeXP4T7iXjDe9ZWKoq6XxxOkOR6zgkxo5kqyWG1/c1ueqvV7Jed3KMqaMyM5WZ76N4O
	Roaak0rw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:36832)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tb06u-0001HN-2h;
	Thu, 23 Jan 2025 16:31:16 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tb06q-000659-1t;
	Thu, 23 Jan 2025 16:31:12 +0000
Date: Thu, 23 Jan 2025 16:31:12 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Furong Xu <0x1207@gmail.com>, Joao Pinto <Joao.Pinto@synopsys.com>,
	Vince Bridgers <vbridger@opensource.altera.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/3] Limit devicetree parameters to hardware
 capability
Message-ID: <Z5Ju0DtNDwj_hO0F@shell.armlinux.org.uk>
References: <20250121044138.2883912-1-hayashi.kunihiko@socionext.com>
 <Z492Mvw-BxLBR1eZ@shell.armlinux.org.uk>
 <ea845c58-ee2a-4660-bc13-7e05003de5d0@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea845c58-ee2a-4660-bc13-7e05003de5d0@socionext.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jan 23, 2025 at 02:25:15PM +0900, Kunihiko Hayashi wrote:
> Hi Russell,
> 
> Thank you for your comment.
> 
> On 2025/01/21 19:25, Russell King (Oracle) wrote:
> > On Tue, Jan 21, 2025 at 01:41:35PM +0900, Kunihiko Hayashi wrote:
> > > This series includes patches that checks the devicetree properties,
> > > the number of MTL queues and FIFO size values, and if these specified
> > > values exceed the value contained in the hardware capabilities, limit to
> > > the values from the capabilities.
> > > 
> > > And this sets hardware capability values if FIFO sizes are not specified
> > > and removes redundant lines.
> > 
> > I think you also indeed to explain why (and possibly understand) - if
> > there are hardware capabilities that describe these parameters - it has
> > been necessary to have them in firmware as well.
> > 
> > There are two scenarios I can think of why these would be duplicated:
> > 
> > 1. firmware/platform capabilities are there to correct wrong values
> >     provided by the hardware.
> > 2. firmware/platform capabilities are there to reduce the parameters
> >     below hardware maximums.
> > 
> > Which it is affects whether your patch is correct or not, and thus needs
> > to be mentioned.
> 
> I think scenario 2 applies in this case.

In light of my other reply
(https://lore.kernel.org/r/Z4_ZilVFKacuAUE8@shell.armlinux.org.uk) I
don't think either of my two above applies, and the driver is designed
to allow platform code to override the hardware value, or to provide
the value if there is no hardware value.

My suggestion, therefore, would be (e.g.):

	if (priv->dma_cap.rx_fifo_size &&
	    priv->plat->rx_fifo_size > priv->dma_cap.rx_fifo_size) {
		dev_warn(priv->device,
			 "Rx FIFO size exceeds dma capability (%d)\n",
			 priv->plat->rx_fifo_size);
		priv->plat->rx_fifo_size = priv->dma_cap.rx_fifo_size;
	}

if we still want to limit it to the hardware provided capability, where
that is provided.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

