Return-Path: <netdev+bounces-174161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 788E1A5DA7B
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 11:34:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42BE01883A1A
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2E323BD15;
	Wed, 12 Mar 2025 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ZesjP4x2"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945E61DF735
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 10:33:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741775639; cv=none; b=pDszwbZoshA4y0b5NGUyuaqDlhWi7vkH2fxIkiXtZWDd72/6ENILvnY6niYMqNXWUP8ZpNaQqdf/65sXuROSF9rDLPLknE3WjEpiy+GMSaqLTJbsLhb06yO4wKEdj64ga7VovCVNceW2RLmVF1GHCS51vhu3WL98VonUcm48BN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741775639; c=relaxed/simple;
	bh=wEbIfdS1b0b7felP7iudkpVNOF8QAapT9Zd1JJfJEfM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WSVHQREca1t1KFixmbM8svBIM+/2ExBSCWRL0J+5a7DVNJ2XC6DIhD8PwZljNb9tRd76EhRp3cPduwFak9xPzDHNfCnDQT8JURfSNm9qUxG+SMw24azpqjHbOEaaH6G3x15xLVZrVrwA3OAvpECI/l2gNHIsJTQi6rEsM2eMJkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ZesjP4x2; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e2d9d908-0103-417c-9087-c8b9030b2fbb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1741775635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8wwQ++0zyIUqBtJ2ulnRdUg/INf1TSOhv//4k7SwD0U=;
	b=ZesjP4x2prWz0WtMNJX21cbh1Iz0mElzfKS3/78EpnFdlaFRBwKs34pa+5GKNr0d6zhfoV
	m5p/gYbTYglW1QIcoOV2sDdOKqm2AfsXd4dCjGawjLsUSlSsp+UQaj7NiUk3X8LHZU0h1Q
	ZpEDS/Y8osjPcQ71OUmASYu1Vpqlbq0=
Date: Wed, 12 Mar 2025 10:33:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net v2 2/3] dpll: fix xa_alloc_cyclic() error handling
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 netdev@vger.kernel.org
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, pierre@stackhpc.com,
 hkallweit1@gmail.com, linux@armlinux.org.uk, maxime.chevallier@bootlin.com,
 christophe.leroy@csgroup.eu, arkadiusz.kubalewski@intel.com
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
 <20250312095251.2554708-3-michal.swiatkowski@linux.intel.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20250312095251.2554708-3-michal.swiatkowski@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/03/2025 09:52, Michal Swiatkowski wrote:
> In case of returning 1 from xa_alloc_cyclic() (wrapping) ERR_PTR(1) will
> be returned, which will cause IS_ERR() to be false. Which can lead to
> dereference not allocated pointer (pin).
> 
> Fix it by checking if err is lower than zero.
> 
> This wasn't found in real usecase, only noticed. Credit to Pierre.
> 
> Fixes: 97f265ef7f5b ("dpll: allocate pin ids in cycle")
> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
> ---
>   drivers/dpll/dpll_core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
> index 32019dc33cca..1877201d1aa9 100644
> --- a/drivers/dpll/dpll_core.c
> +++ b/drivers/dpll/dpll_core.c
> @@ -505,7 +505,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
>   	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
>   	ret = xa_alloc_cyclic(&dpll_pin_xa, &pin->id, pin, xa_limit_32b,
>   			      &dpll_pin_xa_id, GFP_KERNEL);
> -	if (ret)
> +	if (ret < 0)
>   		goto err_xa_alloc;
>   	return pin;
>   err_xa_alloc:

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>

