Return-Path: <netdev+bounces-253317-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIu+MZ3ldmkrYgEAu9opvQ
	(envelope-from <netdev+bounces-253317-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 04:55:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D64583C12
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 04:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD2D230062F2
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 03:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BC92F39C1;
	Mon, 26 Jan 2026 03:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="l3zxjgkW"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29CE1A317D;
	Mon, 26 Jan 2026 03:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769399704; cv=none; b=T1h4kSffLaTq/qTRayf4pliWJjuqkmOoortgEm5UpqJZoQpthbH2Be1TXh93Nb+UixBVxWxus130JtNvlQdIk9tavIJ15VDyw3LYaQcwRGy8/E7vWYtadJVrxkQmOIXpSosWMykIu3pH0/uoWcOJ9fGzz1W5IomiicZ2nvND9ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769399704; c=relaxed/simple;
	bh=KjdUQdBnQiCsWR9hOk8kUAAM2eIk6tO3xj0UcmIso28=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gI3zWhO36M/4CjDJqD57pqlC+4Y6e3rGatRYbRdVfNy7S5swPj9HoeZDAMFqaRACFsZwY6uPbjDEnqKdkX0Cg+jDnLps/coDxpnBF5PXFm9rHmCNiW6q0mm9P6GncRf64bzawRsYr4n7LqUfomhBruxDXUlTU5IJJOubfH+lgdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=l3zxjgkW; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1OFCP67j9jeqr1BTrhOcHzDLjBLjeculXCbuB+OUfhs=;
	b=l3zxjgkWKcRZ9JrpU/8rYzZ2AAPpFew9z+3QFkV0NLkFU7qR21HtMLSLkXIP1yGGg99F3yMO5
	aKVmd/g8V1YnNdiyL71dODmhLzPNkxSav2TUD4GSYUpv36+nlzwREw+KF2MIxxNfgqtZLRKksFB
	qo9/ni4PXoo/pN+KBfc1i3E=
Received: from mail.maildlp.com (unknown [172.19.163.0])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dzvhf6SJTzpTSk;
	Mon, 26 Jan 2026 11:50:58 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
	by mail.maildlp.com (Postfix) with ESMTPS id 2B4594056B;
	Mon, 26 Jan 2026 11:54:53 +0800 (CST)
Received: from huawei.com (10.50.159.234) by kwepemk500008.china.huawei.com
 (7.202.194.93) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 26 Jan
 2026 11:54:52 +0800
From: Chen Zhen <chenzhen126@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<huyizhen2@huawei.com>, <gaoxingwang1@huawei.com>
Subject: [PATCH v4 net 0/2] net: vlan: fix skb_panic bug in vlan_dev_hard_header()
Date: Mon, 26 Jan 2026 12:04:24 +0800
Message-ID: <20260126040426.2570396-1-chenzhen126@huawei.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500008.china.huawei.com (7.202.194.93)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[chenzhen126@huawei.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253317-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_FIVE(0.00)[6];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:mid,huawei.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3D64583C12
X-Rspamd-Action: no action

This series fix a skb_panic bug in vlan_dev_hard_header().

If a vlan device with reorder_hdr off is created without hw offload
feature, but up with hw offload on, the ndisc skb has no enough
room for vlan hdr in vlan_dev_hard_header() and finally panic.

The first patch fixes the bug itself by always set hard_header_len with
VLAN_HLEN. The second patch adds a regression test for this bug.

---
v3 -> v4:
- Change the fix method to cover other callers as suggested by Eric, thx!
- v3: https://lore.kernel.org/all/20260112075939.2509397-1-chenzhen126@huawei.com/

v2 -> v3:
- Add a comment to test script to silence shellcheck SC2329 warning
- v2: https://lore.kernel.org/all/20260107033423.1885071-1-chenzhen126@huawei.com/

v1 -> v2:
- Address format issues of commit message
- Add a selftest to catch re-occurrence of this issue as suggested by Jakub
- v1: https://lore.kernel.org/all/20251231035419.23422-1-chenzhen126@huawei.com/

Chen Zhen (2):
  net: vlan: always set hard_header_len with VLAN_HLEN
  selftests: vlan: add test for turn on hw offload with reorder_hdr off

 net/8021q/vlan.c                              |  5 ---
 net/8021q/vlan_dev.c                          |  8 ++---
 tools/testing/selftests/net/Makefile          |  1 +
 .../testing/selftests/net/vlan_hw_offload.sh  | 31 +++++++++++++++++++
 4 files changed, 35 insertions(+), 10 deletions(-)
 create mode 100755 tools/testing/selftests/net/vlan_hw_offload.sh

-- 
2.33.0


