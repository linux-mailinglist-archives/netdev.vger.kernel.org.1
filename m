Return-Path: <netdev+bounces-179613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5901A7DD72
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 14:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6BC41891CC2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 12:14:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F14722459DF;
	Mon,  7 Apr 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PA32bvcL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD72A2459EA
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 12:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744028053; cv=none; b=Kq6YHQAtKXAP/MLcRcfRB3mPJlQPuKFcLrl7t9mBI2NpDW9zOfa3m4rgmnesUydW8iB/aKF6WYfDaUVi8wdTpO/KQa15W0NaMQJ9HSxZGvRLZE8XRNddOrOZHOjFCpwGPkEJuljbIN1yuhCO+SZLRSE3w01bunNTHgPsGc0bZXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744028053; c=relaxed/simple;
	bh=HQ8XZmGAXYnEmG3WToZajpc1kkwNqQA9RPsH5fZlh84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ukXOPb387hzqaGTkx69fGoUMzEERSGEr0bQGsTCZ4a9+lOX4F3M+sy5pwY8jwCQoJHXCsA6YLVrwX6q62zozal9q1wtg93qd8NRAWtoPxfS7Q4fmmivg4obE/DoSXOH9ntivpIQjAcRPnkG89QcG+F9mt12ImH81x85onaERiC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PA32bvcL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B931C4CEE7;
	Mon,  7 Apr 2025 12:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744028053;
	bh=HQ8XZmGAXYnEmG3WToZajpc1kkwNqQA9RPsH5fZlh84=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PA32bvcLOPrVmDBPAgoKk3kcCOTLDeCwtGwC+SPM01aAzhjU4FQAQIc2GkhPHYeED
	 FExyqiahI4ArlS1/HQd0vfCO1HC5+i1G10EohDD10zcL6qrqFQmJ4lK48PDIwaLqlD
	 YgdoFpDcsKExNufHVQx/5EdZbjWIycRXCLlgIcQ6BJxuCD1YQ19WIKVDu0n3HBBF6Y
	 dlTjBF9P8yrgPfEn9PO/gPlIhn18Kao0vYGJqZuySU99c0d90fpoZDpVmZg+PVf4L/
	 sSv4uIEtcQ02W6DUFEPvy5k5/tJNFEuJXVPcw3to1X5+R50KWmtMiYrrKvjbKRRn0L
	 KM5t5vSTFbmMg==
Date: Mon, 7 Apr 2025 13:14:09 +0100
From: Simon Horman <horms@kernel.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, jhs@mojatatu.com, jiri@resnulli.us,
	victor@mojatatu.com, Gerrard Tai <gerrard.tai@starlabs.sg>
Subject: Re: [Patch net v2 05/11] sch_ets: make est_qlen_notify() idempotent
Message-ID: <20250407121409.GC395307@horms.kernel.org>
References: <20250403211033.166059-1-xiyou.wangcong@gmail.com>
 <20250403211033.166059-6-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250403211033.166059-6-xiyou.wangcong@gmail.com>

On Thu, Apr 03, 2025 at 02:10:27PM -0700, Cong Wang wrote:
> est_qlen_notify() deletes its class from its active list with

nit: ets_class_qlen_notify()

> list_del() when qlen is 0, therefore, it is not idempotent and
> not friendly to its callers, like fq_codel_dequeue().
> 
> Let's make it idempotent to ease qdisc_tree_reduce_backlog() callers'
> life. Also change other list_del()'s to list_del_init() just to be
> extra safe.
> 
> Reported-by: Gerrard Tai <gerrard.tai@starlabs.sg>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  net/sched/sch_ets.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
> index 516038a44163..c3bdeb14185b 100644
> --- a/net/sched/sch_ets.c
> +++ b/net/sched/sch_ets.c
> @@ -293,7 +293,7 @@ static void ets_class_qlen_notify(struct Qdisc *sch, unsigned long arg)
>  	 * to remove them.
>  	 */
>  	if (!ets_class_is_strict(q, cl) && sch->q.qlen)
> -		list_del(&cl->alist);
> +		list_del_init(&cl->alist);
>  }
>  
>  static int ets_class_dump(struct Qdisc *sch, unsigned long arg,
> @@ -488,7 +488,7 @@ static struct sk_buff *ets_qdisc_dequeue(struct Qdisc *sch)
>  			if (unlikely(!skb))
>  				goto out;
>  			if (cl->qdisc->q.qlen == 0)
> -				list_del(&cl->alist);
> +				list_del_init(&cl->alist);
>  			return ets_qdisc_dequeue_skb(sch, skb);
>  		}
>  
> @@ -657,7 +657,7 @@ static int ets_qdisc_change(struct Qdisc *sch, struct nlattr *opt,
>  	}
>  	for (i = q->nbands; i < oldbands; i++) {
>  		if (i >= q->nstrict && q->classes[i].qdisc->q.qlen)
> -			list_del(&q->classes[i].alist);
> +			list_del_init(&q->classes[i].alist);
>  		qdisc_tree_flush_backlog(q->classes[i].qdisc);
>  	}
>  	WRITE_ONCE(q->nstrict, nstrict);
> @@ -713,7 +713,7 @@ static void ets_qdisc_reset(struct Qdisc *sch)
>  
>  	for (band = q->nstrict; band < q->nbands; band++) {
>  		if (q->classes[band].qdisc->q.qlen)
> -			list_del(&q->classes[band].alist);
> +			list_del_init(&q->classes[band].alist);
>  	}
>  	for (band = 0; band < q->nbands; band++)
>  		qdisc_reset(q->classes[band].qdisc);
> -- 
> 2.34.1
> 
> 

