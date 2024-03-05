Return-Path: <netdev+bounces-77399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 639648718E6
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 10:05:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 200FC284684
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 09:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0ED54FA7;
	Tue,  5 Mar 2024 09:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="SEvDndyk"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F39E50279;
	Tue,  5 Mar 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709629444; cv=none; b=oaYpGTX+Ee6KHXuYtBY704wj5QaqUnmDJXsjlbAJX+QJDJsMMFwpbvveAo0vnQ/MeF+x5qqTGRG6uFiZylERZ7aG8sWxZTcrzKTYByTZFYOvGKkbs5ihqmVfyuqCPcoencNRd/D/g9zgdoBtFsPOLCl8k7J+qc++3RZlQm9Fyks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709629444; c=relaxed/simple;
	bh=SOp8UEtTpkI92FaT1RDybMD/r+ZKN/oCe6E34/zPQ60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EMhkyrSJCEGepyS9vjVcHx9H1wJkx0n5qaMgnWRTJ25g9m79Qetm6EQ8658a0C1jqQjuxLmlsZYbltS2GnwYp6PRRGpa0v+p24wXSjyVH46vaTXm2SdJpltrsrAfz8gsqToX9Wr7AMfpW4GWt2qv2OltrkOIUtI1FxgbBQp0vJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=SEvDndyk; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DuhLg7/tM2vcI1x9/B7XAe9UNSmO9kkOSlMy7Wrm4lE=; b=SEvDndyk/0Jm73NJskq1xbb3Vr
	ihTJ+xCl3pV96RJ76BssFrATefu/9hbL88GToN4OCYPEYu1S56OZiLf0KGDkPbM3oAcUUHqi2Haau
	oKkUG0XRjyTY74LY+ytrlF5EpuTOOb1qCwMhuRa1pfwnCS32baJYftL8+qXTbMvYp/GMzzH9rdyMw
	p9gas7fj0qqbsrI5vxKU4PTNWXrSbxyzUHlUO1sPUL4VHuegNH/pTIgCoy19wBbtTxSWRrwfuA9bX
	qx1MG5t1aqI6ujnVxnsSlCiFJJEBfgxOzUrP++Zer4hzR5B1GrqGRTW3PTNwanLLSRPccVio61dYv
	WWqMKFhQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51668)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rhQi2-0006t8-16;
	Tue, 05 Mar 2024 09:03:38 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rhQhx-0005I6-BR; Tue, 05 Mar 2024 09:03:33 +0000
Date: Tue, 5 Mar 2024 09:03:33 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>,
	Lucien Jheng <lucien.jheng@airoha.com>,
	Zhi-Jun You <hujy652@protonmail.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v2 net-next 2/2] net: phy: air_en8811h: Add the Airoha
 EN8811H PHY driver
Message-ID: <Zebf5UvqWjVyunFU@shell.armlinux.org.uk>
References: <20240302183835.136036-1-ericwouds@gmail.com>
 <20240302183835.136036-3-ericwouds@gmail.com>
 <e056b4ac-fffb-41d9-a357-898e35e6d451@lunn.ch>
 <aeb9f17c-ea94-4362-aeda-7d94c5845462@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aeb9f17c-ea94-4362-aeda-7d94c5845462@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 05, 2024 at 09:19:41AM +0100, Eric Woudstra wrote:
> The main reason I have it in config_init() is that by then the
> rootfs is available. The EN8811H does not depend on the firmware
> to respond to get_features(). It is therefore possible to not
> have the firmware in initramfs or included in the kernel image.
> I could not get this result using EPROBE_DEFER, I think this is
> not an option in phylink.

I think you're slightly confused there. It's not specific to phylink.

It's also not an option when using phy_connect()/phy_connect_direct()
from .ndo_open as well, or looking up the PHY to then use phy_attach()/
phy_attach_direct(). One can structure the code using phylink just
the same way one would structure the code using phylib in this respect.

.ndo_open can't handle EPROBE_DEFER. EPROBE_DEFER is so named because
it defers _driver_ _probing_ and thus is only appropriate to be
returned from a device driver .probe method. .ndo_open is not a device
driver probe method and thus EPROBE_DEFER must not be returned from it.

The only option in .ndo_open is to fail the attempt to open the network
device, at which point userspace will report an error and give up
opening that network device - it won't retry.

In summary, this isn't something which is specific to phylink.

The only way I can see around this problem would be to look up the
PHY in order to get a pointer to the struct phy_device in the network
device's probe function, and attach the PHY there _before_ you register
the network device. You can then return EPROBE_DEFER and, because you
are returning it in a .probe function, the probe will be retried once
other probes in the system (such as your PHY driver) have finished.
This also means that userspace doesn't see the appearance of the
non-functional network device until it's ready, and thus can use
normal hotplug mechanisms to notice the network device.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

