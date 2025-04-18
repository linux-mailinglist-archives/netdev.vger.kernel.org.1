Return-Path: <netdev+bounces-184226-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA68A93F0D
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 22:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24C658A7DB7
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 20:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D270222E402;
	Fri, 18 Apr 2025 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cJJTnzWb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DC521127E;
	Fri, 18 Apr 2025 20:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745009350; cv=none; b=l27D5PFhfPQoKc2WmZw76+1TJR8lrKZTMKB67k/wPtmytetQK/TuE0XqZBSo8qTSVm9AIg3O5vsqqJpJRy4a1yjRWioV3OklYBi0DOxVjz4JHsAdMRbDGoeDqbMGAPR3slOFlpgTO8tVC+hvbNQmyVi3FIDsEKdeMRzLdS4HjOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745009350; c=relaxed/simple;
	bh=IDXLCWhe3B9fOmtjZw3mD4GasXsPcTYWgh1iEMR39vk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bc2x/k5IOE2/ZhOnwp2xCFzq5G69SW0w1Cn3bConApSBm6GIjaoo+60piH0HqV3lVyYVWgH2jPLllpYUuyuaG4NUM1kYKdXlf5i5r5qlTBpiwOpVF+w3ZPBDfXF14J99hRaeLe/ep7GiluW+Z5sUh7gx+IQaLR/W3RiknGAhWeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cJJTnzWb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=v26kdZJuDullQdaeIF02DAn4bkJ0oZUrA6h5X1L9724=; b=cJJTnzWbpGOGLdjntuuBlONbCO
	PObxKf6qSECUeqVv9ArshIVoxarXkz2EDiFQMRWINZOh3Jkbp3lzE9y+EbZm06SEp+FCtd+Qpbr/C
	O1IwwnSTyqRr7nBcCc2cbQSnF0Yf1d87e1ZuDO22/8GSrHtFWy0RuVCQtO6zAC20bdwA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u5sdr-009wIw-Ic; Fri, 18 Apr 2025 22:48:55 +0200
Date: Fri, 18 Apr 2025 22:48:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andy Whitcroft <apw@canonical.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>, Jonathan Corbet <corbet@lwn.net>,
	Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next 2/4] dt-bindings: net: ti: k3-am654-cpsw-nuss:
 update phy-mode in example
Message-ID: <2cf14499-6ce8-42e0-98bb-3669aa0ed1fe@lunn.ch>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <4216050f7b33ce4e5ce54f32023ec6ce093bd83c.1744710099.git.matthias.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4216050f7b33ce4e5ce54f32023ec6ce093bd83c.1744710099.git.matthias.schiffer@ew.tq-group.com>

On Tue, Apr 15, 2025 at 12:18:02PM +0200, Matthias Schiffer wrote:
> k3-am65-cpsw-nuss controllers have a fixed internal TX delay, so RXID
> mode is not actually possible and will result in a warning from the
> driver going forward.
> 
> Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
> ---
>  .../devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml          | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> index b11894fbaec47..c8128b8ca74fb 100644
> --- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> +++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
> @@ -282,7 +282,7 @@ examples:
>                      ti,syscon-efuse = <&mcu_conf 0x200>;
>                      phys = <&phy_gmii_sel 1>;
>  
> -                    phy-mode = "rgmii-rxid";
> +                    phy-mode = "rgmii-id";

It would be good to enforce the phy-modes which are valid, which i
think are:

        case PHY_INTERFACE_MODE_RGMII_ID:
        case PHY_INTERFACE_MODE_RGMII_TXID:
        case PHY_INTERFACE_MODE_RMII:
        case PHY_INTERFACE_MODE_QSGMII:
        case PHY_INTERFACE_MODE_SGMII:
        case PHY_INTERFACE_MODE_USXGMII:

Anyway, this can be a follow up patch, it should not block this
patchset.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

