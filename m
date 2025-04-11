Return-Path: <netdev+bounces-181761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 82DB1A86677
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 21:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92A668C7C92
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 19:34:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59E2127F4D9;
	Fri, 11 Apr 2025 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="TjYbO2R9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980BD27F4CF
	for <netdev@vger.kernel.org>; Fri, 11 Apr 2025 19:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744400054; cv=none; b=WPU1eED3o9/CalUBufZ7dTPhUS8FomXOnhSQDBb9PUkNa1NDHPU7Hz7Y/rgI/UBh4heG0DBvE0x6CLm9kpB1PKb06RLM8rhbpq1F3QDW4qPus47vb0zK23QZzV3Hx6s/yioMZ4e7mguQaRU9yhbZy5tj6Wj8CH/975xbnN5mgOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744400054; c=relaxed/simple;
	bh=VbLTeajRe83GTFCQnhUwlnap2k1sQTbhQSEZnbgOXhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aZKrpz6doeZgmuERuHE4xQHdW98aIAJaKFlVNWK6pyX40DKtlOFsXLAxD2ZcguushX/SO6WNfbWQ24iVRvTCNE0Kak1RSZScUEN4gaSoA9Q4QKedWx8f8S4JRmSGKEH+EKHgM7CqygIV7RWxifNcLd3tnTo4fVAywWcDN+8M1/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=TjYbO2R9; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744400053; x=1775936053;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sMswd7w0o7wswqtXzh45dPieVNhg2mZS7fQ0nIQbMRo=;
  b=TjYbO2R92HY4O/t9NoQdkXthBmE6g8TpkaxZ91wuY3iULEDe1felusHv
   FkZ0FwuP5aVKu4yuaiPJxBXJg29Ve3eFGGj4Y3RStka3NrQ/1hTq+7jC4
   kOR+1fegoGX9nSfw90qNIlhKRTrWmpEDad6belMUFkMRZ1C7X0JvkmjlM
   8=;
X-IronPort-AV: E=Sophos;i="6.15,206,1739836800"; 
   d="scan'208";a="9705305"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 19:34:07 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:30264]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.159:2525] with esmtp (Farcaster)
 id 24f21add-cb41-4a8b-bc0c-b11c12051ebd; Fri, 11 Apr 2025 19:34:06 +0000 (UTC)
X-Farcaster-Flow-ID: 24f21add-cb41-4a8b-bc0c-b11c12051ebd
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 19:34:02 +0000
Received: from 6c7e67bfbae3.amazon.com (10.119.240.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Fri, 11 Apr 2025 19:34:00 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <horms@kernel.org>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 10/14] ipv6: Factorise ip6_route_multipath_add().
Date: Fri, 11 Apr 2025 12:33:46 -0700
Message-ID: <20250411193347.47836-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250411103404.GY395307@horms.kernel.org>
References: <20250411103404.GY395307@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Simon Horman <horms@kernel.org>
Date: Fri, 11 Apr 2025 11:34:04 +0100
> > +static int ip6_route_mpath_info_create_nh(struct list_head *rt6_nh_list,
> > +					  struct netlink_ext_ack *extack)
> > +{
> > +	struct rt6_nh *nh, *nh_next, *nh_tmp;
> > +	LIST_HEAD(tmp);
> > +	int err;
> > +
> > +	list_for_each_entry_safe(nh, nh_next, rt6_nh_list, next) {
> > +		struct fib6_info *rt = nh->fib6_info;
> > +
> > +		err = ip6_route_info_create_nh(rt, &nh->r_cfg, extack);
> > +		if (err) {
> > +			nh->fib6_info = NULL;
> > +			goto err;
> > +		}
> > +
> > +		rt->fib6_nh->fib_nh_weight = nh->weight;
> > +
> > +		list_move_tail(&nh->next, &tmp);
> > +
> > +		list_for_each_entry(nh_tmp, rt6_nh_list, next) {
> > +			/* check if fib6_info already exists */
> > +			if (rt6_duplicate_nexthop(nh_tmp->fib6_info, rt)) {
> > +				err = -EEXIST;
> > +				goto err;
> > +			}
> > +		}
> > +	}
> > +out:
> > +	list_splice(&tmp, rt6_nh_list);
> > +	return err;
> 
> Hi Kuniyuki-san,
> 
> Perhaps it can't happen in practice,

Yes, it never happens by patch 1 as rtm_to_fib6_multipath_config()
returns an error in such a case.


> but if the loop above iterates zero
> times then err will be used uninitialised. As it's expected that err is 0
> here, perhaps it would be simplest to just:
> 
> 	return 0;

If we want to return 0 above, we need to duplicate list_splice() at
err: and return err; there.  Or initialise err = 0, but this looks
worse to me.

Btw, was this caught by Smatch, Coverity, or something ?  I don't
see such a report at CI.
https://patchwork.kernel.org/project/netdevbpf/patch/20250409011243.26195-11-kuniyu@amazon.com/

If so, I'm just curious if we have an official guideline for
false-positives flagged by such tools, like we should care about it
while writing a code and should try to be safer to make it happy.

We are also running Coverity for the mainline kernel and have tons
of false-positive reports due to lack of contexts.

Thanks!

> 
> > +err:
> > +	ip6_route_mpath_info_cleanup(rt6_nh_list);
> > +	goto out;

