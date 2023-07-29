Return-Path: <netdev+bounces-22570-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22B877680BD
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 19:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 809EF2821DE
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 17:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37BC6171A9;
	Sat, 29 Jul 2023 17:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFCF15BD
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 17:19:28 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE3F3590
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 10:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5eRdVMUe8SNWP8Z885g3mo/DtksBGcWJClBw77x7Msw=; b=iJok3eAmzuFyzRMZbMAuf+dDT3
	WI/h1QnKHWMSKSr+t48YWkvmA/JnJgs3MzvKkdFda/Nz8UHM3FzyuC5zqiLqUnnvfjrEtWeXJJjbd
	JsZbuHiWwbR06HytkKGkuunhXJsmsY/pl4jAZi1pkNb0dC91Vk4oLfXUA7/R+G8ESfQw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qPnb1-002b90-Qd; Sat, 29 Jul 2023 19:19:15 +0200
Date: Sat, 29 Jul 2023 19:19:15 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Simon Horman <simon.horman@corigine.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>
Subject: Re: [PATCH v2 net-next 0/3] Support offload LED blinking to PHY.
Message-ID: <611320e4-cf52-427a-aed6-0ba04712b292@lunn.ch>
References: <20230624205629.4158216-1-andrew@lunn.ch>
 <ZMUINa552w1TH16U@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMUINa552w1TH16U@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 29, 2023 at 01:38:13PM +0100, Daniel Golle wrote:
> Hi Andrew,
> 
> On Sat, Jun 24, 2023 at 10:56:26PM +0200, Andrew Lunn wrote:
> > 
> > Allow offloading of the LED trigger netdev to PHY drivers and
> > implement it for the Marvell PHY driver. Additionally, correct the
> > handling of when the initial state of the LED cannot be represented by
> > the trigger, and so an error is returned.
> 
> I've used this series in my tree and implemented support for all LED-
> related features in the mediatek-ge-soc PHY driver:
> 
> https://github.com/dangowrt/linux/commit/3b9b30a9a6699d290964fc76c56cfcd1dadf5651
> 
> I've noticed there is a problem when setting up the netdev trigger using
> the 'linux,default-trigger' property in device tree. In this case
> led_classdev_register_ext is called *before* register_netdevice has
> completed.
> Hence supports_hw_control returns false when the 'netdev' trigger is
> initially setup as default trigger.
> 
> To resolve this, I've tried wrapping led_classdev_register_ext() and
> introducing led_classdev_register_ext_nodefault() which doesn't call
> out to led_trigger_set_default, so that can be done later by the
> caller. However, there isn't any good existing call from netdev to phy
> informing the phy that the netdev has been registered, so the phy_leds
> would have to register a netdevice_notifier and wait for the
> NETDEV_REGISTER events, matching against the netdev's PHY... And that
> seems a bit overkill, just to support netdev trigger offloading to work
> when used as a default trigger...
> 
> Any better ideas anyone?

Hi Daniel

I've not had chance to look at this yet. I really need to stop being
lazy and get my Marvell patches merged, the DT binding for defaults,
and then look at this ordering issue.

I do however agree, it is going to be messy, since as you say, the PHY
does not know what MAC it is bound to until quite late. Maybe we can
use the netdev_trig_notify() to update the value from
supports_hw_control()?

	Andrew

