Return-Path: <netdev+bounces-34348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D2227A35C8
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 16:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 295811C208D2
	for <lists+netdev@lfdr.de>; Sun, 17 Sep 2023 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F3724A2E;
	Sun, 17 Sep 2023 14:11:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC4F1859
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 14:11:53 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C95121
	for <netdev@vger.kernel.org>; Sun, 17 Sep 2023 07:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6U2Rz+8AetsoIrc6VjbBwcOZjV8vBNigNMls4XT/ACg=; b=jgA2ub9icF8cvgOQggxBaI9HPr
	K30bTF94o/vH6n38cJpiiUH+EiyiDjjYa8N7H6jGdDL+WzvmdqbvYOxcA54l3LvxNV00usUpWGyPs
	xORzO9oU4Cv4ZcBaCXLPStKtOyALSnaCn6T2TTdkQgUgaVwZQdBsA7GVx0x5WcyRTheQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qhsV1-006hLg-Lj; Sun, 17 Sep 2023 16:11:47 +0200
Date: Sun, 17 Sep 2023 16:11:47 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Raju Rangoju <Raju.Rangoju@amd.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>, netdev@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Shyam-sundar.S-k@amd.com
Subject: Re: [PATCH net] amd-xgbe: read STAT1 register twice to get correct
 value
Message-ID: <13d692fb-1f89-4336-a53a-d5d07d81f6a6@lunn.ch>
References: <20230914041944.450751-1-Raju.Rangoju@amd.com>
 <4f54056f-dac4-4ad8-8f87-0837334d1b01@lunn.ch>
 <d6c6b06f-4f90-62da-7774-02b737198ce0@amd.com>
 <703cae60-5898-e602-f899-06d795b58705@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <703cae60-5898-e602-f899-06d795b58705@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Thanks, Tom.
> 
> The following thread (found online) has the detailed info on the IEEE 802.3
> Standard that define the Link Status bit:
> 
> https://microchip.my.site.com/s/article/How-to-correctly-read-the-Ethernet-PHY-Link-Status-bit

The relevant section for me is:

    Having a latched-low bit helps to ensure a link drop (no matter
    how short the duration before re-establishing link-up again) gets
    recorded and can be read from PHY register by the upper network
    layer (e.g., MAC processor).

By reading it twice, you are loosing the information the link went
down. This could mean you don't restart dhcp to get a new IP address
for a new subnet, kick of IPv6 getting the new network prefix so it
can create its IPv6 address etc.

When Linux is driving the PHYs using phylib, drivers are written such
that they report the latched link down. This gets report to the stack,
and so up to user space etc. phylib will then ask the driver a second
time to get the link status, and it might then return that the link is
now up. That then gets reported to the stack and user space.

As i said, you are not using phylib, this is not a linux PHY driver,
so i don't actually care what you do here. I just want to point out
why what you are doing could be wrong.

    Andrew

