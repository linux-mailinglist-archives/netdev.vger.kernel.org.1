Return-Path: <netdev+bounces-246649-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7935ACEFDA1
	for <lists+netdev@lfdr.de>; Sat, 03 Jan 2026 10:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31E023026AED
	for <lists+netdev@lfdr.de>; Sat,  3 Jan 2026 09:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 788622D94A0;
	Sat,  3 Jan 2026 09:50:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2C41CEAC2
	for <netdev@vger.kernel.org>; Sat,  3 Jan 2026 09:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.169.211.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767433815; cv=none; b=djjqhOGD8fE/TKmrZdbhMEtWMqDp9hEbTcXJjWhmSI6tPWfFn012IhZNccIrZyq8ocQ6kSnJQ9rRfQcjAPrI9szQsNoHCdXphZf1RxOoZKI2dIawz+LGZ/w4FKeb5s5zC1z/6Vvj9h99MTAkRaNJIgEHA8dB21zHPnocerj+H5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767433815; c=relaxed/simple;
	bh=m2aZss0+ZM8b/lxCn7No8GorU3awbdpWBPrKC2tzIHY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m1FLloes8NMdtiZg7Dg232OGTpl+oC7nJUgc/uxiMzoA6rIGpt0gerCdfgSFj5Rh5PIk3LVAcyM+3OyZ0ri+zbQ5SGSiaV18zk++cHabxJws0raIUfFfzAyYrdbN7cXvu01+iVvPPd002kIaj083XRAovkIcX4Ke9AqpAYxfKtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.169.211.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz9t1767433790teb21184d
X-QQ-Originating-IP: nO0rtLGfmJDPd2iY+R26e/t0RD4UGJbK8wAD0XsILeo=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.14.96])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 03 Jan 2026 17:49:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10111140801060055609
EX-QQ-RecipientCnt: 13
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH RESEND net-next v4 0/4] A series of minor optimizations of the bonding module
Date: Sat,  3 Jan 2026 17:49:42 +0800
Message-Id: <cover.1767000122.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Mdekj0pmbZiWR0MjpYn9nQLRvvWN5VKXelQeZSFvECkjp3UmoZ1jfEI1
	oZHTMVVybBjhTu3rnUa3EVykXHvTMEWkTWWeEavGZfo7+DFAwy0WrYVcO/fge3sELVe0Cf8
	0aq+RdXtzi4Yj1riHhvqdLpQ4lkROOwMbQf5BYBNGIOb0CwB4pSzIPVj9rm468Y1e/tkEPQ
	nfCKnFZhRbm3Nmf8w+pUDLJb7tfLUNwox6htapOKiB0keQmiYpPeDeS+GgMnV486wXaXGDK
	jV7CoMv+FMaOZhrCaJB5nlia2o/mn4Yx+B6n46A2tIhB/RBksGe/ns17F/zGho/ekUyEJ7H
	Qa63309F61YbQGLGgtdB2GWmf9MoBweq8uMFfOuVdY+ivibZN+hG5w1qTUhz+B+oMQDqseS
	6Q3Me1orS+BKcxbahGPixQoh4sW0T2F90tc3b79kbLlSaysV6aHbvI7lyejH0zP8Ysuavgr
	iRm1YbHxUC9FfpJ6zCorO7O2ATt9CdOLglM2tvI2tThuX1XyRmdAWWId6OZDufag/wF2qkE
	Zu0TVYYHfvYHURMrcYSCpbk+Cd8Uy2NFJhd4xt3u9my29kVLSJ/LCyPpl2pR/xyEEkTHo/X
	plc7DL4+rcQb+pDOyh4M4OOgy0VBeLy9TQTKF5kn9ggflhwUBF5jF75Hd9cFl6i1XSSLz4Y
	LQqeVr2PmcHiAkw00EV/UGWSoFJyPHuO63ICriiWYPwbg21vVhbpDPXw8ky8CL8ZAHXUgZB
	2dX/QcIHb68FwRLTpFTT2a06E4oiMfs99d7bALRg2YwLdfH17kQZspDy5WgnzmDvBEs8kTw
	wAzuHU4C4pj4LB4QxVwfOJchMqmAuIdD6kNNu5xXGRvvmoGtRrAog/PTkUJYy2zPvxQgf0k
	IgpFtK7QXNDYpk7oX+t2ojBL8I44CJTcZtx+KFBoNKXVh9bWp0PjZxDzknTN/N1Yo18oli7
	KHPlkww9EhFbayyWOnXIqtwZp8/BldbNcKWqN9lwvETTKiyJaBEYe4AW5WkgCj7YFkx23vg
	bcPMxzNrxTY7nBVNGE
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

These patches mainly target the peer notify mechanism of the bonding module.
Including updates of peer notify, lock races, etc. For more information, please
refer to the patch.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>

v4: patch1 keeps the netdevice notifier order
v3: drop the 5/5 patch, net: bonding: combine rtnl lock block for arp monitor in activebackup mode 

Tonghao Zhang (4):
  net: bonding: use workqueue to make sure peer notify updated in lacp
    mode
  net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
  net: bonding: skip the 2nd trylock when first one fail
  net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing

 drivers/net/bonding/bond_3ad.c  |   7 +--
 drivers/net/bonding/bond_main.c | 101 ++++++++++++++++++++------------
 include/net/bonding.h           |   2 +
 3 files changed, 69 insertions(+), 41 deletions(-)

-- 
2.34.1


