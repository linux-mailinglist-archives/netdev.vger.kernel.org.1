Return-Path: <netdev+bounces-58378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 738D3816195
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 19:22:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB621282A12
	for <lists+netdev@lfdr.de>; Sun, 17 Dec 2023 18:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CCD147A4B;
	Sun, 17 Dec 2023 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kNa2mq1Z"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8C5347F43
	for <netdev@vger.kernel.org>; Sun, 17 Dec 2023 18:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=a+SEjM8jPzus0exn5sWerBqdUPF0Sgk2hQTiTcrQcrY=; b=kNa2mq1Z/xDzTABTNvU5iB0zEE
	+cWMnB4uQrY236KIgkFEJ/sSkzfEDHU087tUKldZbcNzw6PIdiUxBpLjMZLWHCZ9eBc2PXrFvizCT
	X7iaBmpgD+Lhcwuav21tjgQmjhN9qeLc8UUrxqgaldThRQMEnafejY9J+zqrXDiHrtVo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rEvmZ-003AKL-J5; Sun, 17 Dec 2023 19:22:31 +0100
Date: Sun, 17 Dec 2023 19:22:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: David Ahern <dsahern@kernel.org>
Cc: Graeme Smecher <gsmecher@threespeedlogic.com>, davem@davemloft.net,
	netdev@vger.kernel.org, claudiu.beznea@tuxon.dev,
	nicolas.ferre@microchip.com, mdf@kernel.org
Subject: Re: net: ipconfig: dev_set_mtu call is incompatible with a number of
 Ethernet drivers
Message-ID: <43538a80-2b46-4fe2-9bb7-97d1e0f0c4c7@lunn.ch>
References: <f532722f-d1ea-d8fb-cf56-da55f3d2eb59@threespeedlogic.com>
 <58519bfa-260c-4745-a145-fdca89b4e9d1@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58519bfa-260c-4745-a145-fdca89b4e9d1@kernel.org>

On Fri, Dec 15, 2023 at 09:49:45AM -0800, David Ahern wrote:
> On 12/14/23 12:07 PM, Graeme Smecher wrote:
> > Hi all,
> > 
> > In a number of ethernet drivers, the MTU can't be changed on a running
> > device. Here's one example (from drivers/net/ethernet/cadence/macb_main.c):
> > 
> 
> ...
> 
> > 
> > So - what to do? I can see three defensible arguments:
> > 
> > - The network drivers should allow MTU changes on-the-fly (many do), or
> > - The ipconfig code could bring the adapter down and up again, or
> 
> looking at the ordering, bringing down the selected device to change the
> MTU seems the more reasonable solution.

But you need to review all the drivers and make sure there are none
which require the interface to be up in order to change the MTU.

So you might actually want to do is first try to change the MTU with
the interface up. If that fails, try it with it down. That should not
cause any regressions.

      Andrew

