Return-Path: <netdev+bounces-28801-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39847780B9B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 14:16:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69FA01C2161B
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 12:16:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED7518AEA;
	Fri, 18 Aug 2023 12:16:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C23AB182B1
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 12:16:38 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD7E4216;
	Fri, 18 Aug 2023 05:16:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=YNNAiuiyjQM0aKUBYB8pkWssLs37+SVlo97PtIMIvSQ=; b=Yuz/ixHtPmL/xbOo4WY5uoYK9v
	GE80t63vdZwvVIqDw1o4Eys5X1OLhGColcCqH80XP/G6S7aOEYz50zzxkIQB3q5ES6dC5WYhRUA8T
	obOBRWICrC6xUn413/XtI3LPmNI0gSGLGkCurFgXT1SO4IVCUz5/Fk+54anQGGHT0wds=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qWyOo-004URv-S6; Fri, 18 Aug 2023 14:16:18 +0200
Date: Fri, 18 Aug 2023 14:16:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] net/ethernet/realtek: Add Realtek
 automotive PCIe driver code
Message-ID: <4b630aeb-3098-4108-b8dc-7da6e55a7cf1@lunn.ch>
References: <20230815143756.106623-1-justinlai0215@realtek.com>
 <20230815143756.106623-2-justinlai0215@realtek.com>
 <95f079a4-19f9-4501-90d9-0bcd476ce68d@lunn.ch>
 <4955506dbf6b4ebdb67cbb738750fbc8@realtek.com>
 <eb245c85-0909-4a75-830d-afb96ccd5d38@lunn.ch>
 <4951391892534eaeb2da96f052364e4c@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4951391892534eaeb2da96f052364e4c@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > Is the 'line' speed of the MAC fixed? It operates at one speed, and that is it?
> 
> Hi, Andrew
> 

> The "line" speed of the MAC is fixed 5G, but the throughput will be
> determined according to the speed of the PCIe link. For example, if
> the link speed is gen 3, the throughput will be 5G. if the link
> speed is gen 2, the throughput will be 2.5G. if the link speed is
> gen 1, the throughput will be 1G.

ksettings does not return throughput, it returns the line
speed. throughput is determined by a lot of different things, can the
CPU handle frames fast enough, is the memory bandwidth high enough,
what is happening on other ports of the PCIe switch etc.

There is at least one driver i know of which reports a warning at
probe time, if it finds the device is on a bus which cannot support
the full bandwidth. Maybe copy that.

> There is no extra fields in DMA descriptors for tagging
> protocol. The tag added by switch hardware instead of this driver.

> > Are the I2C, MDIO and SPI bus masters also hanging off a PCIE endpoint? Can
> > they probe independently? I'm just want to check this should not be part of an
> > MFD driver.
> 

> The I2C, MDIO and SPI bus masters are not hanging off the PCIE
> endpoints, but on the switch core.

So the switch core is also an PCIE endpoint? 

   Andrew

