Return-Path: <netdev+bounces-18034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C797544F1
	for <lists+netdev@lfdr.de>; Sat, 15 Jul 2023 00:27:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16EAB282303
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 22:27:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FE2220F96;
	Fri, 14 Jul 2023 22:27:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CF153AF
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 22:27:32 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5C22D48;
	Fri, 14 Jul 2023 15:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=GtEHO/Q5Yft3ebwH0TleGwrRN8mzf3QmoyzqWl6nYKM=; b=ym
	o0JOGxQh+RWTLHKKBgk/FszLD0slJ+4eMe5bujgGYhxet/rTB0QEnkKhFckrzTXcLLQy/EWlW282S
	Pxv5vXxwqKWIaBXMVsIeVOv78ReLBmgF8ekOB6tFU10kGvJRHRsjm/ow9MSjMRVd7KlBtNrfMzoNm
	uWQO8Nvn6SoKznw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qKRFw-001OX4-2q; Sat, 15 Jul 2023 00:27:20 +0200
Date: Sat, 15 Jul 2023 00:27:20 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alexandru Ardelean <alex@shruggie.ro>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	olteanv@gmail.com, marius.muresan@mxt.ro
Subject: Re: [PATCH v2 1/2 net-next] net: phy: mscc: add support for CLKOUT
 ctrl reg for VSC8531 and similar
Message-ID: <ab0ca942-5e84-4663-a0ed-689f023624b6@lunn.ch>
References: <20230713202123.231445-1-alex@shruggie.ro>
 <cad1d05d-acdd-454b-a9f8-06262cf8495b@lunn.ch>
 <CAH3L5QrtFwTqqFKjPrMFCz4JgUWOFWFUJXpN71Gyprcd33A7hg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH3L5QrtFwTqqFKjPrMFCz4JgUWOFWFUJXpN71Gyprcd33A7hg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Jul 14, 2023 at 09:09:14AM +0300, Alexandru Ardelean wrote:
> On Thu, Jul 13, 2023 at 11:35 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > +set_reg:
> > > +     mutex_lock(&phydev->lock);
> > > +     rc = phy_modify_paged(phydev, MSCC_PHY_PAGE_EXTENDED_GPIO,
> > > +                           VSC8531_CLKOUT_CNTL, mask, set);
> > > +     mutex_unlock(&phydev->lock);
> >
> > What is this mutex protecting?
> 
> This was inspired by vsc85xx_edge_rate_cntl_set().
> Which has the same format.

phy_modify_paged() locks the MDIO bus while it swaps the page, so
nothing else can use it. That also protects the read/modify/write.

Nothing is modifying phydev, so the lock is not needed for that
either.

> I'll re-test with this lock removed.
> I may be misremembering (or maybe I did something silly at some
> point), but there was a weird stack-trace warning before adding this
> lock there.
> This was with a 5.10.116 kernel version.

This patch is for net-next, please test there.

When testing for locking issues, and when doing development in
general, it is a good idea to turn on CONFIG_PROVE_LOCKING and
CONFIG_DEBUG_ATOMIC_SLEEP.

	Andrew

