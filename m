Return-Path: <netdev+bounces-192609-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3090CAC07E6
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D938E17E3E8
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:57:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA9828851A;
	Thu, 22 May 2025 08:56:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AFBD2882C7
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904165; cv=none; b=p9U+pMy64uJH/Bym2jqkYc1hqiLI5XxrbYqAtgOKtSijUh4OLXfglMTo4LvBfur04/r6b0/SX6JOZL6FbSEFkxuUliNs/075AlR6IPNoVo1FlG6Pgagm8+qqysv0ypmXXJNSNQc1OetKKFKtE8Dw1RykqOXEFp4X4EcZne6UBt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904165; c=relaxed/simple;
	bh=scBveQ1b+oExKdPFjAvchkdnVaVaWcgGLEcaNJXFPN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=be6e6VRFTXCsdv6A4Z2rXFzKK4Gn2uaXmLHMSC0gGgmAryiX17ftcG+bBT58q8GQhNSRoo8tK8CGnewzLQqGGUQhJEsnP7U+PZWm6cwpJvexWVJHTaEaj1nEr6QlVQpId0Buqntxb5X0qCZI/IO/Cddq6lNn1XbBlLb4D1vgW3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz17t1747904131tf7f6b5d0
X-QQ-Originating-IP: feqT7bdHHay0f8cpDcAhEyWhhGeX5llh/k3dimlgj5s=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 22 May 2025 16:55:28 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 1715539696277243492
EX-QQ-RecipientCnt: 15
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
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: [PATCH RESEND net-next v5 0/4] add broadcast_neighbor for no-stacking networking arch
Date: Thu, 22 May 2025 16:55:12 +0800
Message-Id: <20250522085516.16355-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MG1k13TElWXs+zlFe3SnXmKtNv7NYJIUSgnBkXIOvoyAUL6nDgXzOvK3
	yJjcMci6cdgvQKyV9Kwuibgh1NSBnWi81zz0phDyDFMyhov/TGtFmKyAs1kNTsqTSow/TVt
	JKmoxPDN/a54+bf3NVPv9VsAZFPO0ar/PRR+q+j9SORKdhUhPKsKzIjz7Rkmgbvm4FAKSkQ
	SbC/J7njLkVlx9UUO7DcCL/npSzSErCr1/VmWdjSPt7IstcSBpg9ME6YkofLD5fbIjrn9xb
	D34R7jJUPDNp35gCe+EpDwGoEJbeXr+G6z+//kUwXZdtmmoQHYK4YqZYcXFeaJXno3I7uHz
	agzWRWin6ZfU0O4+z68h/YTftZraHLwSsO0Hb6WmSXOE/Ajq6/6wZHBwVej5DuWChhLTAdJ
	/5W7klY1arMZgjG8r8UwCSgD7TNdJV4DmC+HSp3BBQhZc7/yfbC9dWrKdxxba3h+gV3+HFj
	7BdJ++e0urGADUUyNjdrtj/BQqufNMZ7Ua7K/X0i2Ix5F7HMC2vgiIhjIgXYyKyRalC7m2k
	aCFEI7+OWC1oQBXbn/ku+4dfHPra17y23RNc/8axuc/I6wyOrtj7jV8Leg77TrqYGin2VYB
	A/Oq633m4opArH5L6m262Pi6pXxsvbosjRRC+5sS6bTy1cSDB/LySUnHHzBViDMQ9lQF1VD
	GM2LSVtDFPyNCdHsfZZJAJYtx1D+79y00RcOK6wx/Hy7cqs4XwpGwFl55DuKaCDULgRhIw9
	16Be9iEQw9aiKdHddk/5uHDd/ZmKwJNH+XhXVz+TcyYVmnzje7mHVXJEQPR8fcKc80wI8rb
	GXw+epN68YacTQxb15A8+pprcD8tCNSioE8inmrP7lJ3reE43Xvj05tN6ILkiNVcLk/l701
	nPYSCsZ/gj2yiDV532BeNTNh9+Y2HFGRN2hb4hBh65dU4BHLt11OYbO9dk0+97+LbMpy6Hn
	ssVUV36l+jEjGEY43Zgd5OPnzq7TRTOaRdBSB4tF0n89uxA==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

For no-stacking networking arch, and enable the bond mode 4(lacp) in
datacenter, the switch require arp/nd packets as session synchronization.
More details please see patch.

v5 change log:
- format commit message of all patches
- use skb_header_pointer instead of pskb_may_pull
- send only packets to active slaves instead of all ports, and add more commit log

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
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Zengbing Tu <tuzengbing@didiglobal.com>

Tonghao Zhang (4):
  net: bonding: add broadcast_neighbor option for 802.3ad
  net: bonding: add broadcast_neighbor netlink option
  net: bonding: send peer notify when failure recovery
  net: bonding: add tracepoint for 802.3ad

 Documentation/networking/bonding.rst | 11 +++-
 drivers/net/bonding/bond_3ad.c       | 19 ++++++
 drivers/net/bonding/bond_main.c      | 87 ++++++++++++++++++++++++----
 drivers/net/bonding/bond_netlink.c   | 16 +++++
 drivers/net/bonding/bond_options.c   | 35 +++++++++++
 include/net/bond_options.h           |  1 +
 include/net/bonding.h                |  3 +
 include/trace/events/bonding.h       | 37 ++++++++++++
 include/uapi/linux/if_link.h         |  1 +
 9 files changed, 198 insertions(+), 12 deletions(-)
 create mode 100644 include/trace/events/bonding.h

-- 
2.34.1


