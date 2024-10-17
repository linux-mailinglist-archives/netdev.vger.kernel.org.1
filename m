Return-Path: <netdev+bounces-136725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 386729A2C34
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 20:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A823FB259FF
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:32:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F44917ADF8;
	Thu, 17 Oct 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qjgkjDxE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDD0E42AB9
	for <netdev@vger.kernel.org>; Thu, 17 Oct 2024 18:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729189917; cv=none; b=nLc304pIfmlKj6xY8B4OgD+rYueksk8QX1eIknmmpsP6hmVveYNQ32IUh1piP+8qTXmgUaMKSb8d067+eMUkxI2UN/XHdNPq3bnGsJRxebcLXW/jSDyRa1C+hGYO3YtMWFonM0PY+4d2iZZRxO+hur/7bj1wSJNRiIQWux3OqQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729189917; c=relaxed/simple;
	bh=el8dMddJAUPWXGtyzmsHfib4ldSh6qRw5yB0sbDgoDw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hv1N+vxFi9w0wZ9c3lofRatqii0CcEosUIUqjwXGYwowR77PWZQ60Gj/l7cAqRqoTyxZpIOeTsJTrhv/8+jMUo2CCy6XxoYubhTdVyRNWh/MXsxaLwyLqJtNfv6LQ78o6uDwI8/qy8QBVzDaHZwXNTdcjcmlypYTkz8By+9clLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qjgkjDxE; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729189916; x=1760725916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FIpiHGZ3/jFDPVEM+C2cdmOe2W/GCXV2ig4cfu7oZXE=;
  b=qjgkjDxEYMYEP6Ztpo87mi7IDK0oG27NMYcBm2Jk0ruRY87x7s4/WyZv
   +a2Pu6bpQsR6QuBPT+GZTkNv3N8Zsgil5nI1HdYPhRCUE62HK9XjkHQoL
   n9ATELc9oW76g6PQGOTME8O2EdO/QRbNBahjL2iXxp05w2x3Lt0XW5hPu
   s=;
X-IronPort-AV: E=Sophos;i="6.11,211,1725321600"; 
   d="scan'208";a="461950261"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2024 18:31:49 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:39862]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id 2ebca994-df1c-4daa-a07d-56839792441e; Thu, 17 Oct 2024 18:31:48 +0000 (UTC)
X-Farcaster-Flow-ID: 2ebca994-df1c-4daa-a07d-56839792441e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 17 Oct 2024 18:31:48 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 17 Oct 2024 18:31:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Remi Denis-Courmont <courmisch@gmail.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/9] phonet: Convert all doit() and dumpit() to RCU.
Date: Thu, 17 Oct 2024 11:31:31 -0700
Message-ID: <20241017183140.43028-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWA003.ant.amazon.com (10.13.139.49) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

addr_doit() and route_doit() access only phonet_device_list(dev_net(dev))
and phonet_pernet(dev_net(dev))->routes, respectively.

Each per-netns struct has its dedicated mutex, and RTNL also protects
the structs.  __dev_change_net_namespace() has synchronize_net(), so
we have two options to convert addr_doit() and route_doit().

  1. Use per-netns RTNL
  2. Use RCU and convert each struct mutex to spinlock_t

As RCU is preferable, this series converts all PF_PHONET's doit()
and dumpit() to RCU.

4 doit()s and 1 dumpit() are now converted to RCU, 70 doit()s and
28 dumpit()s are still under RTNL.


Kuniyuki Iwashima (9):
  phonet: Pass ifindex to fill_addr().
  phonet: Pass net and ifindex to phonet_address_notify().
  phonet: Convert phonet_device_list.lock to spinlock_t.
  phonet: Don't hold RTNL for addr_doit().
  phonet: Don't hold RTNL for getaddr_dumpit().
  phonet: Pass ifindex to fill_route().
  phonet: Pass net and ifindex to rtm_phonet_notify().
  phonet: Convert phonet_routes.lock to spinlock_t.
  phonet: Don't hold RTNL for route_doit().

 include/net/phonet/pn_dev.h |   8 +--
 net/phonet/pn_dev.c         |  69 ++++++++++++++--------
 net/phonet/pn_netlink.c     | 115 ++++++++++++++++++++++--------------
 3 files changed, 120 insertions(+), 72 deletions(-)

-- 
2.39.5 (Apple Git-154)


