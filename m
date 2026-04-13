Return-Path: <netdev+bounces-277988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNH+GNyr3GlfVAkAu9opvQ
	(envelope-from <netdev+bounces-277988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:39:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD3283E9376
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 10:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EF01D300D600
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 08:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0473AC0C4;
	Mon, 13 Apr 2026 08:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YE+zqFCW";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="i0Dzc2IU"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA8538237B
	for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 08:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069586; cv=none; b=BvUEpUIVv1cAkNe+/QE+My4HI45XpyKEI9c9Znnj/66qbUU0jbjJW0OGl/Fbj12Z+rRkLiNNParLUK7/E9g2fYn6DyLoBM1tUAFfakZCFzDFo7MJFVUV8Wb2jsrNNR6oWyNeXqUdJowzCnKR6yawzrs/Y1mDR9dzUvAcoWfvvi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069586; c=relaxed/simple;
	bh=lX8tpz892x1p4COZR1xJ1CEV7Rdo5MlbLLEYQ6aVYX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Pzhq2Wgm+q2gEYAZGhz7B6sFrs0WIKq1jKvduouzu/yemNJQwYZU42ffDd4uHVz2NfStOsLWhchTpRRz9HmbphQNZh92wAT1TBNomg/155GjBLg4Vwlbyo0SU2HN6U0qh1A3lMBWpYNbqIR+fW0InGXaFOWdkcY6P7o0WLVLwdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YE+zqFCW; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=i0Dzc2IU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776069583;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJ3lU+qTcG249TYAmjBTBr5qd/0XDas2IeO/PyiQNFw=;
	b=YE+zqFCWr6J1gVHTP7ZkXwhplSk4ivgemrUM1+/pxc77JGtwa3qZfAISZNNW0T297x1Nn7
	twNxUmz5yfN25mmeJ9c5SFmKDX8yzvVKUHrb5exA7s73FOQfXqPa0Xy3Pn/hokRcaOGU0k
	L0Ki9krQRUmZsk3J5Z1nBla720F2ZuU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-AylGAKguN827ZAyrlCu2dw-1; Mon, 13 Apr 2026 04:39:41 -0400
X-MC-Unique: AylGAKguN827ZAyrlCu2dw-1
X-Mimecast-MFC-AGG-ID: AylGAKguN827ZAyrlCu2dw_1776069580
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488e12db7e0so11785785e9.3
        for <netdev@vger.kernel.org>; Mon, 13 Apr 2026 01:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776069580; x=1776674380; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IJ3lU+qTcG249TYAmjBTBr5qd/0XDas2IeO/PyiQNFw=;
        b=i0Dzc2IU3DsOqQsrSaWdayqwzxAaQ94KxtDph5tuMDtBevrZ8IYQ3m3Tbqp73brEAK
         rGO2LwR9ujvJmJe/arLSgJyKTRqEKXCh8oahAGbG3AmXxW1nwFeuR8yLrgOARrvRQ+J2
         nKDRkMFRMPcmtol/Pkpv9qMoNenVwOv87Q/61bEgTYpjbFe62OLxe8Oa2UdLavnvt4oQ
         P6Y3S+W0RadVgpNc3p3n9VrJcw7NobkLKy2uv59rt7lmoE0A5CA7u4NikTvl4SZPvT3m
         j1s2Bx+ee9z+FMys7ZLIe50jxBURdaGpzMnR1NCzOmk9gkiMEWcsmhUx8axAr21YihwD
         6pGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776069580; x=1776674380;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IJ3lU+qTcG249TYAmjBTBr5qd/0XDas2IeO/PyiQNFw=;
        b=STk1oaE7wkyG6MidsbAO2MW2N0iCXWMlVUFUohFus1Y8jrjQjVqcashoxie4dbuCHn
         KaBkr1fHzALoHqwIW5dGpkaIfLLTa3t/hCZvMD1rWQyr/Pco5PXFs/q1rpPIfpHLajGE
         iKpuJyqzSNl0SU3v/dfH73zbRttM5AdtoTyM1KAYPMVo4ZeXZAFWazjLOod+OZ4zt1rH
         L1LdmKphdqMpQ/McPz7jDhWxADwLGJIrg8ZpvrirA/vJe0A+ARhsbfMvKAqtMUMfl6eL
         3x/q3npRBdP2lixf4LjOAapIAa+Ea7cuMJlRLP3uvgBHcW0rgOVPz3Y8JXX5gU5/BzPy
         KXPw==
X-Forwarded-Encrypted: i=1; AFNElJ9w7rkY80TQF0+y18tYWIIbOvaob7UTP0jpQAIH7739CWmbviFCwRsFnogYGnzQ1Vyb3JR+DII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxIO/A3C480e66az4OrOaanlxawawohKcvfiBm6jTwEvc3Bvj7
	5zY5HMhsE6VWuXW2miz6rQ3/uNISIDdVkof+TVi4d+T/6dwqBdiQrMODioP+n/ga9lKImmuAORF
	6KqRo1DrFTmnfroVx+PQNLEuIYcjbLWhzDWJ66IyIFXCLm+W+5eWIA4b3FQ==
X-Gm-Gg: AeBDietnUE9ot1+P/ij2iuEHxBcWaJ+0xBWgVEuOUGizc53omqQh/VcGuTTMvNAAy45
	VW2AlJS8/n4oOXlDVONgSGSa9hFYpbLmNlkSKbd9uYJWPAXl3rafPIs8lfYI1mi6V2gfGKQ86tc
	MANaICE5PcXxhYizOo74MBH2hSzjqvw0Ap4kIiNChJdWRJn+odYjn1UfW2hih68MZq331M/fEdN
	F+c0fIJv1pqm+50MUBOo6NeQQhmGQYp9CdjK9Dl0mgkZ5ns9ewVfF495KQssQovFX8GJTAcUmar
	lrMfkjfrPh8jVSHvLusIelhDbULDiC9JEuf6CDRNXQl2EwdhX3D6d6etkXAF3wed2PYvJszssPu
	/s2sjwwuFDz2dpxc2QK4WfeOcqBE5nmknHf3F//S712YVpGPBDsrkzO41
X-Received: by 2002:a05:600c:45ce:b0:485:3e19:9e01 with SMTP id 5b1f17b1804b1-488d6890c9dmr175707155e9.28.1776069580271;
        Mon, 13 Apr 2026 01:39:40 -0700 (PDT)
X-Received: by 2002:a05:600c:45ce:b0:485:3e19:9e01 with SMTP id 5b1f17b1804b1-488d6890c9dmr175706645e9.28.1776069579768;
        Mon, 13 Apr 2026 01:39:39 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.125])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d6898445sm93492755e9.36.2026.04.13.01.39.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Apr 2026 01:39:38 -0700 (PDT)
