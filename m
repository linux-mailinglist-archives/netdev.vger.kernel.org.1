Return-Path: <netdev+bounces-190354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 35349AB677A
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:27:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61FDE3B4CA4
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:26:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FE9225761;
	Wed, 14 May 2025 09:27:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast1.qq.com (smtpbguseast1.qq.com [54.204.34.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ED61DED42
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 09:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747214820; cv=none; b=TPCTpueSin/2FWyQZYYArFcozoiR6E3sNHtwrpVnsmDo0rT1YX/Un6qbNxhnyZaz40jk/mXtKWowKRwdckQOzHJZy7zsXY46EzP3wT5IqY+0WXHr3Cu8k93tROWL8hP+CfMTKa0+pp10lmoUQZqPid52/ajSU0ZGFSPOXzeBmuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747214820; c=relaxed/simple;
	bh=/NYYkvB958y7F8oV4sxNuKMzKCm5PYZEWULsJOlaCXk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KLP18QsIVxyud7+HhRlTsjmE6Pn8S0CJvrIdvFC0bddtQQIul/a9hRhI1Xr7ngtFvccYkvfBISGA2V8s4EQgZ4t6QhbFxXgZB3JyEze4lXwJncQC2R5IWlIgXdp03xCTGqDYwe5nkIqjK2sPnUgIJ/sr0cX08Ed8OTeBzjtmSEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz7t1747214755td456f6a4
X-QQ-Originating-IP: 0U1ZPqLwIlU2BZryB11oUIQG8NYEtRs3UP3aa/hVBBc=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 May 2025 17:25:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4044627851637755689
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
Subject: [PATCH net-next v4 0/4] add broadcast_neighbor for no-stacking networking arch
Date: Wed, 14 May 2025 17:25:30 +0800
Message-ID: <41542B8DA1F849A9+20250514092534.27472-1-tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: MOfwHzgDpc8ILM8KD/PYw+zl2pnanJJst64Z3ZHpokqPEMZlukNyIBD7
	z+XIYAXzDR0dpXukhSekkKUns8ztow7cbt02eN2PLSR8efpZW6HeY0htMNpdTSOl3X5/VPP
	kCJGcwnCIHVrayTKIMEBPstNdc4fTCmGFVZzewyhXwOC29ygdUCahzZa5WqOuGus51wNx6x
	H46dR9FAfm+xYsqrwE9QJoEnOyKRhI77vIiUygsGyK8An3eWKAxqEM9TrKztIpm0sDQrDoz
	dFtDDexKJ5TYmxzo7qVbyCpssWDcdTwqayxUFEF2qoOMrQ5cvr+NPDttfbjDG7jL7+ycTze
	CIJ7FtZBsvN5crTqhS3FiK2ccj7HZUsnLAMJkSNXeFJ0Ve5g1g4NWbgjh/JrKpeVp/Vpokq
	tIBQ+7t6GUq3xRfwiKI3T01oNmGNA/YMykk7agtaOc6TZospn3jtH7OR4yerIHLVuYbqdvO
	Q2QJNpWS2ZrRAbni/CCT/0qafdb5RIgGtsNl1CWvaHWFyAPYN4K9hGq/a5diHhGw9q98JSa
	P0z96fVhEb0TrjdUZwJlcBWPLymPHzFmcX5fIn66yPIMfdiH9AGwLCTvG4tqGioeyE9nBUk
	pRqHvdfHM0uMVkqMFWxIK2h4YPkfTLyVsvTrt0PE9oz2F9fTvyarO4KK7VNoh8OU1jxGvoZ
	PkitiqAnBbj8uoB6RF0PtSjR9F5Y1Foczg6si+G6a0VKynrr4Oez7+gxof9kZQX/CMa3tDu
	2ch3U6WSVqDu34roi/qjNZ7HqiOE7T+lY63TGl7PQen5CPduwwsdVVOLlh64fGAnWIyjE3y
	ToJCk+x287wPJQTO3lG7/zBETi1gOO7SeV78/uBKDSsNEzr/QQ2pV9/+YuVIKj5yOt8CvBz
	qmBxpIpXuH42xmYaChuSqKSnSu0/MpJkfO4qAcT2qG9lO2R+8WG8s9uhJpahr4sLOsBIPrN
	GJ1zvc9j9+sWXFe7TMN3p4U6PNQoUWECwdL0IPx8IzBI9Q7dwJEpjh5pQMGv/cZ3jqt5kJL
	jfTqYffw==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

For no-stacking networking arch, and enable the bond mode 4(lacp) in
datacenter, the switch require arp/nd packets as session synchronization.
More details please see patch.

v4 change log:
- fix dec option in bond_close

v3 change log:
- inc/dec broadcast_neighbor option in bond_open/close and UP state.
- remove explicit inline of bond_should_broadcast_neighbor
- remove sysfs option
- remove EXPORT_SYMBOL_GPL
- reorder option bond_opt_value
- use rcu_xxx in bond_should_notify_peers.

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
 drivers/net/bonding/bond_main.c      | 63 +++++++++++++++++++++++++---
 drivers/net/bonding/bond_netlink.c   | 16 +++++++
 drivers/net/bonding/bond_options.c   | 35 ++++++++++++++++
 include/net/bond_options.h           |  1 +
 include/net/bonding.h                |  3 ++
 include/trace/events/bonding.h       | 37 ++++++++++++++++
 include/uapi/linux/if_link.h         |  1 +
 9 files changed, 179 insertions(+), 7 deletions(-)
 create mode 100644 include/trace/events/bonding.h

-- 
2.34.1


