Return-Path: <netdev+bounces-118978-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5D8953C64
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 23:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB7041F21A3F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 21:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A204146D60;
	Thu, 15 Aug 2024 21:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Rl6wFCi6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B558438DC7
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 21:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723756316; cv=none; b=HchMXal7TFo6hEKmMoC8pJIXOBkYN6NF8tIqCa9V1Tdlsbd9XSLo2x8gbdiBM+xo2bIjuKO9D94hWtGADGZGqJ2tSECFPbigQRvdyw1vROeI8R8kOrhg+FdeD3IzALqgnCy6N20YXJZWf9T+3wpSpsHW5WjA74w7//Hdc+Rf1Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723756316; c=relaxed/simple;
	bh=AxYXnddmpI/l0yzFmj5WAcB1dJpg6JabAnlkunSLZyQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VQmntiONrNgvJBCFkMR+q8MUUbio3sSD1E+ze9yXtJIx5qtm5TYPrGauK+UB1fFFtTDE8nUz/DQM7FhFSBn1vjZVH2z38MYqkgVv1rB7UWGRH0t4vqNAMZAy6VCFB2+Z7tuK6qKSRdWkq+8TsTryAFvLuwiYuwzKJunW3ZFyjDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Rl6wFCi6; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723756314; x=1755292314;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/O31I9VrR8vFmbcVT1sXPpvvkjYRzu8Yp5/khKDMQ24=;
  b=Rl6wFCi62hnmdsv0nZTtmkwF1S123ZhaLgNu+eWNYwBVHdMSWdVm7dEe
   dPWG3j0LvcPV+SWIQjdZVgjjj/7PkVc9mCTmnR4uIL1tE1NeNxZW/ssF7
   EJ2qq1xwMSiQ+Vm3O4ld+Yv/930Pt/lbC3yCx5LabcHlq2LDDfaLGXrCK
   8=;
X-IronPort-AV: E=Sophos;i="6.10,150,1719878400"; 
   d="scan'208";a="321385032"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2024 21:11:52 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:17119]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.7.18:2525] with esmtp (Farcaster)
 id 7af8d986-afce-4cc8-a6a8-364b8ea055c5; Thu, 15 Aug 2024 21:11:52 +0000 (UTC)
X-Farcaster-Flow-ID: 7af8d986-afce-4cc8-a6a8-364b8ea055c5
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 21:11:51 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.33) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 15 Aug 2024 21:11:48 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Roopa Prabhu
	<roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/2] net: Clean up af_ops->{get_link_af_size,fill_link_af}().
Date: Thu, 15 Aug 2024 14:11:35 -0700
Message-ID: <20240815211137.62280-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWB003.ant.amazon.com (10.13.138.85) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since commit 5fa85a09390c ("net: core: rcu-ify rtnl af_ops"),
af_ops->{get_link_af_size,fill_link_af}() are called under RCU.

Patch 1 makes the context clear and patch 2 removes unnecessary
rcu_read_lock().


Kuniyuki Iwashima (2):
  ipv4: Use RCU helper in inet_get_link_af_size() and
    inet_fill_link_af().
  net: bridge: Remove rcu_read_lock() in br_get_link_af_size_filtered().

 net/bridge/br_netlink.c | 2 --
 net/ipv4/devinet.c      | 6 ++----
 2 files changed, 2 insertions(+), 6 deletions(-)

-- 
2.30.2


