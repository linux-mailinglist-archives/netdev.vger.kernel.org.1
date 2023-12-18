Return-Path: <netdev+bounces-58451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DFF8167B8
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 08:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 359341F22485
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 07:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F268E549;
	Mon, 18 Dec 2023 07:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kZ/6w0Up"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CF410780
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 07:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1702885842; x=1734421842;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Z8ZTL5XhiUIMBPxYvkf/xAqswczGBrxv6vZ1YHxREgw=;
  b=kZ/6w0UprU8Ehku7+lP30mRmzOcA+qGxfR8jOoaEj8e8XlIRwDFlpiCV
   7G64rNT2X55e+K+UjMvsAX6RZPyJiHoCt7nTudus768OtG9ZIhQKEGLio
   gIDQWscbvXPNQalLlIFE3XasyasQje7TE07TgJPT2+AtXTUVR4+GwS5f/
   U=;
X-IronPort-AV: E=Sophos;i="6.04,284,1695686400"; 
   d="scan'208";a="51916101"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Dec 2023 07:50:39 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
	by email-inbound-relay-pdx-2c-m6i4x-e7094f15.us-west-2.amazon.com (Postfix) with ESMTPS id BB7BE40BBD;
	Mon, 18 Dec 2023 07:50:38 +0000 (UTC)
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:19542]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.19.109:2525] with esmtp (Farcaster)
 id 57af6ce3-acba-4258-909b-6c057788f8a8; Mon, 18 Dec 2023 07:50:38 +0000 (UTC)
X-Farcaster-Flow-ID: 57af6ce3-acba-4258-909b-6c057788f8a8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 07:50:38 +0000
Received: from 88665a182662.ant.amazon.com (10.119.9.19) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Mon, 18 Dec 2023 07:50:34 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Ivan Babrou <ivan@cloudflare.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 0/4] af_unix: Random improvements for GC.
Date: Mon, 18 Dec 2023 16:50:16 +0900
Message-ID: <20231218075020.60826-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWC002.ant.amazon.com (10.13.139.212) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)
Precedence: Bulk

If more than 16000 inflight AF_UNIX sockets exist on a host, each
sendmsg() will be forced to wait for unix_gc() even if a process
is not sending any FD.

This series tries not to impose such a penalty on sane users who
do not send AF_UNIX FDs or do not have inflight sockets more than
SCM_MAX_FD * 8.


Changes:
  v3:
    * Patch 3
      * Reuse gc_in_progress flag to avoid a small race and expensive work_busy().
      * Call flush_work() only when gc is queued or in progress.
    * Patch 4
      * Bump UNIX_INFLIGHT_SANE_USER to SCM_MAX_FD * 8.

  v2: https://lore.kernel.org/netdev/20231123014747.66063-1-kuniyu@amazon.com/
    * Patch 4
      * Fix build error when CONFIG_UNIX=n

  v1: https://lore.kernel.org/netdev/20231122013629.28554-1-kuniyu@amazon.com/


Kuniyuki Iwashima (4):
  af_unix: Do not use atomic ops for unix_sk(sk)->inflight.
  af_unix: Return struct unix_sock from unix_get_socket().
  af_unix: Run GC on only one CPU.
  af_unix: Try to run GC async.

 include/linux/io_uring.h |  4 +-
 include/net/af_unix.h    |  6 +--
 include/net/scm.h        |  1 +
 io_uring/io_uring.c      |  5 ++-
 net/core/scm.c           |  5 +++
 net/unix/af_unix.c       | 10 +++--
 net/unix/garbage.c       | 83 +++++++++++++++++++++-------------------
 net/unix/scm.c           | 34 ++++++++--------
 8 files changed, 79 insertions(+), 69 deletions(-)

-- 
2.30.2


