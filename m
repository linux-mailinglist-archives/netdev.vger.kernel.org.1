Return-Path: <netdev+bounces-187207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1681AAA5A4A
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 06:27:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C24179A19E1
	for <lists+netdev@lfdr.de>; Thu,  1 May 2025 04:27:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD4622541F;
	Thu,  1 May 2025 04:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aMP3Jy8a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29E7AD58;
	Thu,  1 May 2025 04:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746073661; cv=none; b=U4EGi8UYJ1Rx1m6/mQCcwpcObwLNFmQ+bcJAUkrSLt0I0bkyRxvA4t+f9J0lCD96wlGWCg6nY5zoFWaBT8sxusERIBSAyaZyZlhusPpQ5tQPTLxnYdEMhiv+SeKWsWzl09DpOmvTF4SViwMeLXzeuLxmAMfJiieBDWnSIAxiuSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746073661; c=relaxed/simple;
	bh=wm2uoskBjcmJ5xq4YXyrUz3AWluHN+lK7mFqlsXzPSI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FLJD4yL2NX3a+ee/0l2T1xal3Mkv2l96Tu64cChhUhEhWmQ6KKNRpuUrPwDaQp1OTTbgQz9xQIiG4bBkjsB+LNQa1Ti8QNO0YHmTc/LabtbEu22BhafQd8oZs7ToN7tfqUY34wffUtzfVdylsuo6LYpiMBFxQFH8X2Q700HEXzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aMP3Jy8a; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1746073660; x=1777609660;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dLcL67+O3gdWGHtlIunDL8NWJWKO9aINTCEgtB1sDsM=;
  b=aMP3Jy8azOcNS1SjijmRlUtPsq9H2dhqyzrkbovF07M/SJARs1S5+Frt
   GfYcXmJtD5/XoN5x5sk+4cudKNHsQbBb1dHVsCFcJyaM+nPqMO/H1Im6e
   Xjl4IF3zU5HV4wLZHg93LTlNYUu+RLnmuM7HBABY2ql7OGhy6HkFUdgxF
   w=;
X-IronPort-AV: E=Sophos;i="6.15,253,1739836800"; 
   d="scan'208";a="15368904"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2025 04:27:34 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:50737]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.68:2525] with esmtp (Farcaster)
 id f4ae1998-50aa-4fe2-9700-d7b1c72e7189; Thu, 1 May 2025 04:27:33 +0000 (UTC)
