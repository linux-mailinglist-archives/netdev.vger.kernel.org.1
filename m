Return-Path: <netdev+bounces-266012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJyiAaP5r2mmdwIAu9opvQ
	(envelope-from <netdev+bounces-266012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:59:47 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 53989249DB8
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 11:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E33D30EF1CE
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 10:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D2637D139;
	Tue, 10 Mar 2026 10:54:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.baidu.com (mx22.baidu.com [220.181.50.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC8A379997
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 10:54:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.181.50.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773140070; cv=none; b=Ga3myPj6nTlF0+gQlUfZljFuFnIizgmjvJuMuGFI5dHs+XsE2nzJmTBQoPth+WkQ/O06Q65EvRK81vRg7mlvGOBOl+zoqc4v4L6SyNfuue4uGcWa+qfxLhYrz4FttJ4BUXqEBi0J7N9CfHFwjSEKMPqzCMdt0ub4Hgnv5UXPWdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773140070; c=relaxed/simple;
	bh=L3OldUJh3BnS9U3kvXaxxc9dfz8BC6CD0xrNFBhboQA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Od+RFDRqoN3aEQsY/NJGiQA+uT/QHGafL3qNziFIC+LgO9vOXIkA2e0EKiAae+65L8XKeQ8OLmX8gJNuZhqCG0sTJhOrpMU3XlrhpnIh8hZGc0Ces3V5wqCkW1mdzZgUuC0Nl0RNtoJOsH4ScnDi+SS4Ma2vGDAYmBbQ0TpQkX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=220.181.50.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: David Ahern <dsahern@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	<netdev@vger.kernel.org>
CC: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH][net-next] net: vrf: switch to synchronize_net() when releasing routes
Date: Tue, 10 Mar 2026 06:53:31 -0400
Message-ID: <20260310105331.2371-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjkjy-exc8.internal.baidu.com (172.31.50.52) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM
X-Rspamd-Queue-Id: 53989249DB8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[baidu.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266012-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.990];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

From: Li RongQing <lirongqing@baidu.com>

Replace synchronize_rcu() with synchronize_net() in vrf_rtable_release()
and vrf_rt6_release().

synchronize_net() is RTNL-aware and can use the more efficient
synchronize_rcu_expedited() when the RTNL lock is held, avoiding
potentially long wait times for a standard RCU grace period.

Since these release functions are called during device teardown where
the RTNL lock is typically held, this change reduces the time spent
in RTNL critical sections and speeds up VRF device deletion.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/vrf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 8c009bc..92a0f4b 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -755,7 +755,7 @@ static void vrf_rt6_release(struct net_device *dev, struct net_vrf *vrf)
 	struct dst_entry *dst;
 
 	RCU_INIT_POINTER(vrf->rt6, NULL);
-	synchronize_rcu();
+	synchronize_net();
 
 	/* move dev in dst's to loopback so this VRF device can be deleted
 	 * - based on dst_ifdown
@@ -1002,7 +1002,7 @@ static void vrf_rtable_release(struct net_device *dev, struct net_vrf *vrf)
 	struct dst_entry *dst;
 
 	RCU_INIT_POINTER(vrf->rth, NULL);
-	synchronize_rcu();
+	synchronize_net();
 
 	/* move dev in dst's to loopback so this VRF device can be deleted
 	 * - based on dst_ifdown
-- 
2.9.4


