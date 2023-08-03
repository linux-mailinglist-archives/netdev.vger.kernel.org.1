Return-Path: <netdev+bounces-24167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6420576F0F5
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 19:56:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9615B1C215D3
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 17:56:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECAB2516D;
	Thu,  3 Aug 2023 17:55:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8201F16D
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 17:55:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA11BC433C7;
	Thu,  3 Aug 2023 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691085356;
	bh=4Ld8BAA+kCjrI9UjzRHJmebdxcphDEau9AAkrxrmt0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jcEqo1ttrHtdrmdbxjI4EIrA4Rp4zLKc4mTyg0RFpWsDA49uQ2wTILEfw2qBtW9A1
	 c6itAceQ7mGduut5TpowbfaNjCnBFQIRzg4EaDcdowIu4YqjpYipidJIhm7v31xk8g
	 ELd2Y7l0nN3yVnQ+0gpmrAm+KdnG30Bbej04iRusdm/jqDaPDzQVQp6yC5MfZ0dkks
	 GadS93Lcjq1wZ3Bm6aiwsqtKvMTJTNPGYFPltsgI75Y+9vt0W/vAfG/gPIZnKHjVLv
	 LQE5ewkZ//zE8gctYXVuQetXo+5a/hJsTRWzJm1f+qoZXMIKdbdaS5btzwua7/ovlB
	 FKARp59C2gjPw==
Date: Thu, 3 Aug 2023 19:55:51 +0200
From: Simon Horman <horms@kernel.org>
To: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, kgraul@linux.ibm.com,
	tonylu@linux.alibaba.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
	guwen@linux.alibaba.com, linux-s390@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 4/6] net/smc: support max connections per
 lgr negotiation
Message-ID: <ZMvqJ6FYR6gWS+ZK@kernel.org>
References: <20230803132422.6280-1-guangguan.wang@linux.alibaba.com>
 <20230803132422.6280-5-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230803132422.6280-5-guangguan.wang@linux.alibaba.com>

On Thu, Aug 03, 2023 at 09:24:20PM +0800, Guangguan Wang wrote:
> Support max connections per lgr negotiation for SMCR v2.1,
> which is one of smc v2.1 features.
> 
> Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>

...

Hi Guangguan Wang,

>  int smc_clc_cli_v2x_features_validate(struct smc_clc_first_contact_ext *fce,
>  				      struct smc_init_info *ini)
>  {
> +	struct smc_clc_first_contact_ext_v2x *fce_v2x =
> +		(struct smc_clc_first_contact_ext_v2x *)fce;
> +
>  	if (ini->release_ver < SMC_RELEASE_1)
>  		return 0;
>  
> +	if (!ini->is_smcd) {
> +		if (fce_v2x->max_conns > SMC_CONN_PER_LGR_MAX)

The type of the max_cons field is u8.
The value of SMC_CONN_PER_LGR_MAX is 255 (in another patch of this series),
the maximum value that the max_cons field can be assigned.
So it seems that this condition cannot ever be true.

As flagged by Smatch.

> +			return SMC_CLC_DECL_MAXCONNERR;
> +		ini->max_conns = fce_v2x->max_conns;
> +	}
> +
>  	return 0;
>  }

...

> diff --git a/net/smc/smc_clc.h b/net/smc/smc_clc.h

...

> @@ -236,7 +238,8 @@ struct smc_clc_first_contact_ext {
>  
>  struct smc_clc_first_contact_ext_v2x {
>  	struct smc_clc_first_contact_ext fce_v20;
> -	u8 reserved3[4];
> +	u8 max_conns; /* for SMC-R only */
> +	u8 reserved3[3];
>  	__be32 vendor_exp_options;
>  	u8 reserved4[8];
>  } __packed;		/* format defined in

...

> diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
> index 1a97fef39127..065369dc6584 100644
> --- a/net/smc/smc_core.h
> +++ b/net/smc/smc_core.h
> @@ -22,6 +22,7 @@
>  #include "smc_ib.h"
>  
>  #define SMC_RMBS_PER_LGR_MAX	255	/* max. # of RMBs per link group */
> +#define SMC_CONN_PER_LGR_MAX	255	/* max. # of connections per link group */
>  
>  struct smc_lgr_list {			/* list of link group definition */
>  	struct list_head	list;

