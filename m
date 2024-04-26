Return-Path: <netdev+bounces-91757-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C2EA8B3C4E
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 18:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF7041F20F46
	for <lists+netdev@lfdr.de>; Fri, 26 Apr 2024 16:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B35714D29D;
	Fri, 26 Apr 2024 16:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="bty/pBwm"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 123DC14AD26
	for <netdev@vger.kernel.org>; Fri, 26 Apr 2024 16:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714147346; cv=none; b=m96Ho8EkAkThH7mcFLfAtxdhqijsFMehyhnHl1hNFxLrOPCqK5p94PZmvD5S7FnYwqxYKbBZdvva99tjkmo8zjObu75bVlnLv9rbn9hTK70y9cbm4xl5U7GFIxMnIE3Tzl+jzQ8ZlvzByRZZO/W7+kqife7tpD3U75yBqvi0PVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714147346; c=relaxed/simple;
	bh=2PyvTdDENvimSafTrmQaUG8Zv0g9z1NstAi8Nbd8jg0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jyEXD+ERB/Ekk2ApJaHDv6PNcsQl1wTmadvq8/CF8p7DsMECvTxmfVfrrjRXykKXAjG9D/iE873zHe8L8SdHh+K6nkDzFfzZ02PNin/is7xHBwGb31sdgWV0XqNIA1PaxocQ3n8ClbN1ZEG32yjk9uto5HP6ajeM2CKQLvMYAEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=bty/pBwm; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=E2EnCkg7BBWpT1ip396iVXYIySuf0e+XVxe8/SaaEWU=; b=bty/pBwmcvoycevbUJV74BqqPA
	v6ZBeWBR3p+1eOsr6pd3RGc7gTryy+CzLYewiNqGo5jnyYcmjGZfB0obzhh6EyAzWYAR7EYR+lxI/
	J8WVvvnI9eMY1lTdKRZW/u2vkmoCOdrfDiFukKi74RX82J8RN+nUtwlon94BE0XZ0j+EHuDlrhcLY
	UG2eoRdHcS/aL3Jb21fiUOjw8x3TFj6EVbyYTm2vhhhK2jcQPV451zT3qhKVcGfcwUC5W13tTurLo
	yDHrbUX8ORiX+hXZlgJ3SDTw5BIKJI/GlLUJnEFviTwRELz9JcWWsQGbRZHylKCYbKsfq8/OqMM8W
	3siSj9Wg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58686)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1s0O1W-0000SD-39;
	Fri, 26 Apr 2024 17:02:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1s0O1V-0006dn-LD; Fri, 26 Apr 2024 17:02:05 +0100
Date: Fri, 26 Apr 2024 17:02:05 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com
Subject: [PATCH net-next 0/4] net: dsa: microchip: use phylink_mac_ops for
 ksz driver
Message-ID: <ZivP/R1IwKEPb5T6@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

This four patch series switches the Microchip KSZ DSA driver to use
phylink_mac_ops support, and for this one we go a little further
beyond a simple conversion. This driver has four distinct cases:

lan937x
ksz9477
ksz8
ksz8830

Three of these cases are handled by shimming the existing DSA calls
through ksz_dev_ops, and the final case is handled through a
conditional in ksz_phylink_mac_config(). These can all be handled
with separate phylink_mac_ops.

To get there, we do a progressive conversion.

Patch 1 removes ksz_dev_ops' phylink_mac_config() method which is
not populated in any of the arrays - and is thus redundant.

Patch 2 switches the driver to use a common set of phylink_mac_ops
for all cases, doing the simple conversion to avoid the DSA shim.

Patch 3 pushes the phylink_mac_ops down to the first three classes
(lan937x, ksz9477, ksz8) adding an appropriate pointer to the
phylink_mac_ops to struct ksz_chip_data, and using that to
populate DSA's ds->phylink_mac_ops pointer. The difference between
each of these are the mac_link_up() method. mac_config() and
mac_link_down() remain common between each at this stage.

Patch 4 splits out ksz8830, which needs different mac_config()
handling, and thus means we have a difference in mac_config()
methods between the now four phylink_mac_ops structures.

Build tested only, with additional -Wunused-const-variable flag.

 drivers/net/dsa/microchip/ksz8.h       |   6 +-
 drivers/net/dsa/microchip/ksz8795.c    |  10 ++-
 drivers/net/dsa/microchip/ksz_common.c | 121 ++++++++++++++++++++++-----------
 drivers/net/dsa/microchip/ksz_common.h |   5 +-
 4 files changed, 94 insertions(+), 48 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

