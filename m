Return-Path: <netdev+bounces-53449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D786803018
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 11:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4208B208C8
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 10:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAA4120320;
	Mon,  4 Dec 2023 10:22:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBB4585;
	Mon,  4 Dec 2023 02:22:20 -0800 (PST)
Received: from i53875b61.versanet.de ([83.135.91.97] helo=diego.localnet)
	by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <heiko@sntech.de>)
	id 1rA65V-0003dC-Mw; Mon, 04 Dec 2023 11:22:05 +0100
From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To: Florian Fainelli <f.fainelli@gmail.com>, andrew@lunn.ch,
 hkallweit1@gmail.com, Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc: linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Heiko Stuebner <heiko.stuebner@cherry.de>
Subject:
 Re: [PATCH] net: mdio: enable optional clock when registering a phy from
 devicetree
Date: Mon, 04 Dec 2023 11:22:04 +0100
Message-ID: <13590315.F0gNSz5aLb@diego>
In-Reply-To: <10f8e599-940b-4b7c-8c82-8d505007f19b@theobroma-systems.com>
References:
 <20231201142453.324697-1-heiko@sntech.de>
 <ecbdcfb7-32ab-45cc-991a-982c52bf4b14@gmail.com>
 <10f8e599-940b-4b7c-8c82-8d505007f19b@theobroma-systems.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"

Am Montag, 4. Dezember 2023, 11:14:12 CET schrieb Quentin Schulz:
> Hi Florian, Heiko,
> 
> On 12/1/23 23:41, Florian Fainelli wrote:
> > On 12/1/23 06:24, Heiko Stuebner wrote:
> >> From: Heiko Stuebner <heiko.stuebner@cherry.de>
> >>
> >> The ethernet-phy binding (now) specifys that phys can declare a clock
> >> supply. Phy driver itself will handle this when probing the phy-driver.
> >>
> >> But there is a gap when trying to detect phys, because the mdio-bus needs
> >> to talk to the phy to get its phy-id. Using actual phy-ids in the dt like
> >>         compatible = "ethernet-phy-id0022.1640",
> >>                      "ethernet-phy-ieee802.3-c22";
> >> of course circumvents this, but in turn hard-codes the phy.
> > 
> > But it is the established practice for situations like those where you 
> > need specific resources to be available in order to identify the device 
> > you are trying to probe/register.
> > 
> > You can get away here with the clock API because it can operate on 
> > device_node, and you might be able with a bunch of other "resources" 
> > subsystems, but for instance with regulators, that won't work, we need a 
> > "struct device" which won't be created because that is exactly what we 
> > are trying to do.
> > 
> > Also this only works for OF, not for ACPI or other yet to come firmware 
> > interface.
> > 
> > Sorry but NACK.
> > 
> > I am sympathetic to the idea that if you have multiple boards and you 
> > may have multiple PHY vendors this may not really scale, but in 2023 you 
> > have boot loaders aware of the Device Tree which can do all sorts of 
> > live DTB patching to provide the kernel with a "perfect" view of the world.
> 
> There's a strong push towards unifying the device tree across all pieces 
> of SW involved, sometimes going as far as only having one binary passed 
> between SW stages (e.g. U-Boot passes its own DT to TF-A, and then to 
> the Linux kernel without actually loading anything aside from the Linux 
> kernel Image binary) if I remember correctly (haven't really followed 
> tbh). So, this is kinda a step backward for this effort. I don't like 
> relying on bootloader to make the kernel work, this is usually not a 
> great thing. I understand the reasons but am still a bit sad to not see 
> this done in the kernel.
> 
> Heiko, I would personally put the ID of the PHY to be the most likely 
> encountered in the Linux kernel Device Tree so that if we somehow have a 
> broken bootloader, there's a chance some devices still work properly. HW 
> department said ksz9131 so we can go forward with this.

hmm, I was more of the mind of having either all or none work ;-) 
[i.e. keeping the c.22 compatible in the main dt and having firmware
 add the phy-id]

I.e. a bootloader doing the correct detection and fixup would insert the
matching phy-id and a broken bootloader would not do this.

Having some boards work that by chance have the right phy and others break
would possibly create a wild goose chase if the bootloader support for
phy-id-handling breaks somewhere down the line.


Heiko

> In U-Boot DT, we 
> would need a -u-boot.dtsi we change to the auto-detection compatible and 
> we do the magic the Linux kernel doesn't want to do and hope it's fine 
> for U-Boot maintainers. Once properly detected, we fixup the DT before 
> booting the kernel.





