Return-Path: <netdev+bounces-76297-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B039E86D2C6
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 20:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AF7628204B
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF27828A;
	Thu, 29 Feb 2024 19:03:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FCE383B0
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709233387; cv=none; b=VQWx543P37bapvOZO2IAj+yylGqe3ytmwe82/I0idM7MHlsS8kL5ByjCK7U9eH9UXtMAYZiDhyR/sg+LLeFKWg2KF6L7qqVfpS5t8lj3os6WHyuILC6gIk5FHiuPoqasxq9eL5IdM+ayGWkTqHyJHDYNA37mc4AZvJ4WFKLJe3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709233387; c=relaxed/simple;
	bh=lznppwX95aaFQNu+uWEYhsnaW/hN8Q05QrDOzbMoHmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nOHxoQlvqzYNhm9EzYhXzixiHakyYIYnIatSsdYm7Q+OsdmznAZ7W49DLlkL6N3PnCVptr1YimOgsD7gsy0ju55/IvqevTekZ38pLRjJysP+oodJcS8uqyuBEEeYlEnApmYsL06gcEueA3Dc43lOKOLL/51KHPE/pHYyVhud4x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77C28C433F1;
	Thu, 29 Feb 2024 19:03:06 +0000 (UTC)
Date: Thu, 29 Feb 2024 14:05:13 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Cong Wang <xiyou.wangcong@gmail.com>
Cc: netdev@vger.kernel.org, vaclav.zindulka@tlapnet.cz, Jamal Hadi Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>
Subject: Re: [Patch net-next 2/5] net_sched: add tracepoints for
 qdisc_reset() and qdisc_destroy()
Message-ID: <20240229140513.72b2795a@gandalf.local.home>
In-Reply-To: <20200527043527.12287-3-xiyou.wangcong@gmail.com>
References: <20200527043527.12287-1-xiyou.wangcong@gmail.com>
	<20200527043527.12287-3-xiyou.wangcong@gmail.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2020 21:35:24 -0700
Cong Wang <xiyou.wangcong@gmail.com> wrote:

