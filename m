Return-Path: <netdev+bounces-174775-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 275E8A60499
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 23:44:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 660E3179C41
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 22:44:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E791F790F;
	Thu, 13 Mar 2025 22:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bxouhzuz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62B21F426F;
	Thu, 13 Mar 2025 22:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741905873; cv=none; b=RNo4syAp04moNjYheSXAT+XVcqza4c6BkGPVDAvyya3Nu8hYHeyeo9/3ZxY+5l6zm8SaWdV2bqlzh5HG/ZMrb+RnDVe4T9yr13zV6a0e6FTiPs5Cyx15qbqLESBxl2+uhEaTRxOdYjwy2hKB4ZHCRd3SFPUr/1s1ykJb/22slK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741905873; c=relaxed/simple;
	bh=MxRtD3K0VYD0WwkRDlCQHlSfNJ6Mekz5X2R3NT5flNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d7Xq80Pa4jnFbN87G0YLZaoB7wWeQEZ9JsMGi97YwTQgkZ6aSirqRhV0OByWq4UcIUTQYVtd6m7uBOCaaQGbTmqL9gkJqxWmOAAnMtwMAafgdjzzmMupRq7XBrcd0zET+yv27uAPFPixRl6GhxZDYkNW3H+d/mh4uLIvSo+KVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bxouhzuz; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1741905872; x=1773441872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=u0qX6UC7IOIJfm7M210IpWYiJIykCaspPvAT0hqf9Vs=;
  b=bxouhzuzcFIbW8B5753FtckYSfDm/tRyzJQMtD6Uu48o1s0NBjR+fpGR
   K4gXggBcNhPLkLW7DeVmYRheN0LX0LLxATnYhB3iiNrlPgRwk5it50Gcl
   K9DIeSUQjqYpuAP7LacDjUNdPwyNG+9Qv5hPgcBCWifHZ9Z/fwTpo9wwo
   E=;
X-IronPort-AV: E=Sophos;i="6.14,245,1736812800"; 
   d="scan'208";a="480264924"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Mar 2025 22:44:27 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:2568]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.18.34:2525] with esmtp (Farcaster)
 id c2f65031-ac34-44fe-9948-982f3bb7760f; Thu, 13 Mar 2025 22:44:26 +0000 (UTC)
X-Farcaster-Flow-ID: c2f65031-ac34-44fe-9948-982f3bb7760f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 22:44:26 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.242.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 13 Mar 2025 22:44:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kangyan91@outlook.com>
CC: <aleksander.lobakin@intel.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <florian.fainelli@broadcom.com>, <horms@kernel.org>,
	<kory.maincent@bootlin.com>, <kuba@kernel.org>, <kuniyu@amazon.com>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller@googlegroups.com>
Subject: Re: unregister_netdevice: waiting for DEV to become free [unbalanced refcount bug in dev_ifsioc]
Date: Thu, 13 Mar 2025 15:44:06 -0700
Message-ID: <20250313224415.60894-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <SY8P300MB0421225D54EB92762AE8F0F2A1D32@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
References: <SY8P300MB0421225D54EB92762AE8F0F2A1D32@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC003.ant.amazon.com (10.13.139.209) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: YAN KANG <kangyan91@outlook.com>
Date: Thu, 13 Mar 2025 16:18:22 +0000
> I have repro to trigger it.

FTR, I think the attached prog is not a repro by itself.

> ...
>
> Syzkaller reproducer:
> # {Threaded:false Repeat:true RepeatTimes:0 Procs:4 Slowdown:1 Sandbox: SandboxArg:0 Leak:false NetInjection:false NetDevices:false NetReset:false

This syz prog does not unshare() nor create necessary devices.
Someone must create a bridge and another device.


> r0 = syz_init_net_socket$nl_generic(0x10, 0x3, 0x10)
> ioctl$sock_SIOCGIFINDEX_802154(r0, 0x89a2, &(0x7f0000000a80)={'wpan3\x00'})
> r1 = syz_init_net_socket$nl_generic(0x10, 0x3, 0x10)
> ioctl$sock_SIOCGIFINDEX_802154(r1, 0x89a0, &(0x7f0000000a80)={'wpan3\x00'})
> r2 = syz_init_net_socket$nl_generic(0x10, 0x3, 0x10)
> ioctl$sock_SIOCGIFINDEX_802154(r2, 0x89a1, &(0x7f0000000a80)={'wpan3\x00'})

0x89a1 is SIOCBRDELBR, and wpan3 is the name of the bridge dev, which
looks correct from this line.

> unregister_netdevice: waiting for wpan3 to become free. Usage count = 2

But apparently SIOCBRDELIF (0x89a3) is missing in the repro, so
there must be another prog running that adds and removes a dev
to wpan3.

When you share a repro, please make sure it's standalone.


> I GET backtrace for panic by gdb
> (gdb) bt
> #0  netdev_wait_allrefs_any (list=0xffffc9001bfa7bc8) at net/core/dev.c:11151

Also, this should not panic.

Under RTNL pressure, the SIOCBRDELIF's thread may not be able to acquire
RTNL and complete SIOCBRDELIF, then netdev_wait_allrefs_any() will log the
message but it's not under RTNL.  Once the SIOCBRDELIF's thread acquire
RTNL, the refcnt will be released soon and __rtnl_unlock() will be
unblocked.

Thanks

