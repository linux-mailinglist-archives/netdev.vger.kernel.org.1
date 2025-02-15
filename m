Return-Path: <netdev+bounces-166655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16B38A36CF7
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 10:35:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2FAF17152D
	for <lists+netdev@lfdr.de>; Sat, 15 Feb 2025 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556561922ED;
	Sat, 15 Feb 2025 09:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LnqRv4R9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB3A1373
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 09:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739612128; cv=none; b=Nh9BWAcwy5Toc2WOJv7pFMzMyRm6RRry1TCob84nlZHmMPvO4Pf74XpRQ11VbmqgJ7VWwgPFSi4ZS37CsAhMEZ/8nDGLEf5XWHt3O4xnqgv/bNrr8yRDAXHdYmMRgmhCz0eRUszaFhUh7eCdRATN9edDLgOb+mlciLJ34hSBgIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739612128; c=relaxed/simple;
	bh=jx0jkmGx9YtwSscq+Aj5yPGpOeEsQpSJalInQ1IY3vs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N/1J/wzMuwnTvlmBUJrEZDHNz5yPjqwHKLAojooUS90VZWlByM0GW0A/te01I8icVob/bmX66xJ4aIpfyz6DElFtZ4FbnxOulFGvlvxrJxWTxaVZID2W74fwKC1I7P6eVwzDe3ZkOjxNCYz7HkgCWVrftw+3k+KiGjtXUhlR6dY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LnqRv4R9; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739612127; x=1771148127;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/D21+Dpd5j68OPgdzpNJik3WslhG+Tn9mWwd5w7DRTg=;
  b=LnqRv4R9Uwp2Rg4F390xfawotEX44waZZemDQmhiUA32jQnIB1ZSVW8W
   vkiBjA1Q/Fnd+/72lHusveZ+bPJvoxULYaGHKY3aHD8EuavX9088J5wa/
   dmCFe3SYyJhsFJ91SN0jj42ZCYcPxD4qdNH9RGSUaErlqSVMDxPDOqIdq
   E=;
X-IronPort-AV: E=Sophos;i="6.13,288,1732579200"; 
   d="scan'208";a="462816909"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2025 09:35:24 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:61230]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.245:2525] with esmtp (Farcaster)
 id 5bfacad4-9671-43eb-9011-8efab53ad03b; Sat, 15 Feb 2025 09:35:22 +0000 (UTC)
X-Farcaster-Flow-ID: 5bfacad4-9671-43eb-9011-8efab53ad03b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 15 Feb 2025 09:35:22 +0000
Received: from 6c7e67bfbae3.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 15 Feb 2025 09:35:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <apw@canonical.com>, <davem@davemloft.net>, <dwaipayanray1@gmail.com>,
	<horms@kernel.org>, <joe@perches.com>, <kuba@kernel.org>,
	<kuni1840@gmail.com>, <kuniyu@amazon.com>, <lukas.bulwahn@gmail.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next] checkpatch: Discourage a new use of rtnl_lock() variants.
Date: Sat, 15 Feb 2025 18:35:09 +0900
Message-ID: <20250215093509.11745-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <CANn89iKY8V7jj=JkZpC2YuKtiUMr9-mDoJ7g7+0G9ppdOXo8ZQ@mail.gmail.com>
References: <CANn89iKY8V7jj=JkZpC2YuKtiUMr9-mDoJ7g7+0G9ppdOXo8ZQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D046UWA003.ant.amazon.com (10.13.139.18) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri, 14 Feb 2025 15:15:48 +0100
> On Fri, Feb 14, 2025 at 5:54 AM Kuniyuki Iwashima <kuniyu@amazon.com> wrote:
> >
> > rtnl_lock() is a "Big Kernel Lock" in the networking slow path
> > and still serialises most of RTM_(NEW|DEL|SET)* rtnetlink requests.
> >
> > Commit 76aed95319da ("rtnetlink: Add per-netns RTNL.") started a
> > very large, in-progress, effort to make the RTNL lock scope per
> > network namespace.
> >
> > However, there are still some patches that newly use rtnl_lock(),
> > which is now discouraged, and we need to revisit it later.
> >
> > Let's warn about the case by checkpatch.
> >
> > The target functions are as follows:
> >
> >   * rtnl_lock()
> >   * rtnl_trylock()
> >   * rtnl_lock_interruptible()
> >   * rtnl_lock_killable()
> >
> > and the warning will be like:
> >
> >   WARNING: A new use of rtnl_lock() variants is discouraged, try to use rtnl_net_lock(net) variants
> >   #18: FILE: net/core/rtnetlink.c:79:
> >   +     rtnl_lock();
> 
> I do wonder if this is not premature.
> 
> After all, we have nothing in Documentation/ yet about this.

Fair point.  I'll defer this patch at least until rtnetlink
handlers are fully converted and the left thing to do is almost
replacing existing RTNL, then I'll repost with a small doc.

