Return-Path: <netdev+bounces-46057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E667B7E1061
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 17:46:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1117B20F15
	for <lists+netdev@lfdr.de>; Sat,  4 Nov 2023 16:46:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8CD1C686;
	Sat,  4 Nov 2023 16:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qwiKe7NY"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F4E3C34
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 16:46:49 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C517C136
	for <netdev@vger.kernel.org>; Sat,  4 Nov 2023 09:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=EvVJbpN4FYZPSgvZ/ZKgveJaQkfLU+MLMSTdkFyVk8U=; b=qwiKe7NYygvzEetF5K+aVA6j6v
	uCgB19KSei1QXdqj9QQ6ZZHuXBkehXfp1AQvNvr5Oo6s0ljgVaetSOzD2ZmM2WryolZ7NokQOABEX
	4LNue+ruKwlZ486X+1RC+hJ9EqSEQjzhQ+NI9BE2WpJDKkB422fgz+t1JTmt452Fb8Io=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qzJnI-000t61-Vf; Sat, 04 Nov 2023 17:46:44 +0100
Date: Sat, 4 Nov 2023 17:46:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Klaus Kudielka <klaus.kudielka@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>,
	Russell King <rmk+kernel@armlinux.org.uk>
Subject: Re: [PATCH] leds: triggers: netdev: add a check, whether device is up
Message-ID: <53f3e4ff-2afd-4acb-8cd4-55bdd1defd0d@lunn.ch>
References: <20231104125840.27914-1-klaus.kudielka@gmail.com>
 <0e3fb790-74f2-4bb3-b41e-65baa3b00093@lunn.ch>
 <95ff53a1d1b9102c81a05076f40d47242579fc37.camel@gmail.com>
 <970325157b7598b6367c293380cace3624e6cb88.camel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <970325157b7598b6367c293380cace3624e6cb88.camel@gmail.com>

On Sat, Nov 04, 2023 at 05:32:19PM +0100, Klaus Kudielka wrote:
> On Sat, 2023-11-04 at 16:27 +0100, Klaus Kudielka wrote:
> > 
> > phylink_start() is the first one that does netif_carrier_off() and thus
> > sets the NOCARRIER bit, but that only happens when bringing the device up.
> > 
> > Before that, I would not know who cares about setting the NOCARRIER bit.
> 
> A different, driver-specific solution could be like this (tested and working):
> 
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -5690,6 +5690,7 @@ static int mvneta_probe(struct platform_device *pdev)
>         /* 9676 == 9700 - 20 and rounding to 8 */
>         dev->max_mtu = 9676;
>  
> +       netif_carrier_off(dev);
>         err = register_netdev(dev);
>         if (err < 0) {
>                 dev_err(&pdev->dev, "failed to register\n");
> 
> 
> Would that be the "correct" approach?

Crossing emails.

Its a better approach. But it fixes just one driver. If we can do this
in phylink_create(), we fix it in a lot of drivers with a single
change...

	Andrew

