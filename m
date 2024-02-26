Return-Path: <netdev+bounces-74923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A916867615
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 14:09:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74C90B24517
	for <lists+netdev@lfdr.de>; Mon, 26 Feb 2024 13:05:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E8780037;
	Mon, 26 Feb 2024 13:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b="BMEnCvpI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902E27F7F9
	for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 13:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708952725; cv=none; b=N1SOG01cZUXvqhh63Y9sibuW7fkszl+e6Pv6FBlmz5pbpCqgKK4FNoqAm4r12IyyNym8DSh/0G+Y3jRNBqgDXPFSC1qc+9dTefVNk/cegd4MzFG+MXFYZK2p1Lr8bVByCXz4tMFAi7wxvikzq12bGxOmPklhxcwX4d8b63MIhCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708952725; c=relaxed/simple;
	bh=I9nudPBmH1+ABpCfIvC23xUTfEYS66YUpJFBesnh/ys=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tyISvMhx9ky2ZvYbQWpsvL5eSwmmmNUKXOeo6OcoJtCF6DFvwNhEdLS4plJ7PX4JrjnFpF+iQwRQjTLvu8CD8cmwcfQEymK/CTMzatBpMoBycte6XR7IzVaBhBc3pa1x46zmtROipvDkL6j4BfvJg/ob1xs1dMKLl9DQ8TXhvOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com; spf=pass smtp.mailfrom=waldekranz.com; dkim=pass (2048-bit key) header.d=waldekranz-com.20230601.gappssmtp.com header.i=@waldekranz-com.20230601.gappssmtp.com header.b=BMEnCvpI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=waldekranz.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=waldekranz.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-512b13bf764so3690425e87.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 05:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=waldekranz-com.20230601.gappssmtp.com; s=20230601; t=1708952721; x=1709557521; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=iXsjpaTb0bQigvYBS/pBWZ23VKwk/d7ZGal1Zt75OOY=;
        b=BMEnCvpIi3Bob9oSLpK4G90pdRizkeOj6R+lrWLEJ8LUAOB7WJIjltvWw7mgcEwich
         eO6zdJWLA8wCtCBMqQeH/EhvPaTLlsrsNAymOWF5CSzEVprgYiQuIu/ToIv1WzjiwPGp
         sQY6xclG2z9Scslb894opZEU6Q1F9avgp3P2Z+H5O3gkqKjrbo3XyID6W/88xaPU/d2Y
         nyRDGn/m4gRIVQhBBggr36NBJ/Pdy9Bi7yep1QC3slgIAwGhbjwkjMUV8vWt9JdyIkLX
         +cjeuh+WfTcxwClxrh6mbk0BjvlTCrCBggUtW/2lRnvrkElW+sYTX+7JfMzqt+CUe1K7
         GFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708952721; x=1709557521;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iXsjpaTb0bQigvYBS/pBWZ23VKwk/d7ZGal1Zt75OOY=;
        b=ch54aTBJvClXTEqF0CYHFIi99A9gSYLWS2h/aZNELM5Wwi96OxyaZwr15R01SOe3JO
         UujGOU+vxqcrAz2cpYFXkZbP9fmdlBr/vrvIjmlBxLunyF1wyxobjTqthAQDENaggJHD
         5/wZwiNV27ZDsN6T5Z9QYLOsbHWnTXLB7Gmq7pjkHMG99m4+D7CanhmPG5CcEU74ZQJL
         6i2E5/saQCdt+n4UQKVJHAuISDE3CwaIJgzSxJWI/fGntMOb5w1WDdFtBqpqIumaEXhf
         Y25Y2/5rWmlAA02M+9NWrbgyI3DtXF1dXQsV3KcJ+YXL0k5ZqLYY+BBbE5pGTWUpf3Wg
         SUHQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2OxDjSBi85Eh0Lact9oC0ZpHrr+qz0gv6JFj4Sm/QunD7EE86EnrOLhQo12m8HXd2Z4sspIRVHk/unJiJTyH3PTa3Evmi
