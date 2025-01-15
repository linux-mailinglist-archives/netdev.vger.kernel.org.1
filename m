Return-Path: <netdev+bounces-158448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B33A11EA7
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:56:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C7DB1888467
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 09:56:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429001D5143;
	Wed, 15 Jan 2025 09:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XhQJY4Je"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8C1248171
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 09:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736934976; cv=none; b=IPSKB/zsvDaKPodzsBnFKhm3V+ye/E76Dhi4S0pGuhGgpJ1OQqfZxVicDBUqYqaPoSd1fQnXdOR4/fz+US23tkhFb9MQjaiH66/wriM/nJIT9OH45vLg6tv036P4kpUkpaNSRyKV/DByeK5Giafd/LDXs5LK3txFKIH+wiL/bwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736934976; c=relaxed/simple;
	bh=Du6xvKtYvthC01IyY6qHw7hqrHmMy/7GINdwnBytwyw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Fk9Q+RDEJbf8MXC2DRlfEMzpgLbknzbdGmSM8LlhkDtpTDeZt28/zRuq4Wa3moO4yhykOt/A8FLH0HvShr6JxhOLEvbjLGC6Cm5sH+z1dgY/APMbe57fgfH/6YXpBkK2nkR7DKfX1nZd7qkk2fTrKXhRV09TgISqSKjWac6pn/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XhQJY4Je; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736934973; x=1768470973;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=mb1bE7gwtL22TS2GVVgYpu5Ana06xV+tTRv58Nfon4I=;
  b=XhQJY4JeLbGiSXWIdOjyBkpzvMRM+aKjhnk/jQIibVCwm8IzNID4MgCb
   R9TuB8Zww8bNLWMqLJ71XDXlRruq3Ys58IBvNOzIwTtJfNwYRybrDhdAP
   h1XCm5bfT/Afe42o3buyP6C0H7/11mOtt+VxPN72NUqDLbMsGwf6iGQ62
   w=;
X-IronPort-AV: E=Sophos;i="6.12,316,1728950400"; 
   d="scan'208";a="454366443"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 09:56:09 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:58766]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.236:2525] with esmtp (Farcaster)
 id 925548d7-b0da-432d-92cc-8e235cefa625; Wed, 15 Jan 2025 09:56:08 +0000 (UTC)
X-Farcaster-Flow-ID: 925548d7-b0da-432d-92cc-8e235cefa625
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:56:00 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.2.246) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 15 Jan 2025 09:55:56 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/3] dev: Covnert dev_change_name() to per-netns RTNL.
Date: Wed, 15 Jan 2025 18:55:42 +0900
Message-ID: <20250115095545.52709-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 adds a missing netdev_rename_lock in dev_change_name()
and Patch 2 removes unnecessary devnet_rename_sem there.

Patch 3 replaces RTNL with rtnl_net_lock() in dev_ifsioc(),
and now dev_change_name() is always called under per-netns RTNL.

Given it's close to -rc8 and Patch 1 touches the trivial unlikely
path, can Patch 1 go into net-next ?  Otherwise I'll post Patch 2 & 3
separately in the next cycle.


Kuniyuki Iwashima (3):
  dev: Acquire netdev_rename_lock before restoring dev->name in
    dev_change_name().
  dev: Remove devnet_rename_sem.
  dev: Hold rtnl_net_lock() for dev_ifsioc().

 net/core/dev.c            | 25 ++++++-------------------
 net/core/dev_ioctl.c      | 26 +++++++++++++++++---------
 net/core/rtnl_net_debug.c | 15 +++------------
 3 files changed, 26 insertions(+), 40 deletions(-)

-- 
2.39.5 (Apple Git-154)


