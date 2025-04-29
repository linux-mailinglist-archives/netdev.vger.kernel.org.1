Return-Path: <netdev+bounces-186773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A0FAA106E
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 17:27:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 668677B397B
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 15:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 319DD221DA1;
	Tue, 29 Apr 2025 15:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fi9osQRR"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63AC7221D8B;
	Tue, 29 Apr 2025 15:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745940407; cv=none; b=MhuY4n2K1E94U8kuLBAGzZvBfGtKIeYGaYWvCGSJsPe3TMaM6UUmv9bUBHBiEsq/kGhvbPwcSKmqLHtvXbFdnjmwaEr1DIM3czPyzzRtIbmEqTJO746VTy9/OmSwxqdVHMkAn9rIkfpfPyToHpg+Xn1ZvmkQN0OdG1QJMjZ9n3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745940407; c=relaxed/simple;
	bh=nTH8UfUeo2dOVQ7p0AA8nZBOT1sXEh05Hwz/YzGOoSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ucyn61TQ+DVDIP6oX1bX+t2LRPTaDesppMWJGIoIJ7w4YYEBxMVSuCQZanN0nW+fIlEjNWsExFjFO1CLfkhWtpKgoEFXIb4xDFPFb6HqcylRfpA9kkS9EWO4FkL/XDS8v0C+akMtr4IsPAFZBInAMe8YL9CB74jT8y9xg7WI3mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fi9osQRR; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=/f9THZOQn+1tNgvt8I2ZTq9Z2mlHTRdXjKcrrEcqPdc=; b=fi9osQRR0vdMRwiR+ivU6bGQIy
	Lq1wq6jM/JpBPWYG1Pw3Uu36CzTEszgZYLqvVbqAsXEWhV5/dIudPHkKKWS9fe2CAE1A/6t974b3/
	yr1z2f0kYvYACAhf48W28OaJh3tHdJSkAdu2JnH9t6JTtsQzDvlAruNKav0b0cYJb41w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u9mqo-00AxD6-2x; Tue, 29 Apr 2025 17:26:26 +0200
Date: Tue, 29 Apr 2025 17:26:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Rob Herring <robh@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>,
	Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
	Heiner Kallweit <hkallweit1@gmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] dt-bindings: net: ethernet-controller: Add
 informative text about RGMII delays
Message-ID: <73ffdfe2-ecf2-44e9-8850-c00ed9ff388c@lunn.ch>
References: <20250429-v6-15-rc3-net-rgmii-delays-v1-1-f52664945741@lunn.ch>
 <aBDhRH2TlyxKmaaW@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aBDhRH2TlyxKmaaW@shell.armlinux.org.uk>

> > +# In practice, very few PCBs make use of extra long clock lines. Hence
> > +# any RGMII phy mode other than 'rgmii-id' is probably wrong, and is
> > +# unlikely to be accepted during review.
> 
> Maybe add "without details provided in the commit description."

I was thinking about that. And i would actually prefer a comment in
the DT explicitly saying the PCB adds delays.

> > +# If the PHY is to perform fine tuning, the properties
> > +# 'rx-internal-delay-ps' and 'tx-internal-delay-ps' in the PHY node
> > +# should be used. When the PHY is implementing delays, these
> > +# properties should have a value near to 2000ps.
> 
> ... according to the phy-mode used (as they're documented to be
> dependent on that.)
> 
> I'm wondering whether they should be dependent on which rgmii-* mode
> is being used, as delays << 2ns could be used to finely adjust the
> PCB delays if the PHY supports that. I haven't looked closely enough
> at PHY datasheets to know whether that's possible or not though.

Yes, i was trying to express that with the 'When the PHY is
implementing delays'. If the PHY is not adding delays, 'rgmii', small
fine tuning delays are O.K. And some PHYs do support this, they cover
the full range from 0ps to > 2000ps in steps.

	Andrew

