Return-Path: <netdev+bounces-128581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DBA97A751
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 20:31:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B34D1C20CA8
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 18:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DAD38FA1;
	Mon, 16 Sep 2024 18:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Ws0IBRiw"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97835F4E7;
	Mon, 16 Sep 2024 18:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726511457; cv=none; b=gpLY/1B9cJ+S71SdNo+6/oWZgHS0JuJDL0wjUanAqddE79lKrhfkJpq6HX+0Vr0YWk9rj4+43cOb3run8H8pPs2P2BAhj/Ktl77HlsNzVOx4eF9+Q+pIzWClYdEmTFGzh5X4sAN0pgyMzYKhFKUyvRG1J85r6GsXmHGA72DV8Vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726511457; c=relaxed/simple;
	bh=DUd9WcMz0N6JqUgYIGzGsLNpdYVvSRcA8Vy4FpWVLHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4DSJeFWyKoooxzoURp5pacdoJxE779izTenMRLuSwBTfNfKqJcwKRNmm4xuss4+mCpl52dGObQqApvbDXI1OUiNXR67T7UifjlFRsiRw7PH6ZwgoLvvEjkLs/BIeS/tkaEYcfCyJo9isUIXOAeeYgiqrjq32jWVdgkxpvRjlx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Ws0IBRiw; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=gAyI006SWlMSA59v//aeZLYRYdSo+/9azsJe9J8yl9Q=; b=Ws0IBRiw+dNalAZsQYhyl/kj7l
	t69xyNCDPJRx5g0Vws3fEgIn4TrF5hPzXY5NJFv8SxieG7c2BhVYtMnIjweuOoA5MBQxkcdLEA0hv
	PujIqfL6EV5xnBy4HQArVMFjb3NWuWpSbJVkJC24iCI/VoSsyWR9tzjZhFrpGyVVy9fpnqRP4VDW4
	JJJO1YsA2bNEs5Z2unflfVxzbahkemKsMh6LVUpvyi4TzMv/830pfVD8aMUU3n192BxSgKpCIf0XE
	TPvap8mGoz3zMkyMX4Ee7rY50jE2l47md5hnhmi00XCXWAGvMtIMAUgIgVa/WXMLeJ3MmqNo2kbri
	rVv7RTrA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52784)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sqGUq-0006Ha-1I;
	Mon, 16 Sep 2024 19:30:48 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sqGUm-0007BQ-1C;
	Mon, 16 Sep 2024 19:30:44 +0100
Date: Mon, 16 Sep 2024 19:30:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com, maxime.chevallier@bootlin.com,
	rdunlap@infradead.org, andrew@lunn.ch, Steen.Hegelund@microchip.com,
	daniel.machon@microchip.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next V2 1/5] net: lan743x: Add SFP support check flag
Message-ID: <Zuh5VDvnwx868Iqx@shell.armlinux.org.uk>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-2-Raju.Lakkaraju@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911161054.4494-2-Raju.Lakkaraju@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Sep 11, 2024 at 09:40:50PM +0530, Raju Lakkaraju wrote:
>  {
> -	u32 chip_rev;
> +	u32 fpga_rev;
>  	u32 cfg_load;
>  	u32 hw_cfg;
>  	u32 strap;

...

>  	} else {
> -		chip_rev = lan743x_csr_read(adapter, FPGA_REV);
> -		if (chip_rev) {
> -			if (chip_rev & FPGA_SGMII_OP)
> +		fpga_rev = lan743x_csr_read(adapter, FPGA_REV);
> +		if (fpga_rev) {
> +			if (fpga_rev & FPGA_SGMII_OP)

This looks like an unrelated change.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