> Add two tracepoints for qdisc_reset() and qdisc_destroy() to track
> qdisc resetting and destroying.
> 
> Sample output:
> 
>   tc-756   [000] ...3   138.355662: qdisc_reset: dev=ens3 kind=pfifo_fast parent=ffff:ffff handle=0:0
>   tc-756   [000] ...1   138.355720: qdisc_reset: dev=ens3 kind=pfifo_fast parent=ffff:ffff handle=0:0
>   tc-756   [000] ...1   138.355867: qdisc_reset: dev=ens3 kind=pfifo_fast parent=ffff:ffff handle=0:0
>   tc-756   [000] ...1   138.355930: qdisc_destroy: dev=ens3 kind=pfifo_fast parent=ffff:ffff handle=0:0
>   tc-757   [000] ...2   143.073780: qdisc_reset: dev=ens3 kind=fq_codel parent=ffff:ffff handle=8001:0
>   tc-757   [000] ...1   143.073878: qdisc_reset: dev=ens3 kind=fq_codel parent=ffff:ffff handle=8001:0
>   tc-757   [000] ...1   143.074114: qdisc_reset: dev=ens3 kind=fq_codel parent=ffff:ffff handle=8001:0
>   tc-757   [000] ...1   143.074228: qdisc_destroy: dev=ens3 kind=fq_codel parent=ffff:ffff handle=8001:0
> 
> Cc: Jamal Hadi Salim <jhs@mojatatu.com>
> Cc: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
> ---
>  include/trace/events/qdisc.h | 52 ++++++++++++++++++++++++++++++++++++
>  net/sched/sch_generic.c      |  4 +++
>  2 files changed, 56 insertions(+)
> 
> diff --git a/include/trace/events/qdisc.h b/include/trace/events/qdisc.h
> index 0d1a9ebf55ba..2b948801afa3 100644
> --- a/include/trace/events/qdisc.h
> +++ b/include/trace/events/qdisc.h
> @@ -8,6 +8,8 @@
>  #include <linux/netdevice.h>
>  #include <linux/tracepoint.h>
>  #include <linux/ftrace.h>
> +#include <linux/pkt_sched.h>
> +#include <net/sch_generic.h>
>  
>  TRACE_EVENT(qdisc_dequeue,
>  
> @@ -44,6 +46,56 @@ TRACE_EVENT(qdisc_dequeue,
>  		  __entry->txq_state, __entry->packets, __entry->skbaddr )
>  );
>  
> +TRACE_EVENT(qdisc_reset,
> +
> +	TP_PROTO(struct Qdisc *q),
> +
> +	TP_ARGS(q),
> +
> +	TP_STRUCT__entry(
> +		__string(	dev,		qdisc_dev(q)	)
> +		__string(	kind,		q->ops->id	)
> +		__field(	u32,		parent		)
> +		__field(	u32,		handle		)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev, qdisc_dev(q));

I'm doing updates to __assign_str() and __string() and the below errored
out because "qdisc_dev(q)" is not a string.

How does the above work?

static inline struct net_device *qdisc_dev(const struct Qdisc *qdisc)
{
	return qdisc->dev_queue->dev;
}

Where:


struct net_device {
	/* Cacheline organization can be found documented in
	 * Documentation/networking/net_cachelines/net_device.rst.
	 * Please update the document when adding new fields.
	 */

	/* TX read-mostly hotpath */
	__cacheline_group_begin(net_device_read_tx);
	unsigned long long	priv_flags;
	const struct net_device_ops *netdev_ops;

What looks to be returned from qdisc_dev() is not a string??

Is this a bug? You don't really expect this to work do you?

-- Steve



> +		__assign_str(kind, q->ops->id);
> +		__entry->parent = q->parent;
> +		__entry->handle = q->handle;
> +	),
> +
> +	TP_printk("dev=%s kind=%s parent=%x:%x handle=%x:%x", __get_str(dev),
> +		  __get_str(kind), TC_H_MAJ(__entry->parent) >> 16, TC_H_MIN(__entry->parent),
> +		  TC_H_MAJ(__entry->handle) >> 16, TC_H_MIN(__entry->handle))
> +);
> +
> +TRACE_EVENT(qdisc_destroy,
> +
> +	TP_PROTO(struct Qdisc *q),
> +
> +	TP_ARGS(q),
> +
> +	TP_STRUCT__entry(
> +		__string(	dev,		qdisc_dev(q)	)
> +		__string(	kind,		q->ops->id	)
> +		__field(	u32,		parent		)
> +		__field(	u32,		handle		)
> +	),
> +
> +	TP_fast_assign(
> +		__assign_str(dev, qdisc_dev(q));
> +		__assign_str(kind, q->ops->id);
> +		__entry->parent = q->parent;
> +		__entry->handle = q->handle;
> +	),
> +
> +	TP_printk("dev=%s kind=%s parent=%x:%x handle=%x:%x", __get_str(dev),
> +		  __get_str(kind), TC_H_MAJ(__entry->parent) >> 16, TC_H_MIN(__entry->parent),
> +		  TC_H_MAJ(__entry->handle) >> 16, TC_H_MIN(__entry->handle))
> +);
> +
>  #endif /* _TRACE_QDISC_H */
>  
>  /* This part must be outside protection */
> diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
> index 7a0b06001e48..abaa446ed01a 100644
> --- a/net/sched/sch_generic.c
> +++ b/net/sched/sch_generic.c
> @@ -911,6 +911,8 @@ void qdisc_reset(struct Qdisc *qdisc)
>  	const struct Qdisc_ops *ops = qdisc->ops;
>  	struct sk_buff *skb, *tmp;
>  
> +	trace_qdisc_reset(qdisc);
> +
>  	if (ops->reset)
>  		ops->reset(qdisc);
>  
> @@ -965,6 +967,8 @@ static void qdisc_destroy(struct Qdisc *qdisc)
>  	module_put(ops->owner);
>  	dev_put(qdisc_dev(qdisc));
>  
> +	trace_qdisc_destroy(qdisc);
> +
>  	call_rcu(&qdisc->rcu, qdisc_free_cb);
>  }
>  