X-Gm-Message-State: AOJu0YylabV/33cXx8xzvi0HVYvbH3QRjmqD0VnDSvNoXiPe1+bWn6pD
	pJaB3iArubd1xuvYBhqa/3TTKPlrM8Wkv+i/6/z0GQAT2n9C/+rR+ulTz52qtlc=
X-Google-Smtp-Source: AGHT+IG5hh7CurEjOaQi9heB+jROTX4JXnIOCWWtXdCKtxsZKsex4mK150b3mCJbu2almX5myN8AvQ==
X-Received: by 2002:ac2:4da9:0:b0:512:f4bb:d3c5 with SMTP id h9-20020ac24da9000000b00512f4bbd3c5mr3875078lfe.7.1708952721378;
        Mon, 26 Feb 2024 05:05:21 -0800 (PST)
Received: from wkz-x13 (a124.broadband3.quicknet.se. [46.17.184.124])
        by smtp.gmail.com with ESMTPSA id g11-20020ac24d8b000000b00512c9c3aefasm836795lfe.236.2024.02.26.05.05.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 05:05:20 -0800 (PST)
From: Tobias Waldekranz <tobias@waldekranz.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: davem@davemloft.net, kuba@kernel.org, roopa@nvidia.com,
 razor@blackwall.org, bridge@lists.linux.dev, netdev@vger.kernel.org,
 jiri@resnulli.us, ivecera@redhat.com, mhiramat@kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 net-next 4/4] net: switchdev: Add tracepoints
In-Reply-To: <20240223103815.35fdf430@gandalf.local.home>
References: <20240223114453.335809-1-tobias@waldekranz.com>
 <20240223114453.335809-5-tobias@waldekranz.com>
 <20240223103815.35fdf430@gandalf.local.home>
Date: Mon, 26 Feb 2024 14:05:20 +0100
Message-ID: <87cysjgyun.fsf@waldekranz.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On fre, feb 23, 2024 at 10:38, Steven Rostedt <rostedt@goodmis.org> wrote:
> On Fri, 23 Feb 2024 12:44:53 +0100
> Tobias Waldekranz <tobias@waldekranz.com> wrote:
>
>> Add a basic set of tracepoints:
>> 
>> - switchdev_defer: Fires whenever an operation is enqueued to the
>>   switchdev workqueue for deferred delivery.
>> 
>> - switchdev_call_{atomic,blocking}: Fires whenever a notification is
>>   sent to the corresponding switchdev notifier chain.
>> 
>> - switchdev_call_replay: Fires whenever a notification is sent to a
>>   specific driver's notifier block, in response to a replay request.
>> 
>> Signed-off-by: Tobias Waldekranz <tobias@waldekranz.com>
>> ---
>>  include/trace/events/switchdev.h | 74 ++++++++++++++++++++++++++++++++
>>  net/switchdev/switchdev.c        | 71 +++++++++++++++++++++++++-----
>>  2 files changed, 135 insertions(+), 10 deletions(-)
>>  create mode 100644 include/trace/events/switchdev.h
>> 
>> diff --git a/include/trace/events/switchdev.h b/include/trace/events/switchdev.h
>> new file mode 100644
>> index 000000000000..dcaf6870d017
>> --- /dev/null
>> +++ b/include/trace/events/switchdev.h
>> @@ -0,0 +1,74 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#undef TRACE_SYSTEM
>> +#define TRACE_SYSTEM	switchdev
>> +
>> +#if !defined(_TRACE_SWITCHDEV_H) || defined(TRACE_HEADER_MULTI_READ)
>> +#define _TRACE_SWITCHDEV_H
>> +
>> +#include <linux/tracepoint.h>
>> +#include <net/switchdev.h>
>> +
>> +#define SWITCHDEV_TRACE_MSG_MAX 128
>
> 128 bytes is awfully big to waste on the ring buffer. What's the average
> size of a string?

I would say the typical message is around 60-80 bytes. Some common examples:

    PORT_OBJ_ADD PORT_VLAN(flags 0x0 orig br0) vid 1 flags 0x27
    PORT_OBJ_DEL HOST_MDB(flags 0x0 orig br0) vid 100 addr 33:33:ff:ff:00:09

