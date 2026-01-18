Return-Path: <netdev+bounces-250802-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA74D392A9
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 05:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B276301224C
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 04:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3021030BB89;
	Sun, 18 Jan 2026 04:21:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C314C1DB54C
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 04:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768710116; cv=none; b=DS+YjAWhvm/Dv6i8WuR/RoFIR+4i855c4dnRuU8XyDGTEqgNik+M3EgGmg4017ZtP19GoUhyXP2CrjYrEGP9ZrVjdlraSAMsrVkdW6z24YfBF0rjUQNBoo+6Ip5dsqLkJj6GXg1y8gHgiA8Uye8GLrreJSe4941M8maH19REpgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768710116; c=relaxed/simple;
	bh=FORNQ/qdA1FkzJiIv90qWOMLnh/XcKLLBmymKv9SBdU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z1G+067kNp3qhxWxmh4UCoWB2SnSj/wxhmMqXeY64t8Cvg5KOHjmms1JJPv39B0DgDkKX+yaOc5Ith11BUSXjeHScdluAd24HWTk8T4pR9pc/K8ELS0Wq8+bLU/b5X8LP1Z1yEJTQvm983PwrFSg9zF3PCALLk9Xpy+iX5CI1xU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz3t1768710092ta701c576
X-QQ-Originating-IP: WUa5GfBjotTYA9EMWgS4tnPRzr3PSvdlfNIJfP/EK0Y=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.15.52])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 18 Jan 2026 12:21:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10467279096274681119
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
Subject: [PATCH net-next v5 0/4] A series of minor optimizations of the bonding module
Date: Sun, 18 Jan 2026 12:21:10 +0800
Message-Id: <cover.1768709239.git.tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: NAeO0+xU6W76z+Dquk6t/tOCcaO/PqlIQJEzahUx/d/6fHzK7+Is1Esj
	nkv1rRy+iejoxqy92/Xe0SigFaXn//i6d9pyWFaajg9c+woc8CprKuQl7q5sSphGRdrRKMU
	gpbpTGlPMxrZMCiHr0mdKVQZrBpgyMPho2x/VkilqW/jzHwrCAbpUT9n4Pj+4W8z3OnIY4c
	oauuPST4GKu6pnHDE9vD6EPW9gcOkTon2JU9UT8ewpykB3Xn1TV/G/nDQ2e4OOQJ9dgjtq1
	bUg8Omi/9VqCDm8ReMZDizY25Gv4klXr2N2pDdcQiE5L1pvYldrpRbPVkWgUl+R9hbOLHXU
	s/tsXkyiCI7VdR1n0fHOsdPOwNjBNMqBE1BsD4pB81QDTDwTUDWx614NBiO66xqvhdWElzZ
	tVMN7fkbHl5+9JOrD51P5x9rR1uWDbUyCyJx3y+HTyr+VwMSdgolQKDINj3AZLZO4FqJi09
	wvQ5F8Kncco/rJ/Zh8p8zG+UtHhA4j1JukVVcoTOUkrETTWa2xzVFeQ9CO4pf2gDaa847oU
	sn21HS1aRzycnfhZ5gXAZl9FADLicXN7hCTl6yUgXoSGTr7f+dh2e39VE53YotStjRfJFd1
	kf+drZh0JP0sdoxOdWrBTKc9xj/vNHtEeIzhik42iaT+dDkb/RKjfeIHfn9xBdJdKvWPaze
	UqIYlwTvqs5RFIS/yhUB9a0OB/0j6jvNfDy88wtJnF4fMI7BWNaaAw5r/hmOpoHFP79Vv3d
	6Eo9aqXu2/ToIkk196/XjNVzIkYzQoplK5kNprUYXoDr7qwpa2QQuz184Zj9UvJer0AmPqK
	rUpo2C+9jYbqhGDcwl4aws9hJ7EnNcrkf9YJZ6ksrObOIG3lCX4yBjW5d8W+rc68esyOPM2
	JkwNhqQovYIwy0a6qTX9ZIKn8FNW4m2xD96nmPXfz2fOp/q9q44J2re3y+FoXk22r0HNzpO
	QgoJ/ZDSwdg8N6Y+9KowSjMEklFSLCMW1EAjMO7b9JCjbH31H16yQCXzDdfio48HKq7zuBC
	9TCb5Pb8aVDtjhVg0a
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
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

v5: introduce the bond_peer_notify_may_events used in patch 1 and 2.
v4: patch1 keeps the netdevice notifier order, and all patch rebase the codes.
v3: drop the 5/5 patch, net: bonding: combine rtnl lock block for arp monitor in activebackup mode 

Tonghao Zhang (4):
  net: bonding: use workqueue to make sure peer notify updated in lacp
    mode
  net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
  net: bonding: skip the 2nd trylock when first one fail
  net: bonding: add the READ_ONCE/WRITE_ONCE for outside lock accessing

 drivers/net/bonding/bond_3ad.c  |   7 +-
 drivers/net/bonding/bond_main.c | 113 ++++++++++++++++++++------------
 include/net/bonding.h           |   2 +
 3 files changed, 75 insertions(+), 47 deletions(-)

-- 
2.34.1


