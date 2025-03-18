Return-Path: <netdev+bounces-175951-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6146A680E8
	for <lists+netdev@lfdr.de>; Wed, 19 Mar 2025 00:52:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E2993A3E49
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E102207A2C;
	Tue, 18 Mar 2025 23:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Q4rV6yv2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79CB51C5F2C
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 23:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742341941; cv=none; b=Ud9kTQ7acVpnMsFD31QucHNJYxjq50BDk/X92ovqOG2YMazizIUz7n0pEyYQjQymev2sGs1kJUBPs1QxK0RvB6uWFQO/H+BKIevtr0MeW/Ue2UwcPGN4BS9nRi9PREZVDX0H6IBYhcCaC3nKvNmbUE/PRZQhOMKgjOodv1njOrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742341941; c=relaxed/simple;
	bh=fS+xgsu3JIQzDn0IHsFH9pgwubgRfqWG3ohTsyusGhM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m2UzVOxFHJLvXmSG5yZ1aeK+j3PRr71x89rGCGRIqmywLikv4HucLO0lDtrX0FfcAS48QKeoAJ1ck32RJYzWVVU2coeWZ11LXEGe49inKHZF8FDHP44t2NLGONSD04ebcklg92d4+gakVsqq9oHRumnjOLhnA6UxQVPR16PmIfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Q4rV6yv2; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742341940; x=1773877940;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=B3xJs9WSL+v4LVD8HMR6EEdG0OydoHDPePmfDVnoavM=;
  b=Q4rV6yv2iVArrx44RMaLwLgkhAF/4HyRRhqBeiJE8GOEGFSnUcEaYKMm
   JIMselb6n5D/By4h98UCj9/sQPmeY9KX2NnMTjCW9kR3mgwqG7LfN5Vc/
   CuBwzIYO29YRjOXkxYNUAwtTSFuWV2JefL9+Wyc4PzRi9+X43f4NVrrIi
   Q=;
X-IronPort-AV: E=Sophos;i="6.14,258,1736812800"; 
   d="scan'208";a="179804447"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 23:52:18 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:2760]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.9.151:2525] with esmtp (Farcaster)
 id d99b7bbd-9507-4919-95fa-c1dc1da4fac7; Tue, 18 Mar 2025 23:52:18 +0000 (UTC)
X-Farcaster-Flow-ID: d99b7bbd-9507-4919-95fa-c1dc1da4fac7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:52:18 +0000
Received: from 6c7e67bfbae3.amazon.com (10.135.212.115) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 18 Mar 2025 23:52:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <jdamato@fastly.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v1 net-next 1/4] af_unix: Sort headers.
Date: Tue, 18 Mar 2025 16:50:00 -0700
Message-ID: <20250318235208.57089-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <Z9n8w-6nXiBUI20T@LQ3V64L9R2>
References: <Z9n8w-6nXiBUI20T@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWC003.ant.amazon.com (10.13.139.217) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Joe Damato <jdamato@fastly.com>
Date: Tue, 18 Mar 2025 16:07:47 -0700
> > +#include <linux/in.h>
> >  #include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/mount.h>
> > +#include <linux/namei.h>
> > +#include <linux/net.h>
> > +#include <linux/netdevice.h>
> >  #include <linux/poll.h>
> > +#include <linux/proc_fs.h>
> >  #include <linux/rtnetlink.h>
> > -#include <linux/mount.h>
> > -#include <net/checksum.h>
> > +#include <linux/sched/signal.h>
> 
> Not sure what the sorting rules are, but I was wondering if maybe
> "linux/sched/*.h" should come after linux/*.h and not sorted within
> linux/s*.h ?

It's simply sorted in the alphabetial order.

Actually I haven't cared about the / level, so I grepped the
linux/sched/signal.h users and it looks like most didn't care.

  grep -rnI --include=*.c --include=*.h "linux/sched/signal.h" -C 3

Thanks!

