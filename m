Return-Path: <netdev+bounces-65156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 50BDE839601
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 18:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB1491F2A775
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB16A7F7F0;
	Tue, 23 Jan 2024 17:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="bHRgcA9Y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FFA187A
	for <netdev@vger.kernel.org>; Tue, 23 Jan 2024 17:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706029756; cv=none; b=LV5E4vidAF7YZpuJRzJEfRntQY3Dkr2j7/botoS0j/UVAHSpJUZ9lGzL1RM2du1zZuxg2+qjmgFUx2ise7EvdUyIr8WQv7zcsmcx8TbMf0YtTSNqJ7cCUYRN2fsHFf9OV/leRRz/99R2zzyfFyE2mLHYf8/F2t+SdGR9ugWNy+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706029756; c=relaxed/simple;
	bh=uOTyTU1B7uoW6B83LtnrPh41PglL/r/qSwDO5914h/g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KoVcTgmXOrT7Ff8Vz14tIgHQODASjR4fyflVkmcyBEVPxF7sVhB7K0Ts9jVWrxWFYi901gFhyH0JUacVUggyKoGgHh4VIGrAqxvXlRPLt80efwo+hWD5tNrwinZVihI6JfNAahYDmOMpVFPZrMowAhR9ThnYMNJt+NT7bgYePNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=bHRgcA9Y; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706029755; x=1737565755;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AFbSi9hPoxkgLIc4ZkZcnDID4VfCzjBm702L5FoYHuE=;
  b=bHRgcA9YSoqrdw68VfLCxcMIjp52rc8AK5vnF+0m2bdFAqMHMw8XfhQd
   uH1JFH7jdSacf82fvMdlQ5/9xOD1pypcVAr51DdRrHA5Lw9VVCS0Aj946
   Ek7CyiH4U5t/5z21jWOLPA7RvazHrRss5fg8cXCnpc+ZaTCitBrj1Ewl0
   A=;
X-IronPort-AV: E=Sophos;i="6.05,214,1701129600"; 
   d="scan'208";a="384128165"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2024 17:09:12 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (iad7-ws-svc-p70-lb3-vlan3.iad.amazon.com [10.32.235.38])
	by email-inbound-relay-iad-1d-m6i4x-f05d30a1.us-east-1.amazon.com (Postfix) with ESMTPS id 0C2548082B;
	Tue, 23 Jan 2024 17:09:10 +0000 (UTC)
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:4524]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.57:2525] with esmtp (Farcaster)
 id a31142dd-d48d-436d-838f-9bc885f97ebf; Tue, 23 Jan 2024 17:09:10 +0000 (UTC)
X-Farcaster-Flow-ID: a31142dd-d48d-436d-838f-9bc885f97ebf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 17:09:10 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 23 Jan 2024 17:09:07 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ivan Babrou <ivan@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 0/5] af_unix: Random improvements for GC.
Date: Tue, 23 Jan 2024 09:08:51 -0800
Message-ID: <20240123170856.41348-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

If more than 16000 inflight AF_UNIX sockets exist on a host, each
sendmsg() will be forced to wait for unix_gc() even if a process
is not sending any FD.

This series tries not to impose such a penalty on sane users who
do not send AF_UNIX FDs or do not have inflight sockets more than
SCM_MAX_FD * 8.

The first patch can be backported to -stable.

Cleanup patches for commit 69db702c8387 ("io_uring/af_unix: disable
sending io_uring over sockets") and large refactoring of GC will
be followed later.


Changes:
  v5:
    * Rebase on the latest
    * Add patch 1

  v4: https://lore.kernel.org/netdev/20231219030102.27509-1-kuniyu@amazon.com/
    * Rebase on the latest

  v3: https://lore.kernel.org/netdev/20231218075020.60826-1-kuniyu@amazon.com/
    * Patch 3
      * Reuse gc_in_progress flag.
      * Call flush_work() only when gc is queued or in progress.
    * Patch 4
      * Bump UNIX_INFLIGHT_SANE_USER to (SCM_MAX_FD * 8).

  v2: https://lore.kernel.org/netdev/20231123014747.66063-1-kuniyu@amazon.com/
    * Patch 4
      * Fix build error when CONFIG_UNIX=n

  v1: https://lore.kernel.org/netdev/20231122013629.28554-1-kuniyu@amazon.com/


Kuniyuki Iwashima (5):
  af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().
  af_unix: Do not use atomic ops for unix_sk(sk)->inflight.
  af_unix: Return struct unix_sock from unix_get_socket().
  af_unix: Run GC on only one CPU.
  af_unix: Try to run GC async.

 include/net/af_unix.h | 14 +++++--
 include/net/scm.h     |  1 +
 net/core/scm.c        |  5 +++
 net/unix/af_unix.c    | 10 +++--
 net/unix/garbage.c    | 98 ++++++++++++++++++++++---------------------
 net/unix/scm.c        | 27 ++++++------
 6 files changed, 85 insertions(+), 70 deletions(-)

-- 
2.30.2


