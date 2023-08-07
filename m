Return-Path: <netdev+bounces-25179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 409A67732EC
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 00:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0132810FB
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 22:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8AF17AB1;
	Mon,  7 Aug 2023 22:27:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACBB13AE6
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 22:27:15 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44CFCB1
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 15:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jhnpWvZoWQgugltqtg/Ett5kWIutXqRPTvKRQ6/Bhak=; b=kGDgHleDFsjkf+zs12YZAhg4Sv
	pxR0hmQZzKWZJdWDQWVoTA/GQyDd1F7bjGgw0+dTcs4O0uJuvPz2ViLyp/+2GCk4oSRiTyxsib6W0
	Mt4rFIn+3oXGmgnzNrfcHT5QGBk+vBPTtGmpLHfoxeZwYuUHYK0dKEC+uDg72oFtqmos=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qT8gw-003P0z-6W; Tue, 08 Aug 2023 00:27:10 +0200
Date: Tue, 8 Aug 2023 00:27:10 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Simon Horman <simon.horman@corigine.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 net-next 1/3] led: trig: netdev: Fix requesting
 offload device
Message-ID: <d53dd9f4-b37f-4482-97e2-4e8a3fc6fea5@lunn.ch>
References: <20230624205629.4158216-1-andrew@lunn.ch>
 <20230624205629.4158216-2-andrew@lunn.ch>
 <ZLbpTWT0StW0AnqX@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLbpTWT0StW0AnqX@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > +	if (supports_hw_control(led_cdev)) {
> >  		dev = led_cdev->hw_control_get_device(led_cdev);
> >  		if (dev) {
> >  			const char *name = dev_name(dev);
> >  
> >  			set_device_name(trigger_data, name, strlen(name));
> >  			trigger_data->hw_control = true;
> > -			trigger_data->mode = mode;
> > +
> > +			rc = led_cdev->hw_control_get(led_cdev, &mode);
> 
> Shouldn't there also be something like
> led_cdev->hw_control_get(led_cdev, 0);
> in netdev_trig_deactivate then?
> Because somehow we need to tell the hardware to no longer perform an
> offloading operation.

Hi Daniel

Back from vacation, so getting around to this now.

Interesting question. I would actually expect the trigger that takes
its place will set the brightness to what it wants it to default
it. It is documented that setting the brightness disables any offload.

Have you seen a real problem with changing triggers?

     Andrew

