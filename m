Return-Path: <netdev+bounces-248906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF67D10F55
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 08:49:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F167301AE1F
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 07:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988013358B6;
	Mon, 12 Jan 2026 07:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="kr1ZSltN"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87DE30DD22;
	Mon, 12 Jan 2026 07:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768204182; cv=none; b=jnpu4BkzLAzzRpV41NtYW6xmYeBz7ECGZL7cNWYGPpg5rGoEoKCjSaXSD6fcdctQ7qwW8+FecECRwN6eV5PjQWqwt/fU0xwZMIK46SNFCSufpD+RL8v4b2XfFMwnZccNe/UugsxCf+/nRyOI4B04ee3hjk8s+zHj5d5qVlZHn9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768204182; c=relaxed/simple;
	bh=acEinsd+cYwDunIPMu8r7hwGkL7ilrM2bY0mwBVUyQ8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HprGqLU2r7NRBVzMvlsJG1fyWRtCUG/O15B9ZM+IUtENrKpUrO517jyQdH/GI/elS7+F/ALKR177RAw2+LmbpIOXE8gWIuMkL8mga2amLdFN0PbIw07YbcGFj+PIIaBcaWqy93N9CBrrEaL+3t5dlNmb9xIMCVw0P7srzyazemQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=kr1ZSltN; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gFsaaO3Y93zCJd8FnHPVdx11ofZuBzyhRRkST0PbpKU=;
	b=kr1ZSltNV7kYaAa0wuyVLiII/zEgJbnl6JKDDFvVO6XxYtAdnr6Tb2KJBvsxoPLoXQXUYHLSt
	NyGUlzpCa0FN8XAHjsvDO+z6UTzRrZ8TLvht/SxqdWKyVvzxEzMs7kkkSFFabp0OQN7lxz7pFla
	Kmiwx9BiMWLbmquDXy638tk=
Received: from mail.maildlp.com (unknown [172.19.162.92])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dqPZg34FczLlSZ;
	Mon, 12 Jan 2026 15:46:19 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 1D74D40565;
	Mon, 12 Jan 2026 15:49:37 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemk500008.china.huawei.com
 (7.202.194.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 12 Jan
 2026 15:49:36 +0800
From: Chen Zhen <chenzhen126@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<huyizhen2@huawei.com>, <gaoxingwang1@huawei.com>
Subject: [PATCH v3 net 0/2] net: vlan: fix skb_panic bug in vlan_dev_hard_header()
Date: Mon, 12 Jan 2026 15:59:37 +0800
Message-ID: <20260112075939.2509397-1-chenzhen126@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500008.china.huawei.com (7.202.194.93)

This series fix a skb_panic bug in vlan_dev_hard_header().

If a vlan device with reorder_hdr off is created without hw offload
feature, but up with hw offload on, the ndisc skb has no enough
room for vlan hdr in vlan_dev_hard_header() and finally panic.

The first patch fixes the bug itself by also setting header_ops of
vlan dev when offload feature is toggled. The second patch adds a
regression test for this bug.

---
v2 -> v3:
- Add a comment to test script to silence shellcheck SC2329 warning
- v2: https://lore.kernel.org/all/20260107033423.1885071-1-chenzhen126@huawei.com/

v1 -> v2:
- Address format issues of commit message
- Add a selftest to catch re-occurrence of this issue as suggested by Jakub
- v1: https://lore.kernel.org/all/20251231035419.23422-1-chenzhen126@huawei.com/

Chen Zhen (2):
  net: vlan: set header_ops to match hard_header_len when hw offload is
    toggled
  selftests: vlan: add test for turn on hw offload with reorder_hdr off

 net/8021q/vlan.c                              |  5 +--
 net/8021q/vlan.h                              |  3 ++
 net/8021q/vlan_dev.c                          | 22 ++++++++-----
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/vlan_hw_offload.sh  | 31 +++++++++++++++++++
 5 files changed, 50 insertions(+), 12 deletions(-)
 create mode 100755 tools/testing/selftests/net/vlan_hw_offload.sh

-- 
2.33.0


