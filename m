Return-Path: <netdev+bounces-181991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE5AA8747C
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 00:41:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35D24168D3C
	for <lists+netdev@lfdr.de>; Sun, 13 Apr 2025 22:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71DCD18C930;
	Sun, 13 Apr 2025 22:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="MIKCdwdT"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C79DB5674E
	for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 22:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744584057; cv=none; b=NVCqnJ6wLTxqk+gBn2eyJ4X2sIOSSu0ByNME/uedAOZBOZmEAvZ27y72lmF18zv+CEcqmJ4GZxHYOk0DlH7BXRf9UjCvhNNXe8iamYeYhzQn/Ul57zjP+CWG3tsX4yfPpGv/JcZqHhifwzr1LACYWoo3HBJ3RKPECdlO85OLhcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744584057; c=relaxed/simple;
	bh=mTciRUiCc02Z6hwxoBv+s/F5gx/tWEtihBHNt/9NrA8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxECR9TtRqfEn/InnT6Y/eyOS/Va+GIaU7QNrnUpzKw+yXzGK3PjtiQSaG3HP59ex7ZBe+wtOHEs1j3Wz/4xctz0yocGd3NV9Oj9HaoqczlLq0/Yva70mAPYIjBE+df8ktIvwrP5cvimtBMtUkmbDZenQFvfQ3G5FIYnll0xJb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=MIKCdwdT; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=yZKPPgLOnaA6LtXNLTqGU/0863A2eFjmUO8YRdkWJA4=; b=MIKCdwdTxzfm3nfeLK8y3tQrPx
	GMWv72wuecKr72/MAFovpO4qbGD8I8Cg87KO745HF+Dl2ZGdoRMUpfuvoSf6yXBRRTe2iQkYFgt5N
	gTgOojG7ShUf0rqNK0xgzGqV98HMv0Wt5sUzlFYynzlhBnuxaPq71cYgyT1uzoplz+w3uIh01v9l4
	Hf2qzDPOtxo34Of4kFQtbMgRdoq3O3qk5twXCMkm/hToxF3aPri/nuuO9fb0Jj1t/0F2VYhb9hTVd
	Hb/QX10GHmk4NCgEVTuuwwgMFo4aVF5HPtRgGMvY1wZFwnOZFqbArFnPzIXNymN4kx2OdP1MDtbnB
	RlZiSjtA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42456)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u460K-0005hA-0X;
	Sun, 13 Apr 2025 23:40:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u460G-00072n-0w;
	Sun, 13 Apr 2025 23:40:40 +0100
Date: Sun, 13 Apr 2025 23:40:40 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 4/4] net: stmmac: anarion: use
 devm_stmmac_pltfr_probe()
Message-ID: <Z_w9aE62dqOdr4w9@shell.armlinux.org.uk>
References: <Z_p16taXJ1sOo4Ws@shell.armlinux.org.uk>
 <E1u3bfU-000Em3-Mh@rmk-PC.armlinux.org.uk>
 <acd537c9-51f2-4d5c-a07d-032ea628d241@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acd537c9-51f2-4d5c-a07d-032ea628d241@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sun, Apr 13, 2025 at 11:10:24PM +0200, Andrew Lunn wrote:
> On Sat, Apr 12, 2025 at 03:17:12PM +0100, Russell King (Oracle) wrote:
> > Convert anarion to use devm_stmmac_pltfr_probe() which allows the
> > removal of an explicit call to stmmac_pltfr_remove().
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks - but nipa found an error in the patch - s/&pdev->dev/pdev/
with the new call. Ditto for "net: stmmac: anarion: use
stmmac_pltfr_probe()" so I'll be sending a v2 for both. Do you
want me to keep your r-b with that change for both patches?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

