Return-Path: <netdev+bounces-289443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBdaBKFXDGodfwUAu9opvQ
	(envelope-from <netdev+bounces-289443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:29:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BDD57EAFB
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:29:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 41ED230943AC
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD951330D29;
	Tue, 19 May 2026 12:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vVeULiwj"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E39313E2B
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 12:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779193363; cv=none; b=Qe2Y5GVixVFwsSSYP6IJEmTkCxId5KrnzpR+vI60H+F+L82srjsVz56GCUCo8p6G7jQBk9YuGKgcJI9T2/wNSL2M19FsMXs8Qy5jGYcSQfKExhqMQ16UO1g/zlm/0JYz1AnYpEbWB8Y4QeHAtDWXuyT+PY4N7GBgLjwjDv1dV4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779193363; c=relaxed/simple;
	bh=aE7HqcTHcnlb/+YNZUr6kc1HayvdOjauZA6jbD+QaBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gd8uBrbClUe+CFhRvRpdt6L0RyHa3y1I6bd7HGwgGJ61pWSFMzG69qeyn9mumZS14fR6/VP+32fgObAo5ag9n0TSA3yLgY4W6qYNLXZiyLI74o3kuyNQdSzQuCfenmSdm9nO1hgPISeONMCIoGpX9kY6QfYE2jDz4RhX7RY4EVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vVeULiwj; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Tue, 19 May 2026 20:22:31 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779193359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AZqfc1hPR9zQBT77bzEHRTrK4ZS6Eiz+ZKNHV1Y5UQI=;
	b=vVeULiwj5/v8VmP25FxN1O9ulK6mXgvF7gbKrNzWhhEc+37Og5XuxWvVC2RQRc6paDnhzV
	L7o0ALy3UJZ1Bj/cdkr4luMjwbbX667zKj+OMn8R8LyGjZ95dCpXxErbP7W7w08S4SLdsF
	TdGRP8GmdjIRxKeZp9UUckpo64q1ruY=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: Zijing yin <yzjaurora@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Qingfang Deng <qingfang.deng@linux.dev>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dev_addr_lists: don't WARN on GFP_ATOMIC
 kmalloc failure in netif_rx_mode_run
Message-ID: <ewjfjqocrhwmdoa6mgz3mibtuepp7c3mr5c6zixz26lzfa3g5r@4qfqvbesfv5n>
References: <20260519095557.3749407-1-yzjaurora@gmail.com>
 <878q9fod8m.fsf@cloudflare.com>
 <d864aff0-d9e9-42c9-87e8-0074dc35e857@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d864aff0-d9e9-42c9-87e8-0074dc35e857@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-289443-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pastebin.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:dkim,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: 66BDD57EAFB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 02:11:53PM +0800, Zijing yin wrote:
> Thank you so much for the feedback! I will address these comments in the 
> next version. This is not found by syzbot by the way.

There has the a syzbot report now:
https://syzkaller.appspot.com/bug?extid=f2421634072a4b47071e

> 
> Hope you have a great day!
> 
> On 19.05.2026 13:22, Jakub Sitnicki wrote:
> > On Tue, May 19, 2026 at 02:55 AM -07, Zijing Yin wrote:
> >> netif_rx_mode_run() fires netdev_WARN() when netif_addr_lists_snapshot()
> >> returns non-zero. The only path to a non-zero return is -ENOMEM from
> >> __hw_addr_create() failing its kmalloc(GFP_ATOMIC) -- syzkaller hits it
> >> via failslab, and it can also be reached under real memory pressure.
> >>
> >> This is the only allocator-failure site in this file that WARNs.
> >> __hw_addr_create() itself, and every other caller of it in this file
> >> (__hw_addr_add_ex(), dev_uc_add_excl(), dev_uc_add(), dev_mc_add(), ...)
> >> just propagate the -ENOMEM silently. GFP_ATOMIC is a may-fail allocator;
> >> callers are required to handle NULL, so a returned -ENOMEM here is an
> >> expected runtime condition, not an invariant violation.
> >>
> >> The miss is self-healing: any subsequent change to dev->uc / dev->mc
> >> (every dev_{uc,mc}_{add,del}, IFF_PROMISC flip, etc.) calls
> >> __dev_set_rx_mode() -> netif_rx_mode_queue(), which re-queues the device
> >> and retries the sync. The only cost of a failed attempt is one stale
> >> rx-mode window until the next update; nothing in the kernel relies on
> >> this attempt succeeding.
> >>
> >> Demote to net_err_ratelimited() so the condition stays observable in
> >> dmesg without tripping panic_on_warn.
> >>
> >> Reproducer (syzkaller .prog format with setup notes): 
> >> https://pastebin.com/t7AQKx9v
> >>
> >> Fixes: 3554b4345d85 ("net: introduce ndo_set_rx_mode_async and netdev_rx_mode_work")
> >> Signed-off-by: Zijing Yin <yzjaurora@gmail.com>
> >> ---
> >>  net/core/dev_addr_lists.c | 3 ++-
> >>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
> >> index d73fcb0c6..c6fdcac74 100644
> >> --- a/net/core/dev_addr_lists.c
> >> +++ b/net/core/dev_addr_lists.c
> >> @@ -1275,7 +1275,8 @@ static void netif_rx_mode_run(struct net_device *dev)
> >>  		err = netif_addr_lists_snapshot(dev, &uc_snap, &mc_snap,
> >>  						&uc_ref, &mc_ref);
> >>  		if (err) {
> >> -			netdev_WARN(dev, "failed to sync uc/mc addresses\n");
> >> +			net_err_ratelimited("%s: failed to sync uc/mc addresses\n",
> >> +					    netdev_name(dev));
> >>  			netif_addr_unlock_bh(dev);
> >>  			return;
> >>  		}
> > 
> > 1) I'd go with net_warn_ratelimited() instead. The promoted message
> > level in syslog might cause operational pain, and as you say the
> > condition is self-healing. Seems unwarranted.
> > 
> > 2) Since it has a Fixes tag, should probably be sumitted for 'net' tree.
> > 
> > 3) Was this reported by syzbot? If so, there should also be Reported-by
> > and Closes tags.
> 

