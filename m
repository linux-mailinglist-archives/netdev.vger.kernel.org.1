Return-Path: <netdev+bounces-159179-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48BAA14A9D
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:02:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31E293A4B9E
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 08:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8DF1F7916;
	Fri, 17 Jan 2025 08:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="tcWWqqFv"
X-Original-To: netdev@vger.kernel.org
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 076CC1F75AB
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 08:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100955; cv=none; b=sR6CE7pXn7XX4cLnjO3gFFKNTg/wedeJZjcB9ZSCc4aRQ77smCJMGEfqghLqTDjhv4BtWtJZ7zkkK6AE9KPDZ6zlmqZBZngENUJVPdr8XtU703vjLNv3UnwvI885Vv6rF7/LIUwjOywqM0Q8hviRAMn1zfy5X+qSbBeegWXiuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100955; c=relaxed/simple;
	bh=eijQiXkCWY0I7LbNpw2iVFsSgpBM2QzG+fRLQfBir34=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fcA2oGHDTYYRvkZZ4xcm8Xdub0gv079MLvlU0lxPX/6npKfEQA1UwMDIxNsR177GFdSluXoMU9X9a7UYnShWY/4Awqt83qolxtsjsxYlIzvRuSJsS2hsNjV93qqzysqakJfoWIh7f14Ugp6+J7NwPWYNmldo8T+hmph5koXWWMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=tcWWqqFv; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 08D8720842;
	Fri, 17 Jan 2025 09:02:31 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZjHSpVwumHu0; Fri, 17 Jan 2025 09:02:30 +0100 (CET)
Received: from cas-essen-01.secunet.de (rl1.secunet.de [10.53.40.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6687B2083E;
	Fri, 17 Jan 2025 09:02:30 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6687B2083E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1737100950;
	bh=Ro3fdDG4n+A5YTxOijfPr2H8Vqbrh3AlQx9eVPzkZcw=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=tcWWqqFvGMilLHsdHeHgi9HVIPsGMwpdG2b3Io7RsRDA/RdyIHeSa/pbq0/jycvGu
	 xan2MiK6DFUuzjEwfUGTatNafp3wQwDLuBNusVZL5y+bnPBxliFlfSQNZUnr7NzazK
	 X38BxxFuU/psBd3AdZXPLZ3nRKXTLJgvTBygOeZrymu6dQeGmmdNdIxO3EwCANnGfM
	 CSWkyGweq8Cg/JngVE8xV5WJ6NXSmtaYRjJ6W5vvU6QGU8PzZLxldD2+YPvY9Fq/IA
	 NtqNhieilr1pMHdSX2jPGjG3hprfQbyrK50peI8jBj2a6k59fXO49bLOpBSjoR5tvA
	 WbgglcKShMS8w==
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Fri, 17 Jan 2025 09:02:30 +0100
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 17 Jan
 2025 09:02:29 +0100
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id A66D13183D90; Fri, 17 Jan 2025 09:02:29 +0100 (CET)
Date: Fri, 17 Jan 2025 09:02:29 +0100
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Sebastian Sewior <bigeasy@linutronix.de>
CC: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Network Development
	<netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>
Subject: Re: xfrm in RT
Message-ID: <Z4oOldW33zFbYQ6/@gauss3.secunet.de>
References: <CAADnVQKkCLaj=roayH=Mjiiqz_svdf1tsC3OE4EC0E=mAD+L1A@mail.gmail.com>
 <Z2KImhGE2TfpgG4E@gauss3.secunet.de>
 <20241218154426.E4hsgTfF@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20241218154426.E4hsgTfF@linutronix.de>
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Wed, Dec 18, 2024 at 04:44:26PM +0100, Sebastian Sewior wrote:
> On 2024-12-18 09:32:26 [+0100], Steffen Klassert wrote:
> > On Tue, Dec 17, 2024 at 04:07:16PM -0800, Alexei Starovoitov wrote:
> > > Hi,
> > > 
> > > Looks like xfrm isn't friendly to PREEMPT_RT.
> Thank you for the report.

Sorry for the delay.

> > > xfrm_input_state_lookup() is doing:
> > > 
> > > int cpu = get_cpu();
> > > ...
> > > spin_lock_bh(&net->xfrm.xfrm_state_lock);
> > 
> > We just need the cpu as a lookup key, no need to
> > hold on the cpu. So we just can do put_cpu()
> > directly after we fetched the value.
> 
> I would assume that the espX_gro_receive() caller is within NAPI. Can't
> tell what xfrm_input() is.
> However if you don't care about staying on the current CPU for the whole
> time (your current get_cpu() -> put_cpu() span) you could do something
> like
> 
> diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
> index 67ca7ac955a37..66b108a5b87d4 100644
> --- a/net/xfrm/xfrm_state.c
> +++ b/net/xfrm/xfrm_state.c
> @@ -1116,9 +1116,8 @@ struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
>  {
>  	struct hlist_head *state_cache_input;
>  	struct xfrm_state *x = NULL;
> -	int cpu = get_cpu();
>  
> -	state_cache_input =  per_cpu_ptr(net->xfrm.state_cache_input, cpu);
> +	state_cache_input = raw_cpu_ptr(net->xfrm.state_cache_input);
>  
>  	rcu_read_lock();
>  	hlist_for_each_entry_rcu(x, state_cache_input, state_cache_input) {
> @@ -1150,7 +1149,6 @@ struct xfrm_state *xfrm_input_state_lookup(struct net *net, u32 mark,
>  
>  out:
>  	rcu_read_unlock();
> -	put_cpu();
>  	return x;
>  }

This looks like the correct fix. Do you want to submit this pach?