The worst case I can think of currently is 95 characters:

    VXLAN_FDB_ADD_TO_DEVICE vid 1000 addr de:ad:be:ef:00:01 added_by_user is_local locked offloaded

>> +
>> +DECLARE_EVENT_CLASS(switchdev_call,
>> +	TP_PROTO(unsigned long val,
>> +		 const struct switchdev_notifier_info *info,
>> +		 int err),
>> +
>> +	TP_ARGS(val, info, err),
>> +
>> +	TP_STRUCT__entry(
>> +		__field(unsigned long, val)
>> +		__string(dev, info->dev ? netdev_name(info->dev) : "(null)")
>> +		__field(const struct switchdev_notifier_info *, info)
>> +		__field(int, err)
>> +		__array(char, msg, SWITCHDEV_TRACE_MSG_MAX)
>> +	),
>> +
>> +	TP_fast_assign(
>> +		__entry->val = val;
>> +		__assign_str(dev, info->dev ? netdev_name(info->dev) : "(null)");
>> +		__entry->info = info;
>> +		__entry->err = err;
>> +		switchdev_notifier_str(val, info, __entry->msg, SWITCHDEV_TRACE_MSG_MAX);
>
> Is it possible to just store the information in the trace event and then
> call the above function in the read stage? There's helpers to pass strings
> around (namely a struct trace_seq *p).

I'm a complete novice when it comes to tracepoint internals. Am I right
in assuming that TP_printk may execute at a much later time than
TP_fast_assign? E.g., the object referenced by __entry->info may very
well have been freed by that time? That at least seems to be what my
naive refactor to replace __entry->msg with __get_buf() suggests :)

If so, the layout of the switchdev_notifier_* structs makes it a bit
cumbersome to clone the notification in the assign phase, as the size of
a specific notification (e.g., switchdev_notifier_port_obj_info) is not
known by the common notification (switchdev_notifier_info). In the case
of switchdev objects, the problem repeats a second time. E.g., the size
of switchdev_obj_port_vlan is not known by switchdev_obj.

> It would require a plugin for libtraceevent if you want to expose it to
> user space tools for trace-cmd and perf though.
>
> Another possibility is if this event will not race with other events on he
> same CPU, you could create a per-cpu buffer, write into that, and then use
> __string() and __assign_str() to save it, as traces happen with preemption
> disabled.

But bottom halves are still enabled I suppose? Notifications can be
generated both from process context (e.g., users configuring the bridge
with iproute2), and from bridge packet processing (e.g., adding new
neighbors to the FDB). So I don't think that would work in this case.

> -- Steve

Thanks for taking the time!

>> +	),
>> +
>> +	TP_printk("dev %s %s -> %d", __get_str(dev), __entry->msg, __entry->err)
>> +);
>> +
>> +DEFINE_EVENT(switchdev_call, switchdev_defer,
>> +	TP_PROTO(unsigned long val,
>> +		 const struct switchdev_notifier_info *info,
>> +		 int err),
>> +
>> +	TP_ARGS(val, info, err)
>> +);
>> +
>> +DEFINE_EVENT(switchdev_call, switchdev_call_atomic,
>> +	TP_PROTO(unsigned long val,
>> +		 const struct switchdev_notifier_info *info,
>> +		 int err),
>> +
>> +	TP_ARGS(val, info, err)
>> +);
>> +
>> +DEFINE_EVENT(switchdev_call, switchdev_call_blocking,
>> +	TP_PROTO(unsigned long val,
>> +		 const struct switchdev_notifier_info *info,
>> +		 int err),
>> +
>> +	TP_ARGS(val, info, err)
>> +);
>> +
>> +DEFINE_EVENT(switchdev_call, switchdev_call_replay,
>> +	TP_PROTO(unsigned long val,
>> +		 const struct switchdev_notifier_info *info,
>> +		 int err),
>> +
>> +	TP_ARGS(val, info, err)
>> +);
>> +
>> +#endif /* _TRACE_SWITCHDEV_H */
>> +

