Return-Path: <netdev+bounces-25965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6C2B7764BD
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 18:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03DB01C20A06
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 16:11:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19061C9E5;
	Wed,  9 Aug 2023 16:11:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A3D18AE1
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 16:11:14 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E6019E
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 09:11:13 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qTlm9-0005UC-1i;
	Wed, 09 Aug 2023 16:11:10 +0000
Date: Wed, 9 Aug 2023 17:10:45 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Simon Horman <simon.horman@corigine.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net-next v3 0/4] Support offload LED blinking to PHY.
Message-ID: <ZNO6hfjrJthoIUi9@makrotopia.org>
References: <20230808210436.838995-1-andrew@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808210436.838995-1-andrew@lunn.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrew,

On Tue, Aug 08, 2023 at 11:04:32PM +0200, Andrew Lunn wrote:
> Allow offloading of the LED trigger netdev to PHY drivers and
> implement it for the Marvell PHY driver. Additionally, correct the
> handling of when the initial state of the LED cannot be represented by
> the trigger, and so an error is returned. As with ledtrig-timer,
> disable offload when the trigger is deactivate, or replaced by another
> trigger.

I've tested the series and changed my driver accordingly, now
deactivation of the offloaded tasks works fine when changing
the trigger.

Overall I believe this is good to go, however, what remains
unresolved is the chicken-egg when assigning the 'netdev' trigger
using linux,default-trigger in device tree: In this case selection of
the netdev trigger happens on creation of the PHY instance which is
*before* the creation of the netdev the PHY is going to be attached to.
Hence 'netdev' gets activated *without* any hardware offloading.

And while reading the current hardware state (as left behind by IC
defaults or by the bootloader) works fine, by default the LEDs would
show trigger 'none' in Linux right after boot (despite e.g. link and
traffic indications are active by default -- which is would I tried to
express by using linux,default-trigger...)

Tested-by: Daniel Golle <daniel@makrotopia.org>

> 
> Since v2:
> Add support for link speeds, not just link
> Add missing checks for return values
> Add patch disabling offload when driver is deactivated
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
> Andrew Lunn (4):
>   led: trig: netdev: Fix requesting offload device
>   net: phy: phy_device: Call into the PHY driver to set LED offload
>   net: phy: marvell: Add support for offloading LED blinking
>   leds: trig-netdev: Disable offload on deactivation of trigger
> 
>  drivers/leds/trigger/ledtrig-netdev.c |  10 +-
>  drivers/net/phy/marvell.c             | 281 ++++++++++++++++++++++++++
>  drivers/net/phy/phy_device.c          |  68 +++++++
>  include/linux/phy.h                   |  33 +++
>  4 files changed, 389 insertions(+), 3 deletions(-)
> 
> -- 
> 2.40.1
> 

