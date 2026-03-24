Return-Path: <netdev+bounces-271334-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6C77ECMYw2lCoAQAu9opvQ
	(envelope-from <netdev+bounces-271334-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 00:02:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A7EFE31D9B0
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 00:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0217D305749A
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 23:00:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 827F73C5556;
	Tue, 24 Mar 2026 23:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="n+b0hoez"
X-Original-To: netdev@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44A3B2FD2
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 23:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774393227; cv=none; b=N2LmXme+bKPvpJfy64bBO1BWoMZkCaW9vWv//zjTqY/jrWYAYJ277OU3rUuMqHCaD5W3jSaBOPqa9Kmfg+o2lEM+MiD61Hj4CoXmw/B9o6QpzXWhfFXNAOu9yAUTGY5CCmH6dGm2x/KLwopm3/Ue39B2byZy+olOpZk2vH4wObU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774393227; c=relaxed/simple;
	bh=ZII/JGv2JjScCl9hJl3KdXLIxT4b4XoFTIdkQY9QhHY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i9uREpSjFwkWVYeIQziOvaqsxLa11gTOxBySdr8BNBpl40mjYlwYQPIhiqSx7h1YvJC6/fOMTSH7kgwr79XWS8ZXkSwLNF2VgOtLF21gHJQO2Y9nmqXVQEawAikIT+DVSdoaV5kZOYrNbnMVTxTd02rEVDb6bEmd3pBk5oZtE74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=n+b0hoez; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9985d6b0-d305-429f-9dac-a9a40085c843@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774393214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yS7mAUT0O+x7+anV6xI5QCP97XBxbKBlhkikiOxivJ0=;
	b=n+b0hoezYv2rwIGMiIByhGtpboWz/dRKPiEoaPZehcvaH555U1zrZ98nmBJMPnVNu7MlJd
	a6K/Js/3MHBsoEbwtKaMuBQP7t8wigeDp6QfXYUeqTsTsx1TlowCI3cyJW5o0SZprSxGoY
	GBcypAGMgsrS6K/AAlJhNoET1eaQuBs=
Date: Tue, 24 Mar 2026 16:00:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: use RCU-safe iteration in
 dev_map_redirect_multi() SKB path
To: David Carlier <devnexen@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, davem@davemloft.net,
 Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
 bpf <bpf@vger.kernel.org>
References: <20260320072645.16731-1-devnexen@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20260320072645.16731-1-devnexen@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271334-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: A7EFE31D9B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 3/20/26 12:26 AM, David Carlier wrote:
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
> Replace with hlist_for_each_entry_rcu() using rcu_read_lock_bh_held()
> as the lockdep condition, consistent with the rcu_dereference_check()
> used in the DEVMAP (non-hash) branch of the same functions. Also fix
> the same incorrect lockdep_is_held(&dtab->index_lock) condition in
> dev_map_enqueue_multi(), where the lock is not held either.

Applied. Thanks.

Take a look at the review here:
https://sashiko.dev/#/patchset/20260320072645.16731-1-devnexen%40gmail.com

The first comment is legit and please followup. The second comment looks 
unrelated.



