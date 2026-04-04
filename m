Return-Path: <netdev+bounces-275297-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CMZzNhBW0GkA6gYAu9opvQ
	(envelope-from <netdev+bounces-275297-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:06:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D5B399327
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 02:06:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8B968305E9BB
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 00:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 802E11DA23;
	Sat,  4 Apr 2026 00:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isL26sF9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D38520ED
	for <netdev@vger.kernel.org>; Sat,  4 Apr 2026 00:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775261164; cv=none; b=J5cTb3MfccZkvOgF3gxT423iBak7L5v4rj/ojQaeKyS8BDM5V7TRCVB14x2De9KOY+vMNhp7UKwZ4r4rgcCv8pE+n/MfbzSrsIQgL99nbw4KGmYjdRCemSfsNiFi+zJKpzcWI1G6CK/1XtljeqhdHB4RqwZiJbA9e00uS6jPBtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775261164; c=relaxed/simple;
	bh=ckrsAK1DKZFms8X7f4mWEjqzrmnC7nSSDHp/8YcQ1OM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g91ekzCea0SWVm0VvjafcxEBSFVGg0+tpa5gxUueY93KdIagRDljj++3ud7EJt9FNW6/0z2C3CXPlOpRJIsuWWb6/X0TuooO7GF8PYZ1yfSfWxjsizrlL2C8xRhnHqvJhwwOVYQjjKEI8XiS6BvXX1r9ARntMcp17AbR0Z6YvrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isL26sF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF776C2BCAF;
	Sat,  4 Apr 2026 00:06:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775261164;
	bh=ckrsAK1DKZFms8X7f4mWEjqzrmnC7nSSDHp/8YcQ1OM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=isL26sF91N4g5LFg+JB4l8ynnK+FKZlw++4YLp7sPZ2SV53eWJZqXn342POpshzsQ
	 sbdt9WH76Ei8nfTmWrIRWfo94/IZJkF1DcE3CWVhhuImvvC/NIQ5Eze4iI9ugFaJq0
	 sw5vWm+kLkO6Ni+57hIMb2ohEeWuzvxRHJP1sJmIqNnuGXfTxljR44tzSgTjUIzGMq
	 tv1MfKnWJpIK8LJMMTVvLdUxV1IGrPxWO1PA5A6aCTtl7rw/AeKlZsoUYVxsOJowT/
	 lxvpbrME2bLYSgjfIk+VPbjihm/mwSEuxx9wOsLjjm9VHUf9u6r2r7G5HF0hvuEokf
	 6mrUImyZY/KXw==
From: Jakub Kicinski <kuba@kernel.org>
To: sdf@fomichev.me
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	jiri@resnulli.us,
	jv@jvosburgh.net
Subject: Re: [PATCH net-next v5 01/14] net: add address list snapshot and reconciliation infrastructure
Date: Fri,  3 Apr 2026 17:06:02 -0700
Message-ID: <20260404000602.2413848-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-2-sdf@fomichev.me>
References: <20260402225535.4124525-2-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275297-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63D5B399327
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
    net: add address list snapshot and reconciliation infrastructure

This commit introduces address list snapshot and reconciliation routines
to support the async rx_mode path. It provides functions to snapshot the
lists, and to reconcile the hardware sync state back to the original lists
after driver processing.

> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> --- a/net/core/dev_addr_lists.c
> +++ b/net/core/dev_addr_lists.c
[ ... ]
> @@ -501,6 +503,114 @@ void __hw_addr_init(struct netdev_hw_addr_list *list)
[ ... ]
> +void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
> +			      struct netdev_hw_addr_list *work,
> +			      struct netdev_hw_addr_list *ref, int addr_len)
> +{
[ ... ]
> +		real_ha = __hw_addr_lookup(real_list, ref_ha->addr, addr_len,
> +					   ref_ha->type);
> +		if (!real_ha) {
> +			/* The real entry was concurrently removed. If the
> +			 * driver synced this addr to hardware (delta > 0),
> +			 * re-insert it as a stale entry so the next work
> +			 * run unsyncs it from hardware.
> +			 */
> +			if (delta > 0) {
> +				real_ha = __hw_addr_create(ref_ha->addr,
> +							   addr_len,
> +							   ref_ha->type, false,
> +							   false);

Does this code silently leak a hardware MAC filter if the GFP_ATOMIC allocation
fails? If the software loses track of this address, it appears future sync runs
will never unsync it from the hardware.

Could this failure be avoided by unlinking ref_ha from the ref list (which is
about to be unconditionally freed via __hw_addr_flush) and moving it directly
into real_list?

> +				if (real_ha) {
> +					real_ha->sync_cnt = 1;
> +					real_ha->refcount = 1;

Does this code break compatibility with reference-counted sync APIs?

While __hw_addr_sync_dev() increments by 1, drivers processing snapshots with
__hw_addr_ref_sync_dev() might increment sync_cnt by the total number of
references. If such an entry is concurrently removed, recreation with a
hardcoded value of 1 could instruct the next async run to unsync only 1
reference, permanently leaking the remaining hardware references.

Should these be dynamically initialized to real_ha->sync_cnt = delta and
real_ha->refcount = delta?

> +					list_add_tail_rcu(&real_ha->list,
> +							  &real_list->list);
> +					__hw_addr_insert(real_list, real_ha,
> +							 addr_len);
> +					real_list->count++;
> +				}
> +			}
> +			continue;
> +		}
[ ... ]
> diff --git a/net/core/dev_addr_lists_test.c b/net/core/dev_addr_lists_test.c
> --- a/net/core/dev_addr_lists_test.c
> +++ b/net/core/dev_addr_lists_test.c
[ ... ]
> @@ -225,6 +245,339 @@ static void dev_addr_test_add_excl(struct kunit *test)
[ ... ]
> +static void dev_addr_test_snapshot_sync(struct kunit *test)
> +{
[ ... ]
> +	netif_addr_lock_bh(netdev);
> +	__hw_addr_init(&snap);
> +	__hw_addr_init(&ref);
> +	KUNIT_ASSERT_EQ(test, 0,
> +			__hw_addr_list_snapshot(&snap, &netdev->uc, ETH_ALEN));
> +	KUNIT_ASSERT_EQ(test, 0,
> +			__hw_addr_list_snapshot(&ref, &netdev->uc, ETH_ALEN));
> +	netif_addr_unlock_bh(netdev);

Will this cause a system deadlock if the assertion fails?

If KUNIT_ASSERT_EQ triggers (e.g. from an out-of-memory condition in
__hw_addr_list_snapshot), it immediately aborts the test case thread and skips
the rest of the function, leaving the netif_addr_lock_bh spinlock permanently
held and bottom-halves disabled.

Could this be replaced with KUNIT_EXPECT_EQ and explicit goto error handling
to ensure netif_addr_unlock_bh is always reached?

[ ... ]
> +static void dev_addr_test_snapshot_benchmark(struct kunit *test)
> +{
[ ... ]
> +	for (iter = 0; iter < 1000; iter++) {
> +		netif_addr_lock_bh(netdev);
> +		__hw_addr_init(&snap);
> +
> +		start = ktime_get();
> +		KUNIT_ASSERT_EQ(test, 0,
> +				__hw_addr_list_snapshot(&snap, &netdev->uc,
> +							ETH_ALEN));
> +		duration += ktime_to_ns(ktime_sub(ktime_get(), start));
> +
> +		netif_addr_unlock_bh(netdev);

Will this also cause a deadlock if the assertion fails while the lock is held?
-- 
pw-bot: cr