Message-ID: <b4534229-994a-42ac-a200-a9cb1b333e60@redhat.com>
Date: Mon, 13 Apr 2026 10:39:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: openvswitch: decouple flow_table from
 ovs_mutex
To: Adrian Moreno <amorenoz@redhat.com>, netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, "open list:OPENVSWITCH"
 <dev@openvswitch.org>, open list <linux-kernel@vger.kernel.org>
References: <20260407120418.356718-1-amorenoz@redhat.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20260407120418.356718-1-amorenoz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277988-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CD3283E9376
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 2:04 PM, Adrian Moreno wrote:
> Currently the entire ovs module is write-protected using the global
> ovs_mutex. While this simple approach works fine for control-plane
> operations (such as vport configurations), requiring the global mutex
> for flow modifications can be problematic.
> 
> During periods of high control-plane operations, e.g: netdevs (vports)
> coming and going, RTNL can suffer contention. This contention is easily
> transferred to the ovs_mutex as RTNL nests inside ovs_mutex. Flow
> modifications, however, are done as part of packet processing and having
> them wait for RTNL pressure to go away can lead to packet drops.
> 
> This patch decouples flow_table modifications from ovs_mutex by means of
> the following:
> 
> 1 - Make flow_table an rcu-protected pointer inside the datapath.
> This allows both objects to be protected independently while reducing the
> amount of changes required in "flow_table.c".
> 
> 2 - Create a new mutex inside the flow_table that protects it from
> concurrent modifications.
> Putting the mutex inside flow_table makes it easier to consume for
> functions inside flow_table.c that do not currently take pointers to the
> datapath.
> Some function signatures need to be changed to accept flow_table so that
> lockdep checks can be performed.
> 
> 3 - Create a reference count to temporarily extend rcu protection from
> the datapath to the flow_table.
> In order to use the flow_table without locking ovs_mutex, the flow_table
> pointer must be first dereferenced within an rcu-protected region.
> Next, the table->mutex needs to be locked to protect it from
> concurrent writes but mutexes must not be locked inside an rcu-protected
> region, so the rcu-protected region must be left at which point the
> datapath can be concurrently freed.
> To extend the protection beyond the rcu region, a reference count is used.
> One reference is held by the datapath, the other is temporarily
> increased during flow modifications. For example:
> 
> Datapath deletion:
> 
>   ovs_lock();
>   table = rcu_dereference_protected(dp->table, ...);
>   rcu_assign_pointer(dp->table, NULL);
>   ovs_flow_tbl_put(table);
>   ovs_unlock();
> 
> Flow modification:
> 
>   rcu_read_lock();
>   dp = get_dp(...);
>   table = rcu_dereference(dp->table);
>   ovs_flow_tbl_get(table);
>   rcu_read_unlock();
> 
>   mutex_lock(&table->lock);
>   /* Perform modifications on the flow_table */
>   mutex_unlock(&table->lock);
>   ovs_flow_tbl_put(table);
> 
> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
> ---
> v2: Fix argument in ovs_flow_tbl_put (sparse)
>     Remove rcu checks in ovs_dp_masks_rebalance
> ---
>  net/openvswitch/datapath.c   | 285 ++++++++++++++++++++++++-----------
>  net/openvswitch/datapath.h   |   2 +-
>  net/openvswitch/flow.c       |  13 +-
>  net/openvswitch/flow.h       |   9 +-
>  net/openvswitch/flow_table.c | 180 ++++++++++++++--------
>  net/openvswitch/flow_table.h |  51 ++++++-
>  6 files changed, 380 insertions(+), 160 deletions(-)

