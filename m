Return-Path: <netdev+bounces-156928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC27A08502
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 02:48:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2DF3A8D69
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 01:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C4E42A80;
	Fri, 10 Jan 2025 01:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HIb7R0Bx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB6618C31
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 01:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736473695; cv=none; b=DzlhocCJ3qxxtYs2X2xs6IBQRcEZd3O9heR8rq+DKChLJWzYoKblj1VUBw+J6UhkZ0ej9alqN9y3ichBTa06Lxk93DnmI7ff0HFmM5ywF9mZOWBnljlah1IgvXBdmHBzBgvBrXvV0ESyIbxeaAaBWtgt2CgOQuYvmoqdOgmj3cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736473695; c=relaxed/simple;
	bh=tEQcEUku0ipBuDMKKOJFn7sPaUeFVIRyEC4lqGE1pd0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WIgUjJGk7YUV9ajSZ16LzMX7ar3r3/KGTmknDhejq9Jnl8eXEkHta3R1uqyI/Gn81iXthFG9Q5YIXdSBmneHMGppNZfCuqImUTg6KVPPaypzRmfeudUCYUlRA4XN1CgOuQHVWoYY1yvBzISFcJ+aZvjMLTxZgqUR3gAs+tzvV/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HIb7R0Bx; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736473694; x=1768009694;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jQA7gI6vjh4sHEuqpL+jpUDK3hL07hi7aL72TvCw0U8=;
  b=HIb7R0BxInLYuRVbKY0XrxLiDPJSguvhyYiGbEwcaxeFZJO/FFMK6Cps
   YtqWJkEe1pX/iEX8ux/cIL0oHBSB5rLoqC4iFxIfzgMOkKRfdG9wFa2o/
   mDeCTmKMAvtUNFW9i8ppeGLhufw64GYVzG8LKbz+hTVNj7WINTGAvyeY4
   I=;
X-IronPort-AV: E=Sophos;i="6.12,302,1728950400"; 
   d="scan'208";a="457773324"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 01:48:10 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:43068]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.63.9:2525] with esmtp (Farcaster)
 id ba9ef0c5-32ca-4266-805f-ebeaa4ecb28e; Fri, 10 Jan 2025 01:48:09 +0000 (UTC)
X-Farcaster-Flow-ID: ba9ef0c5-32ca-4266-805f-ebeaa4ecb28e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 01:48:08 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 01:48:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
	<horms@kernel.org>
CC: Xiao Liang <shaw.leon@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 0/3] gtp/pfcp: Fix use-after-free of UDP tunnel socket.
Date: Fri, 10 Jan 2025 10:47:51 +0900
Message-ID: <20250110014754.33847-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

Xiao Liang pointed out weird netns usages in ->newlink() of
gtp and pfcp.

This series fixes the issues.

Link: https://lore.kernel.org/netdev/20250104125732.17335-1-shaw.leon@gmail.com/


Changes:
  v2:
    * Patch 1
      * Fix uninit/unused local var

  v1: https://lore.kernel.org/netdev/20250108062834.11117-1-kuniyu@amazon.com/


Kuniyuki Iwashima (3):
  gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().
  gtp: Destroy device along with udp socket's netns dismantle.
  pfcp: Destroy device along with udp socket's netns dismantle.

 drivers/net/gtp.c  | 26 +++++++++++++++++---------
 drivers/net/pfcp.c | 15 ++++++++++-----
 2 files changed, 27 insertions(+), 14 deletions(-)

-- 
2.39.5 (Apple Git-154)


