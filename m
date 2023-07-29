Return-Path: <netdev+bounces-22578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D66B57680F0
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 20:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8021D1C20A2D
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 18:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA9D174D1;
	Sat, 29 Jul 2023 18:24:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 407B417D3
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 18:24:16 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DB4430DC;
	Sat, 29 Jul 2023 11:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=SLDeV9Gd0ll0x0Hf3YTkvfpLnzT91YtzBOUBJcb/X+8=; b=3TU1y5Y8c+Axhgz66VEX8P6UcT
	riakLfdBFGt+BWlumDp30tDKIHGECoxfpHXvr4wvx4TpC+5f25wCf8O+nmtSGPg41Aahg9AQ6PwCL
	0iXh5nrYW/0SUYH3dA07Gro2G25TvnToaw9IStPi2glcXzQT2LIN9F4coyPmUIfStcO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qPobf-002bUX-Ex; Sat, 29 Jul 2023 20:23:59 +0200
Date: Sat, 29 Jul 2023 20:23:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 5/6] net: hns3: fix wrong print link down up
Message-ID: <e7219114-774f-49d0-8985-8875fd351b60@lunn.ch>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
 <20230728075840.4022760-6-shaojijie@huawei.com>
 <7ce32389-550b-4beb-82b1-1b6183fdeabb@lunn.ch>
 <2c6514a7-db97-f345-9bc4-affd4eba2dda@huawei.com>
 <73b41fe2-12dd-4fc0-a44d-f6f94e6541fc@lunn.ch>
 <ef5489f9-43b4-ee59-699b-3f54a30c00aa@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ef5489f9-43b4-ee59-699b-3f54a30c00aa@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

>     Now i wounder if you are fixing the wrong thing. Maybe you should be
>     fixing the PHY so it does not report up and then down? You say 'very
>     snall intervals', which should in fact be 1 second. So is the PHY
>     reporting link for a number of poll intervals? 1min to 10 minutes?
> 
>               Andrew
> 
> Yes, according to the log records, the phy polls every second,
> but the link status changes take time.
> Generally, it takes 10 seconds for the phy to detect link down,
> but occasionally it takes several minutes to detect link down,

What PHY driver is this?

It is not so clear what should actually happen with auto-neg turned
off. With it on, and the link going down, the PHY should react after
about 1 second. It is not supposed to react faster than that, although
some PHYs allow fast link down notification to be configured.

Have you checked 802.3 to see what it says about auto-neg off and link
down detection?

I personally would not suppress this behaviour in the MAC
driver. Otherwise you are going to have funny combinations of special
cases of a feature which very few people actually use, making your
maintenance costs higher.

	    Andrew

