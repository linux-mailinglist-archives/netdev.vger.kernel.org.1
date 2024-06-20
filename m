Return-Path: <netdev+bounces-105425-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8509111B6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 21:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D97421C211A9
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 19:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 067D94CE13;
	Thu, 20 Jun 2024 19:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="L+36cARj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7360A3D966
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 19:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718910101; cv=none; b=oxnKVWRa2+oYDSPfaiA61qsevfRUN2YiNJBRvElzz7qjCUEGnLVvEQ7/SToAteAU2sv25UMfv0bQrYnU+cgUrWXl9bOXt7Ey/M/rgljiEriLGHGnWg6HTgZaCRzSlRMjT5s2l+U5Dp+mmUhkbg2nvrxlbgV8fg3f+nx2fscIdzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718910101; c=relaxed/simple;
	bh=PjN/4hUcv5spblZ5R97qwMCQUmt8E2bWjyYWQBqjxmQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ADbS9M/N1+f+B62WJq+qkiIfys46AFW2WiSCFYNDFM2SGNIbdSrtAcqPK3yddGZQF1+LxDfzMxc11PRaQbGuIPjoEBkbPjmZ7/xz2fWU2zbrkH5iM4ZTF93RINiEuEl/aSUDQM4FPaYEb6GI/7jovUPTpqr9Gj8Xa6GjqqgzNv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=L+36cARj; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718910100; x=1750446100;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o3n2uryCq6wGTvDpmXn2RUZBHwMuBfanycPt5r0xYa0=;
  b=L+36cARj704S7gL1iPl8G9F8HJe/TKkBodf3kgWRoveMdy8HACKsJAEO
   3dSM7IPdTf0SZm5J1diWE+rT4mbBnwWn6zncxn1dKQFTUIP5LlL/Dg5Mc
   E9//PsLBJ85TK4BN4iRmklBJrVmkSqplUgTXmdzbDqIagiaQqo5Vnv0jj
   8=;
X-IronPort-AV: E=Sophos;i="6.08,252,1712620800"; 
   d="scan'208";a="734268817"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 19:01:27 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:49869]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.32:2525] with esmtp (Farcaster)
 id 5c14c4af-0229-4855-9d1b-cd183ff937e9; Thu, 20 Jun 2024 19:01:26 +0000 (UTC)
X-Farcaster-Flow-ID: 5c14c4af-0229-4855-9d1b-cd183ff937e9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 19:01:26 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 19:01:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <kuba@kernel.org>,
	<kuniyu@amazon.com>, <netdev@vger.kernel.org>, <pabeni@redhat.com>,
	<syzkaller@googlegroups.com>
Subject: Re: [PATCH net] net: add softirq safety to netdev_rename_lock
Date: Thu, 20 Jun 2024 12:01:14 -0700
Message-ID: <20240620190114.49677-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240620133119.1135480-1-edumazet@google.com>
References: <20240620133119.1135480-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Date: Thu, 20 Jun 2024 13:31:19 +0000
From: Eric Dumazet <edumazet@google.com>
> syzbot reported a lockdep violation involving bridge driver [1]
> 
> Make sure netdev_rename_lock is softirq safe to fix this issue.
> 
> [1]
> WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
> 6.10.0-rc2-syzkaller-00249-gbe27b8965297 #0 Not tainted
>    -----------------------------------------------------
> syz-executor.2/9449 [HC0[0]:SC0[2]:HE0:SE0] is trying to acquire:
>  ffffffff8f5de668 (netdev_rename_lock.seqcount){+.+.}-{0:0}, at: rtnl_fill_ifinfo+0x38e/0x2270 net/core/rtnetlink.c:1839
> 
> and this task is already holding:
>  ffff888060c64cb8 (&br->lock){+.-.}-{2:2}, at: spin_lock_bh include/linux/spinlock.h:356 [inline]
>  ffff888060c64cb8 (&br->lock){+.-.}-{2:2}, at: br_port_slave_changelink+0x3d/0x150 net/bridge/br_netlink.c:1212
> which would create a new lock dependency:
>  (&br->lock){+.-.}-{2:2} -> (netdev_rename_lock.seqcount){+.+.}-{0:0}
> 
> but this new dependency connects a SOFTIRQ-irq-safe lock:
>  (&br->lock){+.-.}-{2:2}
[...]
> Fixes: 0840556e5a3a ("net: Protect dev->name by seqlock.")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Cc: Kuniyuki Iwashima <kuniyu@amazon.com>

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>

Thanks!

