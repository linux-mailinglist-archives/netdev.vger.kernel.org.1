Return-Path: <netdev+bounces-25188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA932773532
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 01:48:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE1C1C20DBB
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 23:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F125119893;
	Mon,  7 Aug 2023 23:48:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33F9168D3
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 23:48:55 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB74E9E
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 16:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pxdqxGiwlj8p1M06fi+QzMwMMYIYn3MDIPRIAwuspOU=; b=grhNEzSbWb+PB/HkBwU7EyZJO5
	Khed2BjxQo9kgyQE7nbGfy2ir3dn8Butg9shzvT/OUj0hti6/1Wlgj51ZHttqGi3iXxrISXeT4OFg
	lwd3SrKw40dx06NhekMD4BpyhiQb4P3AZ2oD+a89LgsrqAUfy08P0P5i9rPi1bJjU2Ac=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qT9xu-003PWo-KD; Tue, 08 Aug 2023 01:48:46 +0200
Date: Tue, 8 Aug 2023 01:48:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Simon Horman <simon.horman@corigine.com>,
	Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v2 net-next 1/3] led: trig: netdev: Fix requesting
 offload device
Message-ID: <912e0408-dc5a-44dc-87a1-dc1572c427d8@lunn.ch>
References: <20230624205629.4158216-1-andrew@lunn.ch>
 <20230624205629.4158216-2-andrew@lunn.ch>
 <ZLbpTWT0StW0AnqX@makrotopia.org>
 <d53dd9f4-b37f-4482-97e2-4e8a3fc6fea5@lunn.ch>
 <ZNF0_SvsUdk8Dvta@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNF0_SvsUdk8Dvta@makrotopia.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> So setting the brigthness should result in the trigger to be cleared
> back to 'none' then, and that would result in calling
> netdev_trig_deactivate if it was previously active.
> 
> Because otherwise, even if I take care of truning off all hardware
> triggers in the led_set_brightness call, the netdev trigger would
> still be selected.

I looked at edtrig-timer.c, which can offload the blinking to hardware
if it supports the needed op. Its deactivate function is:

static void timer_trig_deactivate(struct led_classdev *led_cdev)
{
        /* Stop blinking */
        led_set_brightness(led_cdev, LED_OFF);
}

So this does suggest the trigger should disable offload. v3 will do
similar.

	Andrew

