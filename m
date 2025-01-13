Return-Path: <netdev+bounces-157660-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35F25A0B29A
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 10:22:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 36D4C1633F4
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 09:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8559023979C;
	Mon, 13 Jan 2025 09:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fYdoFmz7"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F8E145A16
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 09:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736760128; cv=none; b=k8F4nRGm56z9cOn8WmNSR4skI1hzJmNc8HO1EkQe8Pl6d8eUAZX3UdeC2I7zpmkQNnCx9aj7fslgpId8YyVKC0l6UPQQc0cJpfbOJvVc6IW5dlZvKpcJZsVLoyUtxy0mDGsTMb8LH8mUUEOMwJKdzbU4I3BdsV8kX9L0rr/jV6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736760128; c=relaxed/simple;
	bh=D/esqgxMhOa+gKrqWrl9YkbeC6Nlbcann0IkBS2Guhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f8aCe4mJ6oaAixEDRfnVpzJAcruwcZzyyJnlRmYBlJKWP57/dpxJtS+JWLzlAFbkrOLHHvTBaIRqaLsd6D1+qrEs3YwjSzPUEcyQLKlN2dQAFIAeLtw3RTjO0k0orZqSoccHI12hm0wlVM3zubRvpSxoZ8n1GYzlAYS6ZdujfhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fYdoFmz7; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=1SSTzS99BYsiM+oBx4byfpdIc4HV6ye8QqH1Uy/uwK8=; b=fYdoFmz7gBQiSp0E0N+IE+M+N0
	FPcncnIjDuC2EtVNdNKtyxGuoX5fZDq/bAPi7doFZlFyn9BSfhQVBAwgJn/0GfYc6vUqJIYmhZdvc
	8OwDpi+kSkIcJJ68qnMeO34+RnIUxE3PlIpBo8p+4a1XW5daaIyXjYgBKzDFhuPsbLLAFJYTlBtb+
	lhphYEILFzAetzKI3H1cxIOXa0Jft4he4cmWgjpaYrFuJABv4aEgmW4qjpO1eJqEI2PPAw7/33Xkf
	WMPrY+vubq6uZo76PH9DkDYrYu8fbYMgrl+B809jKvAj7Dr3RfKcKA+RO9x7lIZV6zdxlollS4a6s
	0K7rZRxQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54286)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1tXGdU-0006Fg-0X;
	Mon, 13 Jan 2025 09:21:28 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.96)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1tXGdK-0003wv-2z;
	Mon, 13 Jan 2025 09:21:18 +0000
Date: Mon, 13 Jan 2025 09:21:18 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: Alexander Couzens <lynxis@fe80.eu>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Daniel Golle <daniel@makrotopia.org>,
	Daniel Machon <daniel.machon@microchip.com>,
	"David S. Miller" <davem@davemloft.net>,
	DENG Qingfang <dqfext@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Eric Woudstra <ericwouds@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jose Abreu <Jose.Abreu@synopsys.com>, kernel-team@meta.com,
	Lars Povlsen <lars.povlsen@microchip.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Michal Simek <michal.simek@amd.com>, netdev@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Sean Anderson <sean.anderson@seco.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v2 0/5] net: phylink: fix PCS without autoneg
Message-ID: <Z4TbDnXtG8f3SRmC@shell.armlinux.org.uk>
References: <Z3_n_5BXkxQR4zEG@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z3_n_5BXkxQR4zEG@shell.armlinux.org.uk>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

Hi,

Eric Woudstra reported that a PCS attached using 2500base-X does not
see link when phylink is using in-band mode, but autoneg is disabled,
despite there being a valid 2500base-X signal being received. We have
these settings:

	act_link_an_mode = MLO_AN_INBAND
	pcs_neg_mode = PHYLINK_PCS_NEG_INBAND_DISABLED

Eric diagnosed it to phylink_decode_c37_word() setting state->link
false because the full-duplex bit isn't set in the non-existent link
partner advertisement word (which doesn't exist because in-band
autoneg is disabled!)

The test in phylink_mii_c22_pcs_decode_state() is supposed to catch
this state, but since we converted PCS to use neg_mode, testing the
Autoneg in the local advertisement is no longer sufficient - we need
to be looking at the neg_mode, which currently isn't provided.

We need to provide this via the .pcs_get_state() method, and this
will require modifying all PCS implementations to add the extra
argument to this method.

Patch 1 uses the PCS neg_mode in phylink_mac_pcs_get_state() to correct
the now obsolute usage of the Autoneg bit in the advertisement.

Patch 2 passes neg_mode into the .pcs_get_state() method, and updates
all users.

Patch 3 adds neg_mode as an argument to the various clause 22 state
decoder functions in phylink, modifying drivers to pass the neg_mode
through.

Patch 4 makes use of phylink_mii_c22_pcs_decode_state() rather than
using the Autoneg bit in the advertising field.

Patch 5 may be required for Eric's case - it ensures that we report
the correct state for interface types that we support only one set
of modes for when autoneg is disabled.

Changes in v2:
- Add test for NULL pcs in patch 1

I haven't added Eric's t-b because I used a different fix in patch 1.

 drivers/net/dsa/b53/b53_serdes.c                   |  4 +-
 drivers/net/dsa/mt7530.c                           |  2 +-
 drivers/net/dsa/mv88e6xxx/pcs-6185.c               |  1 +
 drivers/net/dsa/mv88e6xxx/pcs-6352.c               |  1 +
 drivers/net/dsa/mv88e6xxx/pcs-639x.c               |  5 +-
 drivers/net/dsa/qca/qca8k-8xxx.c                   |  2 +-
 drivers/net/ethernet/cadence/macb_main.c           |  3 +-
 drivers/net/ethernet/freescale/fman/fman_dtsec.c   |  4 +-
 drivers/net/ethernet/marvell/mvneta.c              |  2 +-
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c    |  2 +
 .../net/ethernet/marvell/prestera/prestera_main.c  |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_phylink.c    |  2 +-
 .../net/ethernet/microchip/lan966x/lan966x_main.h  |  2 +-
 .../ethernet/microchip/lan966x/lan966x_phylink.c   |  3 +-
 .../net/ethernet/microchip/lan966x/lan966x_port.c  |  4 +-
 .../net/ethernet/microchip/sparx5/sparx5_phylink.c |  2 +-
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c  |  3 +-
 drivers/net/pcs/pcs-lynx.c                         |  4 +-
 drivers/net/pcs/pcs-mtk-lynxi.c                    |  4 +-
 drivers/net/pcs/pcs-xpcs.c                         |  7 +--
 drivers/net/phy/phylink.c                          | 60 ++++++++++++++++------
 include/linux/phylink.h                            | 11 ++--
 22 files changed, 87 insertions(+), 42 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

