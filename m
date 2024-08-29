Return-Path: <netdev+bounces-123267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB76B964582
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 14:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6E6C2880E6
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 12:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3EF1AE04F;
	Thu, 29 Aug 2024 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="jQOCrviG"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21B1B1AE861;
	Thu, 29 Aug 2024 12:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724935875; cv=none; b=gRE/WTwAVAloBk353NtHiqUtW+1nwQG5ubxcMjk/3r++3/vRWooV72Qjt5jl6W/dDUiFxgnYRgTETzxZQ81KroiZf26yxuGTdKrvR9/zkWor9zxwLbt4xsCmpHgDgEG9QweztNor2kUk/7Xvwi9yU5mKMW0hoGL9jtRdpgccG9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724935875; c=relaxed/simple;
	bh=uay1tq/KaC1VxjxwxbfjE4Vb+7tLVaaq/oF39ukBKg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MxnWR5U6rSj7FL8dlc5xfutWjsO+FDFPLzqmqMz5ehjeaX7ga4S4qxra+4ujGcfizmp7M7lHn9TsuF1d2s15+SPue3qTsEGtz9ARA+5qOr9dlzKXgMzGYi+E60PD4NLLYDzwYIcB9ELmqStI6iVt36u6+IMRjdgN04zR3cS/cTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=jQOCrviG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Rc4FE6SeX7Q5CdpQHk0AVcFJTNneiwj+fMLYF+mxBQc=; b=jQOCrviGq8/lK0tdOdMx0HQMoJ
	Qx9NkUERJqfO/N4E5yolObLXoC56ntqiEaZNDCd4P/u22mM3C0kMBEY5x8CWzFs6/XCc5FGn5Nw2N
	xzJCn/F3w03A6d9If4aNnfumbw72p7SOhQpsBWXVEr7VTFpFR6w2bV7a+M3E8vO+IGdY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sjec6-006288-T6; Thu, 29 Aug 2024 14:50:58 +0200
Date: Thu, 29 Aug 2024 14:50:58 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: woojung.huh@microchip.com, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	justin.chen@broadcom.com, sebastian.hesselbarth@gmail.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com, wens@csie.org,
	jernej.skrabec@gmail.com, samuel@sholland.org,
	mcoquelin.stm32@gmail.com, hkallweit1@gmail.com,
	linux@armlinux.org.uk, ansuelsmth@gmail.com,
	UNGLinuxDriver@microchip.com, netdev@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	krzk@kernel.org, jic23@kernel.org
Subject: Re: [PATCH net-next v3 06/13] net: phy: Use
 for_each_available_child_of_node_scoped()
Message-ID: <96222bec-e364-41d1-a3a8-2d13fafe3a2c@lunn.ch>
References: <20240829063118.67453-1-ruanjinjie@huawei.com>
 <20240829063118.67453-7-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829063118.67453-7-ruanjinjie@huawei.com>

On Thu, Aug 29, 2024 at 02:31:11PM +0800, Jinjie Ruan wrote:
> Avoid need to manually handle of_node_put() by using
> for_each_available_child_of_node_scoped(), which can simplfy code.
> 
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

