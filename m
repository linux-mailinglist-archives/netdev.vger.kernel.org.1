Return-Path: <netdev+bounces-41402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1937CADD2
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:42:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B4851C20AA0
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 15:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682F92AB4C;
	Mon, 16 Oct 2023 15:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tmK4Xajf"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175182AB23;
	Mon, 16 Oct 2023 15:42:41 +0000 (UTC)
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE1F83;
	Mon, 16 Oct 2023 08:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Zzp2g3em91HvoJPEHh32yNmJM73IDkWjeKVwnDIuGHI=; b=tmK4Xajfb/eKyAIVdNlmpVKHTY
	72EvyPPMaDhtojc2DUFZEKgyYvCyiW9qr5JICBeRy5oxG7iU6bBl/5dUSHZBmsRlrqlSIq+jSdsEt
	xCwel1xpviHnjTAdRgQYYn0tv0xM6y1D3u8OzEStVEW+9FQDLdCKGLw4fbZZgMzaGYi3eSn8YBmY4
	TzwIQsUiE0mou9mXWB+uYSvl0u9zqBWQydt8NWd2QssdNMK3AVbACtwi2XNQgIXity3mOByz1uxXb
	Qmt3SU5kytPtBTu/0+jP0Sjf2b/6v2vN8m/fiLDfKcX79QFUAtjcck3U61PyhzEsuQq0OWNKK/cEK
	C94swfPA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54782)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <linux@armlinux.org.uk>)
	id 1qsPji-0001er-1O;
	Mon, 16 Oct 2023 16:42:30 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1qsPjg-0005iw-Pb; Mon, 16 Oct 2023 16:42:28 +0100
Date: Mon, 16 Oct 2023 16:42:28 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org, Madalin Bucur <madalin.bucur@nxp.com>,
	netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH net-next 0/4] net: remove last of the phylink validate
 methods and clean up
Message-ID: <ZS1Z5DDfHyjMryYu@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

This four patch series removes the last of the phylink MAC .validate
methods which can be found in the Freescale fman driver. fman has a
requirement that half duplex may not be supported in RGMII mode,
which is currently handled in its .validate method.

In order to keep this functionality when removing the .validate method,
we need to replace that with equivalent functionality, for which I
propose the optional .mac_get_caps method in the first patch.

The advantage of this approach over the .validate callback is that MAC
drivers only have to deal with the MAC_* capabilities, and don't need
to call back into phylink functions to do the masking of the ethtool
linkmodes etc - which then becomes internal to phylink. This can be
seen in the fourth patch where we make a load of these methods static.

 Documentation/networking/sfp-phylink.rst         | 10 +++--
 drivers/net/ethernet/freescale/fman/fman_memac.c | 11 +++--
 drivers/net/phy/phylink.c                        | 45 +++++++------------
 include/linux/phylink.h                          | 56 +++++-------------------
 4 files changed, 37 insertions(+), 85 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

