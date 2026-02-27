Return-Path: <netdev+bounces-261643-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOzGKzTqoGnynwQAu9opvQ
	(envelope-from <netdev+bounces-261643-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:49:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE4B1B14E1
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1D4F303CE37
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 00:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5D327B32C;
	Fri, 27 Feb 2026 00:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kDwQeI87"
X-Original-To: netdev@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B8D42049
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 00:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772153376; cv=none; b=ZErvMqbkQLIJZ4evSy+eT3gC6zR6m6AGljK519G8fhPPjlrATxZhzv05op5ncK1cSza8wpkH71ohtmgCCSRFJAppLh1gYLkvOGRZtmtMew+SNCtC8cSqafg/reSCgMEFL5VScB/T2Asqm180ZpqGOtWQKa/HujXre5MPXROTCKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772153376; c=relaxed/simple;
	bh=kxJVxLCX5045kFo1+0Jf+w+pRVLSmR6CixwiNorUPsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KaVthx5OJNAiGRjHJc505bpbA9Kg3k+nFh65HV3VfBBw4drf1q+4ShtJvnSZLCEt448WU32s/4BU/zhnyG65LkFgRWUl0kSVJz8nfYeDYSqs6ZvXabLwro5KGW0hYxp5CSBrmFCEs9vx8wjF2a9Pt6sIt8FXtXCH2zdnBbX8cJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kDwQeI87; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772153373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=nLHgLpQjDCa3lA8XrBt/6vgxD7NRkmc2emKglDrIsHE=;
	b=kDwQeI87Ykhgi3HNg0qgSymihkObjAwonqSWlOHKJu3nRvlCWWNEm5AqhZz1BszeeRAEkS
	PDC1Gh0g5UcbaXs5/ERkjJ83YQsv8nxrxR+XJ41Rawf9z7cUTCQqkTWiwjplvB/tWoQOW2
	yYanmcwSzef7W5KF3AxphFezrM2ftWA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] ipv6: sit: Replace deprecated strcpy with strscpy
Date: Fri, 27 Feb 2026 01:45:42 +0100
Message-ID: <20260227004541.798966-3-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261643-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,linux.dev:email]
X-Rspamd-Queue-Id: 1AE4B1B14E1
X-Rspamd-Action: no action

strcpy() has been deprecated [1] because it performs no bounds checking
on the destination buffer, which can lead to buffer overflows. Replace
it with the safer strscpy().  Use the two-argument version of strscpy()
to copy 'parms->name' in ipip6_tunnel_locate().

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy [1]
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 net/ipv6/sit.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/ipv6/sit.c b/net/ipv6/sit.c
index 439c8a1c6625..52f105315e1e 100644
--- a/net/ipv6/sit.c
+++ b/net/ipv6/sit.c
@@ -21,6 +21,7 @@
 #include <linux/types.h>
 #include <linux/socket.h>
 #include <linux/sockios.h>
+#include <linux/string.h>
 #include <linux/net.h>
 #include <linux/in6.h>
 #include <linux/netdevice.h>
@@ -256,9 +257,9 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 	if (parms->name[0]) {
 		if (!dev_valid_name(parms->name))
 			goto failed;
-		strscpy(name, parms->name, IFNAMSIZ);
+		strscpy(name, parms->name);
 	} else {
-		strcpy(name, "sit%d");
+		strscpy(name, "sit%d");
 	}
 	dev = alloc_netdev(sizeof(*t), name, NET_NAME_UNKNOWN,
 			   ipip6_tunnel_setup);
@@ -275,7 +276,7 @@ static struct ip_tunnel *ipip6_tunnel_locate(struct net *net,
 		goto failed_free;
 
 	if (!parms->name[0])
-		strcpy(parms->name, dev->name);
+		strscpy(parms->name, dev->name);
 
 	return nt;
 
@@ -1442,7 +1443,7 @@ static int ipip6_tunnel_init(struct net_device *dev)
 	int err;
 
 	tunnel->dev = dev;
-	strcpy(tunnel->parms.name, dev->name);
+	strscpy(tunnel->parms.name, dev->name);
 
 	ipip6_tunnel_bind_dev(dev);
 
@@ -1863,7 +1864,7 @@ static int __net_init sit_init_net(struct net *net)
 	ipip6_tunnel_clone_6rd(sitn->fb_tunnel_dev, sitn);
 	ipip6_fb_tunnel_init(sitn->fb_tunnel_dev);
 
-	strcpy(t->parms.name, sitn->fb_tunnel_dev->name);
+	strscpy(t->parms.name, sitn->fb_tunnel_dev->name);
 	return 0;
 
 err_reg_dev:
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


