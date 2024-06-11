Return-Path: <netdev+bounces-102735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9D99046E6
	for <lists+netdev@lfdr.de>; Wed, 12 Jun 2024 00:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E814B1F22C3B
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 22:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F1215530F;
	Tue, 11 Jun 2024 22:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Nnq48Z+q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9105.amazon.com (smtp-fw-9105.amazon.com [207.171.188.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B737711C
	for <netdev@vger.kernel.org>; Tue, 11 Jun 2024 22:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144968; cv=none; b=C+O6fFAfjQol8JGJa3bdy+Ajg+2xBvjBLgeZZsgnDIEQVdIaSMCtdLp+JA4mqVa2U8MoMM/j8CzprCyl3klQp+fAb4ijHAc5LnG+j4guU1zEDpUk8ecGnVUrHPes89Mr49odstzSmB1OtsO/6Ca4NfPMT0IlFFsOqggLqM0k3ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144968; c=relaxed/simple;
	bh=l10MdbaQIxOHoDvxq6Ny1wUezZgTGtZIzEvDyL8r1B8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dpw7AQaeblZ+qNa+b0cx1hFAYB9kOTV0irWuxcG5WIEJL/BEfrfyYCH9doaZDABGC5X2rkLhJT4VwdHSsiUuxoSMjhrZjslBtxHv9HQOkANXPkTiYmKDMpnKnPuShKk19+V09EFz5cx+yEVfft1exXOmhlX20Sl9zwMLjdSwlOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Nnq48Z+q; arc=none smtp.client-ip=207.171.188.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718144967; x=1749680967;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Lpo+ccqT4pU44a1+7rnSmG9moA2E78hnbeLapubSdIg=;
  b=Nnq48Z+qk/KaEOoGhagrMwKE78fWSS/xzi9Tra0VM7wTSTOi4UBgzwgE
   LQhSHa0LL8oDfC/7qVHfVPHFZulmEXQlH+D8b/I0vfnDApGu6Z0BYQaYV
   EM/k72wic07FsK40TZeMwb0192wTdmM+JAbqDk1r67Up4hQamXIsDH3Qq
   g=;
X-IronPort-AV: E=Sophos;i="6.08,231,1712620800"; 
   d="scan'208";a="732869926"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9105.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2024 22:29:19 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:33837]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.46.168:2525] with esmtp (Farcaster)
 id 3e31f276-aa9a-461b-a4db-ec6188589f1d; Tue, 11 Jun 2024 22:29:19 +0000 (UTC)
X-Farcaster-Flow-ID: 3e31f276-aa9a-461b-a4db-ec6188589f1d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 11 Jun 2024 22:29:18 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 11 Jun 2024 22:29:16 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 00/11] af_unix: Remove spin_lock_nested() and convert to lock_cmp_fn.
Date: Tue, 11 Jun 2024 15:28:54 -0700
Message-ID: <20240611222905.34695-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This series removes spin_lock_nested() in AF_UNIX and instead
defines the locking orders as functions tied to each lock by
lockdep_set_lock_cmp_fn().

When the defined function returns a negative value, lockdep
considers it will not cause deadlock.  (See ->cmp_fn() in
check_deadlock() and check_prev_add().)

When we cannot define the total ordering, we return -1 for
the allowed order and otherwise 0 as undefined. [0]

[0]: https://lore.kernel.org/netdev/thzkgbuwuo3knevpipu4rzsh5qgmwhklihypdgziiruabvh46f@uwdkpcfxgloo/


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
  af_unix: Define locking order for U_RECVQ_LOCK_EMBRYO in
    unix_collect_skb().
  af_unix: Set sk_peer_pid/sk_peer_cred locklessly for new socket.
  af_unix: Remove put_pid()/put_cred() in copy_peercred().
  af_unix: Don't use spin_lock_nested() in copy_peercred().

 include/net/af_unix.h |  14 -----
 net/unix/af_unix.c    | 136 +++++++++++++++++++++++++++---------------
 net/unix/diag.c       |  47 ++++-----------
 net/unix/garbage.c    |   8 +--
 4 files changed, 101 insertions(+), 104 deletions(-)

-- 
2.30.2


