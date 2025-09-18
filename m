Return-Path: <netdev+bounces-224434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA89B84B59
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 14:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514B716F309
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 12:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21982304BAB;
	Thu, 18 Sep 2025 12:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="o2Ol/ol1"
X-Original-To: netdev@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54AE302178;
	Thu, 18 Sep 2025 12:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758200275; cv=none; b=AQrJ8pgLl/kR+sU/e20gkTWfcxlMKWSixyQWVSEyQY0Ersb5nTnD9oCwHSviLKLE4GpoX4RG0t75bQ5IfpNOwCZHn1szBkdCIeD+VTaQzRMcqvFWl6NU2tlWNZ5rv8e8psYAdk8/lSH5TUC5rAhfd6DgKebrMqJMQFndEFQgNmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758200275; c=relaxed/simple;
	bh=snlZt4lxBXR5SDj0JTQ/2l6XIsrf7LKZYStZkxPiVKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GLplIdpLzFwbzjzFsuSfTxgXpfkiby03ynTQAou/7t/f8MY9c9Hub3LXvuBMNweTVZuCQP5LjaA4M2wTeftqj6wU6D8vUFTzmdX5CKwaQyRcNtzuxreprAbZ+vAXUvNjCq2qqEIrW/pdAaU06ynQjeqB9NRD5yRxuMuZV4Ia/Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=o2Ol/ol1; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <10f0634f-06de-4a35-8341-5e35d4ce6205@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758200270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UjPRCnaKCH7BJUvHwVsP7fUGkzPKceI2zNdVsEjxJRs=;
	b=o2Ol/ol1rSy11t8Iqv0di2azzfpHHLDdUYMjrvkKsjd2gO4RURpqlWX9zXPJ/vSHxFfII9
	6YTnUFrucww60SlG6Ge7BXTv895jW19GXWHP1dAwNPT8GaezwksUNgDKiWdiGrMFaPx546
	hXu8NnaGijeQ61cYZ0LT2GiOyZhc0/U=
Date: Thu, 18 Sep 2025 13:57:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] hinic3: Fix NULL vs IS_ERR() check in
 hinic3_alloc_rxqs_res()
To: Dan Carpenter <dan.carpenter@linaro.org>, Fan Gong <gongfan1@huawei.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Zhu Yikai <zhuyikai1@h-partners.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <aMvUywhgbmO1kH3Z@stanley.mountain>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <aMvUywhgbmO1kH3Z@stanley.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 18/09/2025 10:45, Dan Carpenter wrote:
> The page_pool_create() function never returns NULL, it returns
> error pointers.  Update the check to match.
> 
> Fixes: 73f37a7e1993 ("hinic3: Queue pair resource initialization")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/net/ethernet/huawei/hinic3/hinic3_rx.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> index 6cfe3bdd8ee5..16c00c3bb1ed 100644
> --- a/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> +++ b/drivers/net/ethernet/huawei/hinic3/hinic3_rx.c
> @@ -414,7 +414,7 @@ int hinic3_alloc_rxqs_res(struct net_device *netdev, u16 num_rq,
>   		pp_params.dma_dir = DMA_FROM_DEVICE;
>   		pp_params.max_len = PAGE_SIZE;
>   		rqres->page_pool = page_pool_create(&pp_params);
> -		if (!rqres->page_pool) {
> +		if (IS_ERR(rqres->page_pool)) {
>   			netdev_err(netdev, "Failed to create rxq%d page pool\n",
>   				   idx);
>   			goto err_free_cqe;

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

