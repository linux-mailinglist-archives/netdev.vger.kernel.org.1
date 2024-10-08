Return-Path: <netdev+bounces-133314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7471A99596B
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147A91F2503A
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 21:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE370212D23;
	Tue,  8 Oct 2024 21:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Kn6yK5BP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7DF179954;
	Tue,  8 Oct 2024 21:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728423853; cv=none; b=N9SEZD5lf79nUw4a0sEMWqGZFuRQJooAQdkcciSLfDkvJrVWHBy8VSAh0BktRRrMzZc0odylpSoNEHvBJdqnAgsXCInVM85AgecnFOMkHk765y0bCvNZKOxRNXnquCoEJaxkUXxD29kXvsRVs7Y+z6TboLkklov6jCVIN6tNzPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728423853; c=relaxed/simple;
	bh=bSxfRdjNSCAsGuJt4Y5y6g1CCsz/0HcyzRHnXI/3DnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uAPviSekENJ4DJqDdZ8Ju4T6PIM/ELoy9W68Jb256jK/9csvyu88B4+rrteoz2C/q/LoX+zYzWhetwDOe6ej7iTASvWG6YhuXaxs+K7bSe8fBSTfPNzt9MMKvHFy155x+v8CGiTmx9Jscgf4FTlB2siqO5VDvvWrHfzRixVB/rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Kn6yK5BP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=C2AolDI/QsdVIj1Mg6RInVQZSGbZPeJ4njl4ckisiJ0=; b=Kn6yK5BP8Bsp+xyYOLEl+yNm6C
	rECb7Lc/OW4zE+iOecWbnhA2Qd2mMy84T7Tl+UTP45dxIVIkMPvQ5b76CBZ+CKsfkrhPhVrbM2Lm4
	QbZBFU7EE+rqjU9Hewhg3LKQ9+juvAXdTEWnu3BQ6g+oTNqDFRoLaPD5msVzP7IfL2xo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1syHzv-009PtL-DG; Tue, 08 Oct 2024 23:44:03 +0200
Date: Tue, 8 Oct 2024 23:44:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH net-next] net: phy: smsc: use
 devm_clk_get_optional_enabled_with_rate()
Message-ID: <0a794a82-3e79-4dcf-94fb-830dcf0a7380@lunn.ch>
References: <20241007134100.107921-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241007134100.107921-1-brgl@bgdev.pl>

On Mon, Oct 07, 2024 at 03:41:00PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Fold the separate call to clk_set_rate() into the clock getter.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

