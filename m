Return-Path: <netdev+bounces-156046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93310A04BE0
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 22:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CF521888054
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 21:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EDBA1F63F4;
	Tue,  7 Jan 2025 21:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="PzE6BqyQ"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E2D1F669F
	for <netdev@vger.kernel.org>; Tue,  7 Jan 2025 21:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736286133; cv=none; b=I4wOtfmB46Sfc4xYp5UXqF6pp6sBkBP6lPUu1gbztaCuDawZZtj1AnuYkvltrThPn72tkJ+so5OhqUdAo5SzQe89AklCxCJF+/3XFVsSzdBY+cYX4DP6f4rcaImImt8QPq35CDWh1McQBp72ZfQ1h4NDvqNLj3ycHvbMvpOMEPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736286133; c=relaxed/simple;
	bh=DDg4zvG3aylXhey39cXjKIuyk6ivRFZpppNNETtIQEM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HDT6+sZV3KxnKtaM5q/F4zGe0aRli64EOQKPG3kPAK5JoapUoIjDtWNutuoEUOupvPftIBxHZrQD4JNYruQzoQ1YfibHQNejXvWWK9Pu0aJFor7JLSJVw2mcK9Gq18AJTLMWbeAUTdsZZjPU5Tr1tbXaLT9y7Lmmk68g1TZvM+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=PzE6BqyQ; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=610; q=dns/txt; s=iport;
  t=1736286131; x=1737495731;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LQhSOnvivb8ZgnWSVZrg7tGm59OVHpdEwuvdiTP0918=;
  b=PzE6BqyQ3VsZyc6KPU4PMBn/oWYyvjCr5FDOJYAi/TTPkFjvttPl3Idd
   kikr/1yAlYauDPyj/Y7gqB2yuhz+Psrd20PGtSiqmXTY4oxfwWCIAt+E/
   LJg/ojrWpleW28S8OwRFALdeDMXBz91VbCJHnGehI0V3T3J8PgojCljP4
   E=;
X-CSE-ConnectionGUID: p+GipP4HSVeu85Uk1OtBGQ==
X-CSE-MsgGUID: 66zx7GOtT1ecaY3HkyfklA==
X-IPAS-Result: =?us-ascii?q?A0AjAQCVnn1nj48QJK1aHgEBCxIMgggLhBpDSI1Rpw2BJ?=
 =?us-ascii?q?QNWDwEBAQ9EBAEBhQeKdgImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQEBCwEBB?=
 =?us-ascii?q?QEBAQIBBwUUAQEBAQEBOQUOO4YIhl02AUaBDDISgwGCZQOxQoIsgQHeM4Ftg?=
 =?us-ascii?q?UiFa4dfcIR3JxuBSUSEDm+FEIV3BIIzgUiDbp4JSIEhA1ksAVUTDQoLBwWBO?=
 =?us-ascii?q?ToDIgsLDAsUHBUCFR8SBhEEbkQ3gkZpSzcCDQI1gh4kWIIrhFyER4RYgktVg?=
 =?us-ascii?q?kiCF3yBHYMWQAMLGA1IESw3Bg4bBj5uB5p1PINvgQ58gRmTfJIfoQOEJYFjn?=
 =?us-ascii?q?2MaM4NxpmKYfCKkJYRmgWc6gVszGggbFYMiUhkPjjq5MCUyPAIHCwEBAwmRV?=
 =?us-ascii?q?QEB?=
