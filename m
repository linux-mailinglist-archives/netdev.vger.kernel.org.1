Return-Path: <netdev+bounces-22550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50193767F31
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 14:38:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAE7E2825C1
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 12:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E997316430;
	Sat, 29 Jul 2023 12:38:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBC6614AB3
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 12:38:27 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8741BB
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 05:38:25 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qPjDB-0008PW-04;
	Sat, 29 Jul 2023 12:38:21 +0000
Date: Sat, 29 Jul 2023 13:38:13 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Simon Horman <simon.horman@corigine.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>
Subject: Re: [PATCH v2 net-next 0/3] Support offload LED blinking to PHY.
Message-ID: <ZMUINa552w1TH16U@makrotopia.org>
References: <20230624205629.4158216-1-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230624205629.4158216-1-andrew@lunn.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrew,

On Sat, Jun 24, 2023 at 10:56:26PM +0200, Andrew Lunn wrote:
> 
> Allow offloading of the LED trigger netdev to PHY drivers and
> implement it for the Marvell PHY driver. Additionally, correct the
> handling of when the initial state of the LED cannot be represented by
> the trigger, and so an error is returned.

I've used this series in my tree and implemented support for all LED-
related features in the mediatek-ge-soc PHY driver:

https://github.com/dangowrt/linux/commit/3b9b30a9a6699d290964fc76c56cfcd1dadf5651

I've noticed there is a problem when setting up the netdev trigger using
the 'linux,default-trigger' property in device tree. In this case
led_classdev_register_ext is called *before* register_netdevice has
completed.
Hence supports_hw_control returns false when the 'netdev' trigger is
initially setup as default trigger.

To resolve this, I've tried wrapping led_classdev_register_ext() and
introducing led_classdev_register_ext_nodefault() which doesn't call
out to led_trigger_set_default, so that can be done later by the
caller. However, there isn't any good existing call from netdev to phy
informing the phy that the netdev has been registered, so the phy_leds
would have to register a netdevice_notifier and wait for the
NETDEV_REGISTER events, matching against the netdev's PHY... And that
seems a bit overkill, just to support netdev trigger offloading to work
when used as a default trigger...

Any better ideas anyone?




> 
> Since v1:
> 
> Add true kerneldoc for the new entries in struct phy_driver
> Add received Reviewed-by: tags
> 
> Since v0:
> 
> Make comments in struct phy_driver look more like kerneldoc
> Add cover letter
> 
> Andrew Lunn (3):
>   led: trig: netdev: Fix requesting offload device
>   net: phy: phy_device: Call into the PHY driver to set LED offload
>   net: phy: marvell: Add support for offloading LED blinking
> 
>  drivers/leds/trigger/ledtrig-netdev.c |   8 +-
>  drivers/net/phy/marvell.c             | 243 ++++++++++++++++++++++++++
>  drivers/net/phy/phy_device.c          |  68 +++++++
>  include/linux/phy.h                   |  33 ++++
>  4 files changed, 349 insertions(+), 3 deletions(-)
> 
> -- 
> 2.40.1
> 
> 

