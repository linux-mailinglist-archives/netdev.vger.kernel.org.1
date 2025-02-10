Return-Path: <netdev+bounces-164958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE863A2FE38
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 00:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75F043A3805
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 23:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196AF25EF99;
	Mon, 10 Feb 2025 23:11:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED75925334D
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 23:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739229099; cv=none; b=YQe7euQghOzDRI4R0tPdepkSnnuqfxlzX6pfwleLYpil8WACyq3pA7F9PMW/DNETUAzo1GZ1KDjXkdQIvic2lZuDIrrjotLSnSMeY8ssitlZ6ykZ0zzpOcB37lk5BRKSS3Kzesyg1Oa/B/yHp39oOc6yRuQ/ocin7+z0Y+1ON7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739229099; c=relaxed/simple;
	bh=9QTidql42Ormz3LOjHNLSQPPccOdZyUGMAUzZbOWZcc=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=PsERRMGgcu0lHyiiSESY7ocbHFlogwsn5k0hqHpizEYFc3WFmcrq3uzIvJpkEcqNtdwPGqDcqWxHZ+FunlgfqaXHch7/1BGVfyYTgv5U8ei3N+xhCXN+HR06jbCrRP5AFNTe8sQpAaJoaBeKupSG11F+ZLa/c1SDmhSibGSADvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1thcvn-000000000gQ-0fDk;
	Mon, 10 Feb 2025 23:11:11 +0000
Date: Mon, 10 Feb 2025 23:11:07 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Bo-Cun Chen <bc-bocun.chen@mediatek.com>,
	Chad Monroe <chad.monroe@adtran.com>,
	John Crispin <john@phrozen.org>, maxime.chevallier@bootlin.com,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Vladimir Oltean <olteanv@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-mediatek@lists.infradead.org,
	Matthias Brugger <matthias.bgg@gmail.com>, netdev@vger.kernel.org
Subject: upstream Linux support for Ethernet combo ports via external mux
Message-ID: <Z6qHi1bQZEnYUDp7@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

Looking for ways to support a passive SerDes mux in vanilla Linux I
found Maxime's slides "Multi-port and Multi-PHY Ethernet interfaces"[1].

The case I want to support is probably quite common nowadays but isn't
covered there nor implemented in Linux.

 +----------------------------+
 |            SoC             |
 |    +-----------------+     |
 |    |       MAC       |     |
 |    +----+-------+----+     |
 |         |  PCS  |   +------+
 |         +---=---+   | GPIO |
 +-------------=-------+---=--+
              |            |
           +---=---+       |
           |  Mux  <-------+
           +-=---=-+
             |   |
            /     \
     +-----=-+   +-=-----+
     |  PHY  |   |  SFP  |
     +-------+   +-------+

So other than it was when SoCs didn't have built-in PCSs, now the SFP is
not connected to the PHY, but there is an additional mux IC controlled
by the SoC to connect the serialized MII either to the PHY (in case no
SFP is inserted) or to the SFP (in case a module is inserted).

MediaTek came up with a vendor-specific solution[2] for that which works
well -- but obviously it would be much nicer to have generic, vendor-
agnostic support for such setups in phylink, ideally based on the
existing gpio-mux driver.

So I imagine something like a generic phylink-mux, controlled by hooking
to the module_insert and module_remove remove SFP ops (assuming the
moddef0 signal is connected...).

Before I get my hands dirty, please join my line of thought for one
moment, so we can agree on a sketch:

Does everyone agree that phylink would be the right place to do this?

DT bindings could look like this (option A):
 ...
    mux: mux-controller {
        compatible = "gpio-mux";
        #mux-control-cells = <0>;

        mux-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
    };

    mux0: mii-mux {
        compatible = "mii-mux";
        mux-controls = <&mux>;
        #address-cells = <1>;
        #size-cells = <0>;

        channel@0 {
            reg = <0>;
            sfp = <&sfp0>;
            managed = "in-band-status";
            module-presence-controls-mux;
        };

        channel@1 {
            reg = <1>;
            phy-handle = <&phy0>;
            phy-connection-type = "sgmii";
        };
    };
  };

  soc {
      ethernet@12340000 {
          mii-mux = <&mux0>;
      };
  };
    

or like this (option B):
 ...
    mux: mux-controller {
        compatible = "gpio-mux";
        #mux-control-cells = <0>;

        mux-gpios = <&pio 7 GPIO_ACTIVE_HIGH>;
    };
  };

  soc {
      ethernet@12340000 {
          sfp = <&sfp0>;
          phy = <&phy0>;
          phy-connection-type = "sgmii";
          mux-controls = <&mux>;
      };
  };


Obviously option A is more expressive, but also more complex, and I'm
not 100% sure if all that complexity is really needed in practise.
However, for "better safe than sorry" reasons I'd opt for option A,
unless anyone comes up with a better idea.

Let me know what you think.


Cheers


Daniel


[1]: https://netdevconf.org/0x17/docs/netdev-0x17-paper2-talk-slides/multi-port-multi-phy-interfaces.pdf
[2]: https://git01.mediatek.com/plugins/gitiles/openwrt/feeds/mtk-openwrt-feeds/+/refs/heads/master/autobuild/unified/global/24.10/files/target/linux/mediatek/patches-6.6/999-2708-net-ethernet-mtk_eth_soc-support-ethernet-passive-mu.patch

