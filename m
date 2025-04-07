Return-Path: <netdev+bounces-179595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AE3A7DC3B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 13:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC6A916DAF9
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 11:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC01623BCF3;
	Mon,  7 Apr 2025 11:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="ARcF3FHg"
X-Original-To: netdev@vger.kernel.org
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78B923AE67;
	Mon,  7 Apr 2025 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744025262; cv=none; b=tAdWzusgffsSUtTJu33vZPZLyR2JknmLCeKVSWQwX/SXmZDx0FI/lNoiOtn+xwKXadJXz4CoN4fx1uAW5xLyiF5YUyZk6EnfNvdCvXLGiLniViYxc8qpZSTF+ZEMIYmrQFBm0YQA3ufRcY0HNr9wBP4e1GrqOffdbGI3ZPr2XME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744025262; c=relaxed/simple;
	bh=093rrwsmRiqMHVzVRyHSZKXYoLgYn1XFtxsIr38PXd8=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=mjm8Zs+acq+l7o1gvXJumB1BAZqlMfp6sR4JWKf5WalNyAdLehi+7TuNZmkknhvTFjRWvn7vkRCl/0kyVJsa1fAdylryInrn9kXoj2KGHH9P+xpzniBenBYitvrJsfz8Q8EDZIBvAEgQSg7pg6C8CTHfjiCmkX23MKtVE3AhbEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=ARcF3FHg; arc=none smtp.client-ip=162.62.58.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1744024951; bh=OIMPWzh9MNaYKe51Y4PxWwdbK6/caOHyB47lalq/Giw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ARcF3FHgac1cBtfU/xYwkXL9sRUEHtpKKFu1SwGHfMFM/QRLFQ5gHU5IhfB1De/yU
	 gEokIErEQBTYGWlxXs+PF/BBYDnEAZmb/xJlVO21REJZskg7QRdl1Bq3BQKPZmWxYv
	 8AKz6I+IHd5gb6w6cjZN+gVWSDtrp1evFxEs3VJE=
Received: from pek-lxu-l1.wrs.com ([114.244.57.157])
	by newxmesmtplogicsvrszb21-0.qq.com (NewEsmtp) with SMTP
	id 59C84251; Mon, 07 Apr 2025 19:22:28 +0800
X-QQ-mid: xmsmtpt1744024948t3yx4n6wg
Message-ID: <tencent_ABAECE4C9727C606CDD2D6C67209852EC406@qq.com>
X-QQ-XMAILINFO: ORuEwgb9eurkQv1vLgVvgl69FjKBMdrYxy4FNZvmCEmHg27T/Qt3YjNmYaxJCz
	 EmeEHAn0bWMiidYxwb8uBTCGf77qeavPqlUbh373Ti+gH4f3vcVTQg6r+tFbCyaXoXebRuYHbv67
	 ooRCp0tGHMjPDdx5lf1s1PxVg6E5fiBlLK8en79VewN+Uy9qeuEd1XypyjiKjDr9VKLeA3k61HxE
	 74MfASVN8dnz1KFTT8/Y5NakDvF0p+zHrJI9Lx28Zj/GM08ed6kyMkLCMJMPmPhHO9VvjA5qybiT
	 pIWBq4mt2WbvqZ03A570oNGPllStNRhy7Pt4wHQa0cfO4wd+i3/8Hx7HsI1fWCHeeUalIm3/vHef
	 6Ya55BJLY3ZT7UziimXrOfvDMQLkkn2LbQu3YbI+q54jNiUEkcXI+JIvOTRR9IsbcAopvtg+v0cd
	 S84v1jmz+vScCFWP7SvIPlauKhy+8JarHrXJpToUh6Vb/KVCMOI/pGZzvbrh+5MLTpWc37uDgXUI
	 MAEgftHz7zXyAHTnAwD92NvJGwKSvSaToNiHyFpsTSBhAsc0Crd32xRLxWI6S40I6GZOMqsH+EQd
	 ePyD/rQCJGAqaA+X2MrN2dI8/dk592lChh3b6M8zh95B7K/sfIlMSirCuFkK5RXhqU8d6tBVdwZK
	 OgwcZiHBRT2v4Fn419jGgFNLSoblBVZYkrFxPg74LMMSi0srrRhyY+lkwiTvQjEIDmd0XpRGCYJg
	 wEW98q+KN70YzCGsonglchzP4/vfcghxTKUVqnZao/+A/Bx0NtcZ4yaV9jNXRKDJB/CwbbeT0m6R
	 rawwkZPzrxlLme59uGvC5haohOv8/7duDZrZOSMrPkdpZSpgdAe1iP+cBKI0lefztxA7QZjJ6MIg
	 yCTFR45TnerQg3o2MzO9TB3+tkWjMEAl2Dyzzsm1Tv
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+10d145ea96fc91185445@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	horms@kernel.org,
	kuba@kernel.org,
	kuniyu@amazon.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sdf@fomichev.me,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH] net: get ops lock under dev valid
Date: Mon,  7 Apr 2025 19:22:27 +0800
X-OQ-MSGID: <20250407112226.570082-2-eadavis@qq.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <67f36908.050a0220.0a13.027f.GAE@google.com>
References: <67f36908.050a0220.0a13.027f.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure that dev is not NULL before locking ops. 

Fixes: 8965c160b8f7 ("net: use netif_disable_lro in ipv6_add_dev")
Reported-by: syzbot+10d145ea96fc91185445@syzkaller.appspotmail.com
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/ipv6/addrconf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 2cffb8f4a2bc..5d9fd01e6265 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -3154,12 +3154,13 @@ int addrconf_add_ifaddr(struct net *net, void __user *arg)
 
 	rtnl_net_lock(net);
 	dev = __dev_get_by_index(net, ireq.ifr6_ifindex);
-	netdev_lock_ops(dev);
-	if (dev)
+	if (dev) {
+		netdev_lock_ops(dev);
 		err = inet6_addr_add(net, dev, &cfg, 0, 0, NULL);
+		netdev_unlock_ops(dev);
+	}
 	else
 		err = -ENODEV;
-	netdev_unlock_ops(dev);
 	rtnl_net_unlock(net);
 	return err;
 }
-- 
2.43.0


