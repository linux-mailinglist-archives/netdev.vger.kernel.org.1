Return-Path: <netdev+bounces-34094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E6B2F7A2121
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 16:35:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1FB81C21AB5
	for <lists+netdev@lfdr.de>; Fri, 15 Sep 2023 14:35:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E580230CE8;
	Fri, 15 Sep 2023 14:34:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4B130CE1
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 14:34:56 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12ED31FD2
	for <netdev@vger.kernel.org>; Fri, 15 Sep 2023 07:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jCih5l7W0pl5VWDv1Cys+jWiZkvzMww5lvb87zwoOBI=; b=KIvXNjnMsh+578h4wW+0VckH2S
	GwmDR7syVL7rHn0WJOws9JAJcxoekFNqsPXkzOaB8Wv1LSPjIdfcxzbkymLyergLG47jeSu1EVbMr
	VQILxRLQs8xsGDBD6g/Y1MhSczf7c+6ynD/mrB891vaEpCaJZJ3Pw0haBrFG1J0A6z8s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qh9u8-006YEH-TW; Fri, 15 Sep 2023 16:34:44 +0200
Date: Fri, 15 Sep 2023 16:34:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Fabio Estevam <festevam@gmail.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, l00g33k@gmail.com,
	netdev <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	sashal@kernel.org
Subject: Re: mv88e6xxx: Timeout waiting for EEPROM done
Message-ID: <5b5f24f4-f98f-4ea1-a4a3-f49c8385559d@lunn.ch>
References: <CAOMZO5AE3HkjRb9-UsoG44XL064Lca7zx9gG47+==GbhVPUFsw@mail.gmail.com>
 <8020f97d-a5c9-4b78-bcf2-fc5245c67138@lunn.ch>
 <CAOMZO5BzaJ3Bw2hwWZ3iiMCX3_VejnZ=LHDhkdU8YmhKHuA5xw@mail.gmail.com>
 <CAOMZO5DJXsbgEDAZSjWJXBesHad1oWR9ht3a3Xjf=Q-faHm1rg@mail.gmail.com>
 <597f21f0-e922-440c-91af-b12cb2a0b7a4@lunn.ch>
 <CAOMZO5BDWFtYu5iae7Gk-bF6Q6d1TV4dYZ=GtW_L_-CV8HapBg@mail.gmail.com>
 <333e23ae-fe75-48e1-a2fb-65b127ec9b3e@lunn.ch>
 <CAOMZO5AQ6VJi7Qhz4B0VQk5f2_R0bXB_RqipgGMBz9+vtHBMmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOMZO5AQ6VJi7Qhz4B0VQk5f2_R0bXB_RqipgGMBz9+vtHBMmg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Just checked with a scope here and no, the reset pin is not held in
> reset before the driver loads.
> 
> > aim of this code is not to actually reset the switch, but to ensure it
> > is taken out of reset if it was being held in reset. And if it was
> > being held in reset, i would expect that to be for a long time, at
> > least the current Linux boot time.
> 
> That's a point I am concerned about: why don't we follow the datasheet
> with respect to taking the reset pin out of reset?
> 
> Isn't the sequence I used below better suited as it follows the
> datasheet by guaranteeing the 10ms at a low level?
> 
>        chip->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>        ....
>        if (chip->reset) {
>                 usleep_range(10000, 20000);
>                 gpiod_set_value(chip->reset, 0);
>                 usleep_range(10000, 20000);
>        }

As i said, we do a hardware reset later. All we are trying to do at
this stage is probe the device, does it exist on the bus, and what ID
value does it have. I want to avoid the overhead of doing a reset now,
and then doing it again later.

So you say your device is not held in reset. So ideally there should
not be a change in the GPIO with devm_gpiod_get_optional(), and the
delay afterwards is pointless in your case.

When the device is held in reset, devm_gpiod_get_optional() should
release it from reset, and then we need a delay because experience has
shown the device will not actually respond on the MDIO bus for a short
while.

	Andrew

