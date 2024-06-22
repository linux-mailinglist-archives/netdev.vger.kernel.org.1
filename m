Return-Path: <netdev+bounces-105892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19969913616
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 23:03:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A070B21677
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 21:03:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0327053E31;
	Sat, 22 Jun 2024 21:03:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED63C40847;
	Sat, 22 Jun 2024 21:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719090230; cv=none; b=F+Dz4b1+bmQ3N7410PxWhsqQMhd8QUN/PzBnib/9IgpaBXBNxF9Btl16N8ZNrCN2zKXdnMcG7PFDjGDL4mruRl/MynlyPQnBaAFzww1Es4Rt43Mbu/PNA8hLPjd0qU10S/zIxc2ZmxvgtHPRAplMTouGnagI4LImY6CuH/PI/as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719090230; c=relaxed/simple;
	bh=dlE2miFt5xef8WDzJ055d86Kazksl3tA5Z0SNaM9GlU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XMxCj/NVZ/K/LZcLvD4pCebBZC5aUbLZbz25jIQrcQtI6nTQsLrkFerBtloDVIlSlApZHhZEZLtp07l/I1780c4GCWttdf4pCMMXNq2UP4gpG0YEn6d978elVhx4h+bX4pkLKJHeVebWRlloKTDoboFyK9S01ZAsO70SQHNJoos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.97.1)
	(envelope-from <daniel@makrotopia.org>)
	id 1sL7tS-000000005kt-28az;
	Sat, 22 Jun 2024 21:03:30 +0000
Date: Sat, 22 Jun 2024 22:03:24 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Sky Huang <SkyLake.Huang@mediatek.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v8 06/13] net: phy: mediatek: Hook LED helper
 functions in mtk-ge.c
Message-ID: <Znc8HI6noTr7myYP@makrotopia.org>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
 <20240621122045.30732-7-SkyLake.Huang@mediatek.com>
 <e1ed191f-7c70-4c34-ad1f-40aaae18582b@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1ed191f-7c70-4c34-ad1f-40aaae18582b@lunn.ch>

On Sat, Jun 22, 2024 at 07:29:45PM +0200, Andrew Lunn wrote:
> > [...]
> > +	if (index > 1)
> > +		return -EINVAL;
> > +
> 
> It looks like this test could be moved into the common code. It seems
> like all variants have a single LED.

Exactly two LEDs, which is what index > 1 checks for, but yes, it
should be moved to common code.


