Return-Path: <netdev+bounces-165541-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B59A3273E
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 14:38:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 501773A788D
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 13:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF6720E326;
	Wed, 12 Feb 2025 13:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="Rb5JAqXu"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1078120B7F4;
	Wed, 12 Feb 2025 13:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739367523; cv=none; b=Zo2dXz0W3mrhCjlH1hWNUqDwHIuJdvRBKzvibtlF8RHPsd68FJfUPj4Xlxq0dKh8gOzDvcKw5/6jfWUVYf9vYwxVDSQA1ZNWhdwPES0xSopf3zNQZEUHjwV5F/5CjYb7ekbDoYTHJMDbCkuyomf9FtTwCikYo8dp5tkpWCAVslQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739367523; c=relaxed/simple;
	bh=KgcoiEkTt6cHBFU6+0AYeRw+2sU3rQ2mobXhCmsB1aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JGQ+CIvtP4dk5RPwRV/AGpDe5Yq9R6pz3ana3T6YYnPsO4DBobOvRIugJsJpyx4j0bmzcG/K4TmaSuDqxvO/ojNme19Ul91Kk9hZQBlgccjPCN4VRGjJ+0ogiijg6GVFoXz54BC99P4lczgk84Uig5qxWg+rCVm9cyLfWiE3wDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=Rb5JAqXu; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FfHTHmD48ap4AAuhHkzDDEmp5+Gy2+Bv7iyUjekfXBI=; b=Rb5JAqXuomlg6Nrl+bnm37EGOF
	pVh7Vxtci1L7tHaUnbXZEtzz1zNrOuYZlaiQUHZdYWPCodQw8HhLtHbZTLgHPDcAM/vfbfSG1zHn4
	7krDExbRGq0mlIslvFyzKoKr4Y07hxIvC1Ehdf59l0juxt8vDNZdkyn0JnKzY9dkppuv95/RDxhWc
	4kVrxHTZ9dgBMsxqBw7ido/wpiheV3O1yCAY2yGHVphsC1dU696nviDfGWpuYa9BcX/JhJwYLStcY
	s71hnB+5h1bpLSkdiW6LItdU2IBZVJ5YpD79SLfWPS/+7cRXpH9LLDHBrLBrExHPSqAMFKqxtaMQn
	KoolO6lw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52138)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tiCwT-00064G-3B;
	Wed, 12 Feb 2025 13:38:18 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tiCwP-00019n-10;
	Wed, 12 Feb 2025 13:38:13 +0000
Date: Wed, 12 Feb 2025 13:38:13 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: dimitri.fedrau@liebherr.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Dimitri Fedrau <dima.fedrau@gmail.com>
Subject: Re: [PATCH net-next v4 1/3] dt-bindings: net: ethernet-phy: add
 property tx-amplitude-100base-tx-percent
Message-ID: <Z6ykRRBXo4tac6XQ@shell.armlinux.org.uk>
References: <20250211-dp83822-tx-swing-v4-0-1e8ebd71ad54@liebherr.com>
 <20250211-dp83822-tx-swing-v4-1-1e8ebd71ad54@liebherr.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250211-dp83822-tx-swing-v4-1-1e8ebd71ad54@liebherr.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Feb 11, 2025 at 09:33:47AM +0100, Dimitri Fedrau via B4 Relay wrote:
> @@ -232,6 +232,12 @@ properties:
>        PHY's that have configurable TX internal delays. If this property is
>        present then the PHY applies the TX delay.
>  
> +  tx-amplitude-100base-tx-percent:
> +    description:
> +      Transmit amplitude gain applied for 100BASE-TX. When omitted, the PHYs
> +      default will be left as is.
> +    default: 100
> +

This should mention what the reference is - so 100% is 100% of what (it
would be the 802.3 specified 100BASE-TX level, but it should make that
clear.)

I'm having a hard time trying to find its specification in 802.3, so
maybe a reference to where it can be found would be useful, otherwise
it's unclear what one gets for "100%".

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

