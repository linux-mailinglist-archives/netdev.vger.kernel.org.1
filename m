Return-Path: <netdev+bounces-169571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B5DEA44A71
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 19:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D08FF86265D
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 18:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B88B1DB12E;
	Tue, 25 Feb 2025 18:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Tzcy6D17"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC921D63C6
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 18:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740507825; cv=none; b=Na6jjSAZYc3238FmZGusjWrF6slvYO/dN6xlCi0kew/4lWKVaaqyvDplLqlaTn9JmWIjzlonWMP0wTewRzuURkbH8AES8rNkojbdmuZCjPRT9GNzJUXqhDdlzvBsYr5Iym+KugInj2E3jedJ0Ck9qV7QMZt9tZJCIJ72+SC5VZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740507825; c=relaxed/simple;
	bh=DigQ5HavSs9VmQ4Athi7l6gsXNnOK7D5avpL9FnF/l0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c5oyzDc5QzrS2tbTyk3Jydio0cwrbxBb23tQ9oZPCACGa5I+/bs191bGW2ekjwuEogQaCqZXBLa/Ma7uOAyWB7VIpZ8hFIOhW2apWGtXkimImzkycE2GT1ZXZrUKOe08eNHslRworgUHBt7xeECQP9K0Xk8fR0qGjqKEp7ickWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Tzcy6D17; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740507824; x=1772043824;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=MoaYwpRZGlY/DsDkAwT1IH2p3w9wLzLkuNsor2WiHkA=;
  b=Tzcy6D17gHnbrsM/+51pq+UxkFj2v/e8GvRgcYCEEMkREoVj07D1BVjG
   dNLVHGSsq+SgHF495xaoKZpsnd6EKz+HNR87kfiD7iTK2lgZB3xw6V1Gd
   rIUH9CzAYEAEMGeCl8YJPIf1QdjLyfJLh+RA76ggh97p54JHTQeL1s1oo
   s=;
X-IronPort-AV: E=Sophos;i="6.13,314,1732579200"; 
   d="scan'208";a="69146873"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 18:23:25 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:36054]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.97:2525] with esmtp (Farcaster)
 id d42d56e4-16c8-41e4-a254-94aab6b20e51; Tue, 25 Feb 2025 18:23:24 +0000 (UTC)
X-Farcaster-Flow-ID: d42d56e4-16c8-41e4-a254-94aab6b20e51
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:23:04 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.5) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Feb 2025 18:23:01 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 00/12] ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.
Date: Tue, 25 Feb 2025 10:22:38 -0800
Message-ID: <20250225182250.74650-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 is a misc cleanup.
Patch 2 ~ 8 converts two fib_info hash tables to per-netns.
Patch 9 ~ 12 converts rtnl_lock() to rtnl_net_lcok().


Kuniyuki Iwashima (12):
  ipv4: fib: Use cached net in fib_inetaddr_event().
  ipv4: fib: Allocate fib_info_hash[] and fib_info_laddrhash[] by
    kvmalloc_array().
  ipv4: fib: Allocate fib_info_hash[] during netns initialisation.
  ipv4: fib: Make fib_info_hashfn() return struct hlist_head.
  ipv4: fib: Remove fib_info_laddrhash pointer.
  ipv4: fib: Remove fib_info_hash_size.
  ipv4: fib: Add fib_info_hash_grow().
  ipv4: fib: Namespacify fib_info hash tables.
  ipv4: fib: Hold rtnl_net_lock() for ip_fib_net_exit().
  ipv4: fib: Hold rtnl_net_lock() in ip_rt_ioctl().
  ipv4: fib: Move fib_valid_key_len() to rtm_to_fib_config().
  ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.

 include/net/ip_fib.h     |   2 +
 include/net/netns/ipv4.h |   3 +
 net/ipv4/fib_frontend.c  |  72 ++++++++++----
 net/ipv4/fib_semantics.c | 207 +++++++++++++++++++--------------------
 net/ipv4/fib_trie.c      |  22 -----
 5 files changed, 158 insertions(+), 148 deletions(-)

-- 
2.39.5 (Apple Git-154)


