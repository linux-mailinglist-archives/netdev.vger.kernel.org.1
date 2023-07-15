Return-Path: <netdev+bounces-18052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6BA75467A
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 05:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2277D1C2165E
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 03:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE02A5F;
	Sat, 15 Jul 2023 03:17:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE24E39D
	for <netdev@vger.kernel.org>; Sat, 15 Jul 2023 03:17:20 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 620782D51
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 20:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=n8mEYUpWOZ0cq46fhOobU2EvPlRGc2vIQJQ5QSB0gTY=; b=pElNYHFaPRtZb9ymaFh6NOi4xS
	TNfuILpiwvSN/80cucTqHGCMEwANzLj+gPg54WPTiv7BzNS9E9T9Eok0PX1Y9RJ7ZaQR5cRciXmHT
	n36P6mTxtBN1Jurb8m9K92MMiD0bPgQS/+iXoLHX6KEQPlx3PygfCy6meIG77hBi+WSw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qKVmX-001POB-DH; Sat, 15 Jul 2023 05:17:17 +0200
Date: Sat, 15 Jul 2023 05:17:17 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: SIMON BABY <simonkbaby@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: Query on acpi support for dsa driver
Message-ID: <4370398e-fe9b-44f6-bba5-c0bb2ead9d58@lunn.ch>
References: <21809053-8295-427b-9aff-24b7f0612735@lunn.ch>
 <F756A296-DD08-4FCB-9585-8D65A3D8857B@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F756A296-DD08-4FCB-9585-8D65A3D8857B@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 07:46:27PM -0700, SIMON BABY wrote:

> Thanks Andrew . So if I add a platform driver, will it get triggered
> by ACPI table or Device Tree or by some other mechanism?

There are a couple of options.

You can just load the module, e.g. via /etc/modules. That is the
simplest solution.

If your board has unique BIOS identity strings, you can use that to
trigger loading. e.g. look at drivers/platform/x86/pcengines-apuv2.c.

apu_gpio_dmi_table[] __initconst = {

        /* APU2 w/ legacy BIOS < 4.0.8 */
        {
                .ident          = "apu2",
                .matches        = {
                        DMI_MATCH(DMI_SYS_VENDOR, "PC Engines"),
                        DMI_MATCH(DMI_BOARD_NAME, "APU2")
                },
                .driver_data    = (void *)&board_apu2,
        },

But they BIOS strings need to be unique to your product. If you have a
generic ComExpress module for example as the core of your product, you
need to customise the BIOS strings. Otherwise this platform driver
module will be loaded for any product which happens to have that
ComExpress card, not just your product.

> My goal is to see all the switch ports in Linux kernel . The switch
> is connected via I2C bus .

Yes, that is the idea of DSA. You can treat the switch ports as Linux
interfaces. All you need is the control plain bus, i2c in your case,
and a 'SoC' Ethernet interface connected to one of the ports of the
switch. I say 'SoC' because such systems are typically ARM or MIPS
systems with an integrated Ethernet controller, but i guess you have a
PCIe NIC? i210 or something like that? That works equally as well.

     Andrew

