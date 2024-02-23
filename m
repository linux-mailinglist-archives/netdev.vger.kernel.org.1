Return-Path: <netdev+bounces-74459-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C08D8615F9
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 16:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B64F91F249CF
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 15:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B4581ADF;
	Fri, 23 Feb 2024 15:36:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733181759;
	Fri, 23 Feb 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708702584; cv=none; b=saZxPyrwFnHXO7e2Qc9SXOXdD+9oVYdEz43ylwBt7Xwr3m0K71miOeN98YPMvVE95HP6Cml/geOKPTODP3I5mWg6X4GYPjy35oSuxz/bS+E2IwPCFkU78F+RyVzguRhpvEj7uiYdKTOqFftdHQa6mSEWFlI+aUG2qup1XqJbjvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708702584; c=relaxed/simple;
	bh=Uz267hoWdPLQH3E1v2gFusexG8PONe8ZHslW5HTLxps=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZDfyeoGGIFMfHpoMZtibFtAGMWaupUYO4lTua08m7Euk9FoZ2GWerpF8KDsHA/tDJ2pIeopE+4JVN7Kop90XG1S+qxgDcYRfnYFu0R2eGLmID8piISVo2iI/5odmC08ay+D4hTOsj7sS3ydHCtaULjgiHoV2iQEALGAHxXWC88Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE365C433F1;
	Fri, 23 Feb 2024 15:36:22 +0000 (UTC)
Date: Fri, 23 Feb 2024 10:38:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tobias Waldekranz <tobias@waldekranz.com>
Cc: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com,
 razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
 jiri@resnulli.us, ivecera@redhat.com, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
Message-ID: <20240223103815.35fdf430@gandalf.local.home>
In-Reply-To: <20240223114453.335809-5-tobias@waldekranz.com>
References: <20240223114453.335809-1-tobias@waldekranz.com>
	<20240223114453.335809-5-tobias@waldekranz.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 23 Feb 2024 12:44:53 +0100
Tobias Waldekranz <tobias@waldekranz.com> wrote:

> Add a basic set of tracepoints:
> 
> - switchdev_defer: Fires whenever an operation is enqueued to the
>   switchdev workqueue for deferred delivery.
> 
> - switchdev_call_{atomic,blocking}: Fires whenever a notification is
>   sent to the corresponding switchdev notifier chain.
> 
> - switchdev_call_replay: Fires whenever a notification is sent to a
>   specific driver's notifier block, in response to a replay request.
> 
> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
> ---
>  include/trace/events/switchdev.h | 74 ++++++++++++++++++++++++++++++++
>  net/switchdev/switchdev.c        | 71 +++++++++++++++++++++++++-----
>  2 files changed, 135 insertions(+), 10 deletions(-)
>  create mode 100644 include/trace/events/switchdev.h
> 
> diff --git a/include/trace/events/switchdev.h b/include/trace/events/switchdev.h
> new file mode 100644
> index 000000000000..dcaf6870d017
> --- /dev/null
> +++ b/include/trace/events/switchdev.h
> @@ -0,0 +1,74 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#undef TRACE_SYSTEM
> +#define TRACE_SYSTEM	switchdev
> +
> +#if !defined(_TRACE_SWITCHDEV_H) || defined(TRACE_HEADER_MULTI_READ)
> +#define _TRACE_SWITCHDEV_H
> +
> +#include <linux/tracepoint.h>
> +#include <net/switchdev.h>
> +
> +#define SWITCHDEV_TRACE_MSG_MAX 128

128 bytes is awfully big to waste on the ring buffer. What's the average
size of a string?

> +
> +DECLARE_EVENT_CLASS(switchdev_call,
> +	TP_PROTO(unsigned long val,
> +		 const struct switchdev_notifier_info *info,
> +		 int err),
> +
> +	TP_ARGS(val, info, err),
> +
> +	TP_STRUCT__entry(
> +		__field(unsigned long, val)
> +		__string(dev, info->dev ? netdev_name(info->dev) : "(null)")
> +		__field(const struct switchdev_notifier_info *, info)
> +		__field(int, err)
> +		__array(char, msg, SWITCHDEV_TRACE_MSG_MAX)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->val = val;
> +		__assign_str(dev, info->dev ? netdev_name(info->dev) : "(null)");
> +		__entry->info = info;
> +		__entry->err = err;
> +		switchdev_notifier_str(val, info, __entry->msg, SWITCHDEV_TRACE_MSG_MAX);

Is it possible to just store the information in the trace event and then
call the above function in the read stage? There's helpers to pass strings
around (namely a struct trace_seq *p).

It would require a plugin for libtraceevent if you want to expose it to
user space tools for trace-cmd and perf though.

Another possibility is if this event will not race with other events on he
same CPU, you could create a per-cpu buffer, write into that, and then use
__string() and __assign_str() to save it, as traces happen with preemption
disabled.

-- Steve

> +	),
> +
> +	TP_printk("dev %s %s -> %d", __get_str(dev), __entry->msg, __entry->err)
> +);
> +
> +DEFINE_EVENT(switchdev_call, switchdev_defer,
> +	TP_PROTO(unsigned long val,
> +		 const struct switchdev_notifier_info *info,
> +		 int err),
> +
> +	TP_ARGS(val, info, err)
> +);
> +
> +DEFINE_EVENT(switchdev_call, switchdev_call_atomic,
> +	TP_PROTO(unsigned long val,
> +		 const struct switchdev_notifier_info *info,
> +		 int err),
> +
> +	TP_ARGS(val, info, err)
> +);
> +
> +DEFINE_EVENT(switchdev_call, switchdev_call_blocking,
> +	TP_PROTO(unsigned long val,
> +		 const struct switchdev_notifier_info *info,
> +		 int err),
> +
> +	TP_ARGS(val, info, err)
> +);
> +
> +DEFINE_EVENT(switchdev_call, switchdev_call_replay,
> +	TP_PROTO(unsigned long val,
> +		 const struct switchdev_notifier_info *info,
> +		 int err),
> +
> +	TP_ARGS(val, info, err)
> +);
> +
> +#endif /* _TRACE_SWITCHDEV_H */
> +

