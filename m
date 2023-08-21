Return-Path: <netdev+bounces-29322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 98F92782A44
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 15:16:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C121C20938
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94DE36FCA;
	Mon, 21 Aug 2023 13:14:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818E6FA7
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 13:14:18 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 073DE135;
	Mon, 21 Aug 2023 06:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=D+Evs2ldTgHIJLnwm1dUWAxe+Hr0v4gc4CgnDjem250=; b=WH3lLGhTpskfQMFY1y8k4SsKZp
	H7PpPcR0SJgpeou8r0qY3vusN9fkIuBT1whM7vwqtURxYVCJmeeXGEDukeelygBVkn6vUsrUDzf+6
	d8Nz6UE/wVpwajht70R4QERgTYwK8tW3L2Yyiq519XiBbPTOf4YsJG3PHLxu1K3roq4c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qY4iE-004goS-3A; Mon, 21 Aug 2023 15:12:54 +0200
Date: Mon, 21 Aug 2023 15:12:54 +0200
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
Message-ID: <97f3744d-afbf-4562-9168-5b9e211fac1f@lunn.ch>
References: <20230815143756.106623-1-justinlai0215@realtek.com>
 <20230815143756.106623-2-justinlai0215@realtek.com>
 <95f079a4-19f9-4501-90d9-0bcd476ce68d@lunn.ch>
 <4955506dbf6b4ebdb67cbb738750fbc8@realtek.com>
 <eb245c85-0909-4a75-830d-afb96ccd5d38@lunn.ch>
 <4951391892534eaeb2da96f052364e4c@realtek.com>
 <4b630aeb-3098-4108-b8dc-7da6e55a7cf1@lunn.ch>
 <6d35d56f78b7452b9330c3257748fa3c@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d35d56f78b7452b9330c3257748fa3c@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

> Sorry, please allow me to explain again.
> The RTL90xx Series supports I2C, MDC/MDIO and SPI slave to access the registers of Ethernet Switch Core and the external CPU could manage it via these pins.

I was wondering if you had mis-understood my question. The bus
'master' is the device which controls the bus. SPI and MDIO has one
bus master, and there can be multiple clients on the bus. I2C in
theory can have multiple bus masters on one bus, bit it is not done
too often. Your switch is a client.

So my question was, are the bus masters also on PCIE enpoints within
the chip. From an architecture standpoint, it would make sense they
are, all you need is one 4x PCIE slot, and this chip gives you
everything you need. But you can also make use of the SoCs I2C, SPI or
MDIO bus.

    Andrew

