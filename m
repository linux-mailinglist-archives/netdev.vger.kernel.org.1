Return-Path: <netdev+bounces-183646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC42DA91674
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:29:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FEE344589D
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904A822F3B8;
	Thu, 17 Apr 2025 08:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFZJjMgP"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E7422E40F
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744878554; cv=none; b=lZfPuIvHcaUH93z9I5quLwWGZEaWSlS7W3beLjkpn4nRSic+kIGkKrSaLX9V2Vaf1NcgoLusNyrZM5KMa/jsm01ey0RGDrXvdI/9tlYl7HqB2gx3UJ78R/WklV4/fi5v+NtVaV5MSmcvejMocJuzYPVYcfVYx3rrqQ4x+acbLfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744878554; c=relaxed/simple;
	bh=xVEfxsLo9pbqU1AK5jwlmJw5GMJsAlZuVl9sZWvfyvY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YlKnRwFqOgsHsdXyJspNEAgF+GWTV23VgzZ9f4JR2wTOUNL1t7cEJZJTYmKbTmLuJEtM/vajurWtDfd4ufquOecAFexit5myIHatG4QynVH16HlUOWBe2P5fdLBDfQidgPt1VH9NYAiWya5y0ukgaW44ZP7oFmucWHy6UF40wSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFZJjMgP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744878551;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkUrbKRD3U8etAppRrC1TENp5/BjAdyMh2DRgi3zpr4=;
	b=CFZJjMgPQE4rwvdxp/JK4XlrELAp174rHc5zwqvQjC+VVNwPfEloc5L/kDvkkH/bEnG0uG
	Mm0B/b8Dts2tfyXAGjSnFQmTR7XG6bFQfw+5T7S6HnevFPM02rYOyeh7//NaHjvCsWxhOs
	AN3KEqGVvvTtwUmnz2fMfbGD6mdKEf4=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-89wEQ8yZME2lhUpQ_8z4Kg-1; Thu, 17 Apr 2025 04:29:09 -0400
X-MC-Unique: 89wEQ8yZME2lhUpQ_8z4Kg-1
X-Mimecast-MFC-AGG-ID: 89wEQ8yZME2lhUpQ_8z4Kg_1744878549
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6e8f9450b19so11235076d6.1
        for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 01:29:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744878549; x=1745483349;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZkUrbKRD3U8etAppRrC1TENp5/BjAdyMh2DRgi3zpr4=;
        b=brw6lwAgT6W5yHhl6iwQ1eYA1cFpXkGM4KMVLCTeL7XoqAupvLCRZJRXzqrJkYWtFH
         n90R9MSnpVzlgKSNALbyol7MRGtScJYCUyFfe3shVlb0fQ6WU/AwVWeihvwvzWRc/Cz1
         p6IYy09PLOw4IPQrZmhmh9U2A/lc7paHzhF871h3MwVQHdaqeJPnttDrPn+T+HPd44qj
         G9ChhwZik+0ttI841HagR9EZYQJOrYc2A1+aeBLT88lKAp7j2PrCsMm1iedwTPcSXtOw
         xjI85oDgI5DUR5/P0bGV45s4wjpYRjmnbHBt9NOCqvh+Ryp9VlVoCCGm9u6ZkZo9WF5e
         nqDA==
X-Forwarded-Encrypted: i=1; AJvYcCUlgH+RHzrdXCVbb2WciOo8QNVrkBn42pC/xEwnjVMos5Xv0rc+B+u6TE7HDqHIEg3VCEKW+o0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg0fxhXinOZcIBQPUtg2K5LXjZ2YQq59Tjc3Wi0uOUrCa+jtXQ
	LbeSAU4TlvEYmJUNIzVSuqEOijQllK8TC6sOuRvs9TEjlI6gA+OI0M8/ja10n6OBYmDvREe0W4/
	cAu45ObraCG4jrZ6laVcNzcvhKB2fjGLYe/DWpLnRbWUto1vEqu8PBA==
X-Gm-Gg: ASbGncsm07r+1gQtTNN0S0IijJ0BevQhIT9PU5stWVWV22jjPDOP+Zol7KGXQ10cPtp
	cZVzLfYtWl0P6yz2mCWY0iuBj16D7QwCzpkN3gVmh12rm0Sa4/0U2Od6b9F/ViWR/QBVpFBeeMI
	pmcpr44qcCYx7XY26rrmcud0fw6rmHhZ7oA8fxXIuCwFCFVKp3888wkSc46mPmprm9Rg9LGBRj8
	XqyMcKVO97MovbmnCgksKBgnJiRAjoHvTqPRnvdLaHLXmtRUapLQit90IIJgaTqfT7mwAkg/JkY
	jdYJjRR/101J8AnyHJVH5xVSCVn4OC06S73UA+TB5w==
