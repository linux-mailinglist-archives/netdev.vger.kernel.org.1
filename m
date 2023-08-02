Return-Path: <netdev+bounces-23690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C99076D1D8
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 17:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DAA71C21317
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 15:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D819D310;
	Wed,  2 Aug 2023 15:24:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0171B79FF
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 15:24:15 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 52C1F44B6
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:23:52 -0700 (PDT)
Received: (qmail 207244 invoked by uid 1000); 2 Aug 2023 11:23:46 -0400
Date: Wed, 2 Aug 2023 11:23:46 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: "Gagniuc, Alexandru" <alexandru.gagniuc@hp.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
  "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
  "davem@davemloft.net" <davem@davemloft.net>,
  "edumazet@google.com" <edumazet@google.com>,
  "kuba@kernel.org" <kuba@kernel.org>,
  "pabeni@redhat.com" <pabeni@redhat.com>,
  "hayeswang@realtek.com" <hayeswang@realtek.com>,
  "jflf_kernel@gmx.com" <jflf_kernel@gmx.com>,
  "bjorn@mork.no" <bjorn@mork.no>,
  "svenva@chromium.org" <svenva@chromium.org>,
  "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
  "Zhang, Eniac" <eniac-xw.zhang@hp.com>,
  "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v2] r8152: Suspend USB device before shutdown when WoL is
 enabled
Message-ID: <fa2a3e71-be88-44d9-a955-94af236cf2c7@rowland.harvard.edu>
References: <2c12d7a0-3edb-48b3-abf7-135e1a8838ca@rowland.harvard.edu>
 <20230719173756.380829-1-alexandru.gagniuc@hp.com>
 <3c4fd3d8-2b0b-492e-aacc-afafcea98417@rowland.harvard.edu>
 <SJ0PR84MB2088F20891376312BA8D550A8F0BA@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR84MB2088F20891376312BA8D550A8F0BA@SJ0PR84MB2088.NAMPRD84.PROD.OUTLOOK.COM>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 02:56:43PM +0000, Gagniuc, Alexandru wrote:
> On Wed, Jul 19, 2023 at 02:36:25PM -0400, Alan Stern wrote:
> > On Wed, Jul 19, 2023 at 05:37:56PM +0000, Alexandru Gagniuc wrote:
> > > For Wake-on-LAN to work from S5 (shutdown), the USB link must be put
> > > in U3 state. If it is not, and the host "disappears", the chip will
> > > no longer respond to WoL triggers.
> > > 
> > > To resolve this, add a notifier block and register it as a reboot
> > > notifier. When WoL is enabled, work through the usb_device struct to
> > > get to the suspend function. Calling this function puts the link in
> > > the correct state for WoL to function.
> > 
> > How do you know that the link will _remain_ in the correct state?
> 
> The objective is to get to xhci_set_link_state() with the USB_SS_PORT_LS_U3
> argument. This is achieved through usb_port_suspend() in drivers/usb/host/hub.c,
> and the function is implemented in drivers/usb/host/xhci-hub.c.
> 
> This is the only path in the kernel that I am aware of for setting the U3 link
> state. Given that it is part of the USB subsystem, I am fairly confident it will
> show consistent behavior across platforms.

That does not answer my question.  I agree that making this change will 
put the link into the U3 state.  But I don't have any reason to think 
that some other software won't later put the link into some other state.

> > That is, how do you know that the shutdown processing for the USB host 
> > controller won't disable the link entirely, thereby preventing WoL from 
> > working?
> 
> We are talking to the USB hub in order to set the link state. I don't see how
> specifics of the host controller would influence behavior.

Specifics of the host controller probably won't influence behavior.  
However, specifics of the _software_ can make a big difference.

>  I do expect a
> controller which advertises S4/S5 in /proc/acpi/wakeup to not do anything that
> would sabotage this capability. Disabling the link entirely would probalby
> violate that promise.

Not if the kernel _tells_ the controller to disable the link.

> Think of USB-C docks with a power button showing up as a HID class. The scenario
> herein would disable the power button. I would take that to be a bug in the host
> controller driver if the S4/S5 capability is advertised.

Indeed.  And I am asking how you can be sure the host controller driver 
(or some other part of the software stack) doesn't have this bug.

Alan Stern

