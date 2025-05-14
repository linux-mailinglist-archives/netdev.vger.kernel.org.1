Return-Path: <netdev+bounces-190327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2302FAB63E7
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:15:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A72CC189EB43
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 07:15:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE1B1DA31D;
	Wed, 14 May 2025 07:15:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 948301F1510
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206913; cv=none; b=qyRC2FsyQqXr1yQYR0jUHHZonMcQwfZibb666dlUaA1FhXdS2SQF4WYRI5KwvO4KaYQ1y+AwlOq6gMi2aeutZCLAsUtQIu1ODPJSE4lb1qGCc4PUrysh87sfGeBQvXD1l/0dBw1G6AAxjLb79Q6BjrT6HPE+hoiuWFTxymI7k34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206913; c=relaxed/simple;
	bh=5bzlpSn27rOzY+CGs5kZP8rcfMrsi69wgKsfNx+ywsY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ix2GZzwqWPoe08EM2+rkUw7qyK2lgtAA5LLQGt+qkLHjJkp+dXZHhaB0lLj++REaqciJNBV0bFO8MM9jlrqC2XNwZWJ1I6nG3C0iB5ECf/Cw9lv8faL7MmERqTBoJTM2Cm0t2X5OlR3R6Or23jK4M84dCv8HdE4KFLvi9QCYY60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz11t1747206833t67c28676
X-QQ-Originating-IP: B5ZZB1ex1kVxxCnKVc5LP8v+dF5+YlwyGD3jRARXXu8=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 May 2025 15:13:50 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15815859643666024006
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
Subject: [PATCH net-next v3 0/4] add broadcast_neighbor for no-stacking networking arch
Date: Wed, 14 May 2025 15:13:35 +0800
Message-ID: <94F95A597F5A58DD+20250514071339.40803-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: Mi0NhBPPe/4RNaUsKxjGls87KtJ/IcM6z+e097LapKxz1oNCmPI6iFYH
	Is1SNaYrbewrZctk2sB1mk/tLDQLssT/BBAhJWdeSE0NALJEGWvyyCSkzqTkyE/Cx6blhvN
	ilfwoIwM43R8HydOt8+2LpnPJaGx4IulDlWMciNDz5IaVVGj/481CeKe7qtCrk59qciWC+a
	nzoV9CQEOtnEe61MAVXEeNgL4qNoVTTeQVjpfh0vV/r8hYQbLiykM8KR9kZQrFayNz/51FP
	jStbltPHuWW5rLnIKXuPRIBX837Bom5Eh4ujFckuF2eiqYqLcR8FkBDimzthJKxfW3Vz7wG
	6bmNjmO7fFc/qBgRzxPn67odry6pmqYe5P78zwqRpfTFb97OutIvifsi8QZV47wcxwMICDi
	Q4JHXJVElgtBSyOvolh0f2PKaXxGCtL3FfQ1CeRuClGCU22kemNbAhve6gD9fYIm4zfo8ce
	ZY2MqoyBQJ7Dt/MLrttKdIhAOHK8OMcxyab48SB+pvsNgkSTOVxgrzmUHHQmF/eB5oDATIZ
	DFcBhV/8duccpxwa3GuxPeqxQqE5MAUsY7ZfxtS/9O7rw74Qm0l3oBBJFYNWrWkz6tvV5pR
	bg3XL7blxd54N4IgxDq4bxeCtpww73OUjfaOLF5DnwWzSYSp3M2RXHfPPjVkT7MA9O7eGi1
	hAsHRGfAJEwiOLOxQ20Idt93JckbmZdFWj2UDE5mCzinJIqriiQUaWmU2ygzs3wbRZGSeRW
	gvR3MVB+6yb7Hoq22RZCl7BOWouACv34bu2SChuXQRs545Q3J8DLEQzavEOWHaulvPrVIiB
	z4/B+k74NqnR9aVWJqAZgQKFPgNHAvOVjC9VDGfhSi9A+PO4VBv0LoVuKK0ueAEEf/wC+2j
	iEOqn4wdQvONS9FfJIKZzSy0qfV1cthUthE1UY7pZe9jY4rgMwuLEIFyiBlQZ92n9Gi1wnS
	HJrTJlho2ylkzJGJgDWZn5BIZHDyKR67TNgMO1xr4RVM9a2jmDiFBvJKH
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

For no-stacking networking arch, and enable the bond mode 4(lacp) in
datacenter, the switch require arp/nd packets as session synchronization.
More details please see patch.

v3 change log:
- inc/dec broadcast_neighbor option in bond_open/close and UP state.
- remove explicit inline of bond_should_broadcast_neighbor
- remove sysfs option/EXPORT_SYMBOL_GPL
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
 drivers/net/bonding/bond_main.c      | 62 +++++++++++++++++++++++++---
 drivers/net/bonding/bond_netlink.c   | 16 +++++++
 drivers/net/bonding/bond_options.c   | 35 ++++++++++++++++
 include/net/bond_options.h           |  1 +
 include/net/bonding.h                |  3 ++
 include/trace/events/bonding.h       | 37 +++++++++++++++++
 include/uapi/linux/if_link.h         |  1 +
 9 files changed, 178 insertions(+), 7 deletions(-)
 create mode 100644 include/trace/events/bonding.h

-- 
2.34.1


