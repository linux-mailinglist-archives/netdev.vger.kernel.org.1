Return-Path: <netdev+bounces-225566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7B1B957BF
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 12:46:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9529D188EB2B
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 10:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29032F6576;
	Tue, 23 Sep 2025 10:46:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78887199EAD
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 10:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758624411; cv=none; b=E2saBxpV3QZmfOfgi7Z6K7jQ3nZRlmvDpLgQ2nNGKc8lL6qcT3YMVS4Sz4ICNN8QOH9e2wXs3UBDxQCbVPHaH7LvKNL7+o2HBFuvg8b9PFCG2CQUth64CTxcEnMq5yCUAGquxP/SV5kYw2pCgGN8Pr9nyvvk30BQAxh2zpxhTEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758624411; c=relaxed/simple;
	bh=4UjRc7e4GWxcOat/Xvn4GJ6ijLbkBC8w6lbD8XRmblQ=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=atlexEZSDx03B+ox5Hf99N85V3LbkbWPmf/1aKPGIJUjmHQzA/WmiGhPS0taec1dfluJCJMGufBVGQwCGTH76g/qMT5CIcTJpKS9ibztK22wDQP9S04us4Of3uFsvfF0u0au+YcmQIN6T3j+FrMnLGx4dTFJMtkzQwgUKJCf4yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cWGnz5Wdmz6L5D7;
	Tue, 23 Sep 2025 18:44:55 +0800 (CST)
Received: from dubpeml100005.china.huawei.com (unknown [7.214.146.113])
	by mail.maildlp.com (Postfix) with ESMTPS id D0D371402A5;
	Tue, 23 Sep 2025 18:46:45 +0800 (CST)
