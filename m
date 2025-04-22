Return-Path: <netdev+bounces-184560-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2D5A96381
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 11:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B371117FCAB
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 08:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47132256C9F;
	Tue, 22 Apr 2025 08:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="dhUS5N9/"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F43256C8D;
	Tue, 22 Apr 2025 08:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745312180; cv=none; b=GBFq3yM83B/4dH8ULcjsXQpa6l4CDdhrSCiM8a6sOGA9CizhwmyaPZlcc7H+2k4bOdEDFWgABJ4JxHUZ78dwyJw50jJ2QAgDtASvNT+3EXMyFp1ndwLl5q2nEsdoLrDylGXn1z6RmOJ4uYNFfkPi3VN+Hqm1cwI/TbIpJEDd+B4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745312180; c=relaxed/simple;
	bh=TpKXeLZ7Fi+2qay5P5RV1UBl1jpJkvwlMTQnMA8coUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bh3kzWzrYxH5X0UCFf5CFAsIRDvdni2qJPxDNqI37TQjq+8ZtGoj6WI4DjLjfkrfXHSoy+e/YkEGXSCBn9G8tpC5OtLJtbKlCghcAEd5CJ3R16lZFztSc76fGtJT2KLcCYfRna7glF5n8HHbEG03G0nPoAm0VIaAcPSSW3ANkPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=dhUS5N9/; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EoAqUPC7IVwxmkA7v4AtUYOCTo2JDd0ZDzX1gHoE3Oo=; b=dhUS5N9/CZazvrG6bBoCPIiULc
	RP+iML0Sv+6n2QvgRsCZEBAzY10DbxiZboYDTZg+prGbs17egcc8U61xixAmlp3HPmhhTdzP70Y4K
	gxPwb3ynSQGCwepoG0/FfSmUlObNynI4+jq+O9GpuNCSVrfxqwkTo+ckrpydKAHSjx/yvE5xY5eCe
	A6xVEI97qgYY8XMclRHmTmMocOgiE2iJvzO8kGfMfN6s6b+mYNlv/q37/Kx9wcxtq169tSCONMK/c
	HHyIZADGB/5CJPmiQtaFkzXiOATDTJftaHvDkn7I7lxDxsn7AMvagAVqFzcY2SBAPCwTmSal4nXcj
	K4E0b1iQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:39526)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u79QC-00044U-0b;
	Tue, 22 Apr 2025 09:56:04 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u79Q8-0007Ll-1n;
	Tue, 22 Apr 2025 09:56:00 +0100
Date: Tue, 22 Apr 2025 09:56:00 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Roger Quadros <rogerq@kernel.org>, Tero Kristo <kristo@kernel.org>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux@ew.tq-group.com
Subject: Re: [PATCH net-next 1/4] dt-bindings: net: ethernet-controller:
 update descriptions of RGMII modes
Message-ID: <aAdZoMge_CKtqokU@shell.armlinux.org.uk>
References: <cover.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <218a27ae2b2ef2db53fdb3573b58229659db65f9.1744710099.git.matthias.schiffer@ew.tq-group.com>
 <6be3bdbe-e87e-4e83-9847-54e52984c645@ti.com>
 <cd483b43465d6e50b75f0b11d0fae57251cdc3db.camel@ew.tq-group.com>
 <5d74d4b2-f442-4cb8-910e-cb1cc7eb2b3d@ti.com>
 <b53fba84c8435859a40288f3a12db40685b8863a.camel@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b53fba84c8435859a40288f3a12db40685b8863a.camel@ew.tq-group.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Wed, Apr 16, 2025 at 09:41:57AM +0200, Matthias Schiffer wrote:
> Also note that (as I understand it) I'm not changing anything, I'm updating the
> documentation to reflect what has been the intended behavior already. Please see
> the previous discussion with Andrew that I linked, where he convinced me that
> this is the correct approach.

I think you are as I stated in my email yesterday. The use of "MAC or
PHY" in your new descriptions opens avenues for confusion such as the
scenarios that I described in yesterday's email.

> Andrew specifically asked to leave it open in the DT bindings whether MAC
> or PHY add the delay, and it might differ between drivers (and different
> operating systems using the same Device Tree).

I'm hoping that Andrew will read my email form yesterday and reconsider
because to me this is a backwards step - it doesn't solve the problem
with unclear documentation. I believe it makes the problem worse, and
will lead to more bugs and misunderstandings in this area.

> Whether the MAC should add a required delay in cases where it's configurable
> is an interesting question - not one of the Device Tree bindings, but of
> driver implementation.

Where Andrew gets this from are MAC drivers that detect the rgmii-*id
modes, apply the delay at the MAC, and then convert the value passed to
phylib to PHY_INTERFACE_MODE_RGMII. This is a load of additional special
handling in the MAC driver, and I'd say it's "advanced" usage and takes
more time to review. It's open to mistakes without review by those who
know this "trick", and the chances of phylib maintainers being Cc'd on
MAC drivers is pretty low.

So, I don't think it's something we want to be generally encouraging,
but instead the more normal "phy-mode describes the phy_interface_mode_t
that is passed to phylib" and only allow the "advanced" case in
exceptional cases.

> On Linux, there currently isn't a way for the MAC driver to query from the PHY
> whether it could include the delays itself. My assumption is that most PHYs
> either don't have internal delays, or the delays are configurable.

motorcomm, dp83tg720, icplus, marvell, dp 838678, adin, micrel, tja11xx,
vitesse, dp83822, mscc, at803x, microchip_t1, broadcom, dp83869,
intel-xway, realtek all do handle internal delays. I haven't checked
whether there are PHYs that don't - that's harder because we don't know
whether PHYs that don't mention RGMII in the driver actually support
RGMII or not.

> If this is
> the case, having the MAC add them in internal-delay modes and not adding them on
> the PHY side would be the best default (also for PHY-less/fixed-link setups,
> which should be handled like a PHY without internal delay capabilities.)

See my "advanced" use case above. We do have drivers doing that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

