Return-Path: <netdev+bounces-105866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D11E1913548
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 19:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52123B228DE
	for <lists+netdev@lfdr.de>; Sat, 22 Jun 2024 17:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D8FD271;
	Sat, 22 Jun 2024 17:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="3oOlZXfq"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4B81758E;
	Sat, 22 Jun 2024 17:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719076428; cv=none; b=QXJ5cCd09wR6TI/rJYmrtDKpcl0xecU9K7dD0wd/oDHUpTZpeQpD0YuWW6wuHO4lPv5/9+AEuEEoiBdqvTq0kawz1sRj5YVB/BNdTpRKC3sQ1JK/jqV6c9QPIcOOPIpr/L2fZznUCTD2YMQLiwe8BJXM6F01xcWfE2a+YAr7c1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719076428; c=relaxed/simple;
	bh=ZovY5y1XnfAbKtJ5bzxQpuwBmU+zQOEFKj7KcdHun2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KcNHxMbnZl0HtodnSZlE30PVCP1HPlQwsJKxRxa0B4Obmtj2LhWDcgaz+Fbc2sWBhK/skMbB7OGoTdCGEx7ZLaxTqIZ56lq5EjwyC6arj80prHAewN1CTRQWC1GV1ibiMrhvJii3MgkjI2kNTmyTHrV7GS2IvPeFAWtEZknaGxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=3oOlZXfq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=847f/ZnIKXbNlHObQkYopX8NCJDk0pRJ2ADO0zqverU=; b=3oOlZXfqDUt1UWpttkQElz15EA
	OlUA1h8hAbnjt4dNuj7V4CXRjCCUxZqtgdoZ4+jPRVg4vmQ2+nHTcuZRKtdKDi/5eB43rYa84uog1
	mNKCJ/JNqACGURy5KoBNgLkuxxX2i0i01eBdI8AsHv376idBnf4LR0vkA8P7crhuC9hk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sL4Ix-000jv8-Nj; Sat, 22 Jun 2024 19:13:35 +0200
Date: Sat, 22 Jun 2024 19:13:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sky Huang <SkyLake.Huang@mediatek.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Steven Liu <Steven.Liu@mediatek.com>
Subject: Re: [PATCH net-next v8 02/13] net: phy: mediatek: Fix spelling
 errors and rearrange variables
Message-ID: <5c350325-4f5d-449b-8db2-c9146f0cfc8f@lunn.ch>
References: <20240621122045.30732-1-SkyLake.Huang@mediatek.com>
 <20240621122045.30732-3-SkyLake.Huang@mediatek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240621122045.30732-3-SkyLake.Huang@mediatek.com>

On Fri, Jun 21, 2024 at 08:20:34PM +0800, Sky Huang wrote:
> From: "SkyLake.Huang" <skylake.huang@mediatek.com>
> 
> This patch fixes spelling errors which comes from mediatek-ge-soc.c and
> rearrange variables with reverse Xmas tree order.
> 
> Signed-off-by: SkyLake.Huang <skylake.huang@mediatek.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

