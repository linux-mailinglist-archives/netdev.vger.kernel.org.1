Return-Path: <netdev+bounces-231292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA236BF724A
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 16:46:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6015F1889692
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 14:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C83336EFA;
	Tue, 21 Oct 2025 14:46:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2A0733F8DF
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 14:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761057986; cv=none; b=ZPHjAGNQAD3h7U4wiCsT6WuPjCAVBWMYyD6s4QKyCsRrCV6NyKKxUycc1Ef1h+V1xQ/HObv7UENbTTl3bYcZ2mice2PojR4we79yWr+g+iIMiEHD6LE6Q0xxQUZHU6YH20Nm0PzsFl0teTUJ7E4udMjRr2UYuYS22+UksR9BkJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761057986; c=relaxed/simple;
	bh=xLfno+IO9hc3akGgneRxzGnmvSurooEjVFePZwdN/bU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=acbj+qVBxfeJuu9J8VhWKsacOgORs1k2Bzl1d+S3OshXPnZogQtGZbCFYsAsAUSgrKJcDNBFbRQazGRlQ9/7Fl1Qmmzjgt2dqJK9tiIniugjNxd7ZFm2/ptF6mwTn9VzcE2HrAeXjRYl2MnRUxDY+qe66mSGN1F5cQZOkpGynHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4crZp429xgz6K6Nf
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 22:45:00 +0800 (CST)
Received: from mscpeml500004.china.huawei.com (unknown [7.188.26.250])
	by mail.maildlp.com (Postfix) with ESMTPS id B627014011A
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 22:46:21 +0800 (CST)
Received: from huawei-ThinkCentre-M920t.huawei.com (10.123.122.223) by
 mscpeml500004.china.huawei.com (7.188.26.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Oct 2025 17:46:21 +0300
From: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
To: <netdev@vger.kernel.org>
CC: <andrey.bokhanko@huawei.com>, Dmitry Skorodumov
	<skorodumov.dmitry@huawei.com>
Subject: [PATCH net-next 0/8] ipvlan: Implement learnable L2-bridge
Date: Tue, 21 Oct 2025 17:44:02 +0300
Message-ID: <20251021144410.257905-1-skorodumov.dmitry@huawei.com>
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

Make it is possible to create link in L2E mode: learnable
bridge. The IPs will be learned from TX-packets of child interfaces.

Also, dev_add_pack() protocol is attached to the main port
to support communication from main to child interfaces.

This mode is intended for the desktop virtual machines, for
bridging to Wireless interfaces.

The mode should be specified while creating first child interface.
It is not possible to change it after this.

This functionality is quite often requested by users.

Dmitry Skorodumov (8):
  ipvlan: Implement learnable L2-bridge
  ipvlan: Send mcasts out directly in ipvlan_xmit_mode_l2()
  ipvlan: Handle rx mcast-ip and unicast eth
  ipvlan: Added some kind of MAC SNAT
  ipvlan: Forget all IP when device goes down
  ipvlan: Support GSO for port -> ipvlan
  ipvlan: Support IPv6 for learnable l2-bridge
  ipvlan: Don't learn child with host-ip

 Documentation/networking/ipvlan.rst |  11 +
 drivers/net/ipvlan/ipvlan.h         |  26 ++
 drivers/net/ipvlan/ipvlan_core.c    | 488 +++++++++++++++++++++++++---
 drivers/net/ipvlan/ipvlan_main.c    | 219 +++++++++++--
 include/uapi/linux/if_link.h        |   1 +
 5 files changed, 659 insertions(+), 86 deletions(-)

-- 
2.25.1


