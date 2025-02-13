Return-Path: <netdev+bounces-166016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BE97A33EF6
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 13:19:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D48D0163133
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 12:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F062207E01;
	Thu, 13 Feb 2025 12:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YwfNkwZI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41BE1227EB4
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 12:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739449158; cv=none; b=NXCAy4xe2fV6Qnb+abqYAPxtye3Bb9M1bZIc9CQGa9sUI/Qvz5ZR2JuAUXMxF+soTBh4R8xdiQt69Dvmt7QtemkrcC7C1G/g2RHDYKdIHZZTCTjEEneb9PuLsoMFWWa9HOsMmwi5GgozReHIBLNwo8KkJyhzTgT0AvZirn9Fyns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739449158; c=relaxed/simple;
	bh=DqyLEvKLR1E2gjJqYqvWjB7bC01hmGEVHAlAY5R6heg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rT1G954lzk1IVGO/9oQ3q0SBnxGCVmNTp2l6HNmq9rhmjoa5F4RrybSdw8qgHGpc/S/IKvgDtDm0BQoUdB8IcrW3xPx6plXHm8upBjbqsgwPfwqY2Mwi8uG7yKaWe9/5cDczYQh+VO3xhMXXcgBe5PTCPyVfI3odeE8a/YYCaGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YwfNkwZI; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739449157; x=1770985157;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZKfDiI5wEf6ZKwas+URfenYGxZh8583KgqMK9vnsKUs=;
  b=YwfNkwZIcZBHO8aU7WaOq6KOhFKUn+s0hDPquGDO8SBJcJot4EEMBKLE
   zgLzMOusp3Kbp5TsrZD/CJFLufGvzwU/pAzBOCiGOkoM29iQ01V5EmZOb
   W132tFOLJ3zpk3I5T0549VKD60MiRVdz5pIDhqaiuqwOaIyBV2TLBAS/S
   4=;
X-IronPort-AV: E=Sophos;i="6.13,282,1732579200"; 
   d="scan'208";a="471837502"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2025 12:19:11 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:62067]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.115:2525] with esmtp (Farcaster)
 id efa84f22-6eeb-40cc-bb09-089902c7c924; Thu, 13 Feb 2025 12:19:10 +0000 (UTC)
X-Farcaster-Flow-ID: efa84f22-6eeb-40cc-bb09-089902c7c924
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 13 Feb 2025 12:19:03 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Feb 2025 12:18:57 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuniyu@amazon.com>
CC: <apw@canonical.com>, <davem@davemloft.net>, <dwaipayanray1@gmail.com>,
	<edumazet@google.com>, <horms@kernel.org>, <joe@perches.com>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <lukas.bulwahn@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next] checkpatch: Discourage a new use of rtnl_lock() variants.
Date: Thu, 13 Feb 2025 21:18:46 +0900
Message-ID: <20250213121846.57655-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250213121028.48711-1-kuniyu@amazon.com>
References: <20250213121028.48711-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Kuniyuki Iwashima <kuniyu@amazon.com>
Date: Thu, 13 Feb 2025 21:10:28 +0900
> > Also I'm unsure if the '^\+.*' header is strictly required - it should
> > but some/most existing tests don't use it, do you know why?
> 
> I didn't notice but exactly, the following matches only + line.
> 
>   if ($line =~ /\brtnl_(try)?lock(_interruptible|_killable)?\s*\(\)/) {
> 
> Looks like the '-' diff is filtered, matching '-' doesn't make sense.
> 
> This function looks suspicious ? (maybe wrong, I'm not familiar with perl)

I was wrong, this part did the filtering :)

---8<---
#ignore lines not being added
                next if ($line =~ /^[^\+]/);
---8<---

