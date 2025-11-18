Return-Path: <netdev+bounces-239476-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C02A2C68AE6
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 11:01:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 397FC354A84
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C112032D0CD;
	Tue, 18 Nov 2025 10:01:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3296C32D435
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 10:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763460060; cv=none; b=tLRS/ipSIE8Fb18ZXpJ5eI7O/O67RfLRLLMe6O4HV2R9PtX4s3Xdj1fsOqLaF9JEU5eCF1hH62spAvah6JvylDUcs03FMcfbHooqx5LRtYkSbjzkf2G95MsiC7LEEjboQI5zs7VE584A/qZhanuuwFQIxQQGcpoxWtosbG1V8NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763460060; c=relaxed/simple;
	bh=U33qyF00O3e8KmBYVJcJ7XWe2SkBsSxVU+kiCOmwK9o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=g3al/GK9PbS4XgnvPTqjFBFPd5qz7vPx29cRGPqLOxv3QgLVkd7Z0jn3qoeEw2zbqYrwniUgKyu3P3HZFOhHrAmMadxK+tzP9DOLb8xx+gw8GgUnRh5IW/D5kL9hHCol7NJMhk/fOILovdAVv/hJQaPBbTUo0fRPqTmqHvujsX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d9g8X42mXzJ46hD
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:00:12 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 9A6C51404FE
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 18:00:54 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 18 Nov 2025 13:00:54 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, <edumazet@google.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>
Subject: [PATCH v4 net-next 00/13] ipvlan: support mac-nat mode
Date: Tue, 18 Nov 2025 13:00:32 +0300
Message-ID: <20251118100046.2944392-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml500003.china.huawei.com (7.188.49.51) To
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

Dmitry Skorodumov (13):
  ipvlan: Support MACNAT mode
  ipvlan: macnat: Handle rx mcast-ip and unicast eth
  ipvlan: Forget all IP when device goes down
  ipvlan: Support IPv6 in macnat mode.
  ipvlan: Fix compilation warning about __be32 -> u32
  ipvlan: Make the addrs_lock be per port
  ipvlan: Take addr_lock in ipvlan_open()
  ipvlan: Don't allow children to use IPs of main
  ipvlan: const-specifier for functions that use iaddr
  ipvlan: Common code from v6/v4 validator_event
  ipvlan: common code to handle ipv6/ipv4 address events
  ipvlan: Ignore PACKET_LOOPBACK in handle_mode_l2()
  selftests: drv-net: selftest for ipvlan-macnat mode

 Documentation/networking/ipvlan.rst           |  20 +
 drivers/net/ipvlan/ipvlan.h                   |  45 +-
 drivers/net/ipvlan/ipvlan_core.c              | 486 ++++++++++++++++-
 drivers/net/ipvlan/ipvlan_main.c              | 506 ++++++++++++++----
 include/uapi/linux/if_link.h                  |   1 +
 tools/testing/selftests/net/Makefile          |   3 +
 .../selftests/net/ipvtap_macnat_bridge.py     | 174 ++++++
 .../selftests/net/ipvtap_macnat_test.sh       | 332 ++++++++++++
 8 files changed, 1426 insertions(+), 141 deletions(-)
 create mode 100755 tools/testing/selftests/net/ipvtap_macnat_bridge.py
 create mode 100755 tools/testing/selftests/net/ipvtap_macnat_test.sh

-- 
2.25.1


