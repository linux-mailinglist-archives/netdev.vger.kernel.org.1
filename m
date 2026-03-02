Return-Path: <netdev+bounces-262648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oPmLDIKNpWmoDgYAu9opvQ
	(envelope-from <netdev+bounces-262648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:15:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F881D99AA
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 14:15:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BCEA53068EEB
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 13:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E2663E0C65;
	Mon,  2 Mar 2026 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQGDaz4S"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4C63E0C61
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772457172; cv=none; b=ezlp3fGBWwGWzhpezZ/QZRsIbaj7/WKq4Q8Oh28NZS43Gv2pVE8rn97phetU48ItAHkbrU5r4GpXPH7riiZgarLkJptYBANl9y1baokuP280xSWUdnaazG5zHK8Y+AO32p6Q9CzaljzRWLAF65BPl0n7t/H7pKkfG4mKg8UEizA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772457172; c=relaxed/simple;
	bh=tXdQ2OklseCAkogI4h7IQ+60z2DOykWACIdOWYiSpRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NXvf/vOeePETkDV5MuvjNqIFZJ5qhK0ND6B87v7ERy7UZK+UTKbcQK85WmW0cN68Zk95jYq0TtGPxRSdKVZba5cNRE1WVj9ZEBKUwUDLJ4gCs4t4GmJJgEAzqVTVZnBumunIIrkpNVjDGQsSnmjDlI3lUv0bpfxOCfkQKtKIl3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQGDaz4S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D870FC2BC87;
	Mon,  2 Mar 2026 13:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772457172;
	bh=tXdQ2OklseCAkogI4h7IQ+60z2DOykWACIdOWYiSpRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sQGDaz4SV9pqH3axmdYgn9o4v/mBaonbyBbZiUti/8DsQYXDQnowojVdb3yMvsA7v
	 IF1ahjZQHBqMYYGhJlVA1zIQn5tTwrDNskF3BGSsgn/b4jrM3pp8+r/Qb81VDk5ono
	 WU5z/gGujav1n8v0Vsz9IsI0T7h+QAdwnvsy6yCZWefxTcwpieObKMeNHkFMSj6Os0
	 EUliQoZVlyifhUdbLl/GAwD5cqllb+ZnDCV/WPlHiHWGQ2Xeo0bXE1DNOvCPu+8ANq
	 E8ZKqfwvpTkXcEahh1mKDYbA09oJi0zLuAmJORVGZXxXgLMWpnC/c58zXmIaEcVJiu
	 kxmBKiiPsTkdg==
From: Simon Horman <horms@kernel.org>
To: kuniyu@google.com
Cc: Simon Horman <horms@kernel.org>,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	netdev@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	kuni1840@gmail.com
Subject: Re: [v3,net-next,08/15] ipmr: Move unregister_netdevice_many() out of ipmr_free_table().
Date: Mon,  2 Mar 2026 13:12:19 +0000
Message-ID: <20260302131218.679806-2-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260228221800.1082070-9-kuniyu@google.com>
References: <20260228221800.1082070-9-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,redhat.com,vger.kernel.org,davemloft.net,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262648-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: A0F881D99AA
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ipmr: Move unregister_netdevice_many() out of ipmr_free_table().

This commit refactors network device cleanup in the IP multicast routing
code by moving unregister_netdevice_many() from ipmr_free_table() to its
callers, enabling batched cleanup across multiple tables per netns.

> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index d15e05662b09..7e2aa2026f01 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c

[ ... ]

> @@ -349,8 +355,13 @@ static int __net_init ipmr_rules_init(struct net *net)
>
>  static void __net_exit ipmr_rules_exit(struct net *net)
>  {
> +	LIST_HEAD(dev_kill_list);
> +
>  	ASSERT_RTNL();
> -	ipmr_free_table(net->ipv4.mrt);
> +
> +	ipmr_free_table(net->ipv4.mrt, &dev_kill_list);
> +	unregister_netdevice_many(&dev_kill_list);
> +
>  	net->ipv4.mrt = NULL;
>  }

In the !CONFIG_IP_MROUTE_MULTIPLE_TABLES version of ipmr_rules_exit(),
does this sequence lead to a use-after-free?

ipmr_free_table() calls kfree(mrt) to free the table:

net/ipv4/ipmr.c:ipmr_free_table() {
    ...
    rhltable_destroy(&mrt->mfc_hash);
    kfree(mrt);
}

Then unregister_netdevice_many() is called, which triggers NETDEV_UNREGISTER
notifications. The global notifier ipmr_device_event() handles this event
and calls ipmr_for_each_table().

In the non-MULTIPLE_TABLES case, ipmr_for_each_table() expands to:

    for (mrt = net->ipv4.mrt; mrt; mrt = NULL)

Since net->ipv4.mrt still points to the freed memory at this point (it's
only set to NULL after unregister_netdevice_many() completes), won't
ipmr_device_event() access mrt->vif_table and mrt->maxvif from a freed
slab object?

The CONFIG_IP_MROUTE_MULTIPLE_TABLES version appears safe because
list_del(&mrt->list) removes the table from the iteration list before
kfree().

Should net->ipv4.mrt = NULL be moved before calling
unregister_netdevice_many(), or before calling ipmr_free_table()?

> @@ -425,18 +436,16 @@ static struct mr_table *ipmr_new_table(struct net *net, u32 id)
>  			      ipmr_expire_process, ipmr_new_table_set);
>  }
>
> -static void ipmr_free_table(struct mr_table *mrt)
> +static void ipmr_free_table(struct mr_table *mrt, struct list_head *dev_kill_list)
>  {
>  	struct net *net = read_pnet(&mrt->net);
> -	LIST_HEAD(dev_kill_list);
>
>  	WARN_ON_ONCE(!mr_can_free_table(net));
>
>  	timer_shutdown_sync(&mrt->ipmr_expire_timer);
>  	mroute_clean_tables(mrt, MRT_FLUSH_VIFS | MRT_FLUSH_VIFS_STATIC |
>  			    MRT_FLUSH_MFC | MRT_FLUSH_MFC_STATIC,
> -			    &dev_kill_list);
> -	unregister_netdevice_many(&dev_kill_list);
> +			    dev_kill_list);
>  	rhltable_destroy(&mrt->mfc_hash);
>  	kfree(mrt);
>  }

