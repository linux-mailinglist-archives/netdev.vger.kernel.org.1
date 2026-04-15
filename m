Return-Path: <netdev+bounces-278828-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WAazArGx32lSYAAAu9opvQ
	(envelope-from <netdev+bounces-278828-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:41:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDF8406071
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 17:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AD16B309DC4D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 15:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77EE3DE420;
	Wed, 15 Apr 2026 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RdmWN6+S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCABB3DDDDA;
	Wed, 15 Apr 2026 15:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776267128; cv=none; b=elqsUEk3kViwctep66DIRQGB9U5mwFrjNjS4vkMN9mJJwROvrV4LtzqmHnlXX96huJhzSx4MLM3s3MsJ3xfoq4hd+7IcdG47aOsc2yRfus3cttxaZqNH1bfZlV7D2spVwkJVYgjEVfZsdYeNR1XxM0/iqZajHKt5Kny4bHywoBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776267128; c=relaxed/simple;
	bh=CFtvHa69WMtKCj/klsJ3WU0C10TJimhD3Vxn1IO+iCM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HM6T8AczVKrmp75nax6ggsVgnFI/bMYYJPWJZ2BbYCq/zPkY8ydFrotsL9NEVi1lY8gMFOKx+Q0SXQLx8pXuJ9V9zu5gSA0YJq9nH0k6xaDq8cYQxXHKG368zyqpHFHzvATFxYNsUoX/XAcoMuPhgzhT81y+AQdNseUsL4vnv70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RdmWN6+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55E4BC19424;
	Wed, 15 Apr 2026 15:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776267128;
	bh=CFtvHa69WMtKCj/klsJ3WU0C10TJimhD3Vxn1IO+iCM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RdmWN6+SJFrQQb4hezram+/Iz6r+1onMQBy6pNxoIIbpik7ZqSw13stv/gbvpEWy5
	 p5jikQte1ObegSNij0r1JNPrdSuY33RcW+Kneclpy95pvU+eya/TD03teOyHLTmkoD
	 4Bf/Z0Bwc3a7H4zYwOLeN5C6hexRdts9Zq2MZVBI6m+eUjDcj+uLUKJGBHsBerNcqh
	 mepGZ69Nf78Rs+GZQRlx73iatRFZi8WMs731346WGQgpiDkWW4IX6dtRXnd/Fb707O
	 qHimezRMrYbLJzoHMpHhDn0g/HtWK9T5mhAyB+Zu+9plRd2qd4Bm5Q5fkRivP+Wiar
	 yNNjAineXfOaw==
From: Simon Horman <horms@kernel.org>
To: hxzene@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sched: teql: fix use-after-free in teql_master_xmit
Date: Wed, 15 Apr 2026 16:31:52 +0100
Message-ID: <20260415153152.816553-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413094448.2263828-1-hxzene@gmail.com>
References: <20260413094448.2263828-1-hxzene@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278828-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6FDF8406071
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
net: sched: teql: fix use-after-free in teql_master_xmit

This patch attempts to fix a use-after-free in teql_master_xmit() by
saving master->slaves to a local head variable during teql_destroy(),
and by adding READ_ONCE()/WRITE_ONCE() to datapath accesses.

> diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
> index ec4039a201a2c..2e86397a5219c 100644
> --- a/net/sched/sch_teql.c
> +++ b/net/sched/sch_teql.c
> @@ -101,7 +101,7 @@ teql_dequeue(struct Qdisc *sch)
>  	if (skb == NULL) {
>  		struct net_device *m = qdisc_dev(q);
>  		if (m) {
> -			dat->m->slaves = sch;
> +			WRITE_ONCE(dat->m->slaves, sch);

Can this lockless publication write a soon-to-be-freed pointer to
master->slaves?

If teql_dequeue() concurrently executes this write while teql_destroy()
is unlinking sch and scheduling it for deletion via call_rcu(), sch could
be published globally just as it is being destroyed.

When the RCU grace period ends, sch would be freed but still globally
referenced. The WRITE_ONCE() prevents store-tearing but does not prevent
this race condition.

>  		}
>  	} else {
[ ... ]
> @@ -136,19 +136,23 @@ teql_destroy(struct Qdisc *sch)
>  	if (!master)
>  		return;
>  
> -	prev = master->slaves;
> +	prev = READ_ONCE(master->slaves);
>  	if (prev) {
> +		struct Qdisc *head = prev;
> +
>  		do {
>  			q = NEXT_SLAVE(prev);
>  			if (q == sch) {
>  				NEXT_SLAVE(prev) = NEXT_SLAVE(q);
> -				if (q == master->slaves) {
> -					master->slaves = NEXT_SLAVE(q);
> -					if (q == master->slaves) {
> +				if (q == head) {

Could changing this condition introduce a use-after-free if master->slaves
is concurrently advanced?

If the datapath (teql_master_xmit() or teql_dequeue()) advances
master->slaves to point to sch after head was snapshot, head will not
equal sch.

When teql_destroy() unlinks sch, the q == head check would evaluate
to false, meaning master->slaves is not updated. This would leave
master->slaves pointing to the unlinked sch, which will then be freed.

> +					WRITE_ONCE(master->slaves,
> +						   NEXT_SLAVE(q));
[ ... ]
> @@ -317,7 +321,7 @@ static netdev_tx_t teql_master_xmit(struct sk_buff *skb, struct net_device *dev)
>  				    netdev_start_xmit(skb, slave, slave_txq, false) ==
>  				    NETDEV_TX_OK) {
>  					__netif_tx_unlock(slave_txq);
> -					master->slaves = NEXT_SLAVE(q);
> +					WRITE_ONCE(master->slaves, NEXT_SLAVE(q));

Similarly to teql_dequeue() above, does this risk publishing a dying qdisc
globally?

If NEXT_SLAVE(q) is read before teql_destroy() unlinks it, but the
WRITE_ONCE() executes immediately after the unlink, it appears the
unlinked qdisc would be written to the global master->slaves pointer.

[ ... ]

While looking at the concurrency issues addressed by this patch, it appears
teql_qdisc_init() might also be affected by concurrent updates to
m->slaves:

net/sched/sch_teql.c:teql_qdisc_init() {
    ...
		q->next = NEXT_SLAVE(m->slaves);
		NEXT_SLAVE(m->slaves) = sch;
    ...
}

Because NEXT_SLAVE(m->slaves) evaluates m->slaves twice, if m->slaves
is concurrently advanced between these two statements, could this break
the list linkage and cause lost elements or infinite loops?

