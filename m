Return-Path: <netdev+bounces-66849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 258B88412FF
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 20:05:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B83481F22E84
	for <lists+netdev@lfdr.de>; Mon, 29 Jan 2024 19:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C805114290;
	Mon, 29 Jan 2024 19:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="U32fXG6I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3FC12E74
	for <netdev@vger.kernel.org>; Mon, 29 Jan 2024 19:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706555095; cv=none; b=O3J+J1EC4rhk0+y/R3R3ix8IbnDGn876onOvDcF05rC9GfwCPE55fMSkmuosLkU0qxutBme5tuJZ029glq3/R9iA8d5Rwjp07MPcytec1mO6wv7ZVRauvODc8RJQM+IMPdGQsqgH2h1kYk5nbjXk3GwM2Tn5uoFKA+Ij7uSqqg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706555095; c=relaxed/simple;
	bh=4uwPElnOZe5qmuxnqusPQKxxmjLjKvRBSmRjMS1sFt0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ad76KFzl1jbhp8Cp4RCi3v8MfaMQIN0pGU+/f5DsIa4jMjn9OxHLbmgk3CyswzmFBRVyLISuw9Xmk7K0lbpmWr3wYf2csDcm0ovEEpqX8rX2B+iqbm4mgRMjxavSR0re4pgBuDP3aBv/3/i4FDw5DsBCOQYUGiUvcoT0Mah/ObY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=U32fXG6I; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1706555094; x=1738091094;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=fP/BOUuR6hVMyYO10iBzlnpfyM2HMCeYrcoQLi4WZJU=;
  b=U32fXG6Id2GM66oDP0oyigvLI22dqJXbSCg5H86SXbrW9A3rNtddC8BU
   IbI6OLqH8euzOYlj7pumFiCHBgspBNYerlAKKPu9RehcnigskhZpCro4d
   CkoEEnJQo4fLF33LBsCrGBsKHWvbXlbs0YB4ekNVsRSOWOJsNJ44tkvXK
   4=;
X-IronPort-AV: E=Sophos;i="6.05,227,1701129600"; 
   d="scan'208";a="630650243"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 19:04:51 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:1870]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.48.50:2525] with esmtp (Farcaster)
 id baa4a042-80fd-4d8e-b653-307c61c12c57; Mon, 29 Jan 2024 19:04:49 +0000 (UTC)
X-Farcaster-Flow-ID: baa4a042-80fd-4d8e-b653-307c61c12c57
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 29 Jan 2024 19:04:48 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.40;
 Mon, 29 Jan 2024 19:04:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Jens Axboe <axboe@kernel.dk>, Pavel Begunkov <asml.silence@gmail.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/3] af_unix: Remove io_uring dead code in GC.
Date: Mon, 29 Jan 2024 11:04:32 -0800
Message-ID: <20240129190435.57228-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA001.ant.amazon.com (10.13.139.83) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

I will post another series that rewrites the garbage collector for
AF_UNIX socket.

This is a prep series to clean up changes to GC made by io_uring but
now not necessary.


Kuniyuki Iwashima (3):
  af_unix: Replace BUG_ON() with WARN_ON_ONCE().
  af_unix: Remove io_uring code for GC.
  af_unix: Remove CONFIG_UNIX_SCM.

 include/net/af_unix.h |   8 +--
 net/Makefile          |   2 +-
 net/unix/Kconfig      |   5 --
 net/unix/Makefile     |   2 -
 net/unix/af_unix.c    |  63 ++++++++++++++++-
 net/unix/garbage.c    | 106 ++++++++++++++++++++--------
 net/unix/scm.c        | 156 ------------------------------------------
 net/unix/scm.h        |  10 ---
 8 files changed, 143 insertions(+), 209 deletions(-)
 delete mode 100644 net/unix/scm.c
 delete mode 100644 net/unix/scm.h

-- 
2.30.2


