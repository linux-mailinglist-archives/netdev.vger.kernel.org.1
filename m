Return-Path: <netdev+bounces-292834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHd1CMedGGpAlggAu9opvQ
	(envelope-from <netdev+bounces-292834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:55:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 30CD85F7745
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 21:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 72E483050CA7
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 19:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E8BE32BF5A;
	Thu, 28 May 2026 19:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nbrqQtiN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19A6534040F
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 19:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998085; cv=none; b=HPLUEmspomCBc7E/wSwVGexuxmsaOnLqIXGeQDCfsb+Og6eKavsAKHrosg4aLfEFbyV+byEV5VzAyjVTy2mji4SxCtf9xQ1t9bHg5WXb69mELgFI55S6gaLRg8Nl4pRYasTDNJ8Hztj0F7A0L1C7JC97RbEihJOwOSjj/UsR368=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998085; c=relaxed/simple;
	bh=WC0d021mnuw5XL6Z5w0j6CYJt9tKOIXjpeT5Am1QL20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKrAZJvVx3HdLcIlMbcer5mtj6Ed8V2dAVv48U96YiCX7ZjIRnUQNTPPfemxua4bzecubMWM9//8DO5651MYJkJVjXRN+bk/PIqVL4tKVRDUzBEPMB/Ih/tpDxIan/RmhNqUNdR59SJZZAta1G6xe1TjH3qyCc3YjQQ7naZF7Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nbrqQtiN; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05D391F00A3A;
	Thu, 28 May 2026 19:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779998084;
	bh=/Te4KWhwxzWlxLU4A1oQPhBmcv0w9HTk8woGej3jEsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nbrqQtiNbM+MmCIKJZOGRiTcefHQ1bD7CroBOtTBmSWGXky96ZPFA0EJ+dDyginvt
	 gGG6WWWnCVchan62pN+dACz1pipsMB+SVqERWL9RavXt0xHbDYNtQieWr75v3NSLxZ
	 7D8+n+F/XNH//+iS2B7IxDxTV8Ovb6T59m2wzFzmQO9meU0VLQoYoI3YA3Zu5I/5Ac
	 zDchbRlgUuUCYQf6w7bvdY70Nsn5klU0wujPb20dGHIoL3UAQMC8l4GeGxbZCRTcrK
	 bmAHIdRM0HckGYB/iIaFwekVJuYr7k+5QWIjvg0owauFa71eXz8WN5AWk3k6IWrMCa
	 Dr2lIh2DzFKSg==
From: Simon Horman <horms@kernel.org>
To: kipreyyy@gmail.com
Cc: 'Simon Horman' <horms@kernel.org>,
	ap420073@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net] amt: fix use-after-free in amt_source_work
Date: Thu, 28 May 2026 20:51:47 +0100
Message-ID: <20260528195149.2718758-2-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526102559.31926-1-kipreyyy@gmail.com>
References: <20260526102559.31926-1-kipreyyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292834-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: 30CD85F7745
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: 'Simon Horman' <horms@kernel.org>

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
amt: fix use-after-free in amt_source_work

This patch tries to fix a UAF in amt_source_work() by moving
rcu_read_lock() before the gnode dereferences and adding an
amt_lookup_src() check after taking tunnel->lock to verify the source
node is still present.

> diff --git a/drivers/net/amt.c b/drivers/net/amt.c
> index f2f3139e38a5..f70d49cca285 100644
> --- a/drivers/net/amt.c
> +++ b/drivers/net/amt.c
> @@ -291,13 +291,18 @@ static void amt_source_work(struct work_struct *work)
>  	struct amt_source_node *snode = container_of(to_delayed_work(work),
>  						     struct amt_source_node,
>  						     source_timer);
> -	struct amt_group_node *gnode = snode->gnode;
> -	struct amt_dev *amt = gnode->amt;
> +	struct amt_group_node *gnode;
> +	struct amt_dev *amt;
>  	struct amt_tunnel_list *tunnel;
>  
> +	rcu_read_lock();
> +	gnode = snode->gnode;
> +	amt = gnode->amt;

[High]
Is snode itself guaranteed to still be allocated by the time
rcu_read_lock() runs here?