X-Received: by 2002:a05:6214:2a4a:b0:6e8:f296:5f57 with SMTP id 6a1803df08f44-6f2ba752e56mr28603366d6.20.1744878548829;
        Thu, 17 Apr 2025 01:29:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtQF2zq6rrDcP6LA8Xtwny4b0RzN0ztGrqa6EZLJoEKOG5SlAjk2oDTB+wONOtDKuoBS/asA==
X-Received: by 2002:a05:6214:2a4a:b0:6e8:f296:5f57 with SMTP id 6a1803df08f44-6f2ba752e56mr28603176d6.20.1744878548565;
        Thu, 17 Apr 2025 01:29:08 -0700 (PDT)
Received: from [192.168.88.253] (146-241-55-253.dyn.eolo.it. [146.241.55.253])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6f2a5856350sm34464696d6.97.2025.04.17.01.29.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Apr 2025 01:29:08 -0700 (PDT)
Message-ID: <75e10631-00a3-405a-b4d8-96b422ffbe41@redhat.com>
Date: Thu, 17 Apr 2025 10:29:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 13/18] net/sched: act_mirred: Move the
 recursion counter struct netdev_xmit
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 netdev@vger.kernel.org, linux-rt-devel@lists.linux.dev
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>
References: <20250414160754.503321-1-bigeasy@linutronix.de>
 <20250414160754.503321-14-bigeasy@linutronix.de>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20250414160754.503321-14-bigeasy@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/14/25 6:07 PM, Sebastian Andrzej Siewior wrote:
> mirred_nest_level is a per-CPU variable and relies on disabled BH for its
> locking. Without per-CPU locking in local_bh_disable() on PREEMPT_RT
> this data structure requires explicit locking.
> 
> Move mirred_nest_level to struct netdev_xmit as u8, provide wrappers.
> 
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Cong Wang <xiyou.wangcong@gmail.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/netdevice_xmit.h |  3 +++
>  net/sched/act_mirred.c         | 28 +++++++++++++++++++++++++---
>  2 files changed, 28 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/netdevice_xmit.h b/include/linux/netdevice_xmit.h
> index 3bbbc1a9860a3..4793ec42b1faa 100644
> --- a/include/linux/netdevice_xmit.h
> +++ b/include/linux/netdevice_xmit.h
> @@ -11,6 +11,9 @@ struct netdev_xmit {
>  #if IS_ENABLED(CONFIG_NF_DUP_NETDEV)
>  	u8 nf_dup_skb_recursion;
>  #endif
> +#if IS_ENABLED(CONFIG_NET_ACT_MIRRED)
> +	u8 sched_mirred_nest;
> +#endif
>  };

How many of such recursion counters do you foresee will be needed?

AFAICS this one does not fit the existing hole anymore; the binary
layout before this series is:

 struct netdev_xmit {
                /* typedef u16 -> __u16 */ short unsigned int recursion;
                /*  2442     2 */
                /* typedef u8 -> __u8 */ unsigned char      more;
                /*  2444     1 */
                /* typedef u8 -> __u8 */ unsigned char
skip_txqueue;                /*  2445     1 */
        } net_xmit; /*  2442     4 */

        /* XXX 2 bytes hole, try to pack */

and this series already added 2 u8 fields. Since all the recursion
counters could be represented with less than 8 bits, perhaps using a
bitfield here could be worthy?!?

In any case I think we need explicit ack from the sched people.

> diff --git a/net/sched/act_mirred.c b/net/sched/act_mirred.c
> index 5b38143659249..5f01f567c934d 100644
> --- a/net/sched/act_mirred.c
> +++ b/net/sched/act_mirred.c
> @@ -30,7 +30,29 @@ static LIST_HEAD(mirred_list);
>  static DEFINE_SPINLOCK(mirred_list_lock);
>  
>  #define MIRRED_NEST_LIMIT    4
> -static DEFINE_PER_CPU(unsigned int, mirred_nest_level);
> +
> +#ifndef CONFIG_PREEMPT_RT
> +static u8 tcf_mirred_nest_level_inc_return(void)
> +{
> +	return __this_cpu_inc_return(softnet_data.xmit.sched_mirred_nest);
> +}
> +
> +static void tcf_mirred_nest_level_dec(void)
> +{
> +	__this_cpu_dec(softnet_data.xmit.sched_mirred_nest);
> +}
> +
> +#else
> +static u8 tcf_mirred_nest_level_inc_return(void)
> +{
> +	return current->net_xmit.sched_mirred_nest++;
> +}
> +
> +static void tcf_mirred_nest_level_dec(void)
> +{
> +	current->net_xmit.sched_mirred_nest--;
> +}
> +#endif

There are already a few of this construct. Perhaps it would be worthy to
implement a netdev_xmit() helper returning a ptr to the whole struct and
use it to reduce the number of #ifdef

Thanks,

Paolo


