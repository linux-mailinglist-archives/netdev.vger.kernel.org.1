Return-Path: <netdev+bounces-221307-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B651FB501C9
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 17:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 717E7B6009C
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 15:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C228126E6F0;
	Tue,  9 Sep 2025 15:41:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zjt8/Bgl"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DAB265614
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 15:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432464; cv=none; b=f9kRq3bDit8CKyKCV47mV9ANeo00TiLG3x/DiwY6wx7T73x4LNGbYAhnVDiiWM32P+xYoFu5vli+E8IXFK63iH98b/pPiZwwGJeKgnMSFLHrBndpqV9+k5ZyjtfviLjMgqc5f/H1WI6qMGh9A7kyzNCo2IYcKeoa5jzNi34QfCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432464; c=relaxed/simple;
	bh=G/cKNxwQ9kE5DUoigzhBtkAZWj+vGuzCuAI2e96JlpM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ehKepj+B/LcDa2aXD5Ta7XS2O+cWMpFg/hxNLI1NV1j680r1xrWCzf92XSsRSg2bruZ0MqZaI6qU6k3A76Voe4EHHsEK60aE0CJ8kqTKDaka2sgZjYczaAjqBGTcQyJ/8QDFhksfPWsZlAzvx978JI8Xmtf2q5n8MDcjDdJqJMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zjt8/Bgl; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UwNbTAExdKAs/sWkcEddQzbT3ea/Pxg+z4IDg8N4mK0=; b=zjt8/BglDrrImQdJ/ldsmx2fHs
	TdAjyGBjFsRqDRPLsND7Vwcd9x7sh9ZrfO2TkVho/GYCuxXZ2ZlyRnFPl5yUenpMaF4HN0Yf+b/HM
	CHVUfSRhPQiut9KGQnfAN8lUXXRpkMtWXR6xvNCcdtLyjQCQ9ZBI9mAvcNmXfi5n18JM3ZawBqXP1
	GWaQmrkLotZPul6hK6G7GvQiBQ8gCvLuZyn5lyBuS1QQFXtrk4hEcdPfEBsw6uH9yPBNpjkGKYyaj
	m9bSDg2lCJehzSo0u0+zGAEseEccJ3fOKjWryBn7akVlC0Kjp2lDx3yuyXB9IXVYNMaqLA6Mg0X8y
	UXtfNO6Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51316)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1uw0So-000000008Ml-0BbG;
	Tue, 09 Sep 2025 16:40:58 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1uw0Sl-000000000XU-2diA;
	Tue, 09 Sep 2025 16:40:55 +0100
Date: Tue, 9 Sep 2025 16:40:55 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: [Query] ethtool cumbersome timestamping options
Message-ID: <aMBKh2sqDwkRY04y@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

While spending some time with PTP stuff, specifically my Marvell PTP
library, and getting mv88e6xxx converted to it, etc, I was trying
out the timestamping related ethtool options:

        ethtool [ FLAGS ] -T|--show-time-stamping DEVNAME       Show time stamping capabilities
                [ index N qualifier precise|approx ]
        ethtool [ FLAGS ] --get-hwtimestamp-cfg DEVNAME Get selected hardware time stamping
        ethtool [ FLAGS ] --set-hwtimestamp-cfg DEVNAME Select hardware time stamping
                [ index N qualifier precise|approx ]

and I'm finding them particularly cumbersome and irritating to use.

Typing:

  ethtool -T eth0 index 0 qualifier precise

or

  ethtool -T eth0 index 1 qualifier precise

is quite annoying, especially when the man page states:

           qualifier precise|approx
                  Qualifier of the ptp hardware clock. Mainly "precise" the de‐
                  fault one is for IEEE 1588 quality and "approx" is  for  NICs
                  DMA point.

Note "the default one". That implies if it isn't given, this is what
will be used if it isn't specified, but this isn't so, you have to
type the whole "qualifier precise" thing out each and every time.
So, it isn't a default at all.

Either the man page needs to be fixed, or ethtool needs to actually
default to the value stated in the man page.

Alternatively, in this age of AI, I'd suggest changing the -- options
for timestamping to be:

ethtool --please-would-you-be-so-kind-as-to-change-the-timestamping-device-to
...

and

ethtool --please-show-me-the-current-timestamping-device-information

and similar, because with AI giving the commands to be executed, it
no longer matters how verbose command options are today. :D (I
suspect there will be some who will have a humour failure with that
suggestion...)

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

