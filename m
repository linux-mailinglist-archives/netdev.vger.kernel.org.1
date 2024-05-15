Return-Path: <netdev+bounces-96468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200538C60E2
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 08:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18BB01C21622
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 06:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A0D3FBA7;
	Wed, 15 May 2024 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pd75HkEm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="varEdGvP"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C0D3D57D;
	Wed, 15 May 2024 06:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715755304; cv=none; b=dveRcIIblKMtOJcfGcTYYKud4vDdQnXDmwjQwpGWGfS19invTrv9e3qgfwzOs5sTdWGMSi2j2w+gnPixIXSKMT5B5N6r6lNzUYluO0bFsNCHT9gQGD3PE2zKvWZBrFd9V4iFK/RPCxd+4/SYXw8WELt77iK4DxAqHcM2E97bR6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715755304; c=relaxed/simple;
	bh=Ohn1QWuD3hXSwNdh6G51TarJNpVtb+Kw3FSPuiN8i50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ia5FFsozes7PMod2Y3d+eypdID100pbbnWnl7duq1N+1xm4qRIkOwGf69i+JSkJv63hgjL06jmkxzfVe1K6fDHAhEI3U/48Ltc3PjI/+urK31Wdjia/lyHitQ78ffbVZL0OgC5ZBKi+n+5Qz7HSvj+6ug0SQrh/WrTLJFXukDsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pd75HkEm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=varEdGvP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 May 2024 08:41:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715755300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sio4TZAEBlWZFidC5qng46z8XhrKeWRYfPlszR0wiFY=;
	b=Pd75HkEm8Fk++MIPte3Ib689xrqTVqJnkvEYJkgsDvUzbpysVYUPHV2/jlMU8HlODuWg/r
	UHDoxca5tLQEnRxqaT7gb0J9/aApdcCR6lnEZQDiYkuzl2WrGFKgX26tBnSJn/Wf1DAbpI
	cfYAi6JcKF11x77OCaB59KpALE/jz7YogPZBp4gy1nlDVA+MY+oSIdEbcTiGlB4nxvodg3
	w4Julu2a4bC2p1SCdcVTQw7EeGkJkWxVTHmbUXNPVqnKoxeK7+px4MlJjoVLl1m0lmZvU/
	cp1qpsiqNvB2yKkF3SNOr1yrtziKXQ+tmtpLLR3xB8e4Z6Mphki6MeyKd64jOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715755300;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sio4TZAEBlWZFidC5qng46z8XhrKeWRYfPlszR0wiFY=;
	b=varEdGvPU/kzLsy/+oGCdvuJBJ6bJV0koxFc0gab29K7iX/zd0709MV4JyUarw3AP4GDYV
	eW8ICv2ZuMMqVuBw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Lukasz Majewski <lukma@denx.de>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Oleksij Rempel <o.rempel@pengutronix.de>, Tristram.Ha@microchip.com,
	Ravi Gunasekaran <r-gunasekaran@ti.com>,
	Simon Horman <horms@kernel.org>,
	Nikita Zhandarovich <n.zhandarovich@fintech.ru>,
	Murali Karicheri <m-karicheri2@ti.com>,
	Arvid Brodin <Arvid.Brodin@xdin.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	"Ricardo B. Marliere" <ricardo@marliere.net>,
	Casper Andersson <casper.casan@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hsr: Setup and delete proxy prune timer only when
 RedBox is enabled
Message-ID: <20240515064139.-B-_Hf0_@linutronix.de>
References: <20240514091306.229444-1-lukma@denx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240514091306.229444-1-lukma@denx.de>

On 2024-05-14 11:13:06 [+0200], Lukasz Majewski wrote:
> The timer for removing entries in the ProxyNodeTable shall be only active
> when the HSR driver works as RedBox (HSR-SAN).
> 
> Moreover, the obsolete del_timer_sync() is replaced with
> timer_delete_sync().
> 
> This patch improves fix from commit 3c668cef61ad
> ("net: hsr: init prune_proxy_timer sooner") as the prune node
> timer shall be setup only when HSR RedBox is supported in the node.

Is it problematic to init/ delete the timer in non-redbox mode? It looks
easier and it is not a hotpath.

> Signed-off-by: Lukasz Majewski <lukma@denx.de>

Sebastian

