Return-Path: <netdev+bounces-116690-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AE3B94B5F9
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 06:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0B76AB21710
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 04:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA38C2E400;
	Thu,  8 Aug 2024 04:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EUzPzas7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F91EBA3F
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 04:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723092330; cv=none; b=YywqqFfSgZPNqlh0TxA0swJ17lcdHGHKUku4SZOe2sIn6KEmOqtDHazDDF03hTihRmJday6cHVZf+x3crWzWgBo3o/d+JG7AZQbQwicmi0P7AnNhr8V9jeryVxFA3pSXfhLzQ5LgqVprbi0p6OEXVR3L3rIUHhlmDjmzveZ/SmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723092330; c=relaxed/simple;
	bh=tteIP/nQrSVflOrI7qFAg7RHiK3RF74Psvxbh5GXdrI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CWBkfSZGxuMl7wve8bRpS+p2s1Xsl78R7Ez41VoiBoXt5BP5Nq98AhpBiQK2FChqC31dIjugoegoK/BCBW0Nq7jw/Bb3dQEpbQMtHViVC5JDzRlUjoBjhwvrIHtkkCSinaTx1M+ZE7soJxEOLlZsL/+i8bFOKCIme2tpXt2C4uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EUzPzas7; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723092329; x=1754628329;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=veGOd6bM62X/hnwNsf2+7yOQByT67Ubh8iWpURtZ+cw=;
  b=EUzPzas7A3v3vKRXx29otq5wDQybNXNE9lgozqyGkfAJLUAwnK65fn25
   ess+9XgyvFyER6BACeIcazp5NFkk4P2pnzQIAi2yGrwIJYaVGSWgwXdPL
   TnZKZCguUQMRWHUI0bU4POadVXcrfXGG6LGsr+pUMJ2owfUrb5c3MhivT
   4=;
X-IronPort-AV: E=Sophos;i="6.09,271,1716249600"; 
   d="scan'208";a="319114421"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2024 04:45:27 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:50001]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.15.23:2525] with esmtp (Farcaster)
 id 3d91cd81-c5d1-4fd2-a50b-dd7406a8a140; Thu, 8 Aug 2024 04:45:26 +0000 (UTC)
X-Farcaster-Flow-ID: 3d91cd81-c5d1-4fd2-a50b-dd7406a8a140
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 8 Aug 2024 04:45:26 +0000
Received: from 88665a182662.ant.amazon.com (10.135.210.149) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 8 Aug 2024 04:45:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <vineeth.karumanchi@amd.com>
CC: <claudiu.beznea@tuxon.dev>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <nicolas.ferre@microchip.com>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net] net: macb: Use rcu_dereference() for idev->ifa_list in macb_suspend().
Date: Wed, 7 Aug 2024 21:45:15 -0700
Message-ID: <20240808044516.12826-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <7a61eaff-3ea4-4eba-a11f-7c4caaef45dd@amd.com>
References: <7a61eaff-3ea4-4eba-a11f-7c4caaef45dd@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Date: Thu, 8 Aug 2024 09:53:42 +0530
> Hi Kuniyuki,
> 
> On 08/08/24 9:30 am, Kuniyuki Iwashima wrote:
> > In macb_suspend(), idev->ifa_list is fetched with rcu_access_pointer()
> > and later the pointer is dereferenced as ifa->ifa_local.
> > 
> > So, idev->ifa_list must be fetched with rcu_dereference().
> > 
> 
> Is there any functional breakage ?

rcu_dereference() triggers lockdep splat if not called under
rcu_read_lock().

Also in include/linux/rcupdate.h:

/**
 * rcu_access_pointer() - fetch RCU pointer with no dereferencing
...
 * It is usually best to test the rcu_access_pointer() return value
 * directly in order to avoid accidental dereferences being introduced
 * by later inattentive changes.  In other words, assigning the
 * rcu_access_pointer() return value to a local variable results in an
 * accident waiting to happen.


> I sent initial patch with rcu_dereference, but there is a review comment:
> 
> https://lore.kernel.org/netdev/a02fac3b21a97dc766d65c4ed2d080f1ed87e87e.camel@redhat.com/ 

I guess the following ifa_local was missed then ?

