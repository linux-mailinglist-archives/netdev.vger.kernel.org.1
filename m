Return-Path: <netdev+bounces-181259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0F9A84360
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 14:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 423524C3893
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 12:37:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5358328540A;
	Thu, 10 Apr 2025 12:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wEi6qI4w"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D379285414;
	Thu, 10 Apr 2025 12:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744288598; cv=none; b=FxZT1Hly8M6CdcYH4qKtaWveBsMRS5drywXcn6Bi1ag0ZzTX5lJkCR1A5u0Y7Bn+jwbAplcJYwxX3kHAEQ17dDdCkjAatjtuxzQEd+9Kgg8VX5iRx90aisw1tzM7xmVDEmJrGN8RxEMxfvbDTf+0PwV6YcKOLmzrH4swJSo62e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744288598; c=relaxed/simple;
	bh=Axve0jiGvbbIsMkn4WSCs6R1ZOyKIjneErr6ing8AQM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCafNkqpofQehk3LB2N5k06Iar/KnZjNS465N5xmMM9XKLR4wqR9fwooGWnAqu23zRUpagTrjptytnqARri3P2pfsYM7P4XhjL8kAZqgxo/8bl9akPWKpqiWGhZ0nWExXufpWaVMxKvyx8VLLpFOB73WupdsLtB1568nYw4TAbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wEi6qI4w; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5oq1WjVLXQxQtBKLB02vbt6Nr9HYhm9Q4TxypjuqpOM=; b=wEi6qI4wn7j/qN+3YBFE6U6Wm5
	aqKQ/4N7St+Nowbxk6Huipm6SpBcEzxCcGTVfhnZMW0zxtzKSUpgit8BsSmDzDdR/JYFugTwZpBhj
	u2xNHgTYehH5XbkQzRnBPQRnUQ316oMyXcTg7eGSEWDY0Als90166bWyvCpZP3uicWqE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1u2r8s-008gA9-Nb; Thu, 10 Apr 2025 14:36:26 +0200
Date: Thu, 10 Apr 2025 14:36:26 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jeff Layton <jlayton@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] net: add debugfs files for showing netns refcount
 tracking info
Message-ID: <1e717326-8551-419e-b185-5cfb20573b4f@lunn.ch>
References: <20250408-netns-debugfs-v2-0-ca267f51461e@kernel.org>
 <20250408-netns-debugfs-v2-2-ca267f51461e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250408-netns-debugfs-v2-2-ca267f51461e@kernel.org>

On Tue, Apr 08, 2025 at 09:36:38AM -0400, Jeff Layton wrote:
> CONFIG_NET_NS_REFCNT_TRACKER currently has no convenient way to display
> its tracking info. Add a new net_ns directory under the debugfs
> ref_tracker directory. Create a directory in there for every netns, with
> refcnt and notrefcnt files that show the currently tracked active and
> passive references.

I think most if not all of this should be moved into the tracker
sources, there is very little which is netdev specific. 

> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  net/core/net_namespace.c | 151 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 151 insertions(+)
> 
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 4303f2a4926243e2c0ff0c0387383cd8e0658019..7e9dc487f46d656ee4ae3d6d18d35bb2aba2b176 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -1512,3 +1512,154 @@ const struct proc_ns_operations netns_operations = {
>  	.owner		= netns_owner,
>  };
>  #endif
> +
> +#ifdef CONFIG_DEBUG_FS
> +#ifdef CONFIG_NET_NS_REFCNT_TRACKER
> +
> +#include <linux/debugfs.h>
> +
> +static struct dentry *ns_ref_tracker_dir;
> +static unsigned int ns_debug_net_id;
> +
> +struct ns_debug_net {
> +	struct dentry *netdir;
> +	struct dentry *refcnt;
> +	struct dentry *notrefcnt;
> +};
> +
> +#define MAX_NS_DEBUG_BUFSIZE	(32 * PAGE_SIZE)
> +
> +static int
> +ns_debug_tracker_show(struct seq_file *f, void *v)
> +{
> +	struct ref_tracker_dir *tracker = f->private;
> +	int len, bufsize = PAGE_SIZE;
> +	char *buf;
> +
> +	for (;;) {
> +		buf = kvmalloc(bufsize, GFP_KERNEL);
> +		if (!buf)
> +			return -ENOMEM;
> +
> +		len = ref_tracker_dir_snprint(tracker, buf, bufsize);
> +		if (len < bufsize)
> +			break;
> +
> +		kvfree(buf);
> +		bufsize *= 2;
> +		if (bufsize > MAX_NS_DEBUG_BUFSIZE)
> +			return -ENOBUFS;

Maybe consider storing bufsize between calls to dump the tracker? I
guess you then have about the correct size for most calls, and from
looking at len, you can decide to downsize it if needed.

> +static int
> +ns_debug_init_net(struct net *net)
> +{
> +	struct ns_debug_net *dnet = net_generic(net, ns_debug_net_id);
> +	char name[11]; /* 10 decimal digits + NULL term */
> +	int len;
> +
> +	len = snprintf(name, sizeof(name), "%u", net->ns.inum);
> +	if (len >= sizeof(name))
> +		return -EOVERFLOW;
> +
> +	dnet->netdir = debugfs_create_dir(name, ns_ref_tracker_dir);
> +	if (IS_ERR(dnet->netdir))
> +		return PTR_ERR(dnet->netdir);

As i pointed out before, the tracker already has a name. Is that name
useless? Not specific enough? Rather than having two names, maybe
change the name to make it useful. Once it has a usable name, you
should be able to push more code into the core.

       Andrew

