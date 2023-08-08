Return-Path: <netdev+bounces-25524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67088774711
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:09:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9FF1C20F5D
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1337168DE;
	Tue,  8 Aug 2023 19:06:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69B0171AC
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:06:25 +0000 (UTC)
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622336ABA
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x3tR1Q3HtfmSw2Sb7jRtZPMxxnMz+JKMndQFIX2Ea3A=; b=TZhqVFu/NYLeKibdYtTJ7FE4M/
	zSRTWdBPnNDNyEzGjNpUi7wvqxUsvvNg3CP4kt4Sovnlk6pW2/gVjkM5ZAm+ADoqjQuknazzlY6iA
	rFbXXewbR1n/0UjBUeAv/ntRoMxvboreTpMtRgd6Mo7nPmz/5oKs40Z3DI7z6Lk61f0SqIRcJOoPZ
	v5Ro8IMQ4MZeU4JHHAqLK+I0LAN4cc/cBXzbWFIDeatglKh5DgZrjlqKkKAlcCsRS0apaRAKhkTVz
	jcqIifkKyLyBpf8vbOhd6vUXmcpd3yWby+vy19/22AI0zvwf9/BcrUl7vOR2+X4U/ShmGhHiP8btG
	idEwu8dQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:54428 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1qTKdM-0007Lw-1D;
	Tue, 08 Aug 2023 12:12:16 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1qTKdM-003Cpx-Eh; Tue, 08 Aug 2023 12:12:16 +0100
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] net: dsa: mark parsed interface mode for legacy
 switch drivers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1qTKdM-003Cpx-Eh@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 08 Aug 2023 12:12:16 +0100
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

If we successfully parsed an interface mode with a legacy switch
driver, populate that mode into phylink's supported interfaces rather
than defaulting to the internal and gmii interfaces.

This hasn't caused an issue so far, because when the interface doesn't
match a supported one, phylink_validate() doesn't clear the supported
mask, but instead returns -EINVAL. phylink_parse_fixedlink() doesn't
check this return value, and merely relies on the supported ethtool
link modes mask being cleared. Therefore, the fixed link settings end
up being allowed despite validation failing.

Before this causes a problem, arrange for DSA to more accurately
populate phylink's supported interfaces mask so validation can
correctly succeed.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 net/dsa/port.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/net/dsa/port.c b/net/dsa/port.c
index 24015e11255f..37ab238e8304 100644
--- a/net/dsa/port.c
+++ b/net/dsa/port.c
@@ -1690,10 +1690,14 @@ int dsa_port_phylink_create(struct dsa_port *dp)
 		ds->ops->phylink_get_caps(ds, dp->index, &dp->pl_config);
 	} else {
 		/* For legacy drivers */
-		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
-			  dp->pl_config.supported_interfaces);
-		__set_bit(PHY_INTERFACE_MODE_GMII,
-			  dp->pl_config.supported_interfaces);
+		if (mode != PHY_INTERFACE_MODE_NA) {
+			__set_bit(mode, dp->pl_config.supported_interfaces);
+		} else {
+			__set_bit(PHY_INTERFACE_MODE_INTERNAL,
+				  dp->pl_config.supported_interfaces);
+			__set_bit(PHY_INTERFACE_MODE_GMII,
+				  dp->pl_config.supported_interfaces);
+		}
 	}
 
 	pl = phylink_create(&dp->pl_config, of_fwnode_handle(dp->dn),
-- 
2.30.2


