Return-Path: <netdev+bounces-16174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A0374BB26
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 03:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A8541C21113
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 01:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D935E1108;
	Sat,  8 Jul 2023 01:51:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88377F
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 01:51:31 +0000 (UTC)
Received: from netrider.rowland.org (netrider.rowland.org [192.131.102.5])
	by lindbergh.monkeyblade.net (Postfix) with SMTP id 9262F212D
	for <netdev@vger.kernel.org>; Fri,  7 Jul 2023 18:51:28 -0700 (PDT)
Received: (qmail 1232616 invoked by uid 1000); 7 Jul 2023 21:51:27 -0400
Date: Fri, 7 Jul 2023 21:51:27 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexandru Gagniuc <alexandru.gagniuc@hp.com>, linux-usb@vger.kernel.org,
  netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
  pabeni@redhat.com, hayeswang@realtek.com, jflf_kernel@gmx.com,
  bjorn@mork.no, svenva@chromium.org, linux-kernel@vger.kernel.org,
  eniac-xw.zhang@hp.com, stable@vger.kernel.org
Subject: Re: [PATCH] r8152: Suspend USB device before shutdown when WoL is
 enabled
Message-ID: <2c12d7a0-3edb-48b3-abf7-135e1a8838ca@rowland.harvard.edu>
References: <20230706182858.761311-1-alexandru.gagniuc@hp.com>
 <20230707171225.3cb6e354@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230707171225.3cb6e354@kernel.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 07, 2023 at 05:12:25PM -0700, Jakub Kicinski wrote:
> On Thu,  6 Jul 2023 18:28:58 +0000 Alexandru Gagniuc wrote:
> > For Wake-on-LAN to work from S5 (shutdown), the USB link must be put
> > in U3 state. If it is not, and the host "disappears", the chip will
> > no longer respond to WoL triggers.
> >  
> > To resolve this, add a notifier block and register it as a reboot
> > notifier. When WoL is enabled, work through the usb_device struct to
> > get to the suspend function. Calling this function puts the link in
> > the correct state for WoL to function.
> 
> Would be good to hear from USB experts on this one, to an outside seems
> like something that the bus should be doing, possibly based on some
> driver opt-in..

The USB spec does not include any discussion of what things should be 
done when the system is turned off -- it doesn't even really acknowledge 
the existence of different system-wide power states.  As a result, the 
USB subsystem never developed any support for power-off callbacks or 
anything else of the sort.

Of course, this kind of thing can always be added.  But I don't think 
there's any way to distinguish (at the USB level) between wakeup from 
S5-off and wakeup from any other low-power system state.  And the PM 
part of the device model doesn't have multiple types of "enable-wakeup" 
flags -- either a device is enabled for wakeup or it isn't.

Alan Stern

