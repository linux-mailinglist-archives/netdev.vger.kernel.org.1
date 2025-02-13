Return-Path: <netdev+bounces-165962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A78A33CEA
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 11:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 684523A444F
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 10:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B852080DD;
	Thu, 13 Feb 2025 10:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kcgsIF7h"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A141C6A;
	Thu, 13 Feb 2025 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739443573; cv=none; b=pL1piTszIEgDv1zQiwbSaPUZGrDn4w2t0QyJC0sJGRhm1K9d8bk+eqI2+vuk3Cp9j/liIM5hRjL4EyJIBeZDcUqb2+BHHGzS5SYO0eIg5D/rpilxK3lmpEOFxAPJZa7uUiiusUGLVVrKfTx1UNW4yTkt3EaRa1emXuMI9WWp3/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739443573; c=relaxed/simple;
	bh=PRion708stDyzBpzkg+ZHWYiT0IPCeU96XYPIsMRHLA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f5lOztILNf4RbwFbuY+hnJq97N9p+ZixA7RSkdejqwd2KGV8Ekn804J4AaP2Yv0SsXNwGDvo+k1BIMFFAIBT0mzP3ICbLMnHve2DuUNCWPezUGEqcXTt0h8JvZLCvBOVnfkfb7XDw7cHkCiNpU+8reS0HK2+X2FSDT7WRQBl+fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kcgsIF7h; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739443571; x=1770979571;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2T1/qBmI0DiKHiEvUpkWL+IkG1IE3CLB5FcNc97aZNM=;
  b=kcgsIF7hO9fC4e/6wAtM4w7nZRwa4mMhw5wBf5EbbgBssKhvj7vYmj2Z
   tuyckOs0aDbJOCHl4bqjmt7PQ35rfvxnB/6y8wBLTcO/zpddMaU5b7Buk
   kjeZPVp1Y2VbmrKPB15FzFZNMcsAxJPtcFhEJYx5lu3Ru5d4Eu1BD+c5F
   0=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="718442685"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 10:45:48 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:48797]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.32.208:2525] with esmtp (Farcaster)
 id 90872893-0365-47d5-86c4-9357a97ba155; Thu, 13 Feb 2025 10:45:47 +0000 (UTC)
X-Farcaster-Flow-ID: 90872893-0365-47d5-86c4-9357a97ba155
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 10:45:47 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 10:45:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <leitao@debian.org>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <dsahern@kernel.org>,
	<edumazet@google.com>, <horms@kernel.org>, <kernel-team@meta.com>,
	<kuba@kernel.org>, <kuniyu@amazon.co.jp>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <ushankar@purestorage.com>
Subject: Re: [PATCH net-next v3 1/3] net: document return value of dev_getbyhwaddr_rcu()
Date: Thu, 13 Feb 2025 19:45:31 +0900
Message-ID: <20250213104531.36861-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250213-kickass-orchid-wildebeest-3ec3ae@leitao>
References: <20250213-kickass-orchid-wildebeest-3ec3ae@leitao>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWA003.ant.amazon.com (10.13.139.43) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Breno Leitao <leitao@debian.org>
Date: Thu, 13 Feb 2025 02:16:36 -0800
> Hello Kuniyuki,
> 
> On Thu, Feb 13, 2025 at 04:47:48PM +0900, Kuniyuki Iwashima wrote:
> > From: Kuniyuki Iwashima <kuniyu@amazon.com>
> > Date: Thu, 13 Feb 2025 16:36:46 +0900
> > > From: Breno Leitao <leitao@debian.org>
> > > Date: Wed, 12 Feb 2025 09:47:24 -0800
> > > > diff --git a/net/core/dev.c b/net/core/dev.c
> > > > index d5ab9a4b318ea4926c200ef20dae01eaafa18c6b..0b3480a125fcaa6f036ddf219c29fa362ea0cb29 100644
> > > > --- a/net/core/dev.c
> > > > +++ b/net/core/dev.c
> > > > @@ -1134,8 +1134,8 @@ int netdev_get_name(struct net *net, char *name, int ifindex)
> > > >   *	The returned device has not had its ref count increased
> > > >   *	and the caller must therefore be careful about locking
> > > >   *
> > > > + *	Return: pointer to the net_device, or NULL if not found
> > > >   */
> > > 
> I am a bit confused about what you are saying.
> > > I noticed here we still mention RTNL and it should be removed.
> 
> I have no mention RTNL in this patch at all:

Yes, and patch 2 removes the part from kernel-doc of
dev_getbyhwaddr_rcu().


> 
> 	# git log -n1 --oneline HEAD~2
> 	6d34fd4700231 net: document return value of dev_getbyhwaddr_rcu()
> 	# git show  HEAD~2  | grep -i rtnl
> 
> > I missed this part is removed in patch 2, but the Return: part
> > is still duplicate.
> 
> This part is also unclear to me. What do you mean the "Return:" part is
> still duplicated?
> 
> This is how the documentation looks like, after the patch applied:
> 
> 	/**
> 	*      dev_getbyhwaddr_rcu - find a device by its hardware address
> 	*      @net: the applicable net namespace
> 	*      @type: media type of device
> 	*      @ha: hardware address
> 	*
> 	*      Search for an interface by MAC address. Returns NULL if the device
                                                       ^^^^^^^
Sorry, I meant this part is redundant as we have Return: now.


> 	*      is not found or a pointer to the device.
> 	*      The caller must hold RCU.
> 	*      The returned device has not had its ref count increased
> 	*      and the caller must therefore be careful about locking
> 	*
> 	*      Return: pointer to the net_device, or NULL if not found
> 	*/
> 	struct net_device *dev_getbyhwaddr_rcu(struct net *net, unsigned short type,
> 						const char *ha)
> 	{
> 		<snip>
> 	}

