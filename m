Return-Path: <netdev+bounces-165869-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E192A3392C
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 08:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA16D165E23
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 07:48:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D035D207A14;
	Thu, 13 Feb 2025 07:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ta7wYWH/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B162BA2D;
	Thu, 13 Feb 2025 07:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739432887; cv=none; b=tu7paVI/6pNkc+47imMVT6S3rw6C+8v/3ORjToCbetxdEBJqvilJtWXQ0eqASl3LnMR6IuaF3eD5jSpYMWyAFP/Dc6v3PM+U9xEcnSCdOqA6+30W4aHn3/BNrsRdq7ZboUpxWyq/ScFtKE2JK0i1Z9wD3R9TrLIStZYOi4VKSjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739432887; c=relaxed/simple;
	bh=dhAj+kXaTDh6GRxeXB3ePgoHwZ6bN1ob6iqWi2XoFFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sN6aokGMw4zSFtv2eKIlIROt2jUe7CGPHdeph6D23qD+GhsiQ3gJ1/0nGBG/IAQ0MzTC1JjDjn+Hm/8KsiE/c6RF8+nwzjR5K/JCF2t2m6pyEDjBm5g+qfMhiOCiid86tj9LoZnzL0f9CDDQ80sdGZp6eVzcAY+yAuJejb6Nukg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ta7wYWH/; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739432886; x=1770968886;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gMGZnrkj1PsBzrRBaQa/AOARDe2r9siZ+blzTwbHXc8=;
  b=ta7wYWH/uVNakP8KZedwtb9yXl7JP6t+9ahatgSejvRpSHKefwYroUT5
   mgYsQ59zZn28p25lDtfB95qrVfm090dBnHacvmuhHcOk9TZ3YKA6pIs3G
   zlwvGQ/an4X5A2HWpaCnyjHoX0Eqo4R2Be3p+YR4I0qylgciN297pVqQz
   w=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="169283745"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 07:48:05 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:21723]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.187:2525] with esmtp (Farcaster)
 id 4f82d4bf-d41e-457b-8d40-10c81143e6ba; Thu, 13 Feb 2025 07:48:05 +0000 (UTC)
X-Farcaster-Flow-ID: 4f82d4bf-d41e-457b-8d40-10c81143e6ba
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 07:48:02 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 07:47:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <horms@kernel.org>, <kernel-team@meta.com>,
	<kuba@kernel.org>, <kuniyu@amazon.co.jp>, <leitao@debian.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ushankar@purestorage.com>
Subject: Re: [PATCH net-next v3 1/3] net: document return value of dev_getbyhwaddr_rcu()
Date: Thu, 13 Feb 2025 16:47:48 +0900
Message-ID: <20250213074748.16001-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250213073646.14847-1-kuniyu@amazon.com>
References: <20250213073646.14847-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Thu, 13 Feb 2025 16:36:46 +0900
> From: Breno Leitao <leitao@debian.org>
> Date: Wed, 12 Feb 2025 09:47:24 -0800
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index d5ab9a4b318ea4926c200ef20dae01eaafa18c6b..0b3480a125fcaa6f036ddf219c29fa362ea0cb29 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -1134,8 +1134,8 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
> >   *	The returned device has not had its ref count increased
> >   *	and the caller must therefore be careful about locking
> >   *
> > + *	Return: pointer to the net_device, or NULL if not found
> >   */
> 
> I noticed here we still mention RTNL and it should be removed.

I missed this part is removed in patch 2, but the Return: part
is still duplicate.

