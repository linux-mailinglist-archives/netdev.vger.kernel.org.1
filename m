Return-Path: <netdev+bounces-197389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B801AAD87B6
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 11:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 107463B6EF3
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 09:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2C8291C31;
	Fri, 13 Jun 2025 09:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hillstonenet.com header.i=@hillstonenet.com header.b="wwSatz74"
X-Original-To: netdev@vger.kernel.org
Received: from mail-m1973182.qiye.163.com (mail-m1973182.qiye.163.com [220.197.31.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2850424DD1A;
	Fri, 13 Jun 2025 09:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749806704; cv=none; b=FWF9Rh1gez4KFsGkLjrAPo2kVXLbG7xbEtwEqj0CXc92QbfOLCAB2micIRStqctZsxRoww2lfKdckKp2DCoO3Ou9GHV9lDM5jq288yIc3ZQZtT2bgDpzHDzOOExBwZHRVsnpzVdaS3LWeYkcfif2ByM0QX+sG1htklO/PMte4v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749806704; c=relaxed/simple;
	bh=zfk3I70U/S1a7wWOZU0zLfDlYSHLaTIkBupmVtsOcQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hxPMot9Z1SEYaOnD791mfmho6bdHl10H0HzTpf1p+gdeUeoJzHvk4gDvRIjibPqySKIW6ar6IpxoWXq3w4zkly4Q+fp1AehVndwt0KihQ14N/PrCDQncJ+Yy2oE3re31HmkLJkdpMdu75c4HvUj2eIxFmEDqcMRD5N/duuiN9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillstonenet.com; spf=pass smtp.mailfrom=hillstonenet.com; dkim=pass (1024-bit key) header.d=hillstonenet.com header.i=@hillstonenet.com header.b=wwSatz74; arc=none smtp.client-ip=220.197.31.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=hillstonenet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hillstonenet.com
Received: from localhost.localdomain (unknown [111.199.5.197])
	by smtp.qiye.163.com (Hmail) with ESMTP id 188a5f404;
	Fri, 13 Jun 2025 13:55:48 +0800 (GMT+08:00)
From: Haixia Qu <hxqu@hillstonenet.com>
To: Jon Maloy <jmaloy@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Haixia Qu <hxqu@hillstonenet.com>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tipc: fix panic in tipc_udp_nl_dump_remoteip() using bearer as udp without check
Date: Fri, 13 Jun 2025 05:55:06 +0000
Message-ID: <20250613055506.95836-1-hxqu@hillstonenet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSE8eVhgeGEwaQhoYGEtOGFYVFAkWGhdVEwETFh
	oSFyQUDg9ZV1kYEgtZQVlKSkpVSkJCVU5VSkJMWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09IVUpLS1
	VKQktLWQY+
X-HM-Tid: 0a9767dbcff609dakunm0183899d96fc76
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6KzI6PSo6DDE4VlFLHQ4sEDQf
	PEgaFE5VSlVKTE9CTEJPSk9CT0JCVTMWGhIXVRMDCg47ExIXFwgPFBUeFR4PVRgUFkVZV1kSC1lB
	WUpKSlVKQkJVTlVKQkxZV1kIAVlBSU9JQjcG
DKIM-Signature:a=rsa-sha256;
	b=wwSatz74OxiXnkMspGWlFdozbCPhPwIR2B1y8y9C8KbtZJTfLAdpjjNmzN8lI2IPy05DRiLM43KCzBTM40GsLBQuVDjkPhUh+QqW23Te/RmbyzyiHFbV6nbcS4E7zqNbag5AUWLEIfks7KZC4W+SySEgVcw4O9thyx7guHnjJzI=; s=default; c=relaxed/relaxed; d=hillstonenet.com; v=1;
	bh=CZ6k5m8GOuN3if7SPQ1hTZoDDUTFYnMwwwYr/8JUHSA=;
	h=date:mime-version:subject:message-id:from;

When TIPC_NL_UDP_GET_REMOTEIP cmd calls tipc_udp_nl_dump_remoteip() 
with media name set to a l2 name, kernel panics [1].

The reproduction steps:
1. create a tun interface
2. enable l2 bearer
3. TIPC_NL_UDP_GET_REMOTEIP with media name set to tun

the ub was in fact a struct dev.

when bid != 0 && skip_cnt != 0, bearer_list[bid] may be NULL or 
other media when other thread changes it.

fix this by checking media_id.

[1]
tipc: Started in network mode
tipc: Node identity 8af312d38a21, cluster identity 4711
tipc: Enabled bearer <eth:syz_tun>, priority 1
Oops: general protection fault
KASAN: null-ptr-deref in range 
CPU: 1 UID: 1000 PID: 559 Comm: poc Not tainted 6.16.0-rc1+ #117 PREEMPT
Hardware name: QEMU Ubuntu 24.04 PC
RIP: 0010:tipc_udp_nl_dump_remoteip+0x4a4/0x8f0

Signed-off-by: Haixia Qu <hxqu@hillstonenet.com>
---
 net/tipc/udp_media.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index 108a4cc2e001..258d6aa4f21a 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -489,7 +489,7 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struct netlink_callback *cb)
 
 		rtnl_lock();
 		b = tipc_bearer_find(net, bname);
-		if (!b) {
+		if (!b || b->bcast_addr.media_id != TIPC_MEDIA_TYPE_UDP) {
 			rtnl_unlock();
 			return -EINVAL;
 		}
@@ -500,7 +500,7 @@ int tipc_udp_nl_dump_remoteip(struct sk_buff *skb, struct netlink_callback *cb)
 
 		rtnl_lock();
 		b = rtnl_dereference(tn->bearer_list[bid]);
-		if (!b) {
+		if (!b || b->bcast_addr.media_id != TIPC_MEDIA_TYPE_UDP) {
 			rtnl_unlock();
 			return -EINVAL;
 		}
-- 
2.43.0


