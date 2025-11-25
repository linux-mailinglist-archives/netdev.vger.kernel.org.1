Return-Path: <netdev+bounces-241574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE847C85F4C
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:24:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A903B4215
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73F523B63E;
	Tue, 25 Nov 2025 16:22:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C1E238176;
	Tue, 25 Nov 2025 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764087754; cv=none; b=UMR4jVopEH/iKTLc+V/2gbLi3lSQ65DgMlYWAvsCV3BkOiaSbEaexAd0MEQydv0gfAeoMg0m3tFolKwHIC1mHYZFydXI6b/4hpNC0MwbiEUOgkcOaRZzKpfByxqIFeSq8bqujh+a5dVIVHucJPF2QuY+I3hLJZqpbSd2s0eNB8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764087754; c=relaxed/simple;
	bh=qB0xmOJ8kffWlzkOUo7IgIFlqKInbkNyJftYVwb7L5I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sou1UOXUuJ3WzPZ7fuAfMXp+4H75Wdq3EnxBV+S18TL/YQSo4pGEeX3zhgFP6dt0zVkXqsQ+Ic2rZfHCJdg0xBLBTTN7RaSaadPLddWOyKc9gR1MMwmxul7ltmvTqh7c7UpUxfp6/iUDBjbmV3Xq17gzNasi/LJVLC6/tsjzEpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id DD81C1A0281;
	Tue, 25 Nov 2025 16:22:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 76A773D;
	Tue, 25 Nov 2025 16:22:20 +0000 (UTC)
Date: Tue, 25 Nov 2025 11:23:04 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Leon Hwang <leon.hwang@linux.dev>
Cc: netdev@vger.kernel.org, hawk@kernel.org, ilias.apalodimas@linaro.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kerneljasonxing@gmail.com, lance.yang@linux.dev, jiayuan.chen@linux.dev,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Leon
 Huang Fu <leon.huangfu@shopee.com>
Subject: Re: [RFC PATCH net-next] page_pool: Add page_pool_release_stalled
 tracepoint
Message-ID: <20251125112304.493ea1ee@gandalf.local.home>
In-Reply-To: <20251125082207.356075-1-leon.hwang@linux.dev>
References: <20251125082207.356075-1-leon.hwang@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 76A773D
X-Stat-Signature: 8kiqc41gsj186tu5zn7dq8ht5stme3of
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18DVnSu8qsB8YHNQi4IYFrBCWT3192d/DQ=
X-HE-Tag: 1764087740-249652
X-HE-Meta: U2FsdGVkX1/k/4FUUqfj/UNxaXdovF4iGJPv6Ni36yi0sbIdryDdf4W87NeY4Oi5QtfF18FvQQlEt/EwjABcDKPiz+PAhB9nUXG2FAjFPV8CpSWdDopJ4TSAU5eVKEBRRbXn/PpqNWH3LEAfzivrtixoS7gDU4coVaNncHOcEBYUFbrFKBsx2DMrilw/Gdox6i8TQG5xPsF7VuqyFDm2dIcOVkzl4jF+5GgQ7+y5GU8tT0BWUbtBW5g5ICOwzKwRKz4AX8Od4+oyNYqCfE/Ghftu63vIYIcWu3hh24V+AZe2ZPb1AWQS0AiqWDDej0xz

On Tue, 25 Nov 2025 16:22:07 +0800
Leon Hwang <leon.hwang@linux.dev> wrote:

> +TRACE_EVENT(page_pool_release_stalled,
> +
> +	TP_PROTO(const struct page_pool *pool, int inflight, int sec),
> +
> +	TP_ARGS(pool, inflight, sec),
> +
> +	TP_STRUCT__entry(
> +		__field(const struct page_pool *, pool)
> +		__field(int,			  inflight)
> +		__field(int,			  sec)
> +	),
> +
> +	TP_fast_assign(
> +		__entry->pool		= pool;
> +		__entry->inflight	= inflight;
> +		__entry->sec		= sec;
> +	),
> +
> +	TP_printk("page_pool=%p id=%d inflight=%d sec=%d",
> +		  __entry->pool, __entry->pool->user.id, __entry->inflight, __entry->sec)

You can't do: __entry->pool->user.id

The TP_fast_assign() is executed when the tracepoint is triggered. The
TP_printk() is executed when the trace is read. That can happen seconds,
minutes, hours, days, even months after the pool was assigned.

That __entry->pool can very well be freed a long time ago.

If you need the id, you need to record it in the TP_fast_assign():

	__entry->id		= pool->user.id

and print that.

-- Steve


> +);
> +

