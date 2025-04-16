Return-Path: <netdev+bounces-183463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33144A90BC7
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 20:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3B2819E0045
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 18:58:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B358A223707;
	Wed, 16 Apr 2025 18:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="MQk3WvRf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2243F2222DC
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 18:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744829907; cv=none; b=OB5iQuGG5EMob003s4Jk7PcITNXdxSMr4vGUMKM4Wrm7RYnz1NFC3tnwKLECO1JLY4YuyRPQMbeIR3bl4am/VlF8LhDNv1s1g6dadBDppbKtMaoUO2jI+IATg1wjaKK6b52fVdJwZU18cc177iEhVYLLAwHhmnuyrNhXqnOjJBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744829907; c=relaxed/simple;
	bh=kjcO+A9vnkzSq9vS2MUCA+TVg5yhBwDeD0dSUwXWPdM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ICmiRLFbu+Sqv5HgfhQZOFWm+LzdtSWW4Gi15hV6otK6v9Ae7jp2Qh5X9t8iCyeI1GoPn08TAe1t/YD6WsAhhbclvcwmXy3yoiawzmFNoJ1HgiQ8NRJ5rwPoz0s2Ju+zk79w7rVtCPk8dokS/uA4/A0tY7VBeo3KMwWYwZ83iF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=MQk3WvRf; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744829906; x=1776365906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oJJlWaAHCca4yCkrtTqzmt9ZsGeLeePiEEVkVBZhJgA=;
  b=MQk3WvRfmszyj1E3skXhNwxFZ6oCfCe7WQIdrL/lNr9i97RAgVzMsM/l
   RPzhzVgBGKXJPMJo38wOxbIx9akCIsQK2cZe7lI+Aq9k4bHcxXCcJUPIM
   u5hprNBW2ijG3PKa9ac/OAw7vBejhFE7cgGRi1Tnyt0EuiHNxCasm/+8p
   0=;
X-IronPort-AV: E=Sophos;i="6.15,216,1739836800"; 
   d="scan'208";a="11004962"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 18:58:21 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:47602]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.169:2525] with esmtp (Farcaster)
 id 299ce818-f4b4-45f0-95d2-96f98944496a; Wed, 16 Apr 2025 18:58:20 +0000 (UTC)
X-Farcaster-Flow-ID: 299ce818-f4b4-45f0-95d2-96f98944496a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 18:58:20 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 18:58:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 net-next 10/14] ipv6: Factorise ip6_route_multipath_add().
Date: Wed, 16 Apr 2025 11:58:07 -0700
Message-ID: <20250416185809.1695-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <c9bee472-c94e-4878-8cc2-1512b2c54db5@redhat.com>
References: <c9bee472-c94e-4878-8cc2-1512b2c54db5@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 16 Apr 2025 11:57:23 +0200
> On 4/14/25 8:14 PM, Kuniyuki Iwashima wrote:
> > diff --git a/net/ipv6/route.c b/net/ipv6/route.c
> > index 49eea7e1e2da..c026f8fe5f78 100644
> > --- a/net/ipv6/route.c
> > +++ b/net/ipv6/route.c
> > @@ -5315,29 +5315,131 @@ struct rt6_nh {
> >  	struct fib6_info *fib6_info;
> >  	struct fib6_config r_cfg;
> >  	struct list_head next;
> > +	int weight;
> >  };
> >  
> > -static int ip6_route_info_append(struct list_head *rt6_nh_list,
> > -				 struct fib6_info *rt,
> > -				 struct fib6_config *r_cfg)
> > +static void ip6_route_mpath_info_cleanup(struct list_head *rt6_nh_list)
> >  {
> > -	struct rt6_nh *nh;
> > -	int err = -EEXIST;
> > +	struct rt6_nh *nh, *nh_next;
> >  
> > -	list_for_each_entry(nh, rt6_nh_list, next) {
> > -		/* check if fib6_info already exists */
> > -		if (rt6_duplicate_nexthop(nh->fib6_info, rt))
> > -			return err;
> > +	list_for_each_entry_safe(nh, nh_next, rt6_nh_list, next) {
> > +		struct fib6_info *rt = nh->fib6_info;
> > +
> > +		if (rt) {
> > +			free_percpu(rt->fib6_nh->nh_common.nhc_pcpu_rth_output);
> > +			free_percpu(rt->fib6_nh->rt6i_pcpu);
> > +			ip_fib_metrics_put(rt->fib6_metrics);
> > +			kfree(rt);
> > +		}
> > +
> > +		list_del(&nh->next);
> 
> Somewhat unrelated, but the field 'next' has IMHO a quite misleading
> name, and it would be great to rename it to something else ('list'),
> could you please consider including such change?

Had the same feeling :)

Will add a patch or post a follow if the series gets over 15.

