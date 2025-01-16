Return-Path: <netdev+bounces-158759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCA3A132A5
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:35:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35DD47A034B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:35:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38832AE99;
	Thu, 16 Jan 2025 05:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sYi0B6j0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7AF1804A
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005713; cv=none; b=jNbPD6FZRASO4uDMVkE6dk8/Osjc24nId0PMKcMCPp06K5p2zevLg0fCtVCPj7rCf02tI3zTPpdANZQDbXW4D62ecoQKgrEvhD8uwqqnkru5NPVj2KU5v5oLgWscM0dA2iBFvAg4fKATyV83GmVW8bp1SK1ap9Na6zIx6GecrgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005713; c=relaxed/simple;
	bh=I4f3tpmkI4DW4Ygiy1ddhZRvRFRz4+tQ5KqqVlceZ0E=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VhaGj2PcvnSObtJG32BQR56O5+V5OM0k1MekId/JP+39+ovkuSz3N5b2wIrei1YIXXGqabI+uJzEXdHQ0RzvEDnUrPmgKbpv4cJ7WhbVw7qNmy5DeqnKcgpossweoNHRqVR+OIOYZDuNMM7Uk0clo3EWEy4rwWTXO5xjHh790FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sYi0B6j0; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737005712; x=1768541712;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gKlub8YMf/DgPFXwbrD32oOybYDk1XPG/wSaL2hD7Jc=;
  b=sYi0B6j0c8uyfoSNQmLX/3um2jERvIOXzsIF+itpiYz++VNFFE5wvHHl
   kx+0vXkv9zRUbx7oEomxsrjT82A5C54cdILHrsGLxTgBXAIMwTW8ywGnK
   xj5S59Lp8GVaWjNEPGmxE76gGENIn23Folgw/QNKP00+QeQ4+WTN9V+cu
   0=;
X-IronPort-AV: E=Sophos;i="6.13,208,1732579200"; 
   d="scan'208";a="369483208"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 05:35:11 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:43758]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.53:2525] with esmtp (Farcaster)
 id fbb2e316-2db3-46cd-9c3c-4f8698ec073e; Thu, 16 Jan 2025 05:35:10 +0000 (UTC)
X-Farcaster-Flow-ID: fbb2e316-2db3-46cd-9c3c-4f8698ec073e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:35:07 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.84.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:35:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 0/9] af_unix: Set skb drop reason in every kfree_skb() path.
Date: Thu, 16 Jan 2025 14:34:33 +0900
Message-ID: <20250116053441.5758-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

There is a potential user for skb drop reason for AF_UNIX.

This series replaces some kfree_skb() in connect() and
sendmsg() paths and sets skb drop reason for the rest of
kfree_skb() in AF_UNIX.

Link: https://lore.kernel.org/netdev/CAAf2ycmZHti95WaBR3s+L5Epm1q7sXmvZ-EqCK=-oZj=45tOwQ@mail.gmail.com/


Changes:
  v3:
    * Drop skb drop reason patches for connect() and sendmsg()
    * Restore patch 8
    * Add patch 9 replacing kfree_skb() with consume_skb() in connect()
      and sendmsg()

  v2: https://lore.kernel.org/netdev/20250112040810.14145-1-kuniyu@amazon.com/
    * Drop the old patch 6 to silence false-positive uninit warning

  v1: https://lore.kernel.org/netdev/20250110092641.85905-1-kuniyu@amazon.com/


Kuniyuki Iwashima (9):
  net: dropreason: Gather SOCKET_ drop reasons.
  af_unix: Set drop reason in unix_release_sock().
  af_unix: Set drop reason in unix_sock_destructor().
  af_unix: Set drop reason in __unix_gc().
  af_unix: Set drop reason in manage_oob().
  af_unix: Set drop reason in unix_stream_read_skb().
  af_unix: Set drop reason in unix_dgram_disconnected().
  af_unix: Reuse out_pipe label in unix_stream_sendmsg().
  af_unix: Use consume_skb() in connect() and sendmsg().

 include/net/dropreason-core.h | 28 +++++++++++----
 net/unix/af_unix.c            | 67 +++++++++++++++++------------------
 net/unix/garbage.c            |  2 +-
 3 files changed, 55 insertions(+), 42 deletions(-)

-- 
2.39.5 (Apple Git-154)


