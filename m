Return-Path: <netdev+bounces-45140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 327DC7DB189
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 00:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 621231C208CF
	for <lists+netdev@lfdr.de>; Sun, 29 Oct 2023 23:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7424C14F90;
	Sun, 29 Oct 2023 23:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="TcT1Rc44"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819DBD2ED
	for <netdev@vger.kernel.org>; Sun, 29 Oct 2023 23:45:25 +0000 (UTC)
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39DA49E;
	Sun, 29 Oct 2023 16:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=KaJzOtJRW4EWZHUOSEMMSs8gJwo3z32RgK/AsKPmB5E=; b=TcT1Rc44sOhOTrfiX4DFzUB0QX
	kiIDhy4VFO7soYj7F2TiwyIJ6KU4+HZboUkTX91Tjan6hFN5K6nsDjIZw+BgsMrbZC0+xayzBzbW9
	F/+6SBRckibKw6CF21tMyWjzUjksQgsikBGsO+MgImr3DT1aPvZuY6ZxdTZ60sitTiSM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1qxEly-000TGF-Dp; Mon, 30 Oct 2023 00:00:46 +0100
Date: Mon, 30 Oct 2023 00:00:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Vladimir Oltean <olteanv@gmail.com>, DENG Qingfang <dqfext@gmail.com>,
	Mauri Sandberg <sandberg@mailfence.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dsa: tag_rtl4_a: Bump min packet size
Message-ID: <54f8d583-e900-4ce8-87d1-a18556698f10@lunn.ch>
References: <20231027-fix-rtl8366rb-v1-1-d565d905535a@linaro.org>
 <20231028220402.gdsynephzfkpvk4m@skbuf>
 <CACRpkdbq03ZXcB-TaBp5Udo3M47rb-o+LfkEkC-gA1+=x1Zd-g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACRpkdbq03ZXcB-TaBp5Udo3M47rb-o+LfkEkC-gA1+=x1Zd-g@mail.gmail.com>

> 1496 is suspiciously much 1500 - DSA tag size. However the
> MTU of the parent ethernet is bumped nicely to 1504 and the
> device MTU is set up to accomodate it as well.
> 
> Modifying the patch to just pad out packets >= 1496 bytes
> solves the problem in a better way, but maybe that is not the
> last thing we try here...

Have you tried playing with RTL8366RB_SGCR in rtl8366rb_change_mtu()?

I had an annoying bug in the mv88e6xxx driver where the MTU
configuration register was up to, but not including... So i had to
change a <= to <.

	Andrew

