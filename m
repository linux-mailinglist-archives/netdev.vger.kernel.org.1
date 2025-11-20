Return-Path: <netdev+bounces-240510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F20CC75D12
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 18:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id CBEFC346B88
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 17:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9BB627FD6D;
	Thu, 20 Nov 2025 17:50:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD451F0995
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763661002; cv=none; b=fvQb9jhFWIvvytBl/gDe7TuAVCFa7Ls8pl7390WB5RKQVxpEo6hWoCFrZr/Pdu0JRCNhKciZaANHoVClolCBDLlw2u5o+Grp7zyU/q5kufnRPkXQX9budFQp5wVwJ2lk4CCp1+/bjNMEKC4mMkV8N5DiwVnW1YM9Dcu3g8Zxtxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763661002; c=relaxed/simple;
	bh=hgpgSpE9+b5syoXb7NqY3pXqB22X6YPN+HqOuWl/nSs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sox5NuNi277siksNTgAr+wZLQRIKuP9Fe+mI44RFFSf9dXY5u0OnRHPJMJSUQqqalOGP3hUcnTsY7Fh9k6pVTUcQUacFcZWXjjKNXNitu44oFxkcpg88BYJvE/iIYbzzIwKK+YQQq5c/D93+LT47XsChWAYuuV5mEazifKxUWJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dC5Sx2s5pzHnGcx
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 01:49:21 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 8B13E1402FD
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 01:49:56 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 20 Nov 2025 20:49:55 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, <edumazet@google.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>
Subject: [PATCH v5 net-next 00/12] ipvlan: support mac-nat mode
Date: Thu, 20 Nov 2025 20:49:37 +0300
Message-ID: <20251120174949.3827500-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500004.china.huawei.com (7.188.26.250) To
 mscpeml500004.china.huawei.com (7.188.26.250)

pvlan: support mac-nat mode

ipvlan: Add support of MAC-NAT translation in L2-bridge

Make it is possible to create link in L2_MACNAT mode: learnable
bridge with MAC Address Translation. The IPs and MAC addresses will be learned
from TX-packets of child interfaces.

Also, dev_add_pack() protocol is attached to the main port
to support communication from main to child interfaces.

This mode is intended for the desktop virtual machines, for
bridging to Wireless interfaces.

The mode should be specified while creating first child interface.
It is not possible to change it after this.

This functionality is quite often requested by users.

diff from v4
- Patch "Fix compilation warning about __be32 -> u32"
was sent as a separate patch, out of this series
- Fixed unused-variable "orig_skb" in "Support IPv6 in macnat mode."
patch
- Fixed shellcheck and pylint warnings in "selftests: net" patch
- Fixed conflict with Makefile in selftests/net
- Fixed "suspicious RCU usage" warning in ipvlan_addr_event() func:
need to use ipvlan_port_get_rcu_rtnl(), since this function can
be called with either rtnl or just with rcu for some ipv6 events

diff from v3:
- Restructured code, to place all new functionality under
if (ipvlan_is_macnat(port) condition and minimize refactoring
of existing code.
- Added kselftest for the new functionality
- Removed patch with unnecessary gso_segment() call
- Patches 1-3 were merged into 1
- Fixed compilation warnings about __be16/__be32 conversions

diff from v2:
- forgotten patches (10..14) added

diff from v1:

- changed name of the mode to be L2_MACNAT
- Fixed use of uninitialized variable, found by Intel CI/CD
- Fixed style problems with lines more then 80 chars
- Try to use xmastree style of vars declarations
- Fixed broken intermediate compilation
- Added check, that child-ip doesn't use IP of the main port
- Added patch to ignore PACKET_LOOPBACK in handle_mode_l2()
- Some patches with style-refactoring of addr-event notifications

*** BLURB HERE ***

Dmitry Skorodumov (12):
  ipvlan: Support MACNAT mode
  ipvlan: macnat: Handle rx mcast-ip and unicast eth
  ipvlan: Forget all IP when device goes down
  ipvlan: Support IPv6 in macnat mode.
  ipvlan: Make the addrs_lock be per port
  ipvlan: Take addr_lock in ipvlan_open()
  ipvlan: Don't allow children to use IPs of main
  ipvlan: const-specifier for functions that use iaddr
  ipvlan: Common code from v6/v4 validator_event
  ipvlan: common code to handle ipv6/ipv4 address events
  ipvlan: Ignore PACKET_LOOPBACK in handle_mode_l2()
  selftests: net: selftest for ipvlan-macnat mode

 Documentation/networking/ipvlan.rst           |  22 +-
 drivers/net/ipvlan/ipvlan.h                   |  51 +-
 drivers/net/ipvlan/ipvlan_core.c              | 479 ++++++++++++++++-
 drivers/net/ipvlan/ipvlan_main.c              | 506 ++++++++++++++----
 include/uapi/linux/if_link.h                  |   1 +
 tools/testing/selftests/net/Makefile          |   2 +
 .../selftests/net/ipvtap_macnat_bridge.py     | 168 ++++++
 .../selftests/net/ipvtap_macnat_test.sh       | 333 ++++++++++++
 8 files changed, 1422 insertions(+), 140 deletions(-)
 create mode 100755 tools/testing/selftests/net/ipvtap_macnat_bridge.py
 create mode 100755 tools/testing/selftests/net/ipvtap_macnat_test.sh

-- 
2.25.1


