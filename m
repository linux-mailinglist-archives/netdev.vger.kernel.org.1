Return-Path: <netdev+bounces-183464-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB790A90BDF
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 21:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4C9093BD27A
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 19:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F1A1F4E27;
	Wed, 16 Apr 2025 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="aDPvWzhZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221BC1E9B04
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 19:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744830182; cv=none; b=KfVGHL3y0jpoWRH61EKhF8ZItE2nfgK2/CSn7q4etFDhK865AsRkHHYIzWVwFZwZ+sPID3A2Ut0sCxoLlsP1YeK9HgxkR7/6Hn4nVT6EQxYiqB1k/uDCwE8IOKRIYdP9giu9/8Ztz95klBCjK1ezuhTgbgPt6YvgQ4Hun00QpfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744830182; c=relaxed/simple;
	bh=0Idkm9QblI7RGNDqa7yCYmiyNLiWKB4nK2+hylVmDKE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CGVSOTyuDEcLb7gzOjdgfVdfy2CNoTb5aAcc6XqTvNjOdybssPA62Z2Zpi6pc/r2Mt3xOSPvBJFuUYY0kR6LOMtK02F6R2dE/StyjstE0jtmLT2NcnkNLD26XWWH/iEeRHcMrMTbJVGGj2JZOtj9SnaBmlWMjU3kxuV/MJ/JMn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=aDPvWzhZ; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744830181; x=1776366181;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c+alg+7ENI9w4IqfEAHX3KlIVDI2Qsan/wQxF5ERGAk=;
  b=aDPvWzhZMIuSIPIjUTQSY7505aOXOWs4h/G/gW7FkcQek2vaC6jRPH+O
   lmy3hhyUrPgjc9PqCvtCSZ5AWBgQusG6gWYhd/fI+gZmZUHEMS6Y906Ut
   ubm2gqx0tNz7ZnLtOR4U9m4jMkFJRtxVkAz21fu04qPkmOAg9JSy7ktbe
   g=;
X-IronPort-AV: E=Sophos;i="6.15,216,1739836800"; 
   d="scan'208";a="41235422"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2025 19:02:57 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:61834]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.52.33:2525] with esmtp (Farcaster)
 id df164271-368c-40fd-8dd8-d7f4283c3f0c; Wed, 16 Apr 2025 19:02:57 +0000 (UTC)
X-Farcaster-Flow-ID: df164271-368c-40fd-8dd8-d7f4283c3f0c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 19:02:57 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 16 Apr 2025 19:02:54 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 net-next 13/14] ipv6: Protect nh->f6i_list with spinlock and flag.
Date: Wed, 16 Apr 2025 12:02:45 -0700
Message-ID: <20250416190247.2820-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <36c2a487-4f74-4be3-af66-0dadd1538c64@redhat.com>
References: <36c2a487-4f74-4be3-af66-0dadd1538c64@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 16 Apr 2025 17:17:13 +0200
> On 4/14/25 8:15 PM, Kuniyuki Iwashima wrote:
> > @@ -1498,7 +1504,23 @@ int fib6_add(struct fib6_node *root, struct fib6_info *rt,
> >  	}
> >  #endif
> >  
> > -	err = fib6_add_rt2node(fn, rt, info, extack, &purge_list);
> > +	if (rt->nh) {
> > +		spin_lock(&rt->nh->lock);
> > +
> > +		if (rt->nh->dead) {
> > +			NL_SET_ERR_MSG(extack, "Nexthop has been deleted");
> > +			err = -EINVAL;
> > +		} else {
> > +			err = fib6_add_rt2node(fn, rt, info, extack, &purge_list);
> > +			if (!err)
> > +				list_add(&rt->nh_list, &rt->nh->f6i_list);
> > +		}
> 
> Maybe move the new check and list_add inside fib6_add_rt2node() or
> bundle all the above in a new helper?

fib6_add_rt2node() has return in many places, so a new hepler makes
more sense to me.

Will add fib6_add_rt2node_nh() and move spin_lock() section there.

