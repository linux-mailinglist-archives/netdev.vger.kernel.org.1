Return-Path: <netdev+bounces-100248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE538D851C
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3E531F20EFD
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2929412CDAE;
	Mon,  3 Jun 2024 14:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CXH1ncOJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE4B82D8E
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425180; cv=none; b=Ry/3pJC1zbQV39yDJnGV6RKKDLbzjrgnHmalbxOerWQesd4IkDLyw7ODUd4ShnFdcECia/HyE+zhZnAuLERMpm6tANYVC9MzN/esjeJ9AZjs+TvE7r3wRvg0Y3DK5YVq24M14Ioqc/yMIIm6a2nsDUBzMarOR2d4iHKlGDLcTfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425180; c=relaxed/simple;
	bh=MPDH6WXGrU8/6jJXUYXcHOBpofgXgv97nMDWAgirQZs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KM+wFtjHB7THhl4cGWuFemc3EC/ex/gZv/FVWFXnj3AkdpAi8223P7CZbjvtxmWWa//5RGnuCXQQ9aBE6GTSf/z+d2cKyamXzC5C+4J2vKaHkTief3br1WFz03I9g6DyPDSwfbzOsryy8pxLdhPYFhYYIIkBFLRlVpY0/2xmH3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CXH1ncOJ; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717425179; x=1748961179;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=8cNMTLXBTL4BY/o3qTWWHYxzHhJL8URflk3PlOrpHXg=;
  b=CXH1ncOJN1/pVUTflw4ju0aWdiSNvc03z1Ko98v3MqY3SJ63r8N1SOPp
   tVNV9bsyZAJ1UESJNDM7TJDmgGZfZx7A0iH9APjBVTJOYvwL269tvX4vB
   sYJeftoYfilTKSYdxifaOlDlAmdgmZcUqYeAuWt22oFJR51XYoRrUYb3d
   g=;
X-IronPort-AV: E=Sophos;i="6.08,211,1712620800"; 
   d="scan'208";a="300540188"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:32:56 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:42599]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.1.254:2525] with esmtp (Farcaster)
 id b7cc910c-3558-4056-bdde-2e5fcdd29422; Mon, 3 Jun 2024 14:32:55 +0000 (UTC)
X-Farcaster-Flow-ID: b7cc910c-3558-4056-bdde-2e5fcdd29422
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 3 Jun 2024 14:32:54 +0000
Received: from 88665a182662.ant.amazon.com (10.88.143.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Jun 2024 14:32:52 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 00/15] af_unix: Fix lockless access of sk->sk_state and others fields.
Date: Mon, 3 Jun 2024 07:32:16 -0700
Message-ID: <20240603143231.62085-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The patch 1 fixes a bug that SOCK_DGRAM's sk->sk_state is changed
to TCP_CLOSE even if the socket is connect()ed to another socket.

The rest of this series annotates lockless accesses to the following
fields:

  * sk->sk_state
  * sk->sk_sndbuf
  * net->unx.sysctl_max_dgram_qlen
  * sk->sk_receive_queue.qlen
  * sk->sk_shutdown

Note that with this series there is skb_queue_empty() left in
unix_dgram_disconnected() that needs to be changed to lockless
version, and unix_peer(other) access there should be protected
by unix_state_lock().

This will require some refactoring, so another series will follow.


Kuniyuki Iwashima (15):
  af_unix: Set sk->sk_state under unix_state_lock() for truly
    disconencted peer.
  af_unix: Annodate data-races around sk->sk_state for writers.
  af_unix: Annotate data-race of sk->sk_state in unix_inq_len().
  af_unix: Annotate data-races around sk->sk_state in unix_write_space()
    and poll().
  af_unix: Annotate data-race of sk->sk_state in unix_stream_connect().
  af_unix: Annotate data-race of sk->sk_state in unix_accept().
  af_unix: Annotate data-races around sk->sk_state in sendmsg() and
    recvmsg().
  af_unix: Annotate data-race of sk->sk_state in unix_stream_read_skb().
  af_unix: Annotate data-races around sk->sk_state in UNIX_DIAG.
  af_unix: Annotate data-races around sk->sk_sndbuf.
  af_unix: Annotate data-race of net->unx.sysctl_max_dgram_qlen.
  af_unix: Use unix_recvq_full_lockless() in unix_stream_connect().
  af_unix: Use skb_queue_empty_lockless() in unix_release_sock().
  af_unix: Use skb_queue_len_lockless() in sk_diag_show_rqlen().
  af_unix: Annotate data-race of sk->sk_shutdown in sk_diag_fill().

 net/unix/af_unix.c | 90 +++++++++++++++++++++++-----------------------
 net/unix/diag.c    | 12 +++----
 2 files changed, 50 insertions(+), 52 deletions(-)

-- 
2.30.2


