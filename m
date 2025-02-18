Return-Path: <netdev+bounces-167388-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8060A3A19D
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 16:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF701171ECD
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 15:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87E526D5DC;
	Tue, 18 Feb 2025 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="nSmgq1Zp"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45066263F36;
	Tue, 18 Feb 2025 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893489; cv=none; b=D6pQKcCxQiU7LCTCLfrINBWxcjwdVumIunyUt7zukDP1Xj8Euo8xWpYYImjmtxhI1Bw+bjqJrAr5vMVpfMI1jw9eGYMeRv1AY74iXWoXgs2yWuP4gSoxxtkUxLvmRZyNEYdkHH6UDRmg5GEua24+WliM2f3pUUot2iWnGsfP2ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893489; c=relaxed/simple;
	bh=DA5ovtBGbrhX0W3s/JS3ztwML238rN8ZFkY+jw4W/+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JD9rB7gY58v7krd/RdCgdyInNkgWLikLOml9Xy8VrOG3saSE1YAZv/2/A3MaAynPzO3FC8XHfyJyoejgh9N2SkQqX1sHW5LAA7eXqlZT8iwBJwfI8KOhmgX9pedEA1jFkOkcR2csSAIdXmVRx+pim5AhMg95TdM4N+Dri0+yM/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=nSmgq1Zp; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=0pQ5blC2+8DjxAh5O4SabJyjKzsTsXvGNXutRQEQZcw=; b=nSmgq1Zpt0SXPWsXRoB2EKcrv8
	f+hoG0nbGcUzTnGs0OGrCucNiZts+RB1Tgs2vIEkOXAlqMMH2VwEZRzNBWsIWJLkOdW1Iv7Ib1V7z
	Byty+ZJEazvoNsa0JrH+XVv9JmtBVG6ux5qlR8kFHi+TlAcet+OVrVhSLWN9n9yr0f0c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tkPm3-00FL5R-Ur; Tue, 18 Feb 2025 16:44:39 +0100
Date: Tue, 18 Feb 2025 16:44:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	shenjian15@huawei.com, wangpeiyang1@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	sudongming1@huawei.com, xujunsheng@huawei.com,
	shiyongbang@huawei.com, libaihan@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 net-next 6/6] net: hibmcge: Add ioctl supported in
 this module
Message-ID: <d1286c95-95ab-4138-806f-a448dc2f0d78@lunn.ch>
References: <20250218085829.3172126-1-shaojijie@huawei.com>
 <20250218085829.3172126-7-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250218085829.3172126-7-shaojijie@huawei.com>

On Tue, Feb 18, 2025 at 04:58:29PM +0800, Jijie Shao wrote:
> This patch implements the .ndo_eth_ioctl() to
> read and write the PHY register.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

