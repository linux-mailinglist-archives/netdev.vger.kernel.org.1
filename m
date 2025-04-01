Return-Path: <netdev+bounces-178692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 132AFA7846B
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 00:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B4CF188F5CD
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 22:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB5E01EF38D;
	Tue,  1 Apr 2025 22:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rIAENsH1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAA9204F6B
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743545274; cv=none; b=IeWFRSf5LOADaaBuEKqBiJKm4ok0EdBq/E4Ou061Ftqo8jIJ6rXhPOAINncRTpUV+UjooJrHWyFaIITe5xkktl0onM66VUU/gpyYeuRwjbY/nkVaYSJ9zEL/YwtY0P/MmnxDWdXGdGYF4WvTdi0G+ptiOD+hM6CBdMoHk0y7DSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743545274; c=relaxed/simple;
	bh=pcqc271B1l/l+ufKii9W2uOVZz+e0tuJuoEswtZmug0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NEIhFYkpVAmV1JE4+YhWxfScpxDjZIlViEzCniH1H69K9K6fdABz57mt+sN8hN5aSJ95F3ywy3MR/+W5XL1en+JG0S4bLzf6l7dyC562TheTZVmyN/ct2PHp154dyonKNry09SL2oWeX+5J5BOlidE7tKo/CmeDkgugznc88x1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rIAENsH1; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743545273; x=1775081273;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Qt0cyWO4RRlXdWAq9sUZJmpz890D/YFYDA2iykeu0Q=;
  b=rIAENsH122OGvjxLglV24I3tZSZvD9Ww3zuGSNUbVjjuBvK3wd86AGLR
   cKEXn/P+VHwd3nE/uBRB/j/dAdRkJgx5JyIDmymrNC21F+cUc/z343Gxr
   fuPpBLHzDwmFeOaIU8hFmsU+7simtAVsrd6EAduUwV/ikbls89NLlDGRU
   4=;
X-IronPort-AV: E=Sophos;i="6.14,294,1736812800"; 
   d="scan'208";a="6558031"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 22:07:47 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:17887]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.18:2525] with esmtp (Farcaster)
 id d613934f-3d28-417c-ac22-07c6c87e8e02; Tue, 1 Apr 2025 22:07:46 +0000 (UTC)
X-Farcaster-Flow-ID: d613934f-3d28-417c-ac22-07c6c87e8e02
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 1 Apr 2025 22:07:46 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.43.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 1 Apr 2025 22:07:43 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <ychemla@nvidia.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v5 net 2/3] net: Fix dev_net(dev) race in unregister_netdevice_notifier_dev_net().
Date: Tue, 1 Apr 2025 14:58:40 -0700
Message-ID: <20250401220735.94909-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <6ce063ee-85cc-4930-839a-36b3155c9820@nvidia.com>
References: <6ce063ee-85cc-4930-839a-36b3155c9820@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D044UWA001.ant.amazon.com (10.13.139.100) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Hi Yael,

Thanks for testing!

From: Yael Chemla <ychemla@nvidia.com>
Date: Tue, 1 Apr 2025 23:49:42 +0300
> Hi Kuniyuki,
> Sorry for the delay (I was OOO). I tested your patch, and while the race
> occurs much less frequently, it still happens—see the warnings and call
> traces below.
> Additionally, in some cases, the test which reproduce the race hang.
> Debugging shows that we're stuck in an endless loop inside
> rtnl_net_dev_lock because the passive refcount is already zero, causing
> net_passive_inc_not_zero to return false, thus it go to "again" and this
> repeats without ending.
> I suspect, as you mentioned before, that in such cases, the passive
> refcount was decreased from cleanup_net.

This sounds weird.

We assumed vif will be moved to init_net, then the infinite loop
should never happen.

So the assumption was wrong and vif belonged to the dead netns and
was not moved to init_net ... ??

Even if dev_change_net_namespace() fails, it leads to BUG().

> 
> 
> warnings and call traces:
> 
> refcount_t: addition on 0; use-after-free.

I guess this is from the old log or the test patch was not applied
because _inc_not_zero() will trigger REFCOUNT_ADD_NOT_ZERO_OVF and
then the message will be

  refcount_t: saturated; leaking memory

, see __refcount_add_not_zero() and refcount_warn_saturate().


> WARNING: CPU: 4 PID: 27219 at lib/refcount.c:25 refcount_warn_saturate
> (/usr/work/linux/lib/refcount.c:25 (discriminator 1))

