Return-Path: <netdev+bounces-98343-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39708D0FFC
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 00:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8ECA41C21237
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 22:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 227B65380F;
	Mon, 27 May 2024 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="4gz2wLZF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA3B1754B;
	Mon, 27 May 2024 22:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716847489; cv=none; b=mn7mTV7J8kGKgFPZFvmaFcCcMLulOuWvDPh4kUdUcRwKm0AmNP38MvCkCMV0ylwmR3wWRwPt1n4V4ox3JZY5qF+0B2uaDttsxhyK5BpqBKMUwzjaMMi4+oCUXeTqK2o89zOf/w3gi+IGMvvR7GAXoovwaZCyUmVD7gnXo1AP61k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716847489; c=relaxed/simple;
	bh=4id6nwrH30cfb7kbRwgCZMpR9t+BkTu7eYCDXgeizbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tQm7Rug8brAOXyO4cM3f+dObK/lclerygxYF/f9Udp6w1xWwWSTmAq6zGveAWQBAwjrs1LToQCxqfCBH6suKhvZots9NrHy1E8h9oOA2ZL/OzhlAJ+dBMYzSmNUVpUm386CQSkZyfuVo9pIw2oKHgz+d+xeX++gg3CVG8ze2J8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=4gz2wLZF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ViXsFVHEpafS5EmxmYJWnIhjbXPQX8peMdEzB/gglf8=; b=4gz2wLZFxJ9C3AfaGWJjrdQYr6
	y4xNFz4d1B8KdxB3BRdDWFj5GuKH0kegvFgevXQ0Rnh3eb8IZTm7y8IWGz1Xiup07Jr0ieeiQPr5L
	9GIK/NxNVSiQ7AOsMIuuoFdfVlUtuJiHFLvJrg9OW/9AanlkFGXMhhJHvVqEAPr6/7YU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sBiS9-00G6lY-7V; Tue, 28 May 2024 00:04:25 +0200
Date: Tue, 28 May 2024 00:04:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: MD Danish Anwar <danishanwar@ti.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
	Jan Kiszka <jan.kiszka@siemens.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>, Diogo Ivo <diogo.ivo@siemens.com>,
	Roger Quadros <rogerq@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, srk@ti.com,
	Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH net-next v5 1/3] net: ti: icssg-prueth: Add helper
 functions to configure FDB
Message-ID: <3cf97632-4d77-4f28-bed6-7d40d61d958f@lunn.ch>
References: <20240527052738.152821-1-danishanwar@ti.com>
 <20240527052738.152821-2-danishanwar@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240527052738.152821-2-danishanwar@ti.com>

> +struct mgmt_cmd {
> +	u8 param;
> +	u8 seqnum;
> +	u8 type;
> +	u8 header;
> +	u32 cmd_args[3];
> +} __packed;

There is a general dislike for __packed. Since your structures are
naturally well aligned, it is probably not needed. You could be
paranoid and add BUILD_BUG_ON(sizeof(struct mgmt_cmd) != 16);

	 Andrew

