Return-Path: <netdev+bounces-130683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E40598B292
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 04:53:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B801C25BCC
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 02:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CEA4D8B9;
	Tue,  1 Oct 2024 02:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="c7TVW2s4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7533BB30
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 02:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727750942; cv=none; b=OiiemtJoSVcP0AK9qK90qd1AbBLH847UEv8zbBxdmsa5Gp7Uaup1Duw8UKQq+l+OQK77B01VTnEXa4NKGHaWcKIe/bwKpz2vT3kvBpLjsQMHWQE7LnaM74cgwvhZ1knay1G4h69AMlTPuEMwv1rWIrEVWO9JMcbjXeMPlP5ylhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727750942; c=relaxed/simple;
	bh=NHYy8IqOBdiuUbIhWZfIbaqeuDXdyIkDzC6M8IUwppM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=akPO6r4hl0LlhJ6cqZS2jHxMaHr08lkFeK8JT8GMhQyE6Akzw0rYmrR/dT9EbmNlKyZHmQK+tX6RYZdBHaK+iRoPjKScu+Spgk0vgRzAjDMhgFU+TN2PIpg9w3+8JDywUEdT+ODtSLIZS3WyEPwgX7qCWp8xkF9q8tjLBguq7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=c7TVW2s4; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727750940; x=1759286940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P16m3D/uCi1xzRvU5yYpicdPgi+MNSZoqM63IltHPto=;
  b=c7TVW2s4YB1MItp34Y5QdieWqJA+ebBwnT1ZhstKPKkypQ99ZLowh/N4
   SL5/uxDlvkhpykeCD/I6qvJUu4vX52KsgokX2TaldPcQtV0x82DUiOxXZ
   l1P7rTaaw5v6YixCBKtGKSTi4AN1U/5GolL7nak+LDdkN1uch5C46axFV
   Y=;
X-IronPort-AV: E=Sophos;i="6.11,167,1725321600"; 
   d="scan'208";a="133233405"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 02:48:58 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:21530]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.191:2525] with esmtp (Farcaster)
 id cdf94514-ec86-4848-9cf5-0eba83a3b0a6; Tue, 1 Oct 2024 02:48:58 +0000 (UTC)
X-Farcaster-Flow-ID: cdf94514-ec86-4848-9cf5-0eba83a3b0a6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 02:48:57 +0000
Received: from 88665a182662.ant.amazon.com (10.1.212.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 1 Oct 2024 02:48:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/5] ipv4: Namespacify IPv4 address hash table.
Date: Tue, 1 Oct 2024 05:48:32 +0300
Message-ID: <20241001024837.96425-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

This is a prep of per-net RTNL conversion for RTM_(NEW|DEL|SET)ADDR.

Currently, each IPv4 address is linked to the global hash table, and
this needs to be protected by another global lock or namespacified to
support per-net RTNL.

Adding a global lock will cause deadlock in the rtnetlink path and GC,

  rtnetlink                      check_lifetime
  |- rtnl_net_lock(net)          |- acquire the global lock
  |- acquire the global lock     |- check ifa's netns
  `- put ifa into hash table     `- rtnl_net_lock(net)

so we need to namespacify the hash table.

The IPv6 one is already namespacified, let's follow that.


Kuniyuki Iwashima (5):
  ipv4: Link IPv4 address to per-net hash table.
  ipv4: Use per-net hash table in inet_lookup_ifaddr_rcu().
  ipv4: Namespacify IPv4 address GC.
  ipv4: Retire global IPv4 hash table inet_addr_lst.
  ipv4: Trigger check_lifetime() only when necessary.

 include/linux/inetdevice.h |   2 +-
 include/net/netns/ipv4.h   |   3 ++
 net/ipv4/devinet.c         | 106 +++++++++++++++++++++++++------------
 3 files changed, 76 insertions(+), 35 deletions(-)

-- 
2.30.2


