Return-Path: <netdev+bounces-59193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C4C819CAE
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 11:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9BC8B254A5
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 10:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B31E220B3C;
	Wed, 20 Dec 2023 10:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EYC1gP4K"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D163B21356
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 10:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b34ebe86-c3bd-48ea-b76b-7b778cc7c086@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703067764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PuUMxESSlAY79Zm1lw0MIxlqWgE3nhfQmBY8/lvcl10=;
	b=EYC1gP4K3gqchSqcfad7iHoEOlvX7c3tXEGvXljRmEYjmKSSBusvehvRp24UnxodsBOELn
	qa2+7pjSYES3j0ep2ReFgO4BWmJp1tz+nMNyalqaKFdyLKcbGVwXatB7K9USbdFZ2wqz0f
	5c2KzoYAYz2D4lfDQxztZfgPchd7QGE=
Date: Wed, 20 Dec 2023 10:22:37 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v1] ptp: ocp: fix bug in unregistering the DPLL subsystem
Content-Language: en-US
To: Sagi Maimon <maimon.sagi@gmail.com>, richardcochran@gmail.com,
 jonathan.lemon@gmail.com, vadfed@fb.com, jiri@resnulli.us,
 arkadiusz.kubalewski@intel.com, davem@davemloft.net
Cc: netdev@vger.kernel.org
References: <20231220081914.16779-1-maimon.sagi@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20231220081914.16779-1-maimon.sagi@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 20/12/2023 08:19, Sagi Maimon wrote:
> When unregistering the DPLL subsystem the priv pointer is different then
> the one used for registration which cause failure in unregistering.
> 
> Fixes: 09eeb3aecc6c ("ptp_ocp: implement DPLL ops")
> ---
>   drivers/ptp/ptp_ocp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 4021d3d325f9..e7defce8cf48 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -4492,7 +4492,7 @@ ptp_ocp_remove(struct pci_dev *pdev)
>   	cancel_delayed_work_sync(&bp->sync_work);
>   	for (i = 0; i < OCP_SMA_NUM; i++) {
>   		if (bp->sma[i].dpll_pin) {
> -			dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, bp);
> +			dpll_pin_unregister(bp->dpll, bp->sma[i].dpll_pin, &dpll_pins_ops, &bp->sma[i]);
>   			dpll_pin_put(bp->sma[i].dpll_pin);
>   		}
>   	}

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