Received: from localhost (10.203.177.15) by dubpeml100005.china.huawei.com
 (7.214.146.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 23 Sep
 2025 11:46:44 +0100
Date: Tue, 23 Sep 2025 11:46:38 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Pavan Chebbi <pavan.chebbi@broadcom.com>
CC: <jgg@ziepe.ca>, <michael.chan@broadcom.com>, <dave.jiang@intel.com>,
	<saeedm@nvidia.com>, <davem@davemloft.net>, <corbet@lwn.net>,
	<edumazet@google.com>, <gospo@broadcom.com>, <kuba@kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<selvin.xavier@broadcom.com>, <leon@kernel.org>,
	<kalesh-anakkur.purayil@broadcom.com>
Subject: Re: [PATCH net-next v2 2/6] bnxt_en: Refactor aux bus functions to
 be generic
Message-ID: <20250923114638.00005498@huawei.com>
In-Reply-To: <20250923095825.901529-3-pavan.chebbi@broadcom.com>
References: <20250923095825.901529-1-pavan.chebbi@broadcom.com>
	<20250923095825.901529-3-pavan.chebbi@broadcom.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 dubpeml100005.china.huawei.com (7.214.146.113)

On Tue, 23 Sep 2025 02:58:21 -0700
Pavan Chebbi <pavan.chebbi@broadcom.com> wrote:

> Up until now there was only one auxiliary device that bnxt
> created and that was for RoCE driver. bnxt fwctl is also
> going to use an aux bus device that bnxt should create.
> This requires some nomenclature changes and refactoring of
> the existing bnxt aux dev functions.
> 
> Make aux bus init/uninit/add/del functions generic which will
> accept aux device type as a parameter. Change aux_dev_ids to
> aux_dev_rdma_ids to mean it is for RoCE driver.
> 
> Also rename the 'aux_priv' and 'edev' members of struct bp to
> 'aux_priv_rdma' and 'edev_rdma' respectively, to mean they belong
> to rdma.
> Rename bnxt_aux_device_release() as bnxt_rdma_aux_device_release()
> 
> Future patches will reuse these functions to add an aux bus device
> for fwctl.
> 
Hi Pavan,

It might just be a question of patch break up, but the code here
doesn't really match with what you suggest when talking about making these
functions generic.  They still have a lot of what looks to be unconditional
RDMA specific code in them after this patch.

I think if this 'generic' approach makes sense this patch needs to
be much clearer on what is rdma specific than it currently is. I'm not
yet convinced that this approach is preferable to a few helper functions
(for the generic bits) that rdma and fwctl specific registration functions call.

Thanks,

Jonathan



> Reviewed-by: Andy Gospodarek <gospo@broadcom.com>
> Signed-off-by: Pavan Chebbi <pavan.chebbi@broadcom.com>

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> index 992eec874345..665850753f90 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_ulp.c

I stopped reading that this point as the same issue on how generic things are
continued and would have lead to many similar comments.

> @@ -465,7 +466,8 @@ void bnxt_rdma_aux_device_add(struct bnxt *bp)
>  	}
>  }
>  
> -void bnxt_rdma_aux_device_init(struct bnxt *bp)
> +void bnxt_aux_device_init(struct bnxt *bp,

This confuses me a bit.  The patch description says it will make them
generic and this has a bunch of code that really doesn't look generic.

> +			  enum bnxt_ulp_auxdev_type auxdev_type)
>  {
>  	struct auxiliary_device *aux_dev;
>  	struct bnxt_aux_priv *aux_priv;
> @@ -473,14 +475,15 @@ void bnxt_rdma_aux_device_init(struct bnxt *bp)
>  	struct bnxt_ulp *ulp;
>  	int rc;
>  
> -	if (!(bp->flags & BNXT_FLAG_ROCE_CAP))
> +	if (auxdev_type == BNXT_AUXDEV_RDMA &&
> +	    !(bp->flags & BNXT_FLAG_ROCE_CAP))
>  		return;
>  
> -	aux_priv = kzalloc(sizeof(*bp->aux_priv), GFP_KERNEL);
> +	aux_priv = kzalloc(sizeof(*bp->aux_priv_rdma), GFP_KERNEL);
>  	if (!aux_priv)
>  		goto exit;
>  
> -	aux_priv->id = ida_alloc(&bnxt_aux_dev_ids, GFP_KERNEL);
> +	aux_priv->id = ida_alloc(&bnxt_rdma_aux_dev_ids, GFP_KERNEL);
>  	if (aux_priv->id < 0) {
>  		netdev_warn(bp->dev,
>  			    "ida alloc failed for ROCE auxiliary device\n");
> @@ -492,15 +495,15 @@ void bnxt_rdma_aux_device_init(struct bnxt *bp)
>  	aux_dev->id = aux_priv->id;
>  	aux_dev->name = "rdma";
>  	aux_dev->dev.parent = &bp->pdev->dev;
> -	aux_dev->dev.release = bnxt_aux_dev_release;
> +	aux_dev->dev.release = bnxt_rdma_aux_dev_release;

Another call that looks very rmda specific.
I would put these all under conditional checks even if that means
that if any other value is passed in for type the function doesn't
yet do anything useful.

>  
>  	rc = auxiliary_device_init(aux_dev);
>  	if (rc) {
> -		ida_free(&bnxt_aux_dev_ids, aux_priv->id);
> +		ida_free(&bnxt_rdma_aux_dev_ids, aux_priv->id);
>  		kfree(aux_priv);
>  		goto exit;
>  	}
> -	bp->aux_priv = aux_priv;
> +	bp->aux_priv_rdma = aux_priv;

As below. This feels like an odd thing to not make conditional on the type.

>  
>  	/* From this point, all cleanup will happen via the .release callback &
>  	 * any error unwinding will need to include a call to
> @@ -517,9 +520,10 @@ void bnxt_rdma_aux_device_init(struct bnxt *bp)
>  		goto aux_dev_uninit;
>  
>  	edev->ulp_tbl = ulp;
> -	bp->edev = edev;
> +	bp->edev_rdma = edev;

This seems to have a slightly odd mix of conditional assignment like
the ulp_num_msix_want below and unconditional assignment of clearly
RDMA specific things like evdev_rdma.

>  	bnxt_set_edev_info(edev, bp);
> -	bp->ulp_num_msix_want = bnxt_set_dflt_ulp_msix(bp);
> +	if (auxdev_type == BNXT_AUXDEV_RDMA)
> +		bp->ulp_num_msix_want = bnxt_set_dflt_ulp_msix(bp);
>  
>  	return;
>  
> diff --git a/include/linux/bnxt/ulp.h b/include/linux/bnxt/ulp.h
> index 7b9dd8ebe4bc..baac0dd44078 100644
> --- a/include/linux/bnxt/ulp.h
> +++ b/include/linux/bnxt/ulp.h
> @@ -20,6 +20,11 @@
>  struct hwrm_async_event_cmpl;
>  struct bnxt;
>  
> +enum bnxt_ulp_auxdev_type {
> +	BNXT_AUXDEV_RDMA = 0,
> +	__BNXT_AUXDEV_MAX,

Trivial but no point in a trailing comma after a entry that will always
terminate this list (like this one).  Having the comma just makes an
accidental addition of stuff after this harder to spot!


> +};



