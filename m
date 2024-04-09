Return-Path: <netdev+bounces-86039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB19589D547
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 11:20:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2571BB217F9
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7AD97F474;
	Tue,  9 Apr 2024 09:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="cRBK2iOa"
X-Original-To: netdev@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A63B32B2DD
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 09:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654434; cv=none; b=RLbmiv8hTG1ToiMckEFVwhSoU0mCRUN/e10jhY2F88zzj8Erd5uxLcMZ9yhcWCv+FHC1R3mlPsE9YzZH7xx6zXtQZ0pRlb/p1hvbsh7W9X+fkpcW1R2ROxibosjMB6XOXQHajs8YJbNIqn76fpsH4Nvb2FQ1DTBx6zpdyt5HeH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654434; c=relaxed/simple;
	bh=7eSr9xMV7HF2iXiMDK9FF9N08SRi35qvGkY3hCh88wI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N5m8ypsqz89FsPS35U4Kb6TeMZmStLDftnK9Nnw4YT5Cu8UWbNwiSUrprkoAMskMF5eb0v7bFciCsxcXmo7x0Q8iQRH2cFLSwPZ0hv/JoLaYt2mRpRYidQoiXENonHGzEnVs4fkIgYjRb1VisZ1mmkJ3dpcI9NoEctApvHL+bhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=cRBK2iOa; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A29971C0004;
	Tue,  9 Apr 2024 09:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1712654430;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ajs3JfsuDGDVdP991mgTubXeqv6k1ZmOZ7kp7bC5KA=;
	b=cRBK2iOa2nNkSXPNfmtTgKyhK4xhE1T9Gm0evKyg9J7tjXbovmOHNZhrPQ/V3n0sk+M28N
	zDxko6zLlDUO0An4fCB1JLix893FFlXC3hQSmHYLuyfUVS7jO6TH3gtxzmEmvndMInhTQV
	rGpaqWa1j1WQAR5dxo9vo0EW5x6WH2iDigzncpxNeyVbo/jqhw6pobnNz0btocSnyQSnaH
	iXpjUDh8SeIKcgluiirLyenfxMwoyzQBL9qrQjjltlERPTtcqFk1DMjbBqIkiKpTgslbET
	dmwb+0IJo7R+B3zs+6byQpQWeKmmUZANmICVv2WDKmry+GCwu9KE/tAupoY2CA==
Date: Tue, 9 Apr 2024 11:20:27 +0200
From: Herve Codina <herve.codina@bootlin.com>
To: Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= <u.kleine-koenig@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kernel@pengutronix.de
Subject: Re: [PATCH net-next] net: wan: fsl_qmc_hdlc: Convert to platform
 remove callback returning void
Message-ID: <20240409112027.15c17572@bootlin.com>
In-Reply-To: <20240409091203.39062-2-u.kleine-koenig@pengutronix.de>
References: <20240409091203.39062-2-u.kleine-koenig@pengutronix.de>
Organization: Bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

On Tue,  9 Apr 2024 11:12:04 +0200
Uwe Kleine-König <u.kleine-koenig@pengutronix.de> wrote:

> The .remove() callback for a platform driver returns an int which makes
> many driver authors wrongly assume it's possible to do error handling by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource leaks.
> 
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all drivers
> are converted, .remove_new() will be renamed to .remove().
> 
> Trivially convert this driver from always returning zero in the remove
> callback to the void returning variant.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
> ---
> Hello,
> 
> the drivers below of drivers/net were already converted to struct
> platform_driver::remove_new during the v6.9-rc1 development cycle. This
> driver was added for v6.9-rc1 and so missed during my conversion.
> 
> There are still more drivers to be converted, so there is from my side
> no need to get this into v6.9, but the next merge window would be nice.
> 
> Best regards
> Uwe
> 
>  drivers/net/wan/fsl_qmc_hdlc.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 

Acked-by: Herve Codina <herve.codina@bootlin.com>

Best regards,
Hervé

