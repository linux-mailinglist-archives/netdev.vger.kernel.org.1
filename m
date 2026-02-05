Return-Path: <netdev+bounces-256978-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EE6QG/kxhGnk0gMAu9opvQ
	(envelope-from <netdev+bounces-256978-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 07:00:25 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0EAEED6D
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 07:00:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFC063013A6D
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 06:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511D33314B9;
	Thu,  5 Feb 2026 06:00:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from outbound.baidu.com (mx24.baidu.com [111.206.215.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA88B31B124;
	Thu,  5 Feb 2026 06:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.206.215.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770271222; cv=none; b=DTToJJ3Hkx+AjeNWNRExGkI39Ug9qoFBclnzKwDGy2jzaqP9VZrlHQ5mkRge5QXE4PRSwgKuRzCAwa1DlwLt6wZ1l9EBiX66OLrFF73O2ayNea/d3Uo531vkzdEt7lZrzUtiUpAIyKMtqzdLPmCYDSdygAFML+1uezC7Qw3OJnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770271222; c=relaxed/simple;
	bh=Bw9eIbyon0C0UsRm+N00FGah8CbfZsuR6jLXJsYCFS4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rmf2wvzDHJ4YyOEs425iaHK0uGERtN+bdjLo4asrria3ECBVeXlqChnoBZYTlzwbnzreVZzdZ0C/SalVMqgiyo0pRl31/RPHeJ7xNAoAoQAWxqOh3dz9BDKm1mazJ/yqQR4sDtP9mFXVJsQsvEaQfjAZ5fkBhf7aPjhU+DWqv4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=111.206.215.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
From: lirongqing <lirongqing@baidu.com>
To: Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Li RongQing
	<lirongqing@baidu.com>, <oss-drivers@corigine.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH][net-next] nfp: flower: use GFP_KERNEL in idr_preload
Date: Thu, 5 Feb 2026 00:59:33 -0500
Message-ID: <20260205055933.3939-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: bjhj-exc11.internal.baidu.com (172.31.3.21) To
 bjkjy-exc3.internal.baidu.com (172.31.50.47)
X-FEAS-Client-IP: 172.31.50.47
X-FE-Policy-ID: 52:10:53:SYSTEM
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[baidu.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256978-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[lirongqing@baidu.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EE0EAEED6D
X-Rspamd-Action: no action

From: Li RongQing <lirongqing@baidu.com>

idr_preload() is called in a sleepable context before acquiring a
spinlock. Change the allocation flag from GFP_ATOMIC to GFP_KERNEL
to allow direct reclaim and improve allocation success rate under
memory pressure.

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 drivers/net/ethernet/netronome/nfp/flower/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/netronome/nfp/flower/main.c b/drivers/net/ethernet/netronome/nfp/flower/main.c
index 83eaa5a..8f232c6 100644
--- a/drivers/net/ethernet/netronome/nfp/flower/main.c
+++ b/drivers/net/ethernet/netronome/nfp/flower/main.c
@@ -63,7 +63,7 @@ nfp_flower_get_internal_port_id(struct nfp_app *app, struct net_device *netdev)
 	if (id > 0)
 		return id;
 
-	idr_preload(GFP_ATOMIC);
+	idr_preload(GFP_KERNEL);
 	spin_lock_bh(&priv->internal_ports.lock);
 	id = idr_alloc(&priv->internal_ports.port_ids, netdev,
 		       NFP_MIN_INT_PORT_ID, NFP_MAX_INT_PORT_ID, GFP_ATOMIC);
-- 
2.9.4


