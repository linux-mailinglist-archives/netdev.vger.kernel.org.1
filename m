Return-Path: <netdev+bounces-90250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AE78AD521
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 21:48:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 294B7B22F40
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 19:48:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B644154453;
	Mon, 22 Apr 2024 19:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="d/k6R6S5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D91153BFB
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 19:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713815299; cv=none; b=mlH8uPaA6lm5Q5DART0FjdnVaeRS9mp8X2Q9Idd8D9yS7jiJaa64KF9DNVLQOtZ4GwNttwIf1ZsfQmowC5+L5hxpMfwJef6iC/IAarmxpHLJXHyDKKg6DtaXr5HrAyYAwWwDShn98Y1J207yN6DnvNiYMOf7h3d1AynuYCsqzv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713815299; c=relaxed/simple;
	bh=tlXAgK9tqMTMLSi/STrPg83yjqBdHB/i2K1T4YnF6uM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TJsp4hIaMdIN93I5/2TeVJKwTo0K2Eilagu1V1Knfe+/3vOlTyEEQGtRO/nj8enLfBQQMuLsL/z7Zmsqo0bX0suUJjALKKFfIWbol0ZsoEjwBPVvyj/Bk5LE7WmQ65aQF6c+3cNFRk3ZhDZc8dkDLZ0MFj1gNcIHFvD9WsaWAjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=d/k6R6S5; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1713815298; x=1745351298;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gqAXnI8AraTRqcvHXD5VLFaGARNIDxjRyE9uLlGpwGM=;
  b=d/k6R6S5xOaT9iqNXsatgWItkhfjYDlPSLe5YVYR1TyISk1fwG6LB6cx
   ICssVrNKgWt5owUrZdG7atNm8pHTzd0pKlaz1oKbz9cDIqOyPE6j5FLLB
   E3y0cCvJFwlLcPW7dw+RWItlOH0KEno5RJaDOJwe4edr3zmBVjfSb1Vvg
   w=;
X-IronPort-AV: E=Sophos;i="6.07,221,1708387200"; 
   d="scan'208";a="413810732"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2024 19:48:12 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:6509]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.80:2525] with esmtp (Farcaster)
 id a7d666d1-d44a-4599-8bfd-785fcafc64a1; Mon, 22 Apr 2024 19:48:11 +0000 (UTC)
X-Farcaster-Flow-ID: a7d666d1-d44a-4599-8bfd-785fcafc64a1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 19:48:11 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.48) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 22 Apr 2024 19:48:08 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/6] arp: Random clean up and RCU conversion for ioctl(SIOCGARP).
Date: Mon, 22 Apr 2024 12:47:49 -0700
Message-ID: <20240422194755.4221-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB003.ant.amazon.com (10.13.138.8) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

arp_ioctl() holds rtnl_lock() regardless of cmd (SIOCDARP, SIOCSARP,
and SIOCGARP) to get net_device by __dev_get_by_name().

In the SIOCGARP path, arp_req_get() calls neigh_lookup(), which looks
up a neighbour entry under RCU.

This series cleans up ioctl() code a bit and extends the RCU section not
to take rtnl_lock() and instead use dev_get_by_name_rcu() for SIOCGARP.


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


