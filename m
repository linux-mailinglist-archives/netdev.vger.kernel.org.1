Return-Path: <netdev+bounces-285804-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sGDzAGzd/Wn0jwAAu9opvQ
	(envelope-from <netdev+bounces-285804-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:56:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E454F69CF
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 14:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3E91630090A6
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 12:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B40034F25C;
	Fri,  8 May 2026 12:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b="lFxLRpi4"
X-Original-To: netdev@vger.kernel.org
Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AB482F8E99
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778244447; cv=none; b=IhpHMSekA8I2iL4NQqXRocNFtk1DX4SC5yrAWqo9k55kI1/cyHMEDVQ5GU34Ray0iyAK0MXvQH//GBfOKr4dVn++uQ14T0r3f3N6yM3XRCJBFMEQqgPJMsT1THBC8Etwz/sXRHiwk2T4Yh8wETNmNcjFDbvwzAO6YWmqzHyZ7t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778244447; c=relaxed/simple;
	bh=ba8BPuTfBT4f9te4kTGFlXW61iUff4/9nWSY4X8BriU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jQDQjufeCKSaAKutQB7wSx9/FpJQHW/QSFCbjSU+tHuIphQ52V5JP8OMHEqSh+xkEXKlHrunli7P+qYeUqxbFrJWPt/sJCMVc8w1c6vHDNNCNsVAub1EGoXtnkQt9MPs1SMQ5BRRmX8RN+U5llgQitnpMHE197EywJUCG7P5ZpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn; spf=pass smtp.mailfrom=std.uestc.edu.cn; dkim=fail (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b=lFxLRpi4 reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=std.uestc.edu.cn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=std.uestc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=88WdoF80lb
	o09x2a1VAPn6ZTFsDinSL52JzrGjI4sh4=; b=lFxLRpi4/R0NknP5g7PlgTM9W+
	0xZwO8MCAmShoUXwtlGx66e7mPCrmh1XbP/Yr4YW2CJiQrFxk8v+m9ydtegA2m4n
	4Q2yo6LceJxSI/p3C84UkBjIV1KPH+jc9G35nc4m6FnUKHKKBpWM6FJaon2nnR+7
	08TQ9VE1U7dQB5iPQ=
Received: from hotaru.tailb307d0.ts.net (unknown [218.106.117.239])
	by hzbj-edu-front-2.icoremail.net (Coremail) with SMTP id BLQMCkDGq7s02_1pGEz4AQ--.39793S2;
	Fri, 08 May 2026 20:46:45 +0800 (CST)
From: Quan Sun <2022090917019@std.uestc.edu.cn>
To: netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org
Cc: pabeni@redhat.com,
	horms@kernel.org,
	fmaurer@redhat.com,
	bigeasy@linutronix.de,
	luka.gejak@linux.dev,
	mingo@kernel.org,
	arvid.brodin@alten.se,
	Quan Sun <2022090917019@std.uestc.edu.cn>
Subject: [PATCH net] net: hsr: fix NULL pointer dereference in hsr_get_node_data()
Date: Fri,  8 May 2026 20:46:36 +0800
Message-ID: <20260508124636.1462346-1-2022090917019@std.uestc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BLQMCkDGq7s02_1pGEz4AQ--.39793S2
X-Coremail-Antispam: 1UD129KBjvJXoW7KF15GF45Ar4xZrWrCw47twb_yoW5Jry5pF
	yrGryqkrWkJry5Ar40qF48Wr4F9r1qkayvv3yUC340kFnYvF1FqF1j9r1vvrWDurWxArWY
	vF18Xw1vqw1qvaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUP014x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AFwI0_Jw0_GFylc2xSY4AK67
	AK6ryUMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAF
	wI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc4
	0Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AK
	xVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr
	1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUjNtx3UU
	UUU==
X-CM-SenderInfo: asqsjiyzqzilqqrzq21wgo3vxvwfhvlgxou0/
X-Rspamd-Queue-Id: 95E454F69CF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [6.34 / 15.00];
	SEM_URIBL(3.50)[uestc.edu.cn:email];
	DMARC_POLICY_QUARANTINE(1.50)[uestc.edu.cn : SPF not aligned (relaxed),quarantine];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285804-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	R_DKIM_PERMFAIL(0.00)[std.uestc.edu.cn:s=dkim];
	MIME_TRACE(0.00)[0:+];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(0.00)[+ip4:172.232.135.74:c];
	TAGGED_RCPT(0.00)[netdev];
	DKIM_TRACE(0.00)[std.uestc.edu.cn:~];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[2022090917019@std.uestc.edu.cn,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.993];
	DBL_BLOCKED_OPENRESOLVER(0.00)[uestc.edu.cn:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,std.uestc.edu.cn:mid]
X-Rspamd-Action: add header
X-Spam: Yes

In the HSR (High-availability Seamless Redundancy) protocol, node
information is maintained in the node_db. When a supervision frame is
received, node->addr_B_port is updated to track the receiving port type
(e.g., HSR_PT_SLAVE_B).

If the underlying physical interface associated with this slave port is
removed (e.g., via `ip link del`), hsr_del_port() frees the hsr_port
object. However, the stale node->addr_B_port reference is kept in the
node_db until the node ages out.

Subsequently, if userspace queries the node status via the Netlink
command HSR_C_GET_NODE_STATUS, the kernel calls hsr_get_node_data().
This function unconditionally dereferences the pointer returned by
hsr_port_get_hsr():

    if (node->addr_B_port != HSR_PT_NONE) {
            port = hsr_port_get_hsr(hsr, node->addr_B_port);
            *addr_b_ifindex = port->dev->ifindex; // <-- NULL deref
    }

If the slave port has been deleted, hsr_port_get_hsr() returns NULL,
resulting in a kernel panic.

Oops: general protection fault, probably for non-canonical address
KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
RIP: 0010:hsr_get_node_data+0x7b6/0x9e0
Call Trace:
 <TASK>
 hsr_get_node_status+0x445/0xa40

Fix this by adding a proper NULL pointer check. If the port lookup fails
due to a stale port type, gracefully treat it as if no valid port exists
and assign -1 to the interface index.

Steps to reproduce:
1. Create an HSR interface with two slave devices.
2. Receive a supervision frame to populate node_db with
   addr_B_port assigned to SLAVE_B.
3. Delete the underlying slave device B.
4. Send an HSR_C_GET_NODE_STATUS Netlink message.

Fixes: c5a759117210 ("net/hsr: Use list_head (and rcu) instead of array for slave devices.")
Signed-off-by: Quan Sun <2022090917019@std.uestc.edu.cn>
---
 net/hsr/hsr_framereg.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index d09875b335885..124619920d386 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -889,7 +889,10 @@ int hsr_get_node_data(struct hsr_priv *hsr,
 
 	if (node->addr_B_port != HSR_PT_NONE) {
 		port = hsr_port_get_hsr(hsr, node->addr_B_port);
-		*addr_b_ifindex = port->dev->ifindex;
+		if (port)
+			*addr_b_ifindex = port->dev->ifindex;
+		else
+			*addr_b_ifindex = -1;
 	} else {
 		*addr_b_ifindex = -1;
 	}
-- 
2.43.0


