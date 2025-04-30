Return-Path: <netdev+bounces-187167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A5F0AA5769
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 23:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF67F5061C3
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 21:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EC732D1138;
	Wed, 30 Apr 2025 21:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bw9tfX2s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B12297A7F;
	Wed, 30 Apr 2025 21:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746048576; cv=none; b=aaKhaKKO3gA+KR7D/I/kh0tq9pjBSuVv90NH5GRsPhZ4k71/UzAnyXyP3XR032JQ1W0n3Gb1/6wM+e92w4gLIErC2Hb2aIr/8nOy3H5woyl0ZoZoPIm07ajBpFLMfVZn96iMJ6rD4A7n5tjGMAdcAgGpgasis7LbPp+1YSAExUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746048576; c=relaxed/simple;
	bh=lIKIbLtONHYjXLdhuP4peo4Z8DDsc4FDnAj/KpC7OMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CW5jiL40O8yKedoz/bbUe0p+9bPKv8It9rRPM3vhGEtTREeVt/sDlXK7i1qx8+rc3w0K42ijOpeNZd1Rp0Y/eZWD40lQWP746O3eyvVOpqHbizJ/6UjmQeFKcUBFmH5g7lUhGwRNrte4KQH7NXYmp2e4xX4+6NWecWptpzc7KfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bw9tfX2s; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746048572; x=1777584572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=yyT2mE4AxoVDIQ/9ei0bjwOO32J4Gut3ZMT5pI4UU7E=;
  b=bw9tfX2sQx1b2LtmuKGIYP0rLWwwsWNDvNAPOkZQEzIq8PLRUs3IreeQ
   y2Qg9S9FPzA1pMLWg1SShalQbCAmO7k5JvAepVHM7+hr9XzZCh51RsnYN
   AS5RyaYtr/loDRRn16dhki5abo4X9cEWvu4CgCYJHzEqfHmP4Bb5Ii2uq
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,252,1739836800"; 
   d="scan'208";a="718487481"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 21:29:27 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:32139]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.121:2525] with esmtp (Farcaster)
 id 62e930e0-868d-4088-b8d6-eaf92158a546; Wed, 30 Apr 2025 21:29:26 +0000 (UTC)
X-Farcaster-Flow-ID: 62e930e0-868d-4088-b8d6-eaf92158a546
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 30 Apr 2025 21:29:26 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 30 Apr 2025 21:29:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jlayton@kernel.org>
CC: <airlied@gmail.com>, <akpm@linux-foundation.org>, <andrew@lunn.ch>,
	<davem@davemloft.net>, <dri-devel@lists.freedesktop.org>,
	<edumazet@google.com>, <horms@kernel.org>, <intel-gfx@lists.freedesktop.org>,
	<jani.nikula@linux.intel.com>, <joonas.lahtinen@linux.intel.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
	<nathan@kernel.org>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<qasdev00@gmail.com>, <rodrigo.vivi@intel.com>, <simona@ffwll.ch>,
	<tursulin@ursulin.net>, <tzimmermann@suse.de>
Subject: Re: [PATCH v6 08/10] net: add symlinks to ref_tracker_dir for netns
Date: Wed, 30 Apr 2025 14:29:07 -0700
Message-ID: <20250430212913.27147-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250430-reftrack-dbgfs-v6-8-867c29aff03a@kernel.org>
References: <20250430-reftrack-dbgfs-v6-8-867c29aff03a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA003.ant.amazon.com (10.13.139.42) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Apr 2025 08:06:54 -0700
> After assigning the inode number to the namespace, use it to create a
> unique name for each netns refcount tracker with the ns.inum value in
> it, and register a symlink to the debugfs file for it.
> 
> init_net is registered before the ref_tracker dir is created, so add a
> late_initcall() to register its files and symlinks.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  net/core/net_namespace.c | 28 +++++++++++++++++++++++++++-
>  1 file changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> index 008de9675ea98fa8c18628b2f1c3aee7f3ebc9c6..6cbc8eabb8e56c847fc34fa8ec9994e8b275b0af 100644
> --- a/net/core/net_namespace.c
> +++ b/net/core/net_namespace.c
> @@ -763,12 +763,38 @@ struct net *get_net_ns_by_pid(pid_t pid)
>  }
>  EXPORT_SYMBOL_GPL(get_net_ns_by_pid);
>  
> +#ifdef CONFIG_NET_NS_REFCNT_TRACKER
> +static void net_ns_net_debugfs(struct net *net)
> +{
> +	ref_tracker_dir_symlink(&net->refcnt_tracker, "netns-%u-refcnt", net->ns.inum);
> +	ref_tracker_dir_symlink(&net->notrefcnt_tracker, "netns-%u-notrefcnt", net->ns.inum);

Could you use net->net_cookie ?

net->ns.inum is always 1 when CONFIG_PROC_FS=n.

