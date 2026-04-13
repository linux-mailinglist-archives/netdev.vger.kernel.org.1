Return-Path: <netdev+bounces-278231-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHenEk523WngeQkAu9opvQ
	(envelope-from <netdev+bounces-278231-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:03:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD493F4288
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 01:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 328933029AC0
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 23:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B808039B94B;
	Mon, 13 Apr 2026 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gdk4Q6kR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94A7737F8CE;
	Mon, 13 Apr 2026 23:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776121335; cv=none; b=pRz0mfimktEWntPlKGjf0fZ2BkeEVQmK8dz5veM9uIELv0UnDF6NVSbZGpe6McLd0b7GzlKRUrDFyqiLukiL6W1r0AcuHe4vF0z+KOBQuQnt8wdSRnPoAc99N8dHsViv97KX3SoClGU0hmSf/owdKdtOXSQJdy+fbj/NC5EbNYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776121335; c=relaxed/simple;
	bh=XV+qyeNvksi2iB4yj+W+MjhgVvM/c59d8lUWBxtkItA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t7+GLhZeo3KezYZh5/VHdWGcqIYEP7RJBcQJKDd4zTWgPMMzzGnOT7ojHzXFeOi2O4OMQskZ1R3/aMCwmou+AYKdDUI4ZyXCF9z263xzm2gEVdMVBeD7YWF0iYx+uHh8Ym0MdFOkIkkPOExCQKCD5jKH/H/dD52Gn+ASy6IaKqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gdk4Q6kR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B22FC2BCAF;
	Mon, 13 Apr 2026 23:02:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776121335;
	bh=XV+qyeNvksi2iB4yj+W+MjhgVvM/c59d8lUWBxtkItA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gdk4Q6kRbF88Bt5gbDg8Szgf/Woqx2JcxDo6MTz/6LTKZMVUCAFkd7ESbW6GYilob
	 ozt+QBqLL4arBqP/7mIwNIeV2iaZipaE00w8rLz9a6Ur8msxTitzKDLQaQVCmpB3sC
	 iZ2XE+vPu2vqwrhVygkC5jW1cilB+JIW8OsdwR+173wcRy49SVbwrz0sheK04aBWEE
	 PikExGhkdlEQkzlNS9M0VKSIs3pesojp1hHQVaKiu1vLQZOwPWHwxGcLdF4Vd59gjg
	 2OXoHjByRp10YmpMKnvHH+rz50TsbaNiG3M6fsTn3Cpyvc9AIKRuSCXiQMZdRPvgMY
	 KwZY1W/EtXhqA==
From: Jakub Kicinski <kuba@kernel.org>
To: vinicius.gomes@intel.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	vladimir.oltean@nxp.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	qjx1298677004@gmail.com
Subject: Re: [PATCH net] net/sched: taprio: fix use-after-free in advance_sched() on schedule switch
Date: Mon, 13 Apr 2026 16:01:06 -0700
Message-ID: <20260413230106.3654555-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410-taprio-user-after-free-fix-net-v1-1-0931b1579988@intel.com>
References: <20260410-taprio-user-after-free-fix-net-v1-1-0931b1579988@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TAGGED_FROM(0.00)[bounces-278231-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,nxp.com,mojatatu.com,resnulli.us,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9CD493F4288
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net/sched: taprio: fix use-after-free in advance_sched() on schedule switch

This commit updates advance_sched() to select the next entry from the new
oper schedule immediately after switch_schedules() returns. It relies on the
pre-calculated end_time of the new schedule's first entry instead of
overwriting it with the admin schedule's base time.

> diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
> index f721c03514f60..0316f2dee06ac 100644
> --- a/net/sched/sch_taprio.c
> +++ b/net/sched/sch_taprio.c

[ ... ]

> @@ -972,11 +972,12 @@ static enum hrtimer_restart advance_sched(struct hrtimer *timer)
>  	}
>  
>  	if (should_change_schedules(admin, oper, end_time)) {
> -		/* Set things so the next time this runs, the new
> -		 * schedule runs.
> -		 */
> -		end_time = sched_base_time(admin);

Does removing this assignment introduce a regression where the new schedule
activates prematurely?

Since the new schedule's first entry has its end_time pre-calculated
as base_time + interval, if we activate it early (before its actual
base_time), does it stretch the entry backwards in time?

Could this cause its gate mask to apply during the time gap, violating the
strictly configured gate durations?

>  		switch_schedules(q, &admin, &oper);

Can this sequence cause a use-after-free regression due to the RCU grace
period starting too early?

Inside switch_schedules(), call_rcu() is invoked on the old oper
schedule. However, q->current_entry is not updated until later in
advance_sched() at the first_run label:

first_run:
	rcu_assign_pointer(q->current_entry, next);

If a concurrent reader calls rcu_dereference(q->current_entry) between
switch_schedules() and this assignment, can it acquire a pointer to the
old schedule after call_rcu() has already started? This would mean the
grace period will not wait for this new reader.

As a separate pre-existing issue, can switch_schedules() be called
concurrently by lockless readers?

If advance_sched() calls it under q->current_entry_lock, but a concurrent
reader like get_packet_txtime() evaluates the switch condition and calls
switch_schedules() without holding locks, can they race?

Could this lead to call_rcu() being called twice on the same old oper
object, potentially corrupting the RCU callback list?

> +		/* After changing schedules, the next entry is the first one
> +		 * in the new schedule, with a pre-calculated end_time.
> +		 */
> +		next = list_first_entry(&oper->entries, struct sched_entry, list);
> +		end_time = next->end_time;
>  	}
>  
>  	next->end_time = end_time;

