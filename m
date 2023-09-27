Return-Path: <netdev+bounces-36552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3C27B05D7
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 15:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 79FF1B20A25
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 13:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1F4286BE;
	Wed, 27 Sep 2023 13:54:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD771FA1
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 13:54:48 +0000 (UTC)
Received: from out-202.mta0.migadu.com (out-202.mta0.migadu.com [91.218.175.202])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51C94126
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 06:54:46 -0700 (PDT)
Message-ID: <5710f678-b643-b22e-7c73-1d8d6ba916a6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1695822884;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/OSwsNOXWM0VgezPfw7af7Si0H/8qY1jnNwHcRl/SBg=;
	b=VRT903ZJjhjbxqVECRTdLvimf33NZh3T4eQx6dkQ2L/fz3ZcEWCrGtZn4/g/Twte9GD069
	PMhYDD4izcVHGPVMYf++2K3AaTDtyb+jSk6uEsAywhst7rADOmuWEaxgmYM2XabEDZPqgC
	m0W8NGhmbYCYFJChm38ODm9Hn3IZAP4=
Date: Wed, 27 Sep 2023 14:54:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] ptp: ocp: fix error code in probe()
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Vadim Fedorenko <vadfed@fb.com>,
 "David S. Miller" <davem@davemloft.net>, Jiri Pirko <jiri@resnulli.us>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <5c581336-0641-48bd-88f7-51984c3b1f79@moroto.mountain>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <5c581336-0641-48bd-88f7-51984c3b1f79@moroto.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 27/09/2023 13:55, Dan Carpenter wrote:
> There is a copy and paste error so this uses a valid pointer instead of
> an error pointer.
> 
> Fixes: 09eeb3aecc6c ("ptp_ocp: implement DPLL ops")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>   drivers/ptp/ptp_ocp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
> index 88d60a9b5731..d39afe091a7b 100644
> --- a/drivers/ptp/ptp_ocp.c
> +++ b/drivers/ptp/ptp_ocp.c
> @@ -4453,7 +4453,7 @@ ptp_ocp_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>   	for (i = 0; i < OCP_SMA_NUM; i++) {
>   		bp->sma[i].dpll_pin = dpll_pin_get(clkid, i, THIS_MODULE, &bp->sma[i].dpll_prop);
>   		if (IS_ERR(bp->sma[i].dpll_pin)) {
> -			err = PTR_ERR(bp->dpll);
> +			err = PTR_ERR(bp->sma[i].dpll_pin);
>   			goto out_dpll;
>   		}
>   

Thanks!

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

