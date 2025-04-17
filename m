Return-Path: <netdev+bounces-183869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C99A924C1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 19:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF0E9464367
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B18925744D;
	Thu, 17 Apr 2025 17:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XWybGd7e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AE61A3178
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 17:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744912487; cv=none; b=ZWqC1J0ls9CKojPTwFHG2Kw7QaTnQGKaoe2g0oWQUIIBzEmKfDkjzS1Rx+27YoOLRwTwat9k7IuQ3c3zrTZ0FFSrhpvBfnd2lvCNLfE6YiUyEV7EF/TwX3kw/k2q3qpPi6h7eaCkzt5kzR2Q6q1MCw2WaGHHPU46RhNdrq5wHns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744912487; c=relaxed/simple;
	bh=ui0C3d1KV0pQaIFaP36I5F8Lvf3qI5gOdfoWGl8ZUug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uu/OEpOdeIq/11MKZ8wXyZtTgUfLyPV5WWU6xX0wteFM4c9xMd2wgku5u2ad+mgLgv+zzjIJSBXFPOWf86X5U+dYXydCEzKavPQI9Bei0AV42cQ/MOKJFV8d0AfdXNrJsJgp/PWWmZHk8MYqZYOVqHk0PMH0fjA5jMVO2fYeEUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XWybGd7e; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1744912486; x=1776448486;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=GhWcykuWa9M756ri7qcp9PYFKr2Y0nYygDMfzUHwowg=;
  b=XWybGd7e6HDX+eX+j+LWs0i5ll4D8ajKlWWh7D4lv4GS6fBNVwD5Y1iX
   x62tkF/qMRe89OVSJuV3Bi+v0lJK2zBdhdp29qg3hfGc6ZNbMcdXDkp7x
   SCCb7+Q2btDtgQE82PGy0OdIbzFjrlCCLhtQjJ2dzU1FCRXawkK1CWF7W
   Y=;
X-IronPort-AV: E=Sophos;i="6.15,219,1739836800"; 
   d="scan'208";a="512425255"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2025 17:53:32 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:13757]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.47.20:2525] with esmtp (Farcaster)
 id 3cf9751c-32b1-4134-b361-bb85a319fa3f; Thu, 17 Apr 2025 17:53:31 +0000 (UTC)
X-Farcaster-Flow-ID: 3cf9751c-32b1-4134-b361-bb85a319fa3f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 17:53:28 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.49.59) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 17 Apr 2025 17:53:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <pabeni@redhat.com>
CC: <davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<horms@kernel.org>, <kuba@kernel.org>, <kuni1840@gmail.com>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>
Subject: Re: [PATCH RESEND v2 net-next 01/14] ipv6: Validate RTA_GATEWAY of RTA_MULTIPATH in rtm_to_fib6_config().
Date: Thu, 17 Apr 2025 10:53:15 -0700
Message-ID: <20250417175318.68220-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <37b0cc42-69ea-42bf-b4d8-304cba0d2dd3@redhat.com>
References: <37b0cc42-69ea-42bf-b4d8-304cba0d2dd3@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC002.ant.amazon.com (10.13.139.196) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Paolo Abeni <pabeni@redhat.com>
Date: Wed, 16 Apr 2025 10:22:33 +0200
> > +static int rtm_to_fib6_multipath_config(struct fib6_config *cfg,
> > +					struct netlink_ext_ack *extack)
> > +{
> > +	struct rtnexthop *rtnh;
> > +	int remaining;
> > +
> > +	remaining = cfg->fc_mp_len;
> > +	rtnh = (struct rtnexthop *)cfg->fc_mp;
> > +
> > +	if (!rtnh_ok(rtnh, remaining)) {
> > +		NL_SET_ERR_MSG(extack, "Invalid nexthop configuration - no valid nexthops");
> > +		return -EINVAL;
> > +	}
> > +
> > +	do {
> 
> I think the initial checks and the loop could be rewritten reducing the
> indentation and calling the helper only once with something alike:
> 
> 	for (i = 0; rtnh_ok(rtnh, remaining);
> 	     i++, rtnh = rtnh_next(rtnh, &remaining)) {
> 		int attrlen = rtnh_attrlen(rtnh);
> 		if (!attrlen)
> 			continue;
> 		
> 		// ...
> 	}
> 	if (i == 0) {
> 		NL_SET_ERR_MSG(extack, "Invalid nexthop configuration - no valid
> nexthops");
> 		// ..
> 
> I guess it's a bit subjective, don't repost just for this.

I couldn't reduce the nest due to patch 4, so I'll keep this as is.

Thanks!

