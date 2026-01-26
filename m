Return-Path: <netdev+bounces-253316-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ERE6L53ldmkpYgEAu9opvQ
	(envelope-from <netdev+bounces-253316-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 04:55:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A21A983C11
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 04:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 79FA53005AD3
	for <lists+netdev@lfdr.de>; Mon, 26 Jan 2026 03:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AEA62F2613;
	Mon, 26 Jan 2026 03:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hjEfnjmn"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49C628851E;
	Mon, 26 Jan 2026 03:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769399704; cv=none; b=QRDeFeccqafotoDjIFK+Rsu47wL3p/KwhcVEny/Q0u8IbsgQBWWzUBCdMzmD7C+hizSRP7rv9KdxvixWpXJr8BySFXsIXVR7+re7BILRvCcxIhcx71flzLwKuyU3jjDvGJ7gI+tHX8jHIkdveAWWBf/UBWC3n0Oo9zOwvbIaDmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769399704; c=relaxed/simple;
	bh=+NHOarEOw7ad/DwJMieu3uat/+JZlUcJNsTRHqfuxl0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=trevsxehcm1qOor1NSGII5/U/v6YPb4dTk4LWtZiqbEixJHtvpDgfufJDKPUQwAHuNv/gyZYZloxtbymP+p+o47tAcfVY9OzhPwx24Pw/z0BOT84a+v/j7jxfzZUv2qeRFwUl8q3CPD/D8A5vqKEWmd8j3Je8t+cKJpCMASTGhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hjEfnjmn; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=1oqBpN3odo8IB/woCZc9kt1nZY7gWrUSPmRs46mWFPY=;
	b=hjEfnjmn9yX80Hu8sXlDeg52rfIPcycybVzcackvwnoXsGHXJXchS4Nord+KNRBzQc6P/FTZc
	fQsFxeqFJ4MupHhF3DIHF9bnOzcHwxikncdqY0i+SXUWSUVA6DTyrCcAfQBkvSqnfUqvMIrQIHg
	HLMxlFzD2XTCkSVHAqbVWTE=
Received: from mail.maildlp.com (unknown [172.19.163.200])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4dzvjC5JkVzLlSg;
	Mon, 26 Jan 2026 11:51:27 +0800 (CST)
Received: from kwepemk500008.china.huawei.com (unknown [7.202.194.93])
	by mail.maildlp.com (Postfix) with ESMTPS id B5E954055B;
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
Subject: [PATCH v4 net 1/2] net: vlan: always set hard_header_len with VLAN_HLEN
Date: Mon, 26 Jan 2026 12:04:25 +0800
Message-ID: <20260126040426.2570396-2-chenzhen126@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20260126040426.2570396-1-chenzhen126@huawei.com>
References: <20260126040426.2570396-1-chenzhen126@huawei.com>
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
	TAGGED_FROM(0.00)[bounces-253316-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,huawei.com:email,huawei.com:dkim,huawei.com:mid]
X-Rspamd-Queue-Id: A21A983C11
X-Rspamd-Action: no action

When tx-vlan-hw-insert is toggled to on, vlan device hard_header_len
will be reduced to dev->hard_header_len since commit 029f5fc31cdb
("8021q: set hard_header_len when VLAN offload features are toggled"),
but the header_ops remains unchanged, ndisc skb will be allocated
with this len and filled in vlan hdr in vlan_dev_hard_header(), but
with reorder_hdr off, the skb room is not enough so it triggers
skb_panic() as below:

skbuff: skb_under_panic: text:ffffffffa0535126 len:90 put:14
 head:ffff916c04232ec0 data:ffff916c04232ebe tail:0x58 end:0x180 dev:veth0.10
------------[ cut here ]------------
 kernel BUG at net/core/skbuff.c:197!
 <TASK>
  skb_push+0x39/0x40 net/core/skbuff.c:207
  eth_header+0x26/0xb0 net/ethernet/eth.c:90
  vlan_dev_hard_header+0x58/0x130 net/8021q/vlan_dev.c:85 [8021q]
  neigh_connected_output+0xae/0x100 net/core/neighbour.c:1589
  ip6_finish_output2+0x2cc/0x650 net/ipv6/ip6_output.c:213
  ip6_finish_output+0x27/0xd0 net/ipv6/ip6_output.c:246
  ndisc_send_skb+0x1d0/0x370 net/ipv6/ndisc.c:516
  ndisc_send_ns+0x5a/0xb0 net/ipv6/ndisc.c:672
  addrconf_dad_work+0x2b5/0x380 net/ipv6/addrconf.c:4258
  process_one_work+0x17f/0x320 kernel/workqueue.c:2743

In case of possible crash from other callers, fix this by always
reserving VLAN_HLEN in hard_header_len even if the header_ops would
not request it.

Fixes: 029f5fc31cdb ("8021q: set hard_header_len when VLAN offload features are toggled")
Signed-off-by: Chen Zhen <chenzhen126@huawei.com>
---
 net/8021q/vlan.c     | 5 -----
 net/8021q/vlan_dev.c | 8 +++-----
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
index 2b74ed56eb16..a7b5da7f9999 100644
--- a/net/8021q/vlan.c
+++ b/net/8021q/vlan.c
@@ -323,11 +323,6 @@ static void vlan_transfer_features(struct net_device *dev,
 
 	netif_inherit_tso_max(vlandev, dev);
 
-	if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
-		vlandev->hard_header_len = dev->hard_header_len;
-	else
-		vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
-
 #if IS_ENABLED(CONFIG_FCOE)
 	vlandev->fcoe_ddp_xid = dev->fcoe_ddp_xid;
 #endif
diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
index fbf296137b09..9e81669bffd6 100644
--- a/net/8021q/vlan_dev.c
+++ b/net/8021q/vlan_dev.c
@@ -572,13 +572,11 @@ static int vlan_dev_init(struct net_device *dev)
 #endif
 
 	dev->needed_headroom = real_dev->needed_headroom;
-	if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)) {
+	dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
+	if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto))
 		dev->header_ops      = &vlan_passthru_header_ops;
-		dev->hard_header_len = real_dev->hard_header_len;
-	} else {
+	else
 		dev->header_ops      = &vlan_header_ops;
-		dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
-	}
 
 	dev->netdev_ops = &vlan_netdev_ops;
 
-- 
2.33.0


