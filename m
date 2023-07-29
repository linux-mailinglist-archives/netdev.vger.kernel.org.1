Return-Path: <netdev+bounces-22504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD222767D02
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 09:58:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075D32827AE
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 07:58:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7AF1FB0;
	Sat, 29 Jul 2023 07:58:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC0917E9
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 07:58:24 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E15CF3;
	Sat, 29 Jul 2023 00:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=jeX6gnaLyhsoAgNas3HST4lthFFpKYPYStpcK6Njo6g=; b=D1qdioZucg2bpafH4c1Mq9fc56
	W5GlUEtNAw+xQd2R6YXXqCGYRCTKIhIA9R7o9ZHQaCcUiZuZnZpLN75y9m/S0FxMJPkVyR8nAxl7I
	Uyf1LvfFCRDHCaLHAUpgUJIf5thNQUJvLMLbJOcKdVIwlQgB937aWKzNWQIJClTFEQn8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qPepr-002a1W-U6; Sat, 29 Jul 2023 09:57:59 +0200
Date: Sat, 29 Jul 2023 09:57:59 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: yisen.zhuang@huawei.com, salil.mehta@huawei.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	shenjian15@huawei.com, wangjie125@huawei.com,
	liuyonglong@huawei.com, wangpeiyang1@huawei.com,
	netdev@vger.kernel.org, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 5/6] net: hns3: fix wrong print link down up
Message-ID: <73b41fe2-12dd-4fc0-a44d-f6f94e6541fc@lunn.ch>
References: <20230728075840.4022760-1-shaojijie@huawei.com>
 <20230728075840.4022760-6-shaojijie@huawei.com>
 <7ce32389-550b-4beb-82b1-1b6183fdeabb@lunn.ch>
 <2c6514a7-db97-f345-9bc4-affd4eba2dda@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c6514a7-db97-f345-9bc4-affd4eba2dda@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, Jul 29, 2023 at 11:11:48AM +0800, Jijie Shao wrote:
> Hi Andrew,
> I understand what you mean, and sorry for my wrong description. The link
> is not always up. If I turn auto-neg off, the link will go down finally.
> However, there is an intervel between my operation and the link down. In
> my experiment, it may be 1 min or evn 10 mins. The phy state is set to
> PHY_UP immediately when I set auto-neg off. And the phy machine check the
> state during a very small intervals. Thus, during my experiment, the phy
> state has a followed varietion:
> PHY_RUNNING -> PHY_UP -> PHY_RUNNING -> PHY_NOLINK.
> 
> We print link up/down based on phy state and link state. In aboved case,
> It print looks like:
> eth0 link down -- because phy state is set to PHY_UP
> eth0 link up -- because phy state is set to PHY_RUNNING
> eth0 link down -- because link down
> 
> This patch wants to fix the first two wrong print.
> We will modify this patch description

Now i wounder if you are fixing the wrong thing. Maybe you should be
fixing the PHY so it does not report up and then down? You say 'very
snall intervals', which should in fact be 1 second. So is the PHY
reporting link for a number of poll intervals? 1min to 10 minutes?

	  Andrew