amt_destroy_source() calls cancel_delayed_work() (not the _sync()
variant) and then hands snode off to source_gc_list, where
__amt_source_gc_work() eventually does kfree_rcu(snode):

drivers/net/amt.c:amt_destroy_source() {
    ...
    cancel_delayed_work(&snode->source_timer);
    hlist_del_init_rcu(&snode->node);
    ...
    spin_lock_bh(&source_gc_lock);
    hlist_add_head_rcu(&snode->node, &source_gc_list);
    spin_unlock_bh(&source_gc_lock);
}

Once process_one_work() has already cleared WORK_STRUCT_PENDING but
not yet entered amt_source_work(), cancel_delayed_work() returns 0
without waiting.  If the worker is preempted at that point and
amt_destroy_source(snode) plus the subsequent gc kfree_rcu(snode) run,
an entire RCU grace period can elapse before the worker reaches
rcu_read_lock().

Wouldn't the subsequent reads of snode->gnode, gnode->amt,
gnode->tunnel_list, and snode->source_addr then be operating on freed
memory?

This window appears to predate this patch, but since the patch's stated
intent is "rcu_read_lock cannot reclaim the memory while the work
handler is accessing it", is it worth noting that an already-dispatched
work is not protected by rcu_read_lock taken inside the work itself?

>  	tunnel = gnode->tunnel_list;
>  	spin_lock_bh(&tunnel->lock);
> -	rcu_read_lock();
> +	if (!amt_lookup_src(tunnel, gnode, AMT_FILTER_ALL,
> +			    &snode->source_addr))
> +		goto unlock;

[Critical]
Does amt_lookup_src() actually verify that the original snode is still
present?  It matches by source_addr, not by snode pointer identity:

    if (memcmp(&snode->source_addr, src, sizeof(union amt_addr)))
        continue;
    return snode;

Consider this sequence after the worker picks up snode_A's timer but
before it acquires tunnel->lock:

  IGMP/MLD report path (under tunnel->lock):
    amt_cleanup_srcs() -> amt_destroy_source(snode_A)
        cancel_delayed_work(&snode_A->source_timer);
        hlist_del_init_rcu(&snode_A->node);
        hlist_add_head_rcu(&snode_A->node, &source_gc_list);
    amt_add_srcs() allocates snode_B with the same source_addr in
    gnode->sources.

  amt_source_work() now acquires tunnel->lock and calls:
    amt_lookup_src(tunnel, gnode, AMT_FILTER_ALL, &snode->source_addr)

Won't this find snode_B and return non-NULL, so the check passes and
the function then proceeds to amt_destroy_source(snode) on the original
snode_A pointer obtained via container_of(work)?

If so, several follow-on problems seem to arise:

amt_destroy_source(snode_A) calls hlist_del_init_rcu(&snode_A->node)
without holding source_gc_lock, while __amt_source_gc_work() serializes
source_gc_list manipulation under that lock — can this corrupt
source_gc_list?

It also performs tunnel->nr_sources-- and gnode->nr_sources-- a second
time, since snode_B's prior insertion incremented them — does this
underflow accounting on still-live state?

If gnode->filter_mode == MCAST_INCLUDE and the bogus decrement reaches
zero, amt_del_group(amt, gnode) runs on a still-populated group,
destroying snode_B and kfree_rcu'ing gnode prematurely — is that
intended?

Would comparing pointer identity instead, e.g.

    if (amt_lookup_src(tunnel, gnode, AMT_FILTER_ALL,
                       &snode->source_addr) != snode)
        goto unlock;

or checking hlist_unhashed(&snode->node) under tunnel->lock, more
faithfully express "this snode is still on gnode's hash"?

>  	if (gnode->filter_mode == MCAST_INCLUDE) {
>  		amt_destroy_source(snode);
>  		if (!gnode->nr_sources)
> @@ -308,8 +313,9 @@ static void amt_source_work(struct work_struct *work)
>  		 */
>  		snode->status = AMT_SOURCE_STATUS_D_FWD;
>  	}
> -	rcu_read_unlock();
> +unlock:
>  	spin_unlock_bh(&tunnel->lock);
> +	rcu_read_unlock();
>  }

