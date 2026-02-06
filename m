Return-Path: <netdev+bounces-257501-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0NbNIa+1hWmOFgQAu9opvQ
	(envelope-from <netdev+bounces-257501-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:34:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0DE6FC141
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 10:34:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 18CD63007C8D
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 09:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75A7435D5FA;
	Fri,  6 Feb 2026 09:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XZEDZlwo";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpjaozEY"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 193FA35B651
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 09:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370296; cv=none; b=iROp7RcuKAH7ETglvkxpaPmTIZpga6lbU5aEQH6EOEpu/O/BpXdhOJ1cELo2kjJnAYltTxIidwwSylf0Aah1UdZLXlbTYU75P5RzUpXIvNzTkB5KmObhyHN+bTFZz76TzEpNFDl2qTQYZT6tMnD0wkmiPjc8h2tvVOTopB95DbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370296; c=relaxed/simple;
	bh=AZErRJuX4VSgdhM0SMFp4ZfOGqCP+e1gDUw6damSyQQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=NWGsn3Cci2Oieh19+YHaCCzpyMMDMDaIsvFlx2nv1iZDnexYdinJDn2KS7iZMXsG43WIGRJXRU5tfgBNBF1J16+6nnXm6/JayyRu73VOZ4ZJi9ZRKjZy59dwEMNZvjK9www8YV6kGHjYtCHOgn4TgThGFuGw46H/W2/kQbquAeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XZEDZlwo; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=WpjaozEY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770370295;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m83qFJJ/01p5WS71hLn6ZqZlvQWtUzYkRVCrBOr7lc8=;
	b=XZEDZlwonLQDhkbVqhPQXF8URvpYNFvv6sHWyvKWVZyusKXP3D66orc1ug26S2+iOE89e/
	5FahkGG4K2CwLddwstuEh3DTwCkwGZBDJZ6aVf/71yLlH/5UhCoUwvriKXsZ2fFddAIaP0
	dtWopBVEZQ/wuYD0SDcweAKZ8YziQsA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-fqUQ4irdMI-KdlsWH_E4-Q-1; Fri, 06 Feb 2026 04:31:33 -0500
X-MC-Unique: fqUQ4irdMI-KdlsWH_E4-Q-1
X-Mimecast-MFC-AGG-ID: fqUQ4irdMI-KdlsWH_E4-Q_1770370293
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-47d4029340aso21812055e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 01:31:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1770370292; x=1770975092; darn=vger.kernel.org;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=m83qFJJ/01p5WS71hLn6ZqZlvQWtUzYkRVCrBOr7lc8=;
        b=WpjaozEYr5fkBm5qPzxlY4aXiZZdD3haaUBpOPQwTCdFzw1/PT9sOJwxK6FP8jC4m/
         UDq+b0X2Rum3TDyFeQST6bnFgKvkbpGTIjWGGysu5ZCDv3pR8q0ZdPs4J2+Rmu1yv+Zm
         1W7borB0B/AMcOoUsOd2t195yuAZBPIl6i/hDS3W0+ydjDPkRFfXoZc5a90fuBCux9lV
         4cGqL3x+5xtrW5Po1Pkg4MyAwhhubNh85vPg+Dhuk9oFFE+SYsKjrnYO1OM3J8mYcWwL
         h9EOsKw9YJa9jUpX0T4cyfH8qa64ZANwXkEEyU55pQnalF3DpFT86hkCxgW4/ptVmwKx
         32Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770370292; x=1770975092;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m83qFJJ/01p5WS71hLn6ZqZlvQWtUzYkRVCrBOr7lc8=;
        b=nmY4aY/2/vKtF0UHtSW046ymDff6b8BBLRVenJMtXxJBQOL806VKyWJxk4vHeWjmUj
         Z1HPqiQM4JtsH5jDgfNqWP4xvJPImvtgpRrXWbSy2RqSl44xLPE0fO2fxfJyRdJtJX0r
         POVOPXdZrtLyxnwArIMYAzt1dgdLuZqeboxDHYacSRyE8hmPLy6jlegQpq/ApboLBxE6
         BkDx+XNKAN9lHD2oVhWnANmmliT8UMl5++EdY+Jo52pVUTNDeMgNS7nFvxrdCpsRDyMJ
         UAToxQfIL7Z8Dw7CT2eAfoz2eLCaCAW1t1f8KwE6pcHNGhu/vUhyN1SeyHvBoYb+afJ9
         HVhA==
X-Forwarded-Encrypted: i=1; AJvYcCXm2b33Zn9eeD9EC3UKfL3CTNSaA2LFlD0L+VhesA+toYIGFNWPn7OSuqBb9tKFGsZcFS8vkWg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNCwOuOHmHR2EVkb4aScy5YJPD/S7d8cAZFrh/Wls3+qQevlxO
	on2Zt7YGMFZyb0q12HqH3YWnnSzz0w4dZueA8rVC6iuScri4nRuf/deLO5D0fXKfsBtEdQxzntP
	uIyKXgMxIbJ/tXzsJ8ybqP6rFaIDVa4t+oh92Mb7SUF/HFdaMa9OtZkJf5w==
X-Gm-Gg: AZuq6aLA8nnX437+8K8VY3OewKqGfCW68k79olimmGx2WF0ERLy3OkWZhmj3rRpPG2Y
	A9GZ88tqVvAUC7WmXLurK6gQdmr3zrw2IVlg/nTlaLvFh4/wqfLMNnyAz5w9QwPiXVyEIGkfJu0
	J3aS6V2NV35R3M83hanlGWhdyOWqMP1olHSIgUeREbYak1yxmNUU0zUDcT6It8GnMJnx2TlWLob
	ALfVfpbW/n+oEh0hfMJiW22qLp9w4jrDifDffTbRjkJ8KKdfQylcMh+LLnbR7V6KPDJqMlwegzZ
	iuW4SnW8AQLDOfV24gfCqA56RckZqNgbv9F9ZmGV0frMm1ktYg3cUKcjgh895bO5AheYYhG/ayy
	ae3zqNpw9Nj/JOqH3DVCQp16bsk5OD5ohdw==
X-Received: by 2002:a05:600c:35d1:b0:480:3a72:524a with SMTP id 5b1f17b1804b1-4832021b572mr27051575e9.19.1770370292473;
        Fri, 06 Feb 2026 01:31:32 -0800 (PST)
X-Received: by 2002:a05:600c:35d1:b0:480:3a72:524a with SMTP id 5b1f17b1804b1-4832021b572mr27051125e9.19.1770370291959;
        Fri, 06 Feb 2026 01:31:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48320728ac7sm36880205e9.13.2026.02.06.01.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 01:31:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 595AF4FE19A; Fri, 06 Feb 2026 10:31:30 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Jesper Dangaard Brouer <hawk@kernel.org>, netdev@vger.kernel.org, Eric
 Dumazet <eric.dumazet@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>, horms@kernel.org, jiri@resnulli.us,
 edumazet@google.com, xiyou.wangcong@gmail.com, jhs@mojatatu.com,
 atenart@redhat.com, carges@cloudflare.com, kernel-team@cloudflare.com
Subject: Re: [PATCH net-next v2 1/6] net: sched: introduce qdisc-specific
 drop reason tracing
In-Reply-To: <177032649028.1975497.12663177216553780756.stgit@firesoul>
References: <177032644012.1975497.16411100029657607833.stgit@firesoul>
 <177032649028.1975497.12663177216553780756.stgit@firesoul>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 06 Feb 2026 10:31:30 +0100
Message-ID: <87sebez099.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.37 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.53)[subject];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[kernel.org,vger.kernel.org,gmail.com,davemloft.net,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,resnulli.us,google.com,gmail.com,mojatatu.com,redhat.com,cloudflare.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257501-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toke.dk:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: E0DE6FC141
X-Rspamd-Action: no action

Jesper Dangaard Brouer <hawk@kernel.org> writes:

> Create new enum qdisc_drop_reason and trace_qdisc_drop tracepoint
> for qdisc layer drop diagnostics with direct qdisc context visibility.
>
> The new tracepoint includes qdisc handle, parent, kind (name), and
> device information. Existing SKB_DROP_REASON_QDISC_DROP is retained
> for backwards compatibility via kfree_skb_reason().
>
> Convert FQ, FQ_CoDel, CoDel, SFB, and pfifo_fast to use the new
> infrastructure.
>
> Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
> ---
>  include/net/dropreason-core.h  |   42 ++----------------
>  include/net/dropreason-qdisc.h |   94 ++++++++++++++++++++++++++++++++++++++++
>  include/net/dropreason.h       |    6 +++
>  include/net/sch_generic.h      |   36 ++++++++++-----
>  include/trace/events/qdisc.h   |   51 ++++++++++++++++++++++
>  net/core/dev.c                 |    8 ++-
>  net/sched/sch_cake.c           |    6 +--
>  net/sched/sch_codel.c          |    5 +-
>  net/sched/sch_dualpi2.c        |    8 +--
>  net/sched/sch_fq.c             |    7 +--
>  net/sched/sch_fq_codel.c       |    4 +-
>  net/sched/sch_fq_pie.c         |    4 +-
>  net/sched/sch_generic.c        |   22 +++++++++
>  net/sched/sch_gred.c           |    4 +-
>  net/sched/sch_pie.c            |    4 +-
>  net/sched/sch_red.c            |    4 +-
>  net/sched/sch_sfb.c            |    4 +-
>  17 files changed, 225 insertions(+), 84 deletions(-)
>  create mode 100644 include/net/dropreason-qdisc.h
>
> diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
> index a7b7abd66e21..3d8d284e05c8 100644
> --- a/include/net/dropreason-core.h
> +++ b/include/net/dropreason-core.h
> @@ -68,12 +68,6 @@
>  	FN(SECURITY_HOOK)		\
>  	FN(QDISC_DROP)			\
>  	FN(QDISC_BURST_DROP)		\
> -	FN(QDISC_OVERLIMIT)		\
> -	FN(QDISC_CONGESTED)		\
> -	FN(CAKE_FLOOD)			\
> -	FN(FQ_BAND_LIMIT)		\
> -	FN(FQ_HORIZON_LIMIT)		\
> -	FN(FQ_FLOW_LIMIT)		\
>  	FN(CPU_BACKLOG)			\
>  	FN(XDP)				\
>  	FN(TC_INGRESS)			\
> @@ -371,8 +365,10 @@ enum skb_drop_reason {
>  	/** @SKB_DROP_REASON_SECURITY_HOOK: dropped due to security HOOK */
>  	SKB_DROP_REASON_SECURITY_HOOK,
>  	/**
> -	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc when packet outputting (
> -	 * failed to enqueue to current qdisc)
> +	 * @SKB_DROP_REASON_QDISC_DROP: dropped by qdisc during enqueue or
> +	 * dequeue. More specific drop reasons are available via the
> +	 * qdisc:qdisc_drop tracepoint, which also provides qdisc handle
> +	 * and name for identifying the source.

IIUC, this is not needed, see below:

[...]

> @@ -37,6 +37,24 @@
>  const struct Qdisc_ops *default_qdisc_ops = &pfifo_fast_ops;
>  EXPORT_SYMBOL(default_qdisc_ops);
>  
> +void tcf_kfree_skb_list(struct sk_buff *skb, struct Qdisc *q,
> +			struct netdev_queue *txq,
> +			struct net_device *dev)
> +{
> +	while (unlikely(skb)) {
> +		struct sk_buff *next = skb->next;
> +		enum qdisc_drop_reason reason = tcf_get_qdisc_drop_reason(skb);
> +
> +		prefetch(next);
> +		/* Catch wrong enum: skb_drop_reason vs qdisc_drop_reason */
> +		WARN_ON_ONCE(reason && reason < __QDISC_DROP_REASON);
> +		trace_qdisc_drop(q, txq, dev, skb, reason);
> +		kfree_skb_reason(skb, SKB_DROP_REASON_QDISC_DROP);

AFAIU, the idea here is that you just pass the same 'reason' value to
kfree_skb_reason(). Because of the subsys shift and offset, these will
all be unique values, so anyone just watching the old tracepoint will
get QDISC_DROP_* reasons with no context, and if you want the context
you listen to the qdisc_drop tracepoint.

-Toke


