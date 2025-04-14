Return-Path: <netdev+bounces-182398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 539AAA88AB7
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 847D818948C2
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 18:08:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DDAA27B4F0;
	Mon, 14 Apr 2025 18:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rl80Shz/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1410827467D
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 18:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744654066; cv=none; b=f6fk73+r5QZMS0HkEaxFkhbwBpJ7wB5Fpks2kGxTv6o5yUdjRDgzB9IVEP+rUITpRCUmFwVq4awwjiOYcPcV2yWmrkIEgG6BID2+7VoSRkgwS0UQc7mzmZOzGo4w0oW8xIhlu41gULBMwyR7SYFbXPigoXNjlh1Ium+/mqPM7/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744654066; c=relaxed/simple;
	bh=wwfzw9cElkhMpJqzG3NEJxYlstI/SNrAWm6plYVWLHs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TYXKMNyL/RIQoYR5ZYmPBu12EmCfwV7jQ5OQ8bDEcTh6sDqlZeiR3ZQUdlOQqZtqnltGheeBH+YHWn0Vg/rM8K0ZfQDzLxqqsUhmRhpkC35jtk2jX70TsUQio7/F+xGYcBvKQ7Ge+XuPGOPyJ+u3b8mY/1Ur7AeXG+t2S+mTP74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rl80Shz/; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744654065; x=1776190065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gOZO9I5TvVbrz8jzJg9YfTR3q0paJDHrI29qVW1wvBg=;
  b=rl80Shz/+FGj/ld+Ni0tP4oFlMzW1ukN+Pq/fYcu7I7jRjj0vLr1tqqS
   HOX4fPd81Cfxcv2XZUy9mEERDweKqNXqLUfObjW4b/rep3BP8KL17cH/S
   oTIZq1sK8u1pbaa/j3UeAZeM1b/8tejktgNvm1T0v9IqtHpCIlVFZpHZc
   E=;
X-IronPort-AV: E=Sophos;i="6.15,212,1739836800"; 
   d="scan'208";a="187297551"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2025 18:07:43 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:10671]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.195:2525] with esmtp (Farcaster)
 id 8d04718f-2884-4ae2-ae26-df939416a736; Mon, 14 Apr 2025 18:07:42 +0000 (UTC)
X-Farcaster-Flow-ID: 8d04718f-2884-4ae2-ae26-df939416a736
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:07:41 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.39) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 14 Apr 2025 18:07:39 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <horms@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 10/14] ipv6: Factorise ip6_route_multipath_add().
Date: Mon, 14 Apr 2025 11:06:58 -0700
Message-ID: <20250414180731.26130-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250414145226.GS395307@horms.kernel.org>
References: <20250414145226.GS395307@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Simon Horman <horms@kernel.org>
Date: Mon, 14 Apr 2025 15:52:26 +0100
> On Fri, Apr 11, 2025 at 12:33:46PM -0700, Kuniyuki Iwashima wrote:
> > From: Simon Horman <horms@kernel.org>
> > Date: Fri, 11 Apr 2025 11:34:04 +0100
> > > > +static int ip6_route_mpath_info_create_nh(struct list_head *rt6_nh_list,
> > > > +					  struct netlink_ext_ack *extack)
> > > > +{
> > > > +	struct rt6_nh *nh, *nh_next, *nh_tmp;
> > > > +	LIST_HEAD(tmp);
> > > > +	int err;
> > > > +
> > > > +	list_for_each_entry_safe(nh, nh_next, rt6_nh_list, next) {
> > > > +		struct fib6_info *rt = nh->fib6_info;
> > > > +
> > > > +		err = ip6_route_info_create_nh(rt, &nh->r_cfg, extack);
> > > > +		if (err) {
> > > > +			nh->fib6_info = NULL;
> > > > +			goto err;
> > > > +		}
> > > > +
> > > > +		rt->fib6_nh->fib_nh_weight = nh->weight;
> > > > +
> > > > +		list_move_tail(&nh->next, &tmp);
> > > > +
> > > > +		list_for_each_entry(nh_tmp, rt6_nh_list, next) {
> > > > +			/* check if fib6_info already exists */
> > > > +			if (rt6_duplicate_nexthop(nh_tmp->fib6_info, rt)) {
> > > > +				err = -EEXIST;
> > > > +				goto err;
> > > > +			}
> > > > +		}
> > > > +	}
> > > > +out:
> > > > +	list_splice(&tmp, rt6_nh_list);
> > > > +	return err;
> > > 
> > > Hi Kuniyuki-san,
> > > 
> > > Perhaps it can't happen in practice,
> > 
> > Yes, it never happens by patch 1 as rtm_to_fib6_multipath_config()
> > returns an error in such a case.
> > 
> > 
> > > but if the loop above iterates zero
> > > times then err will be used uninitialised. As it's expected that err is 0
> > > here, perhaps it would be simplest to just:
> > > 
> > > 	return 0;
> > 
> > If we want to return 0 above, we need to duplicate list_splice() at
> > err: and return err; there.  Or initialise err = 0, but this looks
> > worse to me.
> 
> Thanks. I should have dug a bit deeper to determine that this
> is a false-positive.
> 
> > Btw, was this caught by Smatch, Coverity, or something ?  I don't
> > see such a report at CI.
> > https://patchwork.kernel.org/project/netdevbpf/patch/20250409011243.26195-11-kuniyu@amazon.com/
> 
> Sorry for not mentioning that it was flagged by Smatch,
> I certainly should have done so.

Thanks for confirming!

> 
> 
> > 
> > If so, I'm just curious if we have an official guideline for
> > false-positives flagged by such tools, like we should care about it
> > while writing a code and should try to be safer to make it happy.
> > 
> > We are also running Coverity for the mainline kernel and have tons
> > of false-positive reports due to lack of contexts.
> 
> I think that the current non-guideline is that we don't change
> code just to keep the tools happy. Perhaps we should add something
> about that to the process document?

Makes sense.

But looks like the series was marked Changes Requested, not sure
if it's accidental or intentional, so I'll resend v2 to see others'
opinion.

Thanks!

