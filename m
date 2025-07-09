Return-Path: <netdev+bounces-205261-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D8ECAFDE9E
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 05:58:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 27B6F1C20027
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 03:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9226123ABA3;
	Wed,  9 Jul 2025 03:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="BSfZ9d8H"
X-Original-To: netdev@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 378CC3208;
	Wed,  9 Jul 2025 03:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752033498; cv=none; b=ktTwiPUOy4iaw5gQppaVnFyhXvdjZeOwNIvKX4xs/zezEd09rifPd4e5hSdV2XYbokAAI6jCLfrPWjyJubghhsjhT3B/ojpF4/a4oK1VrBM129wKEn7A3HHLAt1XozJ7qcrW5Tw0Xi+Kf5FLQAd7HjcnSKOXDMrZxZRkBog0dmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752033498; c=relaxed/simple;
	bh=sGCCkkKJBfNJAqH361usUURY9F6NRDwevuWl//frjwE=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=BJBzTRJ7n3OZWqvYejerneoFg5cxvtLKVA905zucsnEe7Dkg58WG4RMyq3s7hJJiwl3WEHjlmFsbmB1tMP8eIPRw5zwGwHPBzhi4BW1RLufcJl5H+/j/tKHF/FMFglj5dmfhML11FUfRt7lkdad20WbkgoeVy1Cbx89blUWMSvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=BSfZ9d8H; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1752033182;
	bh=OfWCbJnUHkYMrgQBuEc+vQsMymRVSQZY/QYP2G5dMyc=;
	h=From:To:Cc:Subject:Date;
	b=BSfZ9d8HmgMuK16zekPEMd4Dmc0LJ+fCCAMi+0rikGaNusxKCbRuriTARjfFwCKHl
	 7M725R4tDueed9omYWqePaN/BCh9i5xrVUlQFe/vMJMXvdCJppzPw7ieksb7bTkj7m
	 OCFryoNNj5pBzWX0wrX0SVUHdR0Bz4W+we+Y7VhU=
Received: from syzkaller.mshome.net ([183.192.14.250])
	by newxmesmtplogicsvrszc13-0.qq.com (NewEsmtp) with SMTP
	id D363D23B; Wed, 09 Jul 2025 11:52:54 +0800
X-QQ-mid: xmsmtpt1752033174t8d37g693
Message-ID: <tencent_E1A26771CDAB389A0396D1681A90A49E5D09@qq.com>
X-QQ-XMAILINFO: NnYhxYSyuBnLQ17IAXwPkP52iNtESB5hKcOl3YXG7ztah5ip05U5RKqK+epaQO
	 7OdrpZn2lPn2e3Pmzk7WmzRFvw6QEaeuuP0mVGtGG87OmG8CM+B3qEdjOwl79Qvlm2Qvp0WpRO/f
	 cYcRYL/SGn/M4lQVJpodp70J1tPYS3/0OC1Y5Nc9A3t5AX66UKhqlPxC5LeK14j9qxrEVfnYu12I
	 A2MfiP0M+uAXardUW7mSScr4wWMz2gBiJh4JHsrNDZylHZOjMeFwNHWhQkFQ3E+GaLzrnmXD2gR2
	 aCNBvXH7cyBDqfIK6oAueZ8ztLkFD3IpqBHnYEb2A2/V+4vYCyZLb2Kf66njH08UQkNjfOzfirrV
	 U6FDagPTB6ER6DiwWildeMTis2cuvGS4QbX0spHmWz9wwGuqRsvlt28VG0aqQkCzWyPAYAUimrvL
	 QXhMeA3/dSM8Bgs8xkGEh6xBZUy2VnRY2xN+xnsuLOCT+NsNPjoco066ShswHA3jwN43pOHqCV3X
	 0fer9/BaJ4Azsy9K5QD1jFdXxSuJ1vKvtwO15zT0bjRcPUVefaQac2p5DmMk7OZQAe05KvBHdWQ4
	 +Xual3oek+rmy3fC3SMAaQQJKVfr7RdjHQ6yT07Ug8fABh+CF6GFdBpX6bkxhuhgolr3HSWsK7vi
	 zghcWeRyhC/WiyFRy/eoNHQkLWpSFYCs68aRueHkWA4Hvf2VsaTwGGLQhQMSGg29fvDu7ijTINlL
	 1k0pMFTrlPrFECYwFTY04GDOWAtgF/8bpBH3Et29lJqSU/tZ9v5b5KaQhu8IYWaFloVHyxHPu9vL
	 kFa1Yy8UFSYPD32RlaWx6O1wh+DeXd2kG4H5duyriB6ywliR8EETq9JtwjDsM90H6rWAs94oqGwy
	 5HfRpIEDHRjr9nEoCsLwYkVkZegCpMDi4y2unFKrPVDUT86ustBqpZSUwWsi1VdJPD83IcH03hAq
	 DRIjoUO3F+QRDxQlVeX4bLBzmNKbuuI88raxJu/lPXi3aAYHUGSYMYX80dO4iovGRvvk0bKVHlca
	 uDN2bfGQge7mRQuGnJx1DsAiqCrEfzRBVaqD44BSSWsMXZdNlpRZHqIW8Qb6WOEAli3EekbRyNWb
	 8gpNPB
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: veritas501@foxmail.com
To: davem@davemloft.net
Cc: Kito Xu <veritas501@foxmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] net: appletalk: Fix device refcount leak in atrtr_create()
Date: Wed,  9 Jul 2025 03:52:51 +0000
X-OQ-MSGID: <20250709035253.492806-1-veritas501@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kito Xu <veritas501@foxmail.com>

When updating an existing route entry in atrtr_create(), the old device
reference was not being released before assigning the new device,
leading to a device refcount leak. Fix this by calling dev_put() to
release the old device reference before holding the new one.

Fixes: c7f905f0f6d4 ("[ATALK]: Add missing dev_hold() to atrtr_create().")
Signed-off-by: Kito Xu <veritas501@foxmail.com>
---
 net/appletalk/ddp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index 73ea7e67f05a..30242fe10341 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -576,6 +576,7 @@ static int atrtr_create(struct rtentry *r, struct net_device *devhint)
 
 	/* Fill in the routing entry */
 	rt->target  = ta->sat_addr;
+	dev_put(rt->dev); /* Release old device */
 	dev_hold(devhint);
 	rt->dev     = devhint;
 	rt->flags   = r->rt_flags;
-- 
2.34.1


