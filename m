Return-Path: <netdev+bounces-112675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DC293A8D4
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 23:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A39EB21F19
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 21:47:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB530147C82;
	Tue, 23 Jul 2024 21:47:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2256145FE9;
	Tue, 23 Jul 2024 21:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721771241; cv=none; b=aj+InhCZL6hRT+CQ6cG1hHbqBxvAnI2AHZB2vKR/XGGJ5N1KH6bMLIw/eg548fpGpTW8KlxTsQHVoOlivw2tcVAsCMUoU3qzp5b0aBfP7+klSAqz/nVQHZQ8zRZxDIAW5pBqnPSYP7nk2ofJBzSttX0He8qqjmRff2H/cphuSwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721771241; c=relaxed/simple;
	bh=xZjrLs8+I+Uxd2mYhKfa05Mbl8pflv30J5AQqjx1YxY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Om1gu/oqoWQBWo55TyGQ7k7HwWcdS9elFPqf0Y7mzQ2UOjhPg2fzTnx/mzB6M9gAzQxkh2sOh49+syrdWfVVjxuCuXvZkkkOGMbW+Qx+aWqkS1RwkRVaWiasztbQdImCfLFHvNgTTHa4lDXTom4jCmZnsURMrWNEUDs+Lqx9jEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sWNLh-000000004Ah-3eHt;
	Tue, 23 Jul 2024 21:47:09 +0000
Date: Tue, 23 Jul 2024 22:47:00 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net] net: ethernet: mtk_eth_soc: drop clocks unused by
 Ethernet driver
Message-ID: <ZqAk1NW4_E9SRjUO@makrotopia.org>
References: <38559102c729a811dc8a85f6c7cee07228cffd3e.1721739769.git.daniel@makrotopia.org>
 <125775a6-42f2-4294-9593-518ad6c852f7@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <125775a6-42f2-4294-9593-518ad6c852f7@lunn.ch>

Hi Andrew,

On Tue, Jul 23, 2024 at 08:35:16PM +0200, Andrew Lunn wrote:
> On Tue, Jul 23, 2024 at 02:04:02PM +0100, Daniel Golle wrote:
> > Clocks for SerDes and PHY are going to be handled by standalone drivers
> > for each of those hardware components. Drop them from the Ethernet driver.
> 
> Please could you explain in more details how this does not break
> backwards compatibility. Should there also be a depends on, to ensure
> the new driver is loaded? Will old DT blobs still work?

At this stage the Ethernet driver only supports the first MAC which
is hard-wired to the built-in DSA switch.
The clocks which are being removed for this patch are responsible for
the for the SerDes PCS and PHYs used for the 2nd and 3rd MAC which
are anyway not yet supported.

Those clocks are basically a left-over from the implementation found in
MediaTek's SDK which does all that inside the Ethernet driver and using
lots of syscon regmaps to access the various parts of the SoC.

This has been deemed unsuitable for inclusion in upstream Linux[1] and I
was asked to implement standalone PHY, CLK and PCS drivers instead,
which is obviously more clean and also results in the device tree being
more understandable.

By now, a CLK driver and a PHY driver (PHY as in drivers/phy, not
drivers/net/phy) has landed in upstream Linux([2], [3]), I'm currently
finalizing the PCS drivers which are going to be in charge of handling
the clocks which are now going to be removed from the Ethernet driver.

tl;dr: The clocks were added by mistake and features of the SoC using
them are up to now unsupported by vanilla Linux.

[1]: https://patchwork.kernel.org/comment/25517462/

[2]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=4b4719437d85f0173d344f2c76fa1a5b7f7d184b

[3]: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=ac4aa9dbc702329c447d968325b055af84ae1b59

