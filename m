Return-Path: <netdev+bounces-129054-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9793697D3B5
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 11:36:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 442801F255D9
	for <lists+netdev@lfdr.de>; Fri, 20 Sep 2024 09:36:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6358136658;
	Fri, 20 Sep 2024 09:35:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2713D7E107;
	Fri, 20 Sep 2024 09:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726824958; cv=none; b=ACNa2otJhhaq4dYJnwp+E2b3PFdCmS3FyZ/nHh55eJSukflH1PVdG3wtvR+GUEz4KSV+SxKwV8Idi3L6iay9iI1cdmTb/AJl6H2E+rQOMcYD2Fl5tCNXO0HmeUaGDYLzW2P8hVp96FDNTOBYu3/WOHnjZGzAKN56M/jo8ZjWs5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726824958; c=relaxed/simple;
	bh=i0xqeoqAvHXB5qmRqkvEbbm+QoU0HBOXjF/kNH1c/4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sDGKG1e4s7ebhMkA99BSAwVY993x3Kz4wx9hl717JvDlTL7zG0oTGLpptoAiY6sY22I7vjgqhZcu+7mthLFt/Qv8T1qjN6jJUNJTCn7LJfTpWazzYAXQokZZxiYPTmELSRiL49LeYNIfn/T9v4oZidPaMBlDzC2XqoBDriX5dNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: from fw by Chamillionaire.breakpoint.cc with local (Exim 4.92)
	(envelope-from <fw@strlen.de>)
	id 1sra39-0002Ub-OH; Fri, 20 Sep 2024 11:35:39 +0200
Date: Fri, 20 Sep 2024 11:35:39 +0200
From: Florian Westphal <fw@strlen.de>
To: Jiawei Ye <jiawei.ye@foxmail.com>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Fix potential RCU dereference issue in
 tcp_assign_congestion_control
Message-ID: <20240920093539.GA8490@breakpoint.cc>
References: <tencent_2A17499A4FFA4D830F7D2F72A95A4ADAB308@qq.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_2A17499A4FFA4D830F7D2F72A95A4ADAB308@qq.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Jiawei Ye <jiawei.ye@foxmail.com> wrote:
> In the `tcp_assign_congestion_control` function, the `ca->flags` is
> accessed after the RCU read-side critical section is unlocked. According
> to RCU usage rules, this is illegal. Reusing this pointer can lead to
> unpredictable behavior, including accessing memory that has been updated
> or causing use-after-free issues.
> 
> This possible bug was identified using a static analysis tool developed
> by myself, specifically designed to detect RCU-related issues.
> 
> To resolve this issue, the `rcu_read_unlock` call has been moved to the
> end of the function.
> 
> Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
> ---
> In another part of the file, `tcp_set_congestion_control` calls
> `tcp_reinit_congestion_control`, ensuring that the congestion control
> reinitialization process is protected by RCU. The
> `tcp_reinit_congestion_control` function contains operations almost
> identical to those in `tcp_assign_congestion_control`, but the former
> operates under full RCU protection, whereas the latter is only partially
> protected. The differing protection strategies between the two may
> warrant further unification.
> ---
>  net/ipv4/tcp_cong.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
> index 0306d257fa64..356a59d316e3 100644
> --- a/net/ipv4/tcp_cong.c
> +++ b/net/ipv4/tcp_cong.c
> @@ -223,13 +223,13 @@ void tcp_assign_congestion_control(struct sock *sk)
>  	if (unlikely(!bpf_try_module_get(ca, ca->owner)))
>  		ca = &tcp_reno;

After this, ca either has module refcount incremented, so it can't
go away anymore, or reno fallback was enabled (always bultin).

>  	icsk->icsk_ca_ops = ca;
> -	rcu_read_unlock();

Therefore its ok to rcu unlock here.

