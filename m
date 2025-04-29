Return-Path: <netdev+bounces-186751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7302CAA0EB0
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 16:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F157844822
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 14:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF1B2D3A60;
	Tue, 29 Apr 2025 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WGVBBsbV"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D22D321B;
	Tue, 29 Apr 2025 14:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745936739; cv=none; b=DpW/miOa/SjbSlaPPbZA18RXrXCdZLa3yfIApdV0VX+EXXahN911WxLdq5DsnJH5/316I5hr1zzGkfcdPxe3t8dpsfMHIEfRgIXI6XpbalsRc4oPgmyQPW6Zw2UD2bzHVBoAjSoxVrB9VZqO+jTTyYTK5VOdyYCMX0QyO3/mCZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745936739; c=relaxed/simple;
	bh=L0Bez4zWVrlwauQ1MnYALwpvxMsSNYXYNxE7pfwLXaM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ntDuC91on0h52YqS52y9gwBgeA35aQDWnMbMxGiQ0XMINYCm0BCsfYOin5W75bQGvm2d+8bfrwdlFjXwZAKHHM49QzoUm6lEoTcFQMfa2wAufv6pLOuJX9ucsBfGJAZTMbo/2VhBojWQ2oGGaa8zTDl/t5jTq9nhLC2oyxYCiqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=WGVBBsbV; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0vA9Rec61rX04rxqvUMiHk6ImQ7asJ7mfPfkjKKAiA8=; b=WGVBBsbVVEPSajhc0uRNknEfrv
	pZGzepnQDbgwUi1ty4f7yqdC5CDC5Tq1kLehk6qqejbN9+/st2TkhJpOugwvF13Lad67bGme2ryg0
	MVDlg0cTXX6sjbvWvEbClJkIOEa9c5/b2pvNGF/ILuMcRV0ruFfpQ7B2Yzjf3jhf3DnAwfaKboYGc
	G9PKsqZMtpKcEVtAXBkb0ju9wQbmoS2bCrNTjyKSLQZZRNklP/KrlN87NpGY9/vFQktt+7xr7KwLd
	bU/nx6/NnB+JXKb6m4/tWCzbIA0gVOG96K5zt/mKixdUnw7NpMI/fi16At4iZrUh/VVyc35rMqOfY
	7LJgCnZw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37870)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1u9ltb-0005xf-01;
	Tue, 29 Apr 2025 15:25:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1u9ltV-0006D4-07;
	Tue, 29 Apr 2025 15:25:09 +0100
Date: Tue, 29 Apr 2025 15:25:08 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
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
Message-ID: <aBDhRH2TlyxKmaaW@shell.armlinux.org.uk>
References: <20250429-v6-15-rc3-net-rgmii-delays-v1-1-f52664945741@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250429-v6-15-rc3-net-rgmii-delays-v1-1-f52664945741@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 29, 2025 at 07:55:14AM -0500, Andrew Lunn wrote:
> +# Informative
> +# ===========
> +#
> +# 'phy-modes' & 'phy-connection-type' properties 'rgmii', 'rgmii-id',
> +# 'rgmii-rxid', and 'rgmii-txid' are frequently used wrongly by
> +# developers. This informative section clarifies their usage.
> +#
> +# The RGMII specification requires a 2ns delay between the data and
> +# clock signals on the RGMII bus. How this delay is implemented is not
> +# specified.
> +#
> +# One option is to make the clock traces on the PCB longer than the
> +# data traces. A sufficiently difference in length can provide the 2ns
> +# delay. If both the RX and TX delays are implemented in this manor,

manner

> +# 'rgmii' should be used, so indicating the PCB adds the delays.
> +#
> +# If the PCB does not add these delays via extra long traces,
> +# 'rgmii-id' should be used. Here, 'id' refers to 'internal delay',
> +# where either the MAC or PHY adds the delay.
> +#
> +# If only one of the two delays are implemented via extra long clock
> +# lines, either 'rgmii-rxid' or 'rgmii-txid' should be used,
> +# indicating the MAC or PHY should implement one of the delays
> +# internally, while the PCB implements the other delay.
> +#
> +# Device Tree describes hardware, and in this case, it describes the
> +# PCB between the MAC and the PHY, if the PCB implements delays or
> +# not.
> +#
> +# In practice, very few PCBs make use of extra long clock lines. Hence
> +# any RGMII phy mode other than 'rgmii-id' is probably wrong, and is
> +# unlikely to be accepted during review.

Maybe add "without details provided in the commit description."

> +#
> +# When the PCB does not implement the delays, the MAC or PHY must.  As
> +# such, this is software configuration, and so not described in Device
> +# Tree.
> +#
> +# The following describes how Linux implements the configuration of
> +# the MAC and PHY to add these delays when the PCB does not. As stated
> +# above, developers often get this wrong, and the aim of this section
> +# is reduce the frequency of these errors by Linux developers. Other
> +# users of the Device Tree may implement it differently, and still be
> +# consistent with both the normative and informative description
> +# above.
> +#
> +# By default in Linux, the MAC is expected to read the 'phy-mode' from
> +# Device Tree, not implement any delays, and pass the value to the
> +# PHY.

I'd suggest "By default in Linux, when using phylib/phylink, "... as
we do have MACs that do not use phylib but talk to the PHY, and may be
cross-platform drivers that follow some other methodology.

> The PHY will then implement delays as specified by the
> +# 'phy-mode'. The PHY should always be reconfigured to implement the
> +# needed delays, replacing any setting performed by strapping or the
> +# bootloader, etc.
> +#
> +# Experience to date is that all PHYs which implement RGMII also
> +# implement the ability to add or not add the needed delays. Hence
> +# this default is expected to work in all cases. Ignoring this default
> +# is likely to be questioned by Reviews, and require a strong argument
> +# to be accepted.
> +#
> +# There are a small number of cases where the MAC has hard coded
> +# delays which cannot be disabled. The 'phy-mode' only describes the
> +# PCB.  The inability to disable the delays in the MAC does not change
> +# the meaning of 'phy-mode'. It does however mean that a 'phy-mode' of
> +# 'rgmii' is now invalid, it cannot be supported, since both the PCB
> +# and the MAC and PHY adding delays cannot result in a functional
> +# link. Thus the MAC should report a fatal error for any modes which
> +# cannot be supported. When the MAC implements the delay, it must
> +# ensure that the PHY does not also implement the same delay. So it
> +# must modify the phy-mode it passes to the PHY, removing the delay it
> +# has added. Failure to remove the delay will result in a
> +# non-functioning link.
> +#
> +# Sometimes there is a need to fine tune the delays. Often the MAC or
> +# PHY can perform this fine tuning. In the MAC node, the Device Tree
> +# properties 'rx-internal-delay-ps' and 'tx-internal-delay-ps' should
> +# be used to indicate fine tuning performed by the MAC. The values
> +# expected here are small. A value of 2000ps, i.e 2ns, and a phy-mode
> +# of 'rgmii' will not be accepted by Reviewers.
> +#
> +# If the PHY is to perform fine tuning, the properties
> +# 'rx-internal-delay-ps' and 'tx-internal-delay-ps' in the PHY node
> +# should be used. When the PHY is implementing delays, these
> +# properties should have a value near to 2000ps.

... according to the phy-mode used (as they're documented to be
dependent on that.)

I'm wondering whether they should be dependent on which rgmii-* mode
is being used, as delays << 2ns could be used to finely adjust the
PCB delays if the PHY supports that. I haven't looked closely enough
at PHY datasheets to know whether that's possible or not though.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

