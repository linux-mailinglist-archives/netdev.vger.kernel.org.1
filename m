Return-Path: <netdev+bounces-143809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2294C9C444C
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 18:59:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC44628A464
	for <lists+netdev@lfdr.de>; Mon, 11 Nov 2024 17:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54771A726F;
	Mon, 11 Nov 2024 17:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ERCLKJ6d"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA59F1A76DA;
	Mon, 11 Nov 2024 17:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731347949; cv=none; b=M7ygWqiUFF6hCsYf1Hl94OtpJtK0a1hGYxutPhe5u3SnS33/aN4k4+YeQrNDvvCNKg5h5aEkcPzCQZHZIXSUm2/FuXJfBd2vTaYTnrMIPjo/BW0bNPAKz3YPDzQ3UC6FQWaOcY+N0Em5BK+XCF8t7GejP576GA1zgAC+AnEm2Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731347949; c=relaxed/simple;
	bh=GKPv7uaLkRyGhNMgI4RXzMllBpPlizjp7+sLaW/6K3w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BtLx5wJ97Qx3r3WWpp4aU73cYEhUb+xYWpcYanz6ghY4MohNi1HYaXGGDZ1hsTL3Fvi92iV5AseXeYY5yU7L+wYT/3MhRyCZU41QW/FQTogY6nlv65rhxDCaIjGHDmr/g6n37U13k5uL6ijf+tKmeXoVB91N977lYR+Gnj8ZJOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ERCLKJ6d; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eGD0oH4o0sjSq13no99a2tcCnImy1T3XGsfKOJMxAzY=; b=ERCLKJ6duXepx8HNMoJ+p54wIN
	fYmmRRfOP7Au4ybcVTbfCqg6xxqQU6jbvLmq7Vq9qqlsjvAczgbPqbhjPKW2Mk6XeMvs/lVsmcmtI
	wisLE8IrFwBrtzpv3ZLUv2IwIKTVCwmDtlifJVbReKpQtMxmJG5TCTfcku3DtUkejdXw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tAYgk-00Cv32-W4; Mon, 11 Nov 2024 18:58:58 +0100
Date: Mon, 11 Nov 2024 18:58:58 +0100
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
Subject: Re: [PATCH V3 net-next 5/7] net: hibmcge: Add pauseparam supported
 in this module
Message-ID: <efd481a8-d020-452b-b29b-dfa373017f1f@lunn.ch>
References: <20241111145558.1965325-1-shaojijie@huawei.com>
 <20241111145558.1965325-6-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241111145558.1965325-6-shaojijie@huawei.com>

On Mon, Nov 11, 2024 at 10:55:56PM +0800, Jijie Shao wrote:
> The MAC can automatically send or respond to pause frames.
> This patch supports the function of enabling pause frames
> by using ethtool.
> 
> Pause auto-negotiation is not supported currently.

What is actually missing to support auto-neg pause? You are using
phylib, so it will do most of the work. You just need your adjust_link
callback to configure the hardware to the result of the negotiation.
And call phy_support_asym_pause() to let phylib know what the MAC
supports.

	Andrew

