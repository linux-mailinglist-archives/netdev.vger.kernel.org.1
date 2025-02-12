Return-Path: <netdev+bounces-165691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BD2A3310B
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 21:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6D303AA9AB
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 20:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C5C201018;
	Wed, 12 Feb 2025 20:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="SjBtZNKA"
X-Original-To: netdev@vger.kernel.org
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012291EEA4A;
	Wed, 12 Feb 2025 20:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739393491; cv=none; b=Rz8eDv+9liXEzNh26SE2BP0vFaF4T4lCEDoIOi6B9p2GN/1Fb+3jmKncIDqWWAN8v8tNY8lrlpJgtPlUo+r8lUMrYgciny+p1o3pAxnfeoyIxnX/z3pnrw7FcHhCtxntHh8HSWVuEJc16lE+3kS8bkPzTxu4niPVEVFxAIU5pLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739393491; c=relaxed/simple;
	bh=jzUTJv45demkUarPa9lEr/aqyCAwc9mdZXYtnY7m2+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ph0BH+CO/5WwLLJpNwUjpb7v44ZucSYXYWUS8edDfQcdmolr0DEcCYV96veP5RlAfocBqockxm/sSCtOe2eAD4mDh1mxWjPEHXBYIYgNBs1xuoUtbWG9ayD7w4dgfNTmRqeoFpJctOZLS6VIKz5JCeItQFnQmgsfnh3ypw2N18k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=SjBtZNKA; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 51CKnVvS2686036;
	Wed, 12 Feb 2025 21:49:31 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 51CKnVvS2686036
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1739393371;
	bh=F1PJTb1t/9OF2CI48FIGTG+U0Elr59Ye0fqTYu9brXc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SjBtZNKATBhPzqrDVztSYIMN0JC235eiJFrg6UZ+OJ8gh1f6lPlR2p1E7Y/5byHzH
	 8L+QtL0T0ELQ4z2eqWU2omkP2eVSF+yzIbQQ6rxo3V7knM6oINfZyiS2eUn8k0W/Cf
	 1bQrrIgclgHcvDS430l5G1tIpjH/6GRiJjbXYL/U=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 51CKnT7J2686035;
	Wed, 12 Feb 2025 21:49:29 +0100
Date: Wed, 12 Feb 2025 21:49:29 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Hayes Wang <hayeswang@realtek.com>, linux-usb@vger.kernel.org,
        netdev@vger.kernel.org, Paul Menzel <pmenzel@molgen.mpg.de>
Subject: Re: [PATCH 2/2] r8152: Call napi_schedule() from proper context
Message-ID: <20250212204929.GA2685909@electric-eye.fr.zoreil.com>
References: <20250212174329.53793-1-frederic@kernel.org>
 <20250212174329.53793-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250212174329.53793-3-frederic@kernel.org>
X-Organisation: Land of Sunshine Inc.

Frederic Weisbecker <frederic@kernel.org> :
[...]
> r8152 may call napi_schedule() on device resume time from a bare task
> context without disabling softirqs as the following trace shows:
[...]
> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index 468c73974046..1325460ae457 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c
> @@ -8537,8 +8537,11 @@ static int rtl8152_runtime_resume(struct r8152 *tp)
>  		clear_bit(SELECTIVE_SUSPEND, &tp->flags);
>  		smp_mb__after_atomic();
>  
> -		if (!list_empty(&tp->rx_done))
> +		if (!list_empty(&tp->rx_done)) {
> +			local_bh_disable();
>  			napi_schedule(&tp->napi);
> +			local_bh_enable();
> +		}

AFAIU drivers/net/usb/r8152.c::rtl_work_func_t exhibits the same
problem.

-- 
Ueimor

