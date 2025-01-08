Return-Path: <netdev+bounces-156164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F7A9A05330
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 07:28:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E5D3A514C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 06:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9D941A7249;
	Wed,  8 Jan 2025 06:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Ml1ADJKF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2391153836
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 06:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736317734; cv=none; b=o8ODiXCt0FPy++So1Q+mG6RyQfWV10PwwcBst43wOGKK/4ffPlSgvP9kkTMkr9LvG+9AKrGlt8F49yEiIqX3QWJaZ8vT6UzK+AtMAoWRTxy67QXCRPOFsKtm9ju/RPU/aH/ABzU0u1wmDKGY6IAS/Jt0BoxCK48BmzlDjaNXFxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736317734; c=relaxed/simple;
	bh=J+5NWX+NFPVZ+/lvikCjRPQsUfgXsxas67j3ux2mNw8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PrPNm+9ITkPNJBhl09pyK+NskDYR/QUgpNgGvnQrgnbM0U+g7Bj3tjVzKeOoiI2JLW8lIC/J4GDYql8rjmGN6slerUGciIaKwJ4s47hMFxzy3qHB83wMz3I4TiQB9wgHx7p7bViVb8+lbSEedAecFVM1lTkZyICvlclMKhS34J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Ml1ADJKF; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736317732; x=1767853732;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ei5Gcr15TePzHt2Sfe5FL8Gn1RlD7NBrHp8rNbcZp1U=;
  b=Ml1ADJKFu8txBT85xYQiQMMQMxZDigI1O1+zqJtjhd1v/bpoa9c/iaS2
   q0sW8+MOeO2rBDx18haAyTO90+qmd4aUOVwsFffMuaaVAc5IpS+p4ux+I
   ZfkrQTIrssobHMsSsRnKDiK4nS0SwmWsf5clnpwDCikTqc+GKNF2hGGGO
   c=;
X-IronPort-AV: E=Sophos;i="6.12,297,1728950400"; 
   d="scan'208";a="56093422"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 06:28:48 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:10677]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.48:2525] with esmtp (Farcaster)
 id 256676d4-f06d-4a38-b3d9-4dc0b666719c; Wed, 8 Jan 2025 06:28:49 +0000 (UTC)
X-Farcaster-Flow-ID: 256676d4-f06d-4a38-b3d9-4dc0b666719c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 8 Jan 2025 06:28:48 +0000
Received: from 6c7e67c6786f.amazon.com (10.37.244.7) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 8 Jan 2025 06:28:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Simon Horman
	<horms@kernel.org>
CC: Xiao Liang <shaw.leon@gmail.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 0/3] gtp/pfcp: Fix use-after-free of UDP tunnel socket.
Date: Wed, 8 Jan 2025 15:28:31 +0900
Message-ID: <20250108062834.11117-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWA003.ant.amazon.com (10.13.139.6) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Xiao Liang pointed out weird netns usages in ->newlink() of
gtp and pfcp.

This series fixes the issues.

Link: https://lore.kernel.org/netdev/20250104125732.17335-1-shaw.leon@gmail.com/


Kuniyuki Iwashima (3):
  gtp: Use for_each_netdev_rcu() in gtp_genl_dump_pdp().
  gtp: Destroy device along with udp socket's netns dismantle.
  pfcp: Destroy device along with udp socket's netns dismantle.

 drivers/net/gtp.c  | 21 +++++++++++++++------
 drivers/net/pfcp.c | 15 ++++++++++-----
 2 files changed, 25 insertions(+), 11 deletions(-)

-- 
2.39.5 (Apple Git-154)