X-Farcaster-Flow-ID: f4ae1998-50aa-4fe2-9700-d7b1c72e7189
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 04:27:33 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 1 May 2025 04:27:27 +0000
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
Date: Wed, 30 Apr 2025 21:26:47 -0700
Message-ID: <20250501042719.81002-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <0c4e532ed8b58f8253a14f8ed59d93523a096f16.camel@kernel.org>
References: <0c4e532ed8b58f8253a14f8ed59d93523a096f16.camel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB001.ant.amazon.com (10.13.139.187) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jeff Layton <jlayton@kernel.org>
Date: Wed, 30 Apr 2025 21:07:20 -0700
> On Wed, 2025-04-30 at 20:50 -0700, Kuniyuki Iwashima wrote:
> > From: Jeff Layton <jlayton@kernel.org>
> > Date: Wed, 30 Apr 2025 20:42:40 -0700
> > > On Wed, 2025-04-30 at 20:07 -0700, Kuniyuki Iwashima wrote:
> > > > From: Jeff Layton <jlayton@kernel.org>
> > > > Date: Wed, 30 Apr 2025 19:59:23 -0700
> > > > > On Wed, 2025-04-30 at 14:29 -0700, Kuniyuki Iwashima wrote:
> > > > > > From: Jeff Layton <jlayton@kernel.org>
> > > > > > Date: Wed, 30 Apr 2025 08:06:54 -0700
> > > > > > > After assigning the inode number to the namespace, use it to create a
> > > > > > > unique name for each netns refcount tracker with the ns.inum value in
> > > > > > > it, and register a symlink to the debugfs file for it.
> > > > > > > 
> > > > > > > init_net is registered before the ref_tracker dir is created, so add a
> > > > > > > late_initcall() to register its files and symlinks.
> > > > > > > 
> > > > > > > Signed-off-by: Jeff Layton <jlayton@kernel.org>
> > > > > > > ---
> > > > > > >  net/core/net_namespace.c | 28 +++++++++++++++++++++++++++-
> > > > > > >  1 file changed, 27 insertions(+), 1 deletion(-)
> > > > > > > 
> > > > > > > diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
> > > > > > > index 008de9675ea98fa8c18628b2f1c3aee7f3ebc9c6..6cbc8eabb8e56c847fc34fa8ec9994e8b275b0af 100644
> > > > > > > --- a/net/core/net_namespace.c
> > > > > > > +++ b/net/core/net_namespace.c
> > > > > > > @@ -763,12 +763,38 @@ struct net *get_net_ns_by_pid(pid_t pid)
> > > > > > >  }
> > > > > > >  EXPORT_SYMBOL_GPL(get_net_ns_by_pid);
> > > > > > >  
> > > > > > > +#ifdef CONFIG_NET_NS_REFCNT_TRACKER
> > > > > > > +static void net_ns_net_debugfs(struct net *net)
> > > > > > > +{
> > > > > > > +	ref_tracker_dir_symlink(&net->refcnt_tracker, "netns-%u-refcnt", net->ns.inum);
> > > > > > > +	ref_tracker_dir_symlink(&net->notrefcnt_tracker, "netns-%u-notrefcnt", net->ns.inum);
> > > > > > 
> > > > > > Could you use net->net_cookie ?
> > > > > > 
> > > > > > net->ns.inum is always 1 when CONFIG_PROC_FS=n.
> > > > > 
> > > > > My main use-case for this is to be able to match the inode number in
> > > > > the /proc/<pid>/ns/net symlink with the correct ref_tracker debugfs
> > > > > file. Is there a way to use the net_cookie to make that association?
> > > > 
> > > > It's roundabout, but  net_cookie can be retrieved by creating a
> > > > random socket in the netns and calling setsockopt(SO_NETNS_COOKIE).
> > > > 
> > > > Ido proposed a handy ip-netns subcommand here, and I guess it will
> > > > be implemented soon(?)
> > > > https://lore.kernel.org/netdev/1d99d7ccfc3a7a18840948ab6ba1c0b5fad90901.camel@fejes.dev/
> > > 
> > > For the cases where I was looking at netns leaks, there were no more
> > > processes in the container, so there was no way to enter the container
> > > and spawn a socket at that point.
> > 
> > Then how do you get net->ns.inum ?
> > 
> 
> In my case, I was looking at /sys/kernel/debug/sunrpc/rpc_xprt/*/info.
> That also displays net->ns.inum in the same format. When I was
> originally working on this, the problem I was chasing was due to stuck
> RPC transports (rpc_xprt).

Thanks for the info.

Prefarably the debugfs should also display netns_cookie instaed of inum,
and the change is acceptable as the debugfs is not uAPI.

Then we don't need to expose possibly non-unique value just for historical
reason.


> 
> 
> > 
> > > 
> > > The point of the symlinks is to have a way to easily identify what
> > > you're tracking. NAME_MAX is 255. We could do something like this
> > > instead:
> > > 
> > >    snprintf(..., "netns-%u-%llx-refcnt", net->ns.inum, net->net_cookie);
> > > 
> > > Obviously the inums would all be 1 when PROC_FS=n, but the cookies
> > > would be unique. Would that work?
> > 
> > This works, but depending on the question above, there's no point in
> > using inum ?
> 
> Having the inum is definitely useful to me, particularly since the
> net_cookie would be pretty useless for the problems I've been chasing.
>  
> I'll plan to respin this to include the net_cookie though, since that
> would disambiguate the names when PROC_FS=n. It might also turn out to
> be useful for someone, once there is a way to fetch the net_cookie from
> userland. 
> -- 

