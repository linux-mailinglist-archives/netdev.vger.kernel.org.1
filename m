Return-Path: <netdev+bounces-122312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A78960AC4
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 14:45:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EBDB1F23499
	for <lists+netdev@lfdr.de>; Tue, 27 Aug 2024 12:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E7021A08DF;
	Tue, 27 Aug 2024 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5xLXnYM/"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1571B1BA87C;
	Tue, 27 Aug 2024 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762709; cv=none; b=PQwykLScDR3YHI3YEoRF8liU9xfcS4MrSgWuzCXPDMh3ZKDsaHyqSQ90DtreSmwWhPLUar1DbLW6MhEQmYHijMjuikBDqHMRiDTFMdOAL8GlTS9sDopnOaYt8MINimc/zVYdJ/ZOUam6y8M5DukFIhlTn7ufYzsIplBlioAhAeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762709; c=relaxed/simple;
	bh=VIlEQ8qaYIISusFonWvkidLmO462Vg6NfZ8e8yNbIwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K+OSjk0XDP0q3hH5vh/YQUCKTSao8wATHl0kJLMG1t8WanIlmBXI+rM95PRnFYMfhMSo9OT38j3YvqW1d+rdPyDyJegmH3Gr1UwbKzMbkDPw+fHQ3eill2IZvxqmW8fBGj6VnSXjKn/OhtchSSvi89LeN7AMgSSCgeC7rosbhKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5xLXnYM/; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8WRlpCMgXoIIwolEONMHOv1APvXRFgdamq0EsOaiXe4=; b=5xLXnYM/RnGfAhdEbuJsu9dLpZ
	IB/XG8HY0Hyt+8NttCA8rGwBOl4u7930X7tkz6Yg/MjG4p5SIyAe1+P+NxL6B3nBvburcoDE+PxcV
	g0FlaKLasnCtPd6t/kkUIrIMtOVMzDilOTv2A8y3QV3VDajP8I2Lw37Asot7fe9AtS7c=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1sivYr-005ojV-5P; Tue, 27 Aug 2024 14:44:37 +0200
Date: Tue, 27 Aug 2024 14:44:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: woojung.huh@microchip.com, f.fainelli@gmail.com, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, linus.walleij@linaro.org, alsi@bang-olufsen.dk,
	justin.chen@broadcom.com, sebastian.hesselbarth@gmail.com,
	alexandre.torgue@foss.st.com, joabreu@synopsys.com,
	mcoquelin.stm32@gmail.com, wens@csie.org, jernej.skrabec@gmail.com,
	samuel@sholland.org, hkallweit1@gmail.com, linux@armlinux.org.uk,
	ansuelsmth@gmail.com, UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
	linux-stm32@st-md-mailman.stormreply.com, krzk@kernel.org,
	jic23@kernel.org
Subject: Re: [PATCH -next 0/7] net: Simplified with scoped function
Message-ID: <a5e18595-ede9-4a02-8aa5-a270d7d7a5d6@lunn.ch>
References: <20240827075219.3793198-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827075219.3793198-1-ruanjinjie@huawei.com>

On Tue, Aug 27, 2024 at 03:52:12PM +0800, Jinjie Ruan wrote:
> Simplify with scoped for each OF child loop and __free().

The Subject: should be [PATCH net-next], not -next. The CI looks at
this to decide which tree it belongs to. It issues a warning because
what you used does not match anything.

	Andrew

