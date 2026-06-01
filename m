Return-Path: <netdev+bounces-293675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAWOMc1gHWojZwkAu9opvQ
	(envelope-from <netdev+bounces-293675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:37:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A3661D9CD
	for <lists+netdev@lfdr.de>; Mon, 01 Jun 2026 12:37:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C32E93303904
	for <lists+netdev@lfdr.de>; Mon,  1 Jun 2026 10:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76E1239023B;
	Mon,  1 Jun 2026 10:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SzsRNcZZ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560A395D8B
	for <netdev@vger.kernel.org>; Mon,  1 Jun 2026 10:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780308710; cv=none; b=dFqvAApPujuP3S/rJzPv1kjWuQEBtcEBjsnNsOXV4nu65mSjfbCiOpXFit2oRCsjGT+5QQ+VZlK9UnbyNbD8UY2Os8soqBvVNCPf0pvLvuBpLwxQxztDE3fGTyTsDl+Er7NDkTYzHhMrWqHmxlRW6fORcL8si5dFSGrNKU5v2Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780308710; c=relaxed/simple;
	bh=20A4jKFUsZEWDr5OgsxLlpo0DE76jxE6xt5gG2U7/lU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vEZoltycjK/glzcaysXAXMPLzESjkMOQB+8MPIv7PJZtiCU9YbvO97+J/C/ijQ6Ikm2LTC+s2sN0OlKDwNdqtmDuIdDkGwoRxEHnhoBrE1oRdpU+JNwOa04cZNubl3jXoJXPwBSsV9+rcVmta2UfM6tXxjgoZSACVi2mjexOde0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SzsRNcZZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780308696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qkve3oWwZFK6KvMeLa6zJtJtTA+c5ODpXQk5K5Y2AUQ=;
	b=SzsRNcZZuPiqThUOnyp/qmKQxHOoPr1GPEmoxNvZQ9s2vDkur8dfTyD2/hUNqHZKKzUO0e
	46Im55+9WqtvFw47ZAUj5gcKOzmkKpydLIjZLc57vB2k37D0juRQGen6iwdBmBJStWLevH
	u9IA4IB21y08d6v4IXoM8uC61iYr0ds=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-riDcqIBHPUiupzHY8basFg-1; Mon,
 01 Jun 2026 06:11:33 -0400
X-MC-Unique: riDcqIBHPUiupzHY8basFg-1
X-Mimecast-MFC-AGG-ID: riDcqIBHPUiupzHY8basFg_1780308692
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0F55C19560A6;
	Mon,  1 Jun 2026 10:11:32 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.44.48.197])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BA1DF1800352;
	Mon,  1 Jun 2026 10:11:30 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: kipreyyy@gmail.com
Cc: ap420073@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] amt: fix use-after-free in amt_group_work
Date: Mon,  1 Jun 2026 12:11:23 +0200
Message-ID: <20260601101123.148258-1-pabeni@redhat.com>
In-Reply-To: <20260526105839.19787-1-kipreyyy@gmail.com>
References: <20260526105839.19787-1-kipreyyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293675-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:url]
X-Rspamd-Queue-Id: 42A3661D9CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: AI Reviewer <ai@example.com>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/
---
amt: fix use-after-free in amt_group_work

This patch wraps the early gnode dereferences in amt_group_work() with
rcu_read_lock() and switches amt_del_group() to hlist_del_init_rcu() so
the worker can detect an already-deleted gnode via hlist_unhashed().
The stated goal is to close a use-after-free window between the
container_of() in the worker and the spin_lock_bh() acquisition.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index f2f3139e38a5..f937957dbd61 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c

[ ... ]

> @@ -412,23 +412,31 @@ static void amt_group_work(struct work_struct *work)
>  	struct amt_group_node *gnode = container_of(to_delayed_work(work),
>  						    struct amt_group_node,
>  						    group_timer);
> -	struct amt_tunnel_list *tunnel = gnode->tunnel_list;
> -	struct amt_dev *amt = gnode->amt;
> +	struct amt_tunnel_list *tunnel;
>  	struct amt_source_node *snode;
>  	bool delete_group = true;
> +	struct amt_dev *amt;
>  	struct hlist_node *t;
>  	int i, buckets;
>  
> +	rcu_read_lock();
> +	tunnel = gnode->tunnel_list;
> +	amt = gnode->amt;

[Medium]
Does this fully close the race the commit message describes?

The worker entry from the workqueue core through container_of() and the
local variable declarations runs before rcu_read_lock() executes.  If
amt_group_work() is preempted in that window (permitted under
PREEMPT_RCU and PREEMPT_RT, since a task that is not currently in a
read-side critical section is a quiescent state for that task), and on
another CPU amt_del_group() runs from amt_clear_groups() and the GP it
was waiting on completes:

- the GP only needs to wait for readers active when call_rcu()/kfree_rcu()
  was invoked, not for the preempted worker
- once the caller of amt_clear_groups() drops its rcu_read_lock(), the
  GP can complete and gnode is freed
- the preempted worker resumes and calls rcu_read_lock() as a new
  reader, which does not retroactively extend the already-completed
  grace period

When the worker resumes, the very first line:

	tunnel = gnode->tunnel_list;

reads from freed memory, and the subsequent hlist_unhashed(&gnode->node)
check operates on a freed hlist_node whose ->pprev may hold any value.

Would cancel_delayed_work_sync() in the destruction path (with care for
the self-cancellation case where amt_group_work() itself calls
amt_del_group()), or taking an explicit reference on gnode at queue
time, be a more robust fix?

>  	buckets = amt->hash_buckets;
>  
>  	spin_lock_bh(&tunnel->lock);
> +	if (hlist_unhashed(&gnode->node)) {
> +		spin_unlock_bh(&tunnel->lock);
> +		rcu_read_unlock();
> +		goto out;
> +	}
>  	if (gnode->filter_mode == MCAST_INCLUDE) {
>  		/* Not Used */
>  		spin_unlock_bh(&tunnel->lock);
> +		rcu_read_unlock();
>  		goto out;
>  	}
>  
> -	rcu_read_lock();
>  	for (i = 0; i < buckets; i++) {
>  		hlist_for_each_entry_safe(snode, t,
>  					  &gnode->sources[i], node) {

[High]
Does the same UAF class still apply to amt_source_work() in the same
file?  It performs the early dereferences before taking either
tunnel->lock or rcu_read_lock():

static void amt_source_work(struct work_struct *work)
{
	struct amt_source_node *snode = container_of(to_delayed_work(work),
						     struct amt_source_node,
						     source_timer);
	struct amt_group_node *gnode = snode->gnode;
	struct amt_dev *amt = gnode->amt;
	struct amt_tunnel_list *tunnel;

	tunnel = gnode->tunnel_list;
	spin_lock_bh(&tunnel->lock);
	rcu_read_lock();
	...
}

The destruction path amt_destroy_source() uses cancel_delayed_work()
(non-sync) and the deferred __amt_source_gc_work() ultimately
kfree_rcu()s snode.  If amt_source_work() is preempted between
container_of() and the spin_lock_bh()/rcu_read_lock(), while a
concurrent destroy of snode runs and completes its grace period, the
snode->gnode and gnode->tunnel_list reads here become use-after-free of
snode (and potentially gnode).

This isn't introduced by this patch, but should the same fix be applied
to amt_source_work() as part of this series, given it is the same bug
class in the same driver?
-- 
This is an AI-generated review.


