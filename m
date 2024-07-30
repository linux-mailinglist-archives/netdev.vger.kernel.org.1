Return-Path: <netdev+bounces-114097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF0D940EE3
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E09FE28348D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D280197A86;
	Tue, 30 Jul 2024 10:22:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2131F208DA;
	Tue, 30 Jul 2024 10:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722334946; cv=none; b=SV5kHUMa/JEsiGcAYvPE+Jlh6ryIBoMpvzSnXkq2CGVC1U1Kc84ZzsQxPFTh6+2h/ry810VsYCCMvSkRlNTfTE+E7EDsiMNNb2rTrWLBPlZAo/OTbWy02vtit+P2klPemJRNJ+7zmna16u9SIAFNsg1jvsnZhfGksuAUPsvrel4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722334946; c=relaxed/simple;
	bh=BivS+la4gSjtSh1xdp30RqJ5DGQazYFqoa7A16gtlZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k1K0FapuMOEh0RdsUXLvls6EfsXNa0Zovdtw9pMPPgYEUKScM80pM1Feb8QqSBmV0WR892nrCUGfxUcRTLlVfzUus67ztWYdtQehoQbkSFhTkP+LZ2U4AJWCn2VLP/R1yZovmVDqwnoR8cmdkHNlisXuINBprQuhFEZRWuUMRV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1sYjzi-000000000f5-09Ad;
	Tue, 30 Jul 2024 10:22:14 +0000
Date: Tue, 30 Jul 2024 11:22:06 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Felix Fietkau <nbd@nbd.name>,
	Sean Wang <sean.wang@mediatek.com>,
	Mark Lee <Mark-MC.Lee@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2] net: ethernet: mtk_eth_soc: drop clocks unused by
 Ethernet driver
Message-ID: <Zqi-zr32ZXl0AyzR@makrotopia.org>
References: <5f7fc409ecae7794e4f09d90437db1dd9e4e7132.1722207277.git.daniel@makrotopia.org>
 <20240729190634.33c50e2a@kernel.org>
 <738f69e6-1e8d-4acc-adfa-9592505723fe@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <738f69e6-1e8d-4acc-adfa-9592505723fe@redhat.com>

On Tue, Jul 30, 2024 at 10:53:19AM +0200, Paolo Abeni wrote:
> On 7/30/24 04:06, Jakub Kicinski wrote:
> > On Mon, 29 Jul 2024 00:00:23 +0100 Daniel Golle wrote:
> > > Clocks for SerDes and PHY are going to be handled by standalone drivers
> > > for each of those hardware components. Drop them from the Ethernet driver.
> > > 
> > > The clocks which are being removed for this patch are responsible for
> > > the for the SerDes PCS and PHYs used for the 2nd and 3rd MAC which are
> > > anyway not yet supported. Hence backwards compatibility is not an issue.
> > 
> > What user visible issue is it fixing, then?
> 
> Indeed this looks like more a cleanup than a fix. @Daniel why net-next
> without fixes tag is not a suitable target here?

There is no user visible issue. I didn't know that this would be the
condition for going into 'net'. I will resend the patch to net-next.

