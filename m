Return-Path: <netdev+bounces-102074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9558B90158A
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 12:34:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3A3E21F212BA
	for <lists+netdev@lfdr.de>; Sun,  9 Jun 2024 10:34:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8745620B33;
	Sun,  9 Jun 2024 10:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="W1Aw8BiC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB755B65E
	for <netdev@vger.kernel.org>; Sun,  9 Jun 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717929287; cv=none; b=aJUqo61MuVvCrlyhBOy7IYLktapquTqf3hPASvgVLnQLfdFInYwMcsUlzE/65nlnVHQd5YxORWRWM4R6PczimID+xo+8vpOpEYN+g2lZ6CN3ST5QWBWBJCsih5dGAAdPuiZD4eothc3NSjD/0P+N+U1lNqK4yH8gJqirGOnPgKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717929287; c=relaxed/simple;
	bh=SDoZSez7Y+K/BBQCvO6xJkuWJ3v2hXTNv3SBVvsPjGo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FIQ4MGay00C+7Xf3h9DS8A1ACV0E1ckk7NpjqgCi58t8j5QAbEmLhhyjmFQeX2c3b+FtKIXHVve1bSRMXv6yU7WGEK0hm4xkbiRTB38v8proaCj01710BRdlA9TDBr+b0Bio9S2hlVfUAWt8hx1UZKhAXH58bky1UUOXlYzB3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=W1Aw8BiC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=7CYQvWtyUu2WhQUKzyRn/qQoFWT4tGvIr+hLmncgYIs=; b=W1Aw8BiCB8DWE+d2BaFnBCbqh7
	lAotIAvP4vlzxJ4BvAnL0gopsE5ai4ARz35Za1UH1dAE7RXvZqGcLDuevsHQ1n5X4iI6Y7jBUj0zs
	RG9he47THI18BptpuhU27OE42mp+bJeT+BZiJaOZnWJxNtT4getuasnOG2qaB2YuL/Ifa2BB5fm2Z
	hEgGU9MzUbgXrLKVy/1+vhZEu/3BZjY0FgKUKXBn8eN0HQzkSjTs6ZcH/pm9YTtLXRp89NpAX96tr
	xaBEVd1sBvu4oVmWOzaf5EJYoxov+04H0+3DT+YqM8PfsvfLb9/ulAgI0wrG62Hq8uUDm+oyKcy65
	pEI3cIHQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:56618)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1sGFsa-0000Qj-1P;
	Sun, 09 Jun 2024 11:34:28 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1sGFsa-0005sk-7d; Sun, 09 Jun 2024 11:34:28 +0100
Date: Sun, 9 Jun 2024 11:34:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, horms@kernel.org,
	kuba@kernel.org, jiri@resnulli.us, pabeni@redhat.com,
	hfdevel@gmx.net, naveenm@marvell.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v9 6/6] net: tn40xx: add phylink support
Message-ID: <ZmWFNATfPWEPSLyf@shell.armlinux.org.uk>
References: <20240605232608.65471-1-fujita.tomonori@gmail.com>
 <20240605232608.65471-7-fujita.tomonori@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605232608.65471-7-fujita.tomonori@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Jun 06, 2024 at 08:26:08AM +0900, FUJITA Tomonori wrote:
> @@ -1670,6 +1681,12 @@ static int tn40_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
>  		goto err_unset_drvdata;
>  	}
>  
> +	ret = tn40_mdiobus_init(priv);
> +	if (ret) {
> +		dev_err(&pdev->dev, "failed to initialize mdio bus.\n");
> +		goto err_free_irq;
> +	}
> +
...
> +err_unregister_phydev:
> +	tn40_phy_unregister(priv);
>  err_free_irq:
>  	pci_free_irq_vectors(pdev);
>  err_unset_drvdata:

and from previous patches:

+       pci_set_drvdata(pdev, NULL);
+err_iounmap:
+       iounmap(regs);
+err_free_regions:
+       pci_release_regions(pdev);
+err_disable_device:
+       pci_disable_device(pdev);
+       return ret;
+}

So, if tn40_mdiobus_init() returns non-zero, this value will be returned
to higher kernel levels via tn40_probe().

...
> +int tn40_phy_register(struct tn40_priv *priv)
> +{
> +	struct phylink_config *config;
> +	struct phy_device *phydev;
> +	struct phylink *phylink;
> +
> +	phydev = phy_find_first(priv->mdio);
> +	if (!phydev) {
> +		dev_err(&priv->pdev->dev, "PHY isn't found\n");
> +		return -1;

And my email client, setup with rules to catch common programming
mistakes, highlights the above line. I have no idea why people do
this... why people think "lets return -1 on error". It seems to be
a very common pattern... but it's utterly wrong. -1 is -EPERM, aka
"Operation not permitted". This is not what you mean here. Please
return a more suitable negative errno symbol... and please refrain
from using "return -1" in kernel code.

(The only case where "return -1" may be permissible is where the
value doesn't get propagated outside of the compilation unit, but
even there, there is the possibility that later changes may end
up propagating it outside... personally, I would like to see
"return -1" totally banned from the kernel.)

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

