Return-Path: <netdev+bounces-191434-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF277ABB7AD
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12A1D7A90FD
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B582690F9;
	Mon, 19 May 2025 08:44:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14E826A0FC
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644289; cv=none; b=eRlzeHfwB2iPRPw7UkEFWT1S6v7kaO1ayo5brs1p8WCEj79i0m2sxSUGezsb5fAW6C1MchGNs8cQMDj8RhfLVp/mb/gsYPlyWvhGnj090ktoVC8JlmAPLUqpwHn3ENgvMXfp+CE4bS+eWbVVfQcHGs2mUjFEPEIhvbMwgyXDzIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644289; c=relaxed/simple;
	bh=DmfxJlNt551rhtA+CTICeawWRTZGT+ew0Zj9+mRoGwg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kRZ+l1C2XQXOB1uKIAQ3lGWvDMsDMthHTJCX4WZ5exZdOI+wDF1bWATcC0+tc+BCuheWjsFgcEWVPKi3LavbP9psuZfKll9bpuSVY03vCj4bpVI2KpBjHcoHy9MolZuH4WFuuAQkl2DyF/WBwlMxNMuLmg41c2DhF0La0eApJ/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz15t1747644207t15379643
X-QQ-Originating-IP: TJPFv31puFHO6rAIQKXdSfwfEdhLzMTlKvKoUjssqdc=
Received: from localhost.localdomain ( [111.202.70.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 19 May 2025 16:43:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 175919231919580
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
Subject: [PATCH net-next v5 0/4] add broadcast_neighbor for no-stacking networking arch
Date: Mon, 19 May 2025 16:43:11 +0800
Message-ID: <B713F1A654D10D79+20250519084315.57693-1-tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: Mc/7Da/97eYXGcUY9XtZhpji9oIYx73axPEGL/P37yNXUSjI0x6ZE/mQ
	rtN7FkdBn5lfUU7EpBGpCjm7hP6nmjJiZErFV29i5g9YZv4mCVrYBQNvLQJkWODsARWL1FS
	PgaWEqT/aspOchubxx9+XSwP2MPXtbKVtChXWrTIjDemY3TVRMuWlp6EbzgEZywpfnhWmKO
	bBHBerIuqxV4YgvW8ZNS14QQ4p0qWjRJQ0w6bIwqYYInGW46Z4YlvE+LhK0GQHIIALEewfU
	zQpjNpL/ZMvElbyPQJDqbFqwXXzlIeZFLo7zTdg7fKuShDPirVxBpd296BKWAfBnshO2/AQ
	2AYWg2sTzsA+iMOJwHUnDVUivFfg28a2Y3EFwGxSVFfoNNlz86T23SXDnJJDvOOgBSD5l/m
	2csBMU0zvhz1+HkQu5A6YkaUdADRpXlmvGeeW/+1IuHXkPQdnY9Tu7R1hete/uBQnrE8GEO
	0aADVHrEx+8K61opsOL6OpAGlwhE00Abk7sPuoUgCEIMdz1LtFIbZ0WiOjVSheRWr3YmngW
	Se+y5cbOTjDyNfmRjE843eqf5myvQRE8cxbVPnbJ8lsvXY+9WkRjawSnWoN+9QCRWnDGoz8
	uGHJb3cw9hQsRjpY+cd1Uhug+JSLZW8uGK8Qv64MSoX/bEUuxwjuzBrHHFEh3XxXhYcVpC7
	PBC1Rox2P3z6HksZvdj5XzsVNL0Z25Nt0d8HUaENLEnLlrDqWhpLD+yO0h9zIY5I53WDJ7G
	OPIrwUiW6F6wRIAI7KrYnPRrePiGRa3zyq4HMfX9Rdr8TrmKqKIw5j5buHv4B8cozEzHsRh
	ig1BdHsgCBWYXMPkw+p6emh+J+6br8f0HcO7tWFXQQtNmxyLJgj0yiA+ln912gk+5OQ2YtD
	ztg6FmaAyq0L7eehiA4GC+VnaJVCtC5wDmc2yf05PHwxkr2sIBteZSkXc05rM0eazoPYIkh
	rDa0dcK/GlLHGsxl4iBYhZBg+4E5v5eRCN0m/t3BoGcPtaw==
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
Cc: Zengbing Tu <tuzengbing@didiglobal.com>

Tonghao Zhang (4):
  net: bonding: add broadcast_neighbor option for 802.3ad
  net: bonding: add broadcast_neighbor netlink option
  net: bonding: send peer notify when failure recovery
  net: bonding: add tracepoint for 802.3ad

 Documentation/networking/bonding.rst | 11 +++-
 drivers/net/bonding/bond_3ad.c       | 19 ++++++
 drivers/net/bonding/bond_main.c      | 86 ++++++++++++++++++++++++----
 drivers/net/bonding/bond_netlink.c   | 16 ++++++
 drivers/net/bonding/bond_options.c   | 35 +++++++++++
 include/net/bond_options.h           |  1 +
 include/net/bonding.h                |  3 +
 include/trace/events/bonding.h       | 37 ++++++++++++
 include/uapi/linux/if_link.h         |  1 +
 9 files changed, 197 insertions(+), 12 deletions(-)
 create mode 100644 include/trace/events/bonding.h

-- 
2.34.1


