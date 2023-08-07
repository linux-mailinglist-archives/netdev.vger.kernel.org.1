Return-Path: <netdev+bounces-25181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6E9773312
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 00:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B7A131C20D8E
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 22:49:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432D0168DC;
	Mon,  7 Aug 2023 22:49:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399BC156D3
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 22:49:47 +0000 (UTC)
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E07F3
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 15:49:45 -0700 (PDT)
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.96)
	(envelope-from <daniel@makrotopia.org>)
	id 1qT92j-0002IH-2P;
	Mon, 07 Aug 2023 22:49:41 +0000
Date: Mon, 7 Aug 2023 23:49:33 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Simon Horman <simon.horman@corigine.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 net-next 1/3] led: trig: netdev: Fix requesting
 offload device
Message-ID: <ZNF0_SvsUdk8Dvta@makrotopia.org>
References: <20230624205629.4158216-1-andrew@lunn.ch>
 <20230624205629.4158216-2-andrew@lunn.ch>
 <ZLbpTWT0StW0AnqX@makrotopia.org>
 <d53dd9f4-b37f-4482-97e2-4e8a3fc6fea5@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d53dd9f4-b37f-4482-97e2-4e8a3fc6fea5@lunn.ch>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrew,

On Tue, Aug 08, 2023 at 12:27:10AM +0200, Andrew Lunn wrote:
> > > +	if (supports_hw_control(led_cdev)) {
> > >  		dev = led_cdev->hw_control_get_device(led_cdev);
> > >  		if (dev) {
> > >  			const char *name = dev_name(dev);
> > >  
> > >  			set_device_name(trigger_data, name, strlen(name));
> > >  			trigger_data->hw_control = true;
> > > -			trigger_data->mode = mode;
> > > +
> > > +			rc = led_cdev->hw_control_get(led_cdev, &mode);
> > 
> > Shouldn't there also be something like
> > led_cdev->hw_control_get(led_cdev, 0);
> > in netdev_trig_deactivate then?
> > Because somehow we need to tell the hardware to no longer perform an
> > offloading operation.
> 
> Hi Daniel
> 
> Back from vacation, so getting around to this now.
> 
> Interesting question. I would actually expect the trigger that takes
> its place will set the brightness to what it wants it to default
> it. It is documented that setting the brightness disables any offload.

So setting the brigthness should result in the trigger to be cleared
back to 'none' then, and that would result in calling
netdev_trig_deactivate if it was previously active.

Because otherwise, even if I take care of truning off all hardware
triggers in the led_set_brightness call, the netdev trigger would
still be selected.

> 
> Have you seen a real problem with changing triggers?

Yes, when manually switching from the netdev trigger to none (or
any other trigger), hardware offloading would remain active with
my implementation of the PHY LED driver[1] (which doesn't clear any
offloading related things but only sets/clears a FORCE_ON bit in its
led_set_brightness function).

[1]: https://github.com/dangowrt/linux/commit/439d52d7b80c97ff0c682ec68a70812030c3d79e


Cheers


Daniel

