Return-Path: <netdev+bounces-12715-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E5C17389EE
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 17:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05FD51C20F27
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 15:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9B119914;
	Wed, 21 Jun 2023 15:38:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F2319913
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 15:38:55 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9898D269F;
	Wed, 21 Jun 2023 08:38:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=g3M0GxwQXCwbY8IKf+GhR6a1/PeDCgIa4nKET63i8YE=; b=W8xFdidOLI7BYLkyv6zyBefI/n
	2orXV6oLWaWWcr/Z1FWAw7zeFF6+uY1Io0uKXb5W8YopUnIxz5Dhz9kqNUnkUGiozUy0w7ze4sZIL
	GfpT7w+ySWoi9EFXxgl6uSYQoY12Z4TYoZgqyGXrAT5mn1qNFLUQwHsA4osS/i6NDyzQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qBzKZ-00H9aU-As; Wed, 21 Jun 2023 17:01:11 +0200
Date: Wed, 21 Jun 2023 17:01:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
	ansuelsmth@gmail.com, Russell King <rmk+kernel@armlinux.org.uk>,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: phy: Manual remove LEDs to ensure correct
 ordering
Message-ID: <e8b5259f-02e3-42c5-a872-c39fb8c7fd13@lunn.ch>
References: <20230617155500.4005881-1-andrew@lunn.ch>
 <8a41a15a-b832-3e66-d10a-df29f1a4c880@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a41a15a-b832-3e66-d10a-df29f1a4c880@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Thanks for fixing this, this is an improvement, though I can still hit
> another sort of use after free whereby the GENET driver removes the
> mdio-bcm-unimac platform device and eventually cuts the clock to the MDIO
> block thus causing the following:

Hi Florian

Yes, i was not expecting this patch to fix that. But i was getting the
NULL pointer dereference you pointed out with another setup, and this
change does fix that part of the problem.

> still not clear to me how the workqueue managed to execute and not finish
> before we unregistered the PHY device.

Me neither. I took a look at the MDIO bus driver and could not see
anything obvious. I think you are going to have to scatter printk() in
the code to get a clear understanding of the order things are done.
Maybe it is another devm_ timing issue.

      Andrew

