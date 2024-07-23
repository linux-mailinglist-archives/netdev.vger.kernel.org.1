Return-Path: <netdev+bounces-112678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408AF93A8EB
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 23:54:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4431284052
	for <lists+netdev@lfdr.de>; Tue, 23 Jul 2024 21:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD63A145326;
	Tue, 23 Jul 2024 21:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="POdZ1Cd8"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E723113B58D;
	Tue, 23 Jul 2024 21:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721771683; cv=none; b=WeHtEpiyp6i/AeLFG7dgALz+QZFzpSOFKML8PhoJRGaiCshROwRdoeo23c2MkNbPq3aNVYQcPZPHsviZC3STjSbLDrewG6jdM6qCLYGKQctBhbUL9lHT0M5x7Fs3PGAG3oipQ6ARkhCO7v6u9BmjP+lMgX+aICF/W381YKuFajM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721771683; c=relaxed/simple;
	bh=KvwdOQUMMxHQO7D47N7FS4D/GKNRPEnXmFR6XE2OnzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=brRAAKLVPO6wa+K0/QtTgDKFNcWZPcxQGolNgJi4cpsCt6gGWGjzNr82upAgbVDMxp/QWjPnBUDMXI4SvYs5Aus18YodJk8G01wIk69cpAecQP7ya886QkFigkOiMKnB0I/qIdCjasK98byIevi+dDSwtVbyH6Pl46efyDgwvd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=POdZ1Cd8; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kcLa2jTpm4Is2gyMHHjkhy4HabJS4w3rCAg3RdWHqC8=; b=POdZ1Cd8AynOmoPH5N+GWyWNci
	gPzqvcTJsqgnevmZ2S4olw0F4SItGvc1HnW0MWrXSkuVBy8ved3J2XtgJli7CjNNjAgUrC1O+xAHP
	yzuINtNBgWw1iIP9ilaCkc+8JwmzGuDYLDghMstbf0Sv3VY3qWln/WtDLaTTHOgcv+o8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sWNSj-0035wz-64; Tue, 23 Jul 2024 23:54:25 +0200
Date: Tue, 23 Jul 2024 23:54:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
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
Message-ID: <af1d5373-6b88-488c-9b90-10c25cefd5d0@lunn.ch>
References: <38559102c729a811dc8a85f6c7cee07228cffd3e.1721739769.git.daniel@makrotopia.org>
 <125775a6-42f2-4294-9593-518ad6c852f7@lunn.ch>
 <ZqAk1NW4_E9SRjUO@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqAk1NW4_E9SRjUO@makrotopia.org>

On Tue, Jul 23, 2024 at 10:47:00PM +0100, Daniel Golle wrote:
> Hi Andrew,
> 
> On Tue, Jul 23, 2024 at 08:35:16PM +0200, Andrew Lunn wrote:
> > On Tue, Jul 23, 2024 at 02:04:02PM +0100, Daniel Golle wrote:
> > > Clocks for SerDes and PHY are going to be handled by standalone drivers
> > > for each of those hardware components. Drop them from the Ethernet driver.
> > 
> > Please could you explain in more details how this does not break
> > backwards compatibility. Should there also be a depends on, to ensure
> > the new driver is loaded? Will old DT blobs still work?
> 
> At this stage the Ethernet driver only supports the first MAC which
> is hard-wired to the built-in DSA switch.

> The clocks which are being removed for this patch are responsible for
> the for the SerDes PCS and PHYs used for the 2nd and 3rd MAC which
> are anyway not yet supported.

O.K. This last part, not yet supported, would of been good to have in
the commit message. It then makes it clear backwards compatibility is
not an issue, it never worked in the first place.

Thanks
	Andrew

