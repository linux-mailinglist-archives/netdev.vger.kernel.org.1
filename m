Return-Path: <netdev+bounces-235856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E0A0C36A91
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 17:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE321A26176
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 16:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3E4337BA6;
	Wed,  5 Nov 2025 16:08:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F520334692
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 16:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762358886; cv=none; b=of9N2wyYBFKWNi0v34R5Spp+OxyUcxPE/n37tNxr0eERWvtfhKReMVCyCyR3LxWJb7hS6LKByd9WsRkcI79RK+W95V7MTG7Ya3r0YbxORslT9wTw12N0gs9wDqU6TRcISR0yWakhQf8bIp5Kubwg7FpVGegaS8RfmjUO0FfwzYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762358886; c=relaxed/simple;
	bh=Zmz5qw9S0+jJHSLp9BZ/0IrZnqhCptd2zJ6gB3+DTuA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LNz14DnohwYU+5jhlDZa28C5uFS6me0lpwTfAwCctcmdCArh6RNv/uKvET9mELMplkgpUYhvAtYEeZl+bs/W9h47fxplFn/ttZGEuj+A6s3WwTvWB0k5Y+YjSBiHzW+Ui1Xq2ZJvTx201+xXZDn9qSXu0w8bWfuvz8rWuvunBIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4d1qrL6WHrz6L50m
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 00:04:02 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id 8F90E1400DB
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 00:07:55 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 5 Nov 2025 19:07:55 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>
Subject: [PATCH net-next v2 00/14] ipvlan: support mac-nat mode
Date: Wed, 5 Nov 2025 19:07:04 +0300
Message-ID: <20251105160713.1727206-1-skorodumov.dmitry@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mscpeml100003.china.huawei.com (10.199.174.67) To
 mscpeml500004.china.huawei.com (7.188.26.250)

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

diff from v1:

- changed name of the mode to be L2_MACNAT
- Fixed use of uninitialized variable, found by Intel CI/CD
- Fixed style problems with lines more then 80 chars
- Try to use xmastree style of vars declarations
- Fixed broken intermediate compilation
- Added check, that child-ip doesn't use IP of the main port
- Added patch to ignore PACKET_LOOPBACK in handle_mode_l2()
- Some patches with style-refactoring of addr-event notifications

Dmitry Skorodumov (14):
  ipvlan: Preparation to support mac-nat
  ipvlan: Send mcasts out directly in ipvlan_xmit_mode_l2()
  ipvlan: Handle rx mcast-ip and unicast eth
  ipvlan: Added some kind of MAC NAT
  ipvlan: Forget all IP when device goes down
  ipvlan: Support GSO for port -> ipvlan
  ipvlan: Support IPv6 for learnable l2-bridge
  ipvlan: Make the addrs_lock be per port
  ipvlan: Take addr_lock in ipvlan_open()
  ipvlan: Don't allow children to use IPs of main
  ipvlan: const-specifier for functions that use iaddr
  ipvlan: Common code from v6/v4 validator_event
  ipvlan: common code to handle ipv6/ipv4 address events
  ipvlan: Ignore PACKET_LOOPBACK in handle_mode_l2()

 Documentation/networking/ipvlan.rst |  11 +
 drivers/net/ipvlan/ipvlan.h         |  45 ++-
 drivers/net/ipvlan/ipvlan_core.c    | 516 ++++++++++++++++++++++++---
 drivers/net/ipvlan/ipvlan_main.c    | 521 ++++++++++++++++++++++------
 include/uapi/linux/if_link.h        |   1 +
 5 files changed, 925 insertions(+), 169 deletions(-)

-- 
2.25.1


