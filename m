Return-Path: <netdev+bounces-132676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96C81992C38
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 14:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8F031C22434
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 12:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DDB1D3581;
	Mon,  7 Oct 2024 12:41:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1A71D27A4;
	Mon,  7 Oct 2024 12:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728304914; cv=none; b=khm6ofwdrUcgxQVLvyrXYrBQq+0ByNrfaB7kZz81RZ1GQy1JoSB9els+mMCzJn2f8bb2DX/i2VeiWR0xMYAKZU3+A5VpSOn9RI4u5hbHH/9XIKzqECGPtJ8WhUnTXhFHwCfTHydM4kqb3eKANZWqTTp/7lQ+9pGJ4cnRqOYR8H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728304914; c=relaxed/simple;
	bh=mSt7Jxuw5jwJ1WrumRHAQaUUlZVrPb9CVd42+x91H4Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n1E6Uqt5ulnR6q4WLA/nA7YV8IpF73yn//h67PL1qujdZ0NCFIJh7c5cLJ3sNPUtSf5FkzoJh6aYRW+72shEOxB7HeozOJURJK1y3/Fl3qZlbUe0X6KfCCjWFE6XbHOdAa+f+vz2l1uHbNbBCwZaEG4/SgVFQq00MAMP0IRmHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XMf0W61tGz6K8n6;
	Mon,  7 Oct 2024 20:41:31 +0800 (CST)
Received: from frapeml500005.china.huawei.com (unknown [7.182.85.13])
	by mail.maildlp.com (Postfix) with ESMTPS id E292E1404F9;
	Mon,  7 Oct 2024 20:41:43 +0800 (CST)
Received: from china (10.200.201.82) by frapeml500005.china.huawei.com
 (7.182.85.13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 7 Oct
 2024 14:41:39 +0200
From: Gur Stavi <gur.stavi@huawei.com>
To: Gur Stavi <gur.stavi@huawei.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v01 0/4] net: af_packet: allow joining a fanout when link is down
Date: Mon, 7 Oct 2024 15:40:23 +0300
Message-ID: <cover.1728303615.git.gur.stavi@huawei.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 frapeml500005.china.huawei.com (7.182.85.13)

PACKET socket can retain its fanout membership through link down and up
and (obviously) leave a fanout while it is not RUNNING (link down).
However, socket was forbidden from joining a fanout while it was not
RUNNING.

This patch allows PACKET socket to join a fanout while not RUNNING.
Selftest psock_fanout is extended to test this scenario.
This is the only test that was performed.

This scenario was identified while studying DPDK pmd_af_packet_drv.
Since sockets are only created during initialization, there is no reason
to fail the initialization if a single link is temporarily down.

I hope it is not considered as breaking user space and that applications
are not designed to expect this failure.

Gur Stavi (4):
  af_packet: allow fanout_add when socket is not RUNNING
  selftests: net/psock_fanout: add loopback up/down toggle facility
  selftests: net/psock_fanout: restore loopback up/down state on exit
  selftests: net/psock_fanout: socket joins fanout when link is down

 net/packet/af_packet.c                     |  10 +-
 tools/testing/selftests/net/psock_fanout.c | 124 ++++++++++++++-------
 2 files changed, 90 insertions(+), 44 deletions(-)


base-commit: c824deb1a89755f70156b5cdaf569fca80698719
-- 
2.45.2


