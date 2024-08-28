Return-Path: <netdev+bounces-122800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7866396299B
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 16:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0531C23C01
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 14:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D507C188CC2;
	Wed, 28 Aug 2024 14:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gm3Zv5lT"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B953A176ABA;
	Wed, 28 Aug 2024 14:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724853808; cv=none; b=fRZpV5GSVKPWFOmX4tOP2IfxDEGYmOuzoHMFhadvT9f0fSewteOPeRkmKvCExKGckf1ll+QBpb8mVqMq0SbGZ2lqedlzYBNQkoRo3vYjN18/tIOg57wJbbNuoV1h9CxBo1OjfIHQSSsTNpWPguIChnP8StnFYYXquE9sfznpUeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724853808; c=relaxed/simple;
	bh=bCDA2OLhvtT5NvKB3PRKwz9R5Y16PPvE8RlwT39+U3w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q6WH3TwTHwsbqbLO6bucpueza4N+zizdgXunwZUyQS+2tTjyKdVNcLcnEdTYuOGisUe88Xwo18rCdrQFSXIdoDNhfD69ardZ45/gH5X6inufXGA1/D8oowsCNYYVPwv+QkUsp4DBk0CbF1A5SqCoNYei4gHhAiumZ5Bf5pV6zpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gm3Zv5lT; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 82AA21BF209;
	Wed, 28 Aug 2024 14:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724853798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X17P1T7VIyC/5Yzbs/EWY2YsIqMeZFR+ix7ybz6ledM=;
	b=Gm3Zv5lTtOQjTQ9tvnyZ10xQ21ogkqfsan2KZYbAHrJKqz5Tak5V6utCjGcSk7ZBxgI8xs
	mx4uHixYa7yQkzLf2gm+tQ2V9h06uNfWq5TJc8bVT3CdVgJ2WADS3dKGk/n3jYz/XPuIu3
	z/6aiNzSflHsSi2UXaqMN9mPhKL4ZLZfrr9dHbiOtGV+SmuJuu597SCIaG6Ee5mly91qr7
	+B4D+HoZULTxowPEmO13GRxB6OTvGp7i8l9upcaVeqO/HS950C4vdr2DiEIpFNV42t57YX
	eK1955Q+Rr9uAUqh4jeoFEP1vLgNqTVBH5AI8Gh1Qvt/9jFO5GiW42f99GZa4Q==
Date: Wed, 28 Aug 2024 16:03:15 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Aleksandr Mishin <amishin@t-argos.ru>
Cc: Vadym Kochan <vadym.kochan@plvision.eu>, Taras Chornyi
 <taras.chornyi@plvision.eu>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Oleksandr Mazur <oleksandr.mazur@plvision.eu>,
 Serhiy Boiko <serhiy.boiko@plvision.eu>, Volodymyr Mytnyk
 <volodymyr.mytnyk@plvision.eu>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net] net: marvell: prestera: Remove unneeded check in
 prestera_port_create()
Message-ID: <20240828160315.077e3428@device-28.home>
In-Reply-To: <20240828132606.19878-1-amishin@t-argos.ru>
References: <20240828132606.19878-1-amishin@t-argos.ru>
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

Hello Aleksandr,

On Wed, 28 Aug 2024 16:26:06 +0300
Aleksandr Mishin <amishin@t-argos.ru> wrote:

> prestera_port_create() calls prestera_rxtx_port_init() and analyze its
> return code. prestera_rxtx_port_init() always returns 0, so this check is
> unneeded and should be removed.
> 
> Remove unneeded check to clean up the code.
> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: 501ef3066c89 ("net: marvell: prestera: Add driver for Prestera family ASIC devices")
> Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
> ---
>  drivers/net/ethernet/marvell/prestera/prestera_main.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/prestera/prestera_main.c b/drivers/net/ethernet/marvell/prestera/prestera_main.c
> index 63ae01954dfc..2d4f6d03b729 100644
> --- a/drivers/net/ethernet/marvell/prestera/prestera_main.c
> +++ b/drivers/net/ethernet/marvell/prestera/prestera_main.c
> @@ -718,9 +718,7 @@ static int prestera_port_create(struct prestera_switch *sw, u32 id)
>  		}
>  	}
>  
> -	err = prestera_rxtx_port_init(port);
> -	if (err)
> -		goto err_port_init;
> +	prestera_rxtx_port_init(port);

If this function always return 0, you might as well change it to return
void. This would avoid future issues if one were to change
prestera_rxtx_port_init() to acually make it return something. It would
then become obvious that the caller doesn't check the return, whereas
with the current patch, we are simply ignoring it.

I also think you can target that patch to net-next, this isn't fixing
any bug, but rather cleans the code up.

Thanks,

Maxime

