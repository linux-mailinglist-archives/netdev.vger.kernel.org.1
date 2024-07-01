Return-Path: <netdev+bounces-108112-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E0C91DE3F
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 13:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E3AA287268
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 11:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A5E513E41A;
	Mon,  1 Jul 2024 11:42:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from cmccmta2.chinamobile.com (cmccmta8.chinamobile.com [111.22.67.151])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A592B9C6;
	Mon,  1 Jul 2024 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719834168; cv=none; b=eP2OCGglWNb/J5Cop6dqVBMKXeRo5K2tz6eA4m/0X9ScEtp+75UDcwhXkfviexZiVevTq2A5eQvK1EbQJlJ4+dsbuD+VYZrPMqS2pnve4k/ezns1NLS4X64PdvClTn6UYhKl8XP1804mC24JHMlBq6OMz/n82yhMfr8EGT6rS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719834168; c=relaxed/simple;
	bh=d4z6WUCfc9/T0SlT41qkvwC+f8VnIFwNy4BV16Q+AXU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SkBZLc+n/vIBVc6uYGUz5AlCLBaujOnbldM1ZeovdGrHh5NqN01ZnZ6o6b2Ykyh3KjTNxHd8JJUoZLYr8ifABGw80FROZi7bv42x7r+GDYWffVrQny1ee8jpeFHJ/CfhWeD+ZV3nM08J4FoCoffrMDpq2MiUE9alVSWHthUa4mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app06-12006 (RichMail) with SMTP id 2ee66682962e5c3-aee7d;
	Mon, 01 Jul 2024 19:42:43 +0800 (CST)
X-RM-TRANSID:2ee66682962e5c3-aee7d
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain.localdomain (unknown[10.54.5.252])
	by rmsmtp-syy-appsvr07-12007 (RichMail) with SMTP id 2ee7668296316a0-6ae4c;
	Mon, 01 Jul 2024 19:42:43 +0800 (CST)
X-RM-TRANSID:2ee7668296316a0-6ae4c
From: Liu Jing <liujing@cmss.chinamobile.com>
To: edumazet@google.com,
	davem@davemloft.net,
	dsahern@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Liu Jing <liujing@cmss.chinamobile.com>
Subject: [PATCH] net/ulp: remove unnecessary assignment in tcp_register_ulp
Date: Mon,  1 Jul 2024 19:42:40 +0800
Message-Id: <20240701114240.7020-1-liujing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

in the tcp_register_ulp function, the initialized value of 'ret' is unused,
because it will be assigned a value by the -EEXIST.thus remove it.

Signed-off-by: Liu Jing <liujing@cmss.chinamobile.com>
---
 net/ipv4/tcp_ulp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_ulp.c b/net/ipv4/tcp_ulp.c
index 2aa442128630..d11bde357e48 100644
--- a/net/ipv4/tcp_ulp.c
+++ b/net/ipv4/tcp_ulp.c
@@ -58,7 +58,7 @@ static const struct tcp_ulp_ops *__tcp_ulp_find_autoload(const char *name)
  */
 int tcp_register_ulp(struct tcp_ulp_ops *ulp)
 {
-	int ret = 0;
+	int ret;
 
 	spin_lock(&tcp_ulp_list_lock);
 	if (tcp_ulp_find(ulp->name))
-- 
2.33.0




