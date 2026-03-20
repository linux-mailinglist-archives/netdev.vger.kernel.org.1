Return-Path: <netdev+bounces-269752-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SNw3Id+kvGk/1wIAu9opvQ
	(envelope-from <netdev+bounces-269752-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:37:35 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6032D4D20
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 02:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 546D7300E153
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 01:37:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C84B72F1FDB;
	Fri, 20 Mar 2026 01:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CJjXBaqr"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FED13064A3
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 01:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773970651; cv=none; b=cCUtVlNv/7VowtR4yeCDXt11M2JRqXWaPV6paPu8WcUrXSR+oGdAbhx3mDi6L33XlsfKZKonSXGE4I/EuP9S9hK7MbfcqkSrJSR+UY0qPey/WVcWcnFLFjC1LRGLKPKe6CU4DVcsmayF33kNtMJuh+1gwFjBlnfwOI/WYyq1URA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773970651; c=relaxed/simple;
	bh=EoCZ9KJ7wBgw2ksSqUtaAQWzBiqn2VSpwV1z2sYzg9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UsINShhOQyKCe/xzCE8n1IugPJH6nw1iDMk5ExpSuG8ymIyYcasSCamATBsNmZ9k0ZwM9NpaYMrKCD9egyWg7AwUuyshKbjCyadfwTjnLsX9ToAQd7jJrvech24IrbaveUjiQQV56Cflh7lXAdpkM8biBe6vZhJ8y0zggbkv0oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CJjXBaqr; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <27a6be7f-8263-41ef-a9b6-3925ee59061c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1773970642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qr0RUgWyw3ghsBST+ueMci8O6MjfEO3bO5SKKAn2NBQ=;
	b=CJjXBaqrVJWbLc+STpmvdUbhoV2INxxo6uIaUBPbr1NjKVc3bw1k2zHsYQpoZT7z6cucSk
	cZBim/gTyipm3FstUqkFcZ3TwE0DP1rnCJcQyc4og7uC5LqC2QpuOeTWw3nMfz/Rbkj6Vg
	th5vkrxldeiOLEYa5YN5i72prB9hmKY=
Date: Thu, 19 Mar 2026 18:37:17 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] bpf: use RCU-safe iteration in dev_map_redirect_multi()
 SKB path
To: David Carlier <devnexen@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
References: <20260318162420.7684-1-devnexen@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260318162420.7684-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269752-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: 8C6032D4D20
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/18/26 9:24 AM, David Carlier wrote:
> The DEVMAP_HASH branch in dev_map_redirect_multi() uses
> hlist_for_each_entry_safe() to iterate hash buckets, but this function
> runs under RCU protection (called from xdp_do_generic_redirect_map()
> in softirq context). Concurrent writers (__dev_map_hash_update_elem,
> dev_map_hash_delete_elem) modify the list using RCU primitives
> (hlist_add_head_rcu, hlist_del_rcu).
> 
> hlist_for_each_entry_safe() performs plain pointer dereferences without
> rcu_dereference(), missing the acquire barrier needed to pair with
> writers' rcu_assign_pointer(). On weakly-ordered architectures (ARM64,
> POWER), a reader can observe a partially-constructed node. It also
> defeats CONFIG_PROVE_RCU lockdep validation and KCSAN data-race
> detection.
> 
> Replace with hlist_for_each_entry_rcu(), matching the XDP-frame path
> (dev_map_enqueue_multi) which already uses the correct macro for the
> same hash iteration.

> 
> Fixes: e624d4ed4aa8 ("xdp: Extend xdp_redirect_map with broadcast support")
> Signed-off-by: David Carlier <devnexen@gmail.com>
> ---
>   kernel/bpf/devmap.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
> index 3d619d01088e..c8d256405c29 100644
> --- a/kernel/bpf/devmap.c
> +++ b/kernel/bpf/devmap.c
> @@ -747,7 +747,6 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
>   	struct bpf_dtab_netdev *dst, *last_dst = NULL;
>   	int excluded_devices[1+MAX_NEST_DEV];
>   	struct hlist_head *head;
> -	struct hlist_node *next;
>   	int num_excluded = 0;
>   	unsigned int i;
>   	int err;
> @@ -787,7 +786,7 @@ int dev_map_redirect_multi(struct net_device *dev, struct sk_buff *skb,
>   	} else { /* BPF_MAP_TYPE_DEVMAP_HASH */
>   		for (i = 0; i < dtab->n_buckets; i++) {
>   			head = dev_map_index_hash(dtab, i);
> -			hlist_for_each_entry_safe(dst, next, head, index_hlist) {
> +			hlist_for_each_entry_rcu(dst, head, index_hlist, lockdep_is_held(&dtab->index_lock)) {he 

Where is the dtab->index_lock acquired? dev_map_enqueue_multi() has been 
incorrect also. Take a look at the rcu_read_lock_bh_held() usage in the 
rcu_dereference_check() a few lines above.

pw-bot: cr

Please cc the bpf list and tag the target tree in the subject. imo, 
bpf-next instead of bpf should be fine for this.

>   				if (is_ifindex_excluded(excluded_devices, num_excluded,
>   							dst->dev->ifindex))
>   					continue;


