Return-Path: <netdev+bounces-31935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D6B791901
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 15:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DF21C20862
	for <lists+netdev@lfdr.de>; Mon,  4 Sep 2023 13:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71768BA5F;
	Mon,  4 Sep 2023 13:44:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61689A925
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 13:43:58 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA4E1733
	for <netdev@vger.kernel.org>; Mon,  4 Sep 2023 06:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=xVtDMuyduIbc26acMzI5bTKVDosyTqvCLQl9XuiYYuc=; b=PN
	/7cwzZEmKgluJ5bNzZJAEGfzmTFSCW87/XO1sfllHuCNdnLYAJT/5Miqe6iieHjG3CjdG+HQ3/Qg1
	oRgor07i+JkmyC5ozt657dGitIVz79gIxAA0vjoP3q0mC8x+cSTQKosEFfypKGp+NX7ddwmIwazcp
	uIFHRoAhwwo5IMU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qd9r2-005k7x-Dl; Mon, 04 Sep 2023 15:43:00 +0200
Date: Mon, 4 Sep 2023 15:43:00 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: f.fainelli@gmail.com, davem@davemloft.net, edumazet@google.com,
	hkallweit1@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
	"shenjian15@huawei.com" <shenjian15@huawei.com>,
	"liuyonglong@huawei.com" <liuyonglong@huawei.com>,
	wangjie125@huawei.com, chenhao418@huawei.com,
	Hao Lan <lanhao@huawei.com>,
	"wangpeiyang1@huawei.com" <wangpeiyang1@huawei.com>
Subject: Re: [PATCH net-next] net: phy: avoid kernel warning dump when
 stopping an errored PHY
Message-ID: <fd08a80d-c70b-4943-8cca-b038f54f8eaa@lunn.ch>
References: <aed0bc3b-2d48-2fd9-9587-5910ad68c180@gmail.com>
 <8e7e02d8-2b2a-8619-e607-fbac50706252@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8e7e02d8-2b2a-8619-e607-fbac50706252@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 04, 2023 at 05:50:32PM +0800, Jijie Shao wrote:
> Hi all,
> We encountered an issue when resetting our netdevice recently, it seems
> related to this patch.
> 
> During our process, we stop phy first and call phy_start() later.
> phy_check_link_status returns error because it read mdio failed. The
> reason why it happened is that the cmdq is unusable when we reset and we
> can't access to mdio.

At what point in the flow below do you apply the reset which stops
access to the MDIO bus? Ideally you want to do phy_stop(), then apply
the reset, get the hardware working again, and then do a phy_start().

> 
> The process and logs are showed as followed:
> Process:
> reset process       |    phy_state_machine           |  phy_state
> ==========================================================================
>                     | mutex_lock(&phydev->lock);     | PHY_RUNNING
>                     | ...                            |
>                     | case PHY_RUNNING:              |
>                     | err = phy_check_link_status()  | PHY_RUNNING
>                     | ...                            |
>                     | mutex_unlock(&phydev->lock)    | PHY_RUNNING
>  phy_stop()         |                                |
>    ...              |                                |
>    mutex_lock()     |                                | PHY_RUNNING
>    ...              |                                |
>    phydev->state =  |                                |
>      PHY_HALTED;    |                                |  PHY_HALTED
>    ...              |                                |
>    mutex_unlock()   |                                |  PHY_HALTED
>                     | phy_error_precise():           |
>                     |   mutex_lock(&phydev->lock);   | PHY_HALTED
>                     |   phydev->state = PHY_ERROR;   | PHY_ERROR
>                     |   mutex_unlock(&phydev->lock); | PHY_ERROR
>                     |                                |
> phy_start()         |                                |  PHY_ERROR
>   ...               |                                |


	Andrew

