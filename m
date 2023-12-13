Return-Path: <netdev+bounces-57107-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D46812297
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 00:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437471F216C4
	for <lists+netdev@lfdr.de>; Wed, 13 Dec 2023 23:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 866868185F;
	Wed, 13 Dec 2023 23:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="dEpAotxw"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6504DD5;
	Wed, 13 Dec 2023 15:06:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=iLIaYmnFeaSAt+oehqvXb0rJqmTP/GxPnscvrauls0A=; b=dEpAotxwRFL6VfcTsV3BjfNlLf
	R0HwFimi0CGQoG+T+QMCJqeMVxxum72Y7ayvcMqp9wFztVnBEbraZ7CX4pZKtGafV+S1CpHPTjRab
	2Iy36dvYn+qgBEsQnwwKZnuJT+oN3GqHHblTCVuqkVLL+HiC4AvY0RGP5nRGrb8jcz38=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rDYIa-002rrh-MX; Thu, 14 Dec 2023 00:05:52 +0100
Date: Thu, 14 Dec 2023 00:05:52 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Kees Cook <keescook@chromium.org>,
	Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH 0/2] net: add define to describe link speed modes
Message-ID: <a4661402-414a-4b0d-82e8-97031fa46230@lunn.ch>
References: <20231213181554.4741-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213181554.4741-1-ansuelsmth@gmail.com>

On Wed, Dec 13, 2023 at 07:15:52PM +0100, Christian Marangi wrote:
> This is a simple series to add define to describe link speed modes.
> 
> Hope the proposed way is acceptable with the enum and define.
> 
> This is also needed in the upcoming changes in the netdev trigger for LEDs
> where phy_speeds functions is used to declare a more compact array instead
> of using a "big enough" approach.

I'm trying to figure out the 'big picture' here.

The LED trigger will call ksetting_get to get a list of supported link
modes. You can then use the table struct phy_setting settings[] in
phy-core.c to translate the link mode to a speed. You are likely to
get a lot of duplicate speeds, but you can remove them. For each speed
you need to create a sysfs file. Why not just create a linked list,
rather than an array? Or just walk the table and find out how many
different speeds there are and allocate an array of that size. Its
currently 15, which is not that big. And then just use the is_visible
method to hide the ones which are not relevant.

I don't see any need for new enums or tables here, just a function to
look up a link mode in that table and return the speed.

       Andrew

