Return-Path: <netdev+bounces-125925-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5634D96F468
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822C41C21CDE
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 12:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051CC1CB338;
	Fri,  6 Sep 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oQurWR6S"
X-Original-To: netdev@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88287158853
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 12:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725626353; cv=none; b=A+opVdlCAoPFImqnanCKNN8apfp+mFPkss4ti8uNw5PU//6G/AAFeZJe06urOHeSNVO+3R0hTecP7SJdtbHGSs+sI8RzHiB7FPpNvBhRkjfJZ5RGCV8sIKF1kjD8mkB/jsBP5iPhpu/Lz3VZKjBhcwsOLLuyBLGzhHe7jkOS1Gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725626353; c=relaxed/simple;
	bh=L88A3unnZlFkBG1PijGTOUqm4C6FixAt5EeW/JUpldw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5lrTZa7NRVtMs3WMPxz9aSkGWWyN9DeBbKaw/Kvqv0lD0F51ODZY7pBP6rJQ39sjm33Xvjz2f33in703asATYk1RJWZVYffPO0CjGq7dI85wPeoarg/1xqlqncMMUdGCJzp4chZYYZTSKN0GBItjX3IGkF1LqTb7cwqlO8hV8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=oQurWR6S; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9B0FFF805;
	Fri,  6 Sep 2024 12:39:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725626344;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xlI4z7LnIoqeMIG0WeiZzZAFqObGv4rhyPakboJsoIM=;
	b=oQurWR6SyHKPWaRjuFMWP0Sx+dl7a5x5Vx6t0jMY3rnoadF2/wfnxmdD09SzSkO/ucnDne
	oumkHJ0V5pnA4QyqSomzps0Bu5AQpdcJXZnnK3CFGOK/yVL7z+JtbTK9eXrrrCl4owCpx/
	glEW/lkD/vtgd/i4hemXi/17I1amcDkY2lc6DlzZTnLfPTpa+VbsA10Ao+MfeO3lBaJk11
	neTyOSXjULo4BKpaMTdzUWKy5+7R1he1nihe+mAjjvmYM9DjKvBit6n/yHuo9ESCKz7/Js
	dJ2UAXjF3en7Xu0WGi05Aa1T/HAD0bChX8LjNdOU/PRojXDL2hc4xDf88y+Vqw==
Date: Fri, 6 Sep 2024 14:39:02 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: "Tomas Paukrt" <tomaspaukrt@email.cz>
Cc: <netdev@vger.kernel.org>, "Andrew Lunn" <andrew@lunn.ch>, "Heiner
 Kallweit" <hkallweit1@gmail.com>, "Russell King" <linux@armlinux.org.uk>,
 "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni"
 <pabeni@redhat.com>, "Catalin Popescu"
 <catalin.popescu@leica-geosystems.com>, "Simon Horman" <horms@kernel.org>
Subject: Re: [PATCH net v2] net: phy: dp83822: Fix NULL pointer dereference
 on DP83825 devices
Message-ID: <20240906143902.7fde7593@device-28.home>
In-Reply-To: <66w.ZbGt.65Ljx42yHo5.1csjxu@seznam.cz>
References: <66w.ZbGt.65Ljx42yHo5.1csjxu@seznam.cz>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

On Fri, 06 Sep 2024 12:52:40 +0200 (CEST)
"Tomas Paukrt" <tomaspaukrt@email.cz> wrote:

> The probe() function is only used for DP83822 and DP83826 PHY,
> leaving the private data pointer uninitialized for the DP83825 models
> which causes a NULL pointer dereference in the recently introduced/changed
> functions dp8382x_config_init() and dp83822_set_wol().
> 
> Add the dp8382x_probe() function, so all PHY models will have a valid
> private data pointer to fix this issue and also prevent similar issues
> in the future.
> 
> Fixes: 9ef9ecfa9e9f ("net: phy: dp8382x: keep WOL settings across suspends")
> Signed-off-by: Tomas Paukrt <tomaspaukrt@email.cz>

That looks OK to me. Note that you must wait 24h between iterations,
to give everyone a chance to review.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

