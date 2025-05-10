Return-Path: <netdev+bounces-189440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48744AB2132
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 06:48:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38161A06264
	for <lists+netdev@lfdr.de>; Sat, 10 May 2025 04:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 142D31C7017;
	Sat, 10 May 2025 04:48:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7A1C1741
	for <netdev@vger.kernel.org>; Sat, 10 May 2025 04:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746852505; cv=none; b=r3MoYYZQihnVLfUM1OTvCjhTwY4SM2DyGMxhBc5miooz8YFA8q+Gnd5jEn+W0pCHo5c3yp1fdvF2kcthUwbGLF0FWUV3AYxkj0AKkzSHjN/f5g3DpiiHVirVhBfYl1ZqeK4X216CR7FUwxiy1emft9AtNme7YG8MTCklIXhXfBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746852505; c=relaxed/simple;
	bh=n+QxiNcqC9DW7qzlH0aSfy54kS63gOlDDbAKB8BWHN8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hubgYzNjf5jid/0qqHY3rRAoi5OoxjTbW1AMO8XG0BpOY5R+uJM0iVVz7u9QJ3SGhpyd2sNvhW/mWDQ5S6zlFqNl7E+XB7LwqYqwLnauHRBziSHRoL4NgHcwfkCnwquBwRMS5g6PgdJV9dWnZmWzweLFSxv4iTQnYe+1qBDDQdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz12t1746852317t07affc53
X-QQ-Originating-IP: WN4iVPPw5bhqkPp7klEp0kIKI6L4r8L7oT5vyOas2QA=
Received: from macbook-dev.xiaojukeji.com ( [111.201.145.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sat, 10 May 2025 12:45:15 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 39229549497567196
EX-QQ-RecipientCnt: 10
From: tonghao@bamaicloud.com
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 0/4] add broadcast_neighbor for no-stacking networking arch
Date: Sat, 10 May 2025 12:45:00 +0800
Message-Id: <20250510044504.52618-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NzOHSugmTg7Xdr6wIjTnGZfxpWvkoMfw3gh/NpsJ/eUypCHTTjWEInLR
	R5nhSBZnAR9Q+3fk7xo4HqknOna/DGXzlazox7vUxSRZ/CNQxxU1vhMfxw9m8NxIWlqWHLc
	dkwwQuvkBQ0u+G3sZxC0hlau7iGY8A+MrAd6Jb3vilhlhT/IyED75vaH9EIT8S61ndDm5Ko
	0zJVEGunraQvbCa4jC5DbMweeGfrMtdg1MQDeUzJe5mqCd8X/pWJ1ZYkcgja/JXWddG/joX
	cwkUdcsdPvjmH96x/KbZtdUSHYiTtfVQODhP6FZTeoAVOOdrKHdPzxHPdPSXvkPxKDS7gyT
	x3L+RH/V7lf0H83irtsNZnxcuVxgG3asWCvtuCtALtI33ZU/IGY58uBPJ4TasQM4coSpPTT
	tVZRMmr3p0u+5+ZcstrFRn38j4+3wUWGnCOA+X+LyBdNSurA3Ig7IQu2KTQbvkpqiHrMh4/
	nrLHsOMkSXjEvh7A+qOUln8loWGL3RzPynoHYKdgUIQJHmTZjzy5RoGYvfroZhP2jF37FnR
	lYHlKTNRDqq+MLj+E+oytFp7qekntKgXMcm2Mq4ZuwBzR4SRoxM8kEw71fALz1LFde6Flfd
	W5xZ+s6UGLVr7gwshmyRQy7wmmcUoqTrMNNUXCcp3yz0QFFeNlnZxtKcOu8azafE3/AoVBW
	SFiP4QHfPx2JngHgOuSKTebtv3DDC/OoknycSDDSIbamHpA2oPu31tq3P3ZkzLGmIf+cFqv
	C/WmtGV5+fZsbjTzpYs+YMzYnJ3ngptQOb5Cpjax/4R7S85V47HW8wgNjc+z3eAT9Dq/fyS
	Le5mRn5fey1OmyrBUXtoRVatWKIN7lGVCeJz+dVDxXfdahVCXEUJn1e+Cj48VDmApXGMz7A
	ZGOlgRwZyiY9KCsk/yEwLMIYsW9wofgeLek0ju8Q9fbn0/joIc9ERuAZiX1q+a292pIC8au
	qOFtWnvnZd19YLpReI0pw3N+etmrxbkHMf8yd02MW0EZ3y9h3BkBkJW0L
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

From: Tonghao Zhang <tonghao@bamaicloud.com>

For no-stacking networking arch, and enable the bond mode 4(lacp) in
datacenter, the switch group require arp/nd packets as session
synchronization. More details please see patch.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>

Tonghao Zhang (4):
  net: bonding: add broadcast_neighbor option for 802.3ad
  net: bonding: add broadcast_neighbor netlink option
  net: bonding: send peer notify when failure recovery
  net: bonding: add tracepoint for 802.3ad

 Documentation/networking/bonding.rst |  5 +++
 drivers/net/bonding/bond_3ad.c       | 20 ++++++++++
 drivers/net/bonding/bond_main.c      | 58 +++++++++++++++++++++-------
 drivers/net/bonding/bond_netlink.c   | 16 ++++++++
 drivers/net/bonding/bond_options.c   | 25 ++++++++++++
 drivers/net/bonding/bond_sysfs.c     | 18 +++++++++
 include/net/bond_options.h           |  1 +
 include/net/bonding.h                |  1 +
 include/trace/events/bonding.h       | 37 ++++++++++++++++++
 include/uapi/linux/if_link.h         |  1 +
 10 files changed, 168 insertions(+), 14 deletions(-)
 create mode 100644 include/trace/events/bonding.h

-- 
2.34.1


