Return-Path: <netdev+bounces-144441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4443F9C74F4
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 15:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F14281F25FCE
	for <lists+netdev@lfdr.de>; Wed, 13 Nov 2024 14:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4221C1531EA;
	Wed, 13 Nov 2024 14:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TrfbnuXY"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B8413AA2D
	for <netdev@vger.kernel.org>; Wed, 13 Nov 2024 14:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731509951; cv=none; b=A176CSJ3EPSF2ZG0jkeXvNSx93OgiApmAzIQ+6TTDdkIUMHu8BMpS5MI/dxlNgFhjgVgrlZEzxb+Sa4Oie3ERlg5S4TiJ0puJT3QhDrebQ/fcnT2L5T62ebHpD+xKuEZifgwLI4xv2XZyuflPbvSmcKScpSmnGBktRbEEY5S/j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731509951; c=relaxed/simple;
	bh=esx3+gp6giuoSv55FGfF8nJwn5DJ2HORa2u7PFK+YjY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rl9FF5/bRHAeGExEsMF7waMuNJi7expONZgifI7Nmxy3K9QlX9Fq+H2TSw/YLLzGYQs/0aKSvtPnVOgGdZbYnbaaj21tebEeN1UqBE4moFStUDvkDBdkK+oy0ZmE8GuAu1W21///ryOIC2wnuUipKCoxp5u4QbVMUo/vgVmvw7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TrfbnuXY; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8c3b20fe-650b-4910-bf23-236e2b377d04@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1731509946;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+OoiRYmdt25DiYMmRNWGGRLGwaM28ebbuFL+WS9HUsI=;
	b=TrfbnuXYdOyykSoBMUoovS8eFoKHIvB8iV/6IYEqwumX++1qk89A9qrXdHIP2YXQC689lx
	fscFuJnp55jhAsBcXtaR1dt2VJScCSrtG3hPvb5yP6Anx1f9GAji3/94q9N28+Hywwqqxq
	In+FmT/1mlV2IGfpv/sDs5RCHZsHfOs=
Date: Wed, 13 Nov 2024 14:59:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v4 1/7] octeon_ep: Add checks to fix double free
 crashes
To: Shinas Rasheed <srasheed@marvell.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: hgani@marvell.com, sedara@marvell.com, vimleshk@marvell.com,
 thaller@redhat.com, wizhao@redhat.com, kheib@redhat.com, egallen@redhat.com,
 konguyen@redhat.com, horms@kernel.org,
 Veerasenareddy Burru <vburru@marvell.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Abhijit Ayarekar <aayarekar@marvell.com>,
 Satananda Burla <sburla@marvell.com>
References: <20241113111319.1156507-1-srasheed@marvell.com>
 <20241113111319.1156507-2-srasheed@marvell.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20241113111319.1156507-2-srasheed@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 13/11/2024 11:13, Shinas Rasheed wrote:
> From: Vimlesh Kumar <vimleshk@marvell.com>
> 
> Add required checks to avoid double free. Crashes were
> observed due to the same on reset scenarios, when reset
> was tried multiple times, and the first reset had torn
> down resources already.
> 
> Fixes: 37d79d059606 ("octeon_ep: add Tx/Rx processing and interrupt support")
> Signed-off-by: Vimlesh Kumar <vimleshk@marvell.com>
> Signed-off-by: Shinas Rasheed <srasheed@marvell.com>
> ---
> V4:
>    - Removed unnecessary protective code. Added fast return from
>      octep_free_irqs()
>    - Improved commit message
> 
> V3: https://lore.kernel.org/all/20241108074543.1123036-2-srasheed@marvell.com/
>    - Added back "Fixes" to the changelist
> 
> V2: https://lore.kernel.org/all/20241107132846.1118835-2-srasheed@marvell.com/
>    - No changes
> 
> V1: https://lore.kernel.org/all/20241101103416.1064930-2-srasheed@marvell.com/
> 
>   .../net/ethernet/marvell/octeon_ep/octep_main.c    | 14 ++++++++++----
>   drivers/net/ethernet/marvell/octeon_ep/octep_tx.c  |  2 ++
>   2 files changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> index 549436efc204..29796544feb6 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_main.c
> @@ -496,6 +496,9 @@ static void octep_free_irqs(struct octep_device *oct)
>   {
>   	int i;
>   
> +	if (!oct->msix_entries)
> +		return;
> +
>   	/* First few MSI-X interrupts are non queue interrupts; free them */
>   	for (i = 0; i < CFG_GET_NON_IOQ_MSIX(oct->conf); i++)
>   		free_irq(oct->msix_entries[i].vector, oct);
> @@ -505,7 +508,7 @@ static void octep_free_irqs(struct octep_device *oct)
>   	for (i = CFG_GET_NON_IOQ_MSIX(oct->conf); i < oct->num_irqs; i++) {
>   		irq_set_affinity_hint(oct->msix_entries[i].vector, NULL);
>   		free_irq(oct->msix_entries[i].vector,
> -			 oct->ioq_vector[i - CFG_GET_NON_IOQ_MSIX(oct->conf)]);
> +				oct->ioq_vector[i - CFG_GET_NON_IOQ_MSIX(oct->conf)]);

Looks like this chunk was unintended, it was perfectly aligned before...

>   	}
>   	netdev_info(oct->netdev, "IRQs freed\n");
>   }
> @@ -635,8 +638,10 @@ static void octep_napi_delete(struct octep_device *oct)
>   
>   	for (i = 0; i < oct->num_oqs; i++) {
>   		netdev_dbg(oct->netdev, "Deleting NAPI on Q-%d\n", i);
> -		netif_napi_del(&oct->ioq_vector[i]->napi);
> -		oct->oq[i]->napi = NULL;
> +		if (oct->oq[i]->napi) {
> +			netif_napi_del(&oct->ioq_vector[i]->napi);
> +			oct->oq[i]->napi = NULL;
> +		}

I would just add

if (!oct->oq[i]->napi)
	continue

as the first line within the loop. Otherwise debug message could be
misleading - deleting NAPI on queue which doesn't exist.

>   	}
>   }
>   
> @@ -666,7 +671,8 @@ static void octep_napi_disable(struct octep_device *oct)
>   
>   	for (i = 0; i < oct->num_oqs; i++) {
>   		netdev_dbg(oct->netdev, "Disabling NAPI on Q-%d\n", i);
> -		napi_disable(&oct->ioq_vector[i]->napi);
> +		if (oct->oq[i]->napi)
> +			napi_disable(&oct->ioq_vector[i]->napi);

And here again, the same pattern.

>   	}
>   }
>   
> diff --git a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
> index 06851b78aa28..157bf489ae19 100644
> --- a/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
> +++ b/drivers/net/ethernet/marvell/octeon_ep/octep_tx.c
> @@ -323,6 +323,8 @@ void octep_free_iqs(struct octep_device *oct)
>   	int i;
>   
>   	for (i = 0; i < CFG_GET_PORTS_ACTIVE_IO_RINGS(oct->conf); i++) {
> +		if (!oct->iq[i])
> +			continue;
>   		octep_free_iq(oct->iq[i]);
>   		dev_dbg(&oct->pdev->dev,
>   			"Successfully destroyed IQ(TxQ)-%d.\n", i);


