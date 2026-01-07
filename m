Return-Path: <netdev+bounces-247568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A6BCFBD47
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 04:24:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1CC9302EA18
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 03:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5DE323EAAF;
	Wed,  7 Jan 2026 03:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="z2ZYJACT"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com [113.46.200.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DFA18A6CF;
	Wed,  7 Jan 2026 03:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767756255; cv=none; b=DCEfamdO3OFz3lzRf96kPgJcWvXLyqhSIz03IWxLNaWYFLFiuBYjZKBWmM2f6UehH6xAfAqCK+gHQCpqTavmYPUPi48sl0x8whpN/4HbxiAJmKTJFQPsQhoax8tdvgorM8WhZdesufopbIEZFaDuQ8DUqGns46gg1ubeMsLx6ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767756255; c=relaxed/simple;
	bh=uPpWryUtAQnzsIeLTD6aEyIUEbW6hGT29qYNh7iVODU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VtmOoC0RG2cvgHMihlbRm6Lp0NFX2R6wnskNLLptIlaLEz41sK4rwaIRsLtMMoOzvZLT6yQAm3+WDu0Q+7siNiN4VfCssJT6fTPGJ4FDhhXin6t0kdw5XhYhscQbKCVqCqndi4v0aWxIrmoVFxrK7uT6g3lHZQdp6mDdY0rzUug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=z2ZYJACT; arc=none smtp.client-ip=113.46.200.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=kk1na1214koTBVutaIhxMMAHNWxBFufVUhdI7IlzCa4=;
	b=z2ZYJACT/Y1xkplWKyyGVSV8Icwl3yFPspHbTwJ/h8sEA2a9AoUZkcOBtVOgtD4MC/3GTdTT/
	wgMPzHW8ABXe6u7f+ZdYR7Sbz7Sdycz35YwiwIg6l6Mf7gjxwPvBqsw9870NzGruv3NY89V/NYM
	Y5Tuz8DmKO+k+Ohjci1myUM=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4dmCwl6JxTz1cyQ8;
	Wed,  7 Jan 2026 11:20:55 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 99E66402AB;
	Wed,  7 Jan 2026 11:24:10 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemk500008.china.huawei.com
 (7.202.194.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 7 Jan
 2026 11:24:09 +0800
From: Chen Zhen <chenzhen126@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<huyizhen2@huawei.com>, <gaoxingwang1@huawei.com>
Subject: [PATCH v2 net 0/2] net: vlan: fix skb_panic bug in vlan_dev_hard_header()
Date: Wed, 7 Jan 2026 11:34:21 +0800
Message-ID: <20260107033423.1885071-1-chenzhen126@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemk500008.china.huawei.com (7.202.194.93)

This series fix a skb_panic bug in vlan_dev_hard_header().

If a vlan device with reorder_hdr off is created without hw offload
feature, but up with hw offload on, the ndisc skb has no enough
room for vlan hdr in vlan_dev_hard_header() and finally panic.

The first patch fixes the bug itself by also setting header_ops of
vlan dev when offload feature is toggled. The second patch adds a
regression test for this bug.

---
v1 -> v2:
- Address format issues of commit message
- Add a selftest to catch re-occurrence of this issue as suggested by Jakub
- v1: https://lore.kernel.org/all/20251231035419.23422-1-chenzhen126@huawei.com/

Chen Zhen (2):
  net: vlan: set header_ops to match hard_header_len when hw offload is
    toggled
  selftests: vlan: add test for turn on hw offload with reorder_hdr off

 net/8021q/vlan.c                              |  5 +---
 net/8021q/vlan.h                              |  3 ++
 net/8021q/vlan_dev.c                          | 22 +++++++++-----
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/vlan_hw_offload.sh  | 30 +++++++++++++++++++
 5 files changed, 49 insertions(+), 12 deletions(-)
 create mode 100755 tools/testing/selftests/net/vlan_hw_offload.sh

-- 
2.33.0


