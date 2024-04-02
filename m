Return-Path: <netdev+bounces-84158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 349BB895C87
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 21:28:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65EAB1C234F3
	for <lists+netdev@lfdr.de>; Tue,  2 Apr 2024 19:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E77F15B966;
	Tue,  2 Apr 2024 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="gbV0BD5c"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCCD915B55A
	for <netdev@vger.kernel.org>; Tue,  2 Apr 2024 19:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086078; cv=none; b=YpIr/Is9X8q8FuTV6F7e4XiN6QERTZ6Cngn2rM26SCqRK+taYGD2WcpDjV6ykdznUx+E17djglQldfF1ZWA/RbdIumnsZEx90l6hCUAurHpg0mgXrLnzgEZRRPBn/jfCEsxbA7RLiRmqtCOcsFKcHGiD6kwgExuMylLRE4EFPE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086078; c=relaxed/simple;
	bh=YNim6JHCla0bZgzda/EmvFoUo2RUIln2onzqGl/Rx7g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftFrLM18TIwOB8XESdo3llGr3u8tGifdR6JGCentxFamYEGcys4iHxJsLlqz2qNXgtJHOpxUw/qh9Q3D7bZiPKefVMQJ6+PUUqcJRaDWodDbotUU1VaaBY2jVAGAtzXtuafUddum93gVOitXV9Rh6ULlSxbyONOv4Ct/Pa7cZvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=gbV0BD5c; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ZMUtKyswRObTwMhTmx3eJRkUmka61Iwoh7vpQ8otQPI=; b=gbV0BD5cvFMh12z52IJEA5eyoN
	faqFZ+PAreEyTF21ZIFAb4U+zMmAJbKWSjHcoOLV7xs6WI28GrGF7OnZH+TEWpbcV73B208NV5eMJ
	LbY0jdrE9DYCr3LHVmrSnC8VceusAhwNXMVv4blB+H3o7XYdxLvnyDLbWMzMN2IJ/MNstcOYRmLeo
	aQK144Xh38ixptUgRjx4wG07NgVQ31V3TbSguN/oZCc3zDJLbdmxmszRfo/GbOa+o0wsvwZNg7Dlg
	gx8Jf8VrMH3zozZBoIGpua1und4XZyXkCVbRrQIKwMPOWiOlM/4HM33P9dBkSkHpsH9X0YYVlv3FH
	5aW318BA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52840)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1rrjnP-0007GS-1W;
	Tue, 02 Apr 2024 20:27:47 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1rrjnP-0007CL-Fq; Tue, 02 Apr 2024 20:27:47 +0100
Date: Tue, 2 Apr 2024 20:27:47 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Eric Woudstra <ericwouds@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
	Frank Wunderlich <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org
Subject: Re: [PATCH v3 net-next 4/6] net: phy: realtek: Change
 rtlgen_get_speed() to rtlgen_decode_speed()
Message-ID: <ZgxcM1a7pF1O8iqB@shell.armlinux.org.uk>
References: <20240402055848.177580-1-ericwouds@gmail.com>
 <20240402055848.177580-5-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402055848.177580-5-ericwouds@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Apr 02, 2024 at 07:58:46AM +0200, Eric Woudstra wrote:
> The value of the register to determine the speed, is retrieved
> differently when using Clause 45 only. To use the rtlgen_get_speed()
> function in this case, pass the value of the register as argument to
> rtlgen_get_speed(). The function would then always return 0, so change it
> to void. A better name for this function now is rtlgen_decode_speed().
> 
> Replace a call to genphy_read_status() followed by rtlgen_get_speed()
> with a call to rtlgen_read_status() in rtl822x_read_status().
> 
> Add reading speed to rtl822x_c45_read_status().
> 
> Signed-off-by: Eric Woudstra <ericwouds@gmail.com>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

