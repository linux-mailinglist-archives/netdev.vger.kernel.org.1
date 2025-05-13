Return-Path: <netdev+bounces-190028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A4DAB5042
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE4E31B40CDE
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3190123C4EA;
	Tue, 13 May 2025 09:49:16 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E44D71E9B03
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129756; cv=none; b=OGBPswtImoEba9OZj58p64BglCYZ14XilPpxb3FgUFN6iq50gDzWduR45ezcsy6pPegHTuLhmP1Y/CmDRCl7uU8poql+WKEwNwkvPuhUMXKz3r9Y8m5tcQf6P7PFPJDLps8LIn67HHpt+WQ1BmiZzPDT6Qb421AExYKvBO52VQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129756; c=relaxed/simple;
	bh=YjKnTR2ihtIgRlEDsmIsSxZOhCBpQRiciSvJEKdW+D8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O/CnXfaziXG1fQ2HBWrZQb2S4j/LDqtGDNokkVcAb0NQF9HwDGpafqfyXu9KTLWMhce+ba4keWu2QNqGgCiwhvEIizYrNmlLU3Acgo8JVGs2CbIQvZ3Gv8y+PMSjpwJ5sDxlVfca3PEO+lpK1cdritWNIouM4eWJZBWENCFbdRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz4t1747129676t196b6b1b
X-QQ-Originating-IP: h5vs1YZaAnkwCDa2CsjVQYE1uP7G/PWXlYWEFoHbwAY=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 May 2025 17:47:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7435081856525753782
EX-QQ-RecipientCnt: 11
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
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: [PATCH net-next v2 0/4] add broadcast_neighbor for no-stacking networking arch
Date: Tue, 13 May 2025 17:47:46 +0800
Message-ID: <47ED0B42943D829F+20250513094750.23387-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NEaes6yu2o+mpvE97KGJAEjzMF0MD2qboJ7i6X1TslxdaG0isznyVBda
	f+M5c28GhQNm8Y2JtehvPU242UlOH0ONKpeNAbusbFzMNm44rE68yAO4P779XKzAfw9EiLN
	rki6g90kiPik/m62XG9bBFTzx5kV1hG7WG4P3BDsHETILL5XSdo/bg4wOQDQFvhcLpLeeFl
	3v4k72zseuRe/qNJxDcBpt0XEwFcYW5C4yc67qDGl6J2L1A++vDGC+BrfS98E7kJWHftqW7
	E/WIsW+Lb3Lq5ZgsZGT1hE/in6Fltj4NDMlyg69CHrr1iVxqGLHPvpEekNxlmeZxaw9lBzM
	JZxz2LCmQWv//XFhMe4mybFbnOy5qkQ1ekb+LqmdvHGd+oBWJZ2hpHLvp+EGB1nyDk3bBhI
	XSIb7MI1oGJFOJk91WtvLOExHf5nG9Zlf/sy2DNaCRGkfbw6rOKB64AIYqLa4OTVhmqRaHs
	6Ds56XddZnb14R+TVW6Ne3kFtnT9wmY6QWqGZW8asApb1Z9zTO133pFroYM9mBKBB8H5le9
	OFdko0OSo5eEooQbYmQ4LvLlP0zzQSide84VlVE9VbwsyKDrM6gSZbU3U6JArhoQazGypMs
	zCeEInYnf9s9b5ySNz0Xwx3lpIlC/5mkMSdjBBK3PvZJ3EkbSwJUYOdACY1KOCthJ9d9qjZ
	eGUC9CzHPv4nM9D2l4H4+FhuG+1YTbE5nnBhVuJ8wB4UIzyUPv2BHbCZtGotVYmzyCPYrd/
	IvrBzM91gkVwOqLIcml6qCZeXvIjU8Xd7qHZK6FnBcwqnRk33Ccv6RVbQXRjHCWDKIK454/
	4O1dPeqxAWke0BN7Q92Nd19MuKRdugbYjZQqp0Dcs2hbEUtL1sjmkxY/LvBySFls4KLT7qn
	SCwnDDarACiffFkkvksJcVmL6adbojKPWicPp9ynOgaXzNFGTR+BLqKHBx4XRDQ3hBIzT6K
	L9Wb9qp378K7F3wMZ6Bs3pbEY5a/JRP6W9wYAfEdmxyNm7yZijaPW4PdXQn6RxVKaajk=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

For no-stacking networking arch, and enable the bond mode 4(lacp) in
datacenter, the switch require arp/nd packets as session synchronization.
More details please see patch.

v2 change log:
- add static branch for performance
- add more info about no-stacking arch in commit message
- add broadcast_neighbor info and format doc
- invoke bond_should_broadcast_neighbor only in BOND_MODE_8023AD mode for performance
- explain why we need sending peer notify when failure recovery
- change the doc about num_unsol_na
- refine function name to ad_cond_set_peer_notif
- ad_cond_set_peer_notif invoked in ad_enable_collecting_distributing
- refine bond_should_notify_peers for lacp mode.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Zengbing Tu <tuzengbing@didiglobal.com>

Tonghao Zhang (4):
  net: bonding: add broadcast_neighbor option for 802.3ad
  net: bonding: add broadcast_neighbor netlink option
  net: bonding: send peer notify when failure recovery
  net: bonding: add tracepoint for 802.3ad

 Documentation/networking/bonding.rst | 11 ++++-
 drivers/net/bonding/bond_3ad.c       | 19 +++++++++
 drivers/net/bonding/bond_main.c      | 60 +++++++++++++++++++++++++---
 drivers/net/bonding/bond_netlink.c   | 16 ++++++++
 drivers/net/bonding/bond_options.c   | 34 ++++++++++++++++
 drivers/net/bonding/bond_sysfs.c     | 18 +++++++++
 include/net/bond_options.h           |  1 +
 include/net/bonding.h                |  3 ++
 include/trace/events/bonding.h       | 37 +++++++++++++++++
 include/uapi/linux/if_link.h         |  1 +
 10 files changed, 193 insertions(+), 7 deletions(-)
 create mode 100644 include/trace/events/bonding.h

-- 
2.34.1