IronPort-Data: A9a23:8WNUMamWLmSsv9p2x9aiBO3o5gxbJkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJJCjqGbqmPYDPze9sgPd6/8xlTucKDm4cwGVdp/CozFVtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/rav658CEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+pe31GONgWYubzpNs/3b8nuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FZVb1edvOT1uz
 sIVNWBQUxPaoP6c74vuH4GAhux7RCXqFIobvnclyXTSCuwrBMidBa7L/tRfmjw3g6iiH96HO
 JFfMmQpNUqGOkEUUrsUIMpWcOOAhH7/dTFRrF+9rqss6G+Vxwt0uFToGIaMJ4bRGJkFxC50o
 EqYoXbpXT49KODGxDGMwymMhf7BnifSDdd6+LqQraMy3wbJmQT/EiY+WVKlrPyRhkegVtdbL
 EIIvCwjscAa+UC2S9DvUgGQr3mDsRoRHdFXFoUS6xyHw4LX7hyfC2xCSSROAPQvssMsSCNp0
 FKVk973LThytrvTQnL13q+dpz60OAAPIGMCbDNCRgwAi/HlrZ0/gwznUNluCui2g8fzFDW2x
 CqFxBXSnJ0aicoNkqH+9lfdjnf0+N7CTxU+4UPcWWfNAh5FiJCNf8+H6EDjsdZ7EouEHgS8v
 yEjh+Kx1bVbZX2SrxClTOIIFbCvwv+KNjzAnFJid6XNERzzohZPmqgOvFlDyFdVDyoSRdP+j
 KbuVeJtCH17YSPCgUxfOt7Z5yEWIU7IToyNuhf8NYEmX3SJXFXblByCnGbJt4wXrGAikLskJ
 bCQetu2AHARBMxPlWXtGb5NgeRznn9umQs/oKwXKTz6j9Jyg1bIGN843KemNLtRAF6s+V+Mq
 ogDZ6NmNT0AALWiOEE7DrL/3XhRcCBkXsqpwyCmXuWCOQFhUHowEOPcxKhpeopu2cxoehTgo
 BmAtrtj4AOn3xXvcFzSAlg6Me+Hdcgk9xoTY3dzVWtELlB/Ou5DGo9DLMNvJdHKNYVLkZZJc
 hXyU5zZXaoXFGiWpVzwr/DV9eRfSfhivirWVwLNXdT1V8cIq9DhkjM8QjbSyQ==
IronPort-HdrOrdr: A9a23:PVQnGqE8/QvzFkHupLqE48eALOsnbusQ8zAXPo5KJiC9Ffbo8v
 xG88576faZslsssRIb6LK90de7IU80nKQdieJ6AV7IZmfbUQWTQL2KlbGSoAEJ30bFh4lgPW
 AKSdkbNOHN
X-Talos-CUID: 9a23:fOr5n27Db/f+9XT++tss7A07G9gdLl3m8nrNcxKFCj9OVJe6cArF
X-Talos-MUID: 9a23:fqnuAQT/j1SerFLERXSy2iNya+hP/5j3BUsEoM4muNiKNihZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,296,1728950400"; 
   d="scan'208";a="415235482"
Received: from alln-l-core-06.cisco.com ([173.36.16.143])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 07 Jan 2025 21:42:05 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by alln-l-core-06.cisco.com (Postfix) with ESMTP id 5992E18000114;
	Tue,  7 Jan 2025 21:42:05 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 2D1DC20F2003; Tue,  7 Jan 2025 13:42:05 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>
Subject: [PATCH net-next v2 0/3] enic: Set link speed only after link up
Date: Tue,  7 Jan 2025 13:41:56 -0800
Message-Id: <20250107214159.18807-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: alln-l-core-06.cisco.com

This is a scaled down patch set that only contains the independent
link speed fixes which was part of the patch set titled:
    enic: Use Page Pool API for receiving packets

Signed-off-by: John Daley <johndale@cisco.com>

---

Changes in v2:
- made typo comment fix be it's own patch

John Daley (3):
  enic: Move RX coalescing set function
  enic: Obtain the Link speed only after the link comes up
  enic: Fix typo in comment in table indexed by link speed

 drivers/net/ethernet/cisco/enic/enic_main.c | 64 ++++++++++-----------
 1 file changed, 32 insertions(+), 32 deletions(-)

-- 
2.35.2


