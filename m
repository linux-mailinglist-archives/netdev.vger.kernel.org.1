Return-Path: <netdev+bounces-30351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15089786FD4
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 15:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 462C21C20DDF
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 13:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4DB288F9;
	Thu, 24 Aug 2023 13:02:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600BED519
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 13:02:24 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3006E79
	for <netdev@vger.kernel.org>; Thu, 24 Aug 2023 06:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6a1yeikx9jaXhKILo9Z+ouxJkqTXegk/Dw2TudK6aZ0=; b=W2rUV2PDAw2XUEUVjHK6KObESO
	jMgQPHQOXDPVslhCic3F5a3p2SqGXnNYvLiOwMW6FiXD0ALWVn9t5oWF6d2ZXlIPs6xubFg4o9tj0
	2r/TnSIHFF2xn+LJMKNGHPKiD/Q5hycXmX/dojIYd80neZh3+DxDpnx9meBS6WkNYPnw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qZ9ya-004zIc-SV; Thu, 24 Aug 2023 15:02:16 +0200
Date: Thu, 24 Aug 2023 15:02:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, Jose.Abreu@synopsys.com,
	rmk+kernel@armlinux.org.uk, mengyuanlou@net-swift.com
Subject: Re: [PATCH net-next v3 7/8] net: txgbe: support copper NIC with
 external PHY
Message-ID: <8b142b43-65fa-465b-aa41-bd2200e71c63@lunn.ch>
References: <20230823061935.415804-1-jiawenwu@trustnetic.com>
 <20230823061935.415804-8-jiawenwu@trustnetic.com>
 <7d999689-cea9-4e66-8807-a04eb9ad4cb5@lunn.ch>
 <039101d9d62e$c97b21f0$5c7165d0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <039101d9d62e$c97b21f0$5c7165d0$@trustnetic.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 24, 2023 at 10:00:41AM +0800, Jiawen Wu wrote:
> On Wednesday, August 23, 2023 11:36 PM, Andrew Lunn wrote:
> > > +static int txgbe_phy_read(struct mii_bus *bus, int phy_addr,
> > > +			  int devnum, int regnum)
> > 
> > There is a general pattern to use the postfix _c45 for the method that
> > implements C45 access. Not a must, just a nice to have.
> > 
> > Does this bus master not support C22 at all?
> 
> It supports C22.

I was looking at how the two MDIO bus master implementations
differ. Once difference is a register write to set C22/C45, which this
code does not have. The second change appears to be a clock setting.

If you added C22, do the two become more similar? Should this actually
be one implementation in the library?

	Andrew

