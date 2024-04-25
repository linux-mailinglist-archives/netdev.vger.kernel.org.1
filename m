Return-Path: <netdev+bounces-91395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C24F8B270E
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 19:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 138E01F23187
	for <lists+netdev@lfdr.de>; Thu, 25 Apr 2024 17:00:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02D3213328D;
	Thu, 25 Apr 2024 17:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="LICphX71"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EC214A61B
	for <netdev@vger.kernel.org>; Thu, 25 Apr 2024 17:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714064423; cv=none; b=elmj/vRD1RUZ9t6BxbRmLW0YApRKx+npvZyBQm3hOy3Kz7PRljmNZAsNpeu3a3zHXtFFMly/2MwSFjOg/tTQaTsqhohvlS/1UIBFV527qpOrL9Hjq/2/g8NstlI+cH85MN3DcSaDQFXTE4OzpGs+OlTKReBZ6MZUa+Yva+adCKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714064423; c=relaxed/simple;
	bh=jrwdc8e9mE2PY7AYwCv1mwV+RNQW0jubWbnVwfqX9/Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=qf3Y8y1t3wV13cDVM6CmP/Wm37UdtUlGqUnlPqBpANTvUZokFbBEXWz9gEpQfIrSzlyD2H5VXnOtMdptgUE0Ifx+yi57DrhE2/L9tXmdJuocX+wt5lvbFZSrzu/uvR/Xg8fRtmZHoVE3lF3M+hwtM13PUWsUrKKC5Nh2RUn3qwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=LICphX71; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1714064422; x=1745600422;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=adeD4feJ+0YrAMlbtARziRxfX1dHARWogh7uUQwdkmk=;
  b=LICphX71EpcU3hrRCCG/sbRNzC1MvfphAusVq4q7xNRidQ9F6L2fV1r0
   UIMkmnY1V2Gze4yjNac3MOjC3KcnhHNAMfMzn6cKGaW2Hw/ru7ujgFkWb
   859MNDBGAWZum3ooPcXgPj5bSU2zSPeyeGDdL/R5ok8xxaf0LnSuS9lsa
   A=;
X-IronPort-AV: E=Sophos;i="6.07,230,1708387200"; 
   d="scan'208";a="392472715"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Apr 2024 17:00:20 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:7060]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.14.6:2525] with esmtp (Farcaster)
 id c190c1e3-3ff9-457b-a878-3f92c7cf4590; Thu, 25 Apr 2024 17:00:18 +0000 (UTC)
X-Farcaster-Flow-ID: c190c1e3-3ff9-457b-a878-3f92c7cf4590
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:00:18 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 25 Apr 2024 17:00:15 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/6] arp: Random clean up and RCU conversion for ioctl(SIOCGARP).
Date: Thu, 25 Apr 2024 09:59:56 -0700
Message-ID: <20240425170002.68160-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

arp_ioctl() holds rtnl_lock() regardless of cmd (SIOCDARP, SIOCSARP,
and SIOCGARP) to get net_device by __dev_get_by_name().

In the SIOCGARP path, arp_req_get() calls neigh_lookup(), which looks
up a neighbour entry under RCU.

This series cleans up ioctl() code a bit and extends the RCU section not
to take rtnl_lock() and instead use dev_get_by_name_rcu() for SIOCGARP.


Changes:
  v2:
    Patch 5: s/!IS_ERR/IS_ERR/ in arp_req_delete().

  v1: https://lore.kernel.org/netdev/20240422194755.4221-1-kuniyu@amazon.com/


Kuniyuki Iwashima (6):
  arp: Move ATF_COM setting in arp_req_set().
  arp: Validate netmask earlier for SIOCDARP and SIOCSARP in
    arp_ioctl().
  arp: Factorise ip_route_output() call in arp_req_set() and
    arp_req_delete().
  arp: Remove a nest in arp_req_get().
  arp: Get dev after calling arp_req_(delete|set|get)().
  arp: Convert ioctl(SIOCGARP) to RCU.

 net/ipv4/arp.c | 203 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 123 insertions(+), 80 deletions(-)

-- 
2.30.2


