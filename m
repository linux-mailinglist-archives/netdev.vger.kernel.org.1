Return-Path: <netdev+bounces-17464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C69751BE0
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 10:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E5542816BA
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 08:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EE3E8821;
	Thu, 13 Jul 2023 08:41:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF898478
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 08:41:31 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3DD81989
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 01:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UZIU+yt5ajx2m4cu+I+YULCa2MRBJfOAXZw4l6Tt6IU=; b=NpXAKLmyT5CRQHMMKqOZwVMepm
	GojzYcXwe/Mhclgn8Lav0qfeyCpn2K1QJUlvvcq0rNpPkHiH/pJjzHO4qfs0KOPNy2nTLdq0UkGuX
	GBW5VCxEvO45iPmOxig0y/gpT3EkQU94LxXI5pB4BYtURyzHp/1QxEH3/n/+aGPSohIeCGzlT1Ffm
	H2qsHjSacnJmKZ3/ltNbyPOq3huVkQ2q7/wR+p4UtjDHWNNrcWTEGrXuHSmnrDw8+6A/PqpWUe0XC
	VyWZ7yA3ofcyo7D0Pt4V4RIPn9//+i9pjgnZgFFBjL6f9B5cGTLwVs9Mul+Pa1Iu/neW4d2ours6m
	ILR862dg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58544)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qJrt7-00067T-1V;
	Thu, 13 Jul 2023 09:41:25 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qJrt6-0005zt-5S; Thu, 13 Jul 2023 09:41:24 +0100
Date: Thu, 13 Jul 2023 09:41:24 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next 00/11] Convert mv88e6xxx to phylink_pcs
Message-ID: <ZK+4tOD4EpFzNM9x@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

This series (previously posted with further patches on the 26 June as
RFC) converts mv88e6xxx to phylink_pcs, and thus moves it from being
a pre-March 2020 legacy driver.

The first four patches lay the ground-work for the conversion by
adding four new methods to the phylink_pcs operations structure:

  pcs_enable() - called when the PCS is going to start to be used
  pcs_disable() - called when the PCS is no longer being used

  pcs_pre_config() - called before the MAC configuration method
  pcs_post_config() - called after the MAC configuration method
      Both of these are necessary for some of the mv88e639x
      workarounds.

We also add the ability to inform phylink of a change to the PCS
state without involving the MAC later, by providing
phylink_pcs_change() which takes a phylink_pcs structure rather than
a phylink structure. phylink maintains which instance the PCS is
conencted to, so internally it can do the right thing when the PCS
is in-use.

Then we provide some additional mdiobus and mdiodev accessors that
we will be using in the new PCS drivers.

The changes for mv88e6xxx follow, and the first one needs to be
explicitly pointed out - we (Andrew and myself) have both decided that
all possible approaches to maintaining backwards compatibility with DT
have been exhaused - everyone has some objection to everything that
has been proposed. So, after many years of trying, we have decided
that this is just an impossibility, and with this patch, we are now
intentionally and knowingly breaking any DT that does not specify the
CPU and DSA port fixed-link parameters. Hence why Andrew has recently
been submitting DT update patches. It is regrettable that it has come
to this.

Following this, we start preparing 88e6xxx for phylink_pcs conversion
by padding the mac_select_pcs() DSA method, and the internal hooks to
create and tear-down PCS instances. Rather than bloat the already very
large mv88e6xxx_ops structure, I decided that it would be better that
the new internal chip specific PCS methods are all grouped within their
own structure - and this structure can be declared in the PCS drivers
themselves.

Then we have the actual conversion patches, one for each family of PCS.

Lastly, we clean up the driver after conversion, removing all the now
redundant code.

 drivers/net/dsa/mv88e6xxx/Makefile   |    3 +
 drivers/net/dsa/mv88e6xxx/chip.c     |  428 ++-----------
 drivers/net/dsa/mv88e6xxx/chip.h     |   33 +-
 drivers/net/dsa/mv88e6xxx/pcs-6185.c |  190 ++++++
 drivers/net/dsa/mv88e6xxx/pcs-6352.c |  390 ++++++++++++
 drivers/net/dsa/mv88e6xxx/pcs-639x.c |  898 +++++++++++++++++++++++++++
 drivers/net/dsa/mv88e6xxx/port.c     |   30 -
 drivers/net/dsa/mv88e6xxx/serdes.c   | 1106 +---------------------------------
 drivers/net/dsa/mv88e6xxx/serdes.h   |  108 +---
 drivers/net/phy/mdio_bus.c           |   24 +-
 drivers/net/phy/phylink.c            |  110 +++-
 include/linux/mdio.h                 |   26 +
 include/linux/phylink.h              |   29 +
 13 files changed, 1737 insertions(+), 1638 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

