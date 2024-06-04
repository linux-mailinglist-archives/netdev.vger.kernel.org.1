Return-Path: <netdev+bounces-100688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 026618FB992
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 18:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 335DA1C23231
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 16:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FA8148828;
	Tue,  4 Jun 2024 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="ZO21RHd6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0DC171BA
	for <netdev@vger.kernel.org>; Tue,  4 Jun 2024 16:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519979; cv=none; b=i0OKoNn/zB2Y8jYPip5XEUp3rWbZTYaozcezp4CJouTywG8g1GhmKtJNMUGG/jQSYc4pYm/n0O3HDBjtOo0b5Td1OXlf05BSewsNyn+evYkUKDiPOfq8PsC1XDrbiD0DbvOWq9Dqo5uM53UIMy8XQLqUTByKkunCp7wLhJiYuVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519979; c=relaxed/simple;
	bh=ExCp8oZSZXS/Znqhu02RK46x7llOo+T8lYiD3vYyHlA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LqDmJ1GryDadRqIllT2Yh6TkbBtVJvAeStjB0jm3Z7UZoKwEsBzbV4RhZbbYyVnhfLtLfltIW/8b8XqgOr4MoT0jxyKOWfFRViUrdOfJbeGWDAjjvZn0AT8uU7f9NeiT2ABbJ/GA8xq6bOPJAKkJC8xknJJkU/mF7Isa2iG78as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=ZO21RHd6; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717519978; x=1749055978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LAADkQ/YMzO10GCI0rpAbQlAJmD59zaTYNKlXk5SZ/s=;
  b=ZO21RHd6Bb/fqwXggAFDk85BWd9x2XDikmZcuw7Ewj1jZKMaxOWszeGn
   6metSiWCo9s4CeTv+hQDxlq0bt4IlueuvWl7SxGjfFPU92uiHOPSveNYn
   Y/dSxsgfPl280QqoieQ1CidGbfozYWRqwR+HSvsQ2GXMa80X+Hj4qGO53
   Q=;
X-IronPort-AV: E=Sophos;i="6.08,214,1712620800"; 
   d="scan'208";a="299733767"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2024 16:52:54 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:36330]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.174:2525] with esmtp (Farcaster)
 id 303c369f-f794-44b6-82c9-c89f32d6dc70; Tue, 4 Jun 2024 16:52:53 +0000 (UTC)
X-Farcaster-Flow-ID: 303c369f-f794-44b6-82c9-c89f32d6dc70
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 4 Jun 2024 16:52:53 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.50) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 4 Jun 2024 16:52:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 00/15] af_unix: Fix lockless access of sk->sk_state and others fields.
Date: Tue, 4 Jun 2024 09:52:26 -0700
Message-ID: <20240604165241.44758-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The patch 1 fixes a bug where SOCK_DGRAM's sk->sk_state is changed
to TCP_CLOSE even if the socket is connect()ed to another socket.

The rest of this series annotates lockless accesses to the following
fields.

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


Changes:
  v2:
    * Patch 1: Fix wrong double lock

  v1: https://lore.kernel.org/netdev/20240603143231.62085-1-kuniyu@amazon.com/


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


