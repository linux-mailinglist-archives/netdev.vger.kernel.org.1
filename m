Return-Path: <netdev+bounces-246644-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1A9CEFCAB
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 09:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 149B6300BBAB
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 08:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDC5718E02A;
	Sat,  3 Jan 2026 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="V2ZJ+66H"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC35D85C4A;
	Sat,  3 Jan 2026 08:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767429054; cv=none; b=SQ1cOl+J1mutvVC3nNTdJl4N/TTScMU2KcbOa+sZMP7SRz/8rOL9v42DuaVubs+m+23l8jZKftl31YAK+XpTqPkY2joOV2Kf2vKlZnig39EEeZa0EnRwmMiDkhsiw/yqFFqBzLhmvLFKO6EBYJ3TjT1TTDLzEsYaHt62SO0y1ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767429054; c=relaxed/simple;
	bh=W4/EEKH3tAkfd33VTTXrSjTh2XoUCbTt2g6NmLuRqkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZcPdahICtKFuqKKWageMQ4ZjwelUC7jrkSqr6i3moQQOXKvy4CoxGCUu/8/2YSd9zD7H8LtLe146BVUb0PpaWrUFNSDoGfTTi0B5pswShERIxSYHE7lSe/LmOlEFapWIP7ixfzGEynQlulw+s25VB3UXbtoBM2p6FoUuTesp7iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=V2ZJ+66H; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Upe3isB/Gl+xV2YsYulLR4EzMgXfGDiqIaeAB/5VGhc=; b=V2ZJ+66HaWObq+W9c1fxuIn+9Q
	LKQ7/K/dS0DOyk0BjBLsg9auh1kGMrXe5JqB0u9AdvOPBzIwa4T+PgIJHg5Y1qC0iTyrPoEcTe1um
	oJVRRj/vPjWG3m4erwtgKX3CFBPzSgBXLhw5bjzBtaVrOfd4UqNNFRr8vAoIWCc2xG3c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vbx23-001Fit-Pf; Sat, 03 Jan 2026 09:30:43 +0100
Date: Sat, 3 Jan 2026 09:30:43 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Sebastian Roland Wolf <Sebastian.Wolf@pace-systems.de>
Cc: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Sebastian Roland Wolf <srw@root533.premium-rootserver.net>
Subject: Re: [PATCH v2] net: mediatek: add null pointer check for hardware
 offloading
Message-ID: <6491ccf8-0318-421e-ba44-1565875e374c@lunn.ch>
References: <20260103005008.438081-1-Sebastian.Wolf@pace-systems.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260103005008.438081-1-Sebastian.Wolf@pace-systems.de>

On Sat, Jan 03, 2026 at 01:50:08AM +0100, Sebastian Roland Wolf wrote:
> From: Sebastian Roland Wolf <srw@root533.premium-rootserver.net>
> 
> Add a null pointer check to prevent kernel crashes when hardware
> offloading is active on MediaTek devices.
> 
> In some edge cases, the ethernet pointer or its associated netdev
> element can be NULL. Checking these pointers before access is
> mandatory to avoid segmentation faults and kernel oops.

Would it make sense to return EOPNOTSUPP, or maybe ENODEV? This does
seem like an error case.

     Andrew