This is too big for a single patch. The changelog above already suggests
a way of splitting the change. At least the RCU-ification addition
should be straight forward in a separate patch, which in turn should be
easily reviewable.

> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index e209099218b4..9c234993520c 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -88,13 +88,17 @@ static void ovs_notify(struct genl_family *family,
>   * DOC: Locking:
>   *
>   * All writes e.g. Writes to device state (add/remove datapath, port, set
> - * operations on vports, etc.), Writes to other state (flow table
> - * modifications, set miscellaneous datapath parameters, etc.) are protected
> - * by ovs_lock.
> + * operations on vports, etc.) and writes to other datapath parameters
> + * are protected by ovs_lock.
> + *
> + * Writes to the flow table are NOT protected by ovs_lock. Instead, a per-table
> + * mutex and reference count are used (see comment above "struct flow_table"
> + * definition). On some few occasions, the per-flow table mutex is nested
> + * inside ovs_mutex.
>   *
>   * Reads are protected by RCU.
>   *
> - * There are a few special cases (mostly stats) that have their own
> + * There are a few other special cases (mostly stats) that have their own
>   * synchronization but they nest under all of above and don't interact with
>   * each other.
>   *
> @@ -166,7 +170,6 @@ static void destroy_dp_rcu(struct rcu_head *rcu)
>  {
>  	struct datapath *dp = container_of(rcu, struct datapath, rcu);
>  
> -	ovs_flow_tbl_destroy(&dp->table);
>  	free_percpu(dp->stats_percpu);
>  	kfree(dp->ports);
>  	ovs_meters_exit(dp);
> @@ -247,6 +250,7 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
>  	struct ovs_pcpu_storage *ovs_pcpu = this_cpu_ptr(ovs_pcpu_storage);
>  	const struct vport *p = OVS_CB(skb)->input_vport;
>  	struct datapath *dp = p->dp;
> +	struct flow_table *table;
>  	struct sw_flow *flow;
>  	struct sw_flow_actions *sf_acts;
>  	struct dp_stats_percpu *stats;
> @@ -257,9 +261,16 @@ void ovs_dp_process_packet(struct sk_buff *skb, struct sw_flow_key *key)
>  	int error;
>  
>  	stats = this_cpu_ptr(dp->stats_percpu);
> +	table = rcu_dereference(dp->table);
> +	if (!table) {
> +		net_dbg_ratelimited("ovs: no flow table on datapath %s\n",
> +				    ovs_dp_name(dp));
> +		kfree_skb(skb);
> +		return;
> +	}
>  
>  	/* Look up flow. */
> -	flow = ovs_flow_tbl_lookup_stats(&dp->table, key, skb_get_hash(skb),
> +	flow = ovs_flow_tbl_lookup_stats(table, key, skb_get_hash(skb),
>  					 &n_mask_hit, &n_cache_hit);
>  	if (unlikely(!flow)) {
>  		struct dp_upcall_info upcall;
> @@ -752,12 +763,16 @@ static struct genl_family dp_packet_genl_family __ro_after_init = {
>  static void get_dp_stats(const struct datapath *dp, struct ovs_dp_stats *stats,
>  			 struct ovs_dp_megaflow_stats *mega_stats)
>  {
> +	struct flow_table *table = ovsl_dereference(dp->table);

Should be rcu_dereference_ovs_tbl() ?

>  	int i;
>  
>  	memset(mega_stats, 0, sizeof(*mega_stats));
>  
> -	stats->n_flows = ovs_flow_tbl_count(&dp->table);
> -	mega_stats->n_masks = ovs_flow_tbl_num_masks(&dp->table);
> +	if (table) {
> +		stats->n_flows = ovs_flow_tbl_count(table);

As noted by Aaron, READ_ONCE() is now needed when accessing
table->count. And WRITE_ONCE when writing it

> +		mega_stats->n_masks = ovs_flow_tbl_num_masks(table);

Sashiko says:

---
get_dp_stats() accesses table->mask_array via ovs_flow_tbl_num_masks()
while holding only ovs_mutex. Since this patch decouples flow table updates
by moving them under table->lock, ovs_flow_cmd_new() can execute
concurrently and trigger a reallocation of the mask array, freeing the old
one via call_rcu().
Because get_dp_stats() does not hold rcu_read_lock(), the thread can be
preempted (as ovs_mutex is sleepable) and the RCU grace period might expire
before the count is read. Can this lead to a use-after-free?
---

Note that it also spotted pre-existing issues, please have a look:

https://sashiko.dev/#/patchset/20260407120418.356718-1-amorenoz%40redhat.com

[...]
> @@ -71,15 +93,40 @@ struct flow_table {
>  
>  extern struct kmem_cache *flow_stats_cache;
>  
> +#ifdef CONFIG_LOCKDEP
> +int lockdep_ovs_tbl_is_held(const struct flow_table *table);
> +#else
> +static inline int lockdep_ovs_tbl_is_held(const struct flow_table *table)
> +{
> +	(void)table;

You can use the __always_unused annotation.

> +	return 1;
> +}
> +#endif
> +
> +#define ASSERT_OVS_TBL(tbl)   WARN_ON(!lockdep_ovs_tbl_is_held(tbl))
> +
> +/* Lock-protected update-allowed dereferences.*/
> +#define ovs_tbl_dereference(p, tbl)	\
> +	rcu_dereference_protected(p, lockdep_ovs_tbl_is_held(tbl))
> +
> +/* Read dereferences can be protected by either RCU, table lock or ovs_mutex. */

Is this access schema really safe? I understand tables can be
written/deleted under the table lock only. If so this should ignore the
OVS mutex status.

/P


