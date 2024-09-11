Return-Path: <netdev+bounces-127346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 211419752AF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 14:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9196282C3D
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 12:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53AE191F96;
	Wed, 11 Sep 2024 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="DiyLjsBo"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CA3185B48;
	Wed, 11 Sep 2024 12:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726058478; cv=none; b=D4ZolokrWbbkSEfaf5MwX7MbnrC7e18tdoMz0HU68yrUOEwOJTxrI8XeQs+6ZNwONkPNtHpTlWXwVvFOQmK6j9mHHEwUSILGmqJmpfIX9hwTLicg6pK3jRKgOhUHCmV05oZiCB8mry5TP9qV3tnOzGqzNJzozfYKENqTY7I5B1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726058478; c=relaxed/simple;
	bh=J489DUDsbDhHvffj3Hz54cCUgti88Qq9h18SA44ecWY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TlKhR3dgDCeOSTA14NOsE9oP8GYk7m8pQq064l3PtNVDpD9rFS0SZl+GOmy5mAVDxcazsvRsOtz4MT+KvQAYyqa+F/WUxPXoBAlCy0fT1ChNFw+QIfT8YYE0G7h7dAc/zm60ni0tp+05n5GWMErG4ziYYSIIdm1SWhI1wFGOkPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=DiyLjsBo; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 862E21BF204;
	Wed, 11 Sep 2024 12:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1726058468;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nzIh3UqGPCKxqgJ2w5mQokXAY94yF3qkRXmk6pC8R58=;
	b=DiyLjsBoEKZc2QM3BCQzL549S+mC0XPig9Og5qhHEV9eW2in5XNjTOVQs4XYTvWDWEweJG
	/pRr14qmI75ZkFDbxwxJZry4kIzdSFcxvqrIIs6Y5C68M0z9i1FDy0mcZ/67F13ikJNxwC
	PingGXPZScRuF4DyZuEEH1M4WsOg+xfYfq4OmENVgYOcMyz79+7dEe1VMIOYa7p4OGyFZs
	9aA0KtmVzaqeGbegPvZAzXgdLNUFmYJ/oGvNAnhRZKLoRta87pNehlRNMMUC36XSOqxbCd
	YcNqH4ktPDEmZDs/pwmend+L+aaL94TmXOD5UaQt/9ZAiSpYwpoVch6t5vJFSw==
Date: Wed, 11 Sep 2024 14:41:06 +0200
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Julien Blais <webmaster@jbsky.fr>
Cc: thomas.petazzoni@bootlin.com, davem@davemloft.net, kuba@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mvneta: fix "napi poll" infinite loop
Message-ID: <20240911144106.034b2f4a@fedora.home>
In-Reply-To: <20240911112846.285033-1-webmaster@jbsky.fr>
References: <20240911112846.285033-1-webmaster@jbsky.fr>
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

Hello Julien,

On Wed, 11 Sep 2024 13:28:46 +0200
Julien Blais <webmaster@jbsky.fr> wrote:

> In percpu mode, when there's a network load, one of the cpus can be
> solicited without having anything to process.
> If 0 is returned to napi poll, napi will ignore the next requests,
> causing an infinite loop with ISR handling.
> 
> Without this change, patches hang around fixing the queue at 0 and
> the interrupt remains stuck on the 1st CPU.
> The percpu conf is useless in this case, so we might as well remove it.
> 
> Signed-off-by: Julien Blais <webmaster@jbsky.fr>

If this patch is a fix, you must also include a "Fixes" tag stating
which commit you are fixing. You must also include in the subject
whether you are targetting the "net-next" tree or "net". In your case,
this would be the "net" tree, that gathers the bugfixes.

> ---
>  drivers/net/ethernet/marvell/mvneta.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 3f124268b..b6e89b888 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -3186,7 +3186,10 @@ static int mvneta_poll(struct napi_struct *napi, int budget)
>  
>  	if (rx_done < budget) {
>  		cause_rx_tx = 0;
> -		napi_complete_done(napi, rx_done);
> +		if (rx_done)
> +			napi_complete_done(napi, rx_done);
> +		else
> +			napi_complete(napi);

I don't quite get this patch. as napi_complete is just calling
napi_complete_done(napi, 0), so this is basically

if (rx_done != 0)
	napi_complete_done(napi, rx_done);
else
	napi_complete_done(napi, 0);

So, nothing actually changes.

Can you elaborate more on the issue you are facing ?

Thanks,

Maxime

