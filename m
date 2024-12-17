Return-Path: <netdev+bounces-152506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE7B9F45A6
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 09:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47FF97A2944
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 08:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97969189B8F;
	Tue, 17 Dec 2024 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ox78WzTc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A915288A2;
	Tue, 17 Dec 2024 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734422629; cv=none; b=F/OT71OUFvF8AnjBCD6wx48WZ27IsgIg3RHXwI5X7EpCq2SYI8inYqpp537fJP0yeNZ5afb5kY3o9QAJ3CPQ/pSEmY6P+WiN7hgvCksXOeNG9a32KaVjes7PykqhL8Xy1NHnoKoQ7VORZg4f1M9AXL+FBSo2lGzx1iSER3dmOx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734422629; c=relaxed/simple;
	bh=HBOqlzoNZQCn5KZBuEwkdzSgAUZkRu/FOER7HVP4z1c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cMN2PgvP97crIncuBBoezlFGL6OEfQwycfjSxZu+YEUjBvxHwbvhnmtC4J8a+t4irjK/HvUSHEy+oZ5Lbhlb9UxCrdsMGyWqsC29PuZ+eDviuRAT02K7ThKsczjAVx03jfLH03McuW7ppic6JqRRhpS/S1lb8P4vFugQL21Cmbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ox78WzTc; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734422627; x=1765958627;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OAqSOfGousZ0wKCZPnMq9ctK4gGgJ8+Vds0fKM2Wsic=;
  b=ox78WzTcxSKvtk/+bTLI/GgzC3LAiZlAXKXimon7sVgwR2Rl5wdVU+1A
   ztOTkrs7HqGHjw4hT5guA7PyVBaNZwkhp5Wiu4bVBkFVoMD/yrrUkSYfg
   5z3V6k/TBC4kF4jbHEzPG9QhC0L+7O+rKlWIsiurvOWdM1jkJ9xT8dLZF
   M=;
X-IronPort-AV: E=Sophos;i="6.12,241,1728950400"; 
   d="scan'208";a="681978134"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Dec 2024 08:03:43 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:23925]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.151:2525] with esmtp (Farcaster)
 id 3b3ba6aa-e300-41b5-a05f-87db24ab3e07; Tue, 17 Dec 2024 08:03:43 +0000 (UTC)
X-Farcaster-Flow-ID: 3b3ba6aa-e300-41b5-a05f-87db24ab3e07
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 08:03:42 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.246.225) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Tue, 17 Dec 2024 08:03:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kees@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<idosch@nvidia.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-hardening@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <petrm@nvidia.com>
Subject: Re: [PATCH] rtnetlink: do_setlink: Use true struct sockaddr
Date: Tue, 17 Dec 2024 17:03:35 +0900
Message-ID: <20241217080335.85554-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <36C08CAB-1D3A-46CE-BCE2-820605E222CF@kernel.org>
References: <36C08CAB-1D3A-46CE-BCE2-820605E222CF@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kees Cook <kees@kernel.org>
Date: Mon, 16 Dec 2024 23:53:46 -0800
> On December 16, 2024 6:41:56 PM PST, Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >From: Kees Cook <kees@kernel.org>
> >Date: Mon, 16 Dec 2024 18:04:45 -0800
> >> Instead of a heap allocation use a stack allocated struct sockaddr, as
> >> dev_set_mac_address_user() is the consumer (which uses a classic
> >> struct sockaddr).
> >
> >I remember Eric's feedback was to keep using heap instead of stack
> >because rtnl_newlink() path already uses too much on stack.
> 
> See below...
> 
> >
> >
> >> Cap the copy to the minimum address size between
> >> the incoming address and the traditional sa_data field itself.
> >> 
> >> Putting "sa" on the stack means it will get a reused stack slot since
> >> it is smaller than other existing single-scope stack variables (like
> >> the vfinfo array).
> 
> That's why I included the rationale above. (I.e. stack usage does not grow with this patch.)

Ah okay, but I think we can't cap the address size to 14
bytes.  MAX_ADDR_LEN is 32.

Also, dev_set_mac_address_user() still uses dev->addr_len.


> 
> -Kees
> 
> >> 
> >> Signed-off-by: Kees Cook <kees@kernel.org>
> >> ---
> >> Cc: Eric Dumazet <edumazet@google.com>
> >> Cc: "David S. Miller" <davem@davemloft.net>
> >> Cc: Jakub Kicinski <kuba@kernel.org>
> >> Cc: Paolo Abeni <pabeni@redhat.com>
> >> Cc: Ido Schimmel <idosch@nvidia.com>
> >> Cc: Petr Machata <petrm@nvidia.com>
> >> Cc: netdev@vger.kernel.org
> >> ---
> >>  net/core/rtnetlink.c | 22 +++++++---------------
> >>  1 file changed, 7 insertions(+), 15 deletions(-)
> >> 
> >> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> >> index ab5f201bf0ab..6da0edc0870d 100644
> >> --- a/net/core/rtnetlink.c
> >> +++ b/net/core/rtnetlink.c
> >> @@ -3048,21 +3048,13 @@ static int do_setlink(const struct sk_buff *skb, struct net_device *dev,
> >>  	}
> >>  
> >>  	if (tb[IFLA_ADDRESS]) {
> >> -		struct sockaddr *sa;
> >> -		int len;
> >> -
> >> -		len = sizeof(sa_family_t) + max_t(size_t, dev->addr_len,
> >> -						  sizeof(*sa));
> >> -		sa = kmalloc(len, GFP_KERNEL);
> >> -		if (!sa) {
> >> -			err = -ENOMEM;
> >> -			goto errout;
> >> -		}
> >> -		sa->sa_family = dev->type;
> >> -		memcpy(sa->sa_data, nla_data(tb[IFLA_ADDRESS]),
> >> -		       dev->addr_len);
> >> -		err = dev_set_mac_address_user(dev, sa, extack);
> >> -		kfree(sa);
> >> +		struct sockaddr sa = { };
> >> +
> >> +		/* dev_set_mac_address_user() uses a true struct sockaddr. */
> >> +		sa.sa_family = dev->type;
> >> +		memcpy(sa.sa_data, nla_data(tb[IFLA_ADDRESS]),
> >> +		       min(dev->addr_len, sizeof(sa.sa_data_min)));
> >> +		err = dev_set_mac_address_user(dev, &sa, extack);
> >>  		if (err)
> >>  			goto errout;
> >>  		status |= DO_SETLINK_MODIFIED;
> >> -- 
> >> 2.34.1
> >
> 
> -- 
> Kees Cook

