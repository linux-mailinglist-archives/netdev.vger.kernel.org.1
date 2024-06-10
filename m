Return-Path: <netdev+bounces-102369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E3A902BBB
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 00:35:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EE0CB20AFD
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 22:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C527577107;
	Mon, 10 Jun 2024 22:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rY/O2ax2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BAC5466B
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 22:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718058921; cv=none; b=hj3lZngc+CZf6Z5kAxi/QYsHFAPuao+u9YnWPt0QB8l5CZG5szUTFm3uYXH3D4dSMDGPVEIQO1WQP7Q4ZAAC6CGWrQjfb5E/nMiVm73TQb6RF3u8g7XM50AEl1p63Ni1H3go6GU+IzXA76+j93hF1sBHjFNOzaIEPXAn3JG+Cp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718058921; c=relaxed/simple;
	bh=6N3i5OSNvSDEttwSRubWEFgAEBhkNvKKdqbB5lz4brM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M7fFX0v1jlTXMd7zsIpyoaJqjemweV7Tcg9VAt/H6ZlUmnhWi2oD6u8EXda8/uJPagX9wQjwwUC5jIV0YuFqJDiT74PkquBW15QOfn7MlezQsGyNK8yj5qytRlheudub7ZXMliwVfuhy9cOHKA+VrSg5suEHUqPlYIByRn0mRCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rY/O2ax2; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718058920; x=1749594920;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zg98b9CiHfRUfoowDo+mZ9k74MH5Fofw+6NR2Ke4FNs=;
  b=rY/O2ax2f5p4inlqOQKxTyLA3S76Lc+qaQtunC94GGCQwXIE3LPpuSbq
   +wNlCQM+pssfAtL9YFBVAUYNR8q8ZK1aVQfnMm12lghTfGnF8LSPC6K4S
   EGJxqu0pgPUxvxiTRx/+tz/LtoVPxND/Rt9wqkbzu0rxGt3fUxccYUKrD
   E=;
X-IronPort-AV: E=Sophos;i="6.08,228,1712620800"; 
   d="scan'208";a="210930846"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 22:35:18 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:43621]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.183:2525] with esmtp (Farcaster)
 id 82ab938e-10bb-4fac-9ed9-13e5f265929e; Mon, 10 Jun 2024 22:35:17 +0000 (UTC)
X-Farcaster-Flow-ID: 82ab938e-10bb-4fac-9ed9-13e5f265929e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 10 Jun 2024 22:35:16 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.27) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 10 Jun 2024 22:35:14 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 00/11] af_unix: Remove spin_lock_nested() and convert to lock_cmp_fn.
Date: Mon, 10 Jun 2024 15:34:50 -0700
Message-ID: <20240610223501.73191-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB004.ant.amazon.com (10.13.138.104) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This series removes spin_lock_nested() in AF_UNIX and instead
defines the locking orders as functions tied to each lock by
lockdep_set_lock_cmp_fn().

When the defined function returns a negative value, lockdep
considers it will not cause deadlock.  (See ->cmp_fn() in
check_deadlock() and check_prev_add().)


Kuniyuki Iwashima (11):
  af_unix: Define locking order for unix_table_double_lock().
  af_unix: Define locking order for U_LOCK_SECOND in
    unix_state_double_lock().
  af_unix: Don't retry after unix_state_lock_nested() in
    unix_stream_connect().
  af_unix: Define locking order for U_LOCK_SECOND in
    unix_stream_connect().
  af_unix: Don't acquire unix_state_lock() for sock_i_ino().
  af_unix: Remove U_LOCK_DIAG.
  af_unix: Remove U_LOCK_GC_LISTENER.
  af_unix: Remove U_RECVQ_LOCK_EMBRYO.
  af_unix: Set sk_peer_pid/sk_peer_cred locklessly for new socket.
  af_unix: Remove put_pid()/put_cred() in copy_peercred().
  af_unix: Don't use spin_lock_nested() in copy_peercred().

 include/net/af_unix.h |  14 -----
 net/unix/af_unix.c    | 134 +++++++++++++++++++++++++++---------------
 net/unix/diag.c       |  47 ++++-----------
 net/unix/garbage.c    |   8 +--
 4 files changed, 99 insertions(+), 104 deletions(-)

-- 
2.30.2


