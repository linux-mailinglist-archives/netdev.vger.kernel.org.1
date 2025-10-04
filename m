Return-Path: <netdev+bounces-227846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D99DBB8971
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 06:29:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 14A0C4E1900
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 04:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00A431B040B;
	Sat,  4 Oct 2025 04:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sAjewFjN"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4DDC2E0
	for <netdev@vger.kernel.org>; Sat,  4 Oct 2025 04:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759552157; cv=none; b=uNlR+3IQg8jpcy4PcyD0CtiGNnebswy01nJ/wA5Q15EGpYlB++qGTT34wfvshlnk9gOBur/2s5F+xR29NaMoSPRgGhK8c35iHMb5TobvHV0nIOoveVdwLKJPUngJrpvrJUypY0EPCjVYsuG8a3pCZSMb+v2BL3mYqk4/8qIwK7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759552157; c=relaxed/simple;
	bh=o2gOUdkDkW3TAW6ZvlWhSCeqfIezE8LGcNQsK02imjw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Afy8d6BPsXPtkI3LaFl1ETwlSjBQtM12h5jeIAly4TtPaFMtYypPklqYrWcec8R5VsGcxCLJTdMUNnxyITR+DM+fDw1EvSjB1P38wPw89mh+SKtQIMKluNOsgisEWeUlryOGw6WsHun5OqB5yKyZekqJ2VZlcJccnHwcxWk+DIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sAjewFjN; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f0cef998-0d49-4a52-b1b8-2f89b81d4b07@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759552152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MOXqTi3/xjR6jvJihYLZ1BSE1oIrotvd0WAQLFqtFts=;
	b=sAjewFjNbjUBCsyTgWte7SAJEDrWTBj8yH58lHyFZtPKBnwEFIwy9x2Piq3ZIaV+RJxfZ2
	Beh30fPkept/b3Jl84rbQT9E/Ds+U2rwn92ZdV9gUb085DAmH9bGTzJkC+yGh5zsPnurbP
	b3r2SOs3iG7ipCOVqMxBRRlOiVRrT/U=
Date: Fri, 3 Oct 2025 21:28:51 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] net: fix potential use-after-free in
 ch_ipsec_xfrm_add_state() callback
To: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>,
 Ayush Sawal <ayush.sawal@chelsio.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Leon Romanovsky <leon@kernel.org>,
 Steffen Klassert <steffen.klassert@secunet.com>,
 Cosmin Ratiu <cratiu@nvidia.com>, Harsh Jain <harsh@chelsio.com>,
 Atul Gupta <atul.gupta@chelsio.com>, Herbert Xu
 <herbert@gondor.apana.org.au>, Ganesh Goudar <ganeshgr@chelsio.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20251001111646.806130-1-Pavel.Zhigulin@kaspersky.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <20251001111646.806130-1-Pavel.Zhigulin@kaspersky.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2025/10/1 4:16, Pavel Zhigulin 写道:
> In ch_ipsec_xfrm_add_state() there is not check of try_module_get
> return value. It is very unlikely, but try_module_get() could return
> false value, which could cause use-after-free error.
>
> This fix adds checking the result of try_module_get call
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: 6dad4e8ab3ec ("chcr: Add support for Inline IPSec")
> Signed-off-by: Pavel Zhigulin <Pavel.Zhigulin@kaspersky.com>
> ---
>   .../net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
> index ecd9a0bd5e18..3a5277630afa 100644
> --- a/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
> +++ b/drivers/net/ethernet/chelsio/inline_crypto/ch_ipsec/chcr_ipsec.c
> @@ -35,6 +35,8 @@
>    *	Atul Gupta (atul.gupta@chelsio.com)
>    */
>
> +#include "asm-generic/errno-base.h"
> +#include "linux/compiler.h"
>   #define pr_fmt(fmt) "ch_ipsec: " fmt
>
>   #include <linux/kernel.h>
> @@ -301,7 +303,8 @@ static int ch_ipsec_xfrm_add_state(struct net_device *dev,
>   		sa_entry->esn = 1;
>   	ch_ipsec_setkey(x, sa_entry);
>   	x->xso.offload_handle = (unsigned long)sa_entry;
> -	try_module_get(THIS_MODULE);
> +	if (unlikely(!try_module_get(THIS_MODULE)))

The function try_module_get() fails (returns false) only if the module 
is in the process of being

unloaded (i.e., module_refcount can’t be increased because the state is 
GOING

or UNFORMED). Otherwise, it succeeds and increments the refcount.

When the function ch_ipsec_xfrm_add_state is called, the kernel module 
cannot be in the GOING

or UNFORMED state. In other words, within this function, it is not 
possible for try_module_get to fail.

I am not sure if this check is strictly necessary, but as a defensive 
programming measure, it still makes sense.

Reviewed-by: Zhu Yanjun <yanjun.zhu@linux.dev>

Zhu Yanjun


> +		res = -ENODEV;
>   out:
>   	return res;
>   }
> --
> 2.43.0
>
-- 
Best Regards,
Yanjun.Zhu


