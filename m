Return-Path: <netdev+bounces-38594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBBE17BB976
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 15:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18BED1C209BB
	for <lists+netdev@lfdr.de>; Fri,  6 Oct 2023 13:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACE2224DC;
	Fri,  6 Oct 2023 13:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="yKQkpi4T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF461F959
	for <netdev@vger.kernel.org>; Fri,  6 Oct 2023 13:44:31 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0AE8C6;
	Fri,  6 Oct 2023 06:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=j+o9YD/rH4lCweO3w6aErJlrY3wSbYk7WLC6xWXOuUE=; b=yKQkpi4TqAyIM2EQ2VF0C5etHx
	q4si8bPUVwwKmUP79r1bC5slCapWFqjQMUVMKjh+J8BlCEi1DsTk64mwpqH9SP9rd1n+U772UfCBZ
	bl4gDEKYafe3chxgUaapciz19pgqoec1Esonf9lVetPN2x1J6Exva2kAphcuRS6eCg/Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qol7q-0000t2-Aq; Fri, 06 Oct 2023 15:44:18 +0200
Date: Fri, 6 Oct 2023 15:44:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Justin Lai <justinlai0215@realtek.com>
Cc: "kuba@kernel.org" <kuba@kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v9 08/13] net:ethernet:realtek:rtase: Implement
 net_device_ops
Message-ID: <f4bcf3e9-d059-4403-a2b7-508806da9631@lunn.ch>
References: <20230928104920.113511-1-justinlai0215@realtek.com>
 <20230928104920.113511-9-justinlai0215@realtek.com>
 <b28a3ea6-d75e-45e0-8b87-0b062b5c3a64@lunn.ch>
 <99dfcd7363dc412f877730fab4a9f7dd@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99dfcd7363dc412f877730fab4a9f7dd@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> > > +static void rtase_tx_timeout(struct net_device *dev, unsigned int
> > > +txqueue) {
> > > +     rtase_sw_reset(dev);
> > 
> > Do you actually see this happening? The timeout is set pretty high, i think 5
> > seconds. If it does happen, it probably means you have a hardware/firmware
> > bug. So you want to be noisy here, so you get to know about these problems,
> > rather than silently work around them.
> 
> I would like to ask if we can dump some information that will help
> us understand the cause of the problem before doing the reset? And
> should we use netdev_warn to print this information?

You might want to look at 'devlink health'. 

    Andrew

