Return-Path: <netdev+bounces-12713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C421A7389E8
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:41:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EB18281659
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D921952F;
	Wed, 21 Jun 2023 15:38:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B504719E44
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:38:35 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D14749B
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 08:38:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=NaVrleCmNiIJhauVDjhLqKO0DQ6jZX79IjchG5Pb8O8=; b=MtltV5usPsrBzwMsH04M8iUAAZ
	2R9rpT+9kegq9b72DZ3qpCK9B9EbB6BFuSE3vvLvEM5U0HNaDNcjF08fIslZCK5ukxcMJ2Ae4Nwjb
	ov0e+a/c8xcJQN5WUmdumrxdLh4mX1OFaA+TOMfZ6wT4vYXRTlbVsY9E/11t9SidQF+Q=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qBzbp-00H9gW-Hk; Wed, 21 Jun 2023 17:19:01 +0200
Date: Wed, 21 Jun 2023 17:19:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Simon Horman <simon.horman@corigine.com>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH net-next v1 1/3] led: trig: netdev: Fix requesting
 offload device
Message-ID: <864bfa14-ab8f-4953-873c-a9ad4721be22@lunn.ch>
References: <20230619215703.4038619-1-andrew@lunn.ch>
 <20230619215703.4038619-2-andrew@lunn.ch>
 <ZJL9I5rQlYFUZWPp@corigine.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZJL9I5rQlYFUZWPp@corigine.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> >  			set_device_name(trigger_data, name, strlen(name));
> >  			trigger_data->hw_control = true;
> > -			trigger_data->mode = mode;
> > +
> > +			rc = led_cdev->hw_control_get(led_cdev, &mode);
> > +			if (!rc)
> > +				trigger_data->mode = mode;
> 
> Is the case where trigger_data->hw_control is set to true
> but trigger_data->mode is not set ok?
> 
> I understand that is the whole point is not to return an error in this case.
> But I'm concerned about the value of trigger_data->mode.

Yes, its something Christian and I talked about off-list.
trigger_data->mode is 0 by default due to the kzalloc(). 0 is a valid
value, it means don't blink for any reason. So in effect the LED
should be off. And any LED driver which the ledtrig-netdev.c supports
must support software control of the LED, so does support setting the
LED off.

In the normal case hw_control_get() returns indicating the current
blink mode, and the trigger sets its initial state to that. If
however, it returns an error, it probably means its current state
cannot be represented by the netdev trigger. PHY vendors do all sort
of odd things, and we don't want to support all the craziness. So
setting the LED off and leaving the user to configure the LED how they
want seems like a reasonable thing to do.

And i tested this because my initial implementation of the Marvell
driver was FUBAR and it returned an error here.

     Andrew

