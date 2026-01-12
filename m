Return-Path: <netdev+bounces-248861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ED7E7D105D7
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:43:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 087483013EB7
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 02:43:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9397C3009C3;
	Mon, 12 Jan 2026 02:43:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B832D223DFF
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768185788; cv=none; b=o3CQyE4uUPXCl/F11339jKDPKOllL5oFjab4tJfxrfiZilB0Mk1i8E/HJsg/11RMjd3dOYCApnCdGRHYQDdjVel3rOzh91TnZRdAr0BI1MZg/4CaXv+/krfMMjiwlru4p3e/TelM4ULG85xn5imw7WhXv7t4asJBLpinzEvMvGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768185788; c=relaxed/simple;
	bh=tkTz34mOvjZ9fFaqeiL663gn5/b7k/ra8t1/gJGX4tI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=T7H+LnAB6dhOrD7i0EasUles8FpL8/wtaNP3Txw35krWWexjoSfIyX0revin8fmgAfGW3/VxtOcjOh3PlaoXoI5nno4EOAtxKqDlPkafYlMaUepfOgQz/lfajs3NC9k+QTHBFqoABLdedWotGXvdL1CLGaMVN0MAAfUDBuR/EkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz13t1768185766tb0b7b628
X-QQ-Originating-IP: vt1EOS82id8o2CM8Ju2mlFjAatCfStCz/+bUZXkmZU4=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Jan 2026 10:42:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15812230900466819900
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
Date: Mon, 12 Jan 2026 10:40:47 +0800
Message-Id: <cover.1768184929.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MShfLn39PbN2WZzgTdjTL8n/CSG+FO/GEBDmlySk9tSDlQJCDsToMC+P
	3aHEtJ+IJ5nObYnVOilnA8Y60KmWDwXLXRsCwECqS4WlD6B3YY2XbDUZxUorD7kGZ6DX88t
	KnnTGLYrWyy5HA3guSHJK+GwGHuEAEgg6mwtvLEXrQJO14MrN7Gd9T+TZPeluCT7YGqBhlm
	bj03axj8qQ2wekyiBIK43nfc4/CSQce1CP+dj1OMD/sNTY6/u7m/yyvAO8AHZLQMVnUPc0/
	n1vra6emra1DV3yuugugRA3nrUXpEaEQjR602kAe1TuFJO76wJXIX8yW9xGps3Aal32heSq
	szt3czzcqM5BfANMqZuusR57zE3fe/eorgIr8HA6rcxK9tM1v+xq0s2j6Ms/OvhMWHPIXUD
	7rcxzz4T9GzafWXzS4F0Of1KnPjo0uc66q6Kq1vEKDVUvYbyUkuc6+Wwcj5QZj87v6zd0Re
	wd7URt7mFxlH78z8l6wXEN1pd4oFyWLUN9B14UDHyYOQuZpIwPxdPgB6QZm10OMv8ppKIbc
	e6fM++gBZtvh3wm5okeWpIe4t7Jjk6dYR9bUriei6NNyd8C9wjHLqLG8egnPPOcW5GuLlA1
	sD8PY8FEFc2CTnU+rARBkAGBZlJNEHA51KHtTRXvUXwFkLL7UuutoR7I8AdMLXS6OnGolDX
	7K+Yf4B7578YcjKlLOdZKl0Tbq7jZpBieUZOnHYSWpcV6aGDyFRLFfmIx0L/W8jimYDHjbH
	78VOHUYRtSCcl9KDcQyvg7eY5Ut63d7QctFH06GMrxR8Oxeb5p2B8Sc/apX0m1oLcUoEJT7
	f+/6ZdmjATrz3UqcU+iLXMX/OahjNsIXo+Lrhj2Gfjy6sB0QNZBLGdM4tVxZ/vStI6nwhSW
	npEuB8ubMdK7tmMs42wpNB0a4eceUUGzFckececJ2sjX8VAf3G7ErBJ6eRrVDDQZ8Y/7n/4
	rkxhoG2/OHLGuaN7PR3YMkl/rPjju84MIGEQb7gUgHZe9DJilXNNOF8xdHXmMfAbxSco3UD
	iMmW8HyQ==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
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

v4: patch1 keeps the netdevice notifier order, and all patch rebase the codes.
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


