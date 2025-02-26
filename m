Return-Path: <netdev+bounces-169971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8EDA46AF3
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 20:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C523A9F61
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 19:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F75323A564;
	Wed, 26 Feb 2025 19:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="IlKyfzgf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBCE5236A70
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 19:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740598002; cv=none; b=SEU3jP8JSyUffeLjedGHAZ+o/RE+mM8QWhRjp49j/gl57yNryXz7IKIA7TWI2aBy7TmmUjhauobYLijnAeKo+ToM/6Q+x3+Hhr4wn77TfyzLCWYtxQA0bzdku2Y2nen9Vn1XSF78SwYMzErexNC+J5sJd4MdVBA9b8qAqW/X6aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740598002; c=relaxed/simple;
	bh=n5wHqRrtfndrzu5v2Hf3jUmZ2x4XzfZfwpeFmITsgsM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QJTryZUcqfZroJRHhsmA2LZBJZO5SOYkuUi2oOWVZjKBfGpPFZMaL7T2P3Tz6KxJuoCET998+LcCeMg6q3He3Do0ZWV6fNAKxkQaF1t5S8Ul4ARC+l1nAE9LUgEa+ErXIpvWLdNeEWaz0H4jcmjuhNe+MMEdMJ4dRXlb9RMkM30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=IlKyfzgf; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1740598000; x=1772134000;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=cZx2GxoWHaJOJrCDb3F7RESBcXDJWtWw24KGpEDEzVg=;
  b=IlKyfzgfl5U+KbjjjIzDCbgqWSp/3Sghm1rifniXxYpsGtDi29JfMA0Y
   7YHTrO0x3avvz0Mq6HLpunFtLE7Xw5KdZNc/phTpbkXtNG0wwkrcweGfZ
   yn0TovTeqcmkdc2EM5Esaw3xSDS6nxZ+TlB7O0KAdFDbHK/lETw92ivlo
   M=;
X-IronPort-AV: E=Sophos;i="6.13,318,1732579200"; 
   d="scan'208";a="173474819"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 19:26:25 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.38.20:10476]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.69:2525] with esmtp (Farcaster)
 id 04323856-40e4-4ba7-9042-eec26794a98c; Wed, 26 Feb 2025 19:26:25 +0000 (UTC)
X-Farcaster-Flow-ID: 04323856-40e4-4ba7-9042-eec26794a98c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:26:08 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 26 Feb 2025 19:26:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 00/12] ipv4: fib: Convert RTM_NEWROUTE and RTM_DELROUTE to per-netns RTNL.
Date: Wed, 26 Feb 2025 11:25:44 -0800
Message-ID: <20250226192556.21633-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 is misc cleanup.
Patch 2 ~ 8 converts two fib_info hash tables to per-netns.
Patch 9 ~ 12 converts rtnl_lock() to rtnl_net_lcok().


Changes:
  v2:
    * Add Eric's tags except for patch 3 (due to a minor change for exit_batch())
    * Patch 3
      * Fix memleak by calling fib4_semantics_exit() properly
      * Move fib4_semantics_exit() to fib_net_exit_batch()

  v1: https://lore.kernel.org/netdev/20250225182250.74650-1-kuniyu@amazon.com/


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
 net/ipv4/fib_frontend.c  |  74 ++++++++++----
 net/ipv4/fib_semantics.c | 207 +++++++++++++++++++--------------------
 net/ipv4/fib_trie.c      |  22 -----
 5 files changed, 160 insertions(+), 148 deletions(-)

-- 
2.39.5 (Apple Git-154)


