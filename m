Return-Path: <netdev+bounces-181060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DEEA837D2
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 06:26:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16E038A427D
	for <lists+netdev@lfdr.de>; Thu, 10 Apr 2025 04:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BF1F1F2B85;
	Thu, 10 Apr 2025 04:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tbpBpfhc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C67F1F1538;
	Thu, 10 Apr 2025 04:26:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744259179; cv=none; b=IeSTFUGu7GClOoKR3MuLKwxJlpgXL3V8w+bw3awryJ1iOOgwEHbfTcsCJ9R4DwWNOvHXvG7s5ivedvwly9+k3n+KWUyeCKSO6A8srmxbt1x0Nx3OB0lXMZVbLi1k8drhUm+phbxmoarD+siPEcqMqVjZGD0AdM2uOB5NZ50cWjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744259179; c=relaxed/simple;
	bh=i2rsA0GJ5JL9p9YLnj53F8I4XkKH+f57A+JCAXPDoxg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f7KEhziSV0A91lsExP5k/vViGIT9+hNbrph+3x7yrO4h/R0nTDAebJg6sAhTQceZ0p5qk1o70RCzscGguEQfJxkio4WJZDmKaqBjs1vV3lyuYckd+RUm0mcUsDa2+ANi/TM5eg//h0J40TkBWi08Tn3G7L2cjFCgRcSCJ5foWZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tbpBpfhc; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744259178; x=1775795178;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jWrgfCuyAlswd5qJJIv7RiCXg6fDzAQOV2joMZ360dQ=;
  b=tbpBpfhcyP8iLDQQ5pLhtobUroCv317SzMct4RQ7F15yCKIfPMPsLTik
   9mZF4/pxvWpnQdhPDw4Jfo/kEKMDztIyw+MRt05I1mgKrTK7zqWEAWxYO
   SnScg/N1vGeBwAZWXAQG/RLl+4Nlpf6dD+KNuIk7YsdcRQwURix7bKVQy
   4=;
X-IronPort-AV: E=Sophos;i="6.15,202,1739836800"; 
   d="scan'208";a="481854576"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 04:26:14 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:55004]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.195:2525] with esmtp (Farcaster)
 id 5eb5ee46-9dd5-4e4c-9964-7a70054ce6e7; Thu, 10 Apr 2025 04:26:13 +0000 (UTC)
X-Farcaster-Flow-ID: 5eb5ee46-9dd5-4e4c-9964-7a70054ce6e7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 04:26:12 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.41) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 10 Apr 2025 04:26:09 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jlayton@kernel.org>
CC: <akpm@linux-foundation.org>, <andrew@lunn.ch>, <davem@davemloft.net>,
	<edumazet@google.com>, <horms@kernel.org>, <kuba@kernel.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <kuniyu@amazon.com>
Subject: Re: [PATCH v2 2/2] net: add debugfs files for showing netns refcount tracking info
Date: Wed, 9 Apr 2025 21:24:59 -0700
Message-ID: <20250410042602.27471-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408-netns-debugfs-v2-2-ca267f51461e@kernel.org>
References: <20250408-netns-debugfs-v2-2-ca267f51461e@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jeff Layton <jlayton@kernel.org>
Date: Tue, 08 Apr 2025 09:36:38 -0400
> CONFIG_NET_NS_REFCNT_TRACKER currently has no convenient way to display
> its tracking info. Add a new net_ns directory under the debugfs
> ref_tracker directory. Create a directory in there for every netns, with
> refcnt and notrefcnt files that show the currently tracked active and
> passive references.
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

I think there is no clear rule about where to break, but could you
remove \n after int so that it will match with other functions in
this file ?

Same for other new functions, looks like none of them go over 80 columns.

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
> +	}
> +	seq_write(f, buf, len);
> +	kvfree(buf);
> +	return 0;
> +}
> +
> +static int
> +ns_debug_ref_open(struct inode *inode, struct file *filp)
> +{
> +	int ret;
> +	struct net *net = inode->i_private;

nit: Please sort in the reverse xmas order.

https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

> +
> +	ret = single_open(filp, ns_debug_tracker_show, &net->refcnt_tracker);
> +	if (!ret)
> +		net_passive_inc(net);
> +	return ret;
> +}
> +
> +static int
> +ns_debug_notref_open(struct inode *inode, struct file *filp)
> +{
> +	int ret;
> +	struct net *net = inode->i_private;

Same here.


> +
> +	ret = single_open(filp, ns_debug_tracker_show, &net->notrefcnt_tracker);
> +	if (!ret)
> +		net_passive_inc(net);
> +	return ret;
> +}
> +
> +static int
> +ns_debug_ref_release(struct inode *inode, struct file *filp)
> +{
> +	struct net *net = inode->i_private;
> +
> +	net_passive_dec(net);
> +	return single_release(inode, filp);
> +}
> +
> +static const struct file_operations ns_debug_ref_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= ns_debug_ref_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= ns_debug_ref_release,
> +};
> +
> +static const struct file_operations ns_debug_notref_fops = {
> +	.owner		= THIS_MODULE,
> +	.open		= ns_debug_notref_open,
> +	.read		= seq_read,
> +	.llseek		= seq_lseek,
> +	.release	= ns_debug_ref_release,
> +};
> +
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
> +
> +	dnet->refcnt = debugfs_create_file("refcnt", S_IFREG | 0400, dnet->netdir,
> +					   net, &ns_debug_ref_fops);
> +	if (IS_ERR(dnet->refcnt)) {
> +		debugfs_remove(dnet->netdir);
> +		return PTR_ERR(dnet->refcnt);
> +	}
> +
> +	dnet->notrefcnt = debugfs_create_file("notrefcnt", S_IFREG | 0400, dnet->netdir,
> +					      net, &ns_debug_notref_fops);
> +	if (IS_ERR(dnet->notrefcnt)) {
> +		debugfs_remove_recursive(dnet->netdir);
> +		return PTR_ERR(dnet->notrefcnt);
> +	}
> +
> +	return 0;
> +}
> +
> +static void
> +ns_debug_exit_net(struct net *net)
> +{
> +	struct ns_debug_net *dnet = net_generic(net, ns_debug_net_id);
> +
> +	debugfs_remove_recursive(dnet->netdir);
> +}
> +
> +static struct pernet_operations ns_debug_net_ops = {
> +	.init = ns_debug_init_net,
> +	.exit = ns_debug_exit_net,
> +	.id = &ns_debug_net_id,
> +	.size = sizeof(struct ns_debug_net),
> +};
> +
> +static int __init ns_debug_init(void)
> +{
> +	ns_ref_tracker_dir = debugfs_create_dir("net_ns", ref_tracker_debug_dir);
> +	if (IS_ERR(ns_ref_tracker_dir))
> +		return PTR_ERR(ns_ref_tracker_dir);
> +
> +	register_pernet_subsys(&ns_debug_net_ops);
> +	return 0;

register_pernet_subsys() could fail, so

	return register_pernet_subsys(&ns_debug_net_ops);


> +}
> +late_initcall(ns_debug_init);
> +#endif /* CONFIG_NET_NS_REFCNT_TRACKER */
> +#endif /* CONFIG_DEBUG_FS */
> 
> -- 
> 2.49.0
> 

