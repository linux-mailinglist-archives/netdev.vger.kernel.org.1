Return-Path: <netdev+bounces-137122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F1459A46E7
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 21:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4DBEE2879F8
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 19:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3D1A205AB5;
	Fri, 18 Oct 2024 19:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="f8+ZPzDJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB89204F84;
	Fri, 18 Oct 2024 19:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729279077; cv=none; b=HCV8Zml1K3ozMAUR5YhYiD7yaevMGYs7ZQ01CAgOG4sCkIB3ndAb9BT2swcSSU8D7P1vAvjmmSe2acbr9Gcgcn+Jv8aPtNpd4rSsIVl1TCs/d/+MVe9HkB6aMoYdSn/OkfZmM0jnFqhEnLef88BrCQ84cm2MHXJ5jX5Vdna1MBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729279077; c=relaxed/simple;
	bh=9wmi1++gLyD9c4Qhq6GUv2Qa4vbusylvVCEK1uU3+HM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k36OIPTf30PsxgAYHfXiXRDVfQZGw4hsj6JcrtfNISWjoxXv5fOXW5oKTu0aIv8IlW9ZkrplD6zydoP0K5+6gG3ZHRk3JeOkUvJJ6nYzBNA8HY4vj0v6+l36DbsgMO0vhRd+HNTRAd1Tz+heQ870OWfVdDbOjJNUE/SV8A/eYHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=f8+ZPzDJ; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729279076; x=1760815076;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Ey17rZoH9y6E2Ela+RNm9BlTZQ3RB/m4P97zQHBlUHg=;
  b=f8+ZPzDJMdvPLLenz2oYiH20L5Q5K9yKMkHqLo5mPVvTxVN0wWyiQxsC
   fKbKnK2xjAbmd+GtKDGOsuN730e3OjZRDOaKkcb0+UwYcYigUH7eKywPd
   8X7EItfyXoIUMsNINVr6HiaP1fIxegQNnKLBA1DcgH31LcFVf7kkqYVsC
   Q=;
X-IronPort-AV: E=Sophos;i="6.11,214,1725321600"; 
   d="scan'208";a="768128763"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 19:17:48 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:56867]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.95:2525] with esmtp (Farcaster)
 id 7fede503-0b3c-4511-a057-d77f5c88d405; Fri, 18 Oct 2024 19:17:48 +0000 (UTC)
X-Farcaster-Flow-ID: 7fede503-0b3c-4511-a057-d77f5c88d405
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 19:17:45 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.170.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 19:17:42 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <arnd@arndb.de>
CC: <aleksander.lobakin@intel.com>, <arnd@kernel.org>, <chentao@kylinos.cn>,
	<davem@davemloft.net>, <dsahern@kernel.org>, <edumazet@google.com>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<lizetao1@huawei.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH] ipmr: Don't mark ip6mr_rtnl_msg_handlers as __initconst
Date: Fri, 18 Oct 2024 12:17:39 -0700
Message-ID: <20241018191739.5158-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <95170855-21fc-45b4-a393-176883f7dd52@app.fastmail.com>
References: <95170855-21fc-45b4-a393-176883f7dd52@app.fastmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC003.ant.amazon.com (10.13.139.252) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: "Arnd Bergmann" <arnd@arndb.de>
Date: Fri, 18 Oct 2024 19:09:10 +0000
> On Fri, Oct 18, 2024, at 16:31, Kuniyuki Iwashima wrote:
> > From: Arnd Bergmann <arnd@kernel.org>
> > Date: Fri, 18 Oct 2024 15:12:14 +0000
> >> From: Arnd Bergmann <arnd@arndb.de>
> >> 
> >> This gets referenced by the ip6_mr_cleanup function, so it must not be
> >> discarded early:
> >> 
> >> WARNING: modpost: vmlinux: section mismatch in reference: ip6_mr_cleanup+0x14 (section: .exit.text) -> ip6mr_rtnl_msg_handlers (section: .init.rodata)
> >> ERROR: modpost: Section mismatches detected.
> >> Set CONFIG_SECTION_MISMATCH_WARN_ONLY=y to allow them.
> >> 
> >> Fixes: 3ac84e31b33e ("ipmr: Use rtnl_register_many().")
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Hi,
> >
> > I posted this yesterday.
> > https://lore.kernel.org/netdev/20241017174732.39487-1-kuniyu@amazon.com/
> 
> Right, your may be better then. I was confused by the
> function name suggesting that this would be called in the
> module_exit path, but I now see that it is only called
> at init time, so that works.

Since the commit below, IPv6 has lost unloadability, and such cleanup
functions are only called from init path now.


commit 8ce440610357b77587433d0df647cea69a6890a8
Author: Cong Wang <amwang@redhat.com>
Date:   Sat Sep 21 11:12:21 2013 +0800

    ipv6: do not allow ipv6 module to be removed

