Return-Path: <netdev+bounces-69423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB284B25C
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 11:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BD88EB26369
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 10:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1962512E1F5;
	Tue,  6 Feb 2024 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="RZIV1C8C"
X-Original-To: netdev@vger.kernel.org
Received: from out-175.mta0.migadu.com (out-175.mta0.migadu.com [91.218.175.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2700012E1D1
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 10:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707214704; cv=none; b=BzzWx9/C1sqEd7F+G6JQKpYr6UYLxtPnsLXSqYSkmqhCbjdO3gzh36JvrLWUDnzED3LltsYoB3h1rw2aPtHXERp5YXIM2Kapct9Pc96n2ENV8pirWDibvSOiKLpqxZbZwN3TFchrb9SP4vrmHiKONoBu35zE15Yd3GDx1zT24cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707214704; c=relaxed/simple;
	bh=1E1SiB3I8ZG3pYhi2qvHAeH0sndhT2f0zCJhhyxJC/Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tImb54Sf+s2xOcaXH1iqXUaLc5GCDm8I8ejJVXWRUs6Y1pGmQL2pLPipl4xtQnwZqSlKtTXDDtktdA1ysTnpwMRGxuNzikO7Zyj7f0ZFcViBl+QAZ97xmwNL9CVxErx7UWi1U7K50C4OoNPJfa+ca019qR90GTmbxp+cAIAvDk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=RZIV1C8C; arc=none smtp.client-ip=91.218.175.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <ef4a3a68-8415-41d3-81b7-b46976b61a82@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707214699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1nLKrNhvMBdzo++A+Cno8YPWKJw5aGVYW26BBZML1VM=;
	b=RZIV1C8CkGyrp4jrQDVBOb2o12XLPDHCqia6iLHXo6YIyzeucZe0s9y8bj00LmDJTRdYab
	aIJclxNRcU1uCkWQwNKUAEtPxoxsKOMu7XfX0EQe57ByRgeo7mZcHkrQCfaBy/nqRRCB8Z
	mD39mtG+ySL1edukR6MJP8tonHbXQr0=
Date: Tue, 6 Feb 2024 10:18:15 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [patch net-next] dpll: check that pin is registered in
 __dpll_pin_unregister()
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: arkadiusz.kubalewski@intel.com
References: <20240206074853.345744-1-jiri@resnulli.us>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240206074853.345744-1-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/02/2024 07:48, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Similar to what is done in dpll_device_unregister(), add assertion to
> __dpll_pin_unregister() to make sure driver does not try to unregister
> non-registered pin.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>   drivers/dpll/dpll_core.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 61e5c607a72f..93c1bb7a6ef7 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -29,6 +29,8 @@ static u32 dpll_pin_xa_id;
>   	WARN_ON_ONCE(!xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
>   #define ASSERT_DPLL_NOT_REGISTERED(d)	\
>   	WARN_ON_ONCE(xa_get_mark(&dpll_device_xa, (d)->id, DPLL_REGISTERED))
> +#define ASSERT_DPLL_PIN_REGISTERED(p) \
> +	WARN_ON_ONCE(!xa_get_mark(&dpll_pin_xa, (p)->id, DPLL_REGISTERED))
>   
>   struct dpll_device_registration {
>   	struct list_head list;
> @@ -631,6 +633,7 @@ static void
>   __dpll_pin_unregister(struct dpll_device *dpll, struct dpll_pin *pin,
>   		      const struct dpll_pin_ops *ops, void *priv)
>   {
> +	ASSERT_DPLL_PIN_REGISTERED(pin);
>   	dpll_xa_ref_pin_del(&dpll->pin_refs, pin, ops, priv);
>   	dpll_xa_ref_dpll_del(&pin->dpll_refs, dpll, ops, priv);
>   	if (xa_empty(&pin->dpll_refs))

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

