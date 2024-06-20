Return-Path: <netdev+bounces-105453-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B47B9113DE
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 22:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D4AF28132E
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:57:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AC574E3D;
	Thu, 20 Jun 2024 20:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="fJOFf5Ov"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A533A1CD
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 20:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718917001; cv=none; b=ja3ndZudaPq3PpYkOPMegsidBRI5Oh+GZopI5lrsG7BwO0VnYIoDe+XkPENB0lf6RrrDF5bU6CEyx2GG4tiFvs7zPkrJTRkwR+ClCosLcF5HcSG7ebXpAQs4GbOykU2o3YG++jZJTmx0eKToGGU+N0Q3+Xmn7PJ1RviVenP01ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718917001; c=relaxed/simple;
	bh=+5+nNdZnuGBYgW05Xlla5jJKaOtA2G2962QgpZsDGMc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=kYzPco72iXeeWyjVBEy2Lx+o4RuU++xBBti0IH6pfy/HQzrkQeH/0qr3TJm3wI0Q7oFUURs3oX6sGDjZyRAbjiRfmhmilVtqjRBBllkTl++KRHXrdq86FhMZubHqLmZ2TkP1xVOB2hcWGJxjGC/xWBPI/HV0gJN/zSPQZmjotaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=fJOFf5Ov; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718916999; x=1750452999;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BYXcPSY0NZ+FsGsZCBmfBgzZJ01ASciMubwGcZdDlUM=;
  b=fJOFf5Ov22sgnNs1eAhJRmlNDPl9KFwmpuLHf1BbYf+33YiDWuShw80d
   IMG8YW3q++7SkYb0Pdmv902Td2GFPdVofAk1l9Ue1eXcGX4iCD0xm11ke
   7usOvb0rXk1tuoK0t2lM1qsSSfdmH70V0y4IqEelCCzoi+gvPISsBJix3
   g=;
X-IronPort-AV: E=Sophos;i="6.08,252,1712620800"; 
   d="scan'208";a="213071359"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jun 2024 20:56:36 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:13568]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.10.32:2525] with esmtp (Farcaster)
 id 273b86b2-306a-43c3-979b-bfe7a541f4d7; Thu, 20 Jun 2024 20:56:36 +0000 (UTC)
X-Farcaster-Flow-ID: 273b86b2-306a-43c3-979b-bfe7a541f4d7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 20:56:36 +0000
Received: from 88665a182662.ant.amazon.com.com (10.187.171.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 20:56:33 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kent Overstreet <kent.overstreet@linux.dev>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 00/11] af_unix: Remove spin_lock_nested() and convert to lock_cmp_fn.
Date: Thu, 20 Jun 2024 13:56:12 -0700
Message-ID: <20240620205623.60139-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This series removes spin_lock_nested() in AF_UNIX and instead
defines the locking orders as functions tied to each lock by
lockdep_set_lock_cmp_fn().

When the defined function returns a negative value, lockdep
considers it will not cause deadlock.  (See ->cmp_fn() in
check_deadlock() and check_prev_add().)

When we cannot define the total ordering, we return -1 for
the allowed ordering and otherwise 0 as undefined. [0]

[0]: https://lore.kernel.org/netdev/thzkgbuwuo3knevpipu4rzsh5qgmwhklihypdgziiruabvh46f@uwdkpcfxgloo/


Changes:
  v4:
    * Patch 4
      * Make unix_state_lock_cmp_fn() symmetric.

  v3: https://lore.kernel.org/netdev/20240614200715.93150-1-kuniyu@amazon.com/
    * Patch 3
      * Cache sk->sk_state
      * s/unix_state_lock()/unix_state_unlock()/
    * Patch 8
      * Add embryo -> listener locking order

  v2: https://lore.kernel.org/netdev/20240611222905.34695-1-kuniyu@amazon.com/
   * Patch 1 & 2
      * Use (((l) > (r)) - ((l) < (r))) for comparison

  v1: https://lore.kernel.org/netdev/20240610223501.73191-1-kuniyu@amazon.com/


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

 include/net/af_unix.h |  14 ----
 net/unix/af_unix.c    | 151 ++++++++++++++++++++++++++++--------------
 net/unix/diag.c       |  47 ++++---------
 net/unix/garbage.c    |   8 +--
 4 files changed, 117 insertions(+), 103 deletions(-)

-- 
2.30.2


