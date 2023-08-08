Return-Path: <netdev+bounces-25514-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 160947746B9
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 21:00:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1C3B1C20F4A
	for <lists+netdev@lfdr.de>; Tue,  8 Aug 2023 19:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB29D156CC;
	Tue,  8 Aug 2023 19:00:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA0D13FF5
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 19:00:17 +0000 (UTC)
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D1E29B79
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 11:37:22 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 39167865BC;
	Tue,  8 Aug 2023 20:37:19 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1691519840;
	bh=sLH95aL0FjYClYcJH6H+hrWMNlurD4VtFIqe41zhrr4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WBG5e4PFT/f6IdEBR9wTkYNzYqEMwXdkxH9/OZPbLOW2qFDH73OWn6NK8vfdszxS1
	 3HKX6gAwWVVGxC+KE/i2LZvhnKJRoU32cR3Y2aYWHWJxPcj58JKeW3Jlm8JBZ7766Z
	 raYF+T89tnGykk4fwR2UJ73alv6ev28ZKc5/xTSPd5xJ0+7/Vw8EvJhyTTai+dQfZw
	 Xhhnsqt6XQeCG1V3WVKiBq+kZy/J6mc6uvW3T3W7pPi2aatHg8WJ2L3o2FsNGhVsQC
	 bS0F0rFM0DIOvowZ9QbxWZRU2Z7ygyBSYbRZMImWsIUo8JFXPkr9+/pj7FF1Pzn/Q7
	 h1qO1mhPhN1rw==
Message-ID: <45b1ee70-8330-0b18-2de1-c94ddd35d817@denx.de>
Date: Tue, 8 Aug 2023 20:37:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] net: phy: at803x: Improve hibernation support on start up
To: Wei Fang <wei.fang@nxp.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, Heiner Kallweit <hkallweit1@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>
References: <20230804175842.209537-1-marex@denx.de>
 <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <AM5PR04MB3139793206F9101A552FADA0880DA@AM5PR04MB3139.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/8/23 10:44, Wei Fang wrote:
> Hi Marek,

Hi,

>> Toggle hibernation mode OFF and ON to wake the PHY up and make it
>> generate clock on RX_CLK pin for about 10 seconds.
>> These clock are needed during start up by MACs like DWMAC in NXP i.MX8M
>> Plus to release their DMA from reset. After the MAC has started up, the PHY
>> can enter hibernation and disable the RX_CLK clock, this poses no problem for
>> the MAC.
>>
>> Originally, this issue has been described by NXP in commit
>> 9ecf04016c87 ("net: phy: at803x: add disable hibernation mode support") but
>> this approach fully disables the hibernation support and takes away any power
>> saving benefit. This patch instead makes the PHY generate the clock on start
>> up for 10 seconds, which should be long enough for the EQoS MAC to release
>> DMA from reset.
>>
>> Before this patch on i.MX8M Plus board with AR8031 PHY:
>> "
>> $ ifconfig eth1 up
>> [   25.576734] imx-dwmac 30bf0000.ethernet eth1: Register
>> MEM_TYPE_PAGE_POOL RxQ-0
>> [   25.658916] imx-dwmac 30bf0000.ethernet eth1: PHY [stmmac-1:00]
>> driver [Qualcomm Atheros AR8031/AR8033] (irq=38)
>> [   26.670276] imx-dwmac 30bf0000.ethernet: Failed to reset the dma
>> [   26.676322] imx-dwmac 30bf0000.ethernet eth1: stmmac_hw_setup:
>> DMA engine initialization failed
>> [   26.685103] imx-dwmac 30bf0000.ethernet eth1: __stmmac_open: Hw
>> setup failed
>> ifconfig: SIOCSIFFLAGS: Connection timed out "
>>
> 
> Have you reproduced this issue based on the upstream net-next or net tree?

On current linux-next next-20230808 so 6.5.0-rc5 . As far as I can tell, 
net-next is merged into this tree too.

> If so, can this issue be reproduced? The reason why I ask this is because when
> I tried to reproduce this problem on net-next 6.3.0 version, I found that it could
> not be reproduced (I did not disable hibernation mode when I reproduced this
> issue ). So I guess maybe other patches in eqos driver fixed the issue.

This is what I use for testing:

- Make sure "qca,disable-hibernation-mode" is NOT present in PHY DT node
- Boot the machine with NO ethernet cable plugged into the affected port
   (i.e. the EQoS port), this is important
- Make sure the EQoS MAC is not brought up e.g. by systemd-networkd or
   whatever other tool, I use busybox initramfs for testing with plain
   script as init (it mounts the various filesystems and runs /bin/sh)
- Wait longer than 10 seconds
- If possible, measure AR8031 PHY pin 33 RX_CLK, wait for the RX_CLK to
   be turned OFF by the PHY (means PHY entered hibernation)
- ifconfig ethN up -- try to bring up the EQoS MAC
<observe failure>

[...]

