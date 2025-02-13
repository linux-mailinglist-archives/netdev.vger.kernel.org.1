Return-Path: <netdev+bounces-165861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E33F3A338DF
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:31:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 727183A5388
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29C572054E7;
	Thu, 13 Feb 2025 07:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ka1YaCAM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72EE712BF24;
	Thu, 13 Feb 2025 07:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739431908; cv=none; b=FMiao8w6UrEIkjmEZSYi0yiwL93gtm6YDMsr3JDAmY0y9gAVlDtJtQgqskkmUotAS626xOhMX1y5M6tHLsR7DzEtzGoPSBU8eLul8UA6sl29sMhe/7iMIRfU/Ut3m0XepkQEBDp5OUkf4YhILnusGY6Ft9oZtB7ftpXptunwezY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739431908; c=relaxed/simple;
	bh=8+FssAr70lJCMslOWjqZdSYg92hrmnNPHqjLpPSInGw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tk46gVVrg4hJ4wMXMgzNeqhkUjaK7obsWjDz++25y0BhQCS1H+x0yiEOPOAYddB2CWSzfLrS/jjgp/HgG+QDWyYsdPcK2FlK16yi4LqtVNE2o7tbXCKfwN0lK07ZM3nzIWKInyzVd5/060DbPxgw9DQDmi08qO/LIMPM3HuyEpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ka1YaCAM; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739431906; x=1770967906;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LaRYNqDoAoQPrbgiZ+kPTN92FsPLiTGwS4prScAXRf8=;
  b=ka1YaCAM/cSF2m06TFEIuM3MStG6+LZpP7B0rBPLz7rBiXcyhsTN5LS0
   Nr5UVQHi0h3nVkTTZ/QCP67IP/+bUQq9J9wSd59TkzA1w35iqOBW9SZzJ
   4ZvMQ7lxyO75oL6jO6sxBUrqM+ZnSjXZzwjYurF8Qtv5IpSSmitObx+mT
   E=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="169280811"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 07:31:44 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:19578]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.21.133:2525] with esmtp (Farcaster)
 id b9be1390-ab07-468c-be9e-244f6979c65b; Thu, 13 Feb 2025 07:31:44 +0000 (UTC)
X-Farcaster-Flow-ID: b9be1390-ab07-468c-be9e-244f6979c65b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 07:31:43 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 07:31:38 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <horms@kernel.org>, <kernel-team@meta.com>,
	<kuba@kernel.org>, <kuniyu@amazon.co.jp>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ushankar@purestorage.com>
Subject: Re: [PATCH net-next v3 2/3] net: Add dev_getbyhwaddr_rtnl() helper
Date: Thu, 13 Feb 2025 16:31:29 +0900
Message-ID: <20250213073129.14081-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250212-arm_fix_selftest-v3-2-72596cb77e44@debian.org>
References: <20250212-arm_fix_selftest-v3-2-72596cb77e44@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWC002.ant.amazon.com (10.13.139.222) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

> Subject: [PATCH net-next v3 2/3] net: Add dev_getbyhwaddr_rtnl() helper

s/_rtnl//

looks like Uday's comment was missed due to the lore issue.


From: Breno Leitao <leitao@debian.org>
Date: Wed, 12 Feb 2025 09:47:25 -0800
> +/**
> + *	dev_getbyhwaddr - find a device by its hardware address

While at it, could you replace '\t' after '*' to a single '\s'
for all kernel-doc comment lines below ?


> + *	@net: the applicable net namespace
> + *	@type: media type of device
> + *	@ha: hardware address
> + *
> + *	Similar to dev_getbyhwaddr_rcu(), but the owner needs to hold
> + *	rtnl_lock.

Otherwise the text here is mis-aligned.

  $ ./scripts/kernel-doc -man net/core/dev.c | \
    scripts/split-man.pl /tmp/man && \
    man /tmp/man/dev_getbyhwaddr.9

Also, the latter part should be in Context:

Context: rtnl_lock() must be held.

See https://docs.kernel.org/doc-guide/kernel-doc.html

> + *
> + *	Return: pointer to the net_device, or NULL if not found
> + */
> +struct net_device *dev_getbyhwaddr(struct net *net, unsigned short type,
> +				   const char *ha)

