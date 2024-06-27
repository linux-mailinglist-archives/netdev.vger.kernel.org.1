Return-Path: <netdev+bounces-107259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D77FD91A746
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 15:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 145071C211D0
	for <lists+netdev@lfdr.de>; Thu, 27 Jun 2024 13:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BAB186E54;
	Thu, 27 Jun 2024 13:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="QuP4ockh"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67DDB13F00A;
	Thu, 27 Jun 2024 13:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719493649; cv=none; b=dFRu+dOmIEF7TF9lzalZqmG9JGj5pYCgzG6gRqGVcjfUEkc8NEaicjZxBlQ5+XU6Yy0OToVUY2r3Hhite4Oh/5xEQ7L4NhzJ6LXw4BqA4Lbmvt6JJdWwJQCwWsjiMMWuL72aeJz+MTxwBAW9w68fL2N/bCMhzZNSYQszyu5EZZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719493649; c=relaxed/simple;
	bh=4eqenzlDJJmiVegcLr50fZF1d8Jb+JeLIA2EruftpKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2JdyUqJXzMiHQdEu2v1/WepD/dcj/PmF8iNlJdhGgPU7+ifQQYyLe8wOzaI88nx0/i2WA3/Tm2bFJD6cElVWkODSiJGvJk1uKxqo6mS/FeWgjBwvctl5EofVUruYNr/nfG5rlce2ZYT1z21eYDeXicsMXDZZhrmr+hvfpzG6cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=QuP4ockh; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=XGLNCYj2BJRifwhxF86lhSp/yOk3DKS/Y+1DL0OAdQg=; b=QuP4ockh5YHBLYEwoZj5NEqkIO
	QPRhs52wNmvvHeJEHgbxO64j9wBMvrt19XSNBvOz8cfXE+lF/iCh0oIBZhjaEPaE/KRv0u1iH416Y
	S2oqly8fxynQd0MWSisU9i8Ptt73hMgEM+MFfAbzVi+0URiVktRSWCX+O0mPsKNz71Vk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sMoq5-0019vg-3G; Thu, 27 Jun 2024 15:07:01 +0200
Date: Thu, 27 Jun 2024 15:07:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Serge Semin <fancer.lancer@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Jose Abreu <Jose.Abreu@synopsys.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sagar Cheluvegowda <quic_scheluve@quicinc.com>,
	Abhishek Chauhan <quic_abchauha@quicinc.com>,
	Andrew Halaney <ahalaney@redhat.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Tomer Maimon <tmaimon77@gmail.com>, openbmc@lists.ozlabs.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/10] net: pcs: xpcs: Split up xpcs_create()
 body to sub-functions
Message-ID: <adfbc8c2-f39e-4aee-a879-1ae992689882@lunn.ch>
References: <20240627004142.8106-1-fancer.lancer@gmail.com>
 <20240627004142.8106-3-fancer.lancer@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627004142.8106-3-fancer.lancer@gmail.com>

On Thu, Jun 27, 2024 at 03:41:22AM +0300, Serge Semin wrote:
> As an initial preparation before adding the fwnode-based DW XPCS device
> support let's split the xpcs_create() function code up to a set of the
> small sub-functions. Thus the xpcs_create() implementation will get to
> look simpler and turn to be more coherent. Further updates will just touch
> the new sub-functions a bit: add platform-specific device info, add the
> reference clock getting and enabling.
> 
> The xpcs_create() method will now contain the next static methods calls:
> 
> xpcs_create_data() - create the DW XPCS device descriptor, pre-initialize
> it' fields and increase the mdio device refcount-er;
> 
> xpcs_init_id() - find XPCS ID instance and save it in the device
> descriptor;
> 
> xpcs_init_iface() - find MAC/PCS interface descriptor and perform
> basic initialization specific to it: soft-reset, disable polling.
> 
> The update doesn't imply any semantic change but merely makes the code
> looking simpler and more ready for adding new features support.
> 
> Note the xpcs_destroy() has been moved to being defined below the
> xpcs_create_mdiodev() function as the driver now implies having the
> protagonist-then-antagonist functions definition order.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

